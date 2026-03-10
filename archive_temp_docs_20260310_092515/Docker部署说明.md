# 学校选课系统 - Docker 部署说明

## 快速开始

### 1. 本地构建部署包

在项目根目录（SchoolCourseSlecetSys）执行：

```powershell
.\build-docker-package.ps1
```

构建完成后，会在 `deploy` 目录生成完整的部署包。

### 2. 上传到服务器

将 `deploy` 文件夹上传到服务器的 `/opt/` 目录：

```bash
# 方式1: 使用 scp
scp -r deploy root@服务器IP:/opt/course-selection

# 方式2: 使用宝塔面板
# 在宝塔面板文件管理中，上传 deploy 文件夹到 /opt/course-selection
```

### 3. 服务器部署

SSH 登录服务器后执行：

```bash
cd /opt/course-selection
chmod +x scripts/*.sh
./scripts/deploy.sh
```

部署脚本会自动：
- 检测并使用已有的 PostgreSQL 和 Redis 容器
- 创建数据库并导入数据
- 构建后端 Docker 镜像
- 启动前端和后端容器

### 4. 访问系统

- 前端: http://服务器IP
- 后端 API: http://服务器IP:8080
- 默认账号: admin / admin123

## 目录结构

```
deploy/
├── backend/                    # 后端文件
│   ├── ruoyi-admin.jar        # Spring Boot JAR
│   └── Dockerfile             # 后端 Dockerfile
├── frontend/                   # 前端静态文件
│   ├── index.html
│   └── static/
├── sql/                        # 数据库脚本
│   └── init.sql               # 数据库初始化脚本
├── scripts/                    # 管理脚本
│   ├── deploy.sh              # 一键部署脚本
│   ├── start.sh               # 启动服务
│   ├── stop.sh                # 停止服务
│   ├── restart.sh             # 重启服务
│   ├── logs.sh                # 查看日志
│   ├── status.sh              # 查看状态
│   └── backup-db.sh           # 备份数据库
├── logs/                       # 日志目录
├── upload/                     # 上传文件目录
├── docker-compose.yml          # 完整版配置（包含数据库）
├── docker-compose-server.yml   # 服务器版配置（使用已有数据库）
├── nginx.conf                  # Nginx 配置
└── README.md                   # 详细说明文档
```

## 服务管理

### 启动服务
```bash
cd /opt/course-selection
./scripts/start.sh
```

### 停止服务
```bash
cd /opt/course-selection
./scripts/stop.sh
```

### 重启服务
```bash
cd /opt/course-selection
./scripts/restart.sh
```

### 查看状态
```bash
cd /opt/course-selection
./scripts/status.sh
```

### 查看日志
```bash
cd /opt/course-selection

# 查看所有服务日志
./scripts/logs.sh

# 查看特定服务日志
./scripts/logs.sh backend    # 后端
./scripts/logs.sh frontend   # 前端
```

### 备份数据库
```bash
cd /opt/course-selection
./scripts/backup-db.sh
```

备份文件保存在 `backups/` 目录，自动压缩，7天后自动清理。

## Docker Compose 命令

```bash
cd /opt/course-selection

# 使用服务器配置（推荐）
docker-compose -f docker-compose-server.yml up -d      # 启动
docker-compose -f docker-compose-server.yml down       # 停止
docker-compose -f docker-compose-server.yml restart    # 重启
docker-compose -f docker-compose-server.yml ps         # 状态
docker-compose -f docker-compose-server.yml logs -f    # 日志

# 使用完整配置（包含数据库）
docker-compose -f docker-compose.yml up -d
```

## 配置说明

### 服务器环境要求

- 操作系统: CentOS 7
- Docker: 已安装
- PostgreSQL: Docker 容器，端口 5432，密码 mm5621528
- Redis: Docker 容器，端口 6379，无密码
- 最小内存: 2GB
- 最小磁盘: 10GB

### 两种部署模式

#### 1. 服务器模式（推荐）
使用 `docker-compose-server.yml`，连接已有的 PostgreSQL 和 Redis 容器。

适用场景：
- 服务器已安装 PostgreSQL 和 Redis
- 需要与其他应用共享数据库
- 宝塔面板环境

#### 2. 完整模式
使用 `docker-compose.yml`，包含所有服务（PostgreSQL、Redis、后端、前端）。

适用场景：
- 全新服务器
- 独立部署
- 开发测试环境

### 端口说明

- 80: 前端 Nginx
- 443: HTTPS（需配置 SSL）
- 8080: 后端 API
- 5432: PostgreSQL（服务器模式使用宿主机的）
- 6379: Redis（服务器模式使用宿主机的）

## 数据库管理

### 连接数据库
```bash
# 查找 PostgreSQL 容器
docker ps | grep postgres

# 进入数据库
docker exec -it <容器名> psql -U postgres -d school-course
```

### 手动备份
```bash
docker exec <容器名> pg_dump -U postgres school-course > backup.sql
```

### 手动恢复
```bash
docker exec -i <容器名> psql -U postgres school-course < backup.sql
```

## 更新部署

当需要更新应用时：

```bash
cd /opt/course-selection

# 1. 备份数据库
./scripts/backup-db.sh

# 2. 停止服务
./scripts/stop.sh

# 3. 替换新文件
# 上传新的 backend/ruoyi-admin.jar 和 frontend/ 文件

# 4. 重新构建镜像
cd backend
docker build -t course-selection-backend:latest .
cd ..

# 5. 启动服务
./scripts/start.sh

# 6. 查看日志确认
./scripts/logs.sh backend
```

或者使用更新脚本（如果已创建）：
```bash
./scripts/update.sh
```

## 配置 HTTPS

### 使用宝塔面板配置（推荐）

1. 在宝塔面板中创建网站
2. 设置网站根目录为: `/opt/course-selection/frontend`
3. 申请 SSL 证书（Let's Encrypt）
4. 配置反向代理:
   - 代理名称: backend-api
   - 目标 URL: http://127.0.0.1:8080
   - 代理路径: /prod-api

### 使用 Docker Nginx 配置

1. 将 SSL 证书文件放到 `ssl/` 目录
2. 修改 `nginx.conf` 添加 SSL 配置
3. 重启前端服务: `docker-compose restart frontend`

## 故障排查

### 后端无法启动

```bash
# 查看后端日志
./scripts/logs.sh backend

# 检查数据库连接
docker-compose exec backend ping host.docker.internal

# 检查环境变量
docker-compose exec backend env | grep SPRING
```

### 数据库连接失败

```bash
# 检查 PostgreSQL 容器
docker ps | grep postgres

# 测试数据库连接
docker exec <postgres容器> psql -U postgres -d school-course -c "SELECT 1"

# 检查数据库是否存在
docker exec <postgres容器> psql -U postgres -l | grep school-course
```

### 前端无法访问

```bash
# 检查 Nginx 配置
docker-compose exec frontend nginx -t

# 查看前端日志
./scripts/logs.sh frontend

# 检查前端文件
docker-compose exec frontend ls -la /usr/share/nginx/html
```

### 端口被占用

```bash
# 检查端口占用
netstat -tlnp | grep 80
netstat -tlnp | grep 8080

# 修改端口映射
# 编辑 docker-compose-server.yml 中的 ports 配置
```

## 性能优化

### 1. JVM 参数调优

编辑 `backend/Dockerfile`，修改启动命令：

```dockerfile
ENTRYPOINT ["java", "-Xms512m", "-Xmx1024m", "-jar", "/app/app.jar", "--spring.profiles.active=prod"]
```

### 2. Nginx 优化

编辑 `nginx.conf`，添加：

```nginx
# 启用 Gzip 压缩
gzip on;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml;

# 增加缓存时间
location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
    expires 90d;
}
```

### 3. 数据库连接池

编辑后端配置文件 `application-druid-prod.yml`：

```yaml
spring:
  datasource:
    druid:
      initialSize: 10
      minIdle: 10
      maxActive: 50
```

## 监控和日志

### 查看容器资源使用

```bash
docker stats
```

### 查看磁盘使用

```bash
du -sh /opt/course-selection/*
```

### 日志轮转

Docker 会自动管理容器日志，但应用日志需要手动清理：

```bash
# 清理 7 天前的日志
find /opt/course-selection/logs -name "*.log" -mtime +7 -delete
```

## 常见问题

### Q: 如何修改数据库密码？

A: 
1. 修改 PostgreSQL 容器的密码
2. 修改 `docker-compose-server.yml` 中的 `SPRING_DATASOURCE_PASSWORD`
3. 重启后端服务

### Q: 如何增加上传文件大小限制？

A: 
1. 修改 `nginx.conf` 中的 `client_max_body_size`
2. 修改后端配置中的 `spring.servlet.multipart.max-file-size`
3. 重启服务

### Q: 如何查看实时日志？

A: 
```bash
./scripts/logs.sh backend
# 或
docker-compose logs -f backend
```

### Q: 如何重置数据库？

A: 
```bash
# 1. 备份当前数据
./scripts/backup-db.sh

# 2. 删除数据库
docker exec <postgres容器> psql -U postgres -c "DROP DATABASE \"school-course\";"

# 3. 重新创建并导入
docker exec <postgres容器> psql -U postgres -c "CREATE DATABASE \"school-course\";"
docker exec -i <postgres容器> psql -U postgres -d school-course < sql/init.sql
```

## 技术支持

如有问题，请：
1. 查看日志文件
2. 检查服务状态
3. 参考故障排查章节
4. 联系技术支持

---

更新时间: 2026-03-09
