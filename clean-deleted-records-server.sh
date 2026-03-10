#!/bin/bash

# ============================================
# 清除服务器PostgreSQL数据库中的逻辑删除记录
# ============================================
# 用途：清除 stu_student_info 和 sys_user 表中 del_flag='2' 的记录
# 环境：服务器上的Docker PostgreSQL容器
# 数据库：school-course
# 用户：postgres
# 密码：mm5621528
# ============================================

set -e  # 遇到错误立即退出

echo "=========================================="
echo "清除PostgreSQL逻辑删除记录脚本"
echo "=========================================="
echo ""

# 配置变量
DB_NAME="school-course"
DB_USER="postgres"
DB_PASSWORD="mm5621528"
CONTAINER_NAME=""

# 自动检测PostgreSQL容器
echo "正在检测PostgreSQL容器..."
CONTAINER_NAME=$(docker ps --filter "ancestor=postgres" --format "{{.Names}}" | head -n 1)

if [ -z "$CONTAINER_NAME" ]; then
    # 尝试通过端口检测
    CONTAINER_NAME=$(docker ps --filter "publish=5432" --format "{{.Names}}" | head -n 1)
fi

if [ -z "$CONTAINER_NAME" ]; then
    echo "错误：未找到运行中的PostgreSQL容器"
    echo "请确保PostgreSQL容器正在运行"
    exit 1
fi

echo "找到PostgreSQL容器: $CONTAINER_NAME"
echo ""

# 函数：执行SQL查询
execute_sql() {
    local sql="$1"
    docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "$sql"
}

# 函数：执行SQL查询并返回结果
query_sql() {
    local sql="$1"
    docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -t -c "$sql" | xargs
}

echo "=========================================="
echo "步骤 1: 检查数据库连接"
echo "=========================================="

# 测试数据库连接
if docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1;" > /dev/null 2>&1; then
    echo "✓ 数据库连接成功"
else
    echo "✗ 数据库连接失败"
    echo "请检查数据库名称、用户名和密码是否正确"
    exit 1
fi

echo ""
echo "=========================================="
echo "步骤 2: 统计逻辑删除记录"
echo "=========================================="

# 统计学生表中的逻辑删除记录
STUDENT_COUNT=$(query_sql "SELECT COUNT(*) FROM stu_student_info WHERE del_flag = '2';")
echo "学生表 (stu_student_info) 中 del_flag='2' 的记录数: $STUDENT_COUNT"

# 统计用户表中的逻辑删除记录
USER_COUNT=$(query_sql "SELECT COUNT(*) FROM sys_user WHERE del_flag = '2';")
echo "用户表 (sys_user) 中 del_flag='2' 的记录数: $USER_COUNT"

echo ""

# 如果没有记录需要清除
if [ "$STUDENT_COUNT" -eq 0 ] && [ "$USER_COUNT" -eq 0 ]; then
    echo "没有需要清除的逻辑删除记录"
    exit 0
fi

echo "=========================================="
echo "步骤 3: 确认清除操作"
echo "=========================================="
echo "即将清除以下记录："
echo "  - 学生表: $STUDENT_COUNT 条记录"
echo "  - 用户表: $USER_COUNT 条记录"
echo ""
read -p "确认要清除这些记录吗？(yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "操作已取消"
    exit 0
fi

echo ""
echo "=========================================="
echo "步骤 4: 清除逻辑删除记录"
echo "=========================================="

# 清除学生表中的逻辑删除记录
if [ "$STUDENT_COUNT" -gt 0 ]; then
    echo "正在清除学生表中的逻辑删除记录..."
    execute_sql "DELETE FROM stu_student_info WHERE del_flag = '2';"
    echo "✓ 已清除 $STUDENT_COUNT 条学生记录"
fi

# 清除用户表中的逻辑删除记录
if [ "$USER_COUNT" -gt 0 ]; then
    echo "正在清除用户表中的逻辑删除记录..."
    execute_sql "DELETE FROM sys_user WHERE del_flag = '2';"
    echo "✓ 已清除 $USER_COUNT 条用户记录"
fi

echo ""
echo "=========================================="
echo "步骤 5: 验证清除结果"
echo "=========================================="

# 验证学生表
STUDENT_REMAINING=$(query_sql "SELECT COUNT(*) FROM stu_student_info WHERE del_flag = '2';")
echo "学生表剩余 del_flag='2' 记录: $STUDENT_REMAINING"

# 验证用户表
USER_REMAINING=$(query_sql "SELECT COUNT(*) FROM sys_user WHERE del_flag = '2';")
echo "用户表剩余 del_flag='2' 记录: $USER_REMAINING"

echo ""
if [ "$STUDENT_REMAINING" -eq 0 ] && [ "$USER_REMAINING" -eq 0 ]; then
    echo "✓ 所有逻辑删除记录已成功清除"
else
    echo "⚠ 警告：仍有逻辑删除记录未清除"
fi

echo ""
echo "=========================================="
echo "清除操作完成"
echo "=========================================="
