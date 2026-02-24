package com.ruoyi.web.controller.course;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.service.IDashboardService;

/**
 * 首页看板
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/course/dashboard")
public class DashboardController extends BaseController
{
    @Autowired
    private IDashboardService dashboardService;

    /**
     * 管理员/教务：选课综合统计
     */
    @PreAuthorize("@ss.hasPermi('course:semester:list') or @ss.hasRole('admin') or @ss.hasRole('course_admin')")
    @GetMapping("/admin")
    public AjaxResult getAdminStats()
    {
        Map<String, Object> stats = dashboardService.getAdminStats();
        return success(stats);
    }

    /**
     * 学生：选课相关统计
     */
    @PreAuthorize("@ss.hasPermi('course:selection:my') or @ss.hasRole('student')")
    @GetMapping("/student")
    public AjaxResult getStudentStats()
    {
        Long userId = SecurityUtils.getUserId();
        Map<String, Object> stats = dashboardService.getStudentStats(userId);
        return success(stats);
    }
}
