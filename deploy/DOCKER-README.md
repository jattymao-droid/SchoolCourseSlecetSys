# Docker 部署说明

## 前置条件

- 服务器已安装 Docker、Docker Compose
- 宿主机已安装并运行 PostgreSQL、Redis（如通过宝塔）

## 部署步骤

### 1. 上传 deploy 目录到服务器

将整个 `deploy` 目录上传到服务器，例如 `/opt/xk/`。

### 2. 配置环境变量（可选）

```bash
cd /opt/xk/deploy
cp .env.example .env
# 编辑 .env，修改数据库密码、Redis 等
```

**PostgreSQL 在 Docker 时**：需在 `.env` 中设置：
- `DB_HOST=172.17.0.1`（Linux 下 Docker 桥接网关，或宿主机内网 IP）
- `DB_PASS=你的数据库密码`
- `PG_PASSWORD=你的数据库密码`（后端连接用）

> `init-db.sh` 使用 Docker 运行 psql，无需在宿主机安装 PostgreSQL 客户端。

### 3. 首次部署：初始化数据库

```bash
chmod +x init-db.sh
./init-db.sh
```

### 4. 启动 Docker 服务

```bash
chmod +x deploy-docker.sh
./deploy-docker.sh
```

或直接执行：

```bash
docker compose -f docker/docker-compose.yml up -d --build
```

### 5. 访问

- 管理端: http://服务器IP:9090
- 学生端: http://服务器IP:9090/h5
- 默认账号: admin / admin123

## 常用命令

```bash
# 查看日志
docker compose -f docker/docker-compose.yml logs -f

# 停止服务
docker compose -f docker/docker-compose.yml down

# 重启服务
docker compose -f docker/docker-compose.yml restart
```
