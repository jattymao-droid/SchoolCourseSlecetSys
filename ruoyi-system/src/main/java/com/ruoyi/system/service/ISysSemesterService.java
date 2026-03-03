package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.common.core.domain.entity.SysSemester;

/**
 * 学期管理 服务层
 *
 * @author ruoyi
 */
public interface ISysSemesterService
{
    /**
     * 查询学期列表
     *
     * @param semester 学期信息
     * @return 学期集合
     */
    List<SysSemester> selectSemesterList(SysSemester semester);

    /**
     * 根据ID查询学期
     *
     * @param id 学期ID
     * @return 学期信息
     */
    SysSemester selectSemesterById(Long id);

    /**
     * 新增学期
     *
     * @param semester 学期信息
     * @return 结果
     */
    int insertSemester(SysSemester semester);

    /**
     * 修改学期
     *
     * @param semester 学期信息
     * @return 结果
     */
    int updateSemester(SysSemester semester);

    /**
     * 删除学期
     *
     * @param id 学期ID
     * @return 结果
     */
    int deleteSemesterById(Long id);

    /**
     * 设置当前学期
     *
     * @param id 学期ID
     * @return 结果
     */
    int setCurrentSemester(Long id);

    /**
     * 获取当前学期
     *
     * @return 当前学期，无则返回null
     */
    SysSemester getCurrentSemester();

    /**
     * 开始选课：将当前学期的选课时间设为 now ~ now+1年
     *
     * @return 结果
     */
    int startSelection();

    /**
     * 结束选课：将当前学期的选课结束时间设为 now
     *
     * @return 结果
     */
    int endSelection();
}
