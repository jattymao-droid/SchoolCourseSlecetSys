# Redis 本地配置说明

## 安装位置

Redis 已下载并解压至项目 `tools/redis` 目录，无需系统安装。

## 启动方式

**方式一：双击启动**
- 双击 `start-redis.bat` 启动 Redis（会打开命令行窗口）

**方式二：命令行启动**
```cmd
cd e:\AI\CourseSlecetSys\tools\redis
redis-server.exe redis.windows.conf
```

## 项目配置

若依项目已配置连接本地 Redis：
- **地址**: localhost
- **端口**: 6379
- **密码**: 无
- **数据库**: 0

配置文件位置：`ruoyi-admin/src/main/resources/application.yml`

## 验证连接

```cmd
cd e:\AI\CourseSlecetSys\tools\redis
redis-cli.exe ping
```
返回 `PONG` 表示 Redis 正常运行。

## 注意事项

- Redis 需在启动后端项目前运行
- 关闭 Redis 窗口或按 Ctrl+C 可停止服务
- 数据文件保存在 redis 目录下的 `.rdb` 文件中
