# 学生导入问题诊断脚本
# 用于诊断学生导入失败的原因

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "学生导入问题诊断工具" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 1. 检查数据库中的学生记录
Write-Host "1. 检查数据库中的学生记录..." -ForegroundColor Yellow
$env:PGPASSWORD='mm5621528'
$studentCount = psql -h localhost -U postgres -d ry_vue -t -c "SELECT COUNT(*) FROM stu_student_info;"
$activeStudents = psql -h localhost -U postgres -d ry_vue -t -c "SELECT COUNT(*) FROM stu_student_info WHERE del_flag = '0';"
$deletedStudents = psql -h localhost -U postgres -d ry_vue -t -c "SELECT COUNT(*) FROM stu_student_info WHERE del_flag = '2';"

Write-Host "   总记录数: $($studentCount.Trim())" -ForegroundColor White
Write-Host "   活跃记录 (del_flag='0'): $($activeStudents.Trim())" -ForegroundColor Green
Write-Host "   已删除记录 (del_flag='2'): $($deletedStudents.Trim())" -ForegroundColor Red

# 2. 检查用户表中的记录
Write-Host "`n2. 检查用户表中的学生用户记录..." -ForegroundColor Yellow
$userCount = psql -h localhost -U postgres -d ry_vue -t -c "SELECT COUNT(*) FROM sys_user WHERE user_type = '01';"
$activeUsers = psql -h localhost -U postgres -d ry_vue -t -c "SELECT COUNT(*) FROM sys_user WHERE user_type = '01' AND del_flag = '0';"
$deletedUsers = psql -h localhost -U postgres -d ry_vue -t -c "SELECT COUNT(*) FROM sys_user WHERE user_type = '01' AND del_flag = '2';"

Write-Host "   总记录数: $($userCount.Trim())" -ForegroundColor White
Write-Host "   活跃记录 (del_flag='0'): $($activeUsers.Trim())" -ForegroundColor Green
Write-Host "   已删除记录 (del_flag='2'): $($deletedUsers.Trim())" -ForegroundColor Red

# 3. 检查是否有孤立的用户记录（用户存在但学生记录不存在）
Write-Host "`n3. 检查孤立的用户记录..." -ForegroundColor Yellow
$orphanUsers = psql -h localhost -U postgres -d ry_vue -t -c "SELECT COUNT(*) FROM sys_user u WHERE u.user_type = '01' AND NOT EXISTS (SELECT 1 FROM stu_student_info s WHERE s.user_id = u.user_id);"
Write-Host "   孤立用户记录数: $($orphanUsers.Trim())" -ForegroundColor $(if ($orphanUsers.Trim() -eq "0") { "Green" } else { "Red" })

if ($orphanUsers.Trim() -ne "0") {
    Write-Host "`n   孤立用户列表（前10条）:" -ForegroundColor Red
    psql -h localhost -U postgres -d ry_vue -c "SELECT user_id, user_name, nick_name, del_flag FROM sys_user u WHERE u.user_type = '01' AND NOT EXISTS (SELECT 1 FROM stu_student_info s WHERE s.user_id = u.user_id) LIMIT 10;"
}

# 4. 检查是否有孤立的学生记录（学生存在但用户记录不存在）
Write-Host "`n4. 检查孤立的学生记录..." -ForegroundColor Yellow
$orphanStudents = psql -h localhost -U postgres -d ry_vue -t -c "SELECT COUNT(*) FROM stu_student_info s WHERE NOT EXISTS (SELECT 1 FROM sys_user u WHERE u.user_id = s.user_id);"
Write-Host "   孤立学生记录数: $($orphanStudents.Trim())" -ForegroundColor $(if ($orphanStudents.Trim() -eq "0") { "Green" } else { "Red" })

if ($orphanStudents.Trim() -ne "0") {
    Write-Host "`n   孤立学生列表（前10条）:" -ForegroundColor Red
    psql -h localhost -U postgres -d ry_vue -c "SELECT id, user_id, student_no, real_name, del_flag FROM stu_student_info s WHERE NOT EXISTS (SELECT 1 FROM sys_user u WHERE u.user_id = s.user_id) LIMIT 10;"
}

# 5. 检查数据库约束
Write-Host "`n5. 检查数据库唯一约束..." -ForegroundColor Yellow
psql -h localhost -U postgres -d ry_vue -c "\d stu_student_info" | Select-String -Pattern "UNIQUE|PRIMARY"

# 6. 提供修复建议
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "修复建议" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($deletedStudents.Trim() -ne "0") {
    Write-Host "`n⚠ 发现 $($deletedStudents.Trim()) 条逻辑删除的学生记录" -ForegroundColor Red
    Write-Host "   这些记录会导致学号冲突，建议执行物理删除：" -ForegroundColor Yellow
    Write-Host "   DELETE FROM stu_student_info WHERE del_flag = '2';" -ForegroundColor White
}

if ($deletedUsers.Trim() -ne "0") {
    Write-Host "`n⚠ 发现 $($deletedUsers.Trim()) 条逻辑删除的用户记录" -ForegroundColor Red
    Write-Host "   这些记录会导致用户名冲突，建议执行物理删除：" -ForegroundColor Yellow
    Write-Host "   DELETE FROM sys_user WHERE user_type = '01' AND del_flag = '2';" -ForegroundColor White
}

if ($orphanUsers.Trim() -ne "0") {
    Write-Host "`n⚠ 发现 $($orphanUsers.Trim()) 条孤立的用户记录" -ForegroundColor Red
    Write-Host "   这些用户没有对应的学生记录，建议删除：" -ForegroundColor Yellow
    Write-Host "   DELETE FROM sys_user WHERE user_type = '01' AND NOT EXISTS (SELECT 1 FROM stu_student_info WHERE user_id = sys_user.user_id);" -ForegroundColor White
}

if ($orphanStudents.Trim() -ne "0") {
    Write-Host "`n⚠ 发现 $($orphanStudents.Trim()) 条孤立的学生记录" -ForegroundColor Red
    Write-Host "   这些学生没有对应的用户记录，数据不一致！" -ForegroundColor Yellow
}

if ($deletedStudents.Trim() -eq "0" -and $deletedUsers.Trim() -eq "0" -and $orphanUsers.Trim() -eq "0" -and $orphanStudents.Trim() -eq "0") {
    Write-Host "`n✓ 数据库状态正常，没有发现问题" -ForegroundColor Green
    Write-Host "`n如果导入仍然失败，可能的原因：" -ForegroundColor Yellow
    Write-Host "   1. Excel文件中有重复的学号" -ForegroundColor White
    Write-Host "   2. 后端代码未重新编译" -ForegroundColor White
    Write-Host "   3. 缓存问题（尝试重启后端）" -ForegroundColor White
}

Write-Host "`n========================================`n" -ForegroundColor Cyan
