-- ----------------------------
-- 学生默认密码配置（在 sys_config 中）
-- config_value 取值：last6=学号后6位（不足用学号）| full=学号全文 | 或直接填固定密码如123456
-- ----------------------------
INSERT INTO sys_config (config_name, config_key, config_value, config_type, create_by, create_time, remark)
SELECT '学生管理-默认密码规则', 'course.default_password', 'last6', 'Y', 'admin', CURRENT_TIMESTAMP, 'last6=学号后6位(不足用学号) full=学号全文 或填固定密码如123456'
WHERE NOT EXISTS (SELECT 1 FROM sys_config WHERE config_key = 'course.default_password');
