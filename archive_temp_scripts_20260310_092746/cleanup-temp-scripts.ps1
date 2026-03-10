# 清理临时脚本文件
# 将临时脚本移动到归档目录

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$archiveDir = "archive_temp_scripts_$timestamp"

Write-Host "创建归档目录: $archiveDir" -ForegroundColor Green
New-Item -ItemType Directory -Path $archiveDir -Force | Out-Null

$movedCount = 0

# 1. 清理项目根目录的临时脚本
Write-Host "`n清理项目根目录..." -ForegroundColor Cyan
$rootScripts = @(
    "cleanup-temp-docs.ps1"
)

foreach ($script in $rootScripts) {
    if (Test-Path $script) {
        Write-Host "移动: $script" -ForegroundColor Yellow
        Move-Item -Path $script -Destination $archiveDir -Force
        $movedCount++
    }
}

# 2. 清理 ruoyi-ui 目录的临时脚本和日志
Write-Host "`n清理 ruoyi-ui 目录..." -ForegroundColor Cyan
$uiTempFiles = @(
    "ruoyi-ui/update-buttons.ps1",
    "ruoyi-ui/dump.rdb",
    "ruoyi-ui/frontend_final.log",
    "ruoyi-ui/frontend_restart_v2.log",
    "ruoyi-ui/frontend_restart.log",
    "ruoyi-ui/frontend.log"
)

foreach ($file in $uiTempFiles) {
    if (Test-Path $file) {
        Write-Host "移动: $file" -ForegroundColor Yellow
        Move-Item -Path $file -Destination $archiveDir -Force
        $movedCount++
    }
}

# 3. 清理 course-selection-app 的临时文件
Write-Host "`n清理 course-selection-app 目录..." -ForegroundColor Cyan
if (Test-Path "course-selection-app/build_error.txt") {
    Write-Host "移动: course-selection-app/build_error.txt" -ForegroundColor Yellow
    Move-Item -Path "course-selection-app/build_error.txt" -Destination $archiveDir -Force
    $movedCount++
}

Write-Host "`n清理完成!" -ForegroundColor Green
Write-Host "已移动 $movedCount 个文件到 $archiveDir" -ForegroundColor Cyan

Write-Host "`n保留的重要脚本:" -ForegroundColor Green
Write-Host "  ✓ scripts/build-for-deploy.ps1 (部署打包脚本)" -ForegroundColor White
Write-Host "  ✓ scripts/build-for-deploy.bat (部署打包脚本)" -ForegroundColor White
Write-Host "  ✓ scripts/deploy.sh (服务器部署脚本)" -ForegroundColor White
Write-Host "  ✓ scripts/init-db.sh (数据库初始化脚本)" -ForegroundColor White
Write-Host "  ✓ docker/deploy-docker.sh (Docker部署脚本)" -ForegroundColor White
Write-Host "  ✓ deploy/scripts/* (服务器运维脚本)" -ForegroundColor White
