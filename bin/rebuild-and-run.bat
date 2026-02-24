@echo off
echo 正在重新编译后端...
cd /d %~dp0..
call mvn clean package -DskipTests -pl ruoyi-admin -am -q
if %errorlevel% neq 0 (
  echo 编译失败，请确保 Maven 已安装并加入 PATH
  pause
  exit /b 1
)
echo 编译成功，正在启动后端...
cd ruoyi-admin\target
set JAVA_OPTS=-Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m
start "RuoYi-Backend" java %JAVA_OPTS% -jar ruoyi-admin.jar
echo 后端已在新窗口启动，端口 8080
pause
