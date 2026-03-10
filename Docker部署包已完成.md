# ✅ Docker 部署包已完成！

## 部署包位置

```
SchoolCourseSlecetSys/deploy/
```

## 部署包内容

### 📦 已编译的应用文件
- ✅ 后端 JAR: `deploy/backend/ruoyi-admin.jar` (已编译)
- ✅ 前端文件: `deploy/frontend/` (已构建)
- ✅ 数据库脚本: `deploy/sql/` (已导出)

### 🐳 Docker 配置文件
- ✅ `Dockerfile` - 后端镜像配置
- ✅ `docker-compose.yml` - 完整版配置（包含数据库）
- ✅ `docker-compose-server.yml` - 服务器版配置（使用已有数据库）
- ✅ `nginx.conf` - Nginx 配置

### 🚀 部署和管理脚本
- ✅ `scripts/deploy.sh` - 一键部署脚本
- ✅ `scripts/start.sh` - 启动服务
- ✅ `scripts/stop.sh` - 停止服务
- ✅ `scripts/restart.sh` - 重启服务
- ✅ `scripts/logs.sh` - 查看日志
- ✅ `scripts/status.sh` - 查看状态
- ✅ `scripts/backup-db.sh` - 备份数据库

### 📚 文档
- ✅ `快速部署指南.md` - 3 步快速部署
- ✅ `README-Docker.md` - 完整的 Docker 部署文档

## 快速部署（3 步）

### 步骤 1: 上传到服务器

```bash
# 使用 scp 上传
scp -r deploy root@服务器IP:/www/wwwroot/xk.xmls.vip

# 或使用宝塔面板上传到 /www/wwwroot/xk.xmls.vip
```

### 步骤 2: 执行部署

```bash
cd /www/wwwroot/xk.xmls.vip
chmod +x scripts/*.sh
./scripts/deploy.sh
```

### 步骤 3: 访问系统

- 前端: http://服务器IP
- 后端: http://服务器IP:8080
- 账号: admin / admin123

## 服务器环境要求

✅ CentOS 7
✅ Docker 已安装
✅ PostgreSQL (Docker, 端口 5432, 密码 mm5621528)
✅ Redis (Docker, 端口 6379, 无密码)
✅ 最小内存 2GB
✅ 最小磁盘 10GB

## 部署特点

### 🎯 智能部署
- 自动检测并使用已有的 PostgreSQL 和 Redis 容器
- 自动创建数据库并导入数据
- 自动构建 Docker 镜像
- 自动启动所有服务

### 🔧 灵活配置
- 支持两种部署模式（服务器模式/完整模式）
- 自动选择合适的配置文件
- 支持自定义端口和配置

### 📊 完善的管理
- 一键启动/停止/重启
- 实时日志查看
- 服务状态监控
- 自动数据库备份

### 🛡️ 生产就绪
- Docker 容器化部署
- 自动重启策略
- 日志管理
- 数据持久化

## 服务管理

```bash
cd /www/wwwroot/xk.xmls.vip

# 启动
./scripts/start.sh

# 停止
./scripts/stop.sh

# 重启
./scripts/restart.sh

# 状态
./scripts/status.sh

# 日志
./scripts/logs.sh backend   # 后端日志
./scripts/logs.sh frontend  # 前端日志

# 备份
./scripts/backup-db.sh
```

## 目录结构

```
deploy/
├── backend/              # 后端文件
│   ├── ruoyi-admin.jar  # Spring Boot JAR
│   └── Dockerfile       # 后端 Dockerfile
├── frontend/             # 前端静态文件
│   ├── index.html
│   └── static/
├── sql/                  # 数据库脚本
│   ├── schema.sql       # 数据库结构
│   ├── data.sql         # 数据库数据
│   └── full_backup.sql  # 完整备份
├── scripts/              # 管理脚本
│   ├── deploy.sh        # 一键部署
│   ├── start.sh         # 启动服务
│   ├── stop.sh          # 停止服务
│   ├── restart.sh       # 重启服务
│   ├── logs.sh          # 查看日志
│   ├── status.sh        # 查看状态
│   └── backup-db.sh     # 备份数据库
├── logs/                 # 日志目录
├── upload/               # 上传文件目录
├── backups/              # 备份目录
├── docker-compose.yml    # 完整版配置
├── docker-compose-server.yml  # 服务器版配置
├── nginx.conf           # Nginx 配置
├── 快速部署指南.md      # 快速指南
└── README-Docker.md     # 详细文档
```

## 部署模式

### 服务器模式（推荐，默认）
- 使用已有的 PostgreSQL 和 Redis
- 适用于宝塔面板环境
- 资源占用更少

### 完整模式
- 包含所有服务
- 适用于全新服务器
- 完全独立部署

## 端口映射

- 80 → 前端 Nginx
- 443 → HTTPS（需配置 SSL）
- 8080 → 后端 API
- 5432 → PostgreSQL（宿主机）
- 6379 → Redis（宿主机）

## 数据持久化

- 数据库数据: PostgreSQL 容器卷
- Redis 数据: Redis 容器卷
- 应用日志: `deploy/logs/`
- 上传文件: `deploy/upload/`
- 数据库备份: `deploy/backups/`

## 更新部署

```bash
# 1. 备份
./scripts/backup-db.sh

# 2. 停止
./scripts/stop.sh

# 3. 替换文件
# 上传新的 backend/ruoyi-admin.jar 和 frontend/

# 4. 重新构建
cd backend && docker build -t course-selection-backend:latest . && cd ..

# 5. 启动
./scripts/start.sh
```

## 故障排查

### 查看日志
```bash
./scripts/logs.sh backend   # 后端
./scripts/logs.sh frontend  # 前端
```

### 检查服务
```bash
./scripts/status.sh
docker ps
```

### 检查数据库
```bash
docker ps | grep postgres
docker exec -it <容器名> psql -U postgres -d school-course
```

## 配置 HTTPS

### 方式 1: 宝塔面板（推荐）
1. 创建网站，根目录: `/www/wwwroot/xk.xmls.vip/frontend`
2. 申请 SSL 证书
3. 配置反向代理: /prod-api → http://127.0.0.1:8080

### 方式 2: Docker Nginx
1. 将 SSL 证书放到 `ssl/` 目录
2. 修改 `nginx.conf` 添加 SSL 配置
3. 重启前端: `docker-compose restart frontend`

## 性能优化建议

### JVM 参数
编辑 `backend/Dockerfile`，修改启动命令：
```dockerfile
ENTRYPOINT ["java", "-Xms512m", "-Xmx1024m", "-jar", "/app/app.jar"]
```

### Nginx 优化
编辑 `nginx.conf`，添加：
```nginx
gzip on;
gzip_types text/plain text/css application/json application/javascript;
```

### 数据库连接池
根据服务器配置调整连接池大小。

## 监控和维护

### 查看资源使用
```bash
docker stats
```

### 查看磁盘使用
```bash
du -sh /opt/course-selection/*
```

### 定期备份
建议设置 cron 任务定期备份：
```bash
# 每天凌晨 2 点备份
0 2 * * * /www/wwwroot/xk.xmls.vip/scripts/backup-db.sh
```

## 文档链接

- 📖 快速部署指南: `deploy/快速部署指南.md`
- 📖 详细文档: `deploy/README-Docker.md`
- 📖 Docker 部署说明: `Docker部署说明.md`

## 技术支持

如有问题：
1. 查看日志: `./scripts/logs.sh`
2. 检查状态: `./scripts/status.sh`
3. 参考文档
4. 联系技术支持

---

✅ 部署包已准备就绪，可以上传到服务器进行部署！

生成时间: 2026-03-09 22:55
