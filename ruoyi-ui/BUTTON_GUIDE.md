# 按钮使用指南

## 按钮颜色语义化规范

为了提升用户体验和界面一致性，不同功能的按钮应使用对应的颜色类型。

---

## 🎨 按钮类型和使用场景

### 1. Primary（靛蓝色）- 主要操作
**颜色**：`#4F46E5` → `#6366F1`

**使用场景**：
- ✅ 查看详情
- ✅ 查询/搜索
- ✅ 确认操作
- ✅ 提交表单
- ✅ 登录/注册
- ✅ 下一步

**示例代码**：
```vue
<el-button type="primary">查看详情</el-button>
<el-button type="primary">查询</el-button>
<el-button type="primary">确认</el-button>
<el-button type="primary" :icon="Search">搜索</el-button>
```

**视觉效果**：
- 渐变背景：靛蓝色渐变
- 悬停：背景变深 + 阴影增强
- 适用：最重要的操作按钮

---

### 2. Success（翠绿色）- 新增/创建
**颜色**：`#10B981` → `#34D399`

**使用场景**：
- ✅ 新增记录
- ✅ 创建项目
- ✅ 添加数据
- ✅ 保存草稿
- ✅ 启用功能
- ✅ 上传文件

**示例代码**：
```vue
<el-button type="success">新增</el-button>
<el-button type="success" :icon="Plus">添加</el-button>
<el-button type="success">保存</el-button>
<el-button type="success">创建</el-button>
```

**视觉效果**：
- 渐变背景：翠绿色渐变
- 悬停：绿色阴影
- 适用：创建和新增操作

---

### 3. Warning（琥珀色）- 编辑/修改
**颜色**：`#F59E0B` → `#FBBF24`

**使用场景**：
- ✅ 编辑记录
- ✅ 修改信息
- ✅ 更新数据
- ✅ 配置设置
- ✅ 调整参数
- ✅ 重置密码

**示例代码**：
```vue
<el-button type="warning">编辑</el-button>
<el-button type="warning" :icon="Edit">修改</el-button>
<el-button type="warning">更新</el-button>
<el-button type="warning">配置</el-button>
```

**视觉效果**：
- 渐变背景：琥珀色渐变
- 悬停：橙色阴影
- 适用：修改和编辑操作

---

### 4. Danger（红色）- 删除/危险操作
**颜色**：`#EF4444` → `#F87171`

**使用场景**：
- ✅ 删除记录
- ✅ 移除数据
- ✅ 清空内容
- ✅ 禁用功能
- ✅ 注销登录
- ✅ 取消订单

**示例代码**：
```vue
<el-button type="danger">删除</el-button>
<el-button type="danger" :icon="Delete">移除</el-button>
<el-button type="danger">清空</el-button>
<el-button type="danger">禁用</el-button>
```

**视觉效果**：
- 渐变背景：红色渐变
- 悬停：红色阴影
- 适用：删除和危险操作
- **建议**：重要操作添加二次确认

---

### 5. Info（蓝色）- 导出/下载
**颜色**：`#3B82F6` → `#60A5FA`

**使用场景**：
- ✅ 导出数据
- ✅ 下载文件
- ✅ 打印报表
- ✅ 生成报告
- ✅ 备份数据
- ✅ 分享链接

**示例代码**：
```vue
<el-button type="info">导出</el-button>
<el-button type="info" :icon="Download">下载</el-button>
<el-button type="info">打印</el-button>
<el-button type="info">生成报告</el-button>
```

**视觉效果**：
- 渐变背景：蓝色渐变
- 悬停：蓝色阴影
- 适用：导出和下载操作

---

## 📝 按钮样式变体

### 文本按钮（Text Button）
**特点**：无背景，仅文字，适合次要操作

**使用场景**：
- 表格内操作链接
- 次要功能入口
- 辅助操作按钮

**示例代码**：
```vue
<!-- 不同类型的文本按钮 -->
<el-button type="primary" text>查看</el-button>
<el-button type="success" text>新增</el-button>
<el-button type="warning" text>编辑</el-button>
<el-button type="danger" text>删除</el-button>
<el-button type="info" text>导出</el-button>
```

**颜色对应**：
- Primary 文本：靛蓝色 `#4F46E5`
- Success 文本：绿色 `#10B981`
- Warning 文本：橙色 `#F59E0B`
- Danger 文本：红色 `#EF4444`
- Info 文本：蓝色 `#3B82F6`

---

### 朴素按钮（Plain Button）
**特点**：白色背景 + 彩色边框，适合并列操作

**使用场景**：
- 与实心按钮并列使用
- 次要但需要强调的操作
- 表单中的取消按钮

**示例代码**：
```vue
<!-- 不同类型的朴素按钮 -->
<el-button type="primary" plain>查看</el-button>
<el-button type="success" plain>新增</el-button>
<el-button type="warning" plain>编辑</el-button>
<el-button type="danger" plain>删除</el-button>
<el-button type="info" plain>导出</el-button>
```

---

### 圆形按钮（Circle Button）
**特点**：圆形图标按钮，适合工具栏

**使用场景**：
- 工具栏图标按钮
- 浮动操作按钮
- 快捷操作入口

**示例代码**：
```vue
<el-button type="primary" :icon="Search" circle />
<el-button type="success" :icon="Plus" circle />
<el-button type="warning" :icon="Edit" circle />
<el-button type="danger" :icon="Delete" circle />
<el-button type="info" :icon="Download" circle />
```

---

## 🎯 实际应用示例

### 表格操作列
```vue
<template>
  <el-table-column label="操作" width="240" fixed="right">
    <template #default="scope">
      <!-- 查看 - Primary -->
      <el-button type="primary" text :icon="View" @click="handleView(scope.row)">
        查看
      </el-button>
      
      <!-- 编辑 - Warning -->
      <el-button type="warning" text :icon="Edit" @click="handleEdit(scope.row)">
        编辑
      </el-button>
      
      <!-- 删除 - Danger -->
      <el-button type="danger" text :icon="Delete" @click="handleDelete(scope.row)">
        删除
      </el-button>
    </template>
  </el-table-column>
</template>
```

### 表单操作按钮
```vue
<template>
  <el-form-item>
    <!-- 主要操作 - Primary -->
    <el-button type="primary" @click="handleSubmit">
      提交
    </el-button>
    
    <!-- 次要操作 - Plain -->
    <el-button plain @click="handleCancel">
      取消
    </el-button>
    
    <!-- 重置 - Info Plain -->
    <el-button type="info" plain @click="handleReset">
      重置
    </el-button>
  </el-form-item>
</template>
```

### 页面头部操作栏
```vue
<template>
  <div class="page-header">
    <!-- 新增 - Success -->
    <el-button type="success" :icon="Plus" @click="handleAdd">
      新增用户
    </el-button>
    
    <!-- 导出 - Info -->
    <el-button type="info" :icon="Download" @click="handleExport">
      导出数据
    </el-button>
    
    <!-- 批量删除 - Danger Plain -->
    <el-button type="danger" plain :icon="Delete" @click="handleBatchDelete">
      批量删除
    </el-button>
  </div>
</template>
```

### 对话框按钮
```vue
<template>
  <el-dialog title="确认删除" v-model="visible">
    <p>确定要删除这条记录吗？此操作不可恢复。</p>
    
    <template #footer>
      <!-- 取消 - Plain -->
      <el-button plain @click="visible = false">
        取消
      </el-button>
      
      <!-- 确认删除 - Danger -->
      <el-button type="danger" @click="handleConfirmDelete">
        确认删除
      </el-button>
    </template>
  </el-dialog>
</template>
```

---

## 📊 按钮组合建议

### 主次关系
```vue
<!-- ✅ 推荐：主要操作用实心，次要操作用朴素 -->
<el-button type="primary">保存</el-button>
<el-button plain>取消</el-button>

<!-- ❌ 不推荐：两个实心按钮并列 -->
<el-button type="primary">保存</el-button>
<el-button type="info">取消</el-button>
```

### 危险操作
```vue
<!-- ✅ 推荐：危险操作使用 Danger 类型 -->
<el-button type="danger">删除</el-button>

<!-- ❌ 不推荐：危险操作使用其他颜色 -->
<el-button type="primary">删除</el-button>
```

### 表格内按钮
```vue
<!-- ✅ 推荐：表格内使用文本按钮 -->
<el-button type="warning" text>编辑</el-button>
<el-button type="danger" text>删除</el-button>

<!-- ❌ 不推荐：表格内使用实心按钮（太突出） -->
<el-button type="warning">编辑</el-button>
<el-button type="danger">删除</el-button>
```

---

## 🎨 颜色速查表

| 按钮类型 | 主色 | 渐变终点 | 使用场景 | 图标建议 |
|---------|------|---------|---------|---------|
| **Primary** | `#4F46E5` | `#6366F1` | 查看、确认、搜索 | Search, View, Check |
| **Success** | `#10B981` | `#34D399` | 新增、创建、保存 | Plus, Upload, Save |
| **Warning** | `#F59E0B` | `#FBBF24` | 编辑、修改、更新 | Edit, Setting, Refresh |
| **Danger** | `#EF4444` | `#F87171` | 删除、移除、禁用 | Delete, Close, Ban |
| **Info** | `#3B82F6` | `#60A5FA` | 导出、下载、打印 | Download, Printer, Share |

---

## 💡 最佳实践

### 1. 一致性原则
- 同一功能在不同页面使用相同颜色
- 例如：所有"编辑"按钮都用 Warning 类型

### 2. 层级原则
- 页面主要操作：实心按钮
- 次要操作：朴素按钮
- 辅助操作：文本按钮

### 3. 对比原则
- 避免相邻按钮颜色过于相似
- 危险操作与普通操作要有明显区分

### 4. 数量原则
- 一个区域内实心按钮不超过 2 个
- 避免过多颜色造成视觉混乱

### 5. 响应原则
- 所有按钮都有悬停、激活、禁用状态
- 重要操作添加加载状态

---

## 🔧 自定义按钮颜色

如需自定义按钮颜色，可以在组件中覆盖样式：

```vue
<style scoped>
/* 自定义紫色按钮 */
.custom-purple-btn {
  background: linear-gradient(135deg, #7C3AED 0%, #8B5CF6 100%);
  border: none;
  color: white;
  
  &:hover {
    background: linear-gradient(135deg, #6D28D9 0%, #7C3AED 100%);
    box-shadow: 0 6px 16px rgba(124, 58, 237, 0.3);
  }
}
</style>

<template>
  <el-button class="custom-purple-btn">自定义按钮</el-button>
</template>
```

---

## 📱 响应式建议

### 移动端
- 按钮高度增加到 44px（便于点击）
- 文字大小增加到 15px
- 图标大小增加到 18px

### 平板端
- 保持默认样式
- 适当增加按钮间距

### 桌面端
- 使用当前默认样式
- 可以使用更多文本按钮

---

## ⚠️ 注意事项

1. **避免颜色滥用**：不要因为喜欢某个颜色就随意使用
2. **保持语义化**：按钮颜色应该反映其功能
3. **考虑色盲用户**：除了颜色，还要用图标和文字区分
4. **测试对比度**：确保文字在背景上清晰可读
5. **统一团队规范**：整个团队遵循相同的按钮使用规范

---

**遵循这些规范，让你的界面更加专业和易用！** 🎉
