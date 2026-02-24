package com.ruoyi.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.domain.entity.SysGrade;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.mapper.SysGradeMapper;
import com.ruoyi.system.service.ISysGradeService;

/**
 * 年级管理 服务实现
 *
 * @author ruoyi
 */
@Service
public class SysGradeServiceImpl implements ISysGradeService
{
    /** 年级名称升级映射：当前名称 -> 下一级名称 */
    private static final Map<String, String> GRADE_UPGRADE_MAP = new HashMap<>();
    static {
        GRADE_UPGRADE_MAP.put("一年级", "二年级");
        GRADE_UPGRADE_MAP.put("二年级", "三年级");
        GRADE_UPGRADE_MAP.put("三年级", "四年级");
        GRADE_UPGRADE_MAP.put("四年级", "五年级");
        GRADE_UPGRADE_MAP.put("五年级", "六年级");
        GRADE_UPGRADE_MAP.put("六年级", "初一");
        GRADE_UPGRADE_MAP.put("初一", "初二");
        GRADE_UPGRADE_MAP.put("初二", "初三");
        GRADE_UPGRADE_MAP.put("初三", "高一");
        GRADE_UPGRADE_MAP.put("高一", "高二");
        GRADE_UPGRADE_MAP.put("高二", "高三");
        GRADE_UPGRADE_MAP.put("高三", "高三"); // 毕业班保持不变
    }

    @Autowired
    private SysGradeMapper gradeMapper;

    @Override
    public List<SysGrade> selectGradeList(SysGrade grade)
    {
        return gradeMapper.selectGradeList(grade);
    }

    @Override
    public SysGrade selectGradeById(Long id)
    {
        return gradeMapper.selectGradeById(id);
    }

    @Override
    public int insertGrade(SysGrade grade)
    {
        if (grade.getSort() == null) {
            grade.setSort(0);
        }
        return gradeMapper.insertGrade(grade);
    }

    @Override
    public int updateGrade(SysGrade grade)
    {
        return gradeMapper.updateGrade(grade);
    }

    @Override
    public int deleteGradeById(Long id)
    {
        return gradeMapper.deleteGradeById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int upgradeGrades()
    {
        List<SysGrade> grades = gradeMapper.selectGradeList(new SysGrade());
        int count = 0;
        for (SysGrade g : grades)
        {
            String nextName = GRADE_UPGRADE_MAP.get(g.getGradeName());
            if (StringUtils.isNotEmpty(nextName) && !nextName.equals(g.getGradeName()))
            {
                g.setGradeName(nextName);
                count += gradeMapper.updateGrade(g);
            }
        }
        return count;
    }
}
