package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.domain.entity.SysClass;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.mapper.SysClassMapper;
import com.ruoyi.system.service.ISysClassService;

/**
 * 班级管理 服务实现
 *
 * @author ruoyi
 */
@Service
public class SysClassServiceImpl implements ISysClassService
{
    @Autowired
    private SysClassMapper classMapper;

    @Override
    public List<SysClass> selectClassList(SysClass sysClass)
    {
        return classMapper.selectClassList(sysClass);
    }

    @Override
    public SysClass selectClassById(Long id)
    {
        return classMapper.selectClassById(id);
    }

    @Override
    public int insertClass(SysClass sysClass)
    {
        return classMapper.insertClass(sysClass);
    }

    @Override
    public int updateClass(SysClass sysClass)
    {
        return classMapper.updateClass(sysClass);
    }

    @Override
    public int deleteClassById(Long id)
    {
        return classMapper.deleteClassById(id);
    }

    @Override
    public List<SysClass> selectClassByGradeId(Long gradeId)
    {
        SysClass query = new SysClass();
        query.setGradeId(gradeId);
        return classMapper.selectClassList(query);
    }
}
