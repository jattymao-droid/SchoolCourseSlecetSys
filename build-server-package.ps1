# 构建服务器部署包
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "构建服务器部署包" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$packageName = "course-selection-server_$timestamp"
$packageDir = "deploy-server"

# 1. 清理旧的部署目录
if (Test-Path $packageDir) {
    Write-Host "清理旧的部署目录..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force "$packageDir/backend" -ErrorAction SilentlyContinue
    Remove-Item -Recurse -Force "$packageDir/frontend" -ErrorAction SilentlyContinue
    Remove-Item -Recurse -Force "$packageDir/database" -ErrorAction SilentlyContinue
}

# 创建目录结构
New-Item -ItemType Directory -Path "$packageDir/backend" -Force | Out-Null
New-Item -ItemType Directory -Path "$packageDir/frontend" -Force | Out-Null
New-Item -ItemType Directory -Path "$packageDir/database" -Force | Out-Null

Write-Host "✓ 目录结构创建完成" -ForegroundColor Green
Write-Host ""

# 2. 编译后端
Write-Host "2. 编译后端..." -ForegroundColor Yellow
$buildResult = mvn clean package -DskipTests 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 后端编译成功" -ForegroundColor Green
} else {
    Write-Host "✗ 后端编译失败" -ForegroundColor Red
    Write-Host $buildResult
    exit 1
}

# 复制后端 JAR
$jarFile = "ruoyi-admin\target\ruoyi-admin.jar"
if (Test-Path $jarFile) {
    Copy-Item $jarFile "$packageDir\backend\ruoyi-admin.jar"
    $jarSize = (Get-Item $jarFile).Length / 1MB
    Write-Host "✓ 后端 JAR 文件: $([math]::Round($jarSize, 2)) MB" -ForegroundColor Green
} else {
    Write-Host "✗ 未找到后端 JAR 文件" -ForegroundColor Red
    exit 1
}

Write-Host ""

# 3. 编译前端
Write-Host "3. 编译前端..." -ForegroundColor Yellow
Push-Location ruoyi-ui

# 检查 node_modules
if (-not (Test-Path "node_modules")) {
    Write-Host "安装前端依赖..." -ForegroundColor Yellow
    npm install
}

# 构建前端
$env:NODE_OPTIONS="--max_old_space_size=4096"
npm run build:prod

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 前端编译成功" -ForegroundColor Green
} else {
    Write-Host "✗ 前端编译失败" -ForegroundColor Red
    Pop-Location
    exit 1
}

Pop-Location

# 复制前端文件
if (Test-Path "ruoyi-ui\dist") {
    Copy-Item -Recurse "ruoyi-ui\dist" "$packageDir\frontend\dist"
    $fileCount = (Get-ChildItem -Recurse "ruoyi-ui\dist").Count
    Write-Host "✓ 前端文件: $fileCount 个" -ForegroundColor Green
} else {
    Write-Host "✗ 未找到前端编译文件" -ForegroundColor Red
    exit 1
}

Write-Host ""

# 4. 导出数据库
Write-Host "4. 导出数据库..." -ForegroundColor Yellow

if (Test-Path "database_backup.dump") {
    Copy-Item "database_backup.dump" "$packageDir\database\database_backup.dump"
    $dbSize = (Get-Item "database_backup.dump").Length / 1MB
    Write-Host "✓ 数据库备份: $([math]::Round($dbSize, 2)) MB" -ForegroundColor Green
} else {
    Write-Host "✗ 未找到数据库备份文件，正在导出..." -ForegroundColor Yellow
    $env:PGPASSWORD = "mm5621528"
    pg_dump -h localhost -p 5432 -U postgres -d ry_vue -F c -b -v -f "$packageDir\database\database_backup.dump"
    
    if ($LASTEXITCODE -eq 0) {
        $dbSize = (Get-Item "$packageDir\database\database_backup.dump").Length / 1MB
        Write-Host "✓ 数据库导出成功: $([math]::Round($dbSize, 2)) MB" -ForegroundColor Green
    } else {
        Write-Host "✗ 数据库导出失败" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""

# 5. 创建部署说明
Write-Host "5. 创建部署说明..." -ForegroundColor Yellow

$readme = @"
# 课程选课系统 - 服务器部署包

## 部署时间
$timestamp

## 服务器要求

- 操作系统: CentOS 7
- 已安装: 宝塔面板
- 已安装: Docker
- Docker 容器: PostgreSQL (端口 5432)
- Docker 容器: Redis (端口 6379)
- 已安装: Java 1.8+
- 已安装: Nginx

## 快速部署

### 1. 上传部署包

将整个 ``deploy-server`` 目录上传到服务器任意位置，例如:
``````bash
/root/deploy-server
``````

### 2. 执行部署脚本

``````bash
cd /root/deploy-server
chmod +x deploy.sh
./deploy.sh
``````

脚本会自动完成以下操作:
1. 检查系统环境
2. 创建目录结构
3. 部署后端应用
4. 部署前端应用
5. 导入数据库（自动删除旧数据库）
6. 配置 Nginx
7. 创建管理脚本
8. 启动后端服务

### 3. 访问系统

部署完成后，通过浏览器访问:
- 前端: http://服务器IP
- 后端: http://服务器IP:8080

默认账号:
- 管理员: admin / admin123
- 学生: 学号 / 123456
- 教师: 工号 / 123456

## 管理命令

部署完成后，可以使用以下命令管理后端服务:

``````bash
# 启动
/www/wwwroot/course-selection/backend/start.sh

# 停止
/www/wwwroot/course-selection/backend/stop.sh

# 重启
/www/wwwroot/course-selection/backend/restart.sh

# 查看日志
tail -f /www/wwwroot/course-selection/logs/backend.log
``````

## 目录结构

``````
/www/wwwroot/course-selection/
├── backend/              # 后端应用
│   ├── ruoyi-admin.jar  # 后端 JAR 文件
│   ├── start.sh         # 启动脚本
│   ├── stop.sh          # 停止脚本
│   ├── restart.sh       # 重启脚本
│   └── app.pid          # 进程 PID 文件
├── frontend/            # 前端静态文件
│   └── dist/           # 前端编译文件
├── logs/               # 日志目录
│   ├── backend.log     # 后端日志
│   ├── nginx_access.log # Nginx 访问日志
│   └── nginx_error.log  # Nginx 错误日志
└── database/           # 数据库备份
    └── database_backup.dump
``````

## 数据库配置

- 数据库名: school-course
- 用户名: postgres
- 密码: mm5621528
- 端口: 5432

## Redis 配置

- 主机: localhost
- 端口: 6379
- 密码: 无

## 端口说明

- 80: 前端访问端口（Nginx）
- 8080: 后端 API 端口
- 5432: PostgreSQL 端口
- 6379: Redis 端口

## 故障排查

### 1. 后端启动失败

查看日志:
``````bash
tail -f /www/wwwroot/course-selection/logs/backend.log
``````

常见原因:
- PostgreSQL 未启动
- Redis 未启动
- 端口 8080 被占用
- 数据库连接失败

### 2. 前端无法访问

检查:
- Nginx 是否运行: ``systemctl status nginx``
- Nginx 配置是否正确: ``nginx -t``
- 后端是否启动

### 3. 数据库导入失败

手动导入:
``````bash
# 查找 PostgreSQL 容器
docker ps | grep postgres

# 手动导入（替换容器名）
docker exec -i <容器名> pg_restore -U postgres -d school-course -v < database/database_backup.dump
``````

## 更新部署

如需更新应用:

1. 停止后端服务:
   ``````bash
   /www/wwwroot/course-selection/backend/stop.sh
   ``````

2. 替换文件:
   - 后端: 替换 ``/www/wwwroot/course-selection/backend/ruoyi-admin.jar``
   - 前端: 替换 ``/www/wwwroot/course-selection/frontend/dist/`` 目录

3. 启动后端服务:
   ``````bash
   /www/wwwroot/course-selection/backend/start.sh
   ``````

## 备份建议

定期备份以下内容:
1. 数据库: 使用 pg_dump 导出
2. 上传文件: ``/www/wwwroot/course-selection/backend/uploadPath/``
3. 配置文件: Nginx 配置

## 安全建议

1. 修改默认密码
2. 配置防火墙规则
3. 启用 HTTPS（使用宝塔面板配置 SSL）
4. 定期更新系统和应用

## 技术支持

如有问题，请查看:
- 后端日志: ``/www/wwwroot/course-selection/logs/backend.log``
- Nginx 日志: ``/www/wwwroot/course-selection/logs/nginx_*.log``
- 系统日志: ``/var/log/messages``
"@

$readme | Out-File -FilePath "$packageDir\README.md" -Encoding UTF8
Write-Host "✓ 部署说明创建完成" -ForegroundColor Green
Write-Host ""

# 6. 打包
Write-Host "6. 打包部署文件..." -ForegroundColor Yellow

if (Test-Path "$packageName.zip") {
    Remove-Item "$packageName.zip" -Force
}

# 使用 PowerShell 压缩
Compress-Archive -Path "$packageDir\*" -DestinationPath "$packageName.zip" -Force

if (Test-Path "$packageName.zip") {
    $zipSize = (Get-Item "$packageName.zip").Length / 1MB
    Write-Host "✓ 部署包创建成功: $([math]::Round($zipSize, 2)) MB" -ForegroundColor Green
} else {
    Write-Host "✗ 打包失败" -ForegroundColor Red
    exit 1
}

Write-Host ""

# 7. 完成
Write-Host "========================================" -ForegroundColor Green
Write-Host "构建完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "部署包: $packageName.zip" -ForegroundColor Cyan
Write-Host "大小: $([math]::Round($zipSize, 2)) MB" -ForegroundColor Cyan
Write-Host ""
Write-Host "部署步骤:" -ForegroundColor Yellow
Write-Host "1. 上传 $packageName.zip 到服务器" -ForegroundColor White
Write-Host "2. 解压: unzip $packageName.zip" -ForegroundColor White
Write-Host "3. 进入目录: cd deploy-server" -ForegroundColor White
Write-Host "4. 执行部署: chmod +x deploy.sh && ./deploy.sh" -ForegroundColor White
Write-Host ""
