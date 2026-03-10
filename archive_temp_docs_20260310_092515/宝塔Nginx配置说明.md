# 宝塔面板 Nginx 配置说明

## 配置文件位置

已提供两个配置文件：
1. `deploy/nginx-baota-config.conf` - 完整版配置
2. `宝塔Nginx配置-简化版.conf` - 简化版配置（推荐）

## 配置步骤

### 方法一：使用宝塔面板界面配置（推荐）

1. 登录宝塔面板
2. 进入"网站"管理
3. 找到 `xk.xmls.vip` 网站，点击"设置"
4. 点击"配置文件"标签
5. 复制下面的配置内容，替换整个配置文件
6. 点击"保存"

### 推荐配置内容（复制以下内容）

```nginx
server {
    listen 80;
    listen 443 ssl http2;
    server_name xk.xmls.vip;
    index index.html index.htm;
    root /www/wwwroot/xk.xmls.vip/frontend;
    
    #CERT-APPLY-CHECK--START
    include /www/server/panel/vhost/nginx/well-known/xk.xmls.vip.conf;
    #CERT-APPLY-CHECK--END
    
    #SSL-START
    ssl_certificate /www/server/panel/vhost/cert/xk.xmls.vip/fullchain.pem;
    ssl_certificate_key /www/server/panel/vhost/cert/xk.xmls.vip/privkey.pem;
    ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
    ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;
    add_header Strict-Transport-Security "max-age=31536000";
    error_page 497 https://$host$request_uri;
    #SSL-END
    
    #HTTP_TO_HTTPS_START
    if ($server_port !~ 443){
        rewrite ^(/.*)$ https://$host$1 permanent;
    }
    #HTTP_TO_HTTPS_END
    
    #REWRITE-START
    include /www/server/panel/vhost/rewrite/xk.xmls.vip.conf;
    #REWRITE-END
    
    # API 代理到后端服务
    location /prod-api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    
    # 前端路由支持
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # 一键申请SSL证书验证目录
    location ~ \.well-known {
        allow all;
    }
    
    # 静态文件缓存
    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf)$ {
        expires 30d;
        error_log /dev/null;
        access_log /dev/null;
    }
    
    location ~ .*\.(js|css)?$ {
        expires 12h;
        error_log /dev/null;
        access_log /dev/null;
    }
    
    access_log /www/wwwlogs/xk.xmls.vip.log;
    error_log /www/wwwlogs/xk.xmls.vip.error.log;
}
```

## 配置说明

### 关键配置项

1. **网站根目录**
   ```nginx
   root /www/wwwroot/xk.xmls.vip/frontend;
   ```
   前端静态文件存放在 `frontend` 子目录

2. **后端 API 代理**
   ```nginx
   location /prod-api/ {
       proxy_pass http://127.0.0.1:8080/;
   }
   ```
   将 `/prod-api/` 请求代理到后端 Docker 容器（端口 8080）

3. **前端路由支持**
   ```nginx
   location / {
       try_files $uri $uri/ /index.html;
   }
   ```
   支持 Vue Router 的 history 模式

4. **HTTPS 强制跳转**
   ```nginx
   if ($server_port !~ 443){
       rewrite ^(/.*)$ https://$host$1 permanent;
   }
   ```
   HTTP 自动跳转到 HTTPS

## 常见错误及解决方法

### 错误 1：配置文件语法错误

**症状**：宝塔面板提示"保存失败，因为检测到被修改的配置文件存在错误"

**解决方法**：
1. 使用上面提供的简化版配置
2. 确保没有多余的空格或特殊字符
3. 检查所有的分号 `;` 是否完整
4. 检查所有的花括号 `{}` 是否配对

### 错误 2：SSL 证书路径错误

**症状**：HTTPS 无法访问

**解决方法**：
1. 先在宝塔面板中申请 SSL 证书（Let's Encrypt）
2. 证书申请成功后，路径会自动配置正确

### 错误 3：后端 API 无法访问

**症状**：前端页面可以访问，但 API 请求失败

**解决方法**：
1. 检查后端 Docker 容器是否运行：
   ```bash
   docker ps | grep course-selection-backend
   ```
2. 检查后端端口是否监听：
   ```bash
   netstat -tlnp | grep 8080
   ```
3. 测试后端 API：
   ```bash
   curl http://127.0.0.1:8080
   ```

## 验证配置

### 1. 检查 Nginx 配置语法

在宝塔面板的终端中执行：
```bash
nginx -t
```

如果显示 `syntax is ok` 和 `test is successful`，说明配置正确。

### 2. 重启 Nginx

在宝塔面板中：
- 进入"软件商店"
- 找到"Nginx"
- 点击"重启"

或在终端执行：
```bash
systemctl restart nginx
```

### 3. 测试访问

1. 访问前端：https://xk.xmls.vip
2. 测试 API：https://xk.xmls.vip/prod-api/
3. 检查浏览器控制台是否有错误

## 故障排查

### 查看 Nginx 错误日志

```bash
tail -f /www/wwwlogs/xk.xmls.vip.error.log
```

### 查看 Nginx 访问日志

```bash
tail -f /www/wwwlogs/xk.xmls.vip.log
```

### 测试后端连接

```bash
# 测试后端是否运行
curl http://127.0.0.1:8080

# 测试通过 Nginx 代理访问
curl https://xk.xmls.vip/prod-api/
```

## 注意事项

1. **SSL 证书**：必须先在宝塔面板中申请 SSL 证书，否则 HTTPS 无法访问
2. **网站根目录**：确保设置为 `/www/wwwroot/xk.xmls.vip/frontend`
3. **后端服务**：确保 Docker 容器已启动并监听 8080 端口
4. **防火墙**：确保 80 和 443 端口已开放

## 快速测试命令

```bash
# 1. 检查前端文件
ls -la /www/wwwroot/xk.xmls.vip/frontend/

# 2. 检查后端容器
docker ps | grep course-selection-backend

# 3. 测试后端 API
curl http://127.0.0.1:8080

# 4. 检查 Nginx 配置
nginx -t

# 5. 查看 Nginx 日志
tail -f /www/wwwlogs/xk.xmls.vip.error.log
```
