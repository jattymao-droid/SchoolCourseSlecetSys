package com.ruoyi.system.domain;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 指定学生请求 DTO
 *
 * @author ruoyi
 */
public class AssignStudentsDTO
{
    @JsonProperty("studentIds")
    private List<? extends Number> studentIds;

    /** 转为 Long 列表，兼容 JSON 反序列化为 Integer 的情况 */
    public List<Long> getStudentIdsAsLong()
    {
        if (studentIds == null || studentIds.isEmpty())
        {
            return Collections.emptyList();
        }
        return studentIds.stream()
            .map(Number::longValue)
            .collect(Collectors.toList());
    }

    public List<? extends Number> getStudentIds()
    {
        return studentIds != null ? studentIds : new ArrayList<>();
    }

    public void setStudentIds(List<? extends Number> studentIds)
    {
        this.studentIds = studentIds;
    }
}
