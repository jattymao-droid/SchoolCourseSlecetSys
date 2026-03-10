# ✅ 部署清单 - xk.xmls.vip

## 📦 部署包信息

- 生成时间: 2026-03-09 22:55
- 部署包位置: `SchoolCourseSlecetSys/deploy/`
- 目标服务器: xk.xmls.vip
- 部署路径: /www/wwwroot/xk.xmls.vip

## ✅ 已完成的工作

### 1. 本地构建
- ✅ 后端编译完成 (ruoyi-admin.jar)
- ✅ 前端构建完成 (Vue 静态文件)
- ✅ 数据库导出完成 (schema.sql, data.sql, full_backup.sql)

### 2. Docker 配置
- ✅ Dockerfile (后端镜像配置)
- ✅ docker-compose.yml (完整版配置)
- ✅ docker-compose-server.yml (服务器版配置，使用已有数据库)
- ✅ nginx.conf (Nginx 配置)

### 3. 部署脚本
- ✅ deploy.sh (一键部署脚本)
- ✅ start.sh (启动服务)
- ✅ stop.sh (停止服务)
- ✅ restart.sh (重启服务)
- ✅ logs.sh (查看日志)
- ✅ status.sh (查看状态)
- ✅ backup-db.sh (备份数据库)

### 4. 文档
- ✅ 快速部署指南.md
- ✅ README-Docker.md (详细文档)
- ✅ 服务器部署说明-xk.xmls.vip.md (专用说明)
- ✅ 宝塔面板配置指南.md (Nginx 配置详解)
- ✅ nginx-baota-config.conf (宝塔 Nginx 配置文件)
- ✅ README.md (简要说明)

## 📋 部署步骤

### 步骤 1: 上传部署包 ⏳

```bash
# 方式 1: 使用 scp
scp -r deploy root@xk.xmls.vip:/www/wwwroot/xk.xmls.vip

# 方式 2: 使用宝塔面板
# 在宝塔面板文件管理中上传 deploy 文件夹到 /www/wwwroot/xk.xmls.vip
```

### 步骤 2: 执行部署 ⏳

```bash
ssh root@xk.xmls.vip
cd /www/wwwroot/xk.xmls.vip
chmod +x scripts/*.sh
./scripts/deploy.sh
```

### 步骤 3: 配置宝塔面板 ⏳

详细步骤请参考：`deploy/宝塔面板配置指南.md`

#### 3.1 创建网站
- 域名: xk.xmls.vip
- 根目录: /www/wwwroot/xk.xmls.vip/frontend
- PHP 版本: 纯静态

#### 3.2 修改 Nginx 配置
使用 `deploy/nginx-baota-config.conf` 的内容替换网站配置文件。

关键配置：
- 根目录指向 frontend/
- 反向代理 /prod-api/ 到 http://127.0.0.1:8080/
- 支持 Vue Router history 模式
- 静态资源缓存优化

#### 3.3 申请 SSL 证书
- 使用 Let's Encrypt 免费证书
- 开启强制 HTTPS

#### 3.4 重启 Nginx
保存配置后重启 Nginx 使配置生效。

### 步骤 4: 验证部署 ⏳

- [ ] 访问 https://xk.xmls.vip
- [ ] 登录系统 (admin / admin123)
- [ ] 测试基本功能
- [ ] 检查后端 API
- [ ] 查看日志确认无错误

## 🔧 服务器环境

### 已确认
- ✅ 操作系统: CentOS 7
- ✅ 宝塔面板: 已安装
- ✅ Docker: 已安装
- ✅ PostgreSQL: Docker 容器，端口 5432，密码 mm5621528
- ✅ Redis: Docker 容器，端口 6379，无密码

### 需要确认
- [ ] Docker Compose 已安装（部署脚本会自动安装）
- [ ] 防火墙开放 80, 443, 8080 端口
- [ ] 域名 xk.xmls.vip 已解析到服务器

## 📊 部署后检查清单

### 服务状态
```bash
cd /www/wwwroot/xk.xmls.vip
./scripts/status.sh
```

应该看到：
- [ ] backend 容器运行中
- [ ] frontend 容器运行中
- [ ] PostgreSQL 容器运行中
- [ ] Redis 容器运行中

### 功能测试
- [ ] 前端页面正常加载
- [ ] 登录功能正常
- [ ] 后端 API 响应正常
- [ ] 数据库连接正常
- [ ] Redis 缓存正常

### 日志检查
```bash
./scripts/logs.sh backend
```

应该没有错误信息。

## 🔐 安全配置

### 立即执行
- [ ] 修改默认管理员密码 (admin / admin123)
- [ ] 配置宝塔面板安全设置
- [ ] 启用防火墙规则

### 建议配置
- [ ] 设置数据库自动备份（每天 02:00）
- [ ] 配置日志轮转
- [ ] 启用访问日志监控
- [ ] 配置告警通知

## 📝 管理命令

### 服务管理
```bash
cd /www/wwwroot/xk.xmls.vip

./scripts/start.sh      # 启动服务
./scripts/stop.sh       # 停止服务
./scripts/restart.sh    # 重启服务
./scripts/status.sh     # 查看状态
./scripts/logs.sh       # 查看日志
./scripts/backup-db.sh  # 备份数据库
```

### Docker 管理
```bash
docker ps                              # 查看容器
docker-compose ps                      # 查看服务
docker-compose logs -f backend         # 查看后端日志
docker-compose restart backend         # 重启后端
```

### 数据库管理
```bash
# 连接数据库
docker exec -it <postgres容器> psql -U postgres -d school-course

# 备份数据库
./scripts/backup-db.sh

# 查看备份
ls -lh backups/
```

## 📚 文档位置

部署包中的文档：
- `deploy/快速部署指南.md` - 3 步快速部署
- `deploy/README-Docker.md` - 完整的 Docker 部署文档
- `deploy/服务器部署说明-xk.xmls.vip.md` - 专用服务器说明
- `deploy/README.md` - 简要说明

项目根目录的文档：
- `Docker部署包已完成.md` - 部署包完成说明
- `Docker部署说明.md` - Docker 部署详细说明

## 🆘 故障排查

### 后端无法启动
```bash
./scripts/logs.sh backend
docker ps | grep postgres
```

### 前端无法访问
```bash
./scripts/logs.sh frontend
# 检查宝塔面板网站配置
```

### 数据库连接失败
```bash
docker ps | grep postgres
docker exec <postgres容器> psql -U postgres -l
```

### 反向代理不工作
检查宝塔面板的反向代理配置，确保 `/prod-api/` 正确代理到 `http://127.0.0.1:8080/`

## 📞 技术支持

如遇到问题：
1. 查看日志: `./scripts/logs.sh`
2. 检查状态: `./scripts/status.sh`
3. 查看容器: `docker ps`
4. 参考文档: `deploy/服务器部署说明-xk.xmls.vip.md`

## 🎯 下一步

部署完成后：
1. [ ] 修改默认密码
2. [ ] 配置自动备份
3. [ ] 测试所有功能
4. [ ] 培训用户
5. [ ] 监控系统运行

---

✅ 部署包已准备就绪！
📦 位置: SchoolCourseSlecetSys/deploy/
🚀 开始部署: 按照上述步骤执行

生成时间: 2026-03-09 22:55
