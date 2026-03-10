#!/bin/bash

# 课程选课系统 - 一键部署脚本
# 适用于 CentOS 7 + 宝塔 + Docker (PostgreSQL + Redis)

echo "========================================"
echo "课程选课系统 - 一键部署"
echo "========================================"

# 配置变量
DEPLOY_DIR="/www/wwwroot/course-selection"
DB_NAME="school-course"
DB_USER="postgres"
DB_PASSWORD="mm5621528"
DB_PORT="5432"
REDIS_PORT="6379"
BACKEND_PORT="8080"

# 1. 检查系统环境
echo "1. 检查系统环境..."
if ! command -v java &> /dev/null; then
    echo "❌ 未安装 Java，请先安装 Java 8 或更高版本"
    exit 1
fi
echo "✓ Java 版本: $(java -version 2>&1 | head -n 1 | cut -d'"' -f2)"

if ! command -v docker &> /dev/null; then
    echo "❌ 未安装 Docker"
    exit 1
fi
echo "✓ Docker 已安装"

# 检测 PostgreSQL 容器
PG_CONTAINER=$(docker ps --format '{{.Names}}' | grep -i postgres | head -n 1)
if [ -z "$PG_CONTAINER" ]; then
    echo "❌ 未找到运行中的 PostgreSQL 容器"
    exit 1
fi
echo "✓ PostgreSQL 容器: $PG_CONTAINER"

# 检测 Redis 容器
REDIS_CONTAINER=$(docker ps --format '{{.Names}}' | grep -i redis | head -n 1)
if [ -z "$REDIS_CONTAINER" ]; then
    echo "❌ 未找到运行中的 Redis 容器"
    exit 1
fi
echo "✓ Redis 容器: $REDIS_CONTAINER"

if ! command -v nginx &> /dev/null; then
    echo "❌ 未安装 Nginx"
    exit 1
fi
echo "✓ Nginx 已安装"

# 2. 创建目录结构
echo ""
echo "2. 创建目录结构..."
mkdir -p $DEPLOY_DIR/backend
mkdir -p $DEPLOY_DIR/frontend
mkdir -p $DEPLOY_DIR/logs
echo "✓ 目录创建完成"

# 3. 部署后端应用
echo ""
echo "3. 部署后端应用..."
cp backend/ruoyi-admin.jar $DEPLOY_DIR/backend/
echo "✓ 后端文件复制完成"

# 4. 部署前端应用
echo ""
echo "4. 部署前端应用..."
cp -r frontend/* $DEPLOY_DIR/frontend/
echo "✓ 前端文件复制完成"

# 5. 导入数据库
echo ""
echo "5. 导入数据库..."

# 检查数据库是否存在
DB_EXISTS=$(docker exec $PG_CONTAINER psql -U $DB_USER -lqt | cut -d \| -f 1 | grep -w $DB_NAME | wc -l)
if [ $DB_EXISTS -eq 1 ]; then
    echo "⚠ 数据库 $DB_NAME 已存在，正在删除..."
    docker exec $PG_CONTAINER psql -U $DB_USER -c "DROP DATABASE \"$DB_NAME\";"
    echo "✓ 旧数据库已删除"
fi

echo "⚠ 创建数据库 $DB_NAME..."
docker exec $PG_CONTAINER psql -U $DB_USER -c "CREATE DATABASE \"$DB_NAME\" OWNER $DB_USER;"
echo "✓ 数据库创建完成"

echo "⚠ 导入数据库备份..."
docker exec -i $PG_CONTAINER pg_restore -U $DB_USER -d $DB_NAME -v < database_backup.dump 2>&1 | grep -v "WARNING" || true
echo "✓ 数据库导入完成"

# 6. 配置 Nginx
echo ""
echo "6. 配置 Nginx..."

# 检查 Nginx 配置文件是否存在
NGINX_CONF="/www/server/panel/vhost/nginx/xk.xmls.vip.conf"
if [ ! -f "$NGINX_CONF" ]; then
    echo "⚠ Nginx 配置文件不存在，请手动配置"
    echo "   前端目录: $DEPLOY_DIR/frontend"
    echo "   后端代理: http://127.0.0.1:$BACKEND_PORT/"
else
    # 更新前端根目录
    sed -i "s|root .*;|root $DEPLOY_DIR/frontend;|g" $NGINX_CONF
    echo "✓ Nginx 配置完成"
    
    # 测试 Nginx 配置
    nginx -t
    if [ $? -eq 0 ]; then
        echo "✓ Nginx 配置测试通过"
        nginx -s reload
        echo "✓ Nginx 已重载"
    else
        echo "❌ Nginx 配置测试失败"
    fi
fi

# 7. 创建启动脚本
echo ""
echo "7. 创建启动脚本..."
cat > $DEPLOY_DIR/backend/start.sh << 'EOF'
#!/bin/bash
APP_NAME="ruoyi-admin.jar"
APP_DIR="/www/wwwroot/course-selection/backend"
LOG_DIR="/www/wwwroot/course-selection/logs"
PID_FILE="$APP_DIR/app.pid"

cd $APP_DIR

# 检查是否已经运行
if [ -f "$PID_FILE" ]; then
    PID=$(cat $PID_FILE)
    if ps -p $PID > /dev/null 2>&1; then
        echo "应用已在运行 (PID: $PID)"
        exit 1
    fi
fi

echo "启动后端应用..."
nohup java -jar $APP_NAME --spring.profiles.active=druid,prod > $LOG_DIR/backend.log 2>&1 &
echo $! > $PID_FILE
echo "后端应用已启动 (PID: $(cat $PID_FILE))"
echo "日志文件: $LOG_DIR/backend.log"

# 等待后端启动
sleep 5
if ps -p $(cat $PID_FILE) > /dev/null 2>&1; then
    echo "✓ 后端服务启动成功"
else
    echo "❌ 后端服务启动失败，请查看日志"
    rm -f $PID_FILE
    exit 1
fi
EOF

chmod +x $DEPLOY_DIR/backend/start.sh
echo "✓ 启动脚本创建完成"

# 8. 创建停止脚本
echo ""
echo "8. 创建停止脚本..."
cat > $DEPLOY_DIR/backend/stop.sh << 'EOF'
#!/bin/bash
APP_DIR="/www/wwwroot/course-selection/backend"
PID_FILE="$APP_DIR/app.pid"

if [ ! -f "$PID_FILE" ]; then
    echo "应用未运行"
    exit 0
fi

PID=$(cat $PID_FILE)
if ps -p $PID > /dev/null 2>&1; then
    echo "停止后端应用 (PID: $PID)..."
    kill $PID
    sleep 3
    
    # 强制杀死
    if ps -p $PID > /dev/null 2>&1; then
        kill -9 $PID
    fi
    
    rm -f $PID_FILE
    echo "✓ 后端应用已停止"
else
    echo "应用未运行"
    rm -f $PID_FILE
fi
EOF

chmod +x $DEPLOY_DIR/backend/stop.sh
echo "✓ 停止脚本创建完成"

# 9. 创建重启脚本
echo ""
echo "9. 创建重启脚本..."
cat > $DEPLOY_DIR/backend/restart.sh << 'EOF'
#!/bin/bash
APP_DIR="/www/wwwroot/course-selection/backend"

$APP_DIR/stop.sh
sleep 2
$APP_DIR/start.sh
EOF

chmod +x $DEPLOY_DIR/backend/restart.sh
echo "✓ 重启脚本创建完成"

# 10. 启动后端服务
echo ""
echo "10. 启动后端服务..."
$DEPLOY_DIR/backend/start.sh

echo ""
echo "========================================"
echo "✓ 部署完成！"
echo "========================================"
echo ""
echo "访问地址:"
echo "前端: https://xk.xmls.vip"
echo "后端: https://xk.xmls.vip/prod-api"
echo ""
echo "默认账号:"
echo "管理员: admin / admin123"
echo "学生: 学号 / 123456"
echo "教师: 工号 / 123456"
echo ""
echo "管理命令:"
echo "启动: $DEPLOY_DIR/backend/start.sh"
echo "停止: $DEPLOY_DIR/backend/stop.sh"
echo "重启: $DEPLOY_DIR/backend/restart.sh"
echo "日志: tail -f $DEPLOY_DIR/logs/backend.log"
echo ""
echo "数据库信息:"
echo "数据库名: $DB_NAME"
echo "用户名: $DB_USER"
echo "端口: $DB_PORT"
echo ""
