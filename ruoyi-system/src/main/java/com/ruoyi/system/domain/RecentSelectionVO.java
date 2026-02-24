package com.ruoyi.system.domain;

import java.util.Date;

/**
 * 最近选课记录 VO
 *
 * @author ruoyi
 */
public class RecentSelectionVO
{
    private String studentName;
    private String courseName;
    private String weekDayName;
    private Date createTime;

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public String getWeekDayName() { return weekDayName; }
    public void setWeekDayName(String weekDayName) { this.weekDayName = weekDayName; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
