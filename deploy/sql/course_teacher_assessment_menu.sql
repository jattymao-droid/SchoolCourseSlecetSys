-- ----------------------------
-- 教师考核菜单（选修课管理下）
-- 在 course_evaluation_menu.sql 之后执行
-- ----------------------------

-- 教师考核菜单
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2050, '教师考核', 2000, 6, 'teacherAssessment', 'course/teacherAssessment/index', '', '', 1, 0, 'C', '0', '0', 'course:teacherAssessment:list', 'peoples', 'admin', CURRENT_TIMESTAMP, '教师考核：按学生评分计算平均分、查看详情、导出'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2050);

-- 教师考核按钮权限
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2051, '考核查询', 2050, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:query', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2051);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2052, '考核导出', 2050, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:export', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2052);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2053, '考核编辑', 2050, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:edit', '#', 'admin', CURRENT_TIMESTAMP, '初始化考核数据'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2053);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2054, '考核删除', 2050, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:remove', '#', 'admin', CURRENT_TIMESTAMP, '删除教师考核数据'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2054);

-- 为超级管理员、教务管理员分配教师考核
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2050 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2050);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2051 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2051);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2052 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2052);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2050 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2050);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2051 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2051);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2052 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2052);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2053 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2053);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2054 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2054);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2053 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2053);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2054 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2054);
