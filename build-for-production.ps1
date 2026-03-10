# 生产环境打包脚本
$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "生产环境打包工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. 打包后端
Write-Host "1. 打包后端项目..." -ForegroundColor Yellow
Write-Host ""

# 使用生产环境配置打包
mvn clean package -DskipTests -Pprod

if ($LASTEXITCODE -ne 0) {
    Write-Host "后端打包失败!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "✓ 后端打包完成" -ForegroundColor Green
Write-Host ""

# 2. 打包前端
Write-Host "2. 打包前端项目..." -ForegroundColor Yellow
Write-Host ""

Set-Location ruoyi-ui

# 安装依赖（如果需要）
if (-not (Test-Path "node_modules")) {
    Write-Host "安装前端依赖..." -ForegroundColor Yellow
    npm install
}

# 构建生产版本
npm run build:prod

if ($LASTEXITCODE -ne 0) {
    Write-Host "前端打包失败!" -ForegroundColor Red
    Set-Location ..
    exit 1
}

Set-Location ..

Write-Host ""
Write-Host "✓ 前端打包完成" -ForegroundColor Green
Write-Host ""

# 3. 创建部署包
Write-Host "3. 创建部署包..." -ForegroundColor Yellow
Write-Host ""

$TIMESTAMP = Get-Date -Format "yyyyMMdd_HHmmss"
$DEPLOY_DIR = "deploy-package"
$PACKAGE_NAME = "course-selection_${TIMESTAMP}"

# 清理旧的部署目录
if (Test-Path $DEPLOY_DIR) {
    Remove-Item -Path $DEPLOY_DIR -Recurse -Force
}

# 创建目录结构
New-Item -ItemType Directory -Path "$DEPLOY_DIR/$PACKAGE_NAME/backend" -Force | Out-Null
New-Item -ItemType Directory -Path "$DEPLOY_DIR/$PACKAGE_NAME/frontend" -Force | Out-Null
New-Item -ItemType Directory -Path "$DEPLOY_DIR/$PACKAGE_NAME/sql" -Force | Out-Null

# 复制后端文件
Write-Host "复制后端文件..." -ForegroundColor Yellow
Copy-Item -Path "ruoyi-admin/target/ruoyi-admin.jar" -Destination "$DEPLOY_DIR/$PACKAGE_NAME/backend/" -Force

# 复制前端文件
Write-Host "复制前端文件..." -ForegroundColor Yellow
Copy-Item -Path "ruoyi-ui/dist/*" -Destination "$DEPLOY_DIR/$PACKAGE_NAME/frontend/" -Recurse -Force

# 复制数据库备份
Write-Host "复制数据库备份..." -ForegroundColor Yellow
$latestSqlBackup = Get-ChildItem -Path "sql" -Filter "*.sql" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if ($latestSqlBackup) {
    Copy-Item -Path $latestSqlBackup.FullName -Destination "$DEPLOY_DIR/$PACKAGE_NAME/sql/database_backup.sql" -Force
}

# 复制部署脚本
Write-Host "复制部署脚本..." -ForegroundColor Yellow
# 核心部署脚本 (重命名为 server-deploy.sh 方便识别)
Copy-Item -Path "scripts/server-deploy-docker-v2.sh" -Destination "$DEPLOY_DIR/$PACKAGE_NAME/server-deploy.sh" -Force

# 脚本辅助工具
New-Item -ItemType Directory -Path "$DEPLOY_DIR/$PACKAGE_NAME/scripts" -Force | Out-Null
Copy-Item -Path "scripts/init-db.sh" -Destination "$DEPLOY_DIR/$PACKAGE_NAME/scripts/" -Force

# 复制部署指南
$deployGuideFile = "最终部署包说明.md"
if (Test-Path $deployGuideFile) {
    Copy-Item -Path $deployGuideFile -Destination "$DEPLOY_DIR/$PACKAGE_NAME/部署指南.md" -Force
}

# 创建压缩包
Write-Host "创建压缩包..." -ForegroundColor Yellow
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
Write-Host "下一步操作:" -ForegroundColor Yellow
Write-Host "  1. 将 ${PACKAGE_NAME}.zip 上传到服务器" -ForegroundColor White
Write-Host "  2. 解压文件: unzip ${PACKAGE_NAME}.zip" -ForegroundColor White
Write-Host "  3. 执行部署: chmod +x server-deploy.sh && ./server-deploy.sh" -ForegroundColor White
Write-Host ""
