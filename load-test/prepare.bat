@echo off
chcp 65001 >nul
echo 压力测试前置：关闭验证码...
set PGPASSWORD=mm5621528
set PGHOST=localhost
set PGPORT=5432
set PGUSER=postgres
set PGDATABASE=ry_vue

REM 尝试查找 psql
where psql >nul 2>&1
if %errorlevel% neq 0 (
    for %%v in (17 16 15 14 13 12) do (
        if exist "C:\Program Files\PostgreSQL\%%v\bin\psql.exe" (
            set "PATH=C:\Program Files\PostgreSQL\%%v\bin;%PATH%"
            goto :run
        )
    )
    echo 未找到 psql，请手动执行:
    echo   psql -U postgres -d ry_vue -f sql\load_test_prepare.sql
    echo 或使用 Navicat/DBeaver 等工具执行 sql\load_test_prepare.sql
    pause
    exit /b 1
)
:run
psql -h %PGHOST% -p %PGPORT% -U %PGUSER% -d %PGDATABASE% -f "%~dp0..\sql\load_test_prepare.sql"
if %errorlevel% equ 0 (
    echo 验证码已关闭，可运行: node load-test.js
) else (
    echo 执行失败，请检查数据库连接
)
pause
