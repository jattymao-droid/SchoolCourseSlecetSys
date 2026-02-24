@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo 正在启动 Redis 服务...
echo Redis 端口: 6379
echo 按 Ctrl+C 可停止服务
echo.

redis-server.exe redis.windows.conf
