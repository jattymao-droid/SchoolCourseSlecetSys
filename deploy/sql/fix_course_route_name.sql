-- 修复课程管理路由名称冲突（与父菜单 选修课管理 path 同为 course 导致 name 重复）
UPDATE sys_menu SET route_name = 'CourseManage' WHERE menu_id = 2030 AND (route_name IS NULL OR route_name = '');
