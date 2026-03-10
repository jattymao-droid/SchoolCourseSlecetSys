#!/bin/bash

# ============================================
# PostgreSQL数据库管理脚本
# ============================================
# 用途：管理服务器上PostgreSQL数据库的所有表
# 环境：服务器上的Docker PostgreSQL容器
# 数据库：school-course
# 用户：postgres
# 密码：mm5621528
# ============================================

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 配置变量
DB_NAME="school-course"
DB_USER="postgres"
DB_PASSWORD="mm5621528"
CONTAINER_NAME=""

# 函数：打印带颜色的消息
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

print_header() {
    echo ""
    echo "=========================================="
    echo "$1"
    echo "=========================================="
}

# 函数：检测PostgreSQL容器
detect_container() {
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
}

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

# 函数：执行SQL查询并返回多行结果
query_sql_multi() {
    local sql="$1"
    docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -t -c "$sql"
}

# 函数：测试数据库连接
test_connection() {
    if docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1;" > /dev/null 2>&1; then
        print_success "数据库连接成功"
        return 0
    else
        print_error "数据库连接失败"
        return 1
    fi
}

# 函数：列出所有表
list_tables() {
    print_header "数据库表列表"
    echo ""
    docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "
        SELECT 
            schemaname as schema,
            tablename as table_name,
            pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
        FROM pg_tables 
        WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
        ORDER BY schemaname, tablename;
    "
}

# 函数：查看表结构
view_table_structure() {
    local table_name="$1"
    print_header "表结构: $table_name"
    echo ""
    docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "\d $table_name"
}

# 函数：查看表数据统计
view_table_stats() {
    local table_name="$1"
    print_header "表统计: $table_name"
    echo ""
    
    # 获取记录数
    local count=$(query_sql "SELECT COUNT(*) FROM $table_name;")
    echo "总记录数: $count"
    
    # 获取表大小
    local size=$(query_sql "SELECT pg_size_pretty(pg_total_relation_size('$table_name'));")
    echo "表大小: $size"
    
    # 如果表有del_flag字段，统计逻辑删除记录
    local has_del_flag=$(query_sql "SELECT COUNT(*) FROM information_schema.columns WHERE table_name='$table_name' AND column_name='del_flag';")
    if [ "$has_del_flag" -gt 0 ]; then
        local deleted_count=$(query_sql "SELECT COUNT(*) FROM $table_name WHERE del_flag='2';")
        echo "逻辑删除记录数: $deleted_count"
        local active_count=$(query_sql "SELECT COUNT(*) FROM $table_name WHERE del_flag='0';")
        echo "活跃记录数: $active_count"
    fi
}

# 函数：查看表数据（前N行）
view_table_data() {
    local table_name="$1"
    local limit="${2:-10}"
    print_header "表数据: $table_name (前 $limit 行)"
    echo ""
    docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT * FROM $table_name LIMIT $limit;"
}

# 函数：清空表数据
truncate_table() {
    local table_name="$1"
    print_warning "即将清空表: $table_name"
    read -p "确认清空此表吗？(yes/no): " confirm
    
    if [ "$confirm" = "yes" ]; then
        execute_sql "TRUNCATE TABLE $table_name CASCADE;"
        print_success "表 $table_name 已清空"
    else
        print_info "操作已取消"
    fi
}

# 函数：删除表
drop_table() {
    local table_name="$1"
    print_error "即将删除表: $table_name (此操作不可恢复！)"
    read -p "确认删除此表吗？(yes/no): " confirm
    
    if [ "$confirm" = "yes" ]; then
        execute_sql "DROP TABLE $table_name CASCADE;"
        print_success "表 $table_name 已删除"
    else
        print_info "操作已取消"
    fi
}

# 函数：备份表数据
backup_table() {
    local table_name="$1"
    local backup_file="backup_${table_name}_$(date +%Y%m%d_%H%M%S).sql"
    
    print_info "正在备份表 $table_name 到 $backup_file..."
    docker exec -i "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" -t "$table_name" > "$backup_file"
    print_success "备份完成: $backup_file"
}

# 函数：执行自定义SQL
execute_custom_sql() {
    print_header "执行自定义SQL"
    echo ""
    echo "请输入SQL语句 (输入 'exit' 退出):"
    echo ""
    
    while true; do
        read -p "SQL> " sql
        
        if [ "$sql" = "exit" ]; then
            break
        fi
        
        if [ -z "$sql" ]; then
            continue
        fi
        
        echo ""
        execute_sql "$sql" || print_error "SQL执行失败"
        echo ""
    done
}

# 函数：查看数据库信息
view_database_info() {
    print_header "数据库信息"
    echo ""
    
    echo "数据库名称: $DB_NAME"
    echo "数据库用户: $DB_USER"
    echo ""
    
    # 数据库大小
    local db_size=$(query_sql "SELECT pg_size_pretty(pg_database_size('$DB_NAME'));")
    echo "数据库大小: $db_size"
    
    # 表数量
    local table_count=$(query_sql "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';")
    echo "表数量: $table_count"
    
    # 连接数
    local connections=$(query_sql "SELECT COUNT(*) FROM pg_stat_activity WHERE datname='$DB_NAME';")
    echo "当前连接数: $connections"
    
    echo ""
    print_info "数据库版本信息:"
    docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT version();"
}

# 函数：清除逻辑删除记录
clean_deleted_records() {
    print_header "清除逻辑删除记录"
    echo ""
    
    # 查找所有有del_flag字段的表
    local tables=$(query_sql_multi "
        SELECT DISTINCT table_name 
        FROM information_schema.columns 
        WHERE table_schema='public' AND column_name='del_flag'
        ORDER BY table_name;
    ")
    
    if [ -z "$tables" ]; then
        print_info "没有找到包含 del_flag 字段的表"
        return
    fi
    
    echo "找到以下包含 del_flag 字段的表:"
    echo "$tables"
    echo ""
    
    # 统计每个表的逻辑删除记录
    local total_deleted=0
    while IFS= read -r table; do
        table=$(echo "$table" | xargs)  # 去除空格
        if [ -n "$table" ]; then
            local count=$(query_sql "SELECT COUNT(*) FROM $table WHERE del_flag='2';")
            if [ "$count" -gt 0 ]; then
                echo "  $table: $count 条逻辑删除记录"
                total_deleted=$((total_deleted + count))
            fi
        fi
    done <<< "$tables"
    
    echo ""
    echo "总计: $total_deleted 条逻辑删除记录"
    echo ""
    
    if [ "$total_deleted" -eq 0 ]; then
        print_info "没有需要清除的逻辑删除记录"
        return
    fi
    
    read -p "确认清除所有逻辑删除记录吗？(yes/no): " confirm
    
    if [ "$confirm" = "yes" ]; then
        while IFS= read -r table; do
            table=$(echo "$table" | xargs)
            if [ -n "$table" ]; then
                local count=$(query_sql "SELECT COUNT(*) FROM $table WHERE del_flag='2';")
                if [ "$count" -gt 0 ]; then
                    execute_sql "DELETE FROM $table WHERE del_flag='2';"
                    print_success "已清除 $table 表中的 $count 条记录"
                fi
            fi
        done <<< "$tables"
        print_success "所有逻辑删除记录已清除"
    else
        print_info "操作已取消"
    fi
}

# 函数：表管理菜单
table_management_menu() {
    local table_name="$1"
    
    while true; do
        print_header "表管理: $table_name"
        echo ""
        echo "1) 查看表结构"
        echo "2) 查看表统计"
        echo "3) 查看表数据 (前10行)"
        echo "4) 查看表数据 (前50行)"
        echo "5) 查看表数据 (自定义行数)"
        echo "6) 清空表数据"
        echo "7) 删除表"
        echo "8) 备份表"
        echo "9) 返回上级菜单"
        echo ""
        read -p "请选择操作 (1-9): " choice
        
        case $choice in
            1) view_table_structure "$table_name" ;;
            2) view_table_stats "$table_name" ;;
            3) view_table_data "$table_name" 10 ;;
            4) view_table_data "$table_name" 50 ;;
            5)
                read -p "请输入要查看的行数: " limit
                view_table_data "$table_name" "$limit"
                ;;
            6) truncate_table "$table_name" ;;
            7)
                drop_table "$table_name"
                break
                ;;
            8) backup_table "$table_name" ;;
            9) break ;;
            *) print_error "无效的选项" ;;
        esac
        
        echo ""
        read -p "按回车键继续..."
    done
}

# 函数：选择表进行管理
select_table_menu() {
    print_header "选择要管理的表"
    echo ""
    
    # 获取所有表名
    local tables=$(query_sql_multi "
        SELECT tablename 
        FROM pg_tables 
        WHERE schemaname='public'
        ORDER BY tablename;
    ")
    
    if [ -z "$tables" ]; then
        print_info "数据库中没有表"
        return
    fi
    
    # 显示表列表
    local i=1
    declare -a table_array
    while IFS= read -r table; do
        table=$(echo "$table" | xargs)
        if [ -n "$table" ]; then
            table_array[$i]="$table"
            echo "$i) $table"
            i=$((i + 1))
        fi
    done <<< "$tables"
    
    echo "0) 返回主菜单"
    echo ""
    read -p "请选择表 (0-$((i-1))): " choice
    
    if [ "$choice" = "0" ]; then
        return
    fi
    
    if [ "$choice" -ge 1 ] && [ "$choice" -lt "$i" ]; then
        table_management_menu "${table_array[$choice]}"
    else
        print_error "无效的选项"
    fi
}

# 主菜单
main_menu() {
    while true; do
        print_header "PostgreSQL数据库管理工具"
        echo ""
        echo "数据库: $DB_NAME"
        echo "容器: $CONTAINER_NAME"
        echo ""
        echo "1)  查看数据库信息"
        echo "2)  列出所有表"
        echo "3)  管理指定表"
        echo "4)  清除逻辑删除记录"
        echo "5)  执行自定义SQL"
        echo "6)  备份整个数据库"
        echo "7)  查看数据库连接"
        echo "8)  查看表空间使用情况"
        echo "9)  优化数据库 (VACUUM)"
        echo "10) 退出"
        echo ""
        read -p "请选择操作 (1-10): " choice
        
        case $choice in
            1) view_database_info ;;
            2) list_tables ;;
            3) select_table_menu ;;
            4) clean_deleted_records ;;
            5) execute_custom_sql ;;
            6)
                local backup_file="backup_${DB_NAME}_$(date +%Y%m%d_%H%M%S).sql"
                print_info "正在备份数据库到 $backup_file..."
                docker exec -i "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" > "$backup_file"
                print_success "备份完成: $backup_file"
                ;;
            7)
                print_header "数据库连接"
                docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "
                    SELECT pid, usename, application_name, client_addr, state, query_start 
                    FROM pg_stat_activity 
                    WHERE datname='$DB_NAME';
                "
                ;;
            8)
                print_header "表空间使用情况"
                docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME" -c "
                    SELECT 
                        schemaname,
                        tablename,
                        pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as total_size,
                        pg_size_pretty(pg_relation_size(schemaname||'.'||tablename)) as table_size,
                        pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename) - pg_relation_size(schemaname||'.'||tablename)) as index_size
                    FROM pg_tables 
                    WHERE schemaname='public'
                    ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC;
                "
                ;;
            9)
                print_info "正在优化数据库..."
                execute_sql "VACUUM ANALYZE;"
                print_success "数据库优化完成"
                ;;
            10)
                print_info "退出程序"
                exit 0
                ;;
            *)
                print_error "无效的选项"
                ;;
        esac
        
        echo ""
        read -p "按回车键继续..."
    done
}

# 主程序
clear
print_header "PostgreSQL数据库管理工具"
echo ""

# 检测容器
detect_container

# 测试连接
if ! test_connection; then
    exit 1
fi

# 显示主菜单
main_menu
