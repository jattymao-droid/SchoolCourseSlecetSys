# 批量更新按钮颜色的 PowerShell 脚本
# 使用方法：在 ruoyi-ui 目录下运行 .\update-buttons.ps1

Write-Host "开始批量更新按钮颜色..." -ForegroundColor Green

# 定义要搜索的目录
$searchPath = "src/views"

# 获取所有 .vue 文件
$vueFiles = Get-ChildItem -Path $searchPath -Filter "*.vue" -Recurse

$totalFiles = $vueFiles.Count
$updatedFiles = 0
$totalReplacements = 0

Write-Host "找到 $totalFiles 个 Vue 文件" -ForegroundColor Cyan

foreach ($file in $vueFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    $fileReplacements = 0
    
    # 1. 编辑按钮：Primary → Warning
    $pattern1 = 'type="primary"([^>]*?)icon="Edit"'
    $replacement1 = 'type="warning"$1icon="Edit"'
    $content = $content -replace $pattern1, $replacement1
    $count1 = ([regex]::Matches($originalContent, $pattern1)).Count
    $fileReplacements += $count1
    
    # 2. 删除按钮：Primary → Danger
    $pattern2 = 'type="primary"([^>]*?)icon="Delete"'
    $replacement2 = 'type="danger"$1icon="Delete"'
    $content = $content -replace $pattern2, $replacement2
    $count2 = ([regex]::Matches($originalContent, $pattern2)).Count
    $fileReplacements += $count2
    
    # 3. 新增按钮：Primary → Success
    $pattern3 = 'type="primary"([^>]*?)icon="Plus"'
    $replacement3 = 'type="success"$1icon="Plus"'
    $content = $content -replace $pattern3, $replacement3
    $count3 = ([regex]::Matches($originalContent, $pattern3)).Count
    $fileReplacements += $count3
    
    # 4. 下载按钮：Primary → Info
    $pattern4 = 'type="primary"([^>]*?)icon="Download"'
    $replacement4 = 'type="info"$1icon="Download"'
    $content = $content -replace $pattern4, $replacement4
    $count4 = ([regex]::Matches($originalContent, $pattern4)).Count
    $fileReplacements += $count4
    
    # 5. 导出按钮：Warning → Info
    $pattern5 = 'type="warning"([^>]*?)icon="Download"'
    $replacement5 = 'type="info"$1icon="Download"'
    $content = $content -replace $pattern5, $replacement5
    $count5 = ([regex]::Matches($originalContent, $pattern5)).Count
    $fileReplacements += $count5
    
    # 6. 刷新/同步按钮：Primary → Warning
    $pattern6 = 'type="primary"([^>]*?)icon="Refresh"'
    $replacement6 = 'type="warning"$1icon="Refresh"'
    $content = $content -replace $pattern6, $replacement6
    $count6 = ([regex]::Matches($originalContent, $pattern6)).Count
    $fileReplacements += $count6
    
    # 7. 上传按钮：Primary → Info
    $pattern7 = 'type="primary"([^>]*?)icon="Upload"'
    $replacement7 = 'type="info"$1icon="Upload"'
    $content = $content -replace $pattern7, $replacement7
    $count7 = ([regex]::Matches($originalContent, $pattern7)).Count
    $fileReplacements += $count7
    
    # 如果内容有变化，保存文件
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        $updatedFiles++
        $totalReplacements += $fileReplacements
        Write-Host "✓ 更新: $($file.Name) ($fileReplacements 处修改)" -ForegroundColor Yellow
    }
}

Write-Host "`n更新完成！" -ForegroundColor Green
Write-Host "总文件数: $totalFiles" -ForegroundColor Cyan
Write-Host "已更新文件: $updatedFiles" -ForegroundColor Cyan
Write-Host "总替换次数: $totalReplacements" -ForegroundColor Cyan

Write-Host "`n按钮颜色映射:" -ForegroundColor Magenta
Write-Host "  编辑 (Edit)     → Warning (橙色)" -ForegroundColor Yellow
Write-Host "  删除 (Delete)   → Danger (红色)" -ForegroundColor Red
Write-Host "  新增 (Plus)     → Success (绿色)" -ForegroundColor Green
Write-Host "  下载 (Download) → Info (蓝色)" -ForegroundColor Blue
Write-Host "  刷新 (Refresh)  → Warning (橙色)" -ForegroundColor Yellow
Write-Host "  上传 (Upload)   → Info (蓝色)" -ForegroundColor Blue

Write-Host "`n请刷新浏览器查看效果！" -ForegroundColor Green
