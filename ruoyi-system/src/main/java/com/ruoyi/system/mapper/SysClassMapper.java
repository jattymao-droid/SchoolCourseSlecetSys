package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.common.core.domain.entity.SysClass;

/**
 * 班级管理 数据层
 *
 * @author ruoyi
 */
public interface SysClassMapper
{
    List<SysClass> selectClassList(SysClass sysClass);

    SysClass selectClassById(Long id);

    int insertClass(SysClass sysClass);

    int updateClass(SysClass sysClass);

    int deleteClassById(Long id);

    int countByGradeId(@Param("gradeId") Long gradeId);

    SysClass checkClassNameUnique(@Param("className") String className, @Param("gradeId") Long gradeId);

    SysClass selectByGradeNameAndClassName(@Param("gradeName") String gradeName, @Param("className") String className);
}
