# SchoolCourseSlecetSys

<p align="center">
  <strong>学校选修课选课系统</strong>
</p>
<p align="center">
  基于 RuoYi-Vue 的完整选课解决方案 · 管理后台 + 学生选课小程序
</p>
<p align="center">
  <a href="https://github.com/jattymao-droid/SchoolCourseSlecetSys"><img src="https://img.shields.io/badge/GitHub-SchoolCourseSlecetSys-blue?logo=github"></a>
  <a href="https://github.com/jattymao-droid/SchoolCourseSlecetSys/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg"></a>
</p>

---

## ✨ 项目特点

### 🛒 选课车机制
- **周一至周五每天一门课**：学生必须为每个工作日选择 exactly 一门课程，满足条件方可提交
- **先选后提交**：选课车暂存，支持调整，提交后生成正式选课记录
- **退课即回填**：退课时已选课程全部移回选课车，可重新调整后再次提交

### 📱 双端设计
| 端 | 技术栈 | 说明 |
|:---|:---|:---|
| **管理后台** | Vue 2 + Element UI | 学期、年级班级、学生、课程、选课管理、教师考核 |
| **学生选课 App** | UniApp + Vue 3 + TypeScript | H5 / 微信小程序，学号登录、选课车、课表、评价 |

### 📊 选课进度可视化
- 课程列表实时显示「已选/总容量」进度条
- 颜色分级：蓝 → 绿 → 橙 → 红，直观反映选课热度

### 👨‍🏫 教师考核
- 管理员配置考核项，学生按项对所选课程打分
- 支持开启/关闭评价周期，统计教师考核结果

### 🔧 技术亮点
- **PostgreSQL** 适配，雪花算法主键
- **Redis** 选课车缓存与并发控制
- **JWT** 多端认证（管理端 + 学生端）
- **EasyExcel** 学生批量导入导出

---

## 🛠 技术栈

| 层级 | 技术 |
|:---|:---|
| 后端 | Spring Boot、Spring Security、MyBatis、JWT、Redis |
| 管理前端 | Vue 2、Element UI、Axios |
| 学生端 | UniApp、Vue 3、TypeScript、Pinia、Vite |
| 数据库 | PostgreSQL 12+ |

---

## 📁 项目结构

```
├── ruoyi-admin/          # 后端主模块
├── ruoyi-ui/             # 管理后台前端
├── course-selection-app/ # 学生选课小程序 (UniApp)
├── sql/                  # 数据库脚本、初始化、菜单等
├── load-test/            # 选课并发压测脚本
└── doc/                  # 设计稿与文档
```

---

## 🚀 快速开始

### 1. 数据库
- 创建 PostgreSQL 数据库 `ry_vue`
- 执行 `sql/ry_20250522_postgresql.sql` 及 `sql/course_selection_init.sql` 等初始化脚本

### 2. 后端
```bash
# 修改 ruoyi-admin/src/main/resources/application-druid.yml 中的数据库连接
mvn clean install
mvn -pl ruoyi-admin spring-boot:run
```

### 3. 管理后台
```bash
cd ruoyi-ui
npm install
npm run dev
```

### 4. 学生选课 App
```bash
cd course-selection-app
npm install
npm run dev:h5   # 或 dev:mp-weixin 运行微信小程序
```

---

## 📄 许可证

MIT License
