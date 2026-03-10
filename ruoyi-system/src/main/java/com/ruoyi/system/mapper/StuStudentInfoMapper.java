package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.common.core.domain.entity.StuStudentInfo;

/**
 * 学生扩展信息 数据层
 *
 * @author ruoyi
 */
public interface StuStudentInfoMapper
{
    List<StuStudentInfo> selectStudentList(StuStudentInfo student);

    StuStudentInfo selectStudentById(Long id);

    StuStudentInfo selectStudentByUserId(Long userId);

    StuStudentInfo selectStudentByStudentNo(String studentNo);

    int countStudentByStudentNoPhysical(String studentNo);

    int insertStudent(StuStudentInfo student);

    int updateStudent(StuStudentInfo student);

    int deleteStudentById(Long id);
}
