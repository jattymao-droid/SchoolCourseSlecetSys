# 数据库备份说明

## 备份文件信息

- **文件名**: `ry_vue_full_backup_20260308_210240.sql`
- **数据库**: ry_vue (PostgreSQL)
- **导出时间**: 2026-03-08 21:02:40
- **文件大小**: 0.72 MB (752,086 字节)
- **导出工具**: pg_dump version 17.5

## 数据库结构

本备份包含完整的数据库结构和数据，包括以下主要表：

### 课程选课系统表
- `cou_course` - 课程表
- `cou_class_quota` - 课程班级容量表
- `stu_selection` - 学生选课表
- `stu_student_info` - 学生信息表
- `stu_evaluation` - 课程评价表
- `eva_question` - 评价问题表

### 系统管理表
- `sys_user` - 用户表
- `sys_role` - 角色表
- `sys_menu` - 菜单表
- `sys_dept` - 部门表
- `sys_config` - 系统配置表
- `sys_dict_type` - 字典类型表
- `sys_dict_data` - 字典数据表
- `sys_post` - 岗位表

### 学校基础数据表
- `sys_grade` - 年级表
- `sys_class` - 班级表
- `sys_semester` - 学期表

### 系统日志表
- `sys_oper_log` - 操作日志表
- `sys_logininfor` - 登录日志表
- `sys_job_log` - 定时任务日志表

### 定时任务表 (Quartz)
- `qrtz_*` - Quartz定时任务相关表

### 代码生成表
- `gen_table` - 代码生成业务表
- `gen_table_column` - 代码生成业务字段表

## 如何恢复数据库

### 方法1: 使用 psql 命令行工具

```bash
# 1. 创建新数据库（如果需要）
createdb -U postgres ry_vue_new

# 2. 恢复数据
psql -U postgres -d ry_vue_new -f ry_vue_full_backup_20260308_210240.sql
```

### 方法2: 使用 PowerShell 脚本

```powershell
# 设置环境变量
$env:PGPASSWORD = "your_password"

# 恢复数据库
psql -h localhost -p 5432 -U postgres -d ry_vue_new -f ry_vue_full_backup_20260308_210240.sql

# 清除密码环境变量
Remove-Item Env:\PGPASSWORD
```

### 方法3: 使用 pgAdmin

1. 打开 pgAdmin
2. 右键点击目标数据库
3. 选择 "Restore..."
4. 选择备份文件
5. 点击 "Restore" 按钮

## 导出脚本使用说明

项目根目录下提供了自动导出脚本：

### export-db.ps1

```powershell
# 直接运行导出脚本
./export-db.ps1
```

脚本会自动：
1. 读取数据库配置
2. 使用 pg_dump 导出完整数据库
3. 生成带时间戳的备份文件
4. 保存到 sql 文件夹

## 备份特点

- **完整备份**: 包含所有表结构、数据、索引、约束、序列等
- **INSERT格式**: 使用 INSERT 语句而不是 COPY，更具可移植性
- **列名包含**: INSERT 语句包含列名，更易读和维护
- **UTF-8编码**: 使用 UTF-8 编码，支持中文等多语言字符

## 注意事项

1. **密码安全**: 备份文件不包含密码，但恢复时需要提供数据库密码
2. **版本兼容**: 建议使用相同或更高版本的 PostgreSQL 进行恢复
3. **数据覆盖**: 恢复操作会覆盖目标数据库的现有数据，请谨慎操作
4. **权限要求**: 恢复操作需要数据库的创建和写入权限

## 定期备份建议

建议定期执行数据库备份：
- 开发环境：每周备份一次
- 测试环境：每天备份一次
- 生产环境：每天备份，并保留多个历史版本

可以使用 Windows 任务计划程序或 cron 定时执行 export-db.ps1 脚本。

## 联系信息

如有问题，请联系系统管理员。
