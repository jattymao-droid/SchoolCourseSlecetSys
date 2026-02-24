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
    @Excel(name = "年级名称")
    private String gradeName;

    /** 班级名称 */
    @Excel(name = "班级名称")
    private String className;

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
