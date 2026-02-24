package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.common.core.domain.entity.EvaQuestion;
import com.ruoyi.system.domain.CourseToEvaluateVO;
import com.ruoyi.system.domain.SubmitEvaluationDTO;

/**
 * 评价管理 服务层
 *
 * @author ruoyi
 */
public interface IEvaluationService
{
    /** 题目列表 */
    List<EvaQuestion> selectQuestionList(EvaQuestion question);

    EvaQuestion selectQuestionById(Long id);

    int insertQuestion(EvaQuestion question);

    int updateQuestion(EvaQuestion question);

    int deleteQuestionById(Long id);

    /** 启用/停用题目 */
    int setQuestionStatus(Long id, Integer status);

    /** 学生：获取待评价课程列表（已选课程 + 启用题目，标记已评/未评） */
    List<CourseToEvaluateVO> getCoursesToEvaluate(Long studentId, Long semesterId);

    /** 学生：提交评价 */
    void submitEvaluation(Long studentId, SubmitEvaluationDTO dto);
}
