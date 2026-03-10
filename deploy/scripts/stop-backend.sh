#!/bin/bash
# 停止后端服务脚本

BACKEND_DIR="/www/wwwroot/course-selection/backend"
PID_FILE="$BACKEND_DIR/backend.pid"

cd "$BACKEND_DIR"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p $PID > /dev/null 2>&1; then
        echo "停止后端服务 (PID: $PID)..."
        kill $PID
        
        # 等待进程结束
        for i in {1..10}; do
            if ! ps -p $PID > /dev/null 2>&1; then
                echo "后端服务已停止"
                rm "$PID_FILE"
                exit 0
            fi
            sleep 1
        done
        
        # 强制停止
        echo "强制停止后端服务..."
        kill -9 $PID
        rm "$PID_FILE"
        echo "后端服务已强制停止"
    else
        echo "后端服务未运行"
        rm "$PID_FILE"
    fi
else
    # 尝试通过进程名停止
    if pgrep -f "ruoyi-admin.jar" > /dev/null; then
        echo "通过进程名停止后端服务..."
        pkill -f "ruoyi-admin.jar"
        echo "后端服务已停止"
    else
        echo "后端服务未运行"
    fi
fi
