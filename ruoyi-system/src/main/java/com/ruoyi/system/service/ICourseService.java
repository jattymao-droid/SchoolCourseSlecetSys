package com.ruoyi.system.service;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.multipart.MultipartFile;
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

    /**
     * 批量删除课程
     * @param ids 课程ID数组
     * @return 删除的课程数量
     */
    int deleteCourseByIds(Long[] ids);


    int copyToNewSemester(Long oldCourseId, Long newSemesterId);

    List<CourseSelectedStudentVO> selectSelectedStudents(Long courseId);

    /** 查询课程指定学生（管理员指定且已提交的） */
    List<CourseSelectedStudentVO> selectAssignedStudents(Long courseId);

    /**
     * 指定学生到课程
     * @param courseId 课程ID
     * @param studentIds 学生ID列表（stu_student_info.user_id）
     * @return 成功指定的人数
     */
    int assignStudents(Long courseId, List<Long> studentIds);



    /**
     * 初始化指定学期的选课数据：清空所有选课记录，重置班级容量已选人数为0
     *
     * @param semesterId 学期ID
     * @return 删除的选课记录数
     */
    int initSelectionData(Long semesterId);

    /**
     * 导入课程数据（Excel）
     *
     * @param file 上传的 Excel 文件
     * @param updateSupport 是否更新已存在课程
     * @param operName 操作用户
     * @return 导入结果提示信息
     */
    String importCourse(MultipartFile file, boolean updateSupport, String operName);

    /**
     * 导入课程数据（Excel，支持班级名额分配）
     *
     * @param file 上传的 Excel 文件
     * @param updateSupport 是否更新已存在课程
     * @param operName 操作用户
     * @return 导入结果提示信息
     */
    String importCourseWithQuota(MultipartFile file, boolean updateSupport, String operName);

    /**
     * 导出课程导入模板（多Sheet，每个年级一个Sheet，动态班级列）
     *
     * @param response HTTP响应
     */
    void exportCourseImportTemplate(HttpServletResponse response);

    /**
     * 导入分配学生（Excel）
     *
     * @param courseId 课程ID
     * @param file 上传的 Excel 文件
     * @param operName 操作用户
     * @return 导入结果提示信息
     */
    String importAssignStudents(Long courseId, MultipartFile file, String operName);
}
