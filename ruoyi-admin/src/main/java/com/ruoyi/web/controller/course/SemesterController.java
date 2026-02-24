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
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.entity.SysSemester;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.service.ISysSemesterService;

/**
 * 学期管理
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/course/semester")
public class SemesterController extends BaseController
{
    @Autowired
    private ISysSemesterService semesterService;

    /**
     * 获取学期列表
     */
    @PreAuthorize("@ss.hasPermi('course:semester:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysSemester semester)
    {
        startPage();
        List<SysSemester> list = semesterService.selectSemesterList(semester);
        return getDataTable(list);
    }

    /**
     * 获取所有学期（不分页，用于下拉选择）
     */
    @PreAuthorize("@ss.hasPermi('course:semester:list')")
    @GetMapping("/listAll")
    public AjaxResult listAll(SysSemester semester)
    {
        List<SysSemester> list = semesterService.selectSemesterList(semester);
        return success(list);
    }

    /**
     * 根据ID获取学期详情
     */
    @PreAuthorize("@ss.hasPermi('course:semester:query')")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        return success(semesterService.selectSemesterById(id));
    }

    /**
     * 新增学期
     */
    @PreAuthorize("@ss.hasPermi('course:semester:add')")
    @Log(title = "学期管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody SysSemester semester)
    {
        semester.setCreateBy(getUsername());
        return toAjax(semesterService.insertSemester(semester));
    }

    /**
     * 修改学期
     */
    @PreAuthorize("@ss.hasPermi('course:semester:edit')")
    @Log(title = "学期管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody SysSemester semester)
    {
        semester.setUpdateBy(getUsername());
        return toAjax(semesterService.updateSemester(semester));
    }

    /**
     * 删除学期
     */
    @PreAuthorize("@ss.hasPermi('course:semester:remove')")
    @Log(title = "学期管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(semesterService.deleteSemesterById(id));
    }

    /**
     * 设置当前学期
     */
    @PreAuthorize("@ss.hasPermi('course:semester:edit')")
    @Log(title = "学期管理", businessType = BusinessType.UPDATE)
    @PutMapping("/setCurrent/{id}")
    public AjaxResult setCurrent(@PathVariable Long id)
    {
        return toAjax(semesterService.setCurrentSemester(id));
    }

    /**
     * 获取当前学期（供选课等模块使用）
     */
    @GetMapping("/current")
    public AjaxResult getCurrent()
    {
        return success(semesterService.getCurrentSemester());
    }
}
