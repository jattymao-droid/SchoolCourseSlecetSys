# 东陆高中选课系统 - Docker 部署

## 前置条件

- 云服务器：CentOS 7，已安装 Docker、Docker Compose
- 宝塔已安装 PostgreSQL（端口 5432，密码 mm5621528）、Redis（端口 6379，无密码）
- 域名：xk.xmls.vip

## 部署流程

### 1. 本地打包

在项目根目录执行（需 Maven、Node.js）：

```powershell
cd scripts
.\build-for-deploy.ps1
```

### 2. 上传到服务器

将以下内容上传到服务器项目目录：

- 整个项目源码（或至少 `docker/`、`ruoyi-*/`、`pom.xml` 等后端源码）
- `deploy/` 目录（含 `frontend-admin/dist`、`frontend-student/h5`）

或使用 git 拉取后，再上传 `deploy/` 目录。

### 3. 云服务器执行

```bash
cd /path/to/CourseSlecetSys
chmod +x docker/deploy-docker.sh
./docker/deploy-docker.sh
```

按提示选择是否初始化数据库（首次选 y）。

### 4. 配置 Nginx 反向代理（可选）

前端默认映射到宿主机 **9090** 端口。在宝塔中为 xk.xmls.vip 添加反向代理到 `http://127.0.0.1:9090`。

若需修改端口，可设置环境变量 `FRONTEND_PORT` 或创建 `.env` 文件。

## 环境变量

可在执行前导出，或创建 `.env` 文件：

| 变量 | 默认值 | 说明 |
|------|--------|------|
| POSTGRES_HOST | host.docker.internal | PostgreSQL 主机 |
| POSTGRES_PORT | 5432 | PostgreSQL 端口 |
| POSTGRES_DB | ry_vue | 数据库名 |
| POSTGRES_USER | postgres | 用户名 |
| PG_PASSWORD | mm5621528 | 密码 |
| REDIS_HOST | host.docker.internal | Redis 主机 |
| REDIS_PORT | 6379 | Redis 端口 |

## 常用命令

```bash
# 查看日志
docker compose -f docker/docker-compose.yml logs -f

# 停止服务
docker compose -f docker/docker-compose.yml down

# 重启
docker compose -f docker/docker-compose.yml restart
```

## 访问地址

- 管理端：http://xk.xmls.vip
- 学生端：http://xk.xmls.vip/h5
- 默认管理员：admin / admin123
