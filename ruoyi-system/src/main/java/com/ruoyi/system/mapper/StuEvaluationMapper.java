package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.common.core.domain.entity.StuEvaluation;

/**
 * 学生评分 数据层
 *
 * @author ruoyi
 */
public interface StuEvaluationMapper
{
    int insertEvaluation(StuEvaluation evaluation);

    /** 批量插入 */
    int batchInsertEvaluation(List<StuEvaluation> list);

    /** 查询学生某课程某题目的评分 */
    StuEvaluation selectByStudentCourseQuestion(@Param("studentId") Long studentId,
            @Param("courseId") Long courseId, @Param("questionId") Long questionId);

    /** 查询学生某学期某课程已评分的题目ID列表 */
    List<Long> selectEvaluatedQuestionIds(@Param("studentId") Long studentId,
            @Param("courseId") Long courseId, @Param("semesterId") Long semesterId);

    /** 删除指定学期的所有评价记录 */
    int deleteBySemesterId(@Param("semesterId") Long semesterId);

    /** 删除指定教师、指定学期的所有评价记录（通过课程关联） */
    int deleteByTeacherAndSemester(@Param("teacherId") Long teacherId, @Param("semesterId") Long semesterId);
}
