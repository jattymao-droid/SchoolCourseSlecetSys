#!/bin/bash
# 服务器 Docker 一键部署脚本
# 适用于 CentOS 7 + Docker + 宝塔面板
# 使用已有的 PostgreSQL 和 Redis Docker 容器

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# 配置变量
DB_NAME="school-course"
DB_USER="postgres"
DB_PASSWORD="mm5621528"
DB_PORT="5432"
REDIS_PORT="6379"
# 自动检测部署目录：如果从 scripts 目录执行，使用父目录；否则使用 /www/wwwroot/xk.xmls.vip
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$SCRIPT_DIR" == */scripts ]]; then
    DEPLOY_DIR="$(dirname "$SCRIPT_DIR")"
else
    DEPLOY_DIR="/www/wwwroot/xk.xmls.vip"
fi

echo -e "${CYAN}========================================"
echo -e "学校选课系统 - Docker 一键部署"
echo -e "========================================${NC}"

# 检查是否为 root 用户
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}请使用 root 用户运行此脚本${NC}"
    exit 1
fi

# 1. 检查环境
echo -e "\n${CYAN}步骤 1/6: 检查服务器环境${NC}"

# 检查 Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}错误: Docker 未安装${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Docker 已安装${NC}"

# 检查 docker-compose
if ! command -v docker-compose &> /dev/null; then
    echo -e "${YELLOW}安装 docker-compose...${NC}"
    curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    echo -e "${GREEN}✓ docker-compose 已安装${NC}"
else
    echo -e "${GREEN}✓ docker-compose 已安装${NC}"
fi

# 检查 PostgreSQL 容器
echo -e "\n${CYAN}检查 PostgreSQL 容器...${NC}"
POSTGRES_CONTAINER=$(docker ps --format "{{.Names}}" | grep -i postgres | head -n 1)

if [ -z "$POSTGRES_CONTAINER" ]; then
    echo -e "${RED}错误: 未找到运行中的 PostgreSQL 容器${NC}"
    echo -e "${YELLOW}请确保 PostgreSQL Docker 容器正在运行${NC}"
    exit 1
fi

echo -e "${GREEN}✓ PostgreSQL 容器运行中: $POSTGRES_CONTAINER${NC}"

# 测试数据库连接
if docker exec $POSTGRES_CONTAINER psql -U $DB_USER -c "SELECT 1" > /dev/null 2>&1; then
    echo -e "${GREEN}✓ 数据库连接测试成功${NC}"
else
    echo -e "${RED}错误: 无法连接到 PostgreSQL${NC}"
    exit 1
fi

# 检查 Redis 服务（直接安装在宿主机）
echo -e "\n${CYAN}检查 Redis 服务...${NC}"
if command -v redis-cli &> /dev/null; then
    if redis-cli -p $REDIS_PORT ping > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Redis 服务运行正常${NC}"
    else
        echo -e "${YELLOW}警告: Redis 服务未响应${NC}"
        echo -e "${YELLOW}请检查 Redis 是否正在运行: systemctl status redis${NC}"
        echo -e "${YELLOW}系统将继续部署，但 Redis 功能可能不可用${NC}"
    fi
else
    echo -e "${YELLOW}警告: 未找到 redis-cli 命令${NC}"
    echo -e "${YELLOW}系统将继续部署，但无法验证 Redis 状态${NC}"
fi

# 2. 准备部署目录
echo -e "\n${CYAN}步骤 2/6: 准备部署目录${NC}"

echo -e "${CYAN}部署目录: $DEPLOY_DIR${NC}"

# 检查是否已在部署目录中（文件已上传）
if [ -f "$DEPLOY_DIR/backend/ruoyi-admin.jar" ] || [ -f "$DEPLOY_DIR/backend/Dockerfile" ]; then
    echo -e "${GREEN}✓ 检测到部署文件已存在，跳过复制步骤${NC}"
else
    # 需要复制文件
    echo -e "${YELLOW}准备复制部署文件...${NC}"
    
    # 如果部署目录已存在但为空或不完整，备份
    if [ -d "$DEPLOY_DIR" ] && [ "$(ls -A $DEPLOY_DIR 2>/dev/null)" ]; then
        BACKUP_DIR="${DEPLOY_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}备份现有部署到: $BACKUP_DIR${NC}"
        mv "$DEPLOY_DIR" "$BACKUP_DIR"
    fi
    
    # 创建部署目录
    mkdir -p "$DEPLOY_DIR"
    
    # 3. 复制部署文件
    echo -e "\n${CYAN}步骤 3/6: 复制部署文件${NC}"
    
    # 检查是否在 scripts 目录中执行
    if [[ "$SCRIPT_DIR" == */scripts ]]; then
        # 从 scripts 目录执行，父目录就是部署目录
        SOURCE_DIR="$(dirname "$SCRIPT_DIR")"
        if [ -f "$SOURCE_DIR/backend/ruoyi-admin.jar" ]; then
            echo -e "${YELLOW}从 $SOURCE_DIR 复制文件...${NC}"
            cp -r "$SOURCE_DIR/"* "$DEPLOY_DIR/"
            echo -e "${GREEN}✓ 部署文件已复制${NC}"
        else
            echo -e "${RED}错误: 在 $SOURCE_DIR 中找不到部署文件${NC}"
            exit 1
        fi
    else
        # 在其他目录执行
        if [ -f "$SCRIPT_DIR/backend/ruoyi-admin.jar" ]; then
            # 当前目录就是部署包
            cp -r "$SCRIPT_DIR/"* "$DEPLOY_DIR/"
            echo -e "${GREEN}✓ 部署文件已复制${NC}"
        elif [ -d "$SCRIPT_DIR/deploy" ]; then
            # 在项目根目录
            cp -r "$SCRIPT_DIR/deploy/"* "$DEPLOY_DIR/"
            echo -e "${GREEN}✓ 部署文件已复制${NC}"
        else
            echo -e "${RED}错误: 找不到部署文件${NC}"
            echo -e "${YELLOW}请确保在正确的目录执行此脚本${NC}"
            exit 1
        fi
    fi
fi

# 4. 初始化数据库
echo -e "\n${CYAN}步骤 4/6: 初始化数据库${NC}"

# 检查数据库是否存在
DB_EXISTS=$(docker exec $POSTGRES_CONTAINER psql -U $DB_USER -lqt | cut -d \| -f 1 | grep -w $DB_NAME | wc -l)

if [ $DB_EXISTS -eq 0 ]; then
    echo -e "${YELLOW}创建数据库: $DB_NAME${NC}"
    docker exec $POSTGRES_CONTAINER psql -U $DB_USER -c "CREATE DATABASE \"$DB_NAME\";"
    echo -e "${GREEN}✓ 数据库已创建${NC}"
    
    # 导入数据库
    if [ -f "$DEPLOY_DIR/sql/init.sql" ]; then
        echo -e "${YELLOW}导入数据库...${NC}"
        docker exec -i $POSTGRES_CONTAINER psql -U $DB_USER -d $DB_NAME < "$DEPLOY_DIR/sql/init.sql"
        echo -e "${GREEN}✓ 数据库导入完成${NC}"
    else
        echo -e "${YELLOW}警告: 未找到数据库初始化脚本${NC}"
    fi
else
    echo -e "${YELLOW}数据库已存在: $DB_NAME${NC}"
    echo -e "${YELLOW}是否覆盖现有数据库？(y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo -e "${YELLOW}删除现有数据库...${NC}"
        docker exec $POSTGRES_CONTAINER psql -U $DB_USER -c "DROP DATABASE IF EXISTS \"$DB_NAME\";"
        docker exec $POSTGRES_CONTAINER psql -U $DB_USER -c "CREATE DATABASE \"$DB_NAME\";"
        
        if [ -f "$DEPLOY_DIR/sql/init.sql" ]; then
            echo -e "${YELLOW}导入数据库...${NC}"
            docker exec -i $POSTGRES_CONTAINER psql -U $DB_USER -d $DB_NAME < "$DEPLOY_DIR/sql/init.sql"
            echo -e "${GREEN}✓ 数据库导入完成${NC}"
        fi
    else
        echo -e "${YELLOW}跳过数据库初始化${NC}"
    fi
fi

# 5. 构建后端镜像
echo -e "\n${CYAN}步骤 5/6: 构建后端 Docker 镜像${NC}"

cd "$DEPLOY_DIR/backend"
docker build -t course-selection-backend:latest .
echo -e "${GREEN}✓ 后端镜像构建完成${NC}"

# 6. 启动服务
echo -e "\n${CYAN}步骤 6/6: 启动 Docker 容器${NC}"

cd "$DEPLOY_DIR"

# 使用服务器配置的 docker-compose 文件
if [ -f "docker-compose-server.yml" ]; then
    COMPOSE_FILE="docker-compose-server.yml"
else
    COMPOSE_FILE="docker-compose.yml"
fi

echo -e "${YELLOW}使用配置文件: $COMPOSE_FILE${NC}"
docker-compose -f $COMPOSE_FILE up -d

echo -e "\n${CYAN}等待服务启动 (30秒)...${NC}"
sleep 30

# 检查服务状态
echo -e "\n${CYAN}检查服务状态...${NC}"
docker-compose -f $COMPOSE_FILE ps

# 检查后端健康状态
if curl -s http://localhost:8080 > /dev/null; then
    echo -e "${GREEN}✓ 后端服务运行正常${NC}"
else
    echo -e "${YELLOW}! 后端服务可能未完全启动，请检查日志${NC}"
    echo -e "${YELLOW}查看日志: docker-compose -f $COMPOSE_FILE logs backend${NC}"
fi

# 完成
echo -e "\n${CYAN}========================================${NC}"
echo -e "${GREEN}部署完成！${NC}"
echo -e "${CYAN}========================================${NC}"
echo -e "部署目录: ${YELLOW}$DEPLOY_DIR${NC}"
echo -e "访问地址: ${YELLOW}http://服务器IP${NC}"
echo -e "后端 API: ${YELLOW}http://服务器IP:8080${NC}"
echo -e "默认账号: ${YELLOW}admin / admin123${NC}"
echo -e "\n${CYAN}服务管理命令：${NC}"
echo -e "  查看状态: ${YELLOW}cd $DEPLOY_DIR && docker-compose -f $COMPOSE_FILE ps${NC}"
echo -e "  查看日志: ${YELLOW}cd $DEPLOY_DIR && docker-compose -f $COMPOSE_FILE logs -f${NC}"
echo -e "  停止服务: ${YELLOW}cd $DEPLOY_DIR && docker-compose -f $COMPOSE_FILE down${NC}"
echo -e "  启动服务: ${YELLOW}cd $DEPLOY_DIR && docker-compose -f $COMPOSE_FILE up -d${NC}"
echo -e "  重启服务: ${YELLOW}cd $DEPLOY_DIR && docker-compose -f $COMPOSE_FILE restart${NC}"
echo -e "\n${CYAN}快捷脚本：${NC}"
echo -e "  启动: ${YELLOW}$DEPLOY_DIR/scripts/start.sh${NC}"
echo -e "  停止: ${YELLOW}$DEPLOY_DIR/scripts/stop.sh${NC}"
echo -e "  重启: ${YELLOW}$DEPLOY_DIR/scripts/restart.sh${NC}"
echo -e "  日志: ${YELLOW}$DEPLOY_DIR/scripts/logs.sh${NC}"
echo -e "${CYAN}========================================${NC}"
