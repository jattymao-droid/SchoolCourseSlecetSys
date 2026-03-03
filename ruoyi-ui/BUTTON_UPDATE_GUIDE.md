# 按钮颜色更新指南

## 已完成的页面

以下页面的按钮颜色已经更新为语义化配色：

### ✅ 系统管理
- **用户管理** (`src/views/system/user/index.vue`)
  - 修改按钮：Primary → Warning（橙色）
  - 删除按钮：Primary → Danger（红色）
  - 重置密码：Primary → Warning（橙色）
  - 新增按钮：Primary → Success（绿色）
  - 导出按钮：Warning → Info（蓝色）

- **菜单管理** (`src/views/system/menu/index.vue`)
  - 修改按钮：Primary → Warning（橙色）
  - 新增按钮：Primary → Success（绿色）
  - 删除按钮：Primary → Danger（红色）

- **角色管理** (`src/views/system/role/index.vue`)
  - 修改按钮：Primary → Warning（橙色）
  - 删除按钮：Primary → Danger（红色）

### ✅ 系统工具
- **代码生成** (`src/views/tool/gen/index.vue`)
  - 预览按钮：Primary（保持靛蓝）
  - 编辑按钮：Primary → Warning（橙色）
  - 删除按钮：Primary → Danger（红色）
  - 同步按钮：Primary → Warning（橙色）
  - 生成代码：Primary → Info（蓝色）

---

## 🔄 需要更新的其他页面

### 待更新列表

以下页面仍需要手动更新按钮颜色：

#### 系统管理模块
- [ ] 部门管理 (`src/views/system/dept/index.vue`)
- [ ] 岗位管理 (`src/views/system/post/index.vue`)
- [ ] 字典管理 (`src/views/system/dict/index.vue`)
- [ ] 参数设置 (`src/views/system/config/index.vue`)
- [ ] 通知公告 (`src/views/system/notice/index.vue`)
- [ ] 日志管理 (`src/views/monitor/operlog/index.vue`)
- [ ] 登录日志 (`src/views/monitor/logininfor/index.vue`)

#### 系统监控模块
- [ ] 在线用户 (`src/views/monitor/online/index.vue`)
- [ ] 定时任务 (`src/views/monitor/job/index.vue`)
- [ ] 数据监控 (`src/views/monitor/druid/index.vue`)
- [ ] 服务监控 (`src/views/monitor/server/index.vue`)
- [ ] 缓存监控 (`src/views/monitor/cache/index.vue`)

#### 系统工具模块
- [ ] 表单构建 (`src/views/tool/build/index.vue`)
- [ ] 系统接口 (`src/views/tool/swagger/index.vue`)

---

## 📝 更新规则

### 按钮类型映射

根据按钮的功能文字，使用以下映射规则：

| 功能文字 | 原类型 | 新类型 | 颜色 |
|---------|-------|-------|------|
| 查看、详情、预览 | Primary | **Primary** | 靛蓝 |
| 新增、添加、创建 | Primary | **Success** | 翠绿 |
| 编辑、修改、更新、配置、同步 | Primary | **Warning** | 琥珀 |
| 删除、移除、清空、禁用 | Primary | **Danger** | 红色 |
| 导出、下载、打印、生成 | Primary/Warning | **Info** | 蓝色 |

### 查找替换模式

#### 1. 编辑/修改按钮
```vue
<!-- 查找 -->
<el-button link type="primary" icon="Edit"

<!-- 替换为 -->
<el-button link type="warning" icon="Edit"
```

#### 2. 删除按钮
```vue
<!-- 查找 -->
<el-button link type="primary" icon="Delete"

<!-- 替换为 -->
<el-button link type="danger" icon="Delete"
```

#### 3. 新增按钮
```vue
<!-- 查找 -->
<el-button link type="primary" icon="Plus"

<!-- 替换为 -->
<el-button link type="success" icon="Plus"
```

#### 4. 导出/下载按钮
```vue
<!-- 查找 -->
<el-button link type="primary" icon="Download"
<!-- 或 -->
<el-button type="warning" plain icon="Download"

<!-- 替换为 -->
<el-button link type="info" icon="Download"
<!-- 或 -->
<el-button type="info" plain icon="Download"
```

---

## 🛠️ 批量更新方法

### 方法一：使用 VS Code 全局查找替换

1. 打开 VS Code
2. 按 `Ctrl + Shift + H` 打开全局查找替换
3. 在"文件包含"中输入：`src/views/**/*.vue`
4. 使用正则表达式模式
5. 按照上面的模式逐个替换

### 方法二：使用命令行工具

在 `ruoyi-ui` 目录下执行：

```bash
# 替换编辑按钮
find src/views -name "*.vue" -type f -exec sed -i 's/type="primary" icon="Edit"/type="warning" icon="Edit"/g' {} +

# 替换删除按钮
find src/views -name "*.vue" -type f -exec sed -i 's/type="primary" icon="Delete"/type="danger" icon="Delete"/g' {} +

# 替换新增按钮
find src/views -name "*.vue" -type f -exec sed -i 's/type="primary" icon="Plus"/type="success" icon="Plus"/g' {} +

# 替换下载按钮
find src/views -name "*.vue" -type f -exec sed -i 's/type="primary" icon="Download"/type="info" icon="Download"/g' {} +
```

**注意**：Windows 系统需要使用 Git Bash 或 WSL 执行上述命令。

### 方法三：手动逐个更新

对于复杂的页面，建议手动更新以确保准确性：

1. 打开页面文件
2. 找到操作列的按钮定义
3. 根据按钮功能修改 `type` 属性
4. 保存并测试

---

## ✅ 更新检查清单

更新完成后，检查以下内容：

- [ ] 所有"编辑"按钮使用 `type="warning"`
- [ ] 所有"删除"按钮使用 `type="danger"`
- [ ] 所有"新增"按钮使用 `type="success"`
- [ ] 所有"导出/下载"按钮使用 `type="info"`
- [ ] 所有"查看/详情"按钮使用 `type="primary"`
- [ ] 页面头部工具栏按钮颜色正确
- [ ] 表格操作列按钮颜色正确
- [ ] 对话框按钮颜色正确

---

## 🎨 特殊情况处理

### 1. 多功能按钮

如果一个按钮有多个功能，选择主要功能对应的颜色：

```vue
<!-- 编辑并保存 - 使用 Warning -->
<el-button type="warning">编辑并保存</el-button>

<!-- 删除并刷新 - 使用 Danger -->
<el-button type="danger">删除并刷新</el-button>
```

### 2. 自定义操作

对于自定义操作，根据操作的性质选择：
- 安全操作 → Primary 或 Success
- 修改操作 → Warning
- 危险操作 → Danger
- 数据操作 → Info

### 3. 状态切换按钮

```vue
<!-- 启用/禁用切换 -->
<el-button v-if="scope.row.status === '0'" type="success">启用</el-button>
<el-button v-else type="danger">禁用</el-button>
```

---

## 📊 更新进度追踪

| 模块 | 总页面数 | 已更新 | 待更新 | 进度 |
|-----|---------|-------|-------|------|
| 系统管理 | 10 | 3 | 7 | 30% |
| 系统监控 | 6 | 0 | 6 | 0% |
| 系统工具 | 3 | 1 | 2 | 33% |
| **总计** | **19** | **4** | **15** | **21%** |

---

## 💡 提示

1. **备份文件**：更新前建议先提交 Git 或备份文件
2. **逐步更新**：建议先更新几个页面测试效果
3. **团队协作**：多人协作时注意避免冲突
4. **测试验证**：更新后在浏览器中测试按钮功能
5. **保持一致**：确保整个系统的按钮颜色保持一致

---

## 🔗 相关文档

- 按钮使用指南：`BUTTON_GUIDE.md`
- 快速参考：`BUTTON_QUICK_REFERENCE.md`
- 美化文档：`CUSTOMIZATION.md`

---

**更新完成后，你的系统将拥有统一、专业的按钮配色方案！** 🎨
