#!/bin/bash
# 启动后端服务脚本

BACKEND_DIR="/www/wwwroot/course-selection/backend"
JAR_FILE="$BACKEND_DIR/ruoyi-admin.jar"
PID_FILE="$BACKEND_DIR/backend.pid"
LOG_FILE="$BACKEND_DIR/backend.log"

cd "$BACKEND_DIR"

# 检查是否已经运行
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null 2>&1; then
        echo "后端服务已在运行中 (PID: $PID)"
        exit 0
    else
        echo "清理旧的PID文件..."
        rm "$PID_FILE"
    fi
fi

# 启动服务
echo "启动后端服务..."
nohup java -jar "$JAR_FILE" --spring.profiles.active=prod > "$LOG_FILE" 2>&1 &
echo $! > "$PID_FILE"

sleep 3

# 验证启动
if ps -p $(cat "$PID_FILE") > /dev/null 2>&1; then
    echo "后端服务启动成功！"
    echo "PID: $(cat $PID_FILE)"
    echo "日志文件: $LOG_FILE"
else
    echo "后端服务启动失败，请查看日志: $LOG_FILE"
    exit 1
fi
