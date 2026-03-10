# ✅ Docker 部署包已完成 - 开始部署！

## 🎉 恭喜！部署包已准备就绪

部署包位置: `SchoolCourseSlecetSys/deploy/`

## 📦 部署包内容

### 应用文件
- ✅ 后端 JAR (已编译): `backend/ruoyi-admin.jar`
- ✅ 前端文件 (已构建): `frontend/`
- ✅ 数据库脚本: `sql/init.sql`

### Docker 配置
- ✅ `backend/Dockerfile` - 后端镜像
- ✅ `docker-compose-server.yml` - 服务器配置（推荐）
- ✅ `docker-compose.yml` - 完整配置
- ✅ `nginx.conf` - Nginx 配置参考

### 部署脚本
- ✅ `scripts/deploy.sh` - 一键部署
- ✅ `scripts/start.sh` - 启动服务
- ✅ `scripts/stop.sh` - 停止服务
- ✅ `scripts/restart.sh` - 重启服务
- ✅ `scripts/logs.sh` - 查看日志
- ✅ `scripts/status.sh` - 查看状态
- ✅ `scripts/backup-db.sh` - 备份数据库

### 宝塔面板配置
- ✅ `nginx-baota-config.conf` - 宝塔 Nginx 配置文件
- ✅ `宝塔面板配置指南.md` - 详细配置步骤

### 文档
- ✅ `快速部署指南.md` - 3 步快速部署
- ✅ `服务器部署说明-xk.xmls.vip.md` - 专用服务器说明
- ✅ `README-Docker.md` - 完整 Docker 文档
- ✅ `README.md` - 简要说明

## 🚀 开始部署（3 大步骤）

### 第一步：上传部署包

```bash
# 使用 scp 上传
scp -r deploy root@xk.xmls.vip:/www/wwwroot/xk.xmls.vip

# 或使用宝塔面板上传到 /www/wwwroot/xk.xmls.vip
```

### 第二步：执行 Docker 部署

```bash
# SSH 登录服务器
ssh root@xk.xmls.vip

# 进入部署目录
cd /www/wwwroot/xk.xmls.vip

# 赋予脚本执行权限
chmod +x scripts/*.sh

# 执行一键部署
./scripts/deploy.sh
```

部署脚本会自动：
- ✅ 检测 PostgreSQL 和 Redis 容器
- ✅ 创建数据库并导入数据
- ✅ 构建后端 Docker 镜像
- ✅ 启动前端和后端容器

### 第三步：配置宝塔面板

详细步骤请查看：`deploy/宝塔面板配置指南.md`

#### 3.1 创建网站
- 域名: xk.xmls.vip
- 根目录: /www/wwwroot/xk.xmls.vip/frontend
- PHP: 纯静态

#### 3.2 修改 Nginx 配置
将 `deploy/nginx-baota-config.conf` 的内容复制到网站配置文件中。

#### 3.3 申请 SSL 证书
使用 Let's Encrypt 申请免费证书，开启强制 HTTPS。

#### 3.4 重启 Nginx
保存配置后重启 Nginx。

## 🎯 访问系统

- 前端: https://xk.xmls.vip
- 后端 API: https://xk.xmls.vip/prod-api
- 默认账号: admin / admin123

## 📚 详细文档

### 快速参考
- `deploy/快速部署指南.md` - 3 步快速部署
- `部署清单-xk.xmls.vip.md` - 完整部署清单

### 配置指南
- `deploy/宝塔面板配置指南.md` - Nginx 配置详解
- `deploy/服务器部署说明-xk.xmls.vip.md` - 服务器专用说明

### 技术文档
- `deploy/README-Docker.md` - Docker 部署完整文档
- `Docker部署说明.md` - Docker 部署详细说明

## 🛠️ 服务管理

```bash
cd /www/wwwroot/xk.xmls.vip

# 启动服务
./scripts/start.sh

# 停止服务
./scripts/stop.sh

# 重启服务
./scripts/restart.sh

# 查看状态
./scripts/status.sh

# 查看日志
./scripts/logs.sh backend   # 后端日志
./scripts/logs.sh frontend  # 前端日志

# 备份数据库
./scripts/backup-db.sh
```

## ✅ 部署后检查

### 1. 检查 Docker 容器
```bash
docker ps
```
应该看到：
- course-selection-backend
- course-selection-frontend
- postgres 容器
- redis 容器

### 2. 检查服务状态
```bash
cd /www/wwwroot/xk.xmls.vip
./scripts/status.sh
```

### 3. 测试访问
- [ ] 访问 https://xk.xmls.vip
- [ ] 登录系统 (admin / admin123)
- [ ] 测试基本功能
- [ ] 检查后端 API 响应

### 4. 查看日志
```bash
./scripts/logs.sh backend
```
确认没有错误信息。

## 🔒 安全配置（重要！）

部署完成后立即执行：

1. **修改默认密码**
   - 登录系统后立即修改 admin 密码

2. **配置自动备份**
   - 在宝塔面板设置计划任务
   - 每天 02:00 执行 `/www/wwwroot/xk.xmls.vip/scripts/backup-db.sh`

3. **配置防火墙**
   - 在宝塔面板"安全"中配置
   - 开放 80, 443 端口
   - 关闭不必要的端口

4. **启用访问日志监控**
   - 定期检查 `/www/wwwlogs/xk.xmls.vip.log`

## 🆘 遇到问题？

### 查看日志
```bash
cd /www/wwwroot/xk.xmls.vip
./scripts/logs.sh backend
```

### 检查容器
```bash
docker ps
docker-compose ps
```

### 查看文档
- `deploy/宝塔面板配置指南.md` - 常见问题解答
- `deploy/服务器部署说明-xk.xmls.vip.md` - 故障排查

### 重新部署
如果部署失败，可以重新执行：
```bash
cd /www/wwwroot/xk.xmls.vip
./scripts/stop.sh
./scripts/deploy.sh
```

## 📊 部署架构

```
┌─────────────────────────────────────────┐
│         用户浏览器                        │
│      https://xk.xmls.vip                │
└──────────────┬──────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│         宝塔 Nginx (443)                 │
│  - SSL 证书                              │
│  - 静态文件服务                           │
│  - 反向代理 /prod-api/                   │
└──────────────┬──────────────────────────┘
               │
       ┌───────┴───────┐
       │               │
       ▼               ▼
┌─────────────┐ ┌─────────────┐
│  Frontend   │ │  Backend    │
│  (Nginx)    │ │  (Spring)   │
│  Docker     │ │  Docker     │
│  Port: 80   │ │  Port: 8080 │
└─────────────┘ └──────┬──────┘
                       │
               ┌───────┴───────┐
               │               │
               ▼               ▼
        ┌─────────────┐ ┌─────────────┐
        │ PostgreSQL  │ │   Redis     │
        │   Docker    │ │   Docker    │
        │  Port: 5432 │ │  Port: 6379 │
        └─────────────┘ └─────────────┘
```

## 🎓 技术栈

- **前端**: Vue 3 + Element Plus + Vite
- **后端**: Spring Boot 2.5 + MyBatis
- **数据库**: PostgreSQL 13
- **缓存**: Redis 7
- **容器**: Docker + Docker Compose
- **Web 服务器**: Nginx
- **服务器**: CentOS 7 + 宝塔面板

## 📞 技术支持

如有问题，请：
1. 查看日志文件
2. 参考文档中的故障排查章节
3. 检查 Docker 容器状态
4. 验证宝塔面板配置

---

## 🎉 准备好了吗？

✅ 部署包已完成
✅ 文档已准备
✅ 脚本已就绪

**现在就开始部署吧！**

1. 上传 `deploy` 文件夹到服务器
2. 执行 `./scripts/deploy.sh`
3. 配置宝塔面板
4. 访问 https://xk.xmls.vip

祝部署顺利！🚀

---

生成时间: 2026-03-09 22:55
部署目标: xk.xmls.vip
部署路径: /www/wwwroot/xk.xmls.vip
