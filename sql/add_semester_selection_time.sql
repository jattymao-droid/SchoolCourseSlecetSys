-- 学期表添加选课时间范围字段
ALTER TABLE sys_semester ADD COLUMN IF NOT EXISTS selection_start_time TIMESTAMP;
ALTER TABLE sys_semester ADD COLUMN IF NOT EXISTS selection_end_time TIMESTAMP;
COMMENT ON COLUMN sys_semester.selection_start_time IS '选课开始时间';
COMMENT ON COLUMN sys_semester.selection_end_time IS '选课结束时间';
