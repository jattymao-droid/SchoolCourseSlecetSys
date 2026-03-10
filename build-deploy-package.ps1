# 项目部署打包脚本
# 用于打包前端和后端项目，生成部署包

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "项目部署打包工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 配置
$PROJECT_NAME = "course-selection"
$DEPLOY_DIR = "deploy-package"
$TIMESTAMP = Get-Date -Format "yyyyMMdd_HHmmss"
$PACKAGE_NAME = "${PROJECT_NAME}_${TIMESTAMP}"

Write-Host "开始打包项目..." -ForegroundColor Yellow
Write-Host ""

# 清理旧的部署目录
if (Test-Path $DEPLOY_DIR) {
    Write-Host "清理旧的部署目录..." -ForegroundColor Yellow
    Remove-Item -Path $DEPLOY_DIR -Recurse -Force
}

# 创建部署目录结构
Write-Host "创建部署目录结构..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "$DEPLOY_DIR/$PACKAGE_NAME" -Force | Out-Null
New-Item -ItemType Directory -Path "$DEPLOY_DIR/$PACKAGE_NAME/backend" -Force | Out-Null
New-Item -ItemType Directory -Path "$DEPLOY_DIR/$PACKAGE_NAME/frontend" -Force | Out-Null
New-Item -ItemType Directory -Path "$DEPLOY_DIR/$PACKAGE_NAME/sql" -Force | Out-Null

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "1. 打包后端项目" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 打包后端
Write-Host "执行 Maven 打包..." -ForegroundColor Yellow
$mvnProcess = Start-Process -FilePath "mvn" -ArgumentList "clean", "package", "-DskipTests", "-Pprod" -NoNewWindow -Wait -PassThru

if ($mvnProcess.ExitCode -ne 0) {
    Write-Host "Maven 打包失败!" -ForegroundColor Red
    exit 1
}

Write-Host "复制后端 JAR 文件..." -ForegroundColor Yellow
Copy-Item -Path "ruoyi-admin/target/ruoyi-admin.jar" -Destination "$DEPLOY_DIR/$PACKAGE_NAME/backend/" -Force

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "2. 打包前端项目" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 打包前端
Set-Location ruoyi-ui

Write-Host "Installing frontend dependencies..." -ForegroundColor Yellow
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "npm install failed!" -ForegroundColor Red
    Set-Location ..
    exit 1
}

Write-Host "Building frontend..." -ForegroundColor Yellow
npm run build:prod
if ($LASTEXITCODE -ne 0) {
    Write-Host "Frontend build failed!" -ForegroundColor Red
    Set-Location ..
    exit 1
}

Write-Host "Copying frontend build files..." -ForegroundColor Yellow
Copy-Item -Path "dist/*" -Destination "../$DEPLOY_DIR/$PACKAGE_NAME/frontend/" -Recurse -Force

Set-Location ..

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "3. 复制配置和脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 复制数据库备份
Write-Host "复制数据库备份文件..." -ForegroundColor Yellow
$latestSqlBackup = Get-ChildItem -Path "sql" -Filter "*.sql" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if ($latestSqlBackup) {
    Copy-Item -Path $latestSqlBackup.FullName -Destination "$DEPLOY_DIR/$PACKAGE_NAME/sql/database_backup.sql" -Force
    Write-Host "已复制数据库备份: $($latestSqlBackup.Name)" -ForegroundColor Green
}

# 复制部署脚本
Write-Host "复制部署脚本..." -ForegroundColor Yellow
Copy-Item -Path "deploy/server-deploy.sh" -Destination "$DEPLOY_DIR/$PACKAGE_NAME/" -Force

# 复制部署指南
if (Test-Path "deploy/部署指南.md") {
    Copy-Item -Path "deploy/部署指南.md" -Destination "$DEPLOY_DIR/$PACKAGE_NAME/" -Force
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "4. 创建压缩包" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "压缩部署包..." -ForegroundColor Yellow
Compress-Archive -Path "$DEPLOY_DIR/$PACKAGE_NAME/*" -DestinationPath "$DEPLOY_DIR/${PACKAGE_NAME}.zip" -Force

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "打包完成!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

$packageInfo = Get-Item "$DEPLOY_DIR/${PACKAGE_NAME}.zip"
Write-Host "部署包信息:" -ForegroundColor Yellow
Write-Host "  文件: $($packageInfo.FullName)" -ForegroundColor White
Write-Host "  大小: $([math]::Round($packageInfo.Length / 1MB, 2)) MB" -ForegroundColor White
Write-Host ""
Write-Host "Upload this file to server and run deployment script" -ForegroundColor Yellow
Write-Host "Deployment script updated for Docker PostgreSQL and Redis" -ForegroundColor Cyan
Write-Host ""
