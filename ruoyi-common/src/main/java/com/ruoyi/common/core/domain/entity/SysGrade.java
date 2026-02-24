package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 年级对象 sys_grade
 *
 * @author ruoyi
 */
public class SysGrade extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 年级ID */
    private Long id;

    /** 年级名称 */
    @Excel(name = "年级名称")
    private String gradeName;

    /** 排序（用于一键升级） */
    @Excel(name = "排序")
    private Integer sort;

    /** 删除标志 */
    private String delFlag;

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getGradeName()
    {
        return gradeName;
    }

    public void setGradeName(String gradeName)
    {
        this.gradeName = gradeName;
    }

    public Integer getSort()
    {
        return sort;
    }

    public void setSort(Integer sort)
    {
        this.sort = sort;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }
}
