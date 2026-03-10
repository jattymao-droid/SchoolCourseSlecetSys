#!/bin/bash

# 课程选课系统 - 一键部署脚本
# 适用于 CentOS 7 + 宝塔 + Docker (PostgreSQL + Redis)

set -e

echo "========================================"
echo "课程选课系统 - 一键部署"
echo "========================================"
echo ""

# 配置变量
DB_HOST="localhost"
DB_PORT="5432"
DB_NAME="school-course"
DB_USER="postgres"
DB_PASSWORD="mm5621528"
REDIS_HOST="localhost"
REDIS_PORT="6379"
BACKEND_PORT="8080"
FRONTEND_PORT="80"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# 检测 Docker 容器
detect_docker_container() {
    local service=$1
    local container=$(docker ps --format '{{.Names}}' | grep -i $service | head -n 1)
    echo $container
}

# 1. 检查环境
echo "1. 检查系统环境..."

# 检查 Java
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    print_success "Java 版本: $JAVA_VERSION"
else
    print_error "未安装 Java，请先安装 JDK 1.8+"
    exit 1
fi

# 检查 Docker
if command -v docker &> /dev/null; then
    print_success "Docker 已安装"
else
    print_error "未安装 Docker"
    exit 1
fi

# 检测 PostgreSQL 容器
PG_CONTAINER=$(detect_docker_container "postgres")
if [ -n "$PG_CONTAINER" ]; then
    print_success "PostgreSQL 容器: $PG_CONTAINER"
else
    print_error "未找到 PostgreSQL 容器"
    exit 1
fi

# 检测 Redis 容器
REDIS_CONTAINER=$(detect_docker_container "redis")
if [ -n "$REDIS_CONTAINER" ]; then
    print_success "Redis 容器: $REDIS_CONTAINER"
else
    print_error "未找到 Redis 容器"
    exit 1
fi

# 检查 Nginx
if command -v nginx &> /dev/null; then
    print_success "Nginx 已安装"
else
    print_warning "未安装 Nginx，前端将无法通过 80 端口访问"
fi

echo ""

# 2. 创建目录结构
echo "2. 创建目录结构..."
mkdir -p /www/wwwroot/course-selection/{backend,frontend,logs,database}
print_success "目录创建完成"
echo ""

# 3. 部署后端
echo "3. 部署后端应用..."

# 停止旧的后端服务
if [ -f /www/wwwroot/course-selection/backend/app.pid ]; then
    OLD_PID=$(cat /www/wwwroot/course-selection/backend/app.pid)
    if ps -p $OLD_PID > /dev/null 2>&1; then
        print_warning "停止旧的后端服务 (PID: $OLD_PID)..."
        kill $OLD_PID
        sleep 3
    fi
    rm -f /www/wwwroot/course-selection/backend/app.pid
fi

# 复制后端 JAR 文件
if [ -f "backend/ruoyi-admin.jar" ]; then
    cp backend/ruoyi-admin.jar /www/wwwroot/course-selection/backend/
    print_success "后端文件复制完成"
else
    print_error "未找到后端 JAR 文件: backend/ruoyi-admin.jar"
    exit 1
fi

echo ""

# 4. 部署前端
echo "4. 部署前端应用..."

if [ -d "frontend/dist" ]; then
    rm -rf /www/wwwroot/course-selection/frontend/*
    cp -r frontend/dist/* /www/wwwroot/course-selection/frontend/
    print_success "前端文件复制完成"
else
    print_error "未找到前端文件: frontend/dist"
    exit 1
fi

echo ""

# 5. 导入数据库
echo "5. 导入数据库..."

if [ -f "database/database_backup.dump" ]; then
    # 检查数据库是否存在
    DB_EXISTS=$(docker exec $PG_CONTAINER psql -U $DB_USER -lqt | cut -d \| -f 1 | grep -w $DB_NAME | wc -l)
    
    if [ $DB_EXISTS -gt 0 ]; then
        print_warning "数据库 $DB_NAME 已存在，正在删除..."
        
        # 断开所有连接
        docker exec $PG_CONTAINER psql -U $DB_USER -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME';" > /dev/null 2>&1 || true
        
        # 删除数据库
        docker exec $PG_CONTAINER psql -U $DB_USER -d postgres -c "DROP DATABASE IF EXISTS \"$DB_NAME\";" > /dev/null 2>&1
        print_success "旧数据库已删除"
    fi
    
    # 创建新数据库
    print_warning "创建数据库 $DB_NAME..."
    docker exec $PG_CONTAINER psql -U $DB_USER -d postgres -c "CREATE DATABASE \"$DB_NAME\" WITH ENCODING='UTF8';" > /dev/null 2>&1
    print_success "数据库创建完成"
    
    # 导入数据
    print_warning "导入数据库备份..."
    docker exec -i $PG_CONTAINER pg_restore -U $DB_USER -d $DB_NAME -v < database/database_backup.dump > /dev/null 2>&1 || true
    print_success "数据库导入完成"
    
    # 复制备份文件
    cp database/database_backup.dump /www/wwwroot/course-selection/database/
else
    print_error "未找到数据库备份文件: database/database_backup.dump"
    exit 1
fi

echo ""

# 6. 配置 Nginx
echo "6. 配置 Nginx..."

NGINX_CONF="/www/server/panel/vhost/nginx/course-selection.conf"

cat > $NGINX_CONF << 'EOF'
server {
    listen 80;
    server_name _;
    
    # 前端静态文件
    location / {
        root /www/wwwroot/course-selection/frontend;
        try_files $uri $uri/ /index.html;
        index index.html;
    }
    
    # 后端 API 代理
    location /prod-api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_connect_timeout 600;
        proxy_read_timeout 600;
        proxy_send_timeout 600;
    }
    
    # 文件上传大小限制
    client_max_body_size 50m;
    
    # 日志
    access_log /www/wwwroot/course-selection/logs/nginx_access.log;
    error_log /www/wwwroot/course-selection/logs/nginx_error.log;
}
EOF

print_success "Nginx 配置完成"

# 测试 Nginx 配置
if nginx -t > /dev/null 2>&1; then
    print_success "Nginx 配置测试通过"
    # 重载 Nginx
    nginx -s reload > /dev/null 2>&1 || systemctl reload nginx
    print_success "Nginx 已重载"
else
    print_error "Nginx 配置测试失败"
fi

echo ""

# 7. 创建启动脚本
echo "7. 创建启动脚本..."

cat > /www/wwwroot/course-selection/backend/start.sh << 'EOF'
#!/bin/bash

APP_NAME="ruoyi-admin.jar"
APP_DIR="/www/wwwroot/course-selection/backend"
LOG_DIR="/www/wwwroot/course-selection/logs"
PID_FILE="$APP_DIR/app.pid"

cd $APP_DIR

# 停止旧进程
if [ -f $PID_FILE ]; then
    OLD_PID=$(cat $PID_FILE)
    if ps -p $OLD_PID > /dev/null 2>&1; then
        echo "停止旧进程 (PID: $OLD_PID)..."
        kill $OLD_PID
        sleep 3
    fi
    rm -f $PID_FILE
fi

# 启动应用
echo "启动后端应用..."
nohup java -jar $APP_NAME \
    --spring.profiles.active=druid,prod \
    > $LOG_DIR/backend.log 2>&1 &

echo $! > $PID_FILE
echo "后端应用已启动 (PID: $(cat $PID_FILE))"
echo "日志文件: $LOG_DIR/backend.log"
EOF

chmod +x /www/wwwroot/course-selection/backend/start.sh
print_success "启动脚本创建完成"

echo ""

# 8. 创建停止脚本
echo "8. 创建停止脚本..."

cat > /www/wwwroot/course-selection/backend/stop.sh << 'EOF'
#!/bin/bash

APP_DIR="/www/wwwroot/course-selection/backend"
PID_FILE="$APP_DIR/app.pid"

if [ -f $PID_FILE ]; then
    PID=$(cat $PID_FILE)
    if ps -p $PID > /dev/null 2>&1; then
        echo "停止后端应用 (PID: $PID)..."
        kill $PID
        sleep 2
        
        # 强制停止
        if ps -p $PID > /dev/null 2>&1; then
            echo "强制停止..."
            kill -9 $PID
        fi
        
        rm -f $PID_FILE
        echo "后端应用已停止"
    else
        echo "进程不存在 (PID: $PID)"
        rm -f $PID_FILE
    fi
else
    echo "未找到 PID 文件"
fi
EOF

chmod +x /www/wwwroot/course-selection/backend/stop.sh
print_success "停止脚本创建完成"

echo ""

# 9. 创建重启脚本
echo "9. 创建重启脚本..."

cat > /www/wwwroot/course-selection/backend/restart.sh << 'EOF'
#!/bin/bash

APP_DIR="/www/wwwroot/course-selection/backend"

echo "重启后端应用..."
$APP_DIR/stop.sh
sleep 2
$APP_DIR/start.sh
EOF

chmod +x /www/wwwroot/course-selection/backend/restart.sh
print_success "重启脚本创建完成"

echo ""

# 10. 启动后端服务
echo "10. 启动后端服务..."
/www/wwwroot/course-selection/backend/start.sh

# 等待启动
echo "等待后端启动..."
sleep 10

# 检查启动状态
if [ -f /www/wwwroot/course-selection/backend/app.pid ]; then
    PID=$(cat /www/wwwroot/course-selection/backend/app.pid)
    if ps -p $PID > /dev/null 2>&1; then
        print_success "后端服务启动成功 (PID: $PID)"
    else
        print_error "后端服务启动失败，请查看日志: /www/wwwroot/course-selection/logs/backend.log"
        exit 1
    fi
else
    print_error "后端服务启动失败"
    exit 1
fi

echo ""

# 11. 完成
echo "========================================"
print_success "部署完成！"
echo "========================================"
echo ""
echo "访问地址:"
echo "  前端: http://$(hostname -I | awk '{print $1}')"
echo "  后端: http://$(hostname -I | awk '{print $1}'):8080"
echo ""
echo "默认账号:"
echo "  管理员: admin / admin123"
echo "  学生: 学号 / 123456"
echo "  教师: 工号 / 123456"
echo ""
echo "管理命令:"
echo "  启动: /www/wwwroot/course-selection/backend/start.sh"
echo "  停止: /www/wwwroot/course-selection/backend/stop.sh"
echo "  重启: /www/wwwroot/course-selection/backend/restart.sh"
echo "  日志: tail -f /www/wwwroot/course-selection/logs/backend.log"
echo ""
echo "数据库信息:"
echo "  数据库名: $DB_NAME"
echo "  用户名: $DB_USER"
echo "  端口: $DB_PORT"
echo ""
