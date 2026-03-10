#!/bin/bash

# 修复管理员账号脚本
# 用途：在数据库中添加缺失的 admin 管理员账号

echo "=========================================="
echo "修复管理员账号"
echo "=========================================="
echo ""

# 数据库配置
DB_CONTAINER="postgresql_d6wx-postgresql_D6Wx-1"
DB_USER="postgres"
DB_NAME="school-course"

# 检查 Docker 容器是否运行
echo "1. 检查 PostgreSQL 容器..."
if ! docker ps | grep -q "$DB_CONTAINER"; then
    echo "❌ 错误：PostgreSQL 容器未运行"
    echo "请先启动 PostgreSQL 容器"
    exit 1
fi
echo "✅ PostgreSQL 容器正在运行"
echo ""

# 检查数据库是否存在
echo "2. 检查数据库..."
if ! docker exec "$DB_CONTAINER" psql -U "$DB_USER" -lqt | cut -d \| -f 1 | grep -qw "$DB_NAME"; then
    echo "❌ 错误：数据库 $DB_NAME 不存在"
    echo "请先创建数据库或导入数据库备份"
    exit 1
fi
echo "✅ 数据库 $DB_NAME 存在"
echo ""

# 执行修复 SQL
echo "3. 执行修复 SQL..."
docker exec -i "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" << 'EOF'
-- 删除可能存在的 admin 用户
DELETE FROM public.sys_user WHERE user_name = 'admin';

-- 插入 admin 管理员账号
INSERT INTO public.sys_user (
    user_id, dept_id, user_name, nick_name, user_type, 
    email, phonenumber, sex, avatar, password, 
    status, del_flag, login_ip, login_date, pwd_update_date, 
    create_by, create_time, update_by, update_time, remark
) VALUES (
    1, 103, 'admin', '管理员', '00',
    'admin@ruoyi.com', '15888888888', '1', '', 
    '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2',
    '0', '0', '127.0.0.1', NOW(), NOW(),
    'admin', NOW(), '', NULL, '管理员'
);

-- 分配超级管理员角色
DELETE FROM public.sys_user_role WHERE user_id = 1;
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (1, 1);

-- 重置序列
SELECT setval('sys_user_user_id_seq', (SELECT MAX(user_id) FROM sys_user));
EOF

if [ $? -eq 0 ]; then
    echo "✅ SQL 执行成功"
else
    echo "❌ SQL 执行失败"
    exit 1
fi
echo ""

# 验证结果
echo "4. 验证修复结果..."
RESULT=$(docker exec "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" -t -c "SELECT user_id, user_name, nick_name, status FROM sys_user WHERE user_name = 'admin';")

if [ -z "$RESULT" ]; then
    echo "❌ 错误：admin 用户未找到"
    exit 1
fi

echo "✅ admin 用户已创建"
echo ""
echo "用户信息："
docker exec "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT user_id, user_name, nick_name, status, del_flag FROM sys_user WHERE user_name = 'admin';"
echo ""

# 检查角色分配
echo "5. 检查角色分配..."
docker exec "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT user_id, role_id FROM sys_user_role WHERE user_id = 1;"
echo ""

echo "=========================================="
echo "✅ 修复完成！"
echo "=========================================="
echo ""
echo "现在可以使用以下账号登录："
echo "  用户名：admin"
echo "  密码：admin123"
echo ""
echo "访问地址：http://xk.xmls.vip"
echo ""
