@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0\.."

echo ========================================
echo   东陆高中选课系统 - 本地打包
echo ========================================

if exist deploy rmdir /s /q deploy
mkdir deploy\backend
mkdir deploy\frontend-admin
mkdir deploy\frontend-student
mkdir deploy\sql
mkdir deploy\config

echo.
echo [1/4] 打包后端 (Maven)...
if exist "%~dp0..\mvnw.cmd" (
    call "%~dp0..\mvnw.cmd" clean package -pl ruoyi-admin -am -DskipTests -q
) else (
    call mvn clean package -pl ruoyi-admin -am -DskipTests -q
)
if errorlevel 1 (
    echo Maven 打包失败
    exit /b 1
)
copy ruoyi-admin\target\ruoyi-admin.jar deploy\backend\
echo   后端 JAR 已复制

echo.
echo [2/4] 打包管理端前端 (ruoyi-ui)...
cd ruoyi-ui
if not exist node_modules call npm install
call npm run build:prod
if errorlevel 1 (
    echo ruoyi-ui 打包失败
    exit /b 1
)
xcopy /e /y dist ..\deploy\frontend-admin\dist\
cd ..

echo.
echo [3/4] 打包学生端 H5 (course-selection-app)...
cd course-selection-app
if not exist node_modules call npm install
set VITE_BASE_PATH=/h5/
call npm run build:h5
if errorlevel 1 (
    echo course-selection-app H5 打包失败
    exit /b 1
)
xcopy /e /y dist\build\h5 ..\deploy\frontend-student\h5\
cd ..

echo.
echo [4/4] 复制 SQL 和配置...
for %%f in (ry_20250522_postgresql.sql quartz_postgresql.sql course_selection_init.sql course_grade_class_menu.sql course_student_menu.sql course_course_menu.sql course_selection_menu.sql course_evaluation_menu.sql course_teacher_assessment_menu.sql course_week_day_dict.sql course_default_password_config.sql add_course_teacher_name.sql add_stu_selection_assigned.sql add_course_location.sql add_semester_selection_time.sql fix_teacher_assessment_no_cache.sql fix_course_route_name.sql fix_student_login_by_student_no.sql verify_location.sql) do (
    if exist sql\%%f copy sql\%%f deploy\sql\
)
if exist sql\course_demo_data.sql copy sql\course_demo_data.sql deploy\sql\

copy scripts\deploy-README.md deploy\DEPLOY.md
copy scripts\init-db.sh deploy\
copy scripts\deploy.sh deploy\
copy scripts\docker-deploy\deploy-docker.sh deploy\
if not exist deploy\docker mkdir deploy\docker
copy scripts\docker-deploy\Dockerfile.backend deploy\docker\
copy scripts\docker-deploy\Dockerfile.frontend deploy\docker\
copy scripts\docker-deploy\docker-compose.yml deploy\docker\
copy scripts\docker-deploy\application-docker.yml deploy\docker\
copy scripts\docker-deploy\nginx.conf deploy\docker\
if exist scripts\docker-deploy\.env.example copy scripts\docker-deploy\.env.example deploy\.env.example
if exist scripts\config\application-prod.yml copy scripts\config\application-prod.yml deploy\config\

REM 转换 .sh 为 Unix 换行符 (LF)，避免 Linux 执行报错
for %%s in (init-db.sh deploy.sh deploy-docker.sh) do (
    if exist deploy\%%s powershell -NoProfile -Command "$c=[IO.File]::ReadAllText('deploy\%%s'); $c=$c -replace \"`r`n\",\"`n\"; [IO.File]::WriteAllText('deploy\%%s', $c)"
)

echo.
echo ========================================
echo   打包完成！部署包位置: deploy
echo   请将 deploy 目录上传到云服务器
echo   deploy.sh / deploy-docker.sh
echo ========================================
pause
