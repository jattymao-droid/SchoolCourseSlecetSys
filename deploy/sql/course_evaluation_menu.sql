-- ----------------------------
-- 评价管理菜单、字典
-- 在 course_selection_init.sql、course_selection_menu.sql 之后执行
-- ----------------------------

-- 字典：评价题目状态
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark)
SELECT '评价题目状态', 'eva_question_status', '0', 'admin', CURRENT_TIMESTAMP, '1启用 0停用'
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_type WHERE dict_type = 'eva_question_status');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 1, '启用', '1', 'eva_question_status', '', 'success', 'Y', '0', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'eva_question_status' AND dict_value = '1');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 2, '停用', '0', 'eva_question_status', '', 'danger', 'N', '0', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'eva_question_status' AND dict_value = '0');

-- 评价管理菜单（选修课管理下）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2040, '评价管理', 2000, 5, 'evaluation', 'course/evaluation/index', '', '', 1, 0, 'C', '0', '0', 'course:evaluation:list', 'star', 'admin', CURRENT_TIMESTAMP, '评价题目管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2040);

-- 评价管理按钮权限
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2041, '题目查询', 2040, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:evaluation:query', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2041);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2042, '题目新增', 2040, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:evaluation:add', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2042);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2043, '题目修改', 2040, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:evaluation:edit', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2043);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2044, '题目删除', 2040, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:evaluation:remove', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2044);

-- 课程评价菜单（选课中心下，学生端）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2130, '课程评价', 2100, 3, 'evaluation', 'selection/evaluation', '', '', 1, 0, 'C', '0', '0', 'course:evaluation:student', 'edit', 'admin', CURRENT_TIMESTAMP, '学生对已选课程评分'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2130);

-- 为超级管理员、教务管理员分配评价管理
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2040 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2040);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2041 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2041);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2042 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2042);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2043 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2043);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2044 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2044);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2040 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2040);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2041 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2041);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2042 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2042);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2043 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2043);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2044 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2044);

-- 为学生角色分配课程评价
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 102, 2130 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2130);
