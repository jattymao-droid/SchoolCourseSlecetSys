# 启动前端服务
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "启动前端服务" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查 node_modules 是否存在
if (-not (Test-Path "ruoyi-ui\node_modules")) {
    Write-Host "警告: 未找到 node_modules，需要先安装依赖" -ForegroundColor Yellow
    Write-Host "正在安装依赖..." -ForegroundColor Green
    Set-Location ruoyi-ui
    npm install
    Set-Location ..
    Write-Host ""
}

Write-Host "启动前端开发服务器..." -ForegroundColor Green
Write-Host "目录: ruoyi-ui" -ForegroundColor Gray
Write-Host "端口: 80 (默认)" -ForegroundColor Gray
Write-Host ""

# 启动前端
Set-Location ruoyi-ui
npm run dev

# 如果 npm run dev 退出，返回上级目录
Set-Location ..
