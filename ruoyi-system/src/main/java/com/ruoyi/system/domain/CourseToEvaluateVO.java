package com.ruoyi.system.domain;

import java.util.List;

/**
 * 待评价课程 VO（含题目列表）
 *
 * @author ruoyi
 */
public class CourseToEvaluateVO
{
    /** 课程ID */
    private Long courseId;

    /** 课程名称 */
    private String courseName;

    /** 星期几 */
    private Integer weekDay;

    /** 教师姓名 */
    private String teacherName;

    /** 学期ID */
    private Long semesterId;

    /** 评价题目列表（仅启用的） */
    private List<QuestionVO> questions;

    /** 是否已全部评价 */
    private Boolean evaluated;

    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    public Integer getWeekDay() { return weekDay; }
    public void setWeekDay(Integer weekDay) { this.weekDay = weekDay; }
    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }
    public Long getSemesterId() { return semesterId; }
    public void setSemesterId(Long semesterId) { this.semesterId = semesterId; }
    public List<QuestionVO> getQuestions() { return questions; }
    public void setQuestions(List<QuestionVO> questions) { this.questions = questions; }
    public Boolean getEvaluated() { return evaluated; }
    public void setEvaluated(Boolean evaluated) { this.evaluated = evaluated; }

    public static class QuestionVO
    {
        private Long questionId;
        private String content;
        private Integer score;

        public Long getQuestionId() { return questionId; }
        public void setQuestionId(Long questionId) { this.questionId = questionId; }
        public String getContent() { return content; }
        public void setContent(String content) { this.content = content; }
        public Integer getScore() { return score; }
        public void setScore(Integer score) { this.score = score; }
    }
}
