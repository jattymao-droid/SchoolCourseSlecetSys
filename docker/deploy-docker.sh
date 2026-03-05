#!/bin/bash
# ============================================================
# 东陆高中选课系统 - Docker 一键部署
# 云服务器执行，需先上传 deploy 目录
# PostgreSQL、Redis 使用宿主机（宝塔安装）
# ============================================================

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

echo "=========================================="
echo "  东陆高中选课系统 - Docker 部署"
echo "  项目目录: $PROJECT_ROOT"
echo "=========================================="

# 检查 deploy 目录及前端构建产物（后端由 Docker 从源码构建）
if [ ! -d "deploy/frontend-admin/dist" ] || [ ! -d "deploy/frontend-student/h5" ]; then
    echo "错误: 请先本地执行 build-for-deploy 生成 deploy 目录（含前端）并上传"
    echo "      或仅上传 deploy/frontend-admin 和 deploy/frontend-student"
    exit 1
fi

# 可选：数据库初始化
if [ -f "deploy/init-db.sh" ]; then
    read -p "是否执行数据库初始化? (y/n，首次部署选 y): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        chmod +x deploy/init-db.sh
        export PGPASSWORD="${PG_PASSWORD:-mm5621528}"
        deploy/init-db.sh ry_vue postgres
    fi
fi

# 构建并启动
echo "构建并启动容器..."
docker compose -f docker/docker-compose.yml up -d --build

echo ""
echo "=========================================="
echo "  部署完成！"
echo "  管理端: http://xk.xmls.vip (或 http://服务器IP)"
echo "  学生端: http://xk.xmls.vip/h5"
echo "  默认管理员: admin / admin123"
echo ""
echo "  查看日志: docker compose -f docker/docker-compose.yml logs -f"
echo "  停止服务: docker compose -f docker/docker-compose.yml down"
echo "=========================================="
