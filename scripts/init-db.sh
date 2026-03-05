#!/bin/bash
# ============================================================
# 数据库初始化脚本 (PostgreSQL)
# 使用 Docker 运行 psql，无需在宿主机安装 PostgreSQL 客户端
# 在 deploy 目录下执行
# ============================================================
# 用法: ./init-db.sh
# 可选环境变量:
#   DB_HOST  数据库主机。PostgreSQL 在 Docker 时，Linux 下建议 172.17.0.1
#   DB_PORT  端口，默认 5432
#   DB_USER  用户，默认 postgres
#   DB_PASS  密码，默认 mm5621528
#   DB_NAME  数据库名，默认 ry_vue
# ============================================================

set -e

# 配置信息
DB_HOST="${DB_HOST:-host.docker.internal}"
DB_PORT="${DB_PORT:-5432}"
DB_USER="${DB_USER:-postgres}"
DB_PASS="${DB_PASS:-mm5621528}"
DB_NAME="${DB_NAME:-ry_vue}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SQL_DIR="${SCRIPT_DIR}/sql"

# SQL 执行函数（使用 Docker postgres 镜像）
run_psql() {
    docker run -i --rm \
        --add-host host.docker.internal:host-gateway \
        -e PGPASSWORD="$DB_PASS" \
        postgres:15-alpine \
        psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" "$@"
}

run_psql_file() {
    docker run -i --rm \
        --add-host host.docker.internal:host-gateway \
        -e PGPASSWORD="$DB_PASS" \
        -v "$SQL_DIR:/sql:ro" \
        postgres:15-alpine \
        psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f "/sql/$1" -q
}

echo "=========================================="
echo "  东陆高中选课系统 - 数据库初始化"
echo "  目标: $DB_NAME @ $DB_HOST:$DB_PORT"
echo "  用户: $DB_USER"
echo "=========================================="

# 检查 Docker
if ! command -v docker &>/dev/null; then
    echo "错误: 未找到 docker，请先安装 Docker"
    exit 1
fi

# 检查 sql 目录
if [ ! -d "$SQL_DIR" ]; then
    echo "错误: 未找到 sql 目录，请在 deploy 目录下执行此脚本"
    exit 1
fi

# 1. 检查数据库是否存在
echo "正在检查数据库 '$DB_NAME' 是否存在..."
DB_EXISTS=$(run_psql -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" 2>/dev/null || echo "")
DB_EXISTS=$(echo "$DB_EXISTS" | tr -d '[:space:]')

if [ "$DB_EXISTS" = "1" ]; then
    echo "数据库 '$DB_NAME' 已存在，跳过创建。"
else
    echo "数据库 '$DB_NAME' 不存在，正在创建..."
    run_psql -d postgres -c "CREATE DATABASE $DB_NAME"
    if [ $? -eq 0 ]; then
        echo "数据库创建成功。"
    else
        echo "错误: 数据库创建失败，请检查连接信息 (DB_HOST=$DB_HOST)"
        exit 1
    fi
fi

# 2. 按顺序导入 SQL 文件
SQL_FILES=(
    "ry_20250522_postgresql.sql"
    "quartz_postgresql.sql"
    "course_selection_init.sql"
    "course_grade_class_menu.sql"
    "course_student_menu.sql"
    "course_course_menu.sql"
    "course_selection_menu.sql"
    "course_evaluation_menu.sql"
    "course_teacher_assessment_menu.sql"
    "course_week_day_dict.sql"
    "course_default_password_config.sql"
    "add_course_teacher_name.sql"
    "add_stu_selection_assigned.sql"
    "add_course_location.sql"
    "add_semester_selection_time.sql"
    "fix_teacher_assessment_no_cache.sql"
    "fix_course_route_name.sql"
    "fix_student_login_by_student_no.sql"
    "verify_location.sql"
)

echo "正在导入表结构和数据..."
for f in "${SQL_FILES[@]}"; do
    if [ -f "$SQL_DIR/$f" ]; then
        echo "  执行: $f"
        run_psql_file "$f" || { echo "错误: $f 执行失败"; exit 1; }
    else
        echo "  跳过(不存在): $f"
    fi
done

# 可选：演示数据
# if [ -f "$SQL_DIR/course_demo_data.sql" ]; then
#     echo "  执行: course_demo_data.sql (演示数据)"
#     run_psql_file "course_demo_data.sql"
# fi

echo ""
echo "=========================================="
echo "  数据库导入成功！"
echo "=========================================="
