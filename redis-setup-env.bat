@echo off
REM 将 Redis 添加到用户 PATH 环境变量
powershell -ExecutionPolicy Bypass -File "%~dp0add-redis-to-path.ps1"
pause
