package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.common.core.domain.entity.SysClass;

/**
 * 班级管理 服务层
 *
 * @author ruoyi
 */
public interface ISysClassService
{
    List<SysClass> selectClassList(SysClass sysClass);

    SysClass selectClassById(Long id);

    int insertClass(SysClass sysClass);

    int updateClass(SysClass sysClass);

    int deleteClassById(Long id);

    List<SysClass> selectClassByGradeId(Long gradeId);
}
