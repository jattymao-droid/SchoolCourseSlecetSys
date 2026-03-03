package com.ruoyi.web.controller.course;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.CartItemVO;
import com.ruoyi.system.domain.MySelectionVO;
import com.ruoyi.system.service.ISelectionService;

/**
 * 选课中心（学生端）
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/course/selection")
public class SelectionController extends BaseController
{
    @Autowired
    private ISelectionService selectionService;

    /** 选课车：获取 */
    @PreAuthorize("@ss.hasPermi('course:selection:cart')")
    @GetMapping("/cart")
    public AjaxResult getCart(@RequestParam Long semesterId)
    {
        Long studentId = SecurityUtils.getUserId();
        Map<Integer, CartItemVO> cart = selectionService.getCart(studentId, semesterId);
        return success(cart);
    }

    /** 选课车：加入 */
    @PreAuthorize("@ss.hasPermi('course:selection:cart')")
    @Log(title = "选课车", businessType = BusinessType.INSERT)
    @PostMapping("/cart/add")
    public AjaxResult addToCart(@RequestParam Long semesterId, @RequestParam Long courseId)
    {
        Long studentId = SecurityUtils.getUserId();
        String msg = selectionService.addToCart(studentId, semesterId, courseId);
        return success(msg);
    }

    /** 选课车：移除 */
    @PreAuthorize("@ss.hasPermi('course:selection:cart')")
    @Log(title = "选课车", businessType = BusinessType.DELETE)
    @DeleteMapping("/cart/remove")
    public AjaxResult removeFromCart(@RequestParam Long semesterId, @RequestParam Integer weekDay)
    {
        Long studentId = SecurityUtils.getUserId();
        selectionService.removeFromCart(studentId, semesterId, weekDay);
        return success();
    }

    /** 选课车：清空 */
    @PreAuthorize("@ss.hasPermi('course:selection:cart')")
    @Log(title = "选课车", businessType = BusinessType.CLEAN)
    @DeleteMapping("/cart/clear")
    public AjaxResult clearCart(@RequestParam Long semesterId)
    {
        Long studentId = SecurityUtils.getUserId();
        selectionService.clearCart(studentId, semesterId);
        return success();
    }

    /** 提交选课 */
    @PreAuthorize("@ss.hasPermi('course:selection:submit')")
    @Log(title = "选课", businessType = BusinessType.INSERT)
    @PostMapping("/submit")
    public AjaxResult submitSelection(@RequestParam Long semesterId)
    {
        Long studentId = SecurityUtils.getUserId();
        try
        {
            String msg = selectionService.submitSelection(studentId, semesterId);
            return success(msg);
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    /** 退课：所有已选课程退回选课车，移除要退选的课程，返回更新后的选课车 */
    @PreAuthorize("@ss.hasPermi('course:selection:drop') or @ss.hasRole('student')")
    @Log(title = "退课", businessType = BusinessType.DELETE)
    @PostMapping("/drop/{selectionId}")
    public AjaxResult dropCourse(@PathVariable Long selectionId)
    {
        Long studentId = SecurityUtils.getUserId();
        try
        {
            Map<String, Object> result = selectionService.dropCourse(studentId, selectionId);
            return success(result);
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    /** 我的选课列表 */
    @PreAuthorize("@ss.hasPermi('course:selection:my')")
    @GetMapping("/my")
    public AjaxResult getMySelections(@RequestParam Long semesterId)
    {
        Long studentId = SecurityUtils.getUserId();
        List<MySelectionVO> list = selectionService.getMySelections(studentId, semesterId);
        return success(list);
    }

    /** 查询课程剩余名额（班级ID -> 剩余数） */
    @PreAuthorize("@ss.hasPermi('course:selection:quota')")
    @GetMapping("/quota/{courseId}")
    public AjaxResult getRemainingQuota(@PathVariable Long courseId)
    {
        Map<Long, Integer> map = selectionService.getRemainingQuota(courseId);
        return success(map);
    }
}
