package com.ruoyi.system.service;

import java.util.Map;

/**
 * 首页看板 服务层
 *
 * @author ruoyi
 */
public interface IDashboardService
{
    /**
     * 管理员/教务：选课综合统计
     *
     * @return 统计信息（semesterCount, courseCount, studentCount, selectionCount, questionCount, currentSemester）
     */
    Map<String, Object> getAdminStats();

    /**
     * 学生：选课相关统计
     *
     * @param studentId 学生ID（stu_student_info.id）
     * @return 统计信息（currentSemester, selectionCount, pendingEvaluationCount, coursesToEvaluate）
     */
    Map<String, Object> getStudentStats(Long studentId);
}
