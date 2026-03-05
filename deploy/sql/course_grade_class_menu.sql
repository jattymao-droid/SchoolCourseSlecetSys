-- ----------------------------
-- 年级班级管理菜单（在 course_selection_init.sql 之后执行，或合并到主脚本）
-- ----------------------------

-- 年级班级管理菜单（选修课管理下）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2010, '年级班级管理', 2000, 2, 'grade', 'course/grade/index', '', '', 1, 0, 'C', '0', '0', 'course:grade:list', 'tree', 'admin', CURRENT_TIMESTAMP, '年级班级管理菜单'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2010);

-- 年级管理按钮权限
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2011, '年级查询', 2010, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:grade:query', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2011);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2012, '年级新增', 2010, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:grade:add', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2012);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2013, '年级修改', 2010, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:grade:edit', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2013);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2014, '年级删除', 2010, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:grade:remove', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2014);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2015, '班级查询', 2010, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:query', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2015);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2016, '班级新增', 2010, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:add', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2016);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2017, '班级修改', 2010, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:edit', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2017);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2018, '班级删除', 2010, 8, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:remove', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2018);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2019, '班级列表', 2010, 9, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:list', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2019);

-- 为超级管理员、教务管理员分配年级班级管理菜单
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2010 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2010);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2011 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2011);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2012 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2012);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2013 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2013);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2014 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2014);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2015 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2015);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2016 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2016);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2017 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2017);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2018 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2018);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2010 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2010);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2011 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2011);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2012 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2012);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2013 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2013);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2014 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2014);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2015 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2015);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2016 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2016);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2017 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2017);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2018 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2018);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2019 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2019);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2019 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2019);
