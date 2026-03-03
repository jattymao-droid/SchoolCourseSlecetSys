# 按钮快速参考卡片

## 🎯 一图看懂按钮颜色

```
┌─────────────────────────────────────────────────────────────┐
│                     按钮颜色语义化速查                        │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  🔵 Primary (靛蓝)    →  查看 | 确认 | 搜索 | 提交           │
│  🟢 Success (翠绿)    →  新增 | 创建 | 保存 | 添加           │
│  🟠 Warning (琥珀)    →  编辑 | 修改 | 更新 | 配置           │
│  🔴 Danger  (红色)    →  删除 | 移除 | 清空 | 禁用           │
│  🔵 Info    (蓝色)    →  导出 | 下载 | 打印 | 生成           │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## 📝 常用代码片段

### 表格操作列（最常用）
```vue
<el-table-column label="操作" width="200">
  <template #default="scope">
    <el-button type="primary" text>查看</el-button>
    <el-button type="warning" text>编辑</el-button>
    <el-button type="danger" text>删除</el-button>
  </template>
</el-table-column>
```

### 页面头部工具栏
```vue
<el-button type="success" :icon="Plus">新增</el-button>
<el-button type="info" :icon="Download">导出</el-button>
<el-button type="danger" plain>批量删除</el-button>
```

### 表单提交区域
```vue
<el-button type="primary">提交</el-button>
<el-button plain>取消</el-button>
```

### 确认对话框
```vue
<template #footer>
  <el-button plain>取消</el-button>
  <el-button type="danger">确认删除</el-button>
</template>
```

## 🎨 按钮类型对照表

| 操作 | 按钮类型 | 代码 |
|-----|---------|------|
| 查看详情 | Primary | `<el-button type="primary">查看</el-button>` |
| 新增记录 | Success | `<el-button type="success">新增</el-button>` |
| 编辑数据 | Warning | `<el-button type="warning">编辑</el-button>` |
| 删除记录 | Danger | `<el-button type="danger">删除</el-button>` |
| 导出数据 | Info | `<el-button type="info">导出</el-button>` |
| 搜索查询 | Primary | `<el-button type="primary">搜索</el-button>` |
| 保存草稿 | Success | `<el-button type="success">保存</el-button>` |
| 更新配置 | Warning | `<el-button type="warning">更新</el-button>` |
| 清空表单 | Danger | `<el-button type="danger">清空</el-button>` |
| 下载文件 | Info | `<el-button type="info">下载</el-button>` |

## 💡 记忆口诀

```
靛蓝查看和确认，
翠绿新增和创建，
琥珀编辑和修改，
红色删除要小心，
蓝色导出和下载。
```

## ⚡ 快速决策树

```
需要添加按钮？
    ↓
是否是查看/确认操作？ → 是 → Primary (靛蓝)
    ↓ 否
是否是新增/创建操作？ → 是 → Success (翠绿)
    ↓ 否
是否是编辑/修改操作？ → 是 → Warning (琥珀)
    ↓ 否
是否是删除/危险操作？ → 是 → Danger (红色)
    ↓ 否
是否是导出/下载操作？ → 是 → Info (蓝色)
    ↓ 否
使用 Primary (靛蓝) 作为默认
```

## 🎯 三秒规则

**看到按钮文字，3 秒内选择颜色：**

- 看、查、搜、确 → 靛蓝
- 增、加、建、存 → 翠绿
- 改、编、更、配 → 琥珀
- 删、移、清、禁 → 红色
- 导、下、印、生 → 蓝色

## 📱 移动端提示

移动端建议：
- 按钮高度：44px（便于点击）
- 文字大小：15px
- 图标大小：18px
- 按钮间距：12px

## ⚠️ 常见错误

❌ **错误示例**：
```vue
<!-- 删除操作用了绿色 -->
<el-button type="success">删除</el-button>

<!-- 新增操作用了红色 -->
<el-button type="danger">新增</el-button>

<!-- 表格内用实心按钮（太突出） -->
<el-button type="primary">编辑</el-button>
```

✅ **正确示例**：
```vue
<!-- 删除操作用红色 -->
<el-button type="danger">删除</el-button>

<!-- 新增操作用绿色 -->
<el-button type="success">新增</el-button>

<!-- 表格内用文本按钮 -->
<el-button type="warning" text>编辑</el-button>
```

## 🔗 相关文档

- 完整指南：`BUTTON_GUIDE.md`
- 美化文档：`CUSTOMIZATION.md`
- 配置模板：`brand.config.template.js`

---

**打印此页，贴在显示器旁边！** 📌
