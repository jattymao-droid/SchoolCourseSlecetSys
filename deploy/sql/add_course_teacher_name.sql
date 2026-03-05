-- 课程表增加教师姓名列（支持直接输入教师姓名）
ALTER TABLE cou_course ADD COLUMN IF NOT EXISTS teacher_name VARCHAR(50);
COMMENT ON COLUMN cou_course.teacher_name IS '教师姓名（直接输入）';
