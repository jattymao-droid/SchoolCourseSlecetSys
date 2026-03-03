# 课程选课进度功能说明

## 功能概述
在课程管理列表中添加了"选课进度"列，用于实时显示每门课程的选课情况。

## 实现内容

### 1. 后端修改

#### 1.1 实体类修改 (`CouCourse.java`)
添加了两个新字段：
- `totalQuota`: 总容量（所有班级容量之和）
- `selectedCount`: 总已选人数（所有班级已选人数之和）

#### 1.2 Mapper XML修改 (`CouCourseMapper.xml`)
修改了 `selectCourseList` 查询，添加了子查询来统计：
```sql
left join (
    select course_id, 
           sum(quota) as total_quota, 
           sum(selected) as selected_count
    from cou_class_quota
    where del_flag = '0'
    group by course_id
) quota_sum on c.id = quota_sum.course_id
```

### 2. 前端修改

#### 2.1 Vue组件修改 (`course/course/index.vue`)
- 添加了"选课进度"列
- 使用 Element Plus 的 `el-progress` 组件显示进度条
- 添加了数字显示（已选人数/总容量）

#### 2.2 进度条颜色规则
- 蓝色 (#3B82F6): 选课率 < 40% (人数较少)
- 绿色 (#10B981): 选课率 40-69% (正常)
- 橙色 (#F59E0B): 选课率 70-89% (较多人选)
- 红色 (#EF4444): 选课率 ≥ 90% (接近满员)

#### 2.3 样式优化
- 进度条宽度: 12px
- 圆角设计
- 渐变背景色
- 数字显示：已选人数用大号粗体，总容量用常规字体

## 使用说明

### 重启后端服务
由于修改了Java代码和Mapper XML，需要重启后端服务：

1. 停止当前运行的后端服务
2. 重新启动 `RuoYiApplication`

### 查看效果
1. 登录管理后台
2. 进入"课程管理"页面
3. 在课程列表中可以看到新增的"选课进度"列
4. 进度条会根据选课情况自动显示不同颜色

## 数据来源
- 数据来自 `cou_class_quota` 表
- `quota` 字段：班级容量
- `selected` 字段：已选人数
- 系统自动汇总所有班级的数据

## 注意事项
1. 如果课程没有设置班级容量，进度显示为 0/0
2. 进度条颜色会根据选课率自动变化
3. 前端支持热更新，刷新页面即可看到效果
4. 后端需要重启才能生效

## 文件修改清单
- `ruoyi-common/src/main/java/com/ruoyi/common/core/domain/entity/CouCourse.java`
- `ruoyi-system/src/main/resources/mapper/course/CouCourseMapper.xml`
- `ruoyi-ui/src/views/course/course/index.vue`
