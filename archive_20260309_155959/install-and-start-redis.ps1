# 自动下载并启动 Redis for Windows
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Redis 自动安装和启动脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$redisDir = "$PSScriptRoot\redis"
$redisZip = "$PSScriptRoot\redis.zip"
$redisUrl = "https://github.com/tporadowski/redis/releases/download/v5.0.14.1/Redis-x64-5.0.14.1.zip"

# 检查是否已下载
if (Test-Path "$redisDir\redis-server.exe") {
    Write-Host "✓ Redis 已存在" -ForegroundColor Green
    Write-Host "位置: $redisDir" -ForegroundColor Gray
} else {
    Write-Host "下载 Redis for Windows..." -ForegroundColor Yellow
    Write-Host "下载地址: $redisUrl" -ForegroundColor Gray
    Write-Host ""
    
    try {
        # 下载 Redis
        Invoke-WebRequest -Uri $redisUrl -OutFile $redisZip -UseBasicParsing
        Write-Host "✓ 下载完成" -ForegroundColor Green
        
        # 解压
        Write-Host "解压 Redis..." -ForegroundColor Yellow
        Expand-Archive -Path $redisZip -DestinationPath $redisDir -Force
        Remove-Item $redisZip -Force
        Write-Host "✓ 解压完成" -ForegroundColor Green
    } catch {
        Write-Host "✗ 下载失败: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "请手动下载 Redis:" -ForegroundColor Yellow
        Write-Host "1. 访问: https://github.com/tporadowski/redis/releases" -ForegroundColor Cyan
        Write-Host "2. 下载 Redis-x64-*.zip" -ForegroundColor Cyan
        Write-Host "3. 解压到: $redisDir" -ForegroundColor Cyan
        exit 1
    }
}

Write-Host ""
Write-Host "启动 Redis 服务..." -ForegroundColor Yellow

# 检查是否已经在运行
$existing = Get-Process -Name "redis-server" -ErrorAction SilentlyContinue
if ($existing) {
    Write-Host "✓ Redis 已在运行 (PID: $($existing.Id))" -ForegroundColor Green
} else {
    # 启动 Redis
    Start-Process -FilePath "$redisDir\redis-server.exe" -ArgumentList "$redisDir\redis.windows.conf" -WindowStyle Normal
    Start-Sleep -Seconds 2
    
    # 验证启动
    $redis = Get-Process -Name "redis-server" -ErrorAction SilentlyContinue
    if ($redis) {
        Write-Host "✓ Redis 启动成功 (PID: $($redis.Id))" -ForegroundColor Green
    } else {
        Write-Host "✗ Redis 启动失败" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Redis 已就绪！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "端口: 6379" -ForegroundColor Cyan
Write-Host "配置文件: $redisDir\redis.windows.conf" -ForegroundColor Gray
Write-Host ""
Write-Host "现在可以启动项目了:" -ForegroundColor Yellow
Write-Host "  .\start-all.ps1" -ForegroundColor Cyan
Write-Host ""
