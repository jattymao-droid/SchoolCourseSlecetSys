package com.ruoyi.common.core.domain.entity;

/**
 * 学生选课记录对象 stu_selection
 *
 * @author ruoyi
 */
public class StuSelection
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 学生ID（user_id） */
    private Long studentId;

    /** 课程ID */
    private Long courseId;

    /** 学期ID */
    private Long semesterId;

    /** 星期几 1-5 */
    private Integer weekDay;

    /** 班级ID */
    private Long classId;

    /** 状态 1正常 0退课删除 */
    private Integer status;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getStudentId() { return studentId; }
    public void setStudentId(Long studentId) { this.studentId = studentId; }
    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    public Long getSemesterId() { return semesterId; }
    public void setSemesterId(Long semesterId) { this.semesterId = semesterId; }
    public Integer getWeekDay() { return weekDay; }
    public void setWeekDay(Integer weekDay) { this.weekDay = weekDay; }
    public Long getClassId() { return classId; }
    public void setClassId(Long classId) { this.classId = classId; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
}
