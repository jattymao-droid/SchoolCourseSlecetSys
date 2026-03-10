#!/bin/bash
# 一键部署脚本 - CentOS 7 服务器
# 用途：自动部署学校选课系统到生产环境

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 配置变量
DB_NAME="school-course"
DB_USER="postgres"
DB_PASSWORD="mm5621528"
DB_HOST="localhost"
DB_PORT="5432"
REDIS_HOST="localhost"
REDIS_PORT="6379"
BACKEND_PORT="8080"
DEPLOY_DIR="/www/wwwroot/course-selection"
BACKEND_DIR="$DEPLOY_DIR/backend"
FRONTEND_DIR="$DEPLOY_DIR/frontend"
SQL_DIR="$DEPLOY_DIR/sql"
DOMAIN="xk.xmls.vip"

echo -e "${CYAN}========================================"
echo -e "学校选课系统 - 一键部署脚本"
echo -e "========================================${NC}"

# 检查是否为root用户
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}请使用root用户运行此脚本${NC}"
    exit 1
fi

# 1. 检查环境
echo -e "\n${CYAN}步骤 1/6: 检查服务器环境${NC}"

# 检查Java
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo -e "${GREEN}✓ Java已安装: $JAVA_VERSION${NC}"
else
    echo -e "${YELLOW}! Java未安装，正在安装OpenJDK 8...${NC}"
    yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
fi

# 检查Docker
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✓ Docker已安装${NC}"
else
    echo -e "${RED}✗ Docker未安装，请先安装Docker${NC}"
    exit 1
fi

# 检查PostgreSQL容器
if docker ps | grep -q postgres; then
    echo -e "${GREEN}✓ PostgreSQL容器运行中${NC}"
    POSTGRES_CONTAINER=$(docker ps --filter "ancestor=postgres" --format "{{.Names}}" | head -n 1)
    if [ -z "$POSTGRES_CONTAINER" ]; then
        POSTGRES_CONTAINER=$(docker ps | grep postgres | awk '{print $NF}' | head -n 1)
    fi
    echo -e "${YELLOW}  PostgreSQL容器名称: $POSTGRES_CONTAINER${NC}"
else
    echo -e "${RED}✗ PostgreSQL容器未运行${NC}"
    echo -e "${YELLOW}请确保PostgreSQL Docker容器正在运行${NC}"
    exit 1
fi

# 检查Redis容器
if docker ps | grep -q redis; then
    echo -e "${GREEN}✓ Redis容器运行中${NC}"
else
    echo -e "${YELLOW}! Redis容器未运行，但将继续部署${NC}"
fi

# 2. 创建部署目录
echo -e "\n${CYAN}步骤 2/6: 准备部署目录${NC}"

# 如果部署目录已存在，备份
if [ -d "$DEPLOY_DIR" ]; then
    BACKUP_DIR="${DEPLOY_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}备份现有部署到: $BACKUP_DIR${NC}"
    mv "$DEPLOY_DIR" "$BACKUP_DIR"
fi

mkdir -p "$BACKEND_DIR"
mkdir -p "$FRONTEND_DIR"
mkdir -p "$SQL_DIR"

echo -e "${GREEN}✓ 部署目录已创建: $DEPLOY_DIR${NC}"

# 3. 复制文件
echo -e "\n${CYAN}步骤 3/6: 复制部署文件${NC}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_DIR="$(dirname "$SCRIPT_DIR")"

# 复制后端
if [ -f "$PACKAGE_DIR/backend/ruoyi-admin.jar" ]; then
    cp "$PACKAGE_DIR/backend/ruoyi-admin.jar" "$BACKEND_DIR/"
    echo -e "${GREEN}✓ 后端JAR包已复制${NC}"
else
    echo -e "${RED}✗ 找不到后端JAR包${NC}"
    exit 1
fi

# 复制前端
if [ -d "$PACKAGE_DIR/frontend" ]; then
    cp -r "$PACKAGE_DIR/frontend/"* "$FRONTEND_DIR/"
    echo -e "${GREEN}✓ 前端文件已复制${NC}"
else
    echo -e "${RED}✗ 找不到前端文件${NC}"
    exit 1
fi

# 复制SQL文件
if [ -d "$PACKAGE_DIR/sql" ]; then
    cp -r "$PACKAGE_DIR/sql/"* "$SQL_DIR/"
    echo -e "${GREEN}✓ SQL文件已复制${NC}"
else
    echo -e "${YELLOW}! 未找到SQL文件，跳过${NC}"
fi

# 4. 初始化数据库
echo -e "\n${CYAN}步骤 4/6: 初始化数据库${NC}"

# 检查数据库是否存在
DB_EXISTS=$(docker exec -e PGPASSWORD=$DB_PASSWORD $POSTGRES_CONTAINER psql -U $DB_USER -lqt | cut -d \| -f 1 | grep -w $DB_NAME | wc -l)

if [ $DB_EXISTS -eq 0 ]; then
    echo -e "${YELLOW}创建数据库: $DB_NAME${NC}"
    docker exec -e PGPASSWORD=$DB_PASSWORD $POSTGRES_CONTAINER psql -U $DB_USER -c "CREATE DATABASE \"$DB_NAME\";"
    echo -e "${GREEN}✓ 数据库已创建${NC}"
else
    echo -e "${YELLOW}! 数据库已存在，是否覆盖？(y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo -e "${YELLOW}删除现有数据库...${NC}"
        docker exec -e PGPASSWORD=$DB_PASSWORD $POSTGRES_CONTAINER psql -U $DB_USER -c "DROP DATABASE IF EXISTS \"$DB_NAME\";"
        docker exec -e PGPASSWORD=$DB_PASSWORD $POSTGRES_CONTAINER psql -U $DB_USER -c "CREATE DATABASE \"$DB_NAME\";"
        echo -e "${GREEN}✓ 数据库已重新创建${NC}"
    else
        echo -e "${YELLOW}跳过数据库初始化${NC}"
    fi
fi

# 导入数据库
if [ -f "$SQL_DIR/full_backup.sql" ]; then
    echo -e "${YELLOW}导入数据库...${NC}"
    docker exec -i -e PGPASSWORD=$DB_PASSWORD $POSTGRES_CONTAINER psql -U $DB_USER -d $DB_NAME < "$SQL_DIR/full_backup.sql"
    echo -e "${GREEN}✓ 数据库导入完成${NC}"
elif [ -f "$SQL_DIR/schema.sql" ]; then
    echo -e "${YELLOW}导入数据库结构...${NC}"
    docker exec -i -e PGPASSWORD=$DB_PASSWORD $POSTGRES_CONTAINER psql -U $DB_USER -d $DB_NAME < "$SQL_DIR/schema.sql"
    if [ -f "$SQL_DIR/data.sql" ]; then
        echo -e "${YELLOW}导入数据库数据...${NC}"
        docker exec -i -e PGPASSWORD=$DB_PASSWORD $POSTGRES_CONTAINER psql -U $DB_USER -d $DB_NAME < "$SQL_DIR/data.sql"
    fi
    echo -e "${GREEN}✓ 数据库导入完成${NC}"
else
    echo -e "${YELLOW}! 未找到SQL文件，跳过数据库导入${NC}"
fi

# 5. 启动后端服务
echo -e "\n${CYAN}步骤 5/6: 启动后端服务${NC}"

# 停止现有的后端服务
if pgrep -f "ruoyi-admin.jar" > /dev/null; then
    echo -e "${YELLOW}停止现有后端服务...${NC}"
    pkill -f "ruoyi-admin.jar"
    sleep 3
fi

# 创建启动脚本
cat > "$BACKEND_DIR/start.sh" << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
nohup java -jar ruoyi-admin.jar --spring.profiles.active=prod > backend.log 2>&1 &
echo $! > backend.pid
echo "后端服务已启动，PID: $(cat backend.pid)"
EOF

chmod +x "$BACKEND_DIR/start.sh"

# 创建停止脚本
cat > "$BACKEND_DIR/stop.sh" << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"
if [ -f backend.pid ]; then
    PID=$(cat backend.pid)
    if ps -p $PID > /dev/null; then
        kill $PID
        echo "后端服务已停止 (PID: $PID)"
        rm backend.pid
    else
        echo "后端服务未运行"
        rm backend.pid
    fi
else
    pkill -f "ruoyi-admin.jar"
    echo "后端服务已停止"
fi
EOF

chmod +x "$BACKEND_DIR/stop.sh"

# 启动后端
cd "$BACKEND_DIR"
./start.sh

echo -e "${GREEN}✓ 后端服务启动中...${NC}"
echo -e "${YELLOW}等待后端服务启动 (30秒)...${NC}"
sleep 30

# 检查后端是否启动成功
if curl -s http://localhost:$BACKEND_PORT > /dev/null; then
    echo -e "${GREEN}✓ 后端服务启动成功！${NC}"
else
    echo -e "${YELLOW}! 后端服务可能未完全启动，请检查日志: $BACKEND_DIR/backend.log${NC}"
fi

# 6. 配置Nginx
echo -e "\n${CYAN}步骤 6/6: 配置前端服务${NC}"

# 生成Nginx配置文件
cat > "$DEPLOY_DIR/nginx.conf" << EOF
server {
    listen 80;
    listen 443 ssl;
    listen 443 quic;
    http2 on;
    server_name $DOMAIN;
    
    # 前端静态文件根目录
    root $FRONTEND_DIR;
    index index.html index.htm;
    
    # CERT-APPLY-CHECK--START
    include /www/server/panel/vhost/nginx/well-known/$DOMAIN.conf;
    # CERT-APPLY-CHECK--END
    
    # SSL 相关配置（需要在宝塔面板中申请SSL证书）
    ssl_certificate    /www/server/panel/vhost/cert/$DOMAIN/fullchain.pem;
    ssl_certificate_key    /www/server/panel/vhost/cert/$DOMAIN/privkey.pem;
    ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
    ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_session_tickets on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    add_header Strict-Transport-Security "max-age=31536000";
    add_header Alt-Svc 'quic=":443"; h3=":443"; h3-29=":443"; h3-27=":443";h3-25=":443"; h3-T050=":443"; h3-Q050=":443";h3-Q049=":443";h3-Q048=":443"; h3-Q046=":443"; h3-Q043=":443"';
    error_page 497  https://\$host\$request_uri;
    
    # HTTP 强制跳转 HTTPS
    if (\$server_port != 443) {
        rewrite ^(/.*)\$ https://\$host\$1 permanent;
    }
    
    # 后端接口代理
    location /prod-api/ {
        proxy_pass http://127.0.0.1:$BACKEND_PORT/;
        proxy_set_header Host \$http_host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header REMOTE-HOST \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_connect_timeout 600;
        proxy_read_timeout 600;
        proxy_send_timeout 600;
        client_max_body_size 50m;
    }
    
    # 前端路由支持
    location / {
        try_files \$uri \$uri/ /index.html;
    }
    
    # 静态资源缓存
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)\$ {
        expires 30d;
        add_header Cache-Control "public, immutable";
    }
    
    # 禁止访问敏感文件
    location ~* (\.user.ini|\.htaccess|\.htpasswd|\.env.*|\.project|\.bashrc|\.bash_profile|\.bash_logout|\.DS_Store|\.gitignore|\.gitattributes|LICENSE|README\.md|CLAUDE\.md|CHANGELOG\.md|CHANGELOG|CONTRIBUTING\.md|TODO\.md|FAQ\.md|composer\.json|composer\.lock|package(-lock)?\.json|yarn\.lock|pnpm-lock\.yaml|\.\w+~|\.swp|\.swo|\.bak(up)?|\.old|\.tmp|\.temp|\.log|\.sql(\.gz)?|docker-compose\.yml|docker\.env|Dockerfile|\.csproj|\.sln|Cargo\.toml|Cargo\.lock|go\.mod|go\.sum|phpunit\.xml|phpunit\.xml|pom\.xml|build\.gradl|pyproject\.toml|requirements\.txt|application(-\w+)?\.(ya?ml|properties))\$ {
        return 404;
    }
    
    # 日志配置
    access_log  /www/wwwlogs/$DOMAIN.log;
    error_log  /www/wwwlogs/$DOMAIN.error.log;
}
EOF

echo -e "${GREEN}✓ Nginx配置文件已生成: $DEPLOY_DIR/nginx.conf${NC}"
echo -e "${YELLOW}请在宝塔面板中配置Nginx：${NC}"
echo -e "  1. 创建新网站，域名: ${CYAN}$DOMAIN${NC}"
echo -e "  2. 网站根目录设置为: ${CYAN}$FRONTEND_DIR${NC}"
echo -e "  3. 复制配置文件内容到网站配置中"
echo -e "  4. 在宝塔面板中申请SSL证书（Let's Encrypt）"
echo -e "  5. 保存配置并重启Nginx"

# 完成
echo -e "\n${CYAN}========================================${NC}"
echo -e "${GREEN}部署完成！${NC}"
echo -e "${CYAN}========================================${NC}"
echo -e "部署目录: ${YELLOW}$DEPLOY_DIR${NC}"
echo -e "后端日志: ${YELLOW}$BACKEND_DIR/backend.log${NC}"
echo -e "后端端口: ${YELLOW}$BACKEND_PORT${NC}"
echo -e "域名: ${YELLOW}https://$DOMAIN${NC}"
echo -e "\n${CYAN}服务管理命令：${NC}"
echo -e "  启动后端: ${YELLOW}$BACKEND_DIR/start.sh${NC}"
echo -e "  停止后端: ${YELLOW}$BACKEND_DIR/stop.sh${NC}"
echo -e "  查看日志: ${YELLOW}tail -f $BACKEND_DIR/backend.log${NC}"
echo -e "\n${CYAN}下一步操作：${NC}"
echo -e "  1. 在宝塔面板中创建网站（域名: ${YELLOW}$DOMAIN${NC}）"
echo -e "  2. 设置网站根目录为: ${YELLOW}$FRONTEND_DIR${NC}"
echo -e "  3. 复制 ${YELLOW}$DEPLOY_DIR/nginx.conf${NC} 的内容到网站配置"
echo -e "  4. 在宝塔面板中申请SSL证书（Let's Encrypt）"
echo -e "  5. 保存配置并重启Nginx"
echo -e "  6. 访问系统: ${YELLOW}https://$DOMAIN${NC}"
echo -e "  7. 默认账号: ${YELLOW}admin / admin123${NC}"
echo -e "${CYAN}========================================${NC}"
