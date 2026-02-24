package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.common.core.domain.entity.SysSemester;

/**
 * 学期管理 数据层
 *
 * @author ruoyi
 */
public interface SysSemesterMapper
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
     * 删除学期（逻辑删除）
     *
     * @param id 学期ID
     * @return 结果
     */
    int deleteSemesterById(Long id);

    /**
     * 取消其他学期的当前学期标记
     */
    int clearCurrentSemester();

    /**
     * 设置指定学期为当前学期
     *
     * @param id 学期ID
     * @return 结果
     */
    int setCurrentSemester(Long id);
}
