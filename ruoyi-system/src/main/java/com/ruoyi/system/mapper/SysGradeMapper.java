package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.common.core.domain.entity.SysGrade;

/**
 * 年级管理 数据层
 *
 * @author ruoyi
 */
public interface SysGradeMapper
{
    List<SysGrade> selectGradeList(SysGrade grade);

    SysGrade selectGradeById(Long id);

    int insertGrade(SysGrade grade);

    int updateGrade(SysGrade grade);

    int deleteGradeById(Long id);

    SysGrade checkGradeNameUnique(SysGrade grade);
}
