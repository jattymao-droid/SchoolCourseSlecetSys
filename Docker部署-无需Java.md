# Docker 部署说明 - 服务器无需安装 Java

## 重要说明 ⚠️

**服务器不需要安装 Java！**

我们使用 Docker 容器化部署，后端应用运行在 Docker 容器内部，容器镜像已经包含了完整的 Java 运行环境。

## 部署架构

```
服务器（CentOS 7）
├── Docker Engine ✅ 必需
├── PostgreSQL (Docker 容器) ✅ 已安装
├── Redis (直接安装) ✅ 已安装
└── 课程选课系统
    ├── 后端 (Docker 容器)
    │   └── 内置 Java 8 环境 ✅ 容器自带
    └── 前端 (静态文件)
        └── 由 Nginx 提供服务
```

## 服务器环境检查清单

### ✅ 已具备的环境
- [x] Docker
- [x] PostgreSQL (Docker 容器: postgresql_d6wx-postgresql_D6Wx-1)
- [x] Redis (直接安装，端口 6379)
- [x] 宝塔面板

### ❌ 不需要安装
- [ ] ~~Java~~ (容器内已包含)
- [ ] ~~Maven~~ (本地已完成编译)
- [ ] ~~Node.js~~ (前端已编译为静态文件)

## 部署流程

### 1. 上传部署包

将 `deploy` 目录上传到服务器：
```bash
/www/wwwroot/xk.xmls.vip/
```

### 2. 执行部署脚本

```bash
cd /www/wwwroot/xk.xmls.vip/scripts/
chmod +x *.sh
bash deploy.sh
```

### 3. 脚本自动完成的操作

1. ✅ 检查 Docker 环境
2. ✅ 自动安装 docker-compose（如果未安装）
3. ✅ 检查 PostgreSQL 容器
4. ✅ 检查 Redis 服务
5. ✅ 初始化数据库
6. ✅ 构建后端 Docker 镜像（包含 Java 环境）
7. ✅ 启动后端容器

### 4. 配置 Nginx（宝塔面板）

使用 `宝塔Nginx配置-简化版.conf` 中的配置

## Docker 镜像说明

### 后端镜像构建

部署脚本会自动构建后端 Docker 镜像：

```dockerfile
FROM openjdk:8-jre-alpine
# 基础镜像已包含 Java 8 运行环境

WORKDIR /app
COPY ruoyi-admin.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar", "--spring.profiles.active=prod"]
```

### 镜像特点

- ✅ 基于 `openjdk:8-jre-alpine`（轻量级 Java 运行环境）
- ✅ 镜像大小约 120MB
- ✅ 包含完整的 Java 8 运行时
- ✅ 无需服务器安装 Java

## 容器运行说明

### 后端容器

```yaml
backend:
  image: course-selection-backend:latest
  container_name: course-selection-backend
  ports:
    - "8080:8080"
  environment:
    - SPRING_PROFILES_ACTIVE=prod
  # 容器内运行 Java 应用
```

### 容器内部

- Java 版本：OpenJDK 8
- 应用端口：8080
- 配置文件：application-prod.yml
- 日志目录：/app/logs（映射到宿主机）

## 验证部署

### 1. 检查容器状态

```bash
docker ps | grep course-selection-backend
```

应该看到：
```
CONTAINER ID   IMAGE                              STATUS
xxxxx          course-selection-backend:latest    Up 2 minutes
```

### 2. 检查容器日志

```bash
docker logs course-selection-backend
```

应该看到 Spring Boot 启动日志

### 3. 测试后端 API

```bash
curl http://localhost:8080
```

应该返回 API 响应

### 4. 检查 Java 版本（容器内）

```bash
docker exec course-selection-backend java -version
```

应该显示：
```
openjdk version "1.8.0_xxx"
```

## 常见问题

### Q1: 服务器需要安装 Java 吗？

**A:** 不需要！后端运行在 Docker 容器中，容器镜像已包含 Java 环境。

### Q2: 如何更新后端应用？

**A:** 
1. 上传新的 JAR 包到 `backend` 目录
2. 重新构建镜像：
   ```bash
   cd /www/wwwroot/xk.xmls.vip/backend
   docker build -t course-selection-backend:latest .
   ```
3. 重启容器：
   ```bash
   cd /www/wwwroot/xk.xmls.vip
   docker-compose -f docker-compose-server.yml restart backend
   ```

### Q3: 如何查看后端日志？

**A:** 
```bash
# 方法1：查看容器日志
docker logs -f course-selection-backend

# 方法2：查看映射到宿主机的日志文件
tail -f /www/wwwroot/xk.xmls.vip/logs/ruoyi-admin.log
```

### Q4: 容器占用多少资源？

**A:** 
- 内存：约 512MB - 1GB
- CPU：根据负载动态调整
- 磁盘：镜像约 120MB，日志根据使用情况增长

### Q5: 如何进入容器内部？

**A:** 
```bash
docker exec -it course-selection-backend sh
```

## 部署优势

### 使用 Docker 的好处

1. ✅ **环境隔离**：不污染宿主机环境
2. ✅ **版本一致**：开发和生产环境完全一致
3. ✅ **快速部署**：一键启动，无需配置 Java
4. ✅ **易于维护**：容器化管理，便于升级和回滚
5. ✅ **资源控制**：可以限制容器的 CPU 和内存使用

### 与传统部署对比

| 项目 | Docker 部署 | 传统部署 |
|------|------------|---------|
| Java 安装 | ❌ 不需要 | ✅ 需要安装 JDK |
| 环境配置 | ❌ 不需要 | ✅ 需要配置 JAVA_HOME |
| 版本管理 | ✅ 容器内固定 | ❌ 可能版本冲突 |
| 部署速度 | ✅ 快速 | ❌ 较慢 |
| 回滚 | ✅ 简单 | ❌ 复杂 |

## 总结

使用 Docker 部署，您的服务器：
- ✅ 不需要安装 Java
- ✅ 不需要配置 Java 环境变量
- ✅ 不需要担心 Java 版本冲突
- ✅ 只需要 Docker 和 docker-compose

所有 Java 相关的环境都在 Docker 容器内部，与宿主机完全隔离！
