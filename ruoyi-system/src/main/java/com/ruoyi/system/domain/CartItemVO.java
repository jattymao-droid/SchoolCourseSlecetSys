package com.ruoyi.system.domain;

import java.io.Serializable;

/**
 * 选课车项 VO（Redis Hash 存储）
 *
 * @author ruoyi
 */
public class CartItemVO implements Serializable
{
    private static final long serialVersionUID = 1L;

    /** 课程ID */
    private Long courseId;

    /** 课程名称 */
    private String courseName;

    /** 星期几 1-5 */
    private Integer weekDay;

    /** 班级ID（学生所在班级） */
    private Long classId;

    /** 班级名称 */
    private String className;

    /** 教师姓名 */
    private String teacherName;

    /** 学期ID */
    private Long semesterId;

    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public Integer getWeekDay() { return weekDay; }
    public void setWeekDay(Integer weekDay) { this.weekDay = weekDay; }
    public Long getClassId() { return classId; }
    public void setClassId(Long classId) { this.classId = classId; }
    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }
    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }
    public Long getSemesterId() { return semesterId; }
    public void setSemesterId(Long semesterId) { this.semesterId = semesterId; }
}
