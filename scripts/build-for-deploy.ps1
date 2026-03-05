# ============================================================
# 东陆高中选课系统 - 本地打包脚本
# 在项目根目录执行，生成 deploy 部署包
# ============================================================

$ErrorActionPreference = "Stop"
$ProjectRoot = $PSScriptRoot + "\.."
Set-Location $ProjectRoot

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  东陆高中选课系统 - 本地打包" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# 清理并创建 deploy 目录
$DeployDir = Join-Path $ProjectRoot "deploy"
if (Test-Path $DeployDir) {
    Remove-Item $DeployDir -Recurse -Force
}
New-Item -ItemType Directory -Path $DeployDir | Out-Null
New-Item -ItemType Directory -Path (Join-Path $DeployDir "backend") | Out-Null
New-Item -ItemType Directory -Path (Join-Path $DeployDir "frontend-admin") | Out-Null
New-Item -ItemType Directory -Path (Join-Path $DeployDir "frontend-student") | Out-Null
New-Item -ItemType Directory -Path (Join-Path $DeployDir "sql") | Out-Null
New-Item -ItemType Directory -Path (Join-Path $DeployDir "config") | Out-Null

# 1. 打包后端
Write-Host "`n[1/4] 打包后端 (Maven)..." -ForegroundColor Yellow
$mvnResult = & mvn clean package -pl ruoyi-admin -am -DskipTests -q 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Maven 打包失败: $mvnResult" -ForegroundColor Red
    exit 1
}
$jarPath = Join-Path $ProjectRoot "ruoyi-admin\target\ruoyi-admin.jar"
if (Test-Path $jarPath) {
    Copy-Item $jarPath (Join-Path $DeployDir "backend\ruoyi-admin.jar")
    Write-Host "  后端 JAR 已复制到 deploy/backend/" -ForegroundColor Green
} else {
    Write-Host "  未找到 ruoyi-admin.jar" -ForegroundColor Red
    exit 1
}

# 2. 打包管理端前端 (ruoyi-ui)
Write-Host "`n[2/4] 打包管理端前端 (ruoyi-ui)..." -ForegroundColor Yellow
Set-Location (Join-Path $ProjectRoot "ruoyi-ui")
if (-not (Test-Path "node_modules")) {
    npm install
}
$buildResult = npm run build:prod 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "ruoyi-ui 打包失败: $buildResult" -ForegroundColor Red
    exit 1
}
$distPath = Join-Path $ProjectRoot "ruoyi-ui\dist"
if (Test-Path $distPath) {
    Copy-Item $distPath (Join-Path $DeployDir "frontend-admin\dist") -Recurse
    Write-Host "  管理端前端已复制到 deploy/frontend-admin/dist/" -ForegroundColor Green
}
Set-Location $ProjectRoot

# 3. 打包学生端 H5 (course-selection-app)
Write-Host "`n[3/4] 打包学生端 H5 (course-selection-app)..." -ForegroundColor Yellow
Set-Location (Join-Path $ProjectRoot "course-selection-app")
if (-not (Test-Path "node_modules")) {
    npm install
}
$env:VITE_BASE_PATH = "/h5/"
$h5Result = npm run build:h5 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "course-selection-app H5 打包失败: $h5Result" -ForegroundColor Red
    exit 1
}
$h5DistPath = Join-Path $ProjectRoot "course-selection-app\dist\build\h5"
if (Test-Path $h5DistPath) {
    Copy-Item $h5DistPath (Join-Path $DeployDir "frontend-student\h5") -Recurse
    Write-Host "  学生端 H5 已复制到 deploy/frontend-student/h5/" -ForegroundColor Green
} else {
    Write-Host "  未找到 H5 构建产物，请检查 course-selection-app 构建输出" -ForegroundColor Red
}
Set-Location $ProjectRoot

# 4. 复制 SQL 和配置
Write-Host "`n[4/4] 复制数据库脚本和配置..." -ForegroundColor Yellow
$sqlFiles = @(
    "ry_20250522_postgresql.sql",
    "quartz_postgresql.sql",
    "course_selection_init.sql",
    "course_grade_class_menu.sql",
    "course_student_menu.sql",
    "course_course_menu.sql",
    "course_selection_menu.sql",
    "course_evaluation_menu.sql",
    "course_teacher_assessment_menu.sql",
    "course_week_day_dict.sql",
    "course_default_password_config.sql",
    "add_course_teacher_name.sql",
    "add_stu_selection_assigned.sql",
    "add_course_location.sql",
    "add_semester_selection_time.sql",
    "fix_teacher_assessment_no_cache.sql",
    "fix_course_route_name.sql",
    "fix_student_login_by_student_no.sql",
    "verify_location.sql"
)
$sqlDir = Join-Path $ProjectRoot "sql"
foreach ($f in $sqlFiles) {
    $src = Join-Path $sqlDir $f
    if (Test-Path $src) {
        Copy-Item $src (Join-Path $DeployDir "sql\$f")
    }
}
# 可选：演示数据
$demoSql = Join-Path $sqlDir "course_demo_data.sql"
if (Test-Path $demoSql) {
    Copy-Item $demoSql (Join-Path $DeployDir "sql\course_demo_data.sql")
    Write-Host "  已包含演示数据脚本 (course_demo_data.sql，可选执行)" -ForegroundColor Gray
}

# 复制 init-db.sh、deploy.sh、配置和部署说明
$scriptsDir = Join-Path $ProjectRoot "scripts"
Copy-Item (Join-Path $scriptsDir "deploy-README.md") (Join-Path $DeployDir "DEPLOY.md")
Copy-Item (Join-Path $scriptsDir "init-db.sh") (Join-Path $DeployDir "init-db.sh")
Copy-Item (Join-Path $scriptsDir "deploy.sh") (Join-Path $DeployDir "deploy.sh")
$prodYmlSrc = Join-Path $scriptsDir "config\application-prod.yml"
if (Test-Path $prodYmlSrc) {
    Copy-Item $prodYmlSrc (Join-Path $DeployDir "config\application-prod.yml")
}
Write-Host "  配置和脚本已复制" -ForegroundColor Green

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  打包完成！" -ForegroundColor Green
Write-Host "  部署包位置: $DeployDir" -ForegroundColor Cyan
Write-Host "  请将 deploy 目录整体上传到云服务器后执行 deploy.sh" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
