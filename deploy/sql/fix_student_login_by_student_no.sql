-- 将学生用户的登录账号改为学号，支持学号+密码登录
-- 执行后：学生可用 202401001 + admin123 登录（原为 student01 + admin123）
UPDATE sys_user u
SET user_name = s.student_no
FROM stu_student_info s
WHERE u.user_id = s.user_id
  AND u.user_type = '01'
  AND s.del_flag = '0';
