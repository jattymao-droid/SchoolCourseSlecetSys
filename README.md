<div align="center">

# 🎓 学校选修课选课系统

**基于 RuoYi-Vue 的完整选课解决方案**

管理后台 + 学生选课小程序 · 支持高并发选课 · 可视化进度管理

[![GitHub](https://img.shields.io/badge/GitHub-SchoolCourseSlecetSys-blue?logo=github)](https://github.com/jattymao-droid/SchoolCourseSlecetSys)
[![Gitee](https://img.shields.io/badge/Gitee-镜像仓库-red?logo=gitee)](https://gitee.com/jatty01/school-sourse-select-sys)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-2.5+-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Vue](https://img.shields.io/badge/Vue-2.x%20%7C%203.x-4FC08D.svg)](https://vuejs.org/)

[功能特点](#-功能特点) · [技术架构](#-技术架构) · [快速开始](#-快速开始) · [部署指南](#-部署指南) · [项目文档](#-项目文档)

</div>

---

## ✨ 功能特点

### 🛒 智能选课车机制
- **周一至周五每天一门课**：学生必须为每个工作日选择恰好一门课程，系统自动校验
- **先选后提交**：选课车暂存机制，支持随时调整，提交后生成正式选课记录
- **退课即回填**：退课时已选课程全部移回选课车，可重新调整后再次提交
- **Redis 缓存**：选课车数据存储在 Redis，提升响应速度

### 📱 双端完整解决方案

<table>
<tr>
<th width="20%">端</th>
<th width="30%">技术栈</th>
<th width="50%">功能说明</th>
</tr>
<tr>
<td><strong>管理后台</strong></td>
<td>Vue 2 + Element UI</td>
<td>学期管理、年级班级管理、学生管理、课程管理、选课管理、教师考核统计</td>
</tr>
<tr>
<td><strong>学生选课 App</strong></td>
<td>UniApp + Vue 3 + TypeScript</td>
<td>支持 H5 / 微信小程序，学号登录、选课车、课表查看、课程评价</td>
</tr>
</table>

### 📊 选课进度可视化
- 课程列表实时显示「已选人数/总容量」进度条
- 颜色分级提示：
  - 🔵 蓝色（0-50%）：充足
  - 🟢 绿色（50-75%）：适中
  - 🟠 橙色（75-90%）：紧张
  - 🔴 红色（90-100%）：爆满
- 直观反映选课热度，帮助学生做出决策

### 👨‍🏫 教师考核系统
- 管理员配置考核项目和评分标准
- 学生按项对所选课程进行评价打分
- 支持开启/关闭评价周期控制
- 自动统计教师考核结果和平均分

### 🔐 安全与性能
- **JWT 双端认证**：管理端和学生端独立认证体系
- **Redis 并发控制**：防止超选和并发冲突
- **雪花算法主键**：分布式环境下保证 ID 唯一性
- **EasyExcel 批量导入**：支持学生信息批量导入导出

### 🧪 压力测试
- 提供选课并发压测脚本（`load-test/`）
- 验证系统在高并发场景下的稳定性

---

## 🛠 技术架构

### 后端技术栈
- **核心框架**：Spring Boot 2.5+、Spring Security、MyBatis
- **认证授权**：JWT Token、Redis Session
- **数据库**：PostgreSQL 12+（支持雪花算法主键）
- **缓存**：Redis 6+（选课车、并发控制）
- **工具库**：EasyExcel、Hutool、Lombok

### 前端技术栈

**管理后台**
- Vue 2.x + Vue Router + Vuex
- Element UI 组件库
- Axios 请求封装

**学生选课端**
- UniApp 跨平台框架
- Vue 3 + TypeScript
- Pinia 状态管理
- Vite 构建工具

### 系统架构图

```
┌─────────────────────────────────────────────────────────┐
│                      Nginx 反向代理                       │
└─────────────────────────────────────────────────────────┘
           │                              │
           ▼                              ▼
┌──────────────────────┐      ┌──────────────────────┐
│   管理后台 (Vue 2)    │      │  学生端 (UniApp)      │
│   Element UI         │      │  Vue 3 + TypeScript  │
└──────────────────────┘      └──────────────────────┘
           │                              │
           └──────────────┬───────────────┘
                          ▼
              ┌──────────────────────┐
              │  Spring Boot 后端     │
              │  JWT + Spring Security│
              └──────────────────────┘
                          │
          ┌───────────────┼───────────────┐
          ▼               ▼               ▼
    ┌─────────┐    ┌──────────┐    ┌─────────┐
    │PostgreSQL│    │  Redis   │    │  文件   │
    │  数据库  │    │  缓存    │    │  存储   │
    └─────────┘    └──────────┘    └─────────┘
```

---

## 📁 项目结构

```
SchoolCourseSlecetSys/
├── ruoyi-admin/              # 后端主模块（Spring Boot 启动类）
├── ruoyi-system/             # 系统核心模块（选课、课程、学生管理）
├── ruoyi-framework/          # 框架核心（安全、Redis、JWT）
├── ruoyi-common/             # 公共工具类
├── ruoyi-ui/                 # 管理后台前端（Vue 2 + Element UI）
├── course-selection-app/     # 学生选课小程序（UniApp + Vue 3）
├── sql/                      # 数据库脚本
│   ├── ry_vue_complete_*.sql # 完整数据库备份
│   └── README.md             # 数据库说明文档
├── deploy/                   # 部署相关
│   ├── scripts/              # 部署脚本
│   ├── sql/                  # 生产环境 SQL
│   └── nginx.conf            # Nginx 配置示例
├── docker/                   # Docker 部署配置
├── load-test/                # 选课并发压测脚本
└── doc/                      # 设计稿与文档
```

---

## 🚀 快速开始

### 环境要求

| 软件 | 版本要求 |
|:---|:---|
| JDK | 1.8+ |
| Maven | 3.6+ |
| Node.js | 14+ |
| PostgreSQL | 12+ |
| Redis | 6+ |

### 1️⃣ 数据库初始化

```bash
# 1. 创建数据库
createdb -U postgres ry_vue

# 2. 导入完整数据库
psql -U postgres -d ry_vue -f sql/ry_vue_complete_20260310_000408.sql
```

> 💡 数据库脚本包含完整的表结构、菜单权限、初始数据

### 2️⃣ 后端启动

```bash
# 1. 修改数据库配置
# 编辑 ruoyi-admin/src/main/resources/application-druid.yml
# 修改 PostgreSQL 和 Redis 连接信息

# 2. 编译打包
mvn clean install

# 3. 启动后端服务
cd ruoyi-admin
mvn spring-boot:run

# 或直接运行 jar 包
java -jar target/ruoyi-admin.jar
```

后端服务默认运行在 `http://localhost:8080`

### 3️⃣ 管理后台启动

```bash
cd ruoyi-ui

# 安装依赖
npm install

# 启动开发服务器
npm run dev
```

访问 `http://localhost:80`，默认账号：`admin / admin123`

### 4️⃣ 学生选课 App 启动

```bash
cd course-selection-app

# 安装依赖
npm install

# H5 开发模式
npm run dev:h5

# 微信小程序开发模式
npm run dev:mp-weixin
```

> 💡 微信小程序需要使用微信开发者工具打开 `dist/dev/mp-weixin` 目录

### 5️⃣ 验证安装

- 管理后台：登录后查看课程管理、学生管理等功能
- 学生端：使用学号登录（默认密码：123456），体验选课流程

---

## 📦 部署指南

### Docker 部署（推荐）

```bash
# 1. 构建部署包
cd scripts
./build-for-deploy.ps1  # Windows
# 或
./build-for-deploy.sh   # Linux/Mac

# 2. 上传 deploy 目录到服务器

# 3. 执行部署脚本
cd deploy/scripts
chmod +x deploy.sh
./deploy.sh
```

### 传统部署

详细部署步骤请参考：
- [部署文档](./deploy/README.md)
- [Nginx 配置说明](./deploy/nginx.conf)
- [数据库导入脚本](./deploy/scripts/import-database.sh)

---

## 📖 项目文档

- [Redis 配置说明](./REDIS-README.md)
- [课程进度功能说明](./COURSE_PROGRESS_FEATURE.md)
- [数据库管理文档](./sql/README.md)
- [部署脚本说明](./scripts/deploy-README.md)

---

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

---

## 📞 联系方式

- **GitHub Issues**: [提交问题](https://github.com/jattymao-droid/SchoolCourseSlecetSys/issues)
- **Gitee Issues**: [提交问题](https://gitee.com/jatty01/school-sourse-select-sys/issues)

---

## 📄 许可证

本项目采用 [MIT License](./LICENSE) 开源协议

---

## 🙏 致谢

- [RuoYi-Vue](https://gitee.com/y_project/RuoYi-Vue) - 基础框架
- [Element UI](https://element.eleme.io/) - UI 组件库
- [UniApp](https://uniapp.dcloud.io/) - 跨平台框架

---

<div align="center">

**如果这个项目对你有帮助，请给个 ⭐️ Star 支持一下！**

</div>
