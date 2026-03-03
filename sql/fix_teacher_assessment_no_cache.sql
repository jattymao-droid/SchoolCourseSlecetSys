-- 教师考核菜单：设置不缓存，确保每次进入页面都重新加载数据
UPDATE sys_menu SET is_cache = 1 WHERE menu_id = 2050;
