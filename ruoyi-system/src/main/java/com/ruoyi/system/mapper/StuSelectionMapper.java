package com.ruoyi.system.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.common.core.domain.entity.StuSelection;
import com.ruoyi.system.domain.MySelectionVO;

/**
 * 学生选课记录 数据层
 *
 * @author ruoyi
 */
public interface StuSelectionMapper
{
    int insertSelection(StuSelection selection);

    /** 检查学生在该学期该星期是否已有选课（status=1） */
    int countByStudentSemesterWeekDay(@Param("studentId") Long studentId,
                                     @Param("semesterId") Long semesterId,
                                     @Param("weekDay") Integer weekDay);

    /** 检查学生是否已选该课程（status=1） */
    int countByStudentAndCourse(@Param("studentId") Long studentId, @Param("courseId") Long courseId);

    /** 查询学生某学期的已选课程列表（含课程信息） */
    List<MySelectionVO> selectMySelections(@Param("studentId") Long studentId, @Param("semesterId") Long semesterId);

    /** 根据ID查询选课记录 */
    StuSelection selectById(@Param("id") Long id);

    /** 逻辑删除（status=0） */
    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    /** 统计某学期有效选课记录数（status=1） */
    int countBySemesterId(@Param("semesterId") Long semesterId);

    /** 按日期统计选课人次（最近 N 天） */
    List<com.ruoyi.system.domain.SelectionTrendVO> selectTrendByDate(@Param("semesterId") Long semesterId, @Param("days") int days);

    /** 最近选课记录（学生名、课程名、时间） */
    List<com.ruoyi.system.domain.RecentSelectionVO> selectRecentSelections(@Param("semesterId") Long semesterId, @Param("limit") int limit);

    /** 按星期统计选课分布（week_day, cnt） */
    List<Map<String, Object>> selectCountByWeekday(@Param("semesterId") Long semesterId);

    /** 删除指定学期的所有选课记录（物理删除） */
    int deleteBySemesterId(@Param("semesterId") Long semesterId);
}
