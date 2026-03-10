# 修复学生删除问题脚本
# 用于清理逻辑删除的记录并验证物理删除功能

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "学生删除问题修复工具" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 数据库配置
$env:PGPASSWORD='mm5621528'
$dbHost = 'localhost'
$dbUser = 'postgres'
$dbName = 'ry_vue'

# 1. 检查当前状态
Write-Host "1. 检查数据库当前状态..." -ForegroundColor Yellow
$studentTotal = (psql -h $dbHost -U $dbUser -d $dbName -t -c "SELECT COUNT(*) FROM stu_student_info;").Trim()
$studentActive = (psql -h $dbHost -U $dbUser -d $dbName -t -c "SELECT COUNT(*) FROM stu_student_info WHERE del_flag = '0';").Trim()
$studentDeleted = (psql -h $dbHost -U $dbUser -d $dbName -t -c "SELECT COUNT(*) FROM stu_student_info WHERE del_flag = '2';").Trim()

Write-Host "   学生表记录:" -ForegroundColor White
Write-Host "   - 总记录数: $studentTotal" -ForegroundColor White
Write-Host "   - 活跃记录: $studentActive" -ForegroundColor Green
Write-Host "   - 逻辑删除: $studentDeleted" -ForegroundColor $(if ($studentDeleted -eq "0") { "Green" } else { "Red" })

$userTotal = (psql -h $dbHost -U $dbUser -d $dbName -t -c "SELECT COUNT(*) FROM sys_user WHERE user_type = '01';").Trim()
$userActive = (psql -h $dbHost -U $dbUser -d $dbName -t -c "SELECT COUNT(*) FROM sys_user WHERE user_type = '01' AND del_flag = '0';").Trim()
$userDeleted = (psql -h $dbHost -U $dbUser -d $dbName -t -c "SELECT COUNT(*) FROM sys_user WHERE user_type = '01' AND del_flag = '2';").Trim()

Write-Host "`n   用户表记录（学生类型）:" -ForegroundColor White
Write-Host "   - 总记录数: $userTotal" -ForegroundColor White
Write-Host "   - 活跃记录: $userActive" -ForegroundColor Green
Write-Host "   - 逻辑删除: $userDeleted" -ForegroundColor $(if ($userDeleted -eq "0") { "Green" } else { "Red" })

# 2. 清理逻辑删除的记录
if ($studentDeleted -ne "0" -or $userDeleted -ne "0") {
    Write-Host "`n2. 发现逻辑删除的记录，开始清理..." -ForegroundColor Yellow
    
    if ($studentDeleted -ne "0") {
        Write-Host "   清理学生表中的逻辑删除记录..." -ForegroundColor White
        $result = psql -h $dbHost -U $dbUser -d $dbName -c "DELETE FROM stu_student_info WHERE del_flag = '2';"
        Write-Host "   ✓ 已清理 $studentDeleted 条学生记录" -ForegroundColor Green
    }
    
    if ($userDeleted -ne "0") {
        Write-Host "   清理用户表中的逻辑删除记录..." -ForegroundColor White
        $result = psql -h $dbHost -U $dbUser -d $dbName -c "DELETE FROM sys_user WHERE user_type = '01' AND del_flag = '2';"
        Write-Host "   ✓ 已清理 $userDeleted 条用户记录" -ForegroundColor Green
    }
} else {
    Write-Host "`n2. ✓ 没有逻辑删除的记录，数据库状态正常" -ForegroundColor Green
}

# 3. 验证清理结果
Write-Host "`n3. 验证清理结果..." -ForegroundColor Yellow
$finalStudentCount = (psql -h $dbHost -U $dbUser -d $dbName -t -c "SELECT COUNT(*) FROM stu_student_info;").Trim()
$finalUserCount = (psql -h $dbHost -U $dbUser -d $dbName -t -c "SELECT COUNT(*) FROM sys_user WHERE user_type = '01';").Trim()

Write-Host "   学生表记录数: $finalStudentCount" -ForegroundColor White
Write-Host "   用户表记录数: $finalUserCount" -ForegroundColor White

# 4. 检查代码版本
Write-Host "`n4. 检查代码编译时间..." -ForegroundColor Yellow
$serviceImplClass = "ruoyi-system\target\classes\com\ruoyi\system\service\impl\StudentServiceImpl.class"
if (Test-Path $serviceImplClass) {
    $classFile = Get-Item $serviceImplClass
    Write-Host "   StudentServiceImpl.class 编译时间: $($classFile.LastWriteTime)" -ForegroundColor White
    
    $javaFile = Get-Item "ruoyi-system\src\main\java\com\ruoyi\system\service\impl\StudentServiceImpl.java"
    Write-Host "   StudentServiceImpl.java 修改时间: $($javaFile.LastWriteTime)" -ForegroundColor White
    
    if ($classFile.LastWriteTime -lt $javaFile.LastWriteTime) {
        Write-Host "   ⚠ 警告：class文件比源文件旧，需要重新编译！" -ForegroundColor Red
    } else {
        Write-Host "   ✓ 代码已是最新版本" -ForegroundColor Green
    }
} else {
    Write-Host "   ⚠ 未找到编译后的class文件" -ForegroundColor Red
}

# 5. 提供操作建议
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "操作建议" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`n✓ 数据库已清理完成，现在可以重新导入学生" -ForegroundColor Green

Write-Host "`n如果删除后重新导入仍然失败，请按以下步骤操作：" -ForegroundColor Yellow
Write-Host "1. 清除浏览器缓存（Ctrl+Shift+Delete）" -ForegroundColor White
Write-Host "2. 刷新前端页面（Ctrl+F5 强制刷新）" -ForegroundColor White
Write-Host "3. 重新编译后端：mvn package -DskipTests" -ForegroundColor White
Write-Host "4. 重启后端服务" -ForegroundColor White

Write-Host "`n========================================`n" -ForegroundColor Cyan
