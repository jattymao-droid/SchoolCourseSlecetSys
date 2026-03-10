# 清理临时文档脚本
# 将临时文档移动到 archive 目录

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$archiveDir = "archive_temp_docs_$timestamp"

Write-Host "创建归档目录: $archiveDir" -ForegroundColor Green
New-Item -ItemType Directory -Path $archiveDir -Force | Out-Null

# 排除重要文档（保留这些）
$keepFiles = @(
    "README.md",
    "LICENSE",
    "REDIS-README.md",
    "COURSE_PROGRESS_FEATURE.md"
)

# 定义需要清理的文档（所有其他.md和.conf文件）
$allMdFiles = Get-ChildItem -Path . -Filter "*.md" -File
$allConfFiles = Get-ChildItem -Path . -Filter "*.conf" -File

$movedCount = 0

# 移动所有临时文档
$allFiles = $allMdFiles + $allConfFiles
foreach ($file in $allFiles) {
    if ($keepFiles -notcontains $file.Name) {
        Write-Host "移动: $($file.Name)" -ForegroundColor Yellow
        Move-Item -Path $file.FullName -Destination $archiveDir -Force
        $movedCount++
    }
}

Write-Host "`n清理完成!" -ForegroundColor Green
Write-Host "已移动 $movedCount 个文件到 $archiveDir" -ForegroundColor Cyan
Write-Host "`n保留的重要文档:" -ForegroundColor Green
Get-ChildItem -Path . -Filter "*.md" -File | ForEach-Object { Write-Host "  - $($_.Name)" -ForegroundColor White }
