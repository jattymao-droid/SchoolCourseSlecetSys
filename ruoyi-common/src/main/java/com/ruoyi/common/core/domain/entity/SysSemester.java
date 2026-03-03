package com.ruoyi.common.core.domain.entity;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学期对象 sys_semester
 *
 * @author ruoyi
 */
public class SysSemester extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /** 学期ID */
    private Long id;

    /** 学期名称 */
    @Excel(name = "学期名称")
    private String semesterName;

    /** 开始日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "开始日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date startDate;

    /** 结束日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "结束日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date endDate;

    /** 是否当前学期 0否 1是 */
    @Excel(name = "是否当前", readConverterExp = "0=否,1=是")
    private Integer isCurrent;

    /** 选课开始时间（按东八区输出，前端按本地时间解析） */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @Excel(name = "选课开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date selectionStartTime;

    /** 选课结束时间（按东八区输出，前端按本地时间解析） */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @Excel(name = "选课结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date selectionEndTime;

    /** 删除标志 */
    private String delFlag;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSemesterName() {
        return semesterName;
    }

    public void setSemesterName(String semesterName) {
        this.semesterName = semesterName;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getIsCurrent() {
        return isCurrent;
    }

    public void setIsCurrent(Integer isCurrent) {
        this.isCurrent = isCurrent;
    }

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

    public Date getSelectionStartTime() {
        return selectionStartTime;
    }

    public void setSelectionStartTime(Date selectionStartTime) {
        this.selectionStartTime = selectionStartTime;
    }

    public Date getSelectionEndTime() {
        return selectionEndTime;
    }

    public void setSelectionEndTime(Date selectionEndTime) {
        this.selectionEndTime = selectionEndTime;
    }
}
