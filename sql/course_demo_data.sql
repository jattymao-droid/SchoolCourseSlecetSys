-- ----------------------------
-- 东陆高中选修课选课系统 - 演示数据 (PostgreSQL)
-- 在 course_selection_init.sql 执行后运行，插入学生、课程等演示数据
-- 学生登录账号：student01~student06，密码：admin123
-- 教师登录账号：teacher01、teacher02，密码：admin123
-- ----------------------------

-- ----------------------------
-- 1. 学期
-- ----------------------------
INSERT INTO sys_semester (semester_name, start_date, end_date, is_current, del_flag, create_time)
SELECT '2024-2025学年第一学期', '2024-09-01', '2025-01-20', 1, '0', CURRENT_TIMESTAMP
WHERE NOT EXISTS (SELECT 1 FROM sys_semester WHERE semester_name = '2024-2025学年第一学期');

-- 确保只有一个当前学期
UPDATE sys_semester SET is_current = 0 WHERE semester_name != '2024-2025学年第一学期';

-- ----------------------------
-- 2. 年级
-- ----------------------------
INSERT INTO sys_grade (grade_name, sort, del_flag, create_time)
SELECT '高一', 1, '0', CURRENT_TIMESTAMP WHERE NOT EXISTS (SELECT 1 FROM sys_grade WHERE grade_name = '高一');
INSERT INTO sys_grade (grade_name, sort, del_flag, create_time)
SELECT '高二', 2, '0', CURRENT_TIMESTAMP WHERE NOT EXISTS (SELECT 1 FROM sys_grade WHERE grade_name = '高二');
INSERT INTO sys_grade (grade_name, sort, del_flag, create_time)
SELECT '高三', 3, '0', CURRENT_TIMESTAMP WHERE NOT EXISTS (SELECT 1 FROM sys_grade WHERE grade_name = '高三');

-- ----------------------------
-- 3. 班级（依赖年级）
-- ----------------------------
INSERT INTO sys_class (class_name, grade_id, del_flag, create_time)
SELECT '高一1班', g.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g WHERE g.grade_name = '高一' AND NOT EXISTS (SELECT 1 FROM sys_class WHERE class_name = '高一1班');
INSERT INTO sys_class (class_name, grade_id, del_flag, create_time)
SELECT '高一2班', g.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g WHERE g.grade_name = '高一' AND NOT EXISTS (SELECT 1 FROM sys_class WHERE class_name = '高一2班');
INSERT INTO sys_class (class_name, grade_id, del_flag, create_time)
SELECT '高二1班', g.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g WHERE g.grade_name = '高二' AND NOT EXISTS (SELECT 1 FROM sys_class WHERE class_name = '高二1班');
INSERT INTO sys_class (class_name, grade_id, del_flag, create_time)
SELECT '高二2班', g.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g WHERE g.grade_name = '高二' AND NOT EXISTS (SELECT 1 FROM sys_class WHERE class_name = '高二2班');
INSERT INTO sys_class (class_name, grade_id, del_flag, create_time)
SELECT '高三1班', g.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g WHERE g.grade_name = '高三' AND NOT EXISTS (SELECT 1 FROM sys_class WHERE class_name = '高三1班');
INSERT INTO sys_class (class_name, grade_id, del_flag, create_time)
SELECT '高三2班', g.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g WHERE g.grade_name = '高三' AND NOT EXISTS (SELECT 1 FROM sys_class WHERE class_name = '高三2班');

-- ----------------------------
-- 4. 教师用户（user_type=02，角色 teacher role_id=101）
-- ----------------------------
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, password, status, del_flag, create_time, remark)
SELECT 20, 103, 'teacher01', '张老师', '02', 'teacher01@school.com', '13800000020', '1', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', CURRENT_TIMESTAMP, '语文教师'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE user_name = 'teacher01');
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, password, status, del_flag, create_time, remark)
SELECT 21, 103, 'teacher02', '李老师', '02', 'teacher02@school.com', '13800000021', '1', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', CURRENT_TIMESTAMP, '数学教师'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE user_name = 'teacher02');

INSERT INTO sys_user_role (user_id, role_id) SELECT 20, 101 WHERE NOT EXISTS (SELECT 1 FROM sys_user_role WHERE user_id = 20 AND role_id = 101);
INSERT INTO sys_user_role (user_id, role_id) SELECT 21, 101 WHERE NOT EXISTS (SELECT 1 FROM sys_user_role WHERE user_id = 21 AND role_id = 101);

-- ----------------------------
-- 5. 学生用户（user_type=01，角色 student role_id=102）
-- ----------------------------
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, password, status, del_flag, create_time, remark)
SELECT 10, 103, 'student01', '王小明', '01', 'student01@school.com', '13900000010', '1', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', CURRENT_TIMESTAMP, '高一1班'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE user_name = 'student01');
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, password, status, del_flag, create_time, remark)
SELECT 11, 103, 'student02', '李小红', '01', 'student02@school.com', '13900000011', '2', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', CURRENT_TIMESTAMP, '高一1班'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE user_name = 'student02');
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, password, status, del_flag, create_time, remark)
SELECT 12, 103, 'student03', '陈小华', '01', 'student03@school.com', '13900000012', '1', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', CURRENT_TIMESTAMP, '高一2班'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE user_name = 'student03');
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, password, status, del_flag, create_time, remark)
SELECT 13, 103, 'student04', '刘小芳', '01', 'student04@school.com', '13900000013', '2', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', CURRENT_TIMESTAMP, '高一2班'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE user_name = 'student04');
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, password, status, del_flag, create_time, remark)
SELECT 14, 103, 'student05', '赵小强', '01', 'student05@school.com', '13900000014', '1', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', CURRENT_TIMESTAMP, '高二1班'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE user_name = 'student05');
INSERT INTO sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, password, status, del_flag, create_time, remark)
SELECT 15, 103, 'student06', '孙小丽', '01', 'student06@school.com', '13900000015', '2', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', CURRENT_TIMESTAMP, '高二2班'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE user_name = 'student06');

INSERT INTO sys_user_role (user_id, role_id) SELECT 10, 102 WHERE NOT EXISTS (SELECT 1 FROM sys_user_role WHERE user_id = 10 AND role_id = 102);
INSERT INTO sys_user_role (user_id, role_id) SELECT 11, 102 WHERE NOT EXISTS (SELECT 1 FROM sys_user_role WHERE user_id = 11 AND role_id = 102);
INSERT INTO sys_user_role (user_id, role_id) SELECT 12, 102 WHERE NOT EXISTS (SELECT 1 FROM sys_user_role WHERE user_id = 12 AND role_id = 102);
INSERT INTO sys_user_role (user_id, role_id) SELECT 13, 102 WHERE NOT EXISTS (SELECT 1 FROM sys_user_role WHERE user_id = 13 AND role_id = 102);
INSERT INTO sys_user_role (user_id, role_id) SELECT 14, 102 WHERE NOT EXISTS (SELECT 1 FROM sys_user_role WHERE user_id = 14 AND role_id = 102);
INSERT INTO sys_user_role (user_id, role_id) SELECT 15, 102 WHERE NOT EXISTS (SELECT 1 FROM sys_user_role WHERE user_id = 15 AND role_id = 102);

-- ----------------------------
-- 6. 学生扩展信息（stu_student_info）
-- ----------------------------
INSERT INTO stu_student_info (user_id, student_no, real_name, class_id, grade_id, del_flag, create_time)
SELECT 10, '202401001', '王小明', c.id, g.id, '0', CURRENT_TIMESTAMP
FROM sys_class c JOIN sys_grade g ON c.grade_id = g.id
WHERE c.class_name = '高一1班' AND g.grade_name = '高一'
  AND NOT EXISTS (SELECT 1 FROM stu_student_info WHERE user_id = 10);
INSERT INTO stu_student_info (user_id, student_no, real_name, class_id, grade_id, del_flag, create_time)
SELECT 11, '202401002', '李小红', c.id, g.id, '0', CURRENT_TIMESTAMP
FROM sys_class c JOIN sys_grade g ON c.grade_id = g.id
WHERE c.class_name = '高一1班' AND g.grade_name = '高一'
  AND NOT EXISTS (SELECT 1 FROM stu_student_info WHERE user_id = 11);
INSERT INTO stu_student_info (user_id, student_no, real_name, class_id, grade_id, del_flag, create_time)
SELECT 12, '202401003', '陈小华', c.id, g.id, '0', CURRENT_TIMESTAMP
FROM sys_class c JOIN sys_grade g ON c.grade_id = g.id
WHERE c.class_name = '高一2班' AND g.grade_name = '高一'
  AND NOT EXISTS (SELECT 1 FROM stu_student_info WHERE user_id = 12);
INSERT INTO stu_student_info (user_id, student_no, real_name, class_id, grade_id, del_flag, create_time)
SELECT 13, '202401004', '刘小芳', c.id, g.id, '0', CURRENT_TIMESTAMP
FROM sys_class c JOIN sys_grade g ON c.grade_id = g.id
WHERE c.class_name = '高一2班' AND g.grade_name = '高一'
  AND NOT EXISTS (SELECT 1 FROM stu_student_info WHERE user_id = 13);
INSERT INTO stu_student_info (user_id, student_no, real_name, class_id, grade_id, del_flag, create_time)
SELECT 14, '202302001', '赵小强', c.id, g.id, '0', CURRENT_TIMESTAMP
FROM sys_class c JOIN sys_grade g ON c.grade_id = g.id
WHERE c.class_name = '高二1班' AND g.grade_name = '高二'
  AND NOT EXISTS (SELECT 1 FROM stu_student_info WHERE user_id = 14);
INSERT INTO stu_student_info (user_id, student_no, real_name, class_id, grade_id, del_flag, create_time)
SELECT 15, '202302002', '孙小丽', c.id, g.id, '0', CURRENT_TIMESTAMP
FROM sys_class c JOIN sys_grade g ON c.grade_id = g.id
WHERE c.class_name = '高二2班' AND g.grade_name = '高二'
  AND NOT EXISTS (SELECT 1 FROM stu_student_info WHERE user_id = 15);

-- ----------------------------
-- 7. 课程（高一选修课，周一至周五各2门）
-- ----------------------------
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '经典诵读', 1, g.id, 20, '诵读经典文学作品，提升文学素养', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高一' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '经典诵读' AND c2.week_day = 1 AND c2.grade_id = g.id);
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '趣味数学', 1, g.id, 21, '拓展数学思维，趣味解题', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高一' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '趣味数学' AND c2.week_day = 1 AND c2.grade_id = g.id);
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '英语戏剧', 2, g.id, 20, '英语情景剧表演，提升口语', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高一' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '英语戏剧' AND c2.week_day = 2 AND c2.grade_id = g.id);
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '物理实验', 2, g.id, 21, '动手做物理实验，探索科学', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高一' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '物理实验' AND c2.week_day = 2 AND c2.grade_id = g.id);
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '书法艺术', 3, g.id, 20, '软笔书法入门与提高', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高一' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '书法艺术' AND c2.week_day = 3 AND c2.grade_id = g.id);
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '编程入门', 3, g.id, 21, 'Python 编程基础', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高一' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '编程入门' AND c2.week_day = 3 AND c2.grade_id = g.id);
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '合唱团', 4, g.id, 20, '校园合唱团排练', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高一' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '合唱团' AND c2.week_day = 4 AND c2.grade_id = g.id);
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '篮球社', 5, g.id, 21, '篮球训练与比赛', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高一' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '篮球社' AND c2.week_day = 5 AND c2.grade_id = g.id);

-- ----------------------------
-- 8. 课程班级容量（cou_class_quota）：每门课对高一1班、高一2班各开放 15 人
-- ----------------------------
INSERT INTO cou_class_quota (course_id, class_id, quota, selected, del_flag, create_time)
SELECT c.id, cl.id, 15, 0, '0', CURRENT_TIMESTAMP
FROM cou_course c
JOIN sys_class cl ON cl.class_name IN ('高一1班', '高一2班')
JOIN sys_grade g ON cl.grade_id = g.id AND c.grade_id = g.id
WHERE g.grade_name = '高一'
  AND NOT EXISTS (SELECT 1 FROM cou_class_quota q WHERE q.course_id = c.id AND q.class_id = cl.id);

-- ----------------------------
-- 9. 高二课程（少量，供高二学生选课）
-- ----------------------------
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '辩论与演讲', 1, g.id, 20, '提升表达与思辨能力', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高二' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '辩论与演讲' AND c2.week_day = 1 AND c2.grade_id = g.id);
INSERT INTO cou_course (course_name, week_day, grade_id, teacher_id, description, semester_id, del_flag, create_time)
SELECT '科技创新', 2, g.id, 21, '科技创新项目实践', s.id, '0', CURRENT_TIMESTAMP
FROM sys_grade g CROSS JOIN sys_semester s
WHERE g.grade_name = '高二' AND s.is_current = 1
  AND NOT EXISTS (SELECT 1 FROM cou_course c2 WHERE c2.course_name = '科技创新' AND c2.week_day = 2 AND c2.grade_id = g.id);

INSERT INTO cou_class_quota (course_id, class_id, quota, selected, del_flag, create_time)
SELECT c.id, cl.id, 12, 0, '0', CURRENT_TIMESTAMP
FROM cou_course c
JOIN sys_class cl ON cl.class_name IN ('高二1班', '高二2班')
JOIN sys_grade g ON cl.grade_id = g.id AND c.grade_id = g.id
WHERE g.grade_name = '高二'
  AND NOT EXISTS (SELECT 1 FROM cou_class_quota q WHERE q.course_id = c.id AND q.class_id = cl.id);
