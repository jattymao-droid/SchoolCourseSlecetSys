package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.common.core.domain.entity.SysGrade;

/**
 * 年级管理 服务层
 *
 * @author ruoyi
 */
public interface ISysGradeService
{
    List<SysGrade> selectGradeList(SysGrade grade);

    SysGrade selectGradeById(Long id);

    int insertGrade(SysGrade grade);

    int updateGrade(SysGrade grade);

    int deleteGradeById(Long id);

    /**
     * 一键升级：将所有年级按 sort 排序，名称升级到下一级
     */
    int upgradeGrades();
}
