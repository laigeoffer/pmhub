#!/bin/bash
# pmhub单体服务启动脚本

# JAR包名称
APP_NAME="pmhub-admin.jar"
# JAR包路径
APP_PATH="/opt/laigeoffer/pmhub/pmhub-boot"
# 完整的JAR包路径
JAR_PATH="$APP_PATH/$APP_NAME"
# 日志文件路径
LOG_PATH="$APP_PATH/logs"
# PID文件路径
PID_FILE="$APP_PATH/pmhub.pid"
# JVM参数
JVM_OPTS="-Xms512m -Xmx1024m"
# 环境配置
PROFILE="prod"

# 如果日志目录不存在，创建它
if [ ! -d "$LOG_PATH" ]; then
    mkdir -p "$LOG_PATH"
fi

# 获取进程PID
get_pid() {
    if [ -f "$PID_FILE" ]; then
        cat "$PID_FILE"
    fi
}

# 启动服务
start() {
    pid=$(get_pid)
    if [ -n "$pid" ] && kill -0 $pid >/dev/null 2>&1; then
        echo "$APP_NAME is already running with pid $pid"
        return
    fi
    
    echo "Starting $APP_NAME ..."
    nohup java $JVM_OPTS -jar $JAR_PATH --spring.profiles.active=$PROFILE > "$LOG_PATH/startup.log" 2>&1 &
    echo $! > "$PID_FILE"
    echo "$APP_NAME started with pid $!"
    echo "You can check the log file at $LOG_PATH/startup.log"
}

# 停止服务
stop() {
    pid=$(get_pid)
    if [ -z "$pid" ]; then
        echo "$APP_NAME is not running"
        return
    fi
    
    echo "Stopping $APP_NAME ..."
    kill $pid
    rm -f "$PID_FILE"
    echo "$APP_NAME stopped"
}

# 重启服务
restart() {
    stop
    sleep 2
    start
}

# 查看服务状态
status() {
    pid=$(get_pid)
    if [ -n "$pid" ] && kill -0 $pid >/dev/null 2>&1; then
        echo "$APP_NAME is running with pid $pid"
    else
        echo "$APP_NAME is not running"
    fi
}

# 根据输入参数执行相应操作
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac

exit 0