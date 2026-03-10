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
import org.springframework.transaction.annotation.Propagation;
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
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.system.service.ISysDeptService;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.utils.poi.ExcelUtil;

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
    public int deleteCourseByIds(Long[] ids)
    {
        if (ids == null || ids.length == 0)
        {
            return 0;
        }

        int count = 0;
        for (Long id : ids)
        {
            quotaMapper.physicalDeleteByCourseId(id);
            count += courseMapper.deleteCourseById(id);
        }
        return count;
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


    /** 按年级和班级简称查找班级，支持 "1班" 或 "八年级1班" 等格式 */
    @Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
    private SysClass findClassByGradeAndShortName(String gradeName, String shortName)
    {
        SysClass c = classMapper.selectByGradeNameAndClassName(gradeName, shortName);
        if (c != null) {
            return c;
        }
        String fullName = gradeName + shortName;
        return classMapper.selectByGradeNameAndClassName(gradeName, fullName);
    }

    @Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
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

    @Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
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
     * 查找教师用户（只读查询，不创建）
     */
    @Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
    private SysUser findTeacherUser(String teacherName)
    {
        // 1. 按昵称精确查找（支持已存在用户）
        SysUser user = findUserByNickName(teacherName);
        if (user != null) {
            return user;
        }
        // 2. 按 userName=teacher_姓名 查找（支持之前自动创建的用户）
        String userName = "teacher_" + teacherName;
        user = userService.selectUserByUserName(userName);
        return user;
    }

    /**
     * 创建教师用户（在新事务中执行）
     */
    @Transactional(propagation = Propagation.REQUIRES_NEW, rollbackFor = Exception.class)
    private SysUser createTeacherUser(String teacherName, String operName)
    {
        String userName = "teacher_" + teacherName;
        SysUser user = buildTeacherUser(teacherName);
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

    /**
     * 查找教师用户，若不存在则自动创建（userType=02，角色=教师）
     * 创建规则：userName=teacher_姓名，nickName=姓名，默认密码123456，角色=教师(101)，部门=103
     * @return 教师用户，若查找和创建均失败则返回 null（不抛异常，课程照常导入）
     */
    private SysUser findOrCreateTeacherUser(String teacherName, String operName)
    {
        // 先查找
        SysUser user = findTeacherUser(teacherName);
        if (user != null) {
            return user;
        }
        // 不存在则创建（在新事务中）
        return createTeacherUser(teacherName, operName);
    }

    @Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
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

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String importCourse(MultipartFile file, boolean updateSupport, String operName)
    {
        if (file == null || file.isEmpty())
        {
            throw new ServiceException("上传文件不能为空");
        }
        ExcelUtil<CouCourse> util = new ExcelUtil<>(CouCourse.class);
        List<CouCourse> list;
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
        for (CouCourse row : list)
        {
            String courseName = row.getCourseName() != null ? row.getCourseName().trim() : "";
            if (StringUtils.isEmpty(courseName))
            {
                failureNum++;
                if (failureNum <= maxFailureMsg)
                    failureMsg.append("<br/>").append(failureNum).append("、课程名称不能为空");
                else if (failureNum == maxFailureMsg + 1)
                    failureMsg.append("<br/>... (更多错误已省略)");
                continue;
            }
            try
            {
                if (row.getSemesterName() != null && !row.getSemesterName().isEmpty())
                {
                    SysSemester sem = findSemesterByName(row.getSemesterName().trim());
                    if (sem != null)
                        row.setSemesterId(sem.getId());
                }
                if (row.getGradeName() != null && !row.getGradeName().isEmpty())
                {
                    SysGrade gr = findGradeByName(row.getGradeName().trim());
                    if (gr != null)
                        row.setGradeId(gr.getId());
                }
                if (row.getTeacherName() != null && !row.getTeacherName().isEmpty())
                {
                    SysUser tea = findOrCreateTeacherUser(row.getTeacherName().trim(), operName);
                    if (tea != null)
                    {
                        row.setTeacherId(tea.getUserId());
                        row.setTeacherName(tea.getNickName());
                    }
                }
                if (row.getSemesterId() == null)
                {
                    throw new ServiceException("学期不存在: " + row.getSemesterName());
                }
                if (row.getGradeId() == null)
                {
                    throw new ServiceException("年级不存在: " + row.getGradeName());
                }
                if (row.getWeekDay() == null || row.getWeekDay() < 1 || row.getWeekDay() > 5)
                {
                    throw new ServiceException("星期必须为1-5（周一至周五）");
                }
                CouCourse query = new CouCourse();
                query.setCourseName(courseName);
                query.setSemesterId(row.getSemesterId());
                query.setGradeId(row.getGradeId());
                query.setWeekDay(row.getWeekDay());
                List<CouCourse> exists = courseMapper.selectCourseList(query);
                if (!exists.isEmpty() && updateSupport)
                {
                    CouCourse exist = exists.get(0);
                    row.setId(exist.getId());
                    row.setQuotaList(quotaMapper.selectQuotaByCourseId(exist.getId()));
                    updateCourse(row);
                    successNum++;
                }
                else if (exists.isEmpty())
                {
                    row.setId(null);
                    row.setQuotaList(null);
                    insertCourse(row);
                    successNum++;
                }
                else
                {
                    failureNum++;
                    if (failureNum <= maxFailureMsg)
                        failureMsg.append("<br/>").append(failureNum).append("、课程「").append(courseName).append("」已存在");
                    else if (failureNum == maxFailureMsg + 1)
                        failureMsg.append("<br/>... (更多错误已省略)");
                }
            }
            catch (Exception e)
            {
                failureNum++;
                if (failureNum <= maxFailureMsg)
                    failureMsg.append("<br/>").append(failureNum).append("、").append(courseName).append("：").append(e.getMessage());
                else if (failureNum == maxFailureMsg + 1)
                    failureMsg.append("<br/>... (更多错误已省略)");
            }
        }
        StringBuilder result = new StringBuilder();
        result.append("导入完成，成功 ").append(successNum).append(" 条");
        if (failureNum > 0)
            result.append("，失败 ").append(failureNum).append(" 条").append(failureMsg);
        return result.toString();
    }

    @Override
    public void exportCourseImportTemplate(javax.servlet.http.HttpServletResponse response)
    {
        try
        {
            // 获取所有年级
            List<SysGrade> gradeList = gradeService.selectGradeList(new SysGrade());
            if (gradeList == null || gradeList.isEmpty())
            {
                throw new ServiceException("系统中没有年级数据，无法生成模板");
            }
            
            // 创建工作簿
            org.apache.poi.ss.usermodel.Workbook workbook = new org.apache.poi.xssf.usermodel.XSSFWorkbook();
            
            // 创建样式
            org.apache.poi.ss.usermodel.CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(org.apache.poi.ss.usermodel.IndexedColors.GREY_25_PERCENT.getIndex());
            headerStyle.setFillPattern(org.apache.poi.ss.usermodel.FillPatternType.SOLID_FOREGROUND);
            headerStyle.setBorderBottom(org.apache.poi.ss.usermodel.BorderStyle.THIN);
            headerStyle.setBorderTop(org.apache.poi.ss.usermodel.BorderStyle.THIN);
            headerStyle.setBorderLeft(org.apache.poi.ss.usermodel.BorderStyle.THIN);
            headerStyle.setBorderRight(org.apache.poi.ss.usermodel.BorderStyle.THIN);
            org.apache.poi.ss.usermodel.Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);
            headerStyle.setAlignment(org.apache.poi.ss.usermodel.HorizontalAlignment.CENTER);
            
            // 为每个年级创建一个Sheet
            for (SysGrade grade : gradeList)
            {
                // 查询该年级的所有班级
                SysClass classQuery = new SysClass();
                classQuery.setGradeId(grade.getId());
                List<SysClass> classList = classMapper.selectClassList(classQuery);
                
                // 创建Sheet
                String sheetName = grade.getGradeName();
                org.apache.poi.ss.usermodel.Sheet sheet = workbook.createSheet(sheetName);
                
                // 创建表头行
                org.apache.poi.ss.usermodel.Row headerRow = sheet.createRow(0);
                int colIndex = 0;
                
                // 固定列
                String[] fixedHeaders = {"课程名称", "星期", "教师姓名", "上课地点", "学期名称", "课程描述"};
                for (String header : fixedHeaders)
                {
                    org.apache.poi.ss.usermodel.Cell cell = headerRow.createCell(colIndex++);
                    cell.setCellValue(header);
                    cell.setCellStyle(headerStyle);
                    sheet.setColumnWidth(colIndex - 1, 4000);
                }
                
                // 动态班级列
                if (classList != null && !classList.isEmpty())
                {
                    for (SysClass clazz : classList)
                    {
                        org.apache.poi.ss.usermodel.Cell cell = headerRow.createCell(colIndex++);
                        cell.setCellValue(clazz.getClassName());
                        cell.setCellStyle(headerStyle);
                        sheet.setColumnWidth(colIndex - 1, 3000);
                    }
                }
                
                // 添加一行示例数据
                org.apache.poi.ss.usermodel.Row exampleRow = sheet.createRow(1);
                exampleRow.createCell(0).setCellValue("示例课程");
                exampleRow.createCell(1).setCellValue("1");
                exampleRow.createCell(2).setCellValue("张老师");
                exampleRow.createCell(3).setCellValue("教学楼101");
                exampleRow.createCell(4).setCellValue("2024-2025学年第一学期");
                exampleRow.createCell(5).setCellValue("这是一门示例课程");
                
                // 班级名额示例
                if (classList != null && !classList.isEmpty())
                {
                    for (int i = 0; i < classList.size(); i++)
                    {
                        exampleRow.createCell(6 + i).setCellValue("30");
                    }
                }
            }
            
            // 设置响应头
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setCharacterEncoding("utf-8");
            String fileName = java.net.URLEncoder.encode("课程导入模板", "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
            
            // 写入响应
            workbook.write(response.getOutputStream());
            workbook.close();
        }
        catch (Exception e)
        {
            throw new ServiceException("生成导入模板失败：" + e.getMessage());
        }
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String importCourseWithQuota(MultipartFile file, boolean updateSupport, String operName)
    {
        if (file == null || file.isEmpty())
        {
            throw new ServiceException("上传文件不能为空");
        }
        
        try
        {
            org.apache.poi.ss.usermodel.Workbook workbook = org.apache.poi.ss.usermodel.WorkbookFactory.create(file.getInputStream());
            
            int successNum = 0;
            int failureNum = 0;
            StringBuilder failureMsg = new StringBuilder();
            int maxFailureMsg = 10;
            
            // 遍历所有Sheet（每个Sheet代表一个年级）
            for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++)
            {
                org.apache.poi.ss.usermodel.Sheet sheet = workbook.getSheetAt(sheetIndex);
                String sheetName = sheet.getSheetName();
                
                // 根据Sheet名称查找年级
                SysGrade grade = findGradeByName(sheetName);
                if (grade == null)
                {
                    failureMsg.append("<br/>Sheet「").append(sheetName).append("」对应的年级不存在，已跳过");
                    continue;
                }
                
                // 读取表头（第一行）
                org.apache.poi.ss.usermodel.Row headerRow = sheet.getRow(0);
                if (headerRow == null)
                {
                    continue;
                }
                
                // 解析表头，获取班级列信息
                List<String> classNames = new ArrayList<>();
                int classStartCol = 6; // 班级列从第7列开始（索引6）
                for (int colIndex = classStartCol; colIndex < headerRow.getLastCellNum(); colIndex++)
                {
                    org.apache.poi.ss.usermodel.Cell cell = headerRow.getCell(colIndex);
                    if (cell != null)
                    {
                        String className = cell.getStringCellValue();
                        if (StringUtils.isNotEmpty(className))
                        {
                            classNames.add(className.trim());
                        }
                    }
                }
                
                // 从第二行开始读取数据（第一行是表头，第二行可能是示例）
                for (int rowIndex = 1; rowIndex <= sheet.getLastRowNum(); rowIndex++)
                {
                    org.apache.poi.ss.usermodel.Row row = sheet.getRow(rowIndex);
                    if (row == null)
                    {
                        continue;
                    }
                    
                    // 读取课程基本信息
                    String courseName = getCellValue(row.getCell(0));
                    if (StringUtils.isEmpty(courseName) || "示例课程".equals(courseName))
                    {
                        continue; // 跳过空行和示例行
                    }
                    
                    try
                    {
                        CouCourse course = new CouCourse();
                        course.setCourseName(courseName.trim());
                        course.setGradeId(grade.getId());
                        
                        // 星期
                        String weekDayStr = getCellValue(row.getCell(1));
                        if (StringUtils.isNotEmpty(weekDayStr))
                        {
                            try
                            {
                                course.setWeekDay(Integer.parseInt(weekDayStr.trim()));
                            }
                            catch (NumberFormatException e)
                            {
                                throw new ServiceException("星期格式错误，应为1-5的数字");
                            }
                        }
                        
                        // 教师
                        String teacherName = getCellValue(row.getCell(2));
                        if (StringUtils.isNotEmpty(teacherName))
                        {
                            SysUser teacher = findOrCreateTeacherUser(teacherName.trim(), operName);
                            if (teacher != null)
                            {
                                course.setTeacherId(teacher.getUserId());
                            }
                        }
                        
                        // 上课地点
                        course.setLocation(getCellValue(row.getCell(3)));
                        
                        // 学期
                        String semesterName = getCellValue(row.getCell(4));
                        if (StringUtils.isNotEmpty(semesterName))
                        {
                            SysSemester semester = findSemesterByName(semesterName.trim());
                            if (semester != null)
                            {
                                course.setSemesterId(semester.getId());
                            }
                            else
                            {
                                throw new ServiceException("学期不存在: " + semesterName);
                            }
                        }
                        else
                        {
                            throw new ServiceException("学期名称不能为空");
                        }
                        
                        // 课程描述
                        course.setDescription(getCellValue(row.getCell(5)));
                        
                        // 验证必填字段
                        if (course.getWeekDay() == null || course.getWeekDay() < 1 || course.getWeekDay() > 5)
                        {
                            throw new ServiceException("星期必须为1-5（周一至周五）");
                        }
                        
                        // 读取班级名额
                        List<CouClassQuota> quotaList = new ArrayList<>();
                        for (int i = 0; i < classNames.size(); i++)
                        {
                            String className = classNames.get(i);
                            org.apache.poi.ss.usermodel.Cell quotaCell = row.getCell(classStartCol + i);
                            String quotaStr = getCellValue(quotaCell);
                            
                            if (StringUtils.isNotEmpty(quotaStr))
                            {
                                try
                                {
                                    int quota = Integer.parseInt(quotaStr.trim());
                                    if (quota > 0)
                                    {
                                        // 查找班级
                                        SysClass clazz = findClassByGradeAndShortName(grade.getGradeName(), className);
                                        if (clazz != null)
                                        {
                                            CouClassQuota q = new CouClassQuota();
                                            q.setClassId(clazz.getId());
                                            q.setQuota(quota);
                                            q.setSelected(0);
                                            quotaList.add(q);
                                        }
                                    }
                                }
                                catch (NumberFormatException e)
                                {
                                    // 忽略非数字的名额
                                }
                            }
                        }
                        
                        if (quotaList.isEmpty())
                        {
                            throw new ServiceException("至少需要为一个班级指定名额");
                        }
                        
                        course.setQuotaList(quotaList);
                        
                        // 检查是否已存在
                        CouCourse query = new CouCourse();
                        query.setCourseName(courseName);
                        query.setSemesterId(course.getSemesterId());
                        query.setGradeId(course.getGradeId());
                        query.setWeekDay(course.getWeekDay());
                        List<CouCourse> exists = courseMapper.selectCourseList(query);
                        
                        if (!exists.isEmpty() && updateSupport)
                        {
                            CouCourse exist = exists.get(0);
                            course.setId(exist.getId());
                            updateCourse(course);
                            successNum++;
                        }
                        else if (exists.isEmpty())
                        {
                            course.setId(null);
                            insertCourse(course);
                            successNum++;
                        }
                        else
                        {
                            failureNum++;
                            if (failureNum <= maxFailureMsg)
                                failureMsg.append("<br/>").append(failureNum).append("、课程「").append(courseName).append("」已存在");
                            else if (failureNum == maxFailureMsg + 1)
                                failureMsg.append("<br/>... (更多错误已省略)");
                        }
                    }
                    catch (Exception e)
                    {
                        failureNum++;
                        if (failureNum <= maxFailureMsg)
                            failureMsg.append("<br/>").append(failureNum).append("、").append(courseName).append("：").append(e.getMessage());
                        else if (failureNum == maxFailureMsg + 1)
                            failureMsg.append("<br/>... (更多错误已省略)");
                    }
                }
            }
            
            workbook.close();
            
            StringBuilder result = new StringBuilder();
            result.append("导入完成，成功 ").append(successNum).append(" 条");
            if (failureNum > 0)
                result.append("，失败 ").append(failureNum).append(" 条").append(failureMsg);
            return result.toString();
        }
        catch (Exception e)
        {
            throw new ServiceException("导入失败：" + e.getMessage());
        }
    }
    
    /**
     * 获取单元格值（字符串形式）
     */
    private String getCellValue(org.apache.poi.ss.usermodel.Cell cell)
    {
        if (cell == null)
        {
            return "";
        }
        
        switch (cell.getCellType())
        {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell))
                {
                    return new java.text.SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
                }
                else
                {
                    // 数字转字符串，去掉小数点
                    double numValue = cell.getNumericCellValue();
                    if (numValue == (long) numValue)
                    {
                        return String.valueOf((long) numValue);
                    }
                    else
                    {
                        return String.valueOf(numValue);
                    }
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                try
                {
                    return cell.getStringCellValue();
                }
                catch (Exception e)
                {
                    return String.valueOf(cell.getNumericCellValue());
                }
            default:
                return "";
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public String importAssignStudents(Long courseId, MultipartFile file, String operName)
    {
        if (file == null || file.isEmpty())
        {
            throw new ServiceException("上传文件不能为空");
        }

        // 验证课程是否存在
        CouCourse course = courseMapper.selectCourseById(courseId);
        if (course == null)
        {
            throw new ServiceException("课程不存在");
        }

        try
        {
            // 读取Excel文件
            ExcelUtil<StuStudentInfo> util = new ExcelUtil<>(StuStudentInfo.class);
            List<StuStudentInfo> studentList = util.importExcel(file.getInputStream());

            if (studentList == null || studentList.isEmpty())
            {
                throw new ServiceException("导入数据为空");
            }

            int successNum = 0;
            int failureNum = 0;
            StringBuilder failureMsg = new StringBuilder();
            int maxFailureMsg = 10;

            List<Long> studentUserIds = new ArrayList<>();

            for (StuStudentInfo student : studentList)
            {
                try
                {
                    // 根据学号查找学生
                    String studentNo = student.getStudentNo();
                    if (StringUtils.isEmpty(studentNo))
                    {
                        throw new ServiceException("学号不能为空");
                    }

                    StuStudentInfo existStudent = studentMapper.selectStudentByStudentNo(studentNo);
                    if (existStudent == null)
                    {
                        throw new ServiceException("学号 " + studentNo + " 不存在");
                    }

                    studentUserIds.add(existStudent.getUserId());
                    successNum++;
                }
                catch (Exception e)
                {
                    failureNum++;
                    if (failureNum <= maxFailureMsg)
                    {
                        failureMsg.append("<br/>").append(failureNum).append("、学号 ")
                                .append(student.getStudentNo()).append("：").append(e.getMessage());
                    }
                    else if (failureNum == maxFailureMsg + 1)
                    {
                        failureMsg.append("<br/>... (更多错误已省略)");
                    }
                }
            }

            // 批量分配学生
            if (!studentUserIds.isEmpty())
            {
                int assignedCount = assignStudents(courseId, studentUserIds);
                successNum = assignedCount;
            }

            StringBuilder result = new StringBuilder();
            result.append("导入完成，成功分配 ").append(successNum).append(" 名学生");
            if (failureNum > 0)
            {
                result.append("，失败 ").append(failureNum).append(" 条").append(failureMsg);
            }
            return result.toString();
        }
        catch (Exception e)
        {
            throw new ServiceException("导入失败：" + e.getMessage());
        }
    }
}
