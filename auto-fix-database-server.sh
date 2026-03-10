#!/bin/bash

# ============================================
# PostgreSQL数据库自动修复脚本
# ============================================
# 用途：自动检测并修复数据库配置问题
# ============================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo ""
    echo -e "${CYAN}=========================================="
    echo "$1"
    echo -e "==========================================${NC}"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[⚠]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_step() {
    echo -e "${CYAN}[步骤 $1]${NC} $2"
}

print_header "PostgreSQL数据库自动修复工具"

# 检测PostgreSQL容器
print_step "1" "检测PostgreSQL容器"
CONTAINER_NAME=$(docker ps --filter "ancestor=postgres" --format "{{.Names}}" | head -n 1)

if [ -z "$CONTAINER_NAME" ]; then
    CONTAINER_NAME=$(docker ps --filter "publish=5432" --format "{{.Names}}" | head -n 1)
fi

if [ -z "$CONTAINER_NAME" ]; then
    print_error "未找到运行中的PostgreSQL容器"
    exit 1
fi

print_success "找到PostgreSQL容器: $CONTAINER_NAME"

# 检查数据库
print_step "2" "检查数据库状态"

# 检查 school-course 数据库
school_course_exists=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -lqt | cut -d \| -f 1 | grep -w "school-course" | wc -l)
if [ "$school_course_exists" -eq 1 ]; then
    school_course_tables=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -d "school-course" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';" 2>/dev/null | xargs || echo "0")
    print_info "school-course 数据库: 存在, $school_course_tables 个表"
else
    school_course_tables=0
    print_warning "school-course 数据库: 不存在"
fi

# 检查 ry_vue 数据库
ry_vue_exists=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -lqt | cut -d \| -f 1 | grep -w "ry_vue" | wc -l)
if [ "$ry_vue_exists" -eq 1 ]; then
    ry_vue_tables=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -d "ry_vue" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';" 2>/dev/null | xargs || echo "0")
    print_info "ry_vue 数据库: 存在, $ry_vue_tables 个表"
else
    ry_vue_tables=0
    print_warning "ry_vue 数据库: 不存在"
fi

# 分析问题
print_step "3" "分析问题"

PROBLEM_TYPE=""
CORRECT_DB=""

if [ "$school_course_tables" -gt 0 ]; then
    print_success "school-course 数据库有数据，配置正确"
    PROBLEM_TYPE="none"
    CORRECT_DB="school-course"
elif [ "$ry_vue_tables" -gt 0 ]; then
    print_warning "数据在 ry_vue 数据库中，但管理脚本配置为 school-course"
    PROBLEM_TYPE="wrong_db_name"
    CORRECT_DB="ry_vue"
elif [ "$school_course_exists" -eq 1 ] && [ "$school_course_tables" -eq 0 ]; then
    print_warning "school-course 数据库存在但是空的"
    PROBLEM_TYPE="empty_db"
    CORRECT_DB="school-course"
else
    print_error "未找到任何包含数据的数据库"
    PROBLEM_TYPE="no_data"
fi

# 提供解决方案
print_step "4" "提供解决方案"

case $PROBLEM_TYPE in
    "none")
        echo ""
        print_success "数据库配置正确，无需修复"
        echo ""
        print_info "你可以直接使用管理工具："
        echo "  ./manage-database-server.sh"
        exit 0
        ;;
        
    "wrong_db_name")
        echo ""
        print_warning "检测到数据库名称配置问题"
        echo ""
        echo "问题描述："
        echo "  - 实际数据在: ry_vue 数据库"
        echo "  - 管理脚本配置: school-course 数据库"
        echo ""
        echo "解决方案："
        echo "  1) 修改管理脚本连接到 ry_vue 数据库（推荐）"
        echo "  2) 从 ry_vue 复制数据到 school-course 数据库"
        echo "  3) 手动处理"
        echo ""
        read -p "请选择解决方案 (1-3): " choice
        
        case $choice in
            1)
                print_info "正在修改管理脚本..."
                
                # 修改所有相关脚本
                if [ -f "manage-database-server.sh" ]; then
                    sed -i 's/DB_NAME="school-course"/DB_NAME="ry_vue"/' manage-database-server.sh
                    print_success "已修改 manage-database-server.sh"
                fi
                
                if [ -f "clean-database-server.sh" ]; then
                    sed -i 's/DB_NAME="school-course"/DB_NAME="ry_vue"/' clean-database-server.sh
                    print_success "已修改 clean-database-server.sh"
                fi
                
                if [ -f "clean-deleted-records-server.sh" ]; then
                    sed -i 's/DB_NAME="school-course"/DB_NAME="ry_vue"/' clean-deleted-records-server.sh
                    print_success "已修改 clean-deleted-records-server.sh"
                fi
                
                echo ""
                print_success "修复完成！现在可以使用管理工具了"
                echo ""
                print_info "运行管理工具："
                echo "  ./manage-database-server.sh"
                ;;
                
            2)
                print_info "正在复制数据库..."
                
                # 导出 ry_vue
                print_info "导出 ry_vue 数据库..."
                docker exec -i "$CONTAINER_NAME" pg_dump -U postgres ry_vue > /tmp/ry_vue_backup.sql
                print_success "导出完成"
                
                # 删除并重建 school-course
                print_info "重建 school-course 数据库..."
                docker exec -i "$CONTAINER_NAME" psql -U postgres -c "DROP DATABASE IF EXISTS \"school-course\";" 2>/dev/null || true
                docker exec -i "$CONTAINER_NAME" psql -U postgres -c "CREATE DATABASE \"school-course\" OWNER postgres;"
                print_success "数据库重建完成"
                
                # 导入数据
                print_info "导入数据到 school-course..."
                docker exec -i "$CONTAINER_NAME" psql -U postgres -d school-course < /tmp/ry_vue_backup.sql
                print_success "数据导入完成"
                
                # 清理临时文件
                rm -f /tmp/ry_vue_backup.sql
                
                echo ""
                print_success "修复完成！"
                echo ""
                print_warning "请重启后端服务："
                echo "  /www/wwwroot/course-selection/backend/restart.sh"
                ;;
                
            3)
                print_info "已取消自动修复"
                echo ""
                echo "手动修复步骤："
                echo "1. 修改管理脚本："
                echo "   sed -i 's/DB_NAME=\"school-course\"/DB_NAME=\"ry_vue\"/' manage-database-server.sh"
                echo ""
                echo "2. 或者复制数据库："
                echo "   docker exec -i $CONTAINER_NAME pg_dump -U postgres ry_vue > backup.sql"
                echo "   docker exec -i $CONTAINER_NAME psql -U postgres -c 'DROP DATABASE IF EXISTS \"school-course\";'"
                echo "   docker exec -i $CONTAINER_NAME psql -U postgres -c 'CREATE DATABASE \"school-course\";'"
                echo "   docker exec -i $CONTAINER_NAME psql -U postgres -d school-course < backup.sql"
                ;;
                
            *)
                print_error "无效的选项"
                exit 1
                ;;
        esac
        ;;
        
    "empty_db")
        echo ""
        print_warning "检测到空数据库"
        echo ""
        echo "问题描述："
        echo "  - school-course 数据库存在但是空的"
        echo "  - 可能是数据导入失败"
        echo ""
        echo "解决方案："
        echo "  1) 从备份文件重新导入数据（推荐）"
        echo "  2) 手动处理"
        echo ""
        read -p "请选择解决方案 (1-2): " choice
        
        case $choice in
            1)
                # 查找备份文件
                BACKUP_FILE=""
                
                if [ -f "/root/deploy-server-20260309_200842/database_backup.dump" ]; then
                    BACKUP_FILE="/root/deploy-server-20260309_200842/database_backup.dump"
                elif [ -f "database_backup.dump" ]; then
                    BACKUP_FILE="database_backup.dump"
                elif [ -f "/root/database_backup.dump" ]; then
                    BACKUP_FILE="/root/database_backup.dump"
                fi
                
                if [ -z "$BACKUP_FILE" ]; then
                    print_error "未找到备份文件 database_backup.dump"
                    echo ""
                    echo "请手动指定备份文件路径："
                    read -p "备份文件路径: " BACKUP_FILE
                    
                    if [ ! -f "$BACKUP_FILE" ]; then
                        print_error "文件不存在: $BACKUP_FILE"
                        exit 1
                    fi
                fi
                
                print_info "找到备份文件: $BACKUP_FILE"
                print_info "正在导入数据..."
                
                docker exec -i "$CONTAINER_NAME" pg_restore -U postgres -d school-course -v < "$BACKUP_FILE" 2>&1 | grep -v "WARNING" || true
                
                print_success "数据导入完成"
                
                # 验证导入结果
                tables=$(docker exec -i "$CONTAINER_NAME" psql -U postgres -d "school-course" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='public';" 2>/dev/null | xargs || echo "0")
                
                if [ "$tables" -gt 0 ]; then
                    print_success "验证成功: 导入了 $tables 个表"
                    echo ""
                    print_warning "请重启后端服务："
                    echo "  /www/wwwroot/course-selection/backend/restart.sh"
                else
                    print_error "导入失败，数据库仍然是空的"
                fi
                ;;
                
            2)
                print_info "已取消自动修复"
                echo ""
                echo "手动导入步骤："
                echo "1. 找到备份文件 database_backup.dump"
                echo "2. 运行导入命令："
                echo "   docker exec -i $CONTAINER_NAME pg_restore -U postgres -d school-course -v < database_backup.dump"
                ;;
                
            *)
                print_error "无效的选项"
                exit 1
                ;;
        esac
        ;;
        
    "no_data")
        echo ""
        print_error "未找到任何包含数据的数据库"
        echo ""
        echo "可能的原因："
        echo "  1. 数据库从未导入过数据"
        echo "  2. 数据库被意外清空"
        echo "  3. 使用了其他数据库名称"
        echo ""
        echo "建议操作："
        echo "  1. 检查是否有数据库备份文件"
        echo "  2. 查看所有数据库："
        echo "     docker exec -i $CONTAINER_NAME psql -U postgres -c '\\l'"
        echo "  3. 如果有备份，运行导入命令"
        ;;
esac

print_header "修复完成"
