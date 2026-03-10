# 清理已逻辑删除的用户记录
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "清理已删除的用户记录" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 数据库配置
$dbHost = "localhost"
$dbPort = "5432"
$dbName = "ry_vue"
$dbUser = "postgres"
$dbPassword = "mm5621528"

Write-Host "连接数据库: $dbName@$dbHost:$dbPort" -ForegroundColor Yellow
Write-Host ""

# 设置环境变量
$env:PGPASSWORD = $dbPassword

# 1. 查看有多少已删除的用户
Write-Host "1. 检查已删除的学生用户数量..." -ForegroundColor Yellow
$countQuery = "SELECT COUNT(*) FROM sys_user WHERE del_flag = '2' AND user_type = '01';"
$count = psql -h $dbHost -p $dbPort -U $dbUser -d $dbName -t -c $countQuery

if ($count -match '\d+') {
    $deletedCount = [int]$count.Trim()
    Write-Host "   找到 $deletedCount 个已删除的学生用户" -ForegroundColor Cyan
    
    if ($deletedCount -eq 0) {
        Write-Host "   没有需要清理的记录" -ForegroundColor Green
        exit 0
    }
} else {
    Write-Host "   无法连接数据库或查询失败" -ForegroundColor Red
    Write-Host "   请确保 PostgreSQL 正在运行，并且 psql 命令可用" -ForegroundColor Yellow
    exit 1
}

Write-Host ""

# 2. 显示这些用户的信息
Write-Host "2. 已删除用户列表（前10条）:" -ForegroundColor Yellow
$listQuery = "SELECT user_id, user_name, nick_name FROM sys_user WHERE del_flag = '2' AND user_type = '01' LIMIT 10;"
psql -h $dbHost -p $dbPort -U $dbUser -d $dbName -c $listQuery

Write-Host ""

# 3. 确认是否删除
$response = Read-Host "是否物理删除这些记录？这将永久删除 $deletedCount 个用户 (y/N)"

if ($response -ne 'y' -and $response -ne 'Y') {
    Write-Host "取消操作" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "3. 开始清理..." -ForegroundColor Yellow

# 删除用户角色关联
Write-Host "   删除用户角色关联..." -ForegroundColor Gray
$deleteRoleQuery = "DELETE FROM sys_user_role WHERE user_id IN (SELECT user_id FROM sys_user WHERE del_flag = '2' AND user_type = '01');"
psql -h $dbHost -p $dbPort -U $dbUser -d $dbName -c $deleteRoleQuery | Out-Null

# 删除用户岗位关联
Write-Host "   删除用户岗位关联..." -ForegroundColor Gray
$deletePostQuery = "DELETE FROM sys_user_post WHERE user_id IN (SELECT user_id FROM sys_user WHERE del_flag = '2' AND user_type = '01');"
psql -h $dbHost -p $dbPort -U $dbUser -d $dbName -c $deletePostQuery | Out-Null

# 删除用户记录
Write-Host "   删除用户记录..." -ForegroundColor Gray
$deleteUserQuery = "DELETE FROM sys_user WHERE del_flag = '2' AND user_type = '01';"
$result = psql -h $dbHost -p $dbPort -U $dbUser -d $dbName -c $deleteUserQuery

Write-Host ""
Write-Host "✓ 清理完成" -ForegroundColor Green
Write-Host ""

# 4. 验证结果
Write-Host "4. 验证清理结果..." -ForegroundColor Yellow
$verifyQuery = "SELECT COUNT(*) FROM sys_user WHERE del_flag = '2' AND user_type = '01';"
$remaining = psql -h $dbHost -p $dbPort -U $dbUser -d $dbName -t -c $verifyQuery

if ($remaining -match '\d+') {
    $remainingCount = [int]$remaining.Trim()
    if ($remainingCount -eq 0) {
        Write-Host "   ✓ 所有已删除用户已清理" -ForegroundColor Green
    } else {
        Write-Host "   ! 还有 $remainingCount 个记录未清理" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "清理完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "现在可以重新导入学生了" -ForegroundColor Cyan
Write-Host ""

# 清除密码环境变量
Remove-Item Env:\PGPASSWORD
