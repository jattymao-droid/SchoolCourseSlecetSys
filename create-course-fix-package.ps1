roundColor Yellow
Write-Host "  1. 上传到服务器" -ForegroundColor White
Write-Host "  2. 解压并执行 deploy.sh" -ForegroundColor White
Write-Host "  3. 验证课程导入功能" -ForegroundColor White
Write-Host ""
rite-Host "  文件名: $zipFile" -ForegroundColor White
Write-Host "  大小: $zipSizeMB MB" -ForegroundColor White
Write-Host "  位置: $(Get-Location)\$zipFile" -ForegroundColor White
Write-Host ""
Write-Host "包含内容:" -ForegroundColor Yellow
Write-Host "  backend/ruoyi-admin.jar ($jarSizeMB MB)" -ForegroundColor White
Write-Host "  deploy.sh (自动部署脚本)" -ForegroundColor White
Write-Host "  README.txt (部署说明)" -ForegroundColor White
Write-Host "  docs/ (详细文档)" -ForegroundColor White
Write-Host ""
Write-Host "下一步操作:" -Foregem -Path $zipFile -Force
}

Compress-Archive -Path $packageDir -DestinationPath $zipFile -CompressionLevel Optimal
$zipInfo = Get-Item $zipFile
$zipSizeMB = [math]::Round($zipInfo.Length / 1MB, 2)

Write-Host "压缩包创建完成" -ForegroundColor Green
Write-Host ""

# 显示摘要
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "部署包创建完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "部署包信息:" -ForegroundColor Yellow
WF8
Write-Host "README.txt 创建完成" -ForegroundColor Green
Write-Host ""

# 复制文档
Write-Host "复制文档..." -ForegroundColor Yellow
if (Test-Path "课程导入修复-部署说明.md") {
    Copy-Item -Path "课程导入修复-部署说明.md" -Destination "$packageDir/docs/"
}
if (Test-Path "课程导入事务错误修复方案.md") {
    Copy-Item -Path "课程导入事务错误修复方案.md" -Destination "$packageDir/docs/"
}
Write-Host "文档复制完成" -ForegroundColor Green
Write-Host ""

# 创建压缩包
Write-Host "创建压缩包..." -ForegroundColor Yellow
$zipFile = "$packageName.zip"
if (Test-Path $zipFile) {
    Remove-It清单:`r`n"
$readmeText += "- backend/ruoyi-admin.jar ($jarSizeMB MB)`r`n"
$readmeText += "- deploy.sh`r`n"
$readmeText += "- README.txt`r`n"
$readmeText += "- docs/`r`n`r`n"
$readmeText += "版本信息:`r`n"
$readmeText += "- 修复版本: v1.1`r`n"
$readmeText += "- 创建日期: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')`r`n"
$readmeText += "- JAR大小: $jarSizeMB MB`r`n"
$readmeText += "- JAR编译时间: $($jarInfo.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss'))`r`n"

Set-Content -Path "$packageDir/README.txt" -Value $readmeText -Encoding UT=========================`r`n`r`n"
$readmeText += "修复内容:`r`n"
$readmeText += "修复了云服务器上导入课程时的PostgreSQL事务错误`r`n`r`n"
$readmeText += "部署步骤:`r`n"
$readmeText += "1. 上传到服务器: scp $packageName.zip root@your-server:/tmp/`r`n"
$readmeText += "2. SSH登录: ssh root@your-server`r`n"
$readmeText += "3. 解压: cd /tmp && unzip $packageName.zip && cd $packageDir`r`n"
$readmeText += "4. 部署: chmod +x deploy.sh && ./deploy.sh`r`n"
$readmeText += "5. 验证: tail -f /www/wwwroot/course-selection/logs/backend.log`r`n`r`n"
$readmeText += "文件EEN}后端服务启动成功${NC}"
    echo ""
    echo -e "${GREEN}部署完成！${NC}"
    echo ""
    echo "查看日志:"
    echo "  tail -f $LOG_DIR/backend.log"
    echo ""
else
    echo -e "${RED}后端服务启动失败${NC}"
    echo ""
    echo "查看错误日志:"
    echo "  tail -n 100 $LOG_DIR/backend.log"
    exit 1
fi
'@

Set-Content -Path "$packageDir/deploy.sh" -Value $deployScript -Encoding UTF8
Write-Host "deploy.sh 创建完成" -ForegroundColor Green

# 创建 README.txt (使用txt避免markdown格式问题)
$readmeText = "课程导入事务错误修复 - 部署包`r`n"
$readmeText += "=============== 2
    fi
    echo -e "${GREEN}后端服务已停止${NC}"
else
    echo -e "${YELLOW}后端服务未运行${NC}"
fi
echo ""

echo -e "${YELLOW}部署新JAR文件...${NC}"
cp backend/ruoyi-admin.jar "$BACKEND_DIR/ruoyi-admin.jar"
chmod 644 "$BACKEND_DIR/ruoyi-admin.jar"
echo -e "${GREEN}JAR文件部署完成${NC}"
echo ""

echo -e "${YELLOW}启动后端服务...${NC}"
cd "$BACKEND_DIR"

nohup java -jar ruoyi-admin.jar \
    --spring.profiles.active=druid,prod \
    > "$LOG_DIR/backend.log" 2>&1 &

sleep 5

if pgrep -f "ruoyi-admin.jar" > /dev/null; then
    echo -e "${GRND_DIR/ruoyi-admin.jar" ]; then
    echo -e "${YELLOW}备份当前JAR文件...${NC}"
    BACKUP_FILE="$BACKUP_DIR/ruoyi-admin.jar.backup_$(date +%Y%m%d_%H%M%S)"
    cp "$BACKEND_DIR/ruoyi-admin.jar" "$BACKUP_FILE"
    echo -e "${GREEN}备份完成: $BACKUP_FILE${NC}"
    echo ""
fi

echo -e "${YELLOW}停止后端服务...${NC}"
if pgrep -f "ruoyi-admin.jar" > /dev/null; then
    pkill -f "ruoyi-admin.jar" || true
    sleep 3
    
    if pgrep -f "ruoyi-admin.jar" > /dev/null; then
        pkill -9 -f "ruoyi-admin.jar" || true
        sleepcho "========================================"
echo ""

BACKEND_DIR="/www/wwwroot/course-selection/backend"
BACKUP_DIR="/www/wwwroot/course-selection/backups"
LOG_DIR="/www/wwwroot/course-selection/logs"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}错误: 请使用root用户运行此脚本${NC}"
    exit 1
fi

echo -e "${YELLOW}检查目录...${NC}"
mkdir -p "$BACKEND_DIR"
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"
echo -e "${GREEN}目录检查完成${NC}"
echo ""

if [ -f "$BACKEckageDir/backend/ruoyi-admin.jar"
Write-Host "JAR文件复制完成" -ForegroundColor Green
Write-Host ""

# 创建部署脚本
Write-Host "创建部署脚本..." -ForegroundColor Yellow

# 创建 deploy.sh
$deployScript = @'
#!/bin/bash
# 课程导入事务错误修复 - 部署脚本

set -e

echo "========================================"
echo "课程导入事务错误修复 - 部署"
eColor Gray
Write-Host ""

# 创建部署目录
Write-Host "创建部署目录..." -ForegroundColor Yellow
if (Test-Path $packageDir) {
    Remove-Item -Path $packageDir -Recurse -Force
}
New-Item -ItemType Directory -Path $packageDir | Out-Null
New-Item -ItemType Directory -Path "$packageDir/backend" | Out-Null
New-Item -ItemType Directory -Path "$packageDir/docs" | Out-Null
Write-Host "部署目录创建完成" -ForegroundColor Green
Write-Host ""

# 复制JAR文件
Write-Host "复制JAR文件..." -ForegroundColor Yellow
Copy-Item -Path $jarPath -Destination "$pa "deploy-$packageName"

# 检查JAR文件
$jarPath = "ruoyi-admin/target/ruoyi-admin.jar"
if (-not (Test-Path $jarPath)) {
    Write-Host "错误: JAR文件不存在: $jarPath" -ForegroundColor Red
    Write-Host "请先运行编译命令: mvn clean package -DskipTests" -ForegroundColor Yellow
    exit 1
}

$jarInfo = Get-Item $jarPath
$jarSizeMB = [math]::Round($jarInfo.Length / 1MB, 2)
Write-Host "找到JAR文件: $jarPath" -ForegroundColor Green
Write-Host "  大小: $jarSizeMB MB" -ForegroundColor Gray
Write-Host "  修改时间: $($jarInfo.LastWriteTime)" -Foreground置
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$packageName = "course-fix-transaction_$timestamp"
$packageDir ========================================" -ForegroundColor Cyan
Write-Host "课程导入事务错误修复 - 部署包创建" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 配# 课程导入事务错误修复 - 部署包创建脚本
# 创建日期: 2026-03-09

$ErrorActionPreference = "Stop"

