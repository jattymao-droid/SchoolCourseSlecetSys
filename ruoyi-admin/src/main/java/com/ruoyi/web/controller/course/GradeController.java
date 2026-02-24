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
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysGrade;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.service.ISysGradeService;

/**
 * 年级管理
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/course/grade")
public class GradeController extends BaseController
{
    @Autowired
    private ISysGradeService gradeService;

    @PreAuthorize("@ss.hasPermi('course:grade:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysGrade grade)
    {
        startPage();
        List<SysGrade> list = gradeService.selectGradeList(grade);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('course:grade:list')")
    @GetMapping("/listAll")
    public AjaxResult listAll(SysGrade grade)
    {
        return success(gradeService.selectGradeList(grade));
    }

    @PreAuthorize("@ss.hasPermi('course:grade:query')")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        return success(gradeService.selectGradeById(id));
    }

    @PreAuthorize("@ss.hasPermi('course:grade:add')")
    @Log(title = "年级管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysGrade grade)
    {
        return toAjax(gradeService.insertGrade(grade));
    }

    @PreAuthorize("@ss.hasPermi('course:grade:edit')")
    @Log(title = "年级管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysGrade grade)
    {
        return toAjax(gradeService.updateGrade(grade));
    }

    @PreAuthorize("@ss.hasPermi('course:grade:remove')")
    @Log(title = "年级管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(gradeService.deleteGradeById(id));
    }

    @PreAuthorize("@ss.hasPermi('course:grade:edit')")
    @Log(title = "年级管理", businessType = BusinessType.UPDATE)
    @PostMapping("/upgrade")
    public AjaxResult upgrade()
    {
        int count = gradeService.upgradeGrades();
        return success().put("count", count).put("msg", "成功升级 " + count + " 个年级");
    }
}
