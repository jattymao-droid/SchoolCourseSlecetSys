package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.common.core.domain.entity.StuStudentInfo;
import org.springframework.web.multipart.MultipartFile;

/**
 * 学生管理 业务层
 *
 * @author ruoyi
 */
public interface IStudentService
{
    List<StuStudentInfo> selectStudentList(StuStudentInfo student);

    StuStudentInfo selectStudentById(Long id);

    StuStudentInfo selectStudentByUserId(Long userId);

    int insertStudent(StuStudentInfo student);

    int updateStudent(StuStudentInfo student);

    int deleteStudentById(Long id);

    String importStudent(MultipartFile file, String operName) throws Exception;

    /**
     * 重置密码，若 newPassword 为空则使用学号后6位
     */
    int resetPassword(Long userId, String newPassword);
}
