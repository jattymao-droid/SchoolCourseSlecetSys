package com.ruoyi.web.controller.course;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.EvaQuestion;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.CourseToEvaluateVO;
import com.ruoyi.system.domain.SubmitEvaluationDTO;
import com.ruoyi.system.service.IEvaluationService;

/**
 * 评价管理
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/course/evaluation")
public class EvaluationController extends BaseController
{
    @Autowired
    private IEvaluationService evaluationService;

    /* ========== 管理员：题目管理 ========== */

    @PreAuthorize("@ss.hasPermi('course:evaluation:list')")
    @GetMapping("/question/list")
    public TableDataInfo questionList(EvaQuestion question)
    {
        startPage();
        List<EvaQuestion> list = evaluationService.selectQuestionList(question);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('course:evaluation:query')")
    @GetMapping("/question/{id}")
    public AjaxResult getQuestion(@PathVariable Long id)
    {
        return success(evaluationService.selectQuestionById(id));
    }

    @PreAuthorize("@ss.hasPermi('course:evaluation:add')")
    @Log(title = "评价题目", businessType = BusinessType.INSERT)
    @PostMapping("/question")
    public AjaxResult addQuestion(@Validated @RequestBody EvaQuestion question)
    {
        return toAjax(evaluationService.insertQuestion(question));
    }

    @PreAuthorize("@ss.hasPermi('course:evaluation:edit')")
    @Log(title = "评价题目", businessType = BusinessType.UPDATE)
    @PutMapping("/question")
    public AjaxResult editQuestion(@Validated @RequestBody EvaQuestion question)
    {
        return toAjax(evaluationService.updateQuestion(question));
    }

    @PreAuthorize("@ss.hasPermi('course:evaluation:remove')")
    @Log(title = "评价题目", businessType = BusinessType.DELETE)
    @DeleteMapping("/question/{id}")
    public AjaxResult removeQuestion(@PathVariable Long id)
    {
        return toAjax(evaluationService.deleteQuestionById(id));
    }

    @PreAuthorize("@ss.hasPermi('course:evaluation:edit')")
    @Log(title = "评价题目", businessType = BusinessType.UPDATE)
    @PutMapping("/question/{id}/status/{status}")
    public AjaxResult setQuestionStatus(@PathVariable Long id, @PathVariable Integer status)
    {
        return toAjax(evaluationService.setQuestionStatus(id, status));
    }

    /* ========== 学生：课程评价 ========== */

    @PreAuthorize("@ss.hasPermi('course:evaluation:student')")
    @GetMapping("/my/courses")
    public AjaxResult getCoursesToEvaluate(@RequestParam Long semesterId)
    {
        Long studentId = SecurityUtils.getUserId();
        List<CourseToEvaluateVO> list = evaluationService.getCoursesToEvaluate(studentId, semesterId);
        return success(list);
    }

    @PreAuthorize("@ss.hasPermi('course:evaluation:student')")
    @Log(title = "课程评价", businessType = BusinessType.INSERT)
    @PostMapping("/my/submit")
    public AjaxResult submitEvaluation(@Validated @RequestBody SubmitEvaluationDTO dto)
    {
        try
        {
            Long studentId = SecurityUtils.getUserId();
            evaluationService.submitEvaluation(studentId, dto);
            return success();
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }
}
