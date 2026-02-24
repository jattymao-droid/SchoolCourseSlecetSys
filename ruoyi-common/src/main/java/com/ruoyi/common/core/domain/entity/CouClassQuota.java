package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 课程班级容量对象 cou_class_quota
 *
 * @author ruoyi
 */
public class CouClassQuota extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 课程ID */
    private Long courseId;

    /** 班级ID */
    private Long classId;

    /** 名额上限 */
    @Excel(name = "名额")
    private Integer quota;

    /** 已选人数 */
    @Excel(name = "已选")
    private Integer selected;

    /** 删除标志 */
    private String delFlag;

    /** 班级名称（关联查询） */
    private String className;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    public Long getClassId() { return classId; }
    public void setClassId(Long classId) { this.classId = classId; }
    public Integer getQuota() { return quota; }
    public void setQuota(Integer quota) { this.quota = quota; }
    public Integer getSelected() { return selected; }
    public void setSelected(Integer selected) { this.selected = selected; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }
    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }
}
