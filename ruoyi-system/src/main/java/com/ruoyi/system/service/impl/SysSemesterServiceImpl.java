package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.domain.entity.SysSemester;
import com.ruoyi.system.mapper.SysSemesterMapper;
import com.ruoyi.system.service.ISysSemesterService;

/**
 * 学期管理 服务实现
 *
 * @author ruoyi
 */
@Service
public class SysSemesterServiceImpl implements ISysSemesterService
{
    @Autowired
    private SysSemesterMapper semesterMapper;

    @Override
    public List<SysSemester> selectSemesterList(SysSemester semester)
    {
        return semesterMapper.selectSemesterList(semester);
    }

    @Override
    public SysSemester selectSemesterById(Long id)
    {
        return semesterMapper.selectSemesterById(id);
    }

    @Override
    public int insertSemester(SysSemester semester)
    {
        return semesterMapper.insertSemester(semester);
    }

    @Override
    public int updateSemester(SysSemester semester)
    {
        return semesterMapper.updateSemester(semester);
    }

    @Override
    public int deleteSemesterById(Long id)
    {
        return semesterMapper.deleteSemesterById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int setCurrentSemester(Long id)
    {
        semesterMapper.clearCurrentSemester();
        return semesterMapper.setCurrentSemester(id);
    }

    @Override
    public SysSemester getCurrentSemester()
    {
        SysSemester query = new SysSemester();
        query.setIsCurrent(1);
        List<SysSemester> list = semesterMapper.selectSemesterList(query);
        return list.isEmpty() ? null : list.get(0);
    }
}
