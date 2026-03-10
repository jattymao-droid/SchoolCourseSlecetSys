#!/bin/bash

# ============================================
# PostgreSQL数据库诊断脚本
# ============================================
# 用途：诊断服务器上PostgreSQL数据库的实际使用情况
# ============================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo ""
    echo "=========================================="
    echo "$1"
    echo "=========================================="
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header "PostgreSQL数据库诊断工具"

# 检测PostgreSQL容器
print_info "正在检测PostgreSQL容器..."
CONTAINER_NAME=$(docker ps --filter "ancestor=postgres" --format "{{.Names}}" | head -n 1)

if [ -z "$CONTAINER_NAME" ]; then
    CONTAINER_NAME=$(docker ps --filter "publish=5432" --format "{{.Names}}" | head -n 1)
fi

if [ -z "$CONTAINER_NAME" ]; then
    print_error "未找到运行中的PostgreSQL容器"
    exit 1
fi

print_success "找到PostgreSQL容器: $CONTAINER_NAME"

# 1. 列出所有数据库
print_header "1. 所有数据库列表"
docker exec -i "$CONTAINER_NAME" psql -U postgres -c "
    SELECT 
        datname as database_name,
        pg_size_pretty(pg_database_size(datname)) as size,
        (SELECT count(*) FROM pg_stat_activity WHERE datname = d.datname) as connections
    FROM pg_database d
    WHERE datistemplate = false
    ORDER BY pg_database_size(datname) DESC;
"

# 2. 检查每个数据库的表数量
print_header "2. 各数据库表数量统计"

# 获取所有非模板数据库
databases=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -t -c "SELECT datname FROM pg_database WHERE datistemplate = false AND datname != 'postgres';")

for db in $databases; do
    db=$(echo "$db" | xargs)  # 去除空格
    if [ -n "$db" ]; then
        table_count=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -d "$db" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';" 2>/dev/null | xargs || echo "0")
        
        if [ "$table_count" -gt 0 ]; then
            print_success "数据库 '$db': $table_count 个表"
        else
            print_warning "数据库 '$db': 0 个表 (空数据库)"
        fi
    fi
done

# 3. 检查当前活动连接
print_header "3. 当前数据库连接"
docker exec -i "$CONTAINER_NAME" psql -U postgres -c "
    SELECT 
        datname as database,
        usename as user,
        application_name,
        client_addr,
        state,
        query_start
    FROM pg_stat_activity 
    WHERE datname IS NOT NULL
    ORDER BY datname, query_start DESC;
"

# 4. 检查后端应用进程
print_header "4. 后端应用进程"
if ps aux | grep -q "[r]uoyi-admin.jar"; then
    print_success "后端应用正在运行"
    ps aux | grep "[r]uoyi-admin.jar" | awk '{print "PID: " $2 ", 启动时间: " $9}'
    
    # 尝试查看后端日志中的数据库连接信息
    if [ -f "/www/wwwroot/course-selection/logs/backend.log" ]; then
        print_info "后端日志中的数据库连接信息:"
        grep -i "jdbc:postgresql" /www/wwwroot/course-selection/logs/backend.log | tail -n 5 || print_warning "未找到数据库连接信息"
    fi
else
    print_warning "后端应用未运行"
fi

# 5. 检查配置文件
print_header "5. 后端配置文件检查"
if [ -f "/www/wwwroot/course-selection/backend/ruoyi-admin.jar" ]; then
    print_info "检查JAR包中的数据库配置..."
    unzip -p /www/wwwroot/course-selection/backend/ruoyi-admin.jar BOOT-INF/classes/application-druid-prod.yml 2>/dev/null | grep -A 2 "url:" || print_warning "无法读取配置文件"
else
    print_warning "未找到后端JAR包"
fi

# 6. 详细检查每个数据库的表结构
print_header "6. 数据库详细信息"

for db in $databases; do
    db=$(echo "$db" | xargs)
    if [ -n "$db" ]; then
        table_count=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -d "$db" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';" 2>/dev/null | xargs || echo "0")
        
        if [ "$table_count" -gt 0 ]; then
            echo ""
            print_info "数据库: $db"
            docker exec -i "$CONTAINER_NAME" psql -U postgres -d "$db" -c "
                SELECT 
                    schemaname,
                    tablename,
                    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
                FROM pg_tables 
                WHERE schemaname='public'
                ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC
                LIMIT 10;
            " 2>/dev/null
        fi
    fi
done

# 7. 生成诊断报告
print_header "7. 诊断总结"

echo ""
print_info "根据以上信息，请确认："
echo ""
echo "1. 哪个数据库包含了实际的业务数据？"
echo "   - 查看上面的表数量统计"
echo "   - 包含表的数据库才是实际使用的数据库"
echo ""
echo "2. 后端应用实际连接的是哪个数据库？"
echo "   - 查看当前数据库连接部分"
echo "   - 查看后端配置文件部分"
echo ""
echo "3. 如果发现数据库名称不匹配："
echo "   - 修改 manage-database-server.sh 中的 DB_NAME 变量"
echo "   - 或者重新导入数据到正确的数据库"
echo ""

# 8. 提供修复建议
print_header "8. 修复建议"

# 检查 school-course 数据库
school_course_tables=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -d "school-course" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';" 2>/dev/null | xargs || echo "0")

# 检查 ry_vue 数据库
ry_vue_tables=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -d "ry_vue" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';" 2>/dev/null | xargs || echo "0")

echo ""
if [ "$school_course_tables" -eq 0 ] && [ "$ry_vue_tables" -gt 0 ]; then
    print_warning "发现问题: school-course 数据库是空的，但 ry_vue 数据库有 $ry_vue_tables 个表"
    echo ""
    echo "建议操作："
    echo "1. 修改数据库管理脚本连接到 ry_vue 数据库："
    echo "   sed -i 's/DB_NAME=\"school-course\"/DB_NAME=\"ry_vue\"/' manage-database-server.sh"
    echo ""
    echo "2. 或者重新导入数据到 school-course 数据库："
    echo "   cd /root/deploy-server-20260309_200842"
    echo "   docker exec -i $CONTAINER_NAME pg_restore -U postgres -d school-course -v < database_backup.dump"
    echo ""
elif [ "$school_course_tables" -gt 0 ]; then
    print_success "school-course 数据库包含 $school_course_tables 个表，配置正确"
elif [ "$ry_vue_tables" -gt 0 ]; then
    print_success "ry_vue 数据库包含 $ry_vue_tables 个表"
    print_info "如果这是实际使用的数据库，请修改管理脚本"
else
    print_error "未找到包含数据的数据库，可能需要重新导入数据"
fi

echo ""
print_header "诊断完成"
echo ""
