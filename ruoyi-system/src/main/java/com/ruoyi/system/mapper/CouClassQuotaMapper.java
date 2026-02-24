package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.common.core.domain.entity.CouClassQuota;

/**
 * 课程班级容量 数据层
 *
 * @author ruoyi
 */
public interface CouClassQuotaMapper
{
    List<CouClassQuota> selectQuotaByCourseId(Long courseId);

    int insertQuota(CouClassQuota quota);

    int batchInsertQuota(List<CouClassQuota> list);

    int deleteByCourseId(Long courseId);

    int physicalDeleteByCourseId(Long courseId);

    int updateQuota(CouClassQuota quota);

    CouClassQuota selectByCourseAndClass(@Param("courseId") Long courseId, @Param("classId") Long classId);

    /** 班级已选人数 +1 */
    int incrementSelected(@Param("courseId") Long courseId, @Param("classId") Long classId);

    /** 班级已选人数 +1（并发控制：仅当 selected < quota 时更新，返回影响行数） */
    int incrementSelectedIfAvailable(@Param("courseId") Long courseId, @Param("classId") Long classId);

    /** 班级已选人数 -1（退课时回退） */
    int decrementSelected(@Param("courseId") Long courseId, @Param("classId") Long classId);
}
