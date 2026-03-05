-- ----------------------------
-- 课程管理菜单（在 course_student_menu.sql 之后执行）
-- ----------------------------

-- 课程管理菜单（选修课管理下）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2030, '课程管理', 2000, 4, 'course', 'course/course/index', '', 'CourseManage', 1, 0, 'C', '0', '0', 'course:course:list', 'list', 'admin', CURRENT_TIMESTAMP, '课程管理菜单'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2030);

-- 课程管理按钮权限
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2031, '课程查询', 2030, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:query', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2031);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2032, '课程新增', 2030, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:add', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2032);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2033, '课程修改', 2030, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:edit', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2033);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2034, '课程删除', 2030, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:remove', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2034);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2035, '课程导出', 2030, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:export', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2035);

-- 为超级管理员、教务管理员分配课程管理菜单
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2030 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2030);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2031 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2031);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2032 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2032);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2033 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2033);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2034 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2034);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2035 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2035);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2030 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2030);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2031 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2031);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2032 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2032);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2033 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2033);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2034 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2034);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2035 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2035);
