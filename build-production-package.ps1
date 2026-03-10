# Production Build and Package Script
# Purpose: Build backend JAR and frontend static files, package to deploy directory

$ErrorActionPreference = "Stop"
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$deployDir = "deploy"
$backendDir = "$deployDir/backend"
$frontendDir = "$deployDir/frontend"
$scriptsDir = "$deployDir/scripts"
$sqlDir = "$deployDir/sql"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Building Production Deployment Package" -ForegroundColor Cyan
Write-Host "Timestamp: $timestamp" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Clean old deploy directory
if (Test-Path $deployDir) {
    Write-Host "Cleaning old deployment directory..." -ForegroundColor Yellow
    Remove-Item -Path $deployDir -Recurse -Force
}

# Create directory structure
Write-Host "Creating deployment directory structure..." -ForegroundColor Green
New-Item -ItemType Directory -Path $backendDir -Force | Out-Null
New-Item -ItemType Directory -Path $frontendDir -Force | Out-Null
New-Item -ItemType Directory -Path $scriptsDir -Force | Out-Null
New-Item -ItemType Directory -Path $sqlDir -Force | Out-Null

# 1. Build Backend
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Step 1/4: Building Backend Spring Boot Application" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "Cleaning Maven cache..." -ForegroundColor Yellow
& mvn clean -q

Write-Host "Starting Maven package (production profile)..." -ForegroundColor Yellow
& mvn package -Pprod -DskipTests

if ($LASTEXITCODE -ne 0) {
    Write-Host "Backend build failed!" -ForegroundColor Red
    exit 1
}

# Copy backend JAR
$jarFile = "ruoyi-admin/target/ruoyi-admin.jar"
if (Test-Path $jarFile) {
    Write-Host "Copying backend JAR to deployment directory..." -ForegroundColor Green
    Copy-Item -Path $jarFile -Destination "$backendDir/ruoyi-admin.jar"
    Write-Host "Backend build completed!" -ForegroundColor Green
} else {
    Write-Host "Error: JAR file not found at $jarFile" -ForegroundColor Red
    exit 1
}

# 2. Build Frontend
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Step 2/4: Building Frontend Vue Application" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Push-Location ruoyi-ui

Write-Host "Installing frontend dependencies..." -ForegroundColor Yellow
& npm install

if ($LASTEXITCODE -ne 0) {
    Write-Host "Frontend dependency installation failed!" -ForegroundColor Red
    Pop-Location
    exit 1
}

Write-Host "Starting frontend build..." -ForegroundColor Yellow
& npm run build:prod

if ($LASTEXITCODE -ne 0) {
    Write-Host "Frontend build failed!" -ForegroundColor Red
    Pop-Location
    exit 1
}

Pop-Location

# Copy frontend build artifacts
if (Test-Path "ruoyi-ui/dist") {
    Write-Host "Copying frontend static files to deployment directory..." -ForegroundColor Green
    Copy-Item -Path "ruoyi-ui/dist/*" -Destination $frontendDir -Recurse
    Write-Host "Frontend build completed!" -ForegroundColor Green
} else {
    Write-Host "Error: Frontend build directory not found at ruoyi-ui/dist" -ForegroundColor Red
    exit 1
}

# 3. Export Database
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Step 3/4: Exporting Database Schema and Data" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$dbName = "ry-vue"
$dbUser = "postgres"
$dbPassword = "mm5621528"
$dbHost = "localhost"
$dbPort = "5432"

$env:PGPASSWORD = $dbPassword

Write-Host "Exporting database schema..." -ForegroundColor Yellow
& pg_dump -h $dbHost -p $dbPort -U $dbUser -d $dbName --schema-only -f "$sqlDir/schema.sql" 2>$null

Write-Host "Exporting database data..." -ForegroundColor Yellow
& pg_dump -h $dbHost -p $dbPort -U $dbUser -d $dbName --data-only -f "$sqlDir/data.sql" 2>$null

Write-Host "Exporting full database backup..." -ForegroundColor Yellow
& pg_dump -h $dbHost -p $dbPort -U $dbUser -d $dbName -f "$sqlDir/full_backup.sql" 2>$null

$env:PGPASSWORD = $null

if (Test-Path "$sqlDir/full_backup.sql") {
    Write-Host "Database export completed!" -ForegroundColor Green
} else {
    Write-Host "Warning: Database export may have failed. Please check if PostgreSQL is installed and configured correctly" -ForegroundColor Yellow
}

# 4. Create Deployment Scripts
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Step 4/4: Generating Deployment Scripts and Configuration Files" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "Generating deployment scripts..." -ForegroundColor Yellow

# Copy deployment scripts
Copy-Item -Path "deploy-server.sh" -Destination "$scriptsDir/deploy.sh" -ErrorAction SilentlyContinue
Copy-Item -Path "start-backend.sh" -Destination "$scriptsDir/start-backend.sh" -ErrorAction SilentlyContinue
Copy-Item -Path "stop-backend.sh" -Destination "$scriptsDir/stop-backend.sh" -ErrorAction SilentlyContinue
Copy-Item -Path "nginx.conf" -Destination "$scriptsDir/nginx.conf" -ErrorAction SilentlyContinue

# Create README
$readmeContent = @"
# School Course Selection System - Production Deployment Package

Build Time: $timestamp

## Directory Structure

``````
deploy/
├── backend/              # Backend JAR file
│   └── ruoyi-admin.jar
├── frontend/             # Frontend static files
│   ├── index.html
│   └── static/
├── scripts/              # Deployment scripts
│   ├── deploy.sh        # One-click deployment script
│   ├── start-backend.sh # Start backend service
│   ├── stop-backend.sh  # Stop backend service
│   └── nginx.conf       # Nginx configuration
└── sql/                  # Database files
    ├── schema.sql       # Database schema
    ├── data.sql         # Database data
    └── full_backup.sql  # Full backup
``````

## Server Requirements

- CentOS 7
- Docker (installed)
- PostgreSQL (Docker container, port 5432, password: mm5621528)
- Redis (Docker container, port 6379, no password)
- BT Panel (installed)
- Java 8 or higher

## Quick Deployment Steps

### 1. Upload deployment package to server

``````bash
# Upload the entire deploy directory to server, for example:
scp -r deploy root@your-server:/opt/
``````

### 2. Execute one-click deployment script

``````bash
cd /opt/deploy/scripts
chmod +x deploy.sh
./deploy.sh
``````

### 3. Access the system

- Frontend URL: http://your-server-ip
- Backend API: http://your-server-ip:8080
- Default account: admin / admin123

## Manual Deployment Steps

If the one-click deployment script encounters issues, follow these manual steps:

### 1. Restore Database

``````bash
cd /opt/deploy/sql

# Set password environment variable
export PGPASSWORD=mm5621528

# Create database
docker exec -i postgres_container psql -U postgres -c "CREATE DATABASE \"school-course\";"

# Restore database
docker exec -i postgres_container psql -U postgres -d school-course < full_backup.sql

# Or import schema and data separately
docker exec -i postgres_container psql -U postgres -d school-course < schema.sql
docker exec -i postgres_container psql -U postgres -d school-course < data.sql
``````

### 2. Start Backend Service

``````bash
cd /opt/deploy/backend

# Start in background
nohup java -jar ruoyi-admin.jar --spring.profiles.active=prod > backend.log 2>&1 &

# View logs
tail -f backend.log
``````

### 3. Configure Nginx (using BT Panel)

In BT Panel:
1. Create new website
2. Set website root directory to: /opt/deploy/frontend
3. Configure reverse proxy:
   - Proxy name: backend-api
   - Target URL: http://127.0.0.1:8080
   - Send domain: `$host`
   - Proxy path: /prod-api

Or use the provided nginx.conf configuration file.

## Service Management

### Start Service
``````bash
cd /opt/deploy/scripts
./start-backend.sh
``````

### Stop Service
``````bash
cd /opt/deploy/scripts
./stop-backend.sh
``````

### View Logs
``````bash
tail -f /opt/deploy/backend/backend.log
``````

## Troubleshooting

### Backend Cannot Start
1. Check Java version: `java -version`
2. Check port usage: `netstat -tlnp | grep 8080`
3. View logs: `tail -f /opt/deploy/backend/backend.log`

### Database Connection Failed
1. Check PostgreSQL container status: `docker ps | grep postgres`
2. Test database connection: `docker exec -it postgres_container psql -U postgres -d school-course`
3. Confirm database password is correct

### Redis Connection Failed
1. Check Redis container status: `docker ps | grep redis`
2. Test Redis connection: `docker exec -it redis_container redis-cli ping`

## Technical Support

If you have any questions, please check the log files or contact technical support.
"@

Set-Content -Path "$deployDir/README.md" -Value $readmeContent -Encoding UTF8

Write-Host "Deployment documentation generated!" -ForegroundColor Green

# Complete
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Deployment package build completed!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Deployment package location: $deployDir" -ForegroundColor Yellow
Write-Host "Please read $deployDir/README.md for deployment instructions" -ForegroundColor Yellow
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Upload $deployDir directory to server" -ForegroundColor White
Write-Host "2. On server, execute: cd /opt/deploy/scripts && chmod +x deploy.sh && ./deploy.sh" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
