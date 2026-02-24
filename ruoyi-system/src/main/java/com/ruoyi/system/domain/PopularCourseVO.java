package com.ruoyi.system.domain;

/**
 * 热门课程 VO（按选课人数排序）
 *
 * @author ruoyi
 */
public class PopularCourseVO
{
    private Long courseId;
    private String courseName;
    private String teacherName;
    private Integer weekDay;
    private Long selectedCount;

    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }
    public Integer getWeekDay() { return weekDay; }
    public void setWeekDay(Integer weekDay) { this.weekDay = weekDay; }
    public Long getSelectedCount() { return selectedCount; }
    public void setSelectedCount(Long selectedCount) { this.selectedCount = selectedCount; }
}
