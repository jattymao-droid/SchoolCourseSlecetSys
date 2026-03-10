# 后端 Dockerfile
FROM openjdk:8-jre-alpine

# 设置工作目录
WORKDIR /app

# 复制 JAR 文件
COPY ruoyi-admin.jar /app/app.jar

# 设置时区
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

# 暴露端口
EXPOSE 8080

# 启动应用
ENTRYPOINT ["java", "-jar", "/app/app.jar", "--spring.profiles.active=prod"]
