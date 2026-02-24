package com.ruoyi.system.domain;

import java.util.List;
import javax.validation.constraints.NotNull;

/**
 * 提交评价 DTO
 *
 * @author ruoyi
 */
public class SubmitEvaluationDTO
{
    /** 课程ID */
    @NotNull(message = "课程ID不能为空")
    private Long courseId;

    /** 学期ID */
    @NotNull(message = "学期ID不能为空")
    private Long semesterId;

    /** 评分列表：questionId -> score */
    @NotNull(message = "评分不能为空")
    private List<QuestionScore> scores;

    public Long getCourseId() { return courseId; }
    public void setCourseId(Long courseId) { this.courseId = courseId; }
    public Long getSemesterId() { return semesterId; }
    public void setSemesterId(Long semesterId) { this.semesterId = semesterId; }
    public List<QuestionScore> getScores() { return scores; }
    public void setScores(List<QuestionScore> scores) { this.scores = scores; }

    public static class QuestionScore
    {
        private Long questionId;
        private Integer score;

        public Long getQuestionId() { return questionId; }
        public void setQuestionId(Long questionId) { this.questionId = questionId; }
        public Integer getScore() { return score; }
        public void setScore(Integer score) { this.score = score; }
    }
}
