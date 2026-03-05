package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;

/**
 * 学生导入 DTO
 *
 * @author ruoyi
 */
public class StudentImportDTO
{
    /** 学号 */
    @Excel(name = "学号")
    private String studentNo;

    /** 姓名 */
    @Excel(name = "姓名")
    private String realName;

    /** 年级名称 */
    @Excel(name = "年级")
    private String gradeName;

    /** 年级名称（兼容旧模板） */
    @Excel(name = "年级名称")
    private String gradeNameFallback;

    /** 班级名称 */
    @Excel(name = "班级")
    private String className;

    /** 班级名称（兼容旧模板） */
    @Excel(name = "班级名称")
    private String classNameFallback;

    public String getGradeNameFallback()
    {
        return gradeNameFallback;
    }

    public void setGradeNameFallback(String gradeNameFallback)
    {
        this.gradeNameFallback = gradeNameFallback;
    }

    public String getClassNameFallback()
    {
        return classNameFallback;
    }

    public void setClassNameFallback(String classNameFallback)
    {
        this.classNameFallback = classNameFallback;
    }

    public String getStudentNo()
    {
        return studentNo;
    }

    public void setStudentNo(String studentNo)
    {
        this.studentNo = studentNo;
    }

    public String getRealName()
    {
        return realName;
    }

    public void setRealName(String realName)
    {
        this.realName = realName;
    }

    public String getGradeName()
    {
        return gradeName;
    }

    public void setGradeName(String gradeName)
    {
        this.gradeName = gradeName;
    }

    public String getClassName()
    {
        return className;
    }

    public void setClassName(String className)
    {
        this.className = className;
    }
}
