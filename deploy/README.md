# School Course Selection System - Production Deployment Package

Build Time: 20260309_233957

## Directory Structure

```
deploy/
鈹溾攢鈹€ backend/              # Backend JAR file
鈹?  鈹斺攢鈹€ ruoyi-admin.jar
鈹溾攢鈹€ frontend/             # Frontend static files
鈹?  鈹溾攢鈹€ index.html
鈹?  鈹斺攢鈹€ static/
鈹溾攢鈹€ scripts/              # Deployment scripts
鈹?  鈹溾攢鈹€ deploy.sh        # One-click deployment script
鈹?  鈹溾攢鈹€ start-backend.sh # Start backend service
鈹?  鈹溾攢鈹€ stop-backend.sh  # Stop backend service
鈹?  鈹斺攢鈹€ nginx.conf       # Nginx configuration
鈹斺攢鈹€ sql/                  # Database files
    鈹溾攢鈹€ schema.sql       # Database schema
    鈹溾攢鈹€ data.sql         # Database data
    鈹斺攢鈹€ full_backup.sql  # Full backup
```

## Server Requirements

- CentOS 7
- Docker (installed)
- PostgreSQL (Docker container, port 5432, password: mm5621528)
- Redis (Docker container, port 6379, no password)
- BT Panel (installed)
- Java 8 or higher

## Quick Deployment Steps

### 1. Upload deployment package to server

```bash
# Upload the entire deploy directory to server, for example:
scp -r deploy root@your-server:/opt/
```

### 2. Execute one-click deployment script

```bash
cd /opt/deploy/scripts
chmod +x deploy.sh
./deploy.sh
```

### 3. Access the system

- Frontend URL: http://your-server-ip
- Backend API: http://your-server-ip:8080
- Default account: admin / admin123

## Manual Deployment Steps

If the one-click deployment script encounters issues, follow these manual steps:

### 1. Restore Database

```bash
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
```

### 2. Start Backend Service

```bash
cd /opt/deploy/backend

# Start in background
nohup java -jar ruoyi-admin.jar --spring.profiles.active=prod > backend.log 2>&1 &

# View logs
tail -f backend.log
```

### 3. Configure Nginx (using BT Panel)

In BT Panel:
1. Create new website
2. Set website root directory to: /opt/deploy/frontend
3. Configure reverse proxy:
   - Proxy name: backend-api
   - Target URL: http://127.0.0.1:8080
   - Send domain: $host
   - Proxy path: /prod-api

Or use the provided nginx.conf configuration file.

## Service Management

### Start Service
```bash
cd /opt/deploy/scripts
./start-backend.sh
```

### Stop Service
```bash
cd /opt/deploy/scripts
./stop-backend.sh
```

### View Logs
```bash
tail -f /opt/deploy/backend/backend.log
```

## Troubleshooting

### Backend Cannot Start
1. Check Java version: java -version
2. Check port usage: 
etstat -tlnp | grep 8080
3. View logs: 	ail -f /opt/deploy/backend/backend.log

### Database Connection Failed
1. Check PostgreSQL container status: docker ps | grep postgres
2. Test database connection: docker exec -it postgres_container psql -U postgres -d school-course
3. Confirm database password is correct

### Redis Connection Failed
1. Check Redis container status: docker ps | grep redis
2. Test Redis connection: docker exec -it redis_container redis-cli ping

## Technical Support

If you have any questions, please check the log files or contact technical support.
