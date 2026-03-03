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

    /**
     * 导入课程数据
     *
     * @param courseList 课程数据列表
     * @param isUpdateSupport 是否更新支持，如果已存在，则进行更新数据
     * @param operName 操作用户
     * @return 结果
     */
    String importCourse(List<CouCourse> courseList, Boolean isUpdateSupport, String operName);

    /**
     * 初始化指定学期的选课数据：清空所有选课记录，重置班级容量已选人数为0
     *
     * @param semesterId 学期ID
     * @return 删除的选课记录数
     */
    int initSelectionData(Long semesterId);
}
