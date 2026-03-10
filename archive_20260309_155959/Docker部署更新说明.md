# Docker 部署更新说明

## 更新时间
2026-03-09 00:04:01

## 问题描述
服务器上部署时报错：`错误: 未找到 PostgreSQL`

原因：服务器上的 PostgreSQL 和 Redis 是通过 Docker 容器运行的，而不是直接安装在系统上。原部署脚本使用 `psql` 和 `redis-cli` 命令检查服务，导致检查失败。

## 解决方案

### 1. 更新部署脚本 (server-deploy.sh)

已将部署脚本更新为支持 Docker 容器环境：

#### 主要变更：

**环境检查部分**
- 移除了对 `psql` 和 `redis-cli` 命令的检查
- 添加了 Docker 检查
- 自动检测运行中的 PostgreSQL 和 Redis Docker 容器

```bash
# 检查 Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}错误: 未找到 Docker${NC}"
    exit 1
fi

# 检查 PostgreSQL 容器
POSTGRES_CONTAINER=$(docker ps --filter "ancestor=postgres" --format "{{.Names}}" | head -n 1)
if [ -z "$POSTGRES_CONTAINER" ]; then
    POSTGRES_CONTAINER=$(docker ps --filter "name=postgres" --format "{{.Names}}" | head -n 1)
fi

# 检查 Redis 容器
REDIS_CONTAINER=$(docker ps --filter "ancestor=redis" --format "{{.Names}}" | head -n 1)
if [ -z "$REDIS_CONTAINER" ]; then
    REDIS_CONTAINER=$(docker ps --filter "name=redis" --format "{{.Names}}" | head -n 1)
fi
```

**数据库操作部分**
- 所有数据库操作通过 `docker exec` 在容器内执行
- 数据库创建：`docker exec -e PGPASSWORD="${DB_PASSWORD}" "${POSTGRES_CONTAINER}" createdb -U ${DB_USER} ${DB_NAME}`
- 数据导入：先将 SQL 文件复制到容器，再在容器内执行导入

```bash
# 将 SQL 文件复制到容器
docker cp sql/database_backup.sql "${POSTGRES_CONTAINER}":/tmp/database_backup.sql

# 在容器中执行导入
docker exec -e PGPASSWORD="${DB_PASSWORD}" "${POSTGRES_CONTAINER}" psql -U ${DB_USER} -d ${DB_NAME} -f /tmp/database_backup.sql
```

**状态检查部分**
- 更新 `status.sh` 脚本，使用 `docker ps` 检查容器状态

```bash
# PostgreSQL 状态 (Docker)
POSTGRES_STATUS=$(docker ps --filter "name=postgres" --format "{{.Status}}" | head -n 1)

# Redis 状态 (Docker)
REDIS_STATUS=$(docker ps --filter "name=redis" --format "{{.Status}}" | head -n 1)
```

### 2. 重新打包部署包

已使用更新后的脚本重新生成部署包：

- **文件名**: `course-selection_20260309_000028.zip`
- **大小**: 78.32 MB
- **位置**: `deploy-package/course-selection_20260309_000028.zip`
- **更新时间**: 2026-03-09 00:04:01

## 部署包内容

```
course-selection_20260309_000028/
├── backend/
│   └── ruoyi-admin.jar              # 后端应用 (支持 Docker 环境)
├── frontend/                         # 前端静态文件
├── sql/
│   └── database_backup.sql          # 数据库备份 (school-course)
├── server-deploy.sh                 # ✅ 一键部署脚本 (已更新支持 Docker)
└── 部署指南.md                       # ✅ 部署文档
```

## 使用方法

### 1. 上传部署包到服务器

```bash
# 使用 SCP 或宝塔面板上传
scp deploy-package/course-selection_20260309_000028.zip root@your-server:/root/deploy/
```

### 2. 解压并部署

```bash
# SSH 登录服务器
ssh root@your-server

# 解压
cd /root/deploy
unzip course-selection_20260309_000028.zip
cd course-selection_20260309_000028

# 运行部署脚本
chmod +x server-deploy.sh
./server-deploy.sh
```

## 前置要求

服务器必须满足以下条件：

1. ✅ 已安装 Docker
2. ✅ PostgreSQL Docker 容器正在运行
3. ✅ Redis Docker 容器正在运行
4. ✅ 已安装 Java 1.8+
5. ✅ 已安装 Nginx
6. ✅ 域名已解析到服务器 IP

## 验证 Docker 容器

在运行部署脚本前，请确认容器正在运行：

```bash
# 查看所有运行中的容器
docker ps

# 应该能看到类似输出：
# CONTAINER ID   IMAGE      COMMAND                  STATUS
# xxxxxxxxxxxx   postgres   "docker-entrypoint.s…"   Up X hours
# xxxxxxxxxxxx   redis      "docker-entrypoint.s…"   Up X hours
```

## 数据库配置

部署脚本会自动：
1. 检测 PostgreSQL 容器
2. 创建数据库 `school-course`
3. 导入数据（39 个表，2512 条数据）

数据库连接信息：
- 数据库名: `school-course`
- 用户名: `postgres`
- 密码: `mm5621528`
- 端口: `5432`

## 常见问题

### Q: 如果容器名称不是 "postgres" 或 "redis" 怎么办？

A: 脚本会自动检测：
- 先查找镜像名为 `postgres` 或 `redis` 的容器
- 如果找不到，再查找容器名包含 `postgres` 或 `redis` 的容器

### Q: 如何手动指定容器名称？

A: 编辑 `server-deploy.sh`，在脚本开头添加：

```bash
POSTGRES_CONTAINER="your_postgres_container_name"
REDIS_CONTAINER="your_redis_container_name"
```

### Q: 部署失败如何排查？

A: 按以下步骤检查：

1. 检查 Docker 是否运行：`systemctl status docker`
2. 检查容器状态：`docker ps`
3. 检查容器日志：`docker logs <container_name>`
4. 测试数据库连接：`docker exec <postgres_container> psql -U postgres -c "SELECT 1"`

## 更新内容总结

| 项目 | 原方案 | 新方案 |
|------|--------|--------|
| PostgreSQL 检查 | `command -v psql` | `docker ps --filter "name=postgres"` |
| Redis 检查 | `command -v redis-cli` | `docker ps --filter "name=redis"` |
| 数据库创建 | `su - postgres -c "createdb"` | `docker exec ... createdb` |
| 数据库导入 | `PGPASSWORD=... psql ...` | `docker cp ... && docker exec ... psql ...` |
| 状态检查 | `systemctl is-active postgresql` | `docker ps --filter "name=postgres"` |

## 技术支持

如遇到问题，请提供以下信息：
1. 服务器操作系统版本
2. Docker 版本：`docker --version`
3. 容器列表：`docker ps -a`
4. 部署脚本输出日志
5. 容器日志：`docker logs <container_name>`

---

**部署包已就绪，可以上传到服务器进行部署！**
