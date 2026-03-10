-- 测试教师考核查询

-- 1. 检查课程表数据
SELECT COUNT(*) as course_count FROM cou_course WHERE del_flag = '0';

-- 2. 检查有教师的课程
SELECT COUNT(*) as course_with_teacher FROM cou_course WHERE del_flag = '0' AND teacher_id IS NOT NULL;

-- 3. 检查学期数据
SELECT * FROM sys_semester WHERE del_flag = '0';

-- 4. 检查评价数据
SELECT COUNT(*) as evaluation_count FROM stu_evaluation;

-- 5. 检查评价题目
SELECT * FROM eva_question WHERE del_flag = '0';

-- 6. 测试原始查询（简化版）
SELECT
    c.teacher_id,
    c.teacher_name,
    s.id AS semester_id,
    s.semester_name,
    COUNT(DISTINCT c.id) AS course_count,
    COUNT(DISTINCT e.id) AS eval_count
FROM cou_course c
INNER JOIN sys_semester s ON c.semester_id = s.id
LEFT JOIN stu_evaluation e ON c.id = e.course_id AND c.semester_id = e.semester_id
LEFT JOIN eva_question q ON e.question_id = q.id
WHERE c.del_flag = '0'
  AND c.teacher_id IS NOT NULL
GROUP BY c.teacher_id, c.teacher_name, s.id, s.semester_name
ORDER BY c.teacher_name;
