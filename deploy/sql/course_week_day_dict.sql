-- ----------------------------
-- 课程星期字典（1=周一 … 5=周五）
-- ----------------------------

INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark)
SELECT '课程星期', 'course_week_day', '0', 'admin', CURRENT_TIMESTAMP, '课程上课星期：1周一至5周五'
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_type WHERE dict_type = 'course_week_day');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 1, '周一', '1', 'course_week_day', '', 'primary', 'N', '0', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'course_week_day' AND dict_value = '1');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 2, '周二', '2', 'course_week_day', '', 'success', 'N', '0', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'course_week_day' AND dict_value = '2');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 3, '周三', '3', 'course_week_day', '', 'info', 'N', '0', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'course_week_day' AND dict_value = '3');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 4, '周四', '4', 'course_week_day', '', 'warning', 'N', '0', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'course_week_day' AND dict_value = '4');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 5, '周五', '5', 'course_week_day', '', 'danger', 'N', '0', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'course_week_day' AND dict_value = '5');
