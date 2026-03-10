# 停止所有服务
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "停止所有服务" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 停止后端（Java 进程）
Write-Host "1. 停止后端服务..." -ForegroundColor Yellow
$javaProcesses = Get-Process -Name "java" -ErrorAction SilentlyContinue | Where-Object {
    $_.CommandLine -like "*ruoyi-admin.jar*"
}

if ($javaProcesses) {
    foreach ($process in $javaProcesses) {
        Write-Host "  停止进程 PID: $($process.Id)" -ForegroundColor Gray
        Stop-Process -Id $process.Id -Force
    }
    Write-Host "  后端服务已停止" -ForegroundColor Green
} else {
    Write-Host "  后端服务未运行" -ForegroundColor Gray
}

Write-Host ""

# 停止前端（Node 进程）
Write-Host "2. 停止前端服务..." -ForegroundColor Yellow
$nodeProcesses = Get-Process -Name "node" -ErrorAction SilentlyContinue | Where-Object {
    $_.CommandLine -like "*vite*" -or $_.CommandLine -like "*ruoyi-ui*"
}

if ($nodeProcesses) {
    foreach ($process in $nodeProcesses) {
        Write-Host "  停止进程 PID: $($process.Id)" -ForegroundColor Gray
        Stop-Process -Id $process.Id -Force
    }
    Write-Host "  前端服务已停止" -ForegroundColor Green
} else {
    Write-Host "  前端服务未运行" -ForegroundColor Gray
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "所有服务已停止" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
