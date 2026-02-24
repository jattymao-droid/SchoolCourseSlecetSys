package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.common.core.domain.entity.EvaQuestion;

/**
 * 评价题目 数据层
 *
 * @author ruoyi
 */
public interface EvaQuestionMapper
{
    List<EvaQuestion> selectQuestionList(EvaQuestion question);

    EvaQuestion selectQuestionById(Long id);

    int insertQuestion(EvaQuestion question);

    int updateQuestion(EvaQuestion question);

    int deleteQuestionById(Long id);

    /** 查询某学期下启用的题目（按 sort 排序） */
    List<EvaQuestion> selectEnabledBySemesterId(Long semesterId);
}
