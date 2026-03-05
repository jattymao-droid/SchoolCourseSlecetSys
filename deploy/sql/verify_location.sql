-- 验证 cou_course 表的 location 字段
-- 1. 检查列是否存在
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'cou_course' AND column_name = 'location';

-- 2. 若不存在则添加
ALTER TABLE cou_course ADD COLUMN IF NOT EXISTS location VARCHAR(100);
COMMENT ON COLUMN cou_course.location IS '上课地点';

-- 3. 查看现有课程是否有 location 数据
SELECT id, course_name, location FROM cou_course WHERE del_flag = '0' LIMIT 5;
