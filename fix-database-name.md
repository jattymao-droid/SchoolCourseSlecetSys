# 数据库名称问题分析和解决方案

## 问题分析

你遇到的问题是：**数据库管理脚本连接的数据库名称不正确**

### 实际情况

1. **部署脚本使用的数据库名称**: `school-course`
   - 位置: `deploy-server-20260309_200842/deploy.sh`
   - 配置: `DB_NAME="school-course"`

2. **生产环境配置文件使用的数据库名称**: `school-course`
   - 位置: `ruoyi-admin/src/main/resources/application-druid-prod.yml`
   - 配置: `url: jdbc:postgresql://localhost:5432/school-course`

3. **数据库管理脚本使用的数据库名称**: `school-course`
   - 位置: `manage-database-server.sh`
   - 配置: `DB_NAME="school-course"`

### 问题原因

数据库 `school-course` 是空的（0 rows），说明：
1. 数据库已创建，但数据没有导入成功
2. 或者后端应用实际连接的是另一个数据库

## 解决方案

### 方案 1: 检查实际使用的数据库（推荐）

运行以下命令查看PostgreSQL中所有数据库：

```bash
docker exec -it postgresql_npxc-postgresql_NpXc-1 psql -U postgres -c "\l"
```

这会列出所有数据库，找到包含数据的数据库。

### 方案 2: 检查后端日志

查看后端启动日志，确认实际连接的数据库：

```bash
tail -f /www/wwwroot/course-selection/logs/backend.log | grep "jdbc:postgresql"
```

### 方案 3: 重新导入数据库

如果 `school-course` 数据库确实是空的，需要重新导入数据：

```bash
# 进入部署目录
cd /root/deploy-server-20260309_200842

# 重新导入数据库
docker exec -i postgresql_npxc-postgresql_NpXc-1 pg_restore -U postgres -d school-course -v < database_backup.dump
```

### 方案 4: 修改数据库管理脚本

如果实际使用的数据库名称不是 `school-course`，需要修改管理脚本：

编辑 `manage-database-server.sh`，修改第 18 行：

```bash
# 原来
DB_NAME="school-course"

# 改为实际的数据库名称（例如 ry_vue）
DB_NAME="ry_vue"
```

## 快速诊断命令

### 1. 列出所有数据库

```bash
docker exec -it postgresql_npxc-postgresql_NpXc-1 psql -U postgres -c "\l"
```

### 2. 检查每个数据库的表数量

```bash
# 检查 school-course
docker exec -it postgresql_npxc-postgresql_NpXc-1 psql -U postgres -d school-course -c "\dt"

# 检查 ry_vue（如果存在）
docker exec -it postgresql_npxc-postgresql_NpXc-1 psql -U postgres -d ry_vue -c "\dt"

# 检查 postgres（默认数据库）
docker exec -it postgresql_npxc-postgresql_NpXc-1 psql -U postgres -d postgres -c "\dt"
```

### 3. 查看后端配置

```bash
# 查看后端JAR包中的配置
cd /www/wwwroot/course-selection/backend
unzip -p ruoyi-admin.jar BOOT-INF/classes/application-druid-prod.yml | grep "url:"
```

### 4. 查看后端进程使用的数据库连接

```bash
# 查看后端进程
ps aux | grep ruoyi-admin.jar

# 查看数据库连接
docker exec -it postgresql_npxc-postgresql_NpXc-1 psql -U postgres -c "SELECT datname, usename, application_name, client_addr FROM pg_stat_activity WHERE datname IS NOT NULL;"
```

## 最可能的情况

根据你的配置文件分析，最可能的情况是：

1. **开发环境使用**: `ry_vue` 数据库
2. **生产环境应该使用**: `school-course` 数据库
3. **当前问题**: `school-course` 数据库是空的，数据没有导入成功

## 建议操作步骤

1. 先运行诊断命令，确认实际情况
2. 如果 `school-course` 是空的，重新导入数据库
3. 如果后端实际连接的是 `ry_vue`，修改管理脚本的数据库名称
4. 重启后端服务，确保使用正确的数据库

## 需要我帮你做什么？

请告诉我：
1. 运行 `docker exec -it postgresql_npxc-postgresql_NpXc-1 psql -U postgres -c "\l"` 的结果
2. 或者直接告诉我你想要：
   - 重新导入数据到 `school-course` 数据库
   - 修改管理脚本连接到其他数据库
   - 创建一个自动诊断脚本
