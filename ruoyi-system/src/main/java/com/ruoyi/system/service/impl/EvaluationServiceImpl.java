package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.domain.entity.EvaQuestion;
import com.ruoyi.common.core.domain.entity.StuEvaluation;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.CourseToEvaluateVO;
import com.ruoyi.system.domain.MySelectionVO;
import com.ruoyi.system.domain.SubmitEvaluationDTO;
import com.ruoyi.system.mapper.EvaQuestionMapper;
import com.ruoyi.system.mapper.StuEvaluationMapper;
import com.ruoyi.system.mapper.StuSelectionMapper;
import com.ruoyi.system.service.IEvaluationService;

/**
 * 评价管理 服务实现
 *
 * @author ruoyi
 */
@Service
public class EvaluationServiceImpl implements IEvaluationService
{
    @Autowired
    private EvaQuestionMapper questionMapper;

    @Autowired
    private StuEvaluationMapper evaluationMapper;

    @Autowired
    private StuSelectionMapper selectionMapper;

    @Override
    public List<EvaQuestion> selectQuestionList(EvaQuestion question)
    {
        return questionMapper.selectQuestionList(question);
    }

    @Override
    public EvaQuestion selectQuestionById(Long id)
    {
        return questionMapper.selectQuestionById(id);
    }

    @Override
    public int insertQuestion(EvaQuestion question)
    {
        if (question.getStatus() == null) question.setStatus(1);
        return questionMapper.insertQuestion(question);
    }

    @Override
    public int updateQuestion(EvaQuestion question)
    {
        return questionMapper.updateQuestion(question);
    }

    @Override
    public int deleteQuestionById(Long id)
    {
        return questionMapper.deleteQuestionById(id);
    }

    @Override
    public int setQuestionStatus(Long id, Integer status)
    {
        EvaQuestion q = questionMapper.selectQuestionById(id);
        if (q == null) throw new ServiceException("题目不存在");
        q.setStatus(status);
        return questionMapper.updateQuestion(q);
    }

    @Override
    public List<CourseToEvaluateVO> getCoursesToEvaluate(Long studentId, Long semesterId)
    {
        List<MySelectionVO> selections = selectionMapper.selectMySelections(studentId, semesterId);
        List<EvaQuestion> allQuestions = questionMapper.selectEnabledBySemesterId(semesterId);
        if (allQuestions.isEmpty()) return new ArrayList<>();

        List<CourseToEvaluateVO> result = new ArrayList<>();
        for (MySelectionVO sel : selections)
        {
            CourseToEvaluateVO vo = new CourseToEvaluateVO();
            vo.setCourseId(sel.getCourseId());
            vo.setCourseName(sel.getCourseName());
            vo.setWeekDay(sel.getWeekDay());
            vo.setTeacherName(sel.getTeacherName());
            vo.setSemesterId(semesterId);

            List<CourseToEvaluateVO.QuestionVO> qList = new ArrayList<>();
            for (EvaQuestion eq : allQuestions)
            {
                CourseToEvaluateVO.QuestionVO qv = new CourseToEvaluateVO.QuestionVO();
                qv.setQuestionId(eq.getId());
                qv.setContent(eq.getContent());
                qv.setScore(eq.getScore());
                qList.add(qv);
            }
            vo.setQuestions(qList);

            List<Long> evaluatedIds = evaluationMapper.selectEvaluatedQuestionIds(studentId, sel.getCourseId(), semesterId);
            vo.setEvaluated(evaluatedIds != null && evaluatedIds.size() >= allQuestions.size());
            result.add(vo);
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void submitEvaluation(Long studentId, SubmitEvaluationDTO dto)
    {
        if (dto == null || dto.getCourseId() == null || dto.getSemesterId() == null
                || StringUtils.isEmpty(dto.getScores()))
        {
            throw new ServiceException("参数不完整");
        }
        List<EvaQuestion> enabledQuestions = questionMapper.selectEnabledBySemesterId(dto.getSemesterId());
        if (enabledQuestions.isEmpty()) throw new ServiceException("当前学期暂无评价题目");

        Set<Long> validQuestionIds = enabledQuestions.stream().map(EvaQuestion::getId).collect(Collectors.toSet());
        java.util.Map<Long, Integer> maxScoreMap = enabledQuestions.stream()
                .collect(Collectors.toMap(EvaQuestion::getId, EvaQuestion::getScore));

        List<StuEvaluation> toInsert = new ArrayList<>();
        for (SubmitEvaluationDTO.QuestionScore qs : dto.getScores())
        {
            if (qs.getQuestionId() == null || qs.getScore() == null) continue;
            if (!validQuestionIds.contains(qs.getQuestionId())) throw new ServiceException("题目未启用或不存在");
            int maxScore = maxScoreMap.getOrDefault(qs.getQuestionId(), 10);
            if (qs.getScore() < 0 || qs.getScore() > maxScore)
                throw new ServiceException("分值超出范围 0-" + maxScore);

            StuEvaluation ev = new StuEvaluation();
            ev.setStudentId(studentId);
            ev.setCourseId(dto.getCourseId());
            ev.setQuestionId(qs.getQuestionId());
            ev.setScore(qs.getScore());
            ev.setSemesterId(dto.getSemesterId());
            toInsert.add(ev);
        }
        if (toInsert.isEmpty()) throw new ServiceException("请至少填写一道评分");
        evaluationMapper.batchInsertEvaluation(toInsert);
    }
}
