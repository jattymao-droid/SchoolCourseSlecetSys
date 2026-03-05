-- ----------------------------
-- 学生管理菜单（在 course_selection_init.sql、course_grade_class_menu.sql 之后执行）
-- ----------------------------

-- 学生管理菜单（选修课管理下）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2020, '学生管理', 2000, 3, 'student', 'course/student/index', '', '', 1, 0, 'C', '0', '0', 'course:student:list', 'user', 'admin', CURRENT_TIMESTAMP, '学生管理菜单'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2020);

-- 学生管理按钮权限
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2021, '学生查询', 2020, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:query', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2021);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2022, '学生新增', 2020, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:add', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2022);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2023, '学生修改', 2020, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:edit', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2023);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2024, '学生删除', 2020, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:remove', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2024);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2025, '学生导入', 2020, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:import', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2025);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2026, '学生导出', 2020, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:export', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2026);

-- 为超级管理员、教务管理员分配学生管理菜单
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2020 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2020);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2021 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2021);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2022 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2022);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2023 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2023);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2024 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2024);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2025 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2025);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2026 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2026);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2020 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2020);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2021 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2021);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2022 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2022);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2023 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2023);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2024 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2024);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2025 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2025);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2026 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2026);
