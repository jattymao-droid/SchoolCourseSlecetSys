#!/bin/bash

# ============================================
# 清除服务器PostgreSQL数据库数据脚本
# ============================================
# 用途：清除指定表的数据或所有业务数据
# 环境：服务器上的Docker PostgreSQL容器
# 数据库：school-course
# 用户：postgres
# 密码：mm5621528
# ============================================

set -e  # 遇到错误立即退出

echo "=========================================="
echo "PostgreSQL数据库清理脚本"
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
echo "步骤 2: 选择清理模式"
echo "=========================================="
echo "请选择要执行的清理操作："
echo "  1) 仅清除逻辑删除记录 (del_flag='2')"
echo "  2) 清除所有学生数据"
echo "  3) 清除所有课程数据"
echo "  4) 清除所有选课数据"
echo "  5) 清除所有业务数据 (学生+课程+选课)"
echo "  6) 退出"
echo ""
read -p "请输入选项 (1-6): " OPTION

case $OPTION in
    1)
        echo ""
        echo "=========================================="
        echo "模式 1: 清除逻辑删除记录"
        echo "=========================================="
        
        # 统计逻辑删除记录
        STUDENT_COUNT=$(query_sql "SELECT COUNT(*) FROM stu_student_info WHERE del_flag = '2';")
        USER_COUNT=$(query_sql "SELECT COUNT(*) FROM sys_user WHERE del_flag = '2';")
        
        echo "学生表 (stu_student_info) 中 del_flag='2' 的记录数: $STUDENT_COUNT"
        echo "用户表 (sys_user) 中 del_flag='2' 的记录数: $USER_COUNT"
        echo ""
        
        if [ "$STUDENT_COUNT" -eq 0 ] && [ "$USER_COUNT" -eq 0 ]; then
            echo "没有需要清除的逻辑删除记录"
            exit 0
        fi
        
        read -p "确认清除这些记录吗？(yes/no): " CONFIRM
        if [ "$CONFIRM" != "yes" ]; then
            echo "操作已取消"
            exit 0
        fi
        
        echo "正在清除逻辑删除记录..."
        [ "$STUDENT_COUNT" -gt 0 ] && execute_sql "DELETE FROM stu_student_info WHERE del_flag = '2';"
        [ "$USER_COUNT" -gt 0 ] && execute_sql "DELETE FROM sys_user WHERE del_flag = '2';"
        echo "✓ 清除完成"
        ;;
        
    2)
        echo ""
        echo "=========================================="
        echo "模式 2: 清除所有学生数据"
        echo "=========================================="
        
        STUDENT_COUNT=$(query_sql "SELECT COUNT(*) FROM stu_student_info;")
        echo "学生表总记录数: $STUDENT_COUNT"
        echo ""
        
        if [ "$STUDENT_COUNT" -eq 0 ]; then
            echo "学生表中没有数据"
            exit 0
        fi
        
        read -p "确认清除所有学生数据吗？(yes/no): " CONFIRM
        if [ "$CONFIRM" != "yes" ]; then
            echo "操作已取消"
            exit 0
        fi
        
        echo "正在清除学生数据..."
        # 先删除选课记录
        execute_sql "DELETE FROM stu_course_selection WHERE student_id IN (SELECT id FROM stu_student_info);"
        # 删除学生记录
        execute_sql "DELETE FROM stu_student_info;"
        # 删除关联的用户记录（学生用户类型为'01'）
        execute_sql "DELETE FROM sys_user WHERE user_type = '01';"
        echo "✓ 清除完成"
        ;;
        
    3)
        echo ""
        echo "=========================================="
        echo "模式 3: 清除所有课程数据"
        echo "=========================================="
        
        COURSE_COUNT=$(query_sql "SELECT COUNT(*) FROM sys_course;")
        echo "课程表总记录数: $COURSE_COUNT"
        echo ""
        
        if [ "$COURSE_COUNT" -eq 0 ]; then
            echo "课程表中没有数据"
            exit 0
        fi
        
        read -p "确认清除所有课程数据吗？(yes/no): " CONFIRM
        if [ "$CONFIRM" != "yes" ]; then
            echo "操作已取消"
            exit 0
        fi
        
        echo "正在清除课程数据..."
        # 先删除选课记录
        execute_sql "DELETE FROM stu_course_selection;"
        # 删除课程记录
        execute_sql "DELETE FROM sys_course;"
        echo "✓ 清除完成"
        ;;
        
    4)
        echo ""
        echo "=========================================="
        echo "模式 4: 清除所有选课数据"
        echo "=========================================="
        
        SELECTION_COUNT=$(query_sql "SELECT COUNT(*) FROM stu_course_selection;")
        echo "选课表总记录数: $SELECTION_COUNT"
        echo ""
        
        if [ "$SELECTION_COUNT" -eq 0 ]; then
            echo "选课表中没有数据"
            exit 0
        fi
        
        read -p "确认清除所有选课数据吗？(yes/no): " CONFIRM
        if [ "$CONFIRM" != "yes" ]; then
            echo "操作已取消"
            exit 0
        fi
        
        echo "正在清除选课数据..."
        execute_sql "DELETE FROM stu_course_selection;"
        echo "✓ 清除完成"
        ;;
        
    5)
        echo ""
        echo "=========================================="
        echo "模式 5: 清除所有业务数据"
        echo "=========================================="
        
        STUDENT_COUNT=$(query_sql "SELECT COUNT(*) FROM stu_student_info;")
        COURSE_COUNT=$(query_sql "SELECT COUNT(*) FROM sys_course;")
        SELECTION_COUNT=$(query_sql "SELECT COUNT(*) FROM stu_course_selection;")
        
        echo "即将清除以下数据："
        echo "  - 学生记录: $STUDENT_COUNT 条"
        echo "  - 课程记录: $COURSE_COUNT 条"
        echo "  - 选课记录: $SELECTION_COUNT 条"
        echo ""
        echo "⚠️  警告：此操作将清除所有业务数据，无法恢复！"
        echo ""
        
        read -p "确认清除所有业务数据吗？(yes/no): " CONFIRM
        if [ "$CONFIRM" != "yes" ]; then
            echo "操作已取消"
            exit 0
        fi
        
        echo "正在清除所有业务数据..."
        # 按照外键依赖顺序删除
        execute_sql "DELETE FROM stu_course_selection;"
        execute_sql "DELETE FROM stu_student_info;"
        execute_sql "DELETE FROM sys_course;"
        execute_sql "DELETE FROM sys_user WHERE user_type = '01';"
        echo "✓ 清除完成"
        ;;
        
    6)
        echo "退出脚本"
        exit 0
        ;;
        
    *)
        echo "无效的选项"
        exit 1
        ;;
esac

echo ""
echo "=========================================="
echo "清理操作完成"
echo "=========================================="
