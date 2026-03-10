# 启动后端服务
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "启动后端服务" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查 JAR 文件是否存在
if (-not (Test-Path "ruoyi-admin\target\ruoyi-admin.jar")) {
    Write-Host "错误: 未找到 JAR 文件，请先编译项目" -ForegroundColor Red
    Write-Host "运行: mvn clean package -DskipTests" -ForegroundColor Yellow
    exit 1
}

# 检查端口是否被占用
$port = 8080
$process = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
if ($process) {
    Write-Host "警告: 端口 $port 已被占用" -ForegroundColor Yellow
    $pid = (Get-Process -Id $process.OwningProcess).Id
    Write-Host "占用进程 PID: $pid" -ForegroundColor Yellow
    $response = Read-Host "是否停止该进程? (y/N)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        Stop-Process -Id $pid -Force
        Write-Host "已停止进程 $pid" -ForegroundColor Green
        Start-Sleep -Seconds 2
    } else {
        Write-Host "取消启动" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "启动后端服务..." -ForegroundColor Green
Write-Host "JAR 文件: ruoyi-admin\target\ruoyi-admin.jar" -ForegroundColor Gray
Write-Host "Profile: druid (开发环境)" -ForegroundColor Gray
Write-Host "端口: 8080" -ForegroundColor Gray
Write-Host ""

# 启动后端
Start-Process -FilePath "java" -ArgumentList "-jar", "ruoyi-admin\target\ruoyi-admin.jar", "--spring.profiles.active=druid" -NoNewWindow

Write-Host "后端服务启动中..." -ForegroundColor Green
Write-Host "请等待几秒钟，然后访问: http://localhost:8080" -ForegroundColor Cyan
Write-Host ""
Write-Host "查看日志: 在控制台中查看输出" -ForegroundColor Gray
Write-Host "停止服务: 按 Ctrl+C 或关闭窗口" -ForegroundColor Gray
Write-Host ""
