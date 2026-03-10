#!/bin/bash
# 课程导入事务错误修复 - 部署脚本

set -e

echo "========================================"
echo "课程导入事务错误修复 - 部署"
echo "========================================"
echo ""

BACKEND_DIR="/www/wwwroot/course-selection/backend"
BACKUP_DIR="/www/wwwroot/course-selection/backups"
LOG_DIR="/www/wwwroot/course-selection/logs"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}错误: 请使用root用户运行此脚本${NC}"
    exit 1
fi

echo -e "${YELLOW}检查目录...${NC}"
mkdir -p "$BACKEND_DIR"
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"
echo -e "${GREEN}目录检查完成${NC}"
echo ""

if [ -f "$BACKEND_DIR/ruoyi-admin.jar" ]; then
    echo -e "${YELLOW}备份当前JAR文件...${NC}"
    BACKUP_FILE="$BACKUP_DIR/ruoyi-admin.jar.backup_$(date +%Y%m%d_%H%M%S)"
    cp "$BACKEND_DIR/ruoyi-admin.jar" "$BACKUP_FILE"
    echo -e "${GREEN}备份完成: $BACKUP_FILE${NC}"
    echo ""
fi

echo -e "${YELLOW}停止后端服务...${NC}"
if pgrep -f "ruoyi-admin.jar" > /dev/null; then
    pkill -f "ruoyi-admin.jar" || true
    sleep 3
    
    if pgrep -f "ruoyi-admin.jar" > /dev/null; then
        pkill -9 -f "ruoyi-admin.jar" || true
        sleep 2
    fi
    echo -e "${GREEN}后端服务已停止${NC}"
else
    echo -e "${YELLOW}后端服务未运行${NC}"
fi
echo ""

echo -e "${YELLOW}部署新JAR文件...${NC}"
cp backend/ruoyi-admin.jar "$BACKEND_DIR/ruoyi-admin.jar"
chmod 644 "$BACKEND_DIR/ruoyi-admin.jar"
echo -e "${GREEN}JAR文件部署完成${NC}"
echo ""

echo -e "${YELLOW}启动后端服务...${NC}"
cd "$BACKEND_DIR"

nohup java -jar ruoyi-admin.jar \
    --spring.profiles.active=druid,prod \
    > "$LOG_DIR/backend.log" 2>&1 &

sleep 5

if pgrep -f "ruoyi-admin.jar" > /dev/null; then
    echo -e "${GREEN}后端服务启动成功${NC}"
    echo ""
    echo -e "${GREEN}部署完成！${NC}"
    echo ""
    echo "查看日志:"
    echo "  tail -f $LOG_DIR/backend.log"
    echo ""
else
    echo -e "${RED}后端服务启动失败${NC}"
    echo ""
    echo "查看错误日志:"
    echo "  tail -n 100 $LOG_DIR/backend.log"
    exit 1
fi
