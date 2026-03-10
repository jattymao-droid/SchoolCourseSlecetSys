-- 检查教师考核相关数据

-- 1. 检查课程数据
SELECT '课程数据' as check_item, COUNT(*) as count FROM cou_course WHERE del_flag = '0';
SELECT '有教师的课程' as check_item, COUNT(*) as count FROM cou_course WHERE del_flag = '0' AND teacher_id IS NOT NULL;

-- 2. 检查学期数据  
SELECT '学期数据' as check_item, * FROM sys_semester WHERE del_flag = '0';

-- 3. 检查评价数据
SELECT '评价数据' as check_item, COUNT(*) as count FROM stu_evaluation;

-- 4. 检查评价题目
SELECT '评价题目' as check_item, COUNT(*) as count FROM eva_question WHERE del_flag = '0';

-- 5. 测试教师考核查询（简化版）
SELECT 
    c.teacher_id,
    c.teacher_name,
    s.id AS semester_id,
    s.semester_name,
    COUNT(DISTINCT c.id) AS course_count
FROM cou_course c
INNER JOIN sys_semester s ON c.semester_id = s.id
WHERE c.del_flag = '0'
  AND c.teacher_id IS NOT NULL
GROUP BY c.teacher_id, c.teacher_name, s.id, s.semester_name
ORDER BY c.teacher_name;
