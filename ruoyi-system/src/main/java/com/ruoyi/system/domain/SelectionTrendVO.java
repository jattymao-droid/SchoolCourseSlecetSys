package com.ruoyi.system.domain;

import java.util.Date;

/**
 * 选课趋势（按日期统计）
 *
 * @author ruoyi
 */
public class SelectionTrendVO
{
    private String dateStr;
    private Date date;
    private Long count;

    public String getDateStr() { return dateStr; }
    public void setDateStr(String dateStr) { this.dateStr = dateStr; }
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    public Long getCount() { return count; }
    public void setCount(Long count) { this.count = count; }
}
