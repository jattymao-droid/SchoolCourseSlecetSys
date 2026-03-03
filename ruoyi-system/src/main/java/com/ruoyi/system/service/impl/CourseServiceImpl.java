package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.entity.CouClassQuota;
import com.ruoyi.common.core.domain.entity.CouCourse;
import com.ruoyi.common.core.domain.entity.SysGrade;
import com.ruoyi.common.core.domain.entity.SysSemester;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.CourseSelectedStudentVO;
import com.ruoyi.common.core.domain.entity.StuSelection;
import com.ruoyi.common.core.domain.entity.StuStudentInfo;
import com.ruoyi.system.mapper.CouClassQuotaMapper;
import com.ruoyi.system.mapper.CouCourseMapper;
import com.ruoyi.system.mapper.StuSelectionMapper;
import com.ruoyi.system.mapper.StuStudentInfoMapper;
import com.ruoyi.system.service.ICourseService;
import com.ruoyi.system.service.ISelectionService;
import com.ruoyi.system.service.ISysGradeService;
import com.ruoyi.system.service.ISysSemesterService;
import com.ruoyi.system.service.ISysUserService;

/**
 * 课程管理 服务实现
 *
 * @author ruoyi
 */
@Service
public class CourseServiceImpl implements ICourseService
{
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
            StuSelection sel = new StuSelection();
            sel.setStudentId(userId);
            sel.setCourseId(courseId);
            sel.setSemesterId(course.getSemesterId());
            sel.setWeekDay(course.getWeekDay());
            sel.setClassId(student.getClassId());
            sel.setStatus(1);
            sel.setAssigned(1);
            selectionMapper.insertSelection(sel);
            if (quota != null)
            {
                quotaMapper.incrementSelected(courseId, student.getClassId());
            }
            // 指定学生直接进入已选课程，不放入选课车
            count++;
        }
        return count;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String importCourse(List<CouCourse> courseList, Boolean isUpdateSupport, String operName)
    {
        if (StringUtils.isNull(courseList) || courseList.size() == 0)
        {
            throw new ServiceException("导入课程数据不能为空！");
        }
        int successNum = 0;
        int failureNum = 0;
        StringBuilder successMsg = new StringBuilder();
        StringBuilder failureMsg = new StringBuilder();
        for (CouCourse course : courseList)
        {
            try
            {
                // 验证是否存在这个课程
                // 通过课程名、学期、年级、星期来判断是否唯一？或者只是课程名？
                // 这里简单点，如果有ID则更新，无ID则新增。但导入通常没有ID。
                
                // 处理外键
                if (StringUtils.isEmpty(course.getGradeName())) {
                    throw new ServiceException("年级名称不能为空");
                }
                if (StringUtils.isEmpty(course.getSemesterName())) {
                    throw new ServiceException("学期名称不能为空");
                }
                
                // 查找年级ID
                SysGrade gradeParams = new SysGrade();
                gradeParams.setGradeName(course.getGradeName());
                List<SysGrade> grades = gradeService.selectGradeList(gradeParams);
                SysGrade exactGrade = null;
                for (SysGrade g : grades) {
                    if (g.getGradeName().equals(course.getGradeName())) {
                        exactGrade = g;
                        break;
                    }
                }
                if (exactGrade == null) {
                    throw new ServiceException("年级不存在: " + course.getGradeName());
                }
                course.setGradeId(exactGrade.getId());
                
                // 查找学期ID
                SysSemester semesterParams = new SysSemester();
                semesterParams.setSemesterName(course.getSemesterName());
                List<SysSemester> semesters = semesterService.selectSemesterList(semesterParams);
                SysSemester exactSemester = null;
                for (SysSemester s : semesters) {
                    if (s.getSemesterName().equals(course.getSemesterName())) {
                        exactSemester = s;
                        break;
                    }
                }
                if (exactSemester == null) {
                    throw new ServiceException("学期不存在: " + course.getSemesterName());
                }
                course.setSemesterId(exactSemester.getId());
                
                // 查找教师ID
                if (StringUtils.isNotEmpty(course.getTeacherName())) {
                    SysUser userParams = new SysUser();
                    userParams.setNickName(course.getTeacherName());
                    List<SysUser> users = userService.selectUserList(userParams);
                    SysUser exactUser = null;
                    for (SysUser u : users) {
                        if (u.getNickName().equals(course.getTeacherName())) {
                            exactUser = u;
                            break;
                        }
                    }
                    if (exactUser == null) {
                        // 尝试按用户名查找（如果用户填的是账号）
                        SysUser userByName = userService.selectUserByUserName(course.getTeacherName());
                        if (userByName != null) {
                            exactUser = userByName;
                        }
                    }
                    
                    if (exactUser != null) {
                        course.setTeacherId(exactUser.getUserId());
                        // 确保 teacherName 与系统一致（可选，如果想保留用户填写的名字可以不覆盖，但为了数据一致性建议覆盖）
                        course.setTeacherName(exactUser.getNickName()); 
                    } else {
                        // 教师必须存在于系统中
                         throw new ServiceException("教师不存在: " + course.getTeacherName());
                    }
                } else {
                    // 如果教师名字为空，是否允许？通常需要教师
                    // 如果允许为空，则 teacherId 为 null
                }

                // 验证是否存在
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
                String msg = "<br/>" + failureNum + "、课程 " + course.getCourseName() + " 导入失败：";
                failureMsg.append(msg + e.getMessage());
            }
        }
        if (failureNum > 0)
        {
            failureMsg.insert(0, "很抱歉，导入失败！共 " + failureNum + " 条数据格式不正确，错误如下：");
            successMsg.append("");
        }
        else
        {
            successMsg.insert(0, "恭喜您，数据已全部导入成功！共 " + successNum + " 条，数据如下：");
        }
        return successMsg.toString() + failureMsg.toString();
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
