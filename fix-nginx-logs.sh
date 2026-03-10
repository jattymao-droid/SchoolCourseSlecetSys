#!/bin/bash
# 修复Nginx日志目录问题

echo "正在修复Nginx日志目录问题..."

# 创建日志目录
mkdir -p /www/wwwlogs
mkdir -p /www/wwwroot/course-selection/logs

# 设置权限
chmod 755 /www/wwwlogs
chmod 755 /www/wwwroot/course-selection/logs

# 创建日志文件
touch /www/wwwlogs/xk.xmls.vip.log
touch /www/wwwlogs/xk.xmls.vip.error.log
touch /www/wwwlogs/course-selection-access.log
touch /www/wwwlogs/course-selection-error.log

# 设置日志文件权限
chmod 644 /www/wwwlogs/*.log

echo "日志目录和文件已创建"
echo "测试Nginx配置..."

# 测试Nginx配置
nginx -t

if [ $? -eq 0 ]; then
    echo "Nginx配置测试通过！"
    echo "重启Nginx..."
    systemctl reload nginx
    echo "Nginx已重启"
else
    echo "Nginx配置测试失败，请检查配置文件"
    exit 1
fi
