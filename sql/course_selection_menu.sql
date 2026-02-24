-- ----------------------------
-- 选课中心菜单（选课车、我的选课）
-- 在 course_selection_init.sql、course_student_menu.sql 之后执行
-- ----------------------------

-- 选课车菜单（选课中心下）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2110, '选课车', 2100, 1, 'cart', 'selection/index', '', '', 1, 0, 'C', '0', '0', 'course:selection:cart', 'shopping-cart', 'admin', CURRENT_TIMESTAMP, '选课车'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2110);

-- 选课车按钮权限
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2111, '提交选课', 2110, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:selection:submit', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2111);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2112, '剩余名额', 2110, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:selection:quota', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2112);

-- 我的选课菜单（选课中心下）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2120, '我的选课', 2100, 2, 'my', 'selection/my', '', '', 1, 0, 'C', '0', '0', 'course:selection:my', 'list', 'admin', CURRENT_TIMESTAMP, '我的选课'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2120);

-- 我的选课按钮权限
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2121, '退课', 2120, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:selection:drop', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2121);

-- 为超级管理员分配选课中心子菜单
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2110 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2110);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2111 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2111);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2112 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2112);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2120 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2120);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2121 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2121);

-- 为学生角色分配选课中心及子菜单
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 102, 2100 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2100);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 102, 2110 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2110);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 102, 2111 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2111);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 102, 2112 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2112);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 102, 2120 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2120);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 102, 2121 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 102 AND menu_id = 2121);
