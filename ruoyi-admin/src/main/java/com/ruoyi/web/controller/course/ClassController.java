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
import com.ruoyi.common.core.domain.entity.SysClass;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.service.ISysClassService;

/**
 * 班级管理
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/course/class")
public class ClassController extends BaseController
{
    @Autowired
    private ISysClassService classService;

    @PreAuthorize("@ss.hasPermi('course:class:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysClass sysClass)
    {
        startPage();
        List<SysClass> list = classService.selectClassList(sysClass);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('course:class:list')")
    @GetMapping("/listByGrade/{gradeId}")
    public AjaxResult listByGrade(@PathVariable Long gradeId)
    {
        return success(classService.selectClassByGradeId(gradeId));
    }

    @PreAuthorize("@ss.hasPermi('course:class:query')")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        return success(classService.selectClassById(id));
    }

    @PreAuthorize("@ss.hasPermi('course:class:add')")
    @Log(title = "班级管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysClass sysClass)
    {
        return toAjax(classService.insertClass(sysClass));
    }

    @PreAuthorize("@ss.hasPermi('course:class:edit')")
    @Log(title = "班级管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysClass sysClass)
    {
        return toAjax(classService.updateClass(sysClass));
    }

    @PreAuthorize("@ss.hasPermi('course:class:remove')")
    @Log(title = "班级管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(classService.deleteClassById(id));
    }
}
