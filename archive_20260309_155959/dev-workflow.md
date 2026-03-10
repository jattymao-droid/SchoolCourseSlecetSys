# 东陆高中选修课选课系统 — 分阶段开发流程文档

> 按功能模块分阶段开发，每完成一项任务请将 `[ ]` 改为 `[x]` 标记进度。  
> 相关文档：`dev.md`（业务方案）、`dev-integration.md`（融合方案）

---

## 进度总览

| 阶段 | 功能模块 | 状态 | 完成度 |
|------|----------|------|--------|
| 0 | 基础准备 | ✅ 已完成 | 12/12 |
| 1 | 学期管理 | ✅ 已完成 | 6/6 |
| 2 | 年级班级管理 | ✅ 已完成 | 8/8 |
| 3 | 学生管理 | ✅ 已完成 | 10/10 |
| 4 | 课程管理 | ✅ 已完成 | 12/12 |
| 5 | 选课系统 | ✅ 已完成 | 14/14 |
| 6 | 评价管理 | ✅ 已完成 | 10/10 |
| 7 | 收尾与优化 | ⬜ 未开始 | 0/6 |

**整体进度：72 / 78**

---

## 阶段 0：基础准备

**目标**：完成数据库表、用户体系扩展、字典、角色等基础设施，为后续业务模块提供支撑。

### 0.1 数据库表创建

- [x] **0.1.1** 创建 `sys_semester` 学期表（含主键、字段、注释）
- [x] **0.1.2** 创建 `sys_grade` 年级表
- [x] **0.1.3** 创建 `sys_class` 班级表（含 grade_id 外键）
- [x] **0.1.4** 创建 `stu_student_info` 学生扩展表（含 user_id、class_id 唯一约束）
- [x] **0.1.5** 创建 `cou_course` 课程表、`cou_class_quota` 课程班级容量表
- [x] **0.1.6** 创建 `stu_selection` 选课记录表、`eva_question` 评价题目表、`stu_evaluation` 学生评分表
- [x] **0.1.7** 编写并执行 PostgreSQL 建表脚本，验证表结构

### 0.2 用户体系扩展

- [x] **0.2.1** 在 `SysUser.java` 中增加 `userType` 字段及 getter/setter
- [x] **0.2.2** 在 `SysUserMapper.xml` 中增加 `user_type` 的 select/insert/update 映射
- [x] **0.2.3** 在 `sys_dict_type` 中新增 `sys_user_type`，并插入字典数据（00=系统用户, 01=学生, 02=教师）

### 0.3 角色与菜单骨架

- [x] **0.3.1** 在 `sys_role` 中新增角色：教务管理员（course_admin）、教师（teacher）、学生（student）
- [x] **0.3.2** 在 `sys_menu` 中新增父菜单「选修课管理」「选课中心」（可先不分配子菜单，后续按模块补充）

---

## 阶段 1：学期管理

**目标**：实现学期的增删改查及设置当前学期功能。

### 1.1 后端

- [x] **1.1.1** 创建 `SysSemester` 实体类
- [x] **1.1.2** 创建 `SysSemesterMapper` 及 XML，实现 CRUD
- [x] **1.1.3** 创建 `ISysSemesterService` 及实现类
- [x] **1.1.4** 创建 `SemesterController`：list、get、add、edit、remove、setCurrent
- [x] **1.1.5** 为接口添加 `@PreAuthorize` 权限控制（如 `course:semester:list`）

### 1.2 前端

- [x] **1.2.1** 在 `sys_menu` 中新增「学期管理」菜单，配置路由 `course/semester/index`
- [x] **1.2.2** 创建 `views/course/semester/index.vue`：表格、表单弹窗、设置当前学期按钮
- [x] **1.2.3** 将「学期管理」菜单分配给教务管理员、超级管理员角色

---

## 阶段 2：年级班级管理

**目标**：实现年级、班级的 CRUD 及一键升级功能。

### 2.1 后端

- [x] **2.1.1** 创建 `SysGrade`、`SysClass` 实体类
- [x] **2.1.2** 创建 `SysGradeMapper`、`SysClassMapper` 及 XML
- [x] **2.1.3** 创建 `GradeController`、`ClassController`，实现 CRUD
- [x] **2.1.4** 在 `GradeService` 中实现 `upgradeGrades()` 一键升级逻辑
- [x] **2.1.5** 新增接口 `POST /course/grade/upgrade`，添加权限控制

### 2.2 前端

- [x] **2.2.1** 在 `sys_menu` 中新增「年级班级管理」菜单
- [x] **2.2.2** 创建 `views/course/grade/index.vue`：年级表格、班级联动（或树形+表格）
- [x] **2.2.3** 实现一键升级按钮及确认弹窗
- [x] **2.2.4** 将菜单分配给教务管理员、超级管理员角色

---

## 阶段 3：学生管理

**目标**：实现学生信息的增删改查、Excel 导入、重置密码。

### 3.1 后端

- [x] **3.1.1** 创建 `StuStudentInfo` 实体类
- [x] **3.1.2** 创建 `StuStudentInfoMapper` 及 XML，支持关联 sys_user、sys_class 查询
- [x] **3.1.3** 创建 `StudentController`：list、get、add、edit、remove
- [x] **3.1.4** 实现学生导入：下载模板接口、Excel 解析、校验班级、创建 sys_user + stu_student_info（事务）
- [x] **3.1.5** 实现重置密码接口：调用 `ISysUserService.resetPwd`，默认密码规则（如学号后六位）

### 3.2 前端

- [x] **3.2.1** 在 `sys_menu` 中新增「学生管理」菜单
- [x] **3.2.2** 创建 `views/course/student/index.vue`：表格、表单、班级下拉（级联年级）
- [x] **3.2.3** 实现导入：下载模板按钮、Upload 组件、导入结果提示
- [x] **3.2.4** 实现重置密码按钮及确认弹窗
- [x] **3.2.5** 将菜单分配给教务管理员、超级管理员角色

---

## 阶段 4：课程管理

**目标**：实现课程 CRUD、班级容量配置、复制到新学期、查看选课学生。

### 4.1 后端

- [x] **4.1.1** 创建 `CouCourse`、`CouClassQuota` 实体类
- [x] **4.1.2** 创建 `CouCourseMapper`、`CouClassQuotaMapper` 及 XML
- [x] **4.1.3** 创建 `CourseController`：list、get、add、edit、remove
- [x] **4.1.4** 实现课程保存时同步维护 `cou_class_quota`（批量插入/更新）
- [x] **4.1.5** 实现 `POST /course/course/copyToNewSemester/{oldId}/{newId}` 复制课程到新学期
- [x] **4.1.6** 实现查看某课程已选学生列表接口及导出
- [x] **4.1.7** 新增字典 `course_week_day`（1=周一 … 5=周五）

### 4.2 前端

- [x] **4.2.1** 在 `sys_menu` 中新增「课程管理」菜单
- [x] **4.2.2** 创建 `views/course/course/index.vue`：课程表格、表单（含星期、年级、教师、班级容量表格）
- [x] **4.2.3** 实现班级容量动态行（可添加/删除行，选择班级、填写名额）
- [x] **4.2.4** 实现「复制到新学期」操作：下拉选择目标学期，调用接口
- [x] **4.2.5** 实现「查看选课学生」弹窗及导出按钮

---

## 阶段 5：选课系统

**目标**：实现选课车、提交选课、退课、剩余名额查询，含 Redis 与并发控制。

### 5.1 后端

- [x] **5.1.1** 创建 `StuSelection` 实体类及 `StuSelectionMapper`
- [x] **5.1.2** 实现选课车 Redis 服务：Key `cart:studentId:semesterId`，Hash 结构，过期 30 分钟
- [x] **5.1.3** 实现选课车接口：获取、加入、移除、清空
- [x] **5.1.4** 实现提交选课：校验选课车周一至周五齐全、校验名额、事务插入 stu_selection、更新 cou_class_quota.selected、清空选课车
- [x] **5.1.5** 实现并发控制：`UPDATE cou_class_quota SET selected = selected + 1 WHERE ... AND selected < quota`
- [x] **5.1.6** 实现退课接口：删除/逻辑删除选课记录、回退 selected、将课程放回选课车（已实现：退课时先放回选课车再移出选课记录）
- [x] **5.1.7** 实现查询剩余名额接口、我的选课列表接口
- [x] **5.1.8** 选课提交防重复：Redis 令牌或分布式锁

### 5.2 前端

- [x] **5.2.1** 在 `sys_menu` 中新增「选课中心」下子菜单：选课车、我的选课
- [x] **5.2.2** 创建 `views/selection/index.vue`：当前学期展示、课程卡片（按星期分组）、选课车区域（周一至周五卡片）
- [x] **5.2.3** 实现加入选课车、移除、提交选课按钮（周一至周五齐全时启用）
- [x] **5.2.4** 创建 `views/selection/my.vue`：已选课程列表、退课重选按钮
- [x] **5.2.5** 将选课中心菜单分配给学生角色
- [ ] **5.2.6** 学生登录后默认跳转选课中心（可选）

---

## 阶段 6：评价管理

**目标**：实现评价题目管理、开启/关闭评价、学生评分。

### 6.1 后端

- [x] **6.1.1** 创建 `EvaQuestion`、`StuEvaluation` 实体类及 Mapper
- [x] **6.1.2** 创建 `EvaluationController`（管理员）：题目 list、add、edit、remove、启用/停用
- [x] **6.1.3** 实现学生评分接口：校验题目启用、分值范围、唯一约束（student_id, course_id, question_id）
- [x] **6.1.4** 实现学生获取待评价课程列表、已评分列表接口
- [x] **6.1.5** 新增字典 `eva_question_status`（1=启用, 0=停用）

### 6.2 前端

- [x] **6.2.1** 在 `sys_menu` 中新增「评价管理」菜单（管理员）、「课程评价」菜单（学生）
- [x] **6.2.2** 创建 `views/course/evaluation/index.vue`：题目列表、启用/停用开关
- [x] **6.2.3** 创建 `views/selection/evaluation.vue`：已选课程列表、评价弹窗（Form + 评分输入）
- [x] **6.2.4** 将评价管理分配给教务管理员，课程评价分配给学生角色

---

## 阶段 7：收尾与优化

**目标**：完善权限、测试、文档与部署准备。

### 7.1 权限与安全

- [ ] **7.1.1** 检查所有接口的 `@PreAuthorize` 及学生端数据归属校验
- [ ] **7.1.2** 确认学生角色无法访问管理员菜单及接口

### 7.2 测试与修复

- [ ] **7.2.1** 功能测试：学期、年级班级、学生导入、课程、选课、退课、评价全流程
- [ ] **7.2.2** 并发测试：多用户同时选课、名额扣减正确性
- [ ] **7.2.3** 修复测试中发现的问题

### 7.3 配置与部署

- [ ] **7.3.1** 在 `sys_config` 中配置 `course.cart_expire_minutes`、`course.default_password`（可选）
- [ ] **7.3.2** 更新 README 或部署文档，说明选修课模块的菜单、角色、初始化数据

---

## 使用说明

1. **开发顺序**：建议按阶段 0 → 1 → 2 → … → 7 依次进行，每阶段内可按子任务顺序执行。
2. **进度标记**：完成某项任务后，将对应行的 `[ ]` 改为 `[x]`。
3. **进度总览**：定期更新文档顶部的「完成度」和「整体进度」，便于跟踪。
4. **依赖关系**：阶段 1–7 均依赖阶段 0；阶段 3 依赖阶段 2；阶段 4 依赖阶段 1、2；阶段 5 依赖阶段 1–4；阶段 6 依赖阶段 1–5。

---

## 常见问题排查

### 1. `/course/grade/listAll` 返回 500

**可能原因与处理：**

| 现象 | 可能原因 | 处理方式 |
|------|----------|----------|
| 后端启动失败，报 `ClassNotFoundException: SysClass` | ruoyi-common 未正确编译/安装 | 在 IntelliJ 中执行 **Build → Rebuild Project**；或关闭所有 Java 进程后执行 `mvn clean install -DskipTests` |
| 后端能启动，但接口返回 500 | **数据库表缺失**（最常见） | 在 PostgreSQL 中依次执行 `sql/course_selection_init.sql` 和 `sql/course_grade_class_menu.sql`，确认 `sys_grade` 表已创建 |
| 课程评价菜单不显示 | **评价菜单未初始化** | 执行 `sql/course_evaluation_menu.sql`（依赖 course_selection_menu.sql），执行后重新登录 |
| 教师考核页面空白 | **教师考核菜单未初始化** | 执行 `sql/course_teacher_assessment_menu.sql`，执行后**退出并重新登录** |
| 教师考核页面空白 | loadView 组件解析失败 | 已在前端 `permission.js` 增加 `course/teacherAssessment/index` 显式兜底，刷新页面即可 |
| 同上 | 权限不足 | 确认当前用户角色有 `course:grade:list` 权限，或使用超级管理员（admin）登录 |
| 同上 | 其他异常 | 查看后端控制台或 `logs/` 目录下的异常堆栈；前端 ElMessage 会显示具体错误信息 |

### 2. Maven 构建失败（文件被占用）

若出现 `Failed to delete ... ruoyi-admin.jar` 或 `Failed to install ... ruoyi-common-3.9.1.jar`：

1. 关闭 IntelliJ IDEA 及所有正在运行的后端进程
2. 在项目根目录执行：`mvn clean install -DskipTests`
3. 若仍失败，可临时重命名或删除 `ruoyi-admin/target`、`~/.m2/repository/com/ruoyi/ruoyi-common` 后重试

### 3. 推荐启动方式

- **开发环境**：在 IntelliJ 中直接运行 `RuoYiApplication`（确保已 Rebuild Project）
- **命令行**：`cd ruoyi-admin && mvn spring-boot:run`（需先执行 `mvn install` 成功）

---

## 变更记录

| 日期 | 变更内容 |
|------|----------|
| 2025-02-23 | 初版创建 |
