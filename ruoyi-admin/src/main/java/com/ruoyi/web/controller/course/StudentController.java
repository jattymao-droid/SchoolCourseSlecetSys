package com.ruoyi.web.controller.course;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.StuStudentInfo;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.StudentImportDTO;
import com.ruoyi.system.service.IStudentService;

/**
 * 学生管理
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/course/student")
public class StudentController extends BaseController
{
    @Autowired
    private IStudentService studentService;

    @PreAuthorize("@ss.hasPermi('course:student:list')")
    @GetMapping("/list")
    public TableDataInfo list(StuStudentInfo student)
    {
        startPage();
        List<StuStudentInfo> list = studentService.selectStudentList(student);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('course:student:export')")
    @Log(title = "学生管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, StuStudentInfo student)
    {
        List<StuStudentInfo> list = studentService.selectStudentList(student);
        ExcelUtil<StuStudentInfo> util = new ExcelUtil<>(StuStudentInfo.class);
        util.exportExcel(response, list, "学生数据");
    }

    @Log(title = "学生管理", businessType = BusinessType.IMPORT)
    @PreAuthorize("@ss.hasPermi('course:student:import')")
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file) throws Exception
    {
        String message = studentService.importStudent(file, getUsername());
        return success(message);
    }

    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<StudentImportDTO> util = new ExcelUtil<>(StudentImportDTO.class);
        util.importTemplateExcel(response, "学生数据");
    }

    @PreAuthorize("@ss.hasPermi('course:student:query')")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        return success(studentService.selectStudentById(id));
    }

    @PreAuthorize("@ss.hasPermi('course:student:add')")
    @Log(title = "学生管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody StuStudentInfo student)
    {
        return toAjax(studentService.insertStudent(student));
    }

    @PreAuthorize("@ss.hasPermi('course:student:edit')")
    @Log(title = "学生管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody StuStudentInfo student)
    {
        return toAjax(studentService.updateStudent(student));
    }

    @PreAuthorize("@ss.hasPermi('course:student:remove')")
    @Log(title = "学生管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(studentService.deleteStudentById(id));
    }

    @PreAuthorize("@ss.hasPermi('course:student:edit')")
    @Log(title = "学生管理", businessType = BusinessType.UPDATE)
    @PostMapping("/resetPwd/{userId}")
    public AjaxResult resetPwd(@PathVariable Long userId, @RequestParam(required = false) String password)
    {
        return toAjax(studentService.resetPassword(userId, password));
    }

    /** 获取当前登录学生的信息（选课中心用） */
    @PreAuthorize("@ss.hasPermi('course:selection:cart')")
    @GetMapping("/me")
    public AjaxResult getCurrentStudent()
    {
        Long userId = SecurityUtils.getUserId();
        StuStudentInfo info = studentService.selectStudentByUserId(userId);
        return success(info);
    }
}
