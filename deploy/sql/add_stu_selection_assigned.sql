-- 学生选课记录表增加 assigned 字段：1=管理员指定 0=学生自选
-- 管理员指定的课程会加入选课车且不可删除
ALTER TABLE stu_selection ADD COLUMN IF NOT EXISTS assigned SMALLINT DEFAULT 0;
COMMENT ON COLUMN stu_selection.assigned IS '1管理员指定 0学生自选';
