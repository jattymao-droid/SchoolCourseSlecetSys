package com.ruoyi.system.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.system.domain.CartItemVO;
import com.ruoyi.system.domain.MySelectionVO;

/**
 * 选课服务 接口
 *
 * @author ruoyi
 */
public interface ISelectionService
{
    /**
     * 获取选课车内容（按星期 1-5 的 Map）
     *
     * @param studentId 学生ID
     * @param semesterId 学期ID
     * @return weekDay -> CartItemVO，无则为空 Map
     */
    Map<Integer, CartItemVO> getCart(Long studentId, Long semesterId);

    /**
     * 加入选课车
     *
     * @param studentId 学生ID
     * @param semesterId 学期ID
     * @param courseId 课程ID
     * @return 成功返回提示信息
     */
    String addToCart(Long studentId, Long semesterId, Long courseId);

    /**
     * 从选课车移除
     *
     * @param studentId 学生ID
     * @param semesterId 学期ID
     * @param weekDay 星期几 1-5
     */
    void removeFromCart(Long studentId, Long semesterId, Integer weekDay);

    /**
     * 清空选课车
     *
     * @param studentId 学生ID
     * @param semesterId 学期ID
     */
    void clearCart(Long studentId, Long semesterId);

    /**
     * 提交选课（校验周一至周五齐全、名额、事务插入、清空选课车）
     *
     * @param studentId 学生ID
     * @param semesterId 学期ID
     * @return 成功提示
     */
    String submitSelection(Long studentId, Long semesterId);

    /**
     * 退课
     *
     * @param studentId 学生ID
     * @param selectionId 选课记录ID
     * @return 成功提示
     */
    String dropCourse(Long studentId, Long selectionId);

    /**
     * 查询我的选课列表
     *
     * @param studentId 学生ID
     * @param semesterId 学期ID
     * @return 已选课程列表
     */
    List<MySelectionVO> getMySelections(Long studentId, Long semesterId);

    /**
     * 查询课程剩余名额（按班级）
     *
     * @param courseId 课程ID
     * @return 班级ID -> 剩余名额
     */
    Map<Long, Integer> getRemainingQuota(Long courseId);
}
