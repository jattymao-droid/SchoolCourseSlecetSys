# Nginx配置问题修复指南

## 🔴 当前错误

```
nginx: [emerg] open() "/www/wwwroot/course-selection/logs/nginx_access.log" failed (2: No such file or directory)
nginx: [warn] conflicting server name "_" on 0.0.0.0:80, ignored
```

## 🔧 快速修复方案

### 方案一：创建缺失的日志目录（推荐）

在服务器上执行：

```bash
# 创建日志目录
mkdir -p /www/wwwroot/course-selection/logs
mkdir -p /www/wwwlogs

# 创建日志文件
touch /www/wwwlogs/xk.xmls.vip.log
touch /www/wwwlogs/xk.xmls.vip.error.log

# 设置权限
chmod 755 /www/wwwroot/course-selection/logs
chmod 755 /www/wwwlogs
chmod 644 /www/wwwlogs/*.log

# 测试Nginx配置
nginx -t

# 重启Nginx
systemctl reload nginx
```

### 方案二：使用修复脚本

已为你创建了自动修复脚本 `fix-nginx-logs.sh`

```bash
# 上传脚本到服务器
scp fix-nginx-logs.sh root@your-server:/root/

# 在服务器上执行
chmod +x /root/fix-nginx-logs.sh
/root/fix-nginx-logs.sh
```

### 方案三：修改Nginx配置使用宝塔默认日志路径

在宝塔面板中，网站设置 → 配置文件，找到日志配置部分，修改为：

```nginx
# 日志配置
access_log /www/wwwlogs/xk.xmls.vip.log;
error_log /www/wwwlogs/xk.xmls.vip.error.log;
```

## 📝 详细说明

### 问题1：日志目录不存在

**原因**：Nginx配置中指定的日志文件路径不存在

**解决方法**：
1. 创建对应的目录
2. 或修改配置使用已存在的目录（如 `/www/wwwlogs`）

### 问题2：server_name冲突

**原因**：多个server块使用了相同的 `server_name "_"`

**解决方法**：
1. 使用具体的域名代替 `_`
2. 或删除其他使用 `_` 的server块

## 🎯 推荐配置

已为你创建了简化版配置文件 `nginx-baota-simple.conf`

**使用方法：**

1. 在宝塔面板中打开网站设置
2. 点击"配置文件"
3. 将 `nginx-baota-simple.conf` 的内容复制粘贴进去
4. 保存并重启Nginx

## ✅ 验证步骤

修复后，按以下步骤验证：

```bash
# 1. 测试Nginx配置
nginx -t

# 2. 查看Nginx状态
systemctl status nginx

# 3. 重启Nginx
systemctl reload nginx

# 4. 检查日志文件是否创建
ls -la /www/wwwlogs/xk.xmls.vip.*

# 5. 测试网站访问
curl -I http://xk.xmls.vip
curl -I https://xk.xmls.vip
```

## 🔍 常见问题

### Q1: 日志文件权限问题

```bash
# 设置正确的权限
chown -R www:www /www/wwwlogs
chmod 755 /www/wwwlogs
chmod 644 /www/wwwlogs/*.log
```

### Q2: SSL证书路径错误

如果SSL证书路径不存在，可以：
1. 在宝塔面板中重新申请SSL证书
2. 或临时注释掉SSL相关配置，只使用HTTP

### Q3: 后端服务无法访问

```bash
# 检查后端服务是否运行
ps aux | grep ruoyi-admin.jar

# 检查端口是否监听
netstat -tlnp | grep 8080

# 测试后端API
curl http://localhost:8080
```

## 📋 完整的Nginx配置检查清单

- [ ] 日志目录存在且有写权限
- [ ] SSL证书文件存在（如果使用HTTPS）
- [ ] server_name配置正确
- [ ] 后端代理地址正确（http://127.0.0.1:8080）
- [ ] 前端文件路径正确（/www/wwwroot/course-selection/frontend）
- [ ] 没有语法错误（nginx -t 通过）
- [ ] Nginx服务正常运行

## 🚀 快速命令参考

```bash
# 测试配置
nginx -t

# 重启Nginx
systemctl reload nginx

# 查看Nginx状态
systemctl status nginx

# 查看Nginx错误日志
tail -f /www/wwwlogs/xk.xmls.vip.error.log

# 查看Nginx访问日志
tail -f /www/wwwlogs/xk.xmls.vip.log

# 查看Nginx进程
ps aux | grep nginx

# 强制重启Nginx
systemctl restart nginx
```

## 💡 建议

1. **使用宝塔面板的默认日志路径** `/www/wwwlogs`，这样不容易出错
2. **定期清理日志文件**，防止占用过多磁盘空间
3. **配置日志轮转**，自动管理日志文件大小
4. **备份配置文件**，修改前先备份

## 📞 如果问题仍未解决

1. 查看完整的Nginx错误日志：`tail -100 /www/server/nginx/logs/error.log`
2. 检查宝塔面板的错误日志
3. 确认前端文件是否已正确部署到 `/www/wwwroot/course-selection/frontend`
4. 确认后端服务是否正常运行

---

**修复完成后，记得测试网站是否可以正常访问！**
