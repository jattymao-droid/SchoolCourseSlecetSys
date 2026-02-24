@echo off
chcp 65001 >nul
echo ========================================
echo 若依系统 PostgreSQL 数据库初始化
echo ========================================

set PGPASSWORD=mm5621528
set PGHOST=localhost
set PGPORT=5432
set PGUSER=postgres

REM 尝试查找 psql（若未在 PATH 中）
where psql >nul 2>&1
if %errorlevel% neq 0 (
    for %%v in (17 16 15 14 13 12) do (
        if exist "C:\Program Files\PostgreSQL\%%v\bin\psql.exe" (
            set "PGPATH=C:\Program Files\PostgreSQL\%%v\bin"
            goto :found
        )
    )
    echo 错误: 未找到 psql，请将 PostgreSQL 的 bin 目录添加到系统 PATH
    echo 例如: C:\Program Files\PostgreSQL\16\bin
    pause
    exit /b 1
)
:found
if defined PGPATH set "PATH=%PGPATH%;%PATH%"

echo.
echo [1/3] 创建数据库 ry_vue ...
psql -U %PGUSER% -h %PGHOST% -p %PGPORT% -d postgres -c "CREATE DATABASE ry_vue;" 2>nul
if %errorlevel% neq 0 (
    echo 数据库可能已存在，继续执行...
) else (
    echo 数据库创建成功！
)

echo.
echo [2/3] 执行主业务表脚本...
psql -U %PGUSER% -h %PGHOST% -p %PGPORT% -d ry_vue -f "%~dp0ry_20250522_postgresql.sql"
if %errorlevel% neq 0 (
    echo 错误: 主业务表脚本执行失败
    pause
    exit /b 1
)
echo 主业务表脚本执行成功！

echo.
echo [3/3] 执行 Quartz 定时任务表脚本...
psql -U %PGUSER% -h %PGHOST% -p %PGPORT% -d ry_vue -f "%~dp0quartz_postgresql.sql"
if %errorlevel% neq 0 (
    echo 错误: Quartz 脚本执行失败
    pause
    exit /b 1
)
echo Quartz 脚本执行成功！

echo.
echo ========================================
echo 数据库初始化完成！
echo 默认账号: admin / admin123
echo ========================================
pause
