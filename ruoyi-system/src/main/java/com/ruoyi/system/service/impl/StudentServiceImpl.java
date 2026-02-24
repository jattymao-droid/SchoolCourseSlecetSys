package com.ruoyi.system.service.impl;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.domain.entity.SysClass;
import com.ruoyi.common.core.domain.entity.StuStudentInfo;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.StudentImportDTO;
import com.ruoyi.system.mapper.SysClassMapper;
import com.ruoyi.system.mapper.StuStudentInfoMapper;
import com.ruoyi.system.service.IStudentService;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysUserService;

/**
 * 学生管理 服务实现
 *
 * @author ruoyi
 */
@Service
public class StudentServiceImpl implements IStudentService
{
    private static final Logger log = LoggerFactory.getLogger(StudentServiceImpl.class);

    /** 学生角色ID */
    private static final Long STUDENT_ROLE_ID = 102L;

    /** 默认密码配置键 */
    private static final String CONFIG_DEFAULT_PASSWORD = "course.default_password";

    /** 规则：学号后6位 */
    private static final String RULE_LAST6 = "last6";

    /** 规则：学号全文 */
    private static final String RULE_FULL = "full";

    @Autowired
    private StuStudentInfoMapper studentMapper;

    @Autowired
    private SysClassMapper classMapper;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysConfigService configService;

    @Override
    public List<StuStudentInfo> selectStudentList(StuStudentInfo student)
    {
        return studentMapper.selectStudentList(student);
    }

    @Override
    public StuStudentInfo selectStudentById(Long id)
    {
        return studentMapper.selectStudentById(id);
    }

    @Override
    public StuStudentInfo selectStudentByUserId(Long userId)
    {
        return studentMapper.selectStudentByUserId(userId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertStudent(StuStudentInfo student)
    {
        if (studentMapper.selectStudentByStudentNo(student.getStudentNo()) != null)
        {
            throw new ServiceException("学号 " + student.getStudentNo() + " 已存在");
        }
        SysUser existUser = userService.selectUserByUserName(student.getStudentNo());
        if (existUser != null)
        {
            throw new ServiceException("学号 " + student.getStudentNo() + " 已关联用户，请勿重复添加");
        }
        SysUser user = buildStudentUser(student);
        userService.insertUser(user);
        student.setUserId(user.getUserId());
        return studentMapper.insertStudent(student);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateStudent(StuStudentInfo student)
    {
        StuStudentInfo exist = studentMapper.selectStudentById(student.getId());
        if (exist == null)
        {
            throw new ServiceException("学生信息不存在");
        }
        if (!exist.getStudentNo().equals(student.getStudentNo()))
        {
            StuStudentInfo dup = studentMapper.selectStudentByStudentNo(student.getStudentNo());
            if (dup != null)
            {
                throw new ServiceException("学号 " + student.getStudentNo() + " 已存在");
            }
        }
        return studentMapper.updateStudent(student);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteStudentById(Long id)
    {
        StuStudentInfo student = studentMapper.selectStudentById(id);
        if (student == null)
        {
            return 0;
        }
        studentMapper.deleteStudentById(id);
        userService.deleteUserById(student.getUserId());
        return 1;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String importStudent(MultipartFile file, String operName) throws Exception
    {
        ExcelUtil<StudentImportDTO> util = new ExcelUtil<>(StudentImportDTO.class);
        List<StudentImportDTO> list = util.importExcel(file.getInputStream());
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();

        for (StudentImportDTO dto : list)
        {
            try
            {
                if (StringUtils.isEmpty(dto.getStudentNo()) || StringUtils.isEmpty(dto.getRealName())
                    || StringUtils.isEmpty(dto.getGradeName()) || StringUtils.isEmpty(dto.getClassName()))
                {
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("、学号 ").append(dto.getStudentNo())
                        .append(" 导入失败：学号、姓名、年级名称、班级名称均不能为空");
                    continue;
                }
                SysClass sysClass = classMapper.selectByGradeNameAndClassName(dto.getGradeName(), dto.getClassName());
                if (sysClass == null)
                {
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("、学号 ").append(dto.getStudentNo())
                        .append(" 导入失败：未找到年级【").append(dto.getGradeName()).append("】下的班级【").append(dto.getClassName()).append("】");
                    continue;
                }
                if (studentMapper.selectStudentByStudentNo(dto.getStudentNo()) != null
                    || userService.selectUserByUserName(dto.getStudentNo()) != null)
                {
                    failureNum++;
                    failureMsg.append("<br/>").append(failureNum).append("、学号 ").append(dto.getStudentNo()).append(" 已存在");
                    continue;
                }
                StuStudentInfo student = new StuStudentInfo();
                student.setStudentNo(dto.getStudentNo().trim());
                student.setRealName(dto.getRealName().trim());
                student.setClassId(sysClass.getId());
                student.setGradeId(sysClass.getGradeId());
                SysUser user = buildStudentUser(student);
                user.setCreateBy(operName);
                userService.insertUser(user);
                student.setUserId(user.getUserId());
                studentMapper.insertStudent(student);
                successNum++;
                successMsg.append("<br/>").append(successNum).append("、学号 ").append(dto.getStudentNo()).append(" 导入成功");
            }
            catch (Exception e)
            {
                failureNum++;
                failureMsg.append("<br/>").append(failureNum).append("、学号 ").append(dto.getStudentNo())
                    .append(" 导入失败：").append(e.getMessage());
                log.error("学生导入失败", e);
            }
        }
        if (failureNum > 0)
        {
            failureMsg.insert(0, "导入失败！共 " + failureNum + " 条数据格式不正确：");
        }
        if (successNum > 0)
        {
            successMsg.insert(0, "导入成功！共 " + successNum + " 条");
        }
        return successMsg.toString() + failureMsg.toString();
    }

    @Override
    public int resetPassword(Long userId, String newPassword)
    {
        StuStudentInfo student = studentMapper.selectStudentByUserId(userId);
        String pwd = StringUtils.isNotEmpty(newPassword) ? newPassword : (student != null ? getDefaultPassword(student.getStudentNo()) : "123456");
        return userService.resetUserPwd(userId, SecurityUtils.encryptPassword(pwd));
    }

    /**
     * 构建学生用户（用于新增）
     */
    private SysUser buildStudentUser(StuStudentInfo student)
    {
        SysUser user = new SysUser();
        user.setUserName(student.getStudentNo());
        user.setNickName(student.getRealName());
        user.setUserType("01"); // 学生
        user.setStatus(UserConstants.NORMAL);
        String defaultPwd = getDefaultPassword(student.getStudentNo());
        user.setPassword(SecurityUtils.encryptPassword(defaultPwd));
        user.setRoleIds(new Long[]{ STUDENT_ROLE_ID });
        return user;
    }

    /**
     * 根据配置生成默认密码
     * 配置规则：last6=学号后6位（不足用学号）| full=学号全文 | 其他=固定密码
     */
    private String getDefaultPassword(String studentNo)
    {
        if (StringUtils.isEmpty(studentNo))
        {
            return "123456";
        }
        String rule = configService.selectConfigByKey(CONFIG_DEFAULT_PASSWORD);
        if (StringUtils.isEmpty(rule))
        {
            rule = RULE_LAST6;
        }
        rule = rule.trim().toLowerCase();
        if (RULE_LAST6.equals(rule))
        {
            return studentNo.length() >= 6 ? studentNo.substring(studentNo.length() - 6) : studentNo;
        }
        if (RULE_FULL.equals(rule))
        {
            return studentNo;
        }
        return StringUtils.isNotEmpty(rule) ? rule : "123456";
    }
}
