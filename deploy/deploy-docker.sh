#!/bin/bash
# ============================================================
# 东陆高中选课系统 - Docker 一键部署
# 在 deploy 目录下执行，需先上传 deploy 包到服务器
# PostgreSQL、Redis 可为宿主机安装或 Docker 容器（端口映射到宿主机）
# ============================================================
# 用法: ./deploy-docker.sh  或  bash deploy-docker.sh
# ============================================================

set -e
DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DEPLOY_DIR"

# 加载 .env（数据库密码、DB_HOST 等）
if [ -f ".env" ]; then
    set -a
    source .env
    set +a
fi

echo "=========================================="
echo "  东陆高中选课系统 - Docker 部署"
echo "  部署目录: $DEPLOY_DIR"
echo "=========================================="

# 检查必要文件
if [ ! -f "backend/ruoyi-admin.jar" ]; then
    echo "错误: 未找到 backend/ruoyi-admin.jar"
    exit 1
fi
if [ ! -d "frontend-admin/dist" ] || [ ! -d "frontend-student/h5" ]; then
    echo "错误: 未找到前端构建产物"
    exit 1
fi
if [ ! -d "docker" ]; then
    echo "错误: 未找到 docker 目录"
    exit 1
fi

# 检查 Docker
if ! command -v docker &>/dev/null; then
    echo "错误: 未安装 Docker，请先安装"
    exit 1
fi

# 可选：数据库初始化（使用 Docker 运行 psql，无需宿主机安装 PostgreSQL）
if [ -f "init-db.sh" ]; then
    read -p "是否执行数据库初始化? (y/n，首次部署选 y): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        chmod +x init-db.sh
        # PostgreSQL 在 Docker 时：确保端口 5432 映射到宿主机
        # 在 .env 中设置 DB_HOST=172.17.0.1（或 host.docker.internal）、DB_PASS=密码
        bash init-db.sh
    fi
fi

# 构建并启动
echo ""
echo "构建并启动容器..."
docker compose -f docker/docker-compose.yml up -d --build

echo ""
echo "=========================================="
echo "  部署完成！"
echo "  管理端: http://xk.xmls.vip:9090"
echo "  学生端: http://xk.xmls.vip:9090/h5"
echo "  默认管理员: admin / admin123"
echo ""
echo "  查看日志: docker compose -f docker/docker-compose.yml logs -f"
echo "  停止服务: docker compose -f docker/docker-compose.yml down"
echo "  重启服务: docker compose -f docker/docker-compose.yml restart"
echo "=========================================="
