@echo off
echo Starting Redis...
start "" "C:\Redis\redis-server.exe" "C:\Redis\redis.windows.conf"
echo Redis started in background (port 6379)
timeout /t 2 >nul
