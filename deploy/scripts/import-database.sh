#!/bin/bash

# 导入完整数据库脚本
# 用途：删除并重建数据库，然后导入完整的 SQL 备份

echo "=========================================="
echo "导入完整数据库"
echo "=========================================="
echo ""

# 数据库配置
DB_CONTAINER="postgresql_d6wx-postgresql_D6Wx-1"
DB_USER="postgres"
DB_NAME="school-course"
SQL_FILE="/www/wwwroot/xk.xmls.vip/sql/complete-database.sql"

# 检查 SQL 文件是否存在
if [ ! -f "$SQL_FILE" ]; then
    echo "❌ 错误：SQL 文件不存在: $SQL_FILE"
    echo ""
    echo "请先上传 SQL 文件到服务器："
    echo "  本地文件: SchoolCourseSlecetSys/deploy/sql/complete-database.sql"
    echo "  服务器路径: $SQL_FILE"
    exit 1
fi

echo "✅ 找到 SQL 文件: $SQL_FILE"
FILE_SIZE=$(du -h "$SQL_FILE" | cut -f1)
echo "   文件大小: $FILE_SIZE"
echo ""

# 检查 Docker 容器是否运行
echo "1. 检查 PostgreSQL 容器..."
if ! docker ps | grep -q "$DB_CONTAINER"; then
    echo "❌ 错误：PostgreSQL 容器未运行"
    echo "请先启动 PostgreSQL 容器"
    exit 1
fi
echo "✅ PostgreSQL 容器正在运行"
echo ""

# 备份现有数据库（如果存在）
echo "2. 备份现有数据库（如果存在）..."
if docker exec "$DB_CONTAINER" psql -U "$DB_USER" -lqt | cut -d \| -f 1 | grep -qw "$DB_NAME"; then
    BACKUP_FILE="/tmp/school-course-backup-$(date +%Y%m%d_%H%M%S).sql"
    echo "   正在备份到: $BACKUP_FILE"
    docker exec "$DB_CONTAINER" pg_dump -U "$DB_USER" "$DB_NAME" > "$BACKUP_FILE" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "✅ 备份成功: $BACKUP_FILE"
    else
        echo "⚠️  备份失败，继续执行..."
    fi
else
    echo "   数据库不存在，跳过备份"
fi
echo ""

# 删除现有数据库
echo "3. 删除现有数据库..."
# 先断开所有连接
docker exec "$DB_CONTAINER" psql -U "$DB_USER" -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME' AND pid <> pg_backend_pid();" 2>/dev/null
# 然后删除数据库
docker exec "$DB_CONTAINER" psql -U "$DB_USER" -c "DROP DATABASE IF EXISTS \"$DB_NAME\";" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✅ 数据库已删除"
else
    echo "⚠️  删除失败或数据库不存在"
fi
echo ""

# 创建新数据库
echo "4. 创建新数据库..."
docker exec "$DB_CONTAINER" psql -U "$DB_USER" -c "CREATE DATABASE \"$DB_NAME\" WITH ENCODING='UTF8';"
if [ $? -eq 0 ]; then
    echo "✅ 数据库已创建"
else
    echo "❌ 创建数据库失败"
    exit 1
fi
echo ""

# 导入 SQL 文件
echo "5. 导入 SQL 文件..."
echo "   这可能需要几分钟，请耐心等待..."
echo ""

docker exec -i "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" < "$SQL_FILE"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ SQL 文件导入成功"
else
    echo ""
    echo "❌ SQL 文件导入失败"
    exit 1
fi
echo ""

# 验证导入结果
echo "6. 验证导入结果..."
echo ""

# 检查表数量
TABLE_COUNT=$(docker exec "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';" | tr -d ' ')
echo "   表数量: $TABLE_COUNT"

if [ "$TABLE_COUNT" -lt 30 ]; then
    echo "⚠️  警告：表数量少于预期（应该有 39 个表）"
else
    echo "✅ 表数量正常"
fi
echo ""

# 检查 admin 用户
echo "   检查 admin 用户..."
ADMIN_USER=$(docker exec "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT user_name FROM sys_user WHERE user_name = 'admin';" | tr -d ' ')

if [ "$ADMIN_USER" = "admin" ]; then
    echo "✅ admin 用户存在"
    docker exec "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT user_id, user_name, nick_name, status FROM sys_user WHERE user_name = 'admin';"
else
    echo "❌ admin 用户不存在"
fi
echo ""

# 检查 sys_menu 表
echo "   检查 sys_menu 表..."
MENU_COUNT=$(docker exec "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT COUNT(*) FROM sys_menu;" | tr -d ' ')
echo "   菜单数量: $MENU_COUNT"

if [ "$MENU_COUNT" -gt 0 ]; then
    echo "✅ sys_menu 表有数据"
else
    echo "❌ sys_menu 表为空"
fi
echo ""

echo "=========================================="
echo "✅ 数据库导入完成！"
echo "=========================================="
echo ""
echo "下一步："
echo "1. 重启后端服务："
echo "   cd /www/wwwroot/xk.xmls.vip/backend"
echo "   ./restart.sh"
echo ""
echo "2. 查看后端日志："
echo "   tail -f /www/wwwroot/xk.xmls.vip/backend/backend.log"
echo ""
echo "3. 测试登录："
echo "   访问: http://xk.xmls.vip"
echo "   用户名: admin"
echo "   密码: admin123"
echo ""
