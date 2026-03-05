-- 课程表添加"上课地点"字段，放在教师相关字段之后
ALTER TABLE cou_course ADD COLUMN IF NOT EXISTS location VARCHAR(100);
COMMENT ON COLUMN cou_course.location IS '上课地点';
