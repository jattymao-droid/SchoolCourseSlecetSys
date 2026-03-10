-- 修复管理员账号
-- 问题：数据库中缺少 admin 用户（user_id=1）
-- 解决：插入默认的 admin 管理员账号

-- 1. 删除可能存在的 admin 用户（如果有）
DELETE FROM public.sys_user WHERE user_name = 'admin';

-- 2. 插入 admin 管理员账号
-- 用户名：admin
-- 密码：admin123（BCrypt 加密后的值）
-- 角色：超级管理员
INSERT INTO public.sys_user (
    user_id, 
    dept_id, 
    user_name, 
    nick_name, 
    user_type, 
    email, 
    phonenumber, 
    sex, 
    avatar, 
    password, 
    status, 
    del_flag, 
    login_ip, 
    login_date, 
    pwd_update_date, 
    create_by, 
    create_time, 
    update_by, 
    update_time, 
    remark
) VALUES (
    1,                                                          -- user_id
    103,                                                        -- dept_id (研发部门)
    'admin',                                                    -- user_name
    '管理员',                                                   -- nick_name
    '00',                                                       -- user_type (系统用户)
    'admin@ruoyi.com',                                         -- email
    '15888888888',                                             -- phonenumber
    '1',                                                        -- sex (男)
    '',                                                         -- avatar
    '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2',  -- password (admin123)
    '0',                                                        -- status (正常)
    '0',                                                        -- del_flag (未删除)
    '127.0.0.1',                                               -- login_ip
    NOW(),                                                      -- login_date
    NOW(),                                                      -- pwd_update_date
    'admin',                                                    -- create_by
    NOW(),                                                      -- create_time
    '',                                                         -- update_by
    NULL,                                                       -- update_time
    '管理员'                                                    -- remark
);

-- 3. 分配超级管理员角色（role_id=1）
DELETE FROM public.sys_user_role WHERE user_id = 1;
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (1, 1);

-- 4. 重置序列（确保后续插入的用户 ID 不会冲突）
SELECT setval('sys_user_user_id_seq', (SELECT MAX(user_id) FROM sys_user));

-- 5. 验证插入结果
SELECT user_id, user_name, nick_name, status, del_flag 
FROM public.sys_user 
WHERE user_name = 'admin';

-- 执行完成后，可以使用以下账号登录：
-- 用户名：admin
-- 密码：admin123
