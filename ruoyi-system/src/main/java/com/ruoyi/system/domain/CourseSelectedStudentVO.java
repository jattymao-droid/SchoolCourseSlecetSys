package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import java.util.Date;

/**
 * 课程已选学生 VO
 *
 * @author ruoyi
 */
public class CourseSelectedStudentVO
{
    /** 学生ID（user_id） */
    private Long userId;

    @Excel(name = "学号")
    private String studentNo;

    @Excel(name = "姓名")
    private String realName;

    @Excel(name = "班级")
    private String className;

    @Excel(name = "选课时间", dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getStudentNo() { return studentNo; }
    public void setStudentNo(String studentNo) { this.studentNo = studentNo; }
    public String getRealName() { return realName; }
    public void setRealName(String realName) { this.realName = realName; }
    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}
