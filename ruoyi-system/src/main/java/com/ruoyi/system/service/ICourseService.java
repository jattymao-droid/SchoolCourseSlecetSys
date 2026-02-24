package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.common.core.domain.entity.CouCourse;
import com.ruoyi.system.domain.CourseSelectedStudentVO;

/**
 * 课程管理 业务层
 *
 * @author ruoyi
 */
public interface ICourseService
{
    List<CouCourse> selectCourseList(CouCourse course);

    CouCourse selectCourseById(Long id);

    int insertCourse(CouCourse course);

    int updateCourse(CouCourse course);

    int deleteCourseById(Long id);

    int copyToNewSemester(Long oldCourseId, Long newSemesterId);

    List<CourseSelectedStudentVO> selectSelectedStudents(Long courseId);

    /**
     * 指定学生到课程
     * @param courseId 课程ID
     * @param studentIds 学生ID列表（stu_student_info.user_id）
     * @return 成功指定的人数
     */
    int assignStudents(Long courseId, List<Long> studentIds);
}
