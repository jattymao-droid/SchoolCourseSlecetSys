# 清理项目中不必要的文档文件
# 保留重要的文档，删除临时和重复的文档

Write-Host "开始清理项目文档..." -ForegroundColor Green

# 定义要删除的临时文档（根目录）
$docsToDelete = @(
    "✅ Docker部署包完成-开始部署.md",
    "✅ 修复教师考核评分显示问题.md",
    "✅ 修复评价详情显示-v2.md",
    "✅ 教师考核修复-部署说明.md",
    "✅ 数据库已重新导出.md",
    "✅ 最终解决方案.md",
    "✅ 部署包已完成-请查看.md",
    "✅ 部署完成-最后一步.md",
    "✅ 配置已修复-请重新上传.md",
    "🎯 现在就做这3件事.md",
    "🔧 导入完整数据库.md",
    "🔧 快速修复-管理员账号.md",
    "【必读】Nginx配置保存前必做.md",
    "Docker部署-无需Java.md",
    "Docker部署包已完成.md",
    "Docker部署说明.md",
    "fix-database-name.md",
    "Nginx配置问题修复指南.md",
    "修复宝塔Nginx配置错误.md",
    "修复管理员账号.md",
    "学生删除重新导入问题-解决方案.md",
    "学生删除问题-最终解决.md",
    "学生导入问题-已修复.md",
    "学生导入问题分析.md",
    "宝塔Nginx配置说明.md",
    "快速修复指南.md",
    "快速导入数据库命令.md",
    "打包完成-请查看.md",
    "打包部署完成说明.md",
    "数据库工具-README.md",
    "数据库工具-快速参考.md",
    "数据库工具-文件清单.md",
    "数据库管理工具使用说明.md",
    "数据库问题快速解决指南.md",
    "服务器数据库工具集说明.md",
    "服务器数据库清理说明.md",
    "服务器部署说明-20260309.md",
    "服务器部署说明.md",
    "清理完成.md",
    "生产环境部署指南.md",
    "紧急修复-Nginx日志问题.md",
    "课程导入事务错误修复方案.md",
    "课程导入修复-部署完成.md",
    "课程导入修复-部署说明.md",
    "部署包已完成.md",
    "部署清单-xk.xmls.vip.md",
    "项目说明.md"
)

# 定义要删除的临时配置文件
$configsToDelete = @(
    "nginx-baota-simple.conf",
    "nginx-docker.conf",
    "nginx-xk.xmls.vip-完整配置.conf",
    "宝塔Nginx配置-最简版.conf",
    "宝塔Nginx配置-简化版.conf"
)

# 定义要删除的临时脚本
$scriptsToDelete = @(
    "auto-fix-database-server.sh",
    "build-deploy-package.ps1",
    "build-docker-package.ps1",
    "build-for-production.ps1",
    "build-production-package.ps1",
    "build-server-package.ps1",
    "check-and-restore-database.sh",
    "clean-database-server.sh",
    "clean-deleted-records-server.sh",
    "create-course-fix-package.ps1",
    "deploy-docker-server.sh",
    "deploy-server.sh",
    "diagnose-database-server.sh",
    "diagnose-import-issue.ps1",
    "export-database.ps1",
    "fix-admin.sh",
    "fix-nginx-logs.sh",
    "fix-student-delete-issue.ps1",
    "manage-database-server.sh",
    "package-database-tools.sh",
    "restore-database.ps1",
    "server-scripts-template.sh",
    "start-all.ps1",
    "start-backend.bat",
    "start-backend.ps1",
    "start-backend.sh",
    "start-frontend.bat",
    "start-frontend.ps1",
    "stop-all.ps1",
    "stop-backend.sh"
)

# 定义要删除的临时文件
$filesToDelete = @(
    "course-fix-transaction_20260309_205702.zip",
    "course-selection-server_20260309_161231.zip",
    "course-selection-server_20260309_200842.zip",
    "database_backup.dump",
    "docker-compose-server.yml"
)

$deletedCount = 0

# 删除文档
Write-Host "`n删除临时文档..." -ForegroundColor Yellow
foreach ($doc in $docsToDelete) {
    $path = Join-Path $PSScriptRoot $doc
    if (Test-Path $path) {
        Remove-Item $path -Force
        Write-Host "  已删除: $doc" -ForegroundColor Gray
        $deletedCount++
    }
}

# 删除配置文件
Write-Host "`n删除临时配置文件..." -ForegroundColor Yellow
foreach ($config in $configsToDelete) {
    $path = Join-Path $PSScriptRoot $config
    if (Test-Path $path) {
        Remove-Item $path -Force
        Write-Host "  已删除: $config" -ForegroundColor Gray
        $deletedCount++
    }
}

# 删除脚本
Write-Host "`n删除临时脚本..." -ForegroundColor Yellow
foreach ($script in $scriptsToDelete) {
    $path = Join-Path $PSScriptRoot $script
    if (Test-Path $path) {
        Remove-Item $path -Force
        Write-Host "  已删除: $script" -ForegroundColor Gray
        $deletedCount++
    }
}

# 删除临时文件
Write-Host "`n删除临时文件..." -ForegroundColor Yellow
foreach ($file in $filesToDelete) {
    $path = Join-Path $PSScriptRoot $file
    if (Test-Path $path) {
        Remove-Item $path -Force
        Write-Host "  已删除: $file" -ForegroundColor Gray
        $deletedCount++
    }
}

# 删除临时目录
Write-Host "`n删除临时目录..." -ForegroundColor Yellow
$dirsToDelete = @(
    "deploy-course-fix-transaction_20260309_205702",
    "deploy-server",
    "deploy-server-20260309_200842"
)

foreach ($dir in $dirsToDelete) {
    $path = Join-Path $PSScriptRoot $dir
    if (Test-Path $path) {
        Remove-Item $path -Recurse -Force
        Write-Host "  已删除目录: $dir" -ForegroundColor Gray
        $deletedCount++
    }
}

Write-Host "`n清理完成！共删除 $deletedCount 个文件/目录" -ForegroundColor Green
Write-Host "`n保留的重要文档:" -ForegroundColor Cyan
Write-Host "  - README.md (项目说明)" -ForegroundColor Gray
Write-Host "  - REDIS-README.md (Redis 配置说明)" -ForegroundColor Gray
Write-Host "  - COURSE_PROGRESS_FEATURE.md (课程进度功能说明)" -ForegroundColor Gray
Write-Host "  - ✅ 项目已提交到GitHub.md (Git 仓库信息)" -ForegroundColor Gray
Write-Host "  - nginx.conf (Nginx 配置)" -ForegroundColor Gray
Write-Host "  - docker-compose.yml (Docker 配置)" -ForegroundColor Gray
Write-Host "  - Dockerfile (Docker 镜像配置)" -ForegroundColor Gray

Write-Host "`n建议下一步操作:" -ForegroundColor Yellow
Write-Host "  1. 检查删除的文件是否正确" -ForegroundColor Gray
Write-Host "  2. 运行 git status 查看变更" -ForegroundColor Gray
Write-Host "  3. 提交清理后的代码: git add . && git commit -m '清理临时文档和文件'" -ForegroundColor Gray
Write-Host "  4. 推送到远程仓库: git push origin main && git push gitee main" -ForegroundColor Gray
