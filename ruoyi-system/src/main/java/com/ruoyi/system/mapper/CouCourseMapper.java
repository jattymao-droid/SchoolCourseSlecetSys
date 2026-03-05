package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.common.core.domain.entity.CouCourse;
import com.ruoyi.system.domain.CourseSelectedStudentVO;

/**
 * 课程 数据层
 *
 * @author ruoyi
 */
public interface CouCourseMapper
{
    List<CouCourse> selectCourseList(CouCourse course);

    CouCourse selectCourseById(Long id);

    int insertCourse(CouCourse course);

    int updateCourse(CouCourse course);

    int deleteCourseById(Long id);

    List<CourseSelectedStudentVO> selectSelectedStudentsByCourseId(Long courseId);

    /** 查询课程指定学生（assigned=1） */
    List<CourseSelectedStudentVO> selectAssignedStudentsByCourseId(Long courseId);

    /** 热门课程（按选课人数排序，取前 N 条） */
    List<com.ruoyi.system.domain.PopularCourseVO> selectPopularCourses(@Param("semesterId") Long semesterId, @Param("limit") int limit);
}
