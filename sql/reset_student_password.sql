-- 重置学生密码为 admin123（BCrypt 加密）
-- 用于修复密码不匹配导致的登录失败
UPDATE sys_user u
SET password = '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2'
FROM stu_student_info s
WHERE u.user_id = s.user_id
  AND u.user_type = '01'
  AND s.del_flag = '0';
