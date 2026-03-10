# 课程选课系统 - 服务器部署包

## 版本信息

- 打包时间：2026-03-09 20:08:42
- 后端版本：3.9.1
- 前端版本：3.9.1
- 数据库：PostgreSQL (Docker)
- 缓存：Redis (Docker)

## 重要更新

本次更新包含以下重要修复：

### 1. 学生删除功能修复
- ✅ 修改为物理删除（完全删除记录）
- ✅ 删除学生时同时删除用户记录
- ✅ 删除用户角色和岗位关联
- ✅ 支持批量删除

### 2. 学生导入功能增强
- ✅ 添加批次内重复检查
- ✅ 更详细的错误信息
- ✅ 区分不同类型的冲突（Excel重复、学生表冲突、用户表冲突）
- ✅ 增强日志记录

## 部署包内容

```
deploy-server-20260309_200842/
├── backend/
│   └── ruoyi-admin.jar          # 后端应用（83.28 MB）
├── frontend/                     # 前端静态文件
│   ├── index.html
│   ├── static/
│   └── ...
├── database_backup.dump          # 数据库备份
├── deploy.sh                     # 一键部署脚本
└── README.md                     # 本文件
```

## 服务器要求

- 操作系统：CentOS 7
- 面板：宝塔面板
- Java：JDK 8 或更高版本
- Docker：已安装并运行
- PostgreSQL：Docker 容器运行（端口 5432）
- Redis：Docker 容器运行（端口 6379）
- Nginx：已安装
- 域名：xk.xmls.vip（已配置 SSL）

## 部署步骤

### 1. 上传部署包

将整个 `deploy-server-20260309_200842` 目录上传到服务器任意位置，例如：
```bash
/root/deploy-server-20260309_200842/
```

### 2. 执行部署脚本

```bash
cd /root/deploy-server-20260309_200842
chmod +x deploy.sh
bash deploy.sh
```

### 3. 等待部署完成

脚本会自动完成以下操作：
1. 检查系统环境（Java、Docker、PostgreSQL、Redis、Nginx）
2. 创建目录结构（/www/wwwroot/course-selection）
3. 部署后端应用
4. 部署前端应用
5. 导入数据库（自动删除旧数据库）
6. 配置 Nginx
7. 创建管理脚本（start.sh、stop.sh、restart.sh）
8. 启动后端服务

### 4. 验证部署

访问：https://xk.xmls.vip

默认账号：
- 管理员：admin / admin123
- 学生：学号 / 123456
- 教师：工号 / 123456

## 管理命令

### 启动后端
```bash
/www/wwwroot/course-selection/backend/start.sh
```

### 停止后端
```bash
/www/wwwroot/course-selection/backend/stop.sh
```

### 重启后端
```bash
/www/wwwroot/course-selection/backend/restart.sh
```

### 查看日志
```bash
tail -f /www/wwwroot/course-selection/logs/backend.log
```

### 查看后端状态
```bash
ps aux | grep ruoyi-admin.jar
```

## 数据库信息

- 数据库名：school-course
- 用户名：postgres
- 密码：mm5621528
- 端口：5432
- 容器：自动检测

### 连接数据库
```bash
# 查找 PostgreSQL 容器名
docker ps | grep postgres

# 连接数据库（替换 CONTAINER_NAME）
docker exec -it CONTAINER_NAME psql -U postgres -d school-course
```

## 故障排查

### 1. 后端启动失败

查看日志：
```bash
tail -f /www/wwwroot/course-selection/logs/backend.log
```

常见问题：
- 端口 8080 被占用：`netstat -tlnp | grep 8080`
- 数据库连接失败：检查 PostgreSQL 容器是否运行
- Redis 连接失败：检查 Redis 容器是否运行

### 2. 前端访问 404

检查 Nginx 配置：
```bash
cat /www/server/panel/vhost/nginx/xk.xmls.vip.conf
```

确认前端目录：
```bash
ls -la /www/wwwroot/course-selection/frontend/
```

重载 Nginx：
```bash
nginx -t
nginx -s reload
```

### 3. 数据库导入失败

手动导入：
```bash
# 查找 PostgreSQL 容器名
PG_CONTAINER=$(docker ps --format '{{.Names}}' | grep -i postgres | head -n 1)

# 删除旧数据库
docker exec $PG_CONTAINER psql -U postgres -c "DROP DATABASE \"school-course\";"

# 创建新数据库
docker exec $PG_CONTAINER psql -U postgres -c "CREATE DATABASE \"school-course\" OWNER postgres;"

# 导入数据
docker exec -i $PG_CONTAINER pg_restore -U postgres -d school-course -v < database_backup.dump
```

### 4. 学生删除后重新导入失败

这个问题已经在本次更新中修复。如果仍然遇到，请：

1. 检查数据库中是否有逻辑删除的记录：
```sql
SELECT COUNT(*) FROM stu_student_info WHERE del_flag = '2';
```

2. 如果有，清理这些记录：
```sql
DELETE FROM stu_student_info WHERE del_flag = '2';
DELETE FROM sys_user WHERE user_type = '01' AND del_flag = '2';
```

3. 重新导入学生

## 更新说明

### 从旧版本更新

如果服务器上已经部署了旧版本，执行以下步骤：

1. 停止旧的后端服务：
```bash
/www/wwwroot/course-selection/backend/stop.sh
```

2. 备份旧的 JAR 文件（可选）：
```bash
cp /www/wwwroot/course-selection/backend/ruoyi-admin.jar /www/wwwroot/course-selection/backend/ruoyi-admin.jar.bak
```

3. 执行新的部署脚本：
```bash
cd /root/deploy-server-20260309_200842
bash deploy.sh
```

部署脚本会自动：
- 覆盖旧的后端 JAR 文件
- 更新前端文件
- 重新导入数据库（会删除旧数据库）
- 重启后端服务

## 注意事项

1. **数据库会被重新导入**：部署脚本会删除旧的 `school-course` 数据库并重新导入。如果需要保留数据，请先备份。

2. **Nginx 配置**：如果 Nginx 配置文件不存在，需要手动配置。参考配置：
   - 前端目录：`/www/wwwroot/course-selection/frontend`
   - 后端代理：`http://127.0.0.1:8080/`

3. **防火墙**：确保端口 8080 在防火墙中开放（如果使用）。

4. **SSL 证书**：域名 xk.xmls.vip 的 SSL 证书应该已经配置好。

## 技术支持

如有问题，请检查：
1. 后端日志：`/www/wwwroot/course-selection/logs/backend.log`
2. Nginx 日志：`/www/wwwlogs/xk.xmls.vip.log`
3. Nginx 错误日志：`/www/wwwlogs/xk.xmls.vip.error.log`

## 版本历史

### v3.9.1 (2026-03-09)
- ✅ 修复学生删除功能（改为物理删除）
- ✅ 增强学生导入功能（批次内重复检查）
- ✅ 优化错误信息显示
- ✅ 增强日志记录
