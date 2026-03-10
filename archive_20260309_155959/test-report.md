# 东陆选课系统 - 综合测试报告

> 测试时间：2025-02-25  
> 本次执行：2025-02-25（已逐一执行）

---

## 〇、本次执行结果摘要

| 阶段 | 状态 | 说明 |
|------|------|------|
| 后端 Maven 编译 | ✅ | 18s |
| 后端 Maven 测试 | ✅ | 8s |
| 选课 App 类型检查 | ✅ | 8s |
| 选课 App H5 构建 | ✅ | 21s |
| 管理后台生产构建 | ✅ | 34s |
| 后端服务启动 | ✅ | http://localhost:8080 |
| 选课 App 开发服务 | ✅ | http://localhost:5173 |
| 管理后台开发服务 | ✅ | http://localhost:82 |
| 验证码 API | ✅ | GET /captchaImage 返回 200 |
| 登录 API | ✅ | POST /login 接口正常（需有效验证码） |

**当前运行中的服务：**
- 后端：`http://localhost:8080`
- 选课 App：`http://localhost:5173`（H5，代理 /api → 8080）
- 管理后台：`http://localhost:82`

---

## 一、自动化测试结果

### 1. 后端 (RuoYi)

| 项目 | 结果 | 说明 |
|------|------|------|
| Maven 编译 | ✅ 通过 | `mvnw clean compile` |
| Maven 测试 | ✅ 通过 | `mvnw test` |

### 2. 选课 App (course-selection-app)

| 项目 | 结果 | 说明 |
|------|------|------|
| TypeScript 类型检查 | ✅ 通过 | `npm run type-check` |
| H5 构建 | ✅ 通过 | `npm run build:h5` |

**修复的 TypeScript 问题：**
- `evaluation.vue`：`:key` 从 `item.selectionId` 改为 `` `${item.courseId}-${item.weekDay}` ``（后端 VO 无 selectionId）
- `request.ts`：ApiResponse 与 rows/total 类型兼容处理
- `tabBar.ts`：移除对 void 的 truthiness 检查

### 3. 管理后台 (ruoyi-ui)

| 项目 | 结果 | 说明 |
|------|------|------|
| 生产构建 | ✅ 通过 | `npm run build:prod` |

---

## 二、功能模块清单（建议手动验证）

### 后端 API

- [x] **登录**：`POST /login` — 接口正常，需有效验证码
- [ ] **用户信息**：`GET /getInfo` — 需登录后测试
- [ ] **学期**：`GET /course/semester/current`、列表 CRUD — 需登录
- [ ] **课程**：`GET /course/course/list`（含 classId 按班级名额）、详情
- [ ] **选课车**：获取、加入、移除、清空、提交
- [ ] **我的选课**：`GET /course/selection/my`（含 location）、退课
- [ ] **学生信息**：`GET /course/student/me`（含 classId）
- [ ] **评价**：待评价列表、提交评价
- [ ] **看板**：`GET /course/dashboard/student`

### 选课 App (H5) — 访问 http://localhost:5173

- [ ] 登录页：验证码、登录、退出
- [ ] 首页：学期、选课进度、快捷入口、热门课程
- [ ] 课程列表：搜索、星期筛选、分页、按班级显示名额
- [ ] 课程详情：加入选课车
- [ ] 选课车：周一到周五网格、提交选课
- [ ] 我的课表：周视图、已选列表
- [ ] 我的选课：列表（含地点）、退课
- [ ] 课程评价：待评价、提交评分
- [ ] 个人中心：修改密码、退出

### 管理后台 (ruoyi-ui) — 访问 http://localhost:82

- [ ] 学期管理：CRUD、设置当前学期
- [ ] 年级/班级管理：CRUD、一键升级
- [ ] 学生管理：CRUD、导入导出
- [ ] 课程管理：CRUD、班级容量、分配学生
- [ ] 选课车：查看、管理
- [ ] 我的选课：查看、退课
- [ ] 评价管理：题目、统计

---

## 三、启动与验证步骤

### 1. 启动后端

```bash
cd e:\AI\CourseSlecetSys
.\mvnw.cmd spring-boot:run -pl ruoyi-admin
```

确保 PostgreSQL 已启动，`application-druid.yml` 中数据库配置正确。

### 2. 启动选课 App (H5)

```bash
cd course-selection-app
npm run dev:h5
```

浏览器访问 `http://localhost:5173`，配置 Vite 代理指向后端 `/api`。

### 3. 启动管理后台

```bash
cd ruoyi-ui
npm run dev
```

访问 `http://localhost:82`（若 80 被占用会使用 81、82 等）。

### 4. 测试账号（参考 sql 脚本）

- 管理员：`admin` / `admin123`
- 学生：学号如 `202401001` / `admin123`（需执行 `fix_student_login_by_student_no.sql`）

### 5. 手动验证建议流程

1. **选课 App**：打开 http://localhost:5173 → 输入验证码登录（admin/admin123 或学生账号）→ 依次验证首页、课程、选课车、我的选课、评价、个人中心
2. **管理后台**：打开 http://localhost:82 → admin/admin123 登录 → 选修课管理 → 依次验证学期、年级班级、学生、课程、选课、评价

---

## 四、已知提示（非错误）

- Sass `@import` 弃用警告：可后续迁移到 `@use`
- uni-app 新版本提示：可选更新
- 选课 App 构建时的 DEPRECATION WARNING：不影响运行
