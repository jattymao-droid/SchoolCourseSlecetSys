#!/bin/bash
# ============================================================
# 东陆高中选课系统 - 云服务器一键部署脚本 (Docker 适配版)
# 适用: CentOS 7 + 宝塔面板 + Docker (PostgreSQL & Redis)
# ============================================================

set -e

# 配置变量
APP_NAME="course-selection"
APP_USER="ruoyi"
APP_HOME="/www/wwwroot/$APP_NAME"
BACKEND_DIR="$APP_HOME/backend"
FRONTEND_DIR="$APP_HOME/frontend"
LOG_DIR="$APP_HOME/logs"
UPLOAD_DIR="$APP_HOME/uploadPath"
NGINX_CONF_DIR="/www/server/panel/vhost/nginx"
DOMAIN="xk.xmls.vip" # 请根据实际情况修改

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}  东陆高中选课系统 - 一键部署 (Docker版)  ${NC}"
echo -e "${GREEN}==========================================${NC}"

# 1. 检查权限
if [ "$EUID" -ne 0 ]; then 
  echo -e "${RED}错误: 请以 root 权限运行此脚本${NC}"
  exit 1
fi

# 2. 创建用户和目录
echo -e "${YELLOW}[1/6] 准备环境...${NC}"
if ! id "$APP_USER" &>/dev/null; then
    useradd -m -s /bin/bash "$APP_USER"
    echo "创建用户 $APP_USER 成功"
fi

mkdir -p "$BACKEND_DIR" "$FRONTEND_DIR" "$LOG_DIR" "$UPLOAD_DIR"
chown -R "$APP_USER:$APP_USER" "$APP_HOME"

# 3. 部署文件
echo -e "${YELLOW}[2/6] 部署文件...${NC}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/backend/ruoyi-admin.jar" ]; then
    cp "$SCRIPT_DIR/backend/ruoyi-admin.jar" "$BACKEND_DIR/"
    echo "后端文件部署完成"
else
    echo -e "${RED}错误: 未找到 ruoyi-admin.jar${NC}"
    exit 1
fi

if [ -d "$SCRIPT_DIR/frontend" ]; then
    cp -r "$SCRIPT_DIR/frontend"/* "$FRONTEND_DIR/"
    echo "前端文件部署完成"
fi

# 4. 数据库初始化 (可选)
echo -e "${YELLOW}[3/6] 数据库初始化...${NC}"
# 优先寻找打包过来的全量备份
BACKUP_SQL="$SCRIPT_DIR/sql/database_backup.sql"
if [ -f "$BACKUP_SQL" ]; then
    read -p "检测到数据库备份文件 (database_backup.sql)，是否导入? (y/n): " init_db
    if [[ "$init_db" =~ ^[Yy]$ ]]; then
        echo "正在导入数据库，请确保 postgres 容器正在运行..."
        # 使用 docker 临时容器运行 psql 进行导入
        export DB_PASS="mm5621528"
        docker run --rm -i \
            --add-host host.docker.internal:host-gateway \
            -e PGPASSWORD="$DB_PASS" \
            postgres:15-alpine \
            psql -h host.docker.internal -p 5432 -U postgres -d ry_vue < "$BACKUP_SQL"
        echo "数据库导入完成"
    fi
elif [ -f "$SCRIPT_DIR/scripts/init-db.sh" ]; then
    read -p "未找到备份文件，是否执行结构初始化脚本? (y/n): " init_db
    if [[ "$init_db" =~ ^[Yy]$ ]]; then
        chmod +x "$SCRIPT_DIR/scripts/init-db.sh"
        export DB_PASS="mm5621528"
        bash "$SCRIPT_DIR/scripts/init-db.sh"
    fi
else
    echo "未找到数据库初始化脚本或备份文件，请手动导入数据库"
fi

# 5. 配置 Systemd 服务
echo -e "${YELLOW}[4/6] 配置后端服务...${NC}"
cat > /etc/systemd/system/ruoyi-admin.service << EOF
[Unit]
Description=RuoYi Admin Service
After=network.target

[Service]
Type=simple
User=$APP_USER
WorkingDirectory=$BACKEND_DIR
ExecStart=/usr/bin/java -Xms512m -Xmx1024m -jar $BACKEND_DIR/ruoyi-admin.jar --spring.profiles.active=druid,prod
Restart=always
StandardOutput=append:$LOG_DIR/backend.log
StandardError=append:$LOG_DIR/backend.log

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable ruoyi-admin
systemctl restart ruoyi-admin
echo "后端服务已启动 (ruoyi-admin)"

# 6. 配置 Nginx (宝塔适配)
echo -e "${YELLOW}[5/6] 配置 Nginx...${NC}"
NGINX_CONF="$NGINX_CONF_DIR/$DOMAIN.conf"

if [ -d "$NGINX_CONF_DIR" ]; then
    cat > "$NGINX_CONF" << EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        root $FRONTEND_DIR;
        try_files \$uri \$uri/ /index.html;
        index index.html;
    }

    location /prod-api/ {
        proxy_set_header Host \$http_host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header REMOTE-HOST \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_pass http://127.0.0.1:8080/;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   html;
    }
}
EOF
    echo "Nginx 配置文件已生成: $NGINX_CONF"
    nginx -t && nginx -s reload || echo -e "${RED}警告: Nginx 重载失败，请在宝塔面板手动重载${NC}"
else
    echo -e "${RED}警告: 未找到宝塔 Nginx 配置目录，请手动配置 Nginx${NC}"
fi

# 7. 完成
echo -e "${YELLOW}[6/6] 清理与收尾...${NC}"
echo -e "${GREEN}==========================================${NC}"
echo -e "${GREEN}  部署完成！${NC}"
echo -e "${GREEN}  前端访问地址: http://$DOMAIN${NC}"
echo -e "${GREEN}  后端管理端口: 8080${NC}"
echo -e "${GREEN}  日志文件: $LOG_DIR/backend.log${NC}"
echo -e "${GREEN}==========================================${NC}"
