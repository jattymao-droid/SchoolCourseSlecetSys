# PostgreSQL数据库导出脚本
# 导出完整数据库到sql文件夹

$ErrorActionPreference = "Stop"

# 数据库配置
$DB_HOST = "localhost"
$DB_PORT = "5432"
$DB_NAME = "ry_vue"
$DB_USER = "postgres"
$DB_PASSWORD = "mm5621528"

# 输出文件配置
$TIMESTAMP = Get-Date -Format "yyyyMMdd_HHmmss"
$OUTPUT_DIR = "sql"
$OUTPUT_FILE = "$OUTPUT_DIR/ry_vue_full_backup_$TIMESTAMP.sql"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PostgreSQL 数据库导出工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "数据库信息:" -ForegroundColor Yellow
Write-Host "  主机: $DB_HOST" -ForegroundColor White
Write-Host "  端口: $DB_PORT" -ForegroundColor White
Write-Host "  数据库: $DB_NAME" -ForegroundColor White
Write-Host "  用户: $DB_USER" -ForegroundColor White
Write-Host ""
Write-Host "输出文件: $OUTPUT_FILE" -ForegroundColor Yellow
Write-Host ""

# 检查pg_dump是否存在
$pgDumpPath = Get-Command pg_dump -ErrorAction SilentlyContinue
if (-not $pgDumpPath) {
    Write-Host "错误: 未找到 pg_dump 命令" -ForegroundColor Red
    Write-Host "请确保 PostgreSQL 已安装并添加到系统 PATH 环境变量中" -ForegroundColor Red
    Write-Host ""
    Write-Host "常见 PostgreSQL 安装路径:" -ForegroundColor Yellow
    Write-Host "  C:\Program Files\PostgreSQL\<version>\bin" -ForegroundColor White
    Write-Host "  C:\PostgreSQL\<version>\bin" -ForegroundColor White
    exit 1
}

Write-Host "找到 pg_dump: $($pgDumpPath.Source)" -ForegroundColor Green
Write-Host ""

# 确保输出目录存在
if (-not (Test-Path $OUTPUT_DIR)) {
    New-Item -ItemType Directory -Path $OUTPUT_DIR | Out-Null
    Write-Host "创建输出目录: $OUTPUT_DIR" -ForegroundColor Green
}

# 设置密码环境变量
$env:PGPASSWORD = $DB_PASSWORD

Write-Host "开始导出数据库..." -ForegroundColor Cyan
Write-Host ""

try {
    # 执行pg_dump导出
    # 参数说明:
    # -h: 主机
    # -p: 端口
    # -U: 用户名
    # -d: 数据库名
    # -F p: 输出格式为纯文本SQL
    # -b: 包含大对象
    # -v: 详细模式
    # -f: 输出文件
    # --inserts: 使用INSERT语句而不是COPY（更兼容）
    # --column-inserts: INSERT语句包含列名
    
    $arguments = @(
        "-h", $DB_HOST,
        "-p", $DB_PORT,
        "-U", $DB_USER,
        "-d", $DB_NAME,
        "-F", "p",
        "-b",
        "-v",
        "-f", $OUTPUT_FILE,
        "--inserts",
        "--column-inserts"
    )
    
    $process = Start-Process -FilePath "pg_dump" -ArgumentList $arguments -NoNewWindow -Wait -PassThru
    
    if ($process.ExitCode -eq 0) {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "数据库导出成功!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        
        # 显示文件信息
        $fileInfo = Get-Item $OUTPUT_FILE
        Write-Host "文件信息:" -ForegroundColor Yellow
        Write-Host "  路径: $($fileInfo.FullName)" -ForegroundColor White
        Write-Host "  大小: $([math]::Round($fileInfo.Length / 1MB, 2)) MB" -ForegroundColor White
        Write-Host "  创建时间: $($fileInfo.CreationTime)" -ForegroundColor White
        Write-Host ""
        
        # 统计SQL文件内容
        $content = Get-Content $OUTPUT_FILE -Raw
        $tableCount = ([regex]::Matches($content, "CREATE TABLE")).Count
        $insertCount = ([regex]::Matches($content, "INSERT INTO")).Count
        
        Write-Host "导出统计:" -ForegroundColor Yellow
        Write-Host "  表数量: $tableCount" -ForegroundColor White
        Write-Host "  INSERT语句数: $insertCount" -ForegroundColor White
        Write-Host ""
        
    } else {
        Write-Host ""
        Write-Host "数据库导出失败! 退出代码: $($process.ExitCode)" -ForegroundColor Red
        exit 1
    }
    
} catch {
    Write-Host ""
    Write-Host "导出过程中发生错误:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
} finally {
    # 清除密码环境变量
    Remove-Item Env:\PGPASSWORD -ErrorAction SilentlyContinue
}

Write-Host "完成!" -ForegroundColor Green
