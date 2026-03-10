# 修复宝塔 Nginx 配置错误

## 问题原因

宝塔面板检测到 Nginx 配置文件存在语法错误，可能的原因：
1. SSL 证书路径不存在（证书还未申请）
2. include 引用的文件不存在
3. 配置文件中有宝塔不识别的指令

## 解决方案：使用最简配置

### 步骤 1：清空现有配置

1. 登录宝塔面板
2. 进入"网站" -> 找到 `xk.xmls.vip`
3. 点击"设置" -> "配置文件"
4. **全选并删除**现有的所有配置内容

### 步骤 2：粘贴最简配置

复制以下配置，粘贴到配置文件编辑框中：

```nginx
server {
    listen 80;
    server_name xk.xmls.vip;
    index index.html;
    root /www/wwwroot/xk.xmls.vip/frontend;
    
    # API 代理到后端服务
    location /prod-api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    
    # 前端路由支持
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    access_log /www/wwwlogs/xk.xmls.vip.log;
    error_log /www/wwwlogs/xk.xmls.vip.error.log;
}
```

### 步骤 3：保存配置

点击"保存"按钮，这次应该能成功保存。

### 步骤 4：验证配置

```bash
# 测试 Nginx 配置语法
nginx -t

# 如果显示 "syntax is ok" 和 "test is successful"，则重载 Nginx
nginx -s reload
```

## 配置说明

这个最简配置：
- ✅ 只监听 HTTP 80 端口（暂不配置 HTTPS）
- ✅ 前端文件路径：`/www/wwwroot/xk.xmls.vip/frontend`
- ✅ 后端 API 代理：`/prod-api/` -> `http://127.0.0.1:8080/`
- ✅ 支持 Vue Router 的 history 模式
- ✅ 日志文件：`/www/wwwlogs/xk.xmls.vip.log`

## 后续配置 HTTPS（可选）

等基本功能测试通过后，再通过宝塔面板申请 SSL 证书：

1. 在网站设置中，点击"SSL"
2. 选择"Let's Encrypt"
3. 点击"申请"
4. 申请成功后，宝塔会自动添加 SSL 配置

## 测试步骤

### 1. 确认后端已启动

```bash
# 检查后端是否在运行
curl http://127.0.0.1:8080

# 应该返回 HTML 或 JSON 响应
```

### 2. 访问前端

在浏览器中访问：`http://xk.xmls.vip`

应该能看到登录页面。

### 3. 测试 API 代理

在浏览器开发者工具中，查看网络请求：
- 前端请求：`http://xk.xmls.vip/prod-api/login`
- 实际代理到：`http://127.0.0.1:8080/login`

## 常见问题

### Q1: 保存后仍然提示错误

**解决方法**：
1. 检查是否有多余的空格或特殊字符
2. 确保使用的是纯文本编辑器复制的配置
3. 尝试在宝塔面板中"重置配置"，然后再粘贴

### Q2: 访问网站显示 502 Bad Gateway

**原因**：后端服务未启动或端口不对

**解决方法**：
```bash
# 检查后端是否在运行
curl http://127.0.0.1:8080

# 如果没有响应，启动后端
cd /www/wwwroot/xk.xmls.vip/backend
./start.sh
```

### Q3: 访问网站显示 404 Not Found

**原因**：前端文件路径不对

**解决方法**：
```bash
# 检查前端文件是否存在
ls -la /www/wwwroot/xk.xmls.vip/frontend/index.html

# 如果不存在，检查部署包是否正确上传
```

### Q4: 前端页面显示，但 API 请求失败

**原因**：API 代理配置问题或后端未启动

**解决方法**：
1. 检查后端日志：`tail -f /www/wwwroot/xk.xmls.vip/backend/backend.log`
2. 检查 Nginx 错误日志：`tail -f /www/wwwlogs/xk.xmls.vip.error.log`
3. 测试后端直接访问：`curl http://127.0.0.1:8080/login`

## 完整部署检查清单

- [ ] 1. 后端 JAR 包已上传到 `/www/wwwroot/xk.xmls.vip/backend/ruoyi-admin.jar`
- [ ] 2. 前端文件已上传到 `/www/wwwroot/xk.xmls.vip/frontend/`
- [ ] 3. 后端服务已启动（`./start.sh`）
- [ ] 4. 后端启动成功（查看日志确认）
- [ ] 5. Nginx 配置已保存（使用最简配置）
- [ ] 6. Nginx 已重载（`nginx -s reload`）
- [ ] 7. 可以访问前端页面（`http://xk.xmls.vip`）
- [ ] 8. API 请求正常（浏览器开发者工具查看）

## 下一步

配置保存成功后，按照以下顺序测试：

1. **测试后端**：`curl http://127.0.0.1:8080`
2. **测试前端**：访问 `http://xk.xmls.vip`
3. **测试登录**：使用默认账号登录（admin/admin123）
4. **申请 SSL**：在宝塔面板中申请 Let's Encrypt 证书
5. **启用 HTTPS**：宝塔会自动配置 HTTPS 跳转

## 需要帮助？

如果还有问题，请提供：
1. 宝塔面板显示的具体错误信息
2. Nginx 错误日志：`cat /www/wwwlogs/xk.xmls.vip.error.log`
3. 后端启动日志：`cat /www/wwwroot/xk.xmls.vip/backend/backend.log`
