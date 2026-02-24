# Redis 安装说明

## 安装位置
- **路径**: `C:\Redis`
- **版本**: Redis 5.0.14.1 (Windows)

## 配置环境变量

### 方法一：手动添加（推荐）
1. 按 `Win + R`，输入 `sysdm.cpl`，回车
2. 点击「高级」→「环境变量」
3. 在「用户变量」中找到 `Path`，选择后点击「编辑」
4. 点击「新建」，输入 `C:\Redis`
5. 确定保存

### 方法二：运行脚本
右键 `add-redis-to-path.ps1` → 选择「使用 PowerShell 运行」

## 启动 Redis

- **方式一**：双击 `start-redis.bat`（以后台方式启动）
- **方式二**：在终端执行 `C:\Redis\redis-server.exe C:\Redis\redis.windows.conf`
- **方式三**：若已配置 PATH，执行 `redis-server C:\Redis\redis.windows.conf`

## 验证
```powershell
redis-cli ping
# 应返回 PONG
```
