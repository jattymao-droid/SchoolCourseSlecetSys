-- ----------------------------
-- 东陆高中选修课选课系统 - 初始化脚本 (PostgreSQL)
-- 在已有 RuoYi 数据库上执行，用于创建选修课相关表、字典、角色、菜单
-- ----------------------------

-- ----------------------------
-- 0.1 业务表创建
-- ----------------------------

-- 学期表
CREATE TABLE IF NOT EXISTS sys_semester (
    id              BIGSERIAL PRIMARY KEY,
    semester_name    VARCHAR(50) NOT NULL,
    start_date      DATE,
    end_date        DATE,
    is_current      SMALLINT DEFAULT 0,
    del_flag        CHAR(1) DEFAULT '0',
    create_by       VARCHAR(64),
    create_time     TIMESTAMP,
    update_by       VARCHAR(64),
    update_time     TIMESTAMP
);
COMMENT ON TABLE sys_semester IS '学期表';
COMMENT ON COLUMN sys_semester.is_current IS '是否当前学期 0否 1是';

-- 年级表
CREATE TABLE IF NOT EXISTS sys_grade (
    id              BIGSERIAL PRIMARY KEY,
    grade_name      VARCHAR(50) NOT NULL,
    sort            INTEGER,
    del_flag        CHAR(1) DEFAULT '0',
    create_time     TIMESTAMP
);
COMMENT ON TABLE sys_grade IS '年级表';
COMMENT ON COLUMN sys_grade.sort IS '排序，用于一键升级';

-- 班级表
CREATE TABLE IF NOT EXISTS sys_class (
    id              BIGSERIAL PRIMARY KEY,
    class_name      VARCHAR(50) NOT NULL,
    grade_id        BIGINT NOT NULL,
    del_flag        CHAR(1) DEFAULT '0',
    create_time     TIMESTAMP
);
COMMENT ON TABLE sys_class IS '班级表';

-- 学生扩展信息表
CREATE TABLE IF NOT EXISTS stu_student_info (
    id              BIGSERIAL PRIMARY KEY,
    user_id         BIGINT NOT NULL UNIQUE,
    student_no      VARCHAR(20) NOT NULL UNIQUE,
    real_name       VARCHAR(50) NOT NULL,
    class_id        BIGINT NOT NULL,
    grade_id        BIGINT,
    del_flag        CHAR(1) DEFAULT '0',
    create_time     TIMESTAMP
);
COMMENT ON TABLE stu_student_info IS '学生扩展信息表';

-- 课程表
CREATE TABLE IF NOT EXISTS cou_course (
    id              BIGSERIAL PRIMARY KEY,
    course_name     VARCHAR(100) NOT NULL,
    week_day        SMALLINT NOT NULL,
    grade_id        BIGINT NOT NULL,
    teacher_id      BIGINT,
    description     TEXT,
    location        VARCHAR(100),
    semester_id     BIGINT NOT NULL,
    del_flag        CHAR(1) DEFAULT '0',
    create_time     TIMESTAMP
);
COMMENT ON TABLE cou_course IS '课程表';
COMMENT ON COLUMN cou_course.week_day IS '星期几 1-5';
COMMENT ON COLUMN cou_course.location IS '上课地点';

-- 课程班级容量表
CREATE TABLE IF NOT EXISTS cou_class_quota (
    id              BIGSERIAL PRIMARY KEY,
    course_id       BIGINT NOT NULL,
    class_id        BIGINT NOT NULL,
    quota           INTEGER NOT NULL,
    selected        INTEGER DEFAULT 0,
    del_flag        CHAR(1) DEFAULT '0',
    create_time     TIMESTAMP,
    UNIQUE (course_id, class_id)
);
COMMENT ON TABLE cou_class_quota IS '课程班级容量表';

-- 学生选课记录表（使用部分唯一索引，仅对 status=1 生效）
CREATE TABLE IF NOT EXISTS stu_selection (
    id              BIGSERIAL PRIMARY KEY,
    student_id      BIGINT NOT NULL,
    course_id       BIGINT NOT NULL,
    semester_id     BIGINT NOT NULL,
    week_day        SMALLINT NOT NULL,
    class_id        BIGINT,
    create_time     TIMESTAMP,
    status          SMALLINT DEFAULT 1
);
COMMENT ON TABLE stu_selection IS '学生选课记录表';
COMMENT ON COLUMN stu_selection.status IS '1正常 0退课删除';
CREATE UNIQUE INDEX IF NOT EXISTS stu_selection_unique_active 
    ON stu_selection (student_id, semester_id, week_day) WHERE status = 1;

-- 评价题目表
CREATE TABLE IF NOT EXISTS eva_question (
    id              BIGSERIAL PRIMARY KEY,
    content         VARCHAR(255) NOT NULL,
    score           INTEGER NOT NULL,
    sort            INTEGER,
    semester_id     BIGINT NOT NULL,
    status          SMALLINT DEFAULT 1,
    del_flag        CHAR(1) DEFAULT '0',
    create_time     TIMESTAMP
);
COMMENT ON TABLE eva_question IS '评价题目表';
COMMENT ON COLUMN eva_question.status IS '1启用 0停用';

-- 学生评分表
CREATE TABLE IF NOT EXISTS stu_evaluation (
    id              BIGSERIAL PRIMARY KEY,
    student_id      BIGINT NOT NULL,
    course_id       BIGINT NOT NULL,
    question_id     BIGINT NOT NULL,
    score           INTEGER NOT NULL,
    semester_id     BIGINT NOT NULL,
    create_time     TIMESTAMP,
    UNIQUE (student_id, course_id, question_id)
);
COMMENT ON TABLE stu_evaluation IS '学生评分表';

-- 为 id 列创建序列（供应用插入时使用，RuoYi 使用雪花算法时可忽略）
-- 若使用 BIGSERIAL 风格，可改为: ALTER TABLE xxx ADD COLUMN id BIGSERIAL;
-- 本脚本采用应用层生成 ID，表结构已满足

-- ----------------------------
-- 0.2 字典：用户类型
-- ----------------------------
INSERT INTO sys_dict_type (dict_name, dict_type, status, create_by, create_time, remark)
SELECT '用户类型', 'sys_user_type', '0', 'admin', CURRENT_TIMESTAMP, '用户类型：系统用户/学生/教师'
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_type WHERE dict_type = 'sys_user_type');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 1, '系统用户', '00', 'sys_user_type', '', '', 'Y', '0', 'admin', CURRENT_TIMESTAMP, '系统管理员等'
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'sys_user_type' AND dict_value = '00');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 2, '学生', '01', 'sys_user_type', '', 'primary', 'N', '0', 'admin', CURRENT_TIMESTAMP, '学生用户'
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'sys_user_type' AND dict_value = '01');

INSERT INTO sys_dict_data (dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, remark)
SELECT 3, '教师', '02', 'sys_user_type', '', 'success', 'N', '0', 'admin', CURRENT_TIMESTAMP, '教师用户'
WHERE NOT EXISTS (SELECT 1 FROM sys_dict_data WHERE dict_type = 'sys_user_type' AND dict_value = '02');

-- ----------------------------
-- 0.3 角色
-- ----------------------------
INSERT INTO sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, remark)
SELECT 100, '教务管理员', 'course_admin', 3, '1', 1, 1, '0', '0', 'admin', CURRENT_TIMESTAMP, '选修课教务管理'
WHERE NOT EXISTS (SELECT 1 FROM sys_role WHERE role_key = 'course_admin');

INSERT INTO sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, remark)
SELECT 101, '教师', 'teacher', 4, '1', 1, 1, '0', '0', 'admin', CURRENT_TIMESTAMP, '选修课教师'
WHERE NOT EXISTS (SELECT 1 FROM sys_role WHERE role_key = 'teacher');

INSERT INTO sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, remark)
SELECT 102, '学生', 'student', 5, '1', 1, 1, '0', '0', 'admin', CURRENT_TIMESTAMP, '选课学生'
WHERE NOT EXISTS (SELECT 1 FROM sys_role WHERE role_key = 'student');

-- 更新角色序列，避免后续插入冲突
SELECT setval('sys_role_role_id_seq', (SELECT COALESCE(MAX(role_id), 102) FROM sys_role));

-- ----------------------------
-- 0.4 菜单骨架：选修课管理、选课中心（父菜单）
-- ----------------------------
-- 选修课管理 (parent_id=0, 与系统管理同级)
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2000, '选修课管理', 0, 5, 'course', NULL, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', CURRENT_TIMESTAMP, '选修课管理目录'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2000);

-- 选课中心 (parent_id=0)
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2100, '选课中心', 0, 6, 'selection', NULL, '', '', 1, 0, 'M', '0', '0', '', 'shopping', 'admin', CURRENT_TIMESTAMP, '学生选课中心'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2100);

-- 学期管理菜单（选修课管理下）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2001, '学期管理', 2000, 1, 'semester', 'course/semester/index', '', '', 1, 0, 'C', '0', '0', 'course:semester:list', 'date', 'admin', CURRENT_TIMESTAMP, '学期管理菜单'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2001);

-- 学期管理按钮权限
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2002, '学期查询', 2001, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:semester:query', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2002);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2003, '学期新增', 2001, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:semester:add', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2003);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2004, '学期修改', 2001, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:semester:edit', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2004);
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, remark)
SELECT 2005, '学期删除', 2001, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:semester:remove', '#', 'admin', CURRENT_TIMESTAMP, ''
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2005);

-- 为超级管理员、教务管理员分配学期管理菜单
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2000 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2000);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2001 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2001);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2002 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2002);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2003 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2003);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2004 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2004);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2005 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2005);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2000 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2000);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2001 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2001);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2002 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2002);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2003 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2003);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2004 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2004);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 100, 2005 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 100 AND menu_id = 2005);
INSERT INTO sys_role_menu (role_id, menu_id) SELECT 1, 2100 WHERE NOT EXISTS (SELECT 1 FROM sys_role_menu WHERE role_id = 1 AND menu_id = 2100);
