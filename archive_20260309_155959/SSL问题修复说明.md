# SSL 证书问题修复说明

## 问题分析

根据前端报错信息：
- `ERR_CERT_COMMON_NAME_INVALID` - SSL 证书域名不匹配
- `Network Error` - 无法连接到 `/prod-api/captchaImage`
- `Unchecked runtime.lastError: Could not establish connection`

主要原因是 **SSL 证书配置或 Nginx 反向代理配置不正确**。

## 已提供的解决方案

### 1. Nginx 配置文件
已生成标准的 Nginx 配置文件：`nginx-config.conf`

配置要点：
- HTTP 自动跳转到 HTTPS
- 正确的 SSL 证书路径配置
- `/prod-api/` 反向代理到后端 `http://127.0.0.1:8080/`
- Vue Router history 模式支持
- 静态资源缓存优化

### 2. SSL 证书问题排查指南
已生成详细的排查文档：`SSL证书问题排查指南.md`

包含内容：
- 问题原因分析
- 快速排查步骤
- Nginx 配置应用方法
- 常见问题解答
- 验证修复方法

### 3. 更新的部署指南
已更新 `部署指南.md`，添加了：
- SSL 证书配置详细说明
- Nginx 反向代理配置步骤
- 证书路径查找方法
- 配置验证方法

## 快速修复步骤

### 步骤 1: 检查 SSL 证书（在宝塔面板）

1. 登录宝塔面板
2. 进入"网站" → 找到 `xk.xmls.vip` → 点击"设置"
3. 点击"SSL"标签
4. 检查证书状态：
   - ✅ 证书应该显示为"有效"
   - ✅ 证书应该包含域名 `xk.xmls.vip`
   - ✅ 如果需要 www 子域名，证书也应包含 `www.xk.xmls.vip`

**如果证书无效或域名不匹配**：
- 重新申请 Let's Encrypt 证书
- 确保勾选所有需要的域名

### 步骤 2: 应用 Nginx 配置

#### 方法 A: 通过宝塔面板（推荐）

1. 在宝塔面板中，进入"网站" → `xk.xmls.vip` → "设置"
2. 点击"配置文件"标签
3. 打开部署包中的 `nginx-config.conf` 文件
4. 复制全部内容
5. 粘贴到宝塔面板的配置文件编辑器中（替换原有内容）
6. **重要**: 找到以下两行，修改为实际的证书路径：
   ```nginx
   ssl_certificate /www/server/panel/vhost/cert/xk.xmls.vip/fullchain.pem;
   ssl_certificate_key /www/server/panel/vhost/cert/xk.xmls.vip/privkey.pem;
   ```
   
   证书路径可以在"SSL"标签中查看，或使用命令查找：
   ```bash
   find /www/server -name "*.pem" | grep xk.xmls.vip
   ```

7. 点击"保存"
8. 重启 Nginx（宝塔面板 → 软件商店 → Nginx → 重启）

#### 方法 B: 通过命令行

```bash
# 1. 备份原配置
cp /www/server/panel/vhost/nginx/xk.xmls.vip.conf \
   /www/server/panel/vhost/nginx/xk.xmls.vip.conf.bak

# 2. 上传 nginx-config.conf 到服务器
# 然后复制到 Nginx 配置目录
cp nginx-config.conf /www/server/panel/vhost/nginx/xk.xmls.vip.conf

# 3. 编辑配置，修改 SSL 证书路径
vi /www/server/panel/vhost/nginx/xk.xmls.vip.conf
# 找到 ssl_certificate 和 ssl_certificate_key 行，修改为实际路径

# 4. 测试配置
nginx -t

# 5. 重新加载 Nginx
nginx -s reload
```

### 步骤 3: 验证修复

1. **清除浏览器缓存**
   - 按 Ctrl+Shift+Delete
   - 选择"缓存的图片和文件"
   - 点击"清除数据"

2. **访问系统**
   - 打开浏览器访问 `https://xk.xmls.vip`
   - 地址栏应显示锁图标（表示 HTTPS 正常）

3. **检查 API 连接**
   - 按 F12 打开开发者工具
   - 切换到"Network"标签
   - 刷新页面
   - 查看 `/prod-api/captchaImage` 请求
   - 应该返回 200 状态码，不应有 SSL 错误

4. **测试登录**
   - 验证码图片应该正常显示
   - 尝试登录（账号: admin, 密码: admin123）

## 如果问题仍然存在

### 检查后端服务

```bash
# 检查后端是否运行
ps aux | grep ruoyi-admin.jar

# 检查 8080 端口
netstat -tlnp | grep 8080

# 测试后端 API（在服务器上执行）
curl http://localhost:8080/captchaImage

# 查看后端日志
tail -f /www/wwwroot/course-selection/logs/backend.log
```

### 检查防火墙

```bash
# 检查防火墙状态
firewall-cmd --state

# 如果防火墙开启，确保 8080 端口可以被本地访问
# （注意：8080 不应对外开放，只需要 Nginx 能访问）
```

### 查看详细日志

```bash
# Nginx 错误日志
tail -f /www/wwwlogs/xk.xmls.vip.error.log

# Nginx 访问日志
tail -f /www/wwwlogs/xk.xmls.vip.log

# 后端日志
tail -f /www/wwwroot/course-selection/logs/backend.log
```

## 新部署包信息

已生成新的部署包，包含所有修复文件：

**文件名**: `course-selection_20260309_005500.zip`

**包含内容**:
- ✅ 修复后的后端 JAR 文件（已移除 Spring profile 配置错误）
- ✅ 前端静态文件
- ✅ 数据库备份文件
- ✅ 部署脚本 `server-deploy.sh`
- ✅ Nginx 配置文件 `nginx-config.conf`（新增）
- ✅ SSL 证书问题排查指南 `SSL证书问题排查指南.md`（新增）
- ✅ 更新的部署指南 `部署指南.md`

## 重新部署（如果需要）

如果需要重新部署：

```bash
# 1. 停止当前服务
bash /www/wwwroot/course-selection/scripts/stop-backend.sh

# 2. 上传新部署包到服务器
# 使用宝塔面板或 SCP 上传 course-selection_20260309_005500.zip

# 3. 解压
cd /root/deploy
unzip course-selection_20260309_005500.zip
cd course-selection_*

# 4. 执行部署脚本（会自动部署后端和前端）
chmod +x server-deploy.sh
./server-deploy.sh

# 5. 应用 Nginx 配置（按照上面的步骤 2）

# 6. 验证（按照上面的步骤 3）
```

## 常见问题

### Q: 为什么会出现 SSL 证书错误？
A: 通常是因为：
- SSL 证书绑定的域名与访问域名不一致
- Nginx 配置中的证书路径不正确
- 证书过期或无效

### Q: 为什么 API 请求失败？
A: 通常是因为：
- Nginx 没有正确配置反向代理
- 后端服务没有运行
- 8080 端口被占用或无法访问

### Q: 如何确认 Nginx 配置是否正确？
A: 运行 `nginx -t` 命令，应该显示：
```
nginx: the configuration file /www/server/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /www/server/nginx/conf/nginx.conf test is successful
```

### Q: 修改配置后需要重启什么服务？
A: 
- 修改 Nginx 配置后：重启 Nginx（`nginx -s reload`）
- 修改后端配置后：重启后端服务（`bash /www/wwwroot/course-selection/scripts/restart-backend.sh`）

## 技术支持

如果按照以上步骤操作后问题仍未解决，请提供以下信息：

1. 宝塔面板中的 SSL 证书信息截图
2. 当前的 Nginx 配置文件内容
3. 后端服务日志（最后 50 行）
4. 浏览器开发者工具中的 Network 标签截图

---

**文档版本**: 1.0  
**创建日期**: 2026-03-09  
**适用场景**: SSL 证书错误和 API 连接失败
