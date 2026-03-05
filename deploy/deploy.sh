#!/bin/bash
# ============================================================
# 东陆高中选课系统 - 一键部署脚本
# 适用: CentOS 7 + 宝塔 + Docker + Redis + PostgreSQL
# 域名: xk.xmls.vip
# ============================================================
# 使用前请确保:
# 1. 已将 deploy 目录上传到服务器
# 2. 宝塔已安装 Nginx、Redis、PostgreSQL
# 3. PostgreSQL 密码: mm5621528, Redis 无密码
# 4. 已创建数据库 ry_vue (或由 init-db.sh 创建)
# ============================================================

set -e
DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"
DOMAIN="xk.xmls.vip"
APP_USER="ruoyi"
APP_HOME="/home/$APP_USER"
UPLOAD_PATH="$APP_HOME/uploadPath"
NGINX_CONF_DIR="/www/server/panel/vhost/nginx"  # 宝塔 Nginx 配置目录

echo "=========================================="
echo "  东陆高中选课系统 - 一键部署"
echo "  域名: $DOMAIN"
echo "  部署目录: $DEPLOY_DIR"
echo "=========================================="

# 1. 检查/创建应用用户
if ! id "$APP_USER" &>/dev/null; then
    echo "[1] 创建用户 $APP_USER"
    useradd -m -s /bin/bash "$APP_USER"
else
    echo "[1] 用户 $APP_USER 已存在"
fi

# 2. 创建目录结构
echo "[2] 创建目录结构"
mkdir -p "$APP_HOME/backend"
mkdir -p "$APP_HOME/frontend-admin"
mkdir -p "$APP_HOME/frontend-student"
mkdir -p "$UPLOAD_PATH"
chown -R "$APP_USER:$APP_USER" "$APP_HOME"

# 3. 复制后端 JAR 和配置
echo "[3] 部署后端"
if [ -f "$DEPLOY_DIR/backend/ruoyi-admin.jar" ]; then
    cp "$DEPLOY_DIR/backend/ruoyi-admin.jar" "$APP_HOME/backend/"
    if [ -f "$DEPLOY_DIR/config/application-prod.yml" ]; then
        cp "$DEPLOY_DIR/config/application-prod.yml" "$APP_HOME/backend/"
    fi
    chown "$APP_USER:$APP_USER" "$APP_HOME/backend"/*
else
    echo "错误: 未找到 ruoyi-admin.jar"
    exit 1
fi

# 4. 复制前端静态文件
echo "[4] 部署前端"
if [ -d "$DEPLOY_DIR/frontend-admin/dist" ]; then
    cp -r "$DEPLOY_DIR/frontend-admin/dist"/* "$APP_HOME/frontend-admin/"
fi
if [ -d "$DEPLOY_DIR/frontend-student/h5" ]; then
    cp -r "$DEPLOY_DIR/frontend-student/h5"/* "$APP_HOME/frontend-student/"
fi
chown -R "$APP_USER:$APP_USER" "$APP_HOME/frontend-admin" "$APP_HOME/frontend-student"

# 5. 初始化数据库（可选，首次部署执行）
echo "[5] 数据库初始化"
if [ -f "$DEPLOY_DIR/init-db.sh" ]; then
    read -p "是否执行数据库初始化? (y/n，首次部署选 y): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        chmod +x "$DEPLOY_DIR/init-db.sh"
        export PGPASSWORD=mm5621528
        "$DEPLOY_DIR/init-db.sh" ry_vue postgres
    fi
else
    echo "未找到 init-db.sh，请手动执行 SQL 脚本初始化数据库"
fi

# 6. 创建 systemd 服务
echo "[6] 配置后端服务"
cat > /etc/systemd/system/ruoyi-xk.service << EOF
[Unit]
Description=东陆高中选课系统后端
After=network.target postgresql.service redis.service

[Service]
Type=simple
User=$APP_USER
WorkingDirectory=$APP_HOME/backend
ExecStart=/usr/bin/java -Xms256m -Xmx512m -jar $APP_HOME/backend/ruoyi-admin.jar --spring.profiles.active=druid,prod --spring.config.additional-location=file:$APP_HOME/backend/application-prod.yml
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# 检查 Java
if ! command -v java &>/dev/null; then
    echo "警告: 未检测到 Java，请先安装 JDK 8+ (yum install java-1.8.0-openjdk)"
fi

systemctl daemon-reload
systemctl enable ruoyi-xk
systemctl restart ruoyi-xk
echo "后端服务已启动，可用 systemctl status ruoyi-xk 查看状态"

# 7. 配置 Nginx（宝塔）
echo "[7] 配置 Nginx"
NGINX_CONF="$NGINX_CONF_DIR/${DOMAIN}.conf"
if [ -d "/www/server/panel/vhost/nginx" ]; then
    cat > "$NGINX_CONF" << 'NGINX_EOF'
server {
    listen 80;
    server_name xk.xmls.vip www.xk.xmls.vip;
    
    # 学生端 H5（需在 / 之前，优先匹配）
    location /h5/ {
        alias /home/ruoyi/frontend-student/;
        index index.html;
        try_files $uri $uri/ /h5/index.html;
    }
    location = /h5 {
        return 301 /h5/;
    }
    
    # 后端 API（管理端）
    location /prod-api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    
    # 后端 API（学生端）
    location /api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    
    # 管理端（根路径）
    location / {
        root /home/ruoyi/frontend-admin;
        index index.html;
        try_files $uri $uri/ /index.html;
    }
}
NGINX_EOF
    echo "Nginx 配置已写入 $NGINX_CONF"
    echo "请在宝塔面板中重载 Nginx，或执行: nginx -t && nginx -s reload"
else
    echo "未检测到宝塔 Nginx 配置目录，请手动配置 Nginx:"
    echo "  - 根路径 / -> /home/ruoyi/frontend-admin"
    echo "  - /h5 -> /home/ruoyi/frontend-student"
    echo "  - /prod-api/ 和 /api/ -> http://127.0.0.1:8080/"
fi

echo ""
echo "=========================================="
echo "  部署完成！"
echo "  管理端: http://$DOMAIN"
echo "  学生端: http://$DOMAIN/h5"
echo "  默认管理员: admin / admin123"
echo "=========================================="
