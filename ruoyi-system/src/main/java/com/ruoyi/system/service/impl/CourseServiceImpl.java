package com.ruoyi.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.domain.entity.CouClassQuota;
import com.ruoyi.common.core.domain.entity.CouCourse;
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
            selectionMapper.insertSelection(sel);
            if (quota != null)
            {
                quotaMapper.incrementSelected(courseId, student.getClassId());
            }
            count++;
        }
        return count;
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
}
