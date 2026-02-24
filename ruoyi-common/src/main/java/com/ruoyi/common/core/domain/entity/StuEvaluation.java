package com.ruoyi.common.core.domain.entity;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 学生评分对象 stu_evaluation
 *
 * @author ruoyi
 */
public class StuEvaluation extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 评分ID */
    private Long id;

    /** 学生ID */
    private Long studentId;

    /** 课程ID */
    private Long courseId;

    /** 题目ID */
    private Long questionId;

    /** 得分 */
    private Integer score;

    /** 学期ID */
    private Long semesterId;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getStudentId() { return studentId; }
    public void setStudentId(Long studentId) { this.studentId = studentId; }
    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    public Long getQuestionId() { return questionId; }
    public void setQuestionId(Long questionId) { this.questionId = questionId; }
    public Integer getScore() { return score; }
    public void setScore(Integer score) { this.score = score; }
    public Long getSemesterId() { return semesterId; }
    public void setSemesterId(Long semesterId) { this.semesterId = semesterId; }
}
