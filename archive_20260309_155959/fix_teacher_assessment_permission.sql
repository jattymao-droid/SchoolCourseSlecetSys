-- 修复教师考核权限问题
-- 执行此脚本后需要重新登录系统

-- 1. 删除旧的菜单（如果存在）
DELETE FROM sys_menu WHERE menu_id >= 2050 AND menu_id <= 2054;

-- 2. 插入教师考核主菜单
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (2050, '教师考核', 2000, 6, 'teacherAssessment', 'course/teacherAssessment/index', '', '', 1, 0, 'C', '0', '0', 'course:teacherAssessment:list', 'peoples', 'admin', CURRENT_TIMESTAMP, '教师考核：按学生评分计算平均分、查看详情、导出');

-- 3. 插入教师考核按钮权限
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (2051, '考核查询', 2050, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:query', '#', 'admin', CURRENT_TIMESTAMP, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (2052, '考核导出', 2050, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:export', '#', 'admin', CURRENT_TIMESTAMP, '');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (2053, '考核编辑', 2050, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:edit', '#', 'admin', CURRENT_TIMESTAMP, '初始化考核数据');

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
VALUES (2054, '考核删除', 2050, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:remove', '#', 'admin', CURRENT_TIMESTAMP, '删除教师考核数据');

-- 4. 为管理员角色分配权限（假设管理员角色ID为1）
-- 先删除旧的角色菜单关联
DELETE FROM sys_role_menu WHERE menu_id >= 2050 AND menu_id <= 2054;

-- 为管理员角色（role_id=1）分配所有教师考核权限
INSERT INTO sys_role_menu (role_id, menu_id)
SELECT 1, menu_id FROM sys_menu WHERE menu_id >= 2050 AND menu_id <= 2054;

-- 5. 验证插入结果
SELECT menu_id, menu_name, perms, menu_type FROM sys_menu WHERE menu_id >= 2050 AND menu_id <= 2054 ORDER BY menu_id;

-- 提示：执行完此脚本后，请退出系统重新登录，权限才会生效
