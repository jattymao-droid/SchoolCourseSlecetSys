# 一键启动前后端服务
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "一键启动前后端服务" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查 JAR 文件
if (-not (Test-Path "ruoyi-admin\target\ruoyi-admin.jar")) {
    Write-Host "错误: 未找到后端 JAR 文件" -ForegroundColor Red
    Write-Host "请先编译后端: mvn clean package -DskipTests" -ForegroundColor Yellow
    exit 1
}

# 检查前端依赖
if (-not (Test-Path "ruoyi-ui\node_modules")) {
    Write-Host "警告: 未找到前端依赖，需要先安装" -ForegroundColor Yellow
    $response = Read-Host "是否现在安装前端依赖? (y/N)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        Write-Host "正在安装前端依赖..." -ForegroundColor Green
        Set-Location ruoyi-ui
        npm install
        Set-Location ..
        Write-Host ""
    } else {
        Write-Host "取消启动" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "1. 启动后端服务..." -ForegroundColor Green
Write-Host ""

# 启动后端（新窗口）
Start-Process powershell -ArgumentList "-NoExit", "-File", "$PSScriptRoot\start-backend.ps1"

Write-Host "等待后端启动..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "2. 启动前端服务..." -ForegroundColor Green
Write-Host ""

# 启动前端（新窗口）
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$PSScriptRoot\ruoyi-ui'; npm run dev"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "服务启动完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "后端地址: http://localhost:8080" -ForegroundColor Cyan
Write-Host "前端地址: http://localhost:80 (或查看前端窗口显示的端口)" -ForegroundColor Cyan
Write-Host ""
Write-Host "默认账号: admin" -ForegroundColor Gray
Write-Host "默认密码: admin123" -ForegroundColor Gray
Write-Host ""
Write-Host "提示: 两个服务都在独立的窗口中运行" -ForegroundColor Yellow
Write-Host "      关闭窗口即可停止对应的服务" -ForegroundColor Yellow
Write-Host ""
