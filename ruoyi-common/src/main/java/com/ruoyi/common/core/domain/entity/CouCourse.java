package com.ruoyi.common.core.domain.entity;

import java.util.List;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 课程对象 cou_course
 *
 * @author ruoyi
 */
public class CouCourse extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 课程ID */
    private Long id;

    /** 课程名称 */
    @Excel(name = "课程名称")
    private String courseName;

    /** 星期几 1-5 */
    @Excel(name = "星期", readConverterExp = "1=周一,2=周二,3=周三,4=周四,5=周五")
    private Integer weekDay;

    /** 年级ID */
    @Excel(name = "年级ID")
    private Long gradeId;

    /** 教师ID */
    @Excel(name = "教师ID")
    private Long teacherId;

    /** 课程描述 */
    private String description;

    /** 学期ID */
    @Excel(name = "学期ID")
    private Long semesterId;

    /** 删除标志 */
    private String delFlag;

    /** 年级名称（关联查询） */
    private String gradeName;

    /** 教师姓名（关联查询） */
    private String teacherName;

    /** 上课地点 */
    @Excel(name = "上课地点")
    @JsonInclude(JsonInclude.Include.ALWAYS)
    private String location;

    /** 学期名称（关联查询） */
    private String semesterName;

    /** 班级容量列表（编辑时加载，保存时写入） */
    private List<CouClassQuota> quotaList;

    /** 班级ID（选课列表查询用，指定班级时返回该班名额信息） */
    private Long classId;

    /** 班级名额（选课列表用，来自 cou_class_quota.quota） */
    private Integer quota;

    /** 已选人数（选课列表用，来自 cou_class_quota.selected） */
    private Integer selected;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public Integer getWeekDay() { return weekDay; }
    public void setWeekDay(Integer weekDay) { this.weekDay = weekDay; }
    public Long getGradeId() { return gradeId; }
    public void setGradeId(Long gradeId) { this.gradeId = gradeId; }
    public Long getTeacherId() { return teacherId; }
    public void setTeacherId(Long teacherId) { this.teacherId = teacherId; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Long getSemesterId() { return semesterId; }
    public void setSemesterId(Long semesterId) { this.semesterId = semesterId; }
    public String getDelFlag() { return delFlag; }
    public void setDelFlag(String delFlag) { this.delFlag = delFlag; }
    public String getGradeName() { return gradeName; }
    public void setGradeName(String gradeName) { this.gradeName = gradeName; }
    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getSemesterName() { return semesterName; }
    public void setSemesterName(String semesterName) { this.semesterName = semesterName; }
    public List<CouClassQuota> getQuotaList() { return quotaList; }
    public void setQuotaList(List<CouClassQuota> quotaList) { this.quotaList = quotaList; }
    public Long getClassId() { return classId; }
    public void setClassId(Long classId) { this.classId = classId; }
    public Integer getQuota() { return quota; }
    public void setQuota(Integer quota) { this.quota = quota; }
    public Integer getSelected() { return selected; }
    public void setSelected(Integer selected) { this.selected = selected; }
}
