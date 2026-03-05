# 东陆高中选课系统 - 部署说明

## 部署方式

- **Docker 部署**（推荐）：`bash deploy-docker.sh`（需服务器安装 Docker）
- **传统部署**：`sudo ./deploy.sh`（需服务器安装 JDK、配置 Nginx）

---

## 一、本地打包

在项目根目录执行（需安装 Maven、Node.js）：

```powershell
cd scripts
.\build-for-deploy.ps1
```

打包完成后，`deploy` 目录包含：
- `backend/ruoyi-admin.jar` - 后端 JAR
- `frontend-admin/dist/` - 管理端静态文件
- `frontend-student/h5/` - 学生端 H5 静态文件
- `sql/` - 数据库初始化脚本
- `config/application-prod.yml` - 生产环境配置
- `init-db.sh` - 数据库初始化脚本
- `deploy.sh` - 一键部署脚本

## 二、上传到云服务器

将整个 `deploy` 目录上传到云服务器，例如：

```bash
scp -r deploy root@your-server-ip:/root/
```

## 三、云服务器环境要求

- CentOS 7
- 宝塔面板（已安装 Nginx、Redis、PostgreSQL）
- JDK 8+（若未安装：`yum install java-1.8.0-openjdk`）
- PostgreSQL 密码：mm5621528
- Redis 无密码，端口 6379

## 四、一键部署

SSH 登录服务器后执行：

```bash
cd /root/deploy   # 或你上传的路径
chmod +x deploy.sh init-db.sh
sudo ./deploy.sh
```

按提示选择是否执行数据库初始化（首次部署选 `y`）。

## 五、访问地址

- **管理端**：https://xk.xmls.vip
- **学生端**：https://xk.xmls.vip/h5
- **默认管理员**：admin / admin123

## 六、可选：导入演示数据

如需演示数据（学生、课程等），在数据库初始化后执行：

```bash
psql -U postgres -h localhost -d ry_vue -f sql/course_demo_data.sql
```

## 七、HTTPS 配置

在宝塔面板中为 xk.xmls.vip 申请 SSL 证书并开启强制 HTTPS。

---

## 八、Docker 部署（可选）

若使用 Docker 部署，在 deploy 目录执行：

```bash
chmod +x deploy-docker.sh
bash deploy-docker.sh
```

前端默认映射到宿主机 **9090** 端口。在宝塔中为 xk.xmls.vip 添加反向代理到 `http://127.0.0.1:9090`。

### Docker 部署故障排查

**后端容器 xk-backend 不健康时**，先查看日志：

```bash
docker logs xk-backend
```

常见原因与处理：

1. **Redis 连接被拒**（`Connection refused: 172.17.0.1:6379`）  
   宝塔 Redis 默认只监听 127.0.0.1，Docker 容器无法连接。需修改 Redis 配置：
   - 宝塔面板 → 软件商店 → Redis → 设置 → 配置修改
   - 将 `bind 127.0.0.1` 改为 `bind 0.0.0.0`（或增加 `bind 172.17.0.1`）
   - 保存并重启 Redis
   - 若担心安全，可同时配置防火墙仅允许 172.17.0.0/16 访问 6379

2. **PostgreSQL 连接失败**  
   宝塔 PostgreSQL 默认可能只监听 localhost。需修改 `postgresql.conf` 中 `listen_addresses = '*'`，并重启 PostgreSQL，再在 `pg_hba.conf` 中增加：
   ```
   host    ry_vue    postgres    172.17.0.0/16    md5
   ```

3. **host.docker.internal 不可用**  
   在 deploy 目录创建 `.env` 文件（可复制 `.env.example` 修改），设置 `POSTGRES_HOST=172.17.0.1`、`REDIS_HOST=172.17.0.1`。

4. **数据库未初始化**  
   首次部署需执行 `bash init-db.sh` 初始化数据库。
