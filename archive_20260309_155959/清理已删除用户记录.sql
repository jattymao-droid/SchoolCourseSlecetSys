-- 清理已逻辑删除的用户记录
-- 用于解决学生删除后无法重新导入的问题

-- 1. 查看有多少已删除的用户（学生账号）
SELECT COUNT(*) as deleted_student_count
FROM sys_user
WHERE del_flag = '2' AND user_type = '01';

-- 2. 查看这些已删除用户的详细信息
SELECT user_id, user_name, nick_name, user_type, create_time, update_time
FROM sys_user
WHERE del_flag = '2' AND user_type = '01'
ORDER BY user_id;

-- 3. 物理删除这些已逻辑删除的学生用户记录
-- 注意：执行前请确认这些记录确实可以删除
DELETE FROM sys_user_role WHERE user_id IN (
    SELECT user_id FROM sys_user WHERE del_flag = '2' AND user_type = '01'
);

DELETE FROM sys_user_post WHERE user_id IN (
    SELECT user_id FROM sys_user WHERE del_flag = '2' AND user_type = '01'
);

DELETE FROM sys_user WHERE del_flag = '2' AND user_type = '01';

-- 4. 验证清理结果
SELECT COUNT(*) as remaining_deleted_students
FROM sys_user
WHERE del_flag = '2' AND user_type = '01';

-- 应该返回 0
