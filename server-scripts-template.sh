#!/bin/bash
# 服务器管理脚本模板
# 这些脚本会被复制到 deploy/scripts/ 目录

# ============ start.sh ============
cat > start.sh << 'EOF'
#!/bin/bash
# 启动所有服务

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(dirname "$SCRIPT_DIR")"

cd "$DEPLOY_DIR"

# 检查使用哪个配置文件
if [ -f "docker-compose-server.yml" ]; then
    COMPOSE_FILE="docker-compose-server.yml"
else
    COMPOSE_FILE="docker-compose.yml"
fi

echo "启动 Docker 容器..."
docker-compose -f $COMPOSE_FILE up -d
echo "服务已启动！"
docker-compose -f $COMPOSE_FILE ps
EOF

# ============ stop.sh ============
cat > stop.sh << 'EOF'
#!/bin/bash
# 停止所有服务

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(dirname "$SCRIPT_DIR")"

cd "$DEPLOY_DIR"

# 检查使用哪个配置文件
if [ -f "docker-compose-server.yml" ]; then
    COMPOSE_FILE="docker-compose-server.yml"
else
    COMPOSE_FILE="docker-compose.yml"
fi

echo "停止 Docker 容器..."
docker-compose -f $COMPOSE_FILE down
echo "服务已停止！"
EOF

# ============ restart.sh ============
cat > restart.sh << 'EOF'
#!/bin/bash
# 重启所有服务

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(dirname "$SCRIPT_DIR")"

cd "$DEPLOY_DIR"

# 检查使用哪个配置文件
if [ -f "docker-compose-server.yml" ]; then
    COMPOSE_FILE="docker-compose-server.yml"
else
    COMPOSE_FILE="docker-compose.yml"
fi

echo "重启 Docker 容器..."
docker-compose -f $COMPOSE_FILE restart
echo "服务已重启！"
docker-compose -f $COMPOSE_FILE ps
EOF

# ============ logs.sh ============
cat > logs.sh << 'EOF'
#!/bin/bash
# 查看服务日志

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(dirname "$SCRIPT_DIR")"

cd "$DEPLOY_DIR"

# 检查使用哪个配置文件
if [ -f "docker-compose-server.yml" ]; then
    COMPOSE_FILE="docker-compose-server.yml"
else
    COMPOSE_FILE="docker-compose.yml"
fi

if [ -z "$1" ]; then
    echo "查看所有服务日志..."
    docker-compose -f $COMPOSE_FILE logs -f
else
    echo "查看 $1 服务日志..."
    docker-compose -f $COMPOSE_FILE logs -f $1
fi
EOF

# ============ status.sh ============
cat > status.sh << 'EOF'
#!/bin/bash
# 查看服务状态

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(dirname "$SCRIPT_DIR")"

cd "$DEPLOY_DIR"

# 检查使用哪个配置文件
if [ -f "docker-compose-server.yml" ]; then
    COMPOSE_FILE="docker-compose-server.yml"
else
    COMPOSE_FILE="docker-compose.yml"
fi

echo "服务状态："
docker-compose -f $COMPOSE_FILE ps

echo ""
echo "后端健康检查："
if curl -s http://localhost:8080 > /dev/null; then
    echo "✓ 后端服务运行正常"
else
    echo "✗ 后端服务未响应"
fi

echo ""
echo "前端健康检查："
if curl -s http://localhost > /dev/null; then
    echo "✓ 前端服务运行正常"
else
    echo "✗ 前端服务未响应"
fi
EOF

# ============ backup-db.sh ============
cat > backup-db.sh << 'EOF'
#!/bin/bash
# 备份数据库

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$DEPLOY_DIR/backups"

mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/database_backup_$TIMESTAMP.sql"

# 查找 PostgreSQL 容器
POSTGRES_CONTAINER=$(docker ps --format "{{.Names}}" | grep -i postgres | head -n 1)

if [ -z "$POSTGRES_CONTAINER" ]; then
    echo "错误: 未找到 PostgreSQL 容器"
    exit 1
fi

echo "备份数据库到: $BACKUP_FILE"
docker exec $POSTGRES_CONTAINER pg_dump -U postgres school-course > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "✓ 数据库备份成功"
    
    # 压缩备份文件
    gzip "$BACKUP_FILE"
    echo "✓ 备份文件已压缩: ${BACKUP_FILE}.gz"
    
    # 删除 7 天前的备份
    find "$BACKUP_DIR" -name "database_backup_*.sql.gz" -mtime +7 -delete
    echo "✓ 已清理 7 天前的旧备份"
else
    echo "✗ 数据库备份失败"
    exit 1
fi
EOF

# ============ update.sh ============
cat > update.sh << 'EOF'
#!/bin/bash
# 更新应用

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(dirname "$SCRIPT_DIR")"

cd "$DEPLOY_DIR"

# 检查使用哪个配置文件
if [ -f "docker-compose-server.yml" ]; then
    COMPOSE_FILE="docker-compose-server.yml"
else
    COMPOSE_FILE="docker-compose.yml"
fi

echo "========================================="
echo "应用更新脚本"
echo "========================================="

# 1. 备份数据库
echo "步骤 1/5: 备份数据库..."
bash "$SCRIPT_DIR/backup-db.sh"

# 2. 停止服务
echo ""
echo "步骤 2/5: 停止服务..."
docker-compose -f $COMPOSE_FILE down

# 3. 重新构建镜像
echo ""
echo "步骤 3/5: 重新构建后端镜像..."
cd backend
docker build -t course-selection-backend:latest .
cd ..

# 4. 启动服务
echo ""
echo "步骤 4/5: 启动服务..."
docker-compose -f $COMPOSE_FILE up -d

# 5. 等待并检查
echo ""
echo "步骤 5/5: 等待服务启动..."
sleep 30

docker-compose -f $COMPOSE_FILE ps

if curl -s http://localhost:8080 > /dev/null; then
    echo "✓ 更新成功！后端服务运行正常"
else
    echo "✗ 警告：后端服务可能未正常启动，请检查日志"
fi

echo "========================================="
echo "更新完成"
echo "========================================="
EOF

chmod +x *.sh

echo "所有管理脚本已创建！"
