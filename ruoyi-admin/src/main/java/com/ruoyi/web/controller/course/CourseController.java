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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.CouCourse;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.AssignStudentsDTO;
import com.ruoyi.system.domain.CourseSelectedStudentVO;
import com.ruoyi.system.service.ICourseService;

/**
 * 课程管理
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/course/course")
public class CourseController extends BaseController
{
    private static final Logger log = LoggerFactory.getLogger(CourseController.class);

    @Autowired
    private ICourseService courseService;

    @PreAuthorize("@ss.hasPermi('course:course:list') or @ss.hasPermi('course:selection:cart')")
    @GetMapping("/list")
    public TableDataInfo list(CouCourse course, @RequestParam(required = false) Long classId)
    {
        if (classId != null)
        {
            course.setClassId(classId);
        }
        startPage();
        List<CouCourse> list = courseService.selectCourseList(course);
        if (!list.isEmpty() && log.isDebugEnabled())
        {
            CouCourse first = list.get(0);
            log.debug("[课程列表] 首条 id={} courseName={} location={}", first.getId(), first.getCourseName(), first.getLocation());
        }
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('course:course:query') or @ss.hasPermi('course:selection:cart')")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(courseService.selectCourseById(id));
    }

    @PreAuthorize("@ss.hasPermi('course:course:add')")
    @Log(title = "课程管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody CouCourse course)
    {
        return toAjax(courseService.insertCourse(course));
    }

    @PreAuthorize("@ss.hasPermi('course:course:edit')")
    @Log(title = "课程管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody CouCourse course)
    {
        if (log.isDebugEnabled())
        {
            log.debug("[课程更新] id={} location={}", course.getId(), course.getLocation());
        }
        return toAjax(courseService.updateCourse(course));
    }

    @PreAuthorize("@ss.hasPermi('course:course:remove')")
    @Log(title = "课程管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(courseService.deleteCourseById(id));
    }

    @PreAuthorize("@ss.hasPermi('course:course:add')")
    @Log(title = "课程管理", businessType = BusinessType.INSERT)
    @PostMapping("/copyToNewSemester/{oldCourseId}/{newSemesterId}")
    public AjaxResult copyToNewSemester(@PathVariable Long oldCourseId, @PathVariable Long newSemesterId)
    {
        return toAjax(courseService.copyToNewSemester(oldCourseId, newSemesterId));
    }

    @PreAuthorize("@ss.hasPermi('course:course:edit')")
    @Log(title = "课程管理", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/assignStudents")
    public AjaxResult assignStudents(@PathVariable("id") Long id, @RequestBody(required = false) AssignStudentsDTO dto)
    {
        try
        {
            List<Long> studentIds = dto != null ? dto.getStudentIdsAsLong() : java.util.Collections.emptyList();
            int count = courseService.assignStudents(id, studentIds);
            return success("成功指定 " + count + " 名学生");
        }
        catch (Exception e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }

    @PreAuthorize("@ss.hasPermi('course:course:query')")
    @GetMapping("/{id}/selectedStudents")
    public TableDataInfo selectedStudents(@PathVariable Long id)
    {
        List<CourseSelectedStudentVO> list = courseService.selectSelectedStudents(id);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('course:course:export')")
    @Log(title = "课程管理", businessType = BusinessType.EXPORT)
    @PostMapping("/{id}/exportSelectedStudents")
    public void exportSelectedStudents(@PathVariable Long id, HttpServletResponse response)
    {
        List<CourseSelectedStudentVO> list = courseService.selectSelectedStudents(id);
        ExcelUtil<CourseSelectedStudentVO> util = new ExcelUtil<>(CourseSelectedStudentVO.class);
        util.exportExcel(response, list, "选课学生");
    }

    @Log(title = "课程管理", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('course:course:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, CouCourse course)
    {
        List<CouCourse> list = courseService.selectCourseList(course);
        ExcelUtil<CouCourse> util = new ExcelUtil<CouCourse>(CouCourse.class);
        util.exportExcel(response, list, "课程数据");
    }

    @Log(title = "课程管理", businessType = BusinessType.IMPORT)
    @PreAuthorize("@ss.hasPermi('course:course:import')")
    @PostMapping("/importData")
    public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception
    {
        ExcelUtil<CouCourse> util = new ExcelUtil<CouCourse>(CouCourse.class);
        List<CouCourse> courseList = util.importExcel(file.getInputStream());
        String operName = getUsername();
        String message = courseService.importCourse(courseList, updateSupport, operName);
        return success(message);
    }

    @PostMapping("/importTemplate")
    public void importTemplate(HttpServletResponse response)
    {
        ExcelUtil<CouCourse> util = new ExcelUtil<CouCourse>(CouCourse.class);
        util.importTemplateExcel(response, "课程数据");
    }

    @PreAuthorize("@ss.hasPermi('course:course:edit')")
    @Log(title = "课程管理", businessType = BusinessType.CLEAN)
    @PostMapping("/initSelectionData")
    public AjaxResult initSelectionData(@RequestParam Long semesterId)
    {
        int deleted = courseService.initSelectionData(semesterId);
        return success("初始化成功，已清空 " + deleted + " 条选课记录");
    }
}
