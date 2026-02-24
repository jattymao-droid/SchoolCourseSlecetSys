# 东陆高中选修课选课系统 — 新功能与 RuoYi 深度融合方案

> 基于 `dev.md` 开发方案，结合 RuoYi-Vue3 现有能力，分析如何将选修课选课系统与框架进行深度融合。

---

## 一、融合总览

| 融合维度 | RuoYi 现有能力 | 选课系统需求 | 融合策略 |
|---------|----------------|-------------|----------|
| 用户体系 | sys_user + 角色 | 学生、教师、管理员 | 扩展 user_type，复用 sys_user |
| 组织架构 | sys_dept 树形 | 年级、班级 | **独立表** sys_grade / sys_class，不替代 sys_dept |
| 权限菜单 | sys_menu + sys_role | 管理员端 / 学生端 | 新增角色 + 菜单，动态路由自动适配 |
| 字典配置 | sys_dict_type / sys_dict_data | 星期、状态等 | 新增业务字典 |
| 登录认证 | Spring Security + JWT | 学号+密码 | 复用，user_name 存学号 |
| 代码生成 | gen 模块 | 快速 CRUD | 配置 PostgreSQL 数据源后生成 |

---

## 二、用户体系深度融合

### 2.1 现状

- `sys_user` 已有 `user_type` 字段（SQL 中 `VARCHAR(2) DEFAULT '00'`，注释：00=系统用户）
- `SysUser.java` 实体**未暴露** `userType` 属性
- 用户通过 `sys_user_role` 关联角色，角色通过 `sys_role_menu` 控制菜单权限

### 2.2 融合方案

**1）扩展 sys_user 与 SysUser 实体**

- 在 `SysUser.java` 中增加 `userType` 字段
- 在 `sys_dict_type` 中新增字典 `sys_user_type`：
  - `00`：系统用户（管理员等）
  - `01`：学生
  - `02`：教师

**2）学生扩展信息**

- 按 `dev.md` 建议，**不直接改 sys_user 表**，新建 `stu_student_info`：
  - `user_id` 关联 `sys_user.user_id`
  - `student_no`、`real_name`、`class_id`、`grade_id`
- 学生登录：`user_name` 存学号，密码加密存储，与现有登录逻辑完全兼容

**3）角色设计**

| 角色 | role_key | 说明 | 菜单范围 |
|------|----------|------|----------|
| 超级管理员 | admin | 原有 | 全部 |
| 教务管理员 | course_admin | 新增 | 学期、年级班级、学生、课程、评价等 |
| 教师 | teacher | 新增 | 查看任教课程、选课学生等 |
| 学生 | student | 新增 | 选课中心、退课、课程评价 |

**4）用户管理扩展**

- 在系统管理 → 用户管理中增加「用户类型」筛选
- 学生列表可单独做「学生管理」模块，关联 `stu_student_info`，支持 Excel 导入、重置密码

---

## 三、组织架构：年级班级 vs 部门

### 3.1 为何不直接用 sys_dept

- `sys_dept` 面向企业组织（公司→分公司→部门），含 `ancestors`、`leader`、`phone` 等
- 学校场景是「年级→班级」，语义不同，且班级需要与课程容量、选课记录强关联
- 若用 sys_dept 表示班级，需大量扩展字段，与 RuoYi 原有部门逻辑耦合过深

### 3.2 推荐：独立年级班级表

- 使用 `sys_grade`、`sys_class`（按 dev.md 设计）
- `sys_class.grade_id` 关联 `sys_grade`
- 与 `sys_dept` 解耦，便于「一键升级」等业务逻辑

### 3.3 与 sys_user 的关联方式

- **学生**：`stu_student_info.class_id` → `sys_class`
- **教师**：`cou_course.teacher_id` → `sys_user.user_id`（user_type=02）
- **管理员**：可继续使用 `sys_user.dept_id` 做数据权限（若需要按部门隔离）

---

## 四、菜单与路由融合

### 4.1 RuoYi 菜单机制

- 菜单存储在 `sys_menu`，通过 `sys_role_menu` 分配给角色
- 前端通过 `getRouters` 接口获取当前用户菜单，动态生成路由
- `component` 对应 `views/` 下路径，如 `system/user/index` → `@/views/system/user/index.vue`

### 4.2 新增菜单结构建议

```
选修课管理（父菜单，仅管理员）
├── 学期管理          → semester/index
├── 年级班级管理      → grade/index, class/index（或合并页面）
├── 学生管理          → student/index
├── 课程管理          → course/index
├── 课程容量配置      → course/quota（或嵌入课程表单）
├── 评价管理          → evaluation/index

选课中心（学生端，student 角色）
├── 选课车 / 提交选课  → selection/index
├── 我的选课          → selection/my
├── 课程评价          → evaluation/student
```

### 4.3 实现要点

- 在 `sys_menu` 中插入上述菜单，`perms` 如 `course:semester:list`、`selection:cart:add` 等
- 将菜单分配给「教务管理员」「学生」等角色
- 前端在 `ruoyi-ui/src/views/` 下新建 `course/`、`selection/`、`evaluation/` 等目录
- 学生登录后仅看到「选课中心」相关菜单，管理员看到「选修课管理」

---

## 五、字典与配置融合

### 5.1 新增字典类型（sys_dict_type）

| 字典类型 | 说明 | 示例数据 |
|----------|------|----------|
| course_week_day | 星期几 | 1=周一, 2=周二, ..., 5=周五 |
| selection_status | 选课状态 | 1=正常, 0=已退课 |
| eva_question_status | 评价题目状态 | 1=启用, 0=停用 |
| sys_user_type | 用户类型 | 00=系统用户, 01=学生, 02=教师 |

### 5.2 系统配置（sys_config）

- 可选：`course.default_password`（学生默认密码规则，如学号后六位）
- 可选：`course.cart_expire_minutes`（选课车 Redis 过期时间，默认 30）

---

## 六、核心业务与框架的衔接点

### 6.1 学生导入

- 使用 RuoYi 的 `ExcelUtil` + EasyExcel
- 流程：解析 Excel → 校验班级 → 创建 `sys_user`（user_name=学号，user_type=01）→ 插入 `stu_student_info`
- 需在 `SysUser` 的导入逻辑外，单独实现 `StudentService.importStudents()`，保证事务一致性

### 6.2 重置密码

- 复用 `ISysUserService.resetPwd(userId, newPassword)`
- 在学生管理页面提供「重置密码」按钮，新密码按配置规则生成并加密

### 6.3 选课车（Redis）

- Key：`cart:studentId:semesterId`
- Value：Hash，field=weekDay，value=courseId
- 与 RuoYi 的 Redis 配置共用，无需新增组件

### 6.4 权限控制

- 后端：`@PreAuthorize("@ss.hasPermi('course:semester:list')")` 等
- 学生端接口：校验 `SecurityUtils.getUserId()` 与操作对象所属学生一致
- 选课提交：使用 Redis 分布式锁或令牌防重复提交

### 6.5 数据权限（可选）

- 若教师只能看本年级/本班数据，可借助 RuoYi 的 `@DataScope` 注解
- 需在 `sys_role` 的 `data_scope` 及 `sys_role_dept` 中配置，并将年级/班级映射到 dept 或自定义数据权限逻辑

---

## 七、开发顺序建议

| 阶段 | 内容 | 依赖 |
|------|------|------|
| 1 | 数据库：创建 sys_semester、sys_grade、sys_class、stu_student_info、cou_course、cou_class_quota、stu_selection、eva_question、stu_evaluation | 无 |
| 2 | 扩展 SysUser：增加 userType；新增字典 sys_user_type | 阶段 1 |
| 3 | 新增角色：教务管理员、教师、学生 | 阶段 2 |
| 4 | 学期、年级、班级管理（CRUD + 一键升级） | 阶段 1–3 |
| 5 | 学生管理（含导入、重置密码） | 阶段 1–4 |
| 6 | 课程管理、课程容量、复制到新学期 | 阶段 1–5 |
| 7 | 选课车 + 提交 + 退课（含 Redis、事务、并发控制） | 阶段 1–6 |
| 8 | 评价管理 + 学生评分 | 阶段 1–7 |
| 9 | 前端：管理员端全部页面 | 阶段 4–8 |
| 10 | 前端：学生端选课中心、评价页 | 阶段 7–8 |

---

## 八、融合检查清单

- [ ] `sys_user` 增加 `user_type` 使用，`SysUser` 实体同步
- [ ] 新建 `stu_student_info`，不破坏 sys_user 原有结构
- [ ] 年级班级独立于 sys_dept，使用 sys_grade、sys_class
- [ ] 新增角色并分配菜单权限
- [ ] 在 sys_menu 中配置选修课相关菜单及 perms
- [ ] 新增业务字典类型与数据
- [ ] 学生登录使用 user_name=学号，与现有登录兼容
- [ ] 选课车使用项目已有 Redis
- [ ] 代码生成器配置 PostgreSQL 数据源，生成基础 CRUD 后按业务定制

---

## 九、总结

通过 **扩展 user_type、独立年级班级表、复用菜单与权限体系**，选修课选课系统可以深度融入 RuoYi，既保留框架的认证、权限、字典、代码生成等能力，又避免对核心表过度改造。学生、教师、管理员统一在 `sys_user` 体系下，通过角色和菜单实现界面与接口的差异化访问。
