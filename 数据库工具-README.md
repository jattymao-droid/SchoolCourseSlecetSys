# 服务器数据库工具集 - 快速开始

## 🚀 一分钟快速开始

### 你遇到的问题

运行 `manage-database-server.sh` 时显示 `school-course` 数据库是空的（0 rows）。

### 快速解决方案

```bash
# 1. 上传自动修复脚本到服务器
scp auto-fix-database-server.sh root@your-server:/root/

# 2. 运行自动修复
chmod +x auto-fix-database-server.sh
./auto-fix-database-server.sh

# 3. 按照提示选择修复方案
# 通常选择方案1（修改脚本连接到正确的数据库）

# 4. 修复完成后，使用管理工具
./manage-database-server.sh
```

## 📦 工具包内容

### 核心工具（5个脚本）

1. **diagnose-database-server.sh** - 诊断工具 🔍
   - 快速了解数据库状态
   - 找出配置问题

2. **auto-fix-database-server.sh** - 自动修复工具 🔧
   - 一键修复配置问题
   - 自动导入数据

3. **manage-database-server.sh** - 管理工具 📊
   - 查看和管理所有表
   - 执行SQL查询
   - 备份和优化

4. **clean-database-server.sh** - 清理工具 🧹
   - 清理测试数据
   - 多种清理模式

5. **clean-deleted-records-server.sh** - 清理逻辑删除 🗑️
   - 解决"学号已存在"问题
   - 清除 del_flag='2' 记录

### 文档（5个文档）

1. **服务器数据库工具集说明.md** - 完整工具集说明
2. **数据库管理工具使用说明.md** - 管理工具详细文档
3. **服务器数据库清理说明.md** - 清理工具使用说明
4. **数据库问题快速解决指南.md** - 问题解决指南
5. **fix-database-name.md** - 数据库名称问题分析

## 🎯 使用场景

### 场景 1: 数据库管理工具显示 0 rows

```bash
./auto-fix-database-server.sh
```

### 场景 2: 删除学生后重新导入报错

```bash
./clean-deleted-records-server.sh
```

### 场景 3: 不确定使用哪个数据库

```bash
./diagnose-database-server.sh
```

### 场景 4: 日常数据库管理

```bash
./manage-database-server.sh
```

### 场景 5: 清理测试数据

```bash
./clean-database-server.sh
```

## 📋 完整安装步骤

### 步骤 1: 上传所有文件

```bash
# 上传所有脚本
scp diagnose-database-server.sh root@your-server:/root/
scp auto-fix-database-server.sh root@your-server:/root/
scp manage-database-server.sh root@your-server:/root/
scp clean-database-server.sh root@your-server:/root/
scp clean-deleted-records-server.sh root@your-server:/root/

# 或者打包上传
tar -czf database-tools.tar.gz *.sh *.md
scp database-tools.tar.gz root@your-server:/root/
ssh root@your-server "cd /root && tar -xzf database-tools.tar.gz"
```

### 步骤 2: 添加执行权限

```bash
ssh root@your-server
cd /root
chmod +x *.sh
```

### 步骤 3: 运行诊断

```bash
./diagnose-database-server.sh
```

### 步骤 4: 自动修复

```bash
./auto-fix-database-server.sh
```

### 步骤 5: 开始使用

```bash
./manage-database-server.sh
```

## 🔥 推荐工作流

### 首次使用

```
诊断 → 自动修复 → 管理工具
  ↓         ↓          ↓
了解状态  修复问题   日常使用
```

### 日常维护

```
管理工具 → 查看信息 → 优化数据库
   ↓          ↓           ↓
 查看表    备份数据    清理记录
```

## 💡 常用命令速查

### 查看所有数据库

```bash
docker exec -it <container_name> psql -U postgres -c "\l"
```

### 查看指定数据库的表

```bash
docker exec -it <container_name> psql -U postgres -d school-course -c "\dt"
```

### 手动清除逻辑删除记录

```bash
docker exec -it <container_name> psql -U postgres -d school-course -c "DELETE FROM stu_student_info WHERE del_flag='2';"
docker exec -it <container_name> psql -U postgres -d school-course -c "DELETE FROM sys_user WHERE del_flag='2';"
```

### 备份数据库

```bash
docker exec -i <container_name> pg_dump -U postgres school-course > backup.sql
```

### 恢复数据库

```bash
docker exec -i <container_name> psql -U postgres -d school-course < backup.sql
```

## ⚙️ 配置说明

所有脚本的默认配置：

```bash
DB_NAME="school-course"      # 数据库名称
DB_USER="postgres"           # 数据库用户
DB_PASSWORD="mm5621528"      # 数据库密码
```

如果需要修改，编辑脚本的配置部分即可。

## 🆘 遇到问题？

### 问题 1: 提示"未找到PostgreSQL容器"

**解决**:
```bash
docker ps | grep postgres
docker start <container_name>
```

### 问题 2: 提示"数据库连接失败"

**解决**:
```bash
# 检查数据库是否存在
docker exec -it <container_name> psql -U postgres -c "\l"

# 检查密码是否正确
docker exec -it <container_name> psql -U postgres -d school-course -c "SELECT 1;"
```

### 问题 3: 自动修复失败

**解决**:
1. 查看诊断工具的输出
2. 阅读相关文档
3. 手动执行修复步骤

## 📚 详细文档

- **完整功能说明**: 查看 `服务器数据库工具集说明.md`
- **管理工具文档**: 查看 `数据库管理工具使用说明.md`
- **问题解决指南**: 查看 `数据库问题快速解决指南.md`

## ✅ 功能特性

- ✨ 自动检测PostgreSQL容器
- 🎨 彩色输出，界面友好
- 🔒 安全确认，防止误操作
- 🤖 自动化修复，省时省力
- 📊 详细统计，一目了然
- 📖 完整文档，易于上手

## 🎉 开始使用

现在你已经了解了所有工具，选择一个开始吧：

```bash
# 推荐：先运行诊断
./diagnose-database-server.sh

# 然后根据诊断结果决定下一步
```

祝使用愉快！ 🚀
