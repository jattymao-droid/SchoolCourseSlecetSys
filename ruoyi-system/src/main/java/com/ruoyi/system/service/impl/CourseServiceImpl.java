package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.entity.CouClassQuota;
import com.ruoyi.common.core.domain.entity.CouCourse;
import com.ruoyi.common.core.domain.entity.SysClass;
import com.ruoyi.common.core.domain.entity.SysGrade;
import com.ruoyi.common.core.domain.entity.SysSemester;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.AssignStudentsImportDTO;
import com.ruoyi.system.domain.CourseSelectedStudentVO;
import com.ruoyi.common.core.domain.entity.StuStudentInfo;
import com.ruoyi.system.mapper.CouClassQuotaMapper;
import com.ruoyi.system.mapper.CouCourseMapper;
import com.ruoyi.system.mapper.SysClassMapper;
import com.ruoyi.system.mapper.StuSelectionMapper;
import com.ruoyi.system.mapper.StuStudentInfoMapper;
import com.ruoyi.system.service.ICourseService;
import com.ruoyi.system.service.ISelectionService;
import com.ruoyi.system.service.ISysGradeService;
import com.ruoyi.system.service.ISysSemesterService;
import com.ruoyi.common.core.domain.dto.CourseImportDTO;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.system.service.ISysDeptService;
import com.ruoyi.common.core.domain.entity.SysDept;

/**
 * 课程管理 服务实现
 *
 * @author ruoyi
 */
@Service
public class CourseServiceImpl implements ICourseService
{
    /** 教师角色ID（与 sql/course_selection_init.sql 中 role_id=101 对应） */
    private static final Long TEACHER_ROLE_ID = 101L;

    /** 教师默认密码 */
    private static final String TEACHER_DEFAULT_PASSWORD = "123456";

    /** 默认部门ID（与 demo 数据一致，教师/学生归属） */
    private static final Long DEFAULT_DEPT_ID = 103L;

    @Autowired
    private CouCourseMapper courseMapper;

    @Autowired
    private CouClassQuotaMapper quotaMapper;

    @Autowired
    private StuSelectionMapper selectionMapper;

    @Autowired
    private StuStudentInfoMapper studentMapper;

    @Autowired
    private ISysGradeService gradeService;

    @Autowired
    private ISysSemesterService semesterService;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISelectionService selectionService;

    @Autowired
    private SysClassMapper classMapper;

    @Autowired
    private ISysDeptService deptService;


    @Override
    public List<CouCourse> selectCourseList(CouCourse course)
    {
        return courseMapper.selectCourseList(course);
    }

    @Override
    public CouCourse selectCourseById(Long id)
    {
        CouCourse course = courseMapper.selectCourseById(id);
        if (course != null)
        {
            course.setQuotaList(quotaMapper.selectQuotaByCourseId(id));
        }
        return course;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertCourse(CouCourse course)
    {
        if (course == null)
        {
            throw new ServiceException("课程信息不能为空");
        }
        validateCourse(course);
        int rows = courseMapper.insertCourse(course);
        saveQuotas(course.getId(), course.getQuotaList());
        return rows;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateCourse(CouCourse course)
    {
        if (course == null || course.getId() == null)
        {
            throw new ServiceException("课程信息不能为空");
        }
        validateCourse(course);
        quotaMapper.physicalDeleteByCourseId(course.getId());
        saveQuotas(course.getId(), course.getQuotaList());
        return courseMapper.updateCourse(course);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteCourseById(Long id)
    {
        quotaMapper.physicalDeleteByCourseId(id);
        return courseMapper.deleteCourseById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int copyToNewSemester(Long oldCourseId, Long newSemesterId)
    {
        CouCourse old = courseMapper.selectCourseById(oldCourseId);
        if (old == null)
        {
            throw new ServiceException("原课程不存在");
        }
        CouCourse newCourse = new CouCourse();
        newCourse.setCourseName(old.getCourseName());
        newCourse.setWeekDay(old.getWeekDay());
        newCourse.setGradeId(old.getGradeId());
        newCourse.setTeacherId(old.getTeacherId());
        newCourse.setTeacherName(old.getTeacherName());
        newCourse.setDescription(old.getDescription());
        newCourse.setLocation(old.getLocation());
        newCourse.setSemesterId(newSemesterId);
        int rows = courseMapper.insertCourse(newCourse);
        List<CouClassQuota> oldQuotas = quotaMapper.selectQuotaByCourseId(oldCourseId);
        if (StringUtils.isNotEmpty(oldQuotas))
        {
            List<CouClassQuota> newQuotas = new ArrayList<>();
            for (CouClassQuota q : oldQuotas)
            {
                CouClassQuota nq = new CouClassQuota();
                nq.setCourseId(newCourse.getId());
                nq.setClassId(q.getClassId());
                nq.setQuota(q.getQuota());
                nq.setSelected(0);
                newQuotas.add(nq);
            }
            quotaMapper.batchInsertQuota(newQuotas);
        }
        return rows;
    }

    @Override
    public List<CourseSelectedStudentVO> selectSelectedStudents(Long courseId)
    {
        return courseMapper.selectSelectedStudentsByCourseId(courseId);
    }

    @Override
    public List<CourseSelectedStudentVO> selectAssignedStudents(Long courseId)
    {
        CouCourse course = courseMapper.selectCourseById(courseId);
        if (course == null || course.getSemesterId() == null)
        {
            return courseMapper.selectAssignedStudentsByCourseId(courseId);
        }
        Set<Long> seenUserIds = new HashSet<>();
        List<CourseSelectedStudentVO> result = new LinkedList<>();
        List<CourseSelectedStudentVO> fromDb = courseMapper.selectAssignedStudentsByCourseId(courseId);
        if (fromDb != null)
        {
            for (CourseSelectedStudentVO v : fromDb)
            {
                if (v.getUserId() != null && seenUserIds.add(v.getUserId()))
                {
                    result.add(v);
                }
            }
        }
        List<CourseSelectedStudentVO> fromCart = selectionService.listAssignedStudentsInCart(courseId, course.getSemesterId());
        if (fromCart != null)
        {
            for (CourseSelectedStudentVO v : fromCart)
            {
                if (v.getUserId() != null && seenUserIds.add(v.getUserId()))
                {
                    result.add(v);
                }
            }
        }
        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int assignStudents(Long courseId, List<Long> studentIds)
    {
        if (StringUtils.isEmpty(studentIds))
        {
            return 0;
        }
        CouCourse course = courseMapper.selectCourseById(courseId);
        if (course == null)
        {
            throw new ServiceException("课程不存在");
        }
        if (course.getSemesterId() == null || course.getWeekDay() == null)
        {
            throw new ServiceException("课程缺少学期或星期信息，无法指定学生");
        }
        int count = 0;
        for (Long userId : studentIds)
        {
            StuStudentInfo student = studentMapper.selectStudentByUserId(userId);
            if (student == null)
            {
                throw new ServiceException("学生不存在：userId=" + userId);
            }
            if (course.getGradeId() != null && student.getGradeId() != null
                && !course.getGradeId().equals(student.getGradeId()))
            {
                throw new ServiceException("学生 " + student.getRealName() + " 所在年级与课程年级不一致");
            }
            if (selectionMapper.countByStudentSemesterWeekDay(userId, course.getSemesterId(), course.getWeekDay()) > 0)
            {
                throw new ServiceException("学生 " + student.getRealName() + " 在该学期该星期已有其他选课，无法指定");
            }
            if (selectionMapper.countByStudentAndCourse(userId, courseId) > 0)
            {
                throw new ServiceException("学生 " + student.getRealName() + " 已选该课程");
            }
            if (student.getClassId() == null)
            {
                throw new ServiceException("学生 " + student.getRealName() + " 未设置班级");
            }
            CouClassQuota quota = quotaMapper.selectByCourseAndClass(courseId, student.getClassId());
            if (quota != null && quota.getSelected() != null && quota.getQuota() != null
                && quota.getSelected() >= quota.getQuota())
            {
                throw new ServiceException("学生 " + student.getRealName() + " 所在班级名额已满");
            }
            // 指定学生：将课程加入选课车（标记为不可删除），学生提交选课时一并确认；指定即占名额
            selectionService.addToCartAssigned(userId, course.getSemesterId(), courseId);
            if (quota != null)
            {
                quotaMapper.incrementSelected(courseId, student.getClassId());
            }
            count++;
        }
        return count;
    }

    @Override
    public String importAssignStudents(Long courseId, MultipartFile file)
    {
        if (file == null || file.isEmpty())
        {
            throw new ServiceException("上传文件不能为空");
        }
        ExcelUtil<AssignStudentsImportDTO> util = new ExcelUtil<>(AssignStudentsImportDTO.class);
        List<AssignStudentsImportDTO> list;
        try
        {
            list = util.importExcel(file.getInputStream());
        }
        catch (Exception e)
        {
            throw new ServiceException("解析Excel失败：" + e.getMessage());
        }
        if (list == null || list.isEmpty())
        {
            throw new ServiceException("导入数据不能为空");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder failureMsg = new StringBuilder();
        int maxFailureMsg = 10;

        for (AssignStudentsImportDTO dto : list)
        {
            String studentNo = dto.getStudentNo() != null ? dto.getStudentNo().trim() : "";
            if (StringUtils.isEmpty(studentNo))
            {
                failureNum++;
                if (failureNum <= maxFailureMsg)
                {
                    failureMsg.append("<br/>").append(failureNum).append("、学号不能为空");
                }
                else if (failureNum == maxFailureMsg + 1)
                {
                    failureMsg.append("<br/>... (更多错误已省略)");
                }
                continue;
            }
            StuStudentInfo student = studentMapper.selectStudentByStudentNo(studentNo);
            if (student == null)
            {
                failureNum++;
                if (failureNum <= maxFailureMsg)
                {
                    failureMsg.append("<br/>").append(failureNum).append("、学号 ").append(studentNo).append(" 不存在");
                }
                else if (failureNum == maxFailureMsg + 1)
                {
                    failureMsg.append("<br/>... (更多错误已省略)");
                }
                continue;
            }
            try
            {
                assignStudents(courseId, Collections.singletonList(student.getUserId()));
                successNum++;
            }
            catch (Exception e)
            {
                failureNum++;
                if (failureNum <= maxFailureMsg)
                {
                    failureMsg.append("<br/>").append(failureNum).append("、学号 ").append(studentNo)
                        .append(" ").append(student.getRealName()).append("：").append(e.getMessage());
                }
                else if (failureNum == maxFailureMsg + 1)
                {
                    failureMsg.append("<br/>... (更多错误已省略)");
                }
            }
        }
        StringBuilder result = new StringBuilder();
        result.append("导入完成，成功 ").append(successNum).append(" 人");
        if (failureNum > 0)
        {
            result.append("，失败 ").append(failureNum).append(" 人").append(failureMsg);
        }
        return result.toString();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String importCourse(List<CourseImportDTO> dtoList, Boolean isUpdateSupport, String operName)
    {
        if (StringUtils.isNull(dtoList) || dtoList.size() == 0)
        {
            throw new ServiceException("导入课程数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (CourseImportDTO dto : dtoList)
        {
            String courseName = dto.getCourseName() != null ? dto.getCourseName() : "未知";
            try
            {
                CouCourse course = dtoToCourse(dto);
                List<CouClassQuota> quotaList = buildQuotaListFromDto(dto);
                course.setQuotaList(quotaList);

                if (StringUtils.isEmpty(course.getCourseName())) {
                    throw new ServiceException("课程名称不能为空");
                }
                if (course.getWeekDay() == null || course.getWeekDay() < 1 || course.getWeekDay() > 5) {
                    throw new ServiceException("星期必须为1-5（1=周一至5=周五）");
                }
                if (StringUtils.isEmpty(course.getGradeName())) {
                    throw new ServiceException("年级名称不能为空");
                }
                if (StringUtils.isEmpty(course.getSemesterName())) {
                    throw new ServiceException("学期名称不能为空");
                }

                SysGrade exactGrade = findGradeByName(course.getGradeName());
                if (exactGrade == null) {
                    throw new ServiceException("年级不存在: " + course.getGradeName());
                }
                course.setGradeId(exactGrade.getId());

                SysSemester exactSemester = findSemesterByName(course.getSemesterName());
                if (exactSemester == null) {
                    throw new ServiceException("学期不存在: " + course.getSemesterName());
                }
                course.setSemesterId(exactSemester.getId());

                if (StringUtils.isNotEmpty(course.getTeacherName())) {
                    SysUser exactUser = findOrCreateTeacherUser(course.getTeacherName().trim(), operName);
                    if (exactUser != null) {
                        course.setTeacherId(exactUser.getUserId());
                        course.setTeacherName(exactUser.getNickName());
                    } else {
                        course.setTeacherId(null);
                        course.setTeacherName(course.getTeacherName().trim());
                    }
                }

                CouCourse existingCourse = null;
                CouCourse query = new CouCourse();
                query.setCourseName(course.getCourseName());
                query.setSemesterId(course.getSemesterId());
                query.setGradeId(course.getGradeId());
                query.setWeekDay(course.getWeekDay());
                List<CouCourse> list = courseMapper.selectCourseList(query);
                if (!list.isEmpty()) {
                    existingCourse = list.get(0);
                }

                if (existingCourse == null)
                {
                    this.insertCourse(course);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、课程 " + course.getCourseName() + " 导入成功");
                }
                else if (isUpdateSupport)
                {
                    course.setId(existingCourse.getId());
                    this.updateCourse(course);
                    successNum++;
                    successMsg.append("<br/>" + successNum + "、课程 " + course.getCourseName() + " 更新成功");
                }
                else
                {
                    failureNum++;
                    failureMsg.append("<br/>" + failureNum + "、课程 " + course.getCourseName() + " 已存在");
                }
            }
            catch (Exception e)
            {
                failureNum++;
                failureMsg.append("<br/>" + failureNum + "、课程 " + courseName + " 导入失败：" + e.getMessage());
            }
        }
        if (failureNum > 0)
        {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
        }
        else
        {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString() + failureMsg.toString();
    }

    private CouCourse dtoToCourse(CourseImportDTO dto)
    {
        CouCourse course = new CouCourse();
        course.setCourseName(trimToNull(dto.getCourseName()));
        course.setWeekDay(dto.getWeekDay());
        course.setSemesterName(trimToNull(dto.getSemesterName()));
        course.setGradeName(trimToNull(dto.getGradeName()));
        course.setTeacherName(trimToNull(dto.getTeacherName()));
        course.setLocation(trimToNull(dto.getLocation()));
        return course;
    }

    private static String trimToNull(String s)
    {
        if (s == null) return null;
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private List<CouClassQuota> buildQuotaListFromDto(CourseImportDTO dto)
    {
        List<CouClassQuota> list = new ArrayList<>();
        String gradeName = trimToNull(dto.getGradeName());
        if (StringUtils.isEmpty(gradeName)) {
            return list;
        }
        Integer[] quotas = { dto.getQuota1(), dto.getQuota2(), dto.getQuota3(), dto.getQuota4(), dto.getQuota5() };
        String[] shortNames = { "1班", "2班", "3班", "4班", "5班" };
        for (int i = 0; i < quotas.length; i++) {
            Integer q = quotas[i];
            if (q == null || q < 1) {
                continue;
            }
            SysClass sysClass = findClassByGradeAndShortName(gradeName, shortNames[i]);
            if (sysClass == null) {
                continue;
            }
            CouClassQuota quota = new CouClassQuota();
            quota.setClassId(sysClass.getId());
            quota.setQuota(q);
            list.add(quota);
        }
        return list;
    }

    /** 按年级和班级简称查找班级，支持 "1班" 或 "八年级1班" 等格式 */
    private SysClass findClassByGradeAndShortName(String gradeName, String shortName)
    {
        SysClass c = classMapper.selectByGradeNameAndClassName(gradeName, shortName);
        if (c != null) {
            return c;
        }
        String fullName = gradeName + shortName;
        return classMapper.selectByGradeNameAndClassName(gradeName, fullName);
    }

    private SysGrade findGradeByName(String gradeName)
    {
        SysGrade params = new SysGrade();
        params.setGradeName(gradeName);
        List<SysGrade> grades = gradeService.selectGradeList(params);
        for (SysGrade g : grades) {
            if (gradeName.equals(g.getGradeName())) {
                return g;
            }
        }
        return null;
    }

    private SysSemester findSemesterByName(String semesterName)
    {
        SysSemester params = new SysSemester();
        params.setSemesterName(semesterName);
        List<SysSemester> semesters = semesterService.selectSemesterList(params);
        for (SysSemester s : semesters) {
            if (semesterName.equals(s.getSemesterName())) {
                return s;
            }
        }
        return null;
    }

    /**
     * 查找教师用户，若不存在则自动创建（userType=02，角色=教师）
     * 创建规则：userName=teacher_姓名，nickName=姓名，默认密码123456，角色=教师(101)，部门=103
     * @return 教师用户，若查找和创建均失败则返回 null（不抛异常，课程照常导入）
     */
    private SysUser findOrCreateTeacherUser(String teacherName, String operName)
    {
        // 1. 按昵称精确查找（支持已存在用户）
        SysUser user = findUserByNickName(teacherName);
        if (user != null) {
            return user;
        }
        // 2. 按 userName=teacher_姓名 查找（支持之前自动创建的用户）
        String userName = "teacher_" + teacherName;
        user = userService.selectUserByUserName(userName);
        if (user != null) {
            return user;
        }
        // 3. 不存在则自动创建
        user = buildTeacherUser(teacherName);
        user.setCreateBy(operName);
        
        // 检查部门是否存在
        SysDept dept = deptService.selectDeptById(DEFAULT_DEPT_ID);
        if (dept != null) {
            user.setDeptId(DEFAULT_DEPT_ID);
        } else {
            // 默认部门不存在，查找第一个可用部门
            SysDept queryDept = new SysDept();
            queryDept.setStatus("0");
            List<SysDept> deptList = deptService.selectDeptList(queryDept);
            if (!deptList.isEmpty()) {
                user.setDeptId(deptList.get(0).getDeptId());
            } else {
                // 无可用部门，无法创建用户
                throw new ServiceException("无法自动创建教师用户：未找到可用部门");
            }
        }

        try {
            userService.insertUser(user);
            if (user.getUserId() == null) {
                user = userService.selectUserByUserName(userName);
            }
        } catch (Exception e) {
            // 捕获异常尝试重新查找（可能是并发插入导致）
            user = userService.selectUserByUserName(userName);
            if (user == null) {
                throw new ServiceException("创建教师用户失败：" + e.getMessage());
            }
        }
        return user;
    }

    private SysUser findUserByNickName(String nickName)
    {
        SysUser params = new SysUser();
        params.setNickName(nickName);
        List<SysUser> users = userService.selectUserList(params);
        return users.isEmpty() ? null : users.get(0);
    }

    /** 构建教师用户（用于课程导入时自动创建） */
    private SysUser buildTeacherUser(String teacherName)
    {
        SysUser user = new SysUser();
        user.setUserName("teacher_" + teacherName);
        user.setNickName(teacherName);
        user.setUserType("02"); // 教师
        user.setStatus(UserConstants.NORMAL);
        user.setDeptId(DEFAULT_DEPT_ID);
        user.setPassword(SecurityUtils.encryptPassword(TEACHER_DEFAULT_PASSWORD));
        user.setRoleIds(new Long[]{ TEACHER_ROLE_ID });
        return user;
    }

    private void validateCourse(CouCourse course)
    {
        if (StringUtils.isEmpty(course.getCourseName()))
        {
            throw new ServiceException("课程名称不能为空");
        }
        if (course.getWeekDay() == null || course.getWeekDay() < 1 || course.getWeekDay() > 5)
        {
            throw new ServiceException("请选择星期（周一至周五）");
        }
        if (course.getGradeId() == null)
        {
            throw new ServiceException("请选择年级");
        }
        if (course.getSemesterId() == null)
        {
            throw new ServiceException("请选择学期");
        }
    }

    private void saveQuotas(Long courseId, List<CouClassQuota> quotaList)
    {
        if (StringUtils.isEmpty(quotaList))
        {
            return;
        }
        List<CouClassQuota> toInsert = new ArrayList<>();
        for (CouClassQuota q : quotaList)
        {
            if (q.getClassId() == null || q.getQuota() == null || q.getQuota() < 1)
            {
                continue;
            }
            q.setCourseId(courseId);
            q.setSelected(0);
            toInsert.add(q);
        }
        if (!toInsert.isEmpty())
        {
            quotaMapper.batchInsertQuota(toInsert);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int initSelectionData(Long semesterId)
    {
        if (semesterId == null)
        {
            throw new ServiceException("请指定学期");
        }
        int deleted = selectionMapper.deleteBySemesterId(semesterId);
        quotaMapper.resetSelectedBySemesterId(semesterId);
        return deleted;
    }
}
