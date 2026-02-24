package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 评价题目对象 eva_question
 *
 * @author ruoyi
 */
public class EvaQuestion extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 题目ID */
    private Long id;

    /** 题目内容 */
    @Excel(name = "题目内容")
    private String content;

    /** 分值上限 */
    @Excel(name = "分值")
    private Integer score;

    /** 排序 */
    private Integer sort;

    /** 学期ID */
    @Excel(name = "学期ID")
    private Long semesterId;

    /** 状态 1启用 0停用 */
    @Excel(name = "状态", readConverterExp = "1=启用,0=停用")
    private Integer status;

    /** 删除标志 */
    private String delFlag;

    /** 学期名称（关联） */
    private String semesterName;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Integer getScore() { return score; }
    public void setScore(Integer score) { this.score = score; }
    public Integer getSort() { return sort; }
    public void setSort(Integer sort) { this.sort = sort; }
    public Long getSemesterId() { return semesterId; }
    public void setSemesterId(Long semesterId) { this.semesterId = semesterId; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }
    public String getSemesterName() { return semesterName; }
    public void setSemesterName(String semesterName) { this.semesterName = semesterName; }
}
