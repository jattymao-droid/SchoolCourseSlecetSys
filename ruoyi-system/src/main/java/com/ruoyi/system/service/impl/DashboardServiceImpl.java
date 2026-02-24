package com.ruoyi.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.domain.entity.CouCourse;
import com.ruoyi.common.core.domain.entity.EvaQuestion;
import com.ruoyi.common.core.domain.entity.SysSemester;
import com.ruoyi.common.core.domain.entity.StuStudentInfo;
import com.ruoyi.system.domain.CourseToEvaluateVO;
import com.ruoyi.system.domain.PopularCourseVO;
import com.ruoyi.system.domain.RecentSelectionVO;
import com.ruoyi.system.domain.SelectionTrendVO;
import com.ruoyi.system.mapper.CouCourseMapper;
import com.ruoyi.system.mapper.EvaQuestionMapper;
import com.ruoyi.system.mapper.StuSelectionMapper;
import com.ruoyi.system.service.ICourseService;
import com.ruoyi.system.service.IDashboardService;
import com.ruoyi.system.service.IEvaluationService;
import com.ruoyi.system.service.ISysSemesterService;
import com.ruoyi.system.service.IStudentService;

/**
 * 首页看板 服务实现
 *
 * @author ruoyi
 */
@Service
public class DashboardServiceImpl implements IDashboardService
{
    @Autowired
    private ISysSemesterService semesterService;

    @Autowired
    private ICourseService courseService;

    @Autowired
    private IStudentService studentService;

    @Autowired
    private IEvaluationService evaluationService;

    @Autowired
    private StuSelectionMapper selectionMapper;

    @Autowired
    private EvaQuestionMapper questionMapper;

    @Autowired
    private CouCourseMapper courseMapper;

    @Override
    public Map<String, Object> getAdminStats()
    {
        Map<String, Object> result = new HashMap<>();
        SysSemester current = semesterService.getCurrentSemester();
        result.put("currentSemester", current);

        List<SysSemester> semesters = semesterService.selectSemesterList(new SysSemester());
        result.put("semesterCount", semesters != null ? semesters.size() : 0);

        CouCourse courseQuery = new CouCourse();
        if (current != null)
        {
            courseQuery.setSemesterId(current.getId());
        }
        List<CouCourse> courses = courseService.selectCourseList(courseQuery);
        result.put("courseCount", courses != null ? courses.size() : 0);

        List<StuStudentInfo> students = studentService.selectStudentList(new StuStudentInfo());
        result.put("studentCount", students != null ? students.size() : 0);

        long selectionCount = 0;
        int questionCount = 0;
        if (current != null)
        {
            selectionCount = selectionMapper.countBySemesterId(current.getId());
            EvaQuestion q = new EvaQuestion();
            q.setSemesterId(current.getId());
            List<EvaQuestion> questions = questionMapper.selectQuestionList(q);
            questionCount = questions != null ? questions.size() : 0;
        }
        result.put("selectionCount", selectionCount);
        result.put("questionCount", questionCount);

        if (current != null)
        {
            List<SelectionTrendVO> trend = selectionMapper.selectTrendByDate(current.getId(), 14);
            result.put("selectionTrend", trend != null ? trend : List.of());

            List<RecentSelectionVO> recent = selectionMapper.selectRecentSelections(current.getId(), 8);
            result.put("recentSelections", recent != null ? recent : List.of());

            List<Map<String, Object>> byWeekday = selectionMapper.selectCountByWeekday(current.getId());
            result.put("selectionByWeekday", byWeekday != null ? byWeekday : List.of());

            List<PopularCourseVO> popular = courseMapper.selectPopularCourses(current.getId(), 6);
            result.put("popularCourses", popular != null ? popular : List.of());
        }
        else
        {
            result.put("selectionTrend", List.of());
            result.put("recentSelections", List.of());
            result.put("selectionByWeekday", List.of());
            result.put("popularCourses", List.of());
        }

        return result;
    }

    @Override
    public Map<String, Object> getStudentStats(Long userId)
    {
        Map<String, Object> result = new HashMap<>();
        SysSemester current = semesterService.getCurrentSemester();
        result.put("currentSemester", current);

        StuStudentInfo student = studentService.selectStudentByUserId(userId);
        if (student == null)
        {
            result.put("selectionCount", 0);
            result.put("pendingEvaluationCount", 0);
            result.put("coursesToEvaluate", List.of());
            return result;
        }

        Long studentId = student.getId();
        long selectionCount = 0;
        int pendingEvaluationCount = 0;
        List<CourseToEvaluateVO> coursesToEvaluate = List.of();

        if (current != null)
        {
            List<com.ruoyi.system.domain.MySelectionVO> selections =
                selectionMapper.selectMySelections(studentId, current.getId());
            selectionCount = selections != null ? selections.size() : 0;

            coursesToEvaluate = evaluationService.getCoursesToEvaluate(studentId, current.getId());
            if (coursesToEvaluate != null)
            {
                pendingEvaluationCount = (int) coursesToEvaluate.stream().filter(c -> !Boolean.TRUE.equals(c.getEvaluated())).count();
            }
        }

        result.put("selectionCount", selectionCount);
        result.put("pendingEvaluationCount", pendingEvaluationCount);
        result.put("coursesToEvaluate", coursesToEvaluate != null ? coursesToEvaluate : List.of());

        if (current != null)
        {
            List<PopularCourseVO> popular = courseMapper.selectPopularCourses(current.getId(), 4);
            result.put("popularCourses", popular != null ? popular : List.of());
        }
        else
        {
            result.put("popularCourses", List.of());
        }

        return result;
    }
}
