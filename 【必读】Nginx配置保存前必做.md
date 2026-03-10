# 🔴【必读】Nginx配置保存前必做

## ⚠️ 重要提示

在宝塔面板中保存Nginx配置之前，必须先在服务器上创建日志目录！

## 🚀 只需3步

### 第1步：SSH登录服务器

```bash
ssh root@你的服务器IP
```

### 第2步：复制并执行以下命令

```bash
mkdir -p /www/wwwlogs && chown -R www:www /www/wwwlogs && echo "✅ 日志目录创建成功！"
```

### 第3步：回到宝塔面板保存Nginx配置

现在可以安全地保存Nginx配置了，不会再报错。

---

## 📝 详细说明

### 为什么需要这一步？

Nginx配置文件中指定了日志文件路径：
```nginx
access_log /www/wwwlogs/xk.xmls.vip.log;
error_log /www/wwwlogs/xk.xmls.vip.error.log;
```

如果这个目录不存在，Nginx就无法启动，配置也无法保存。

### 如何验证目录已创建？

```bash
ls -la /www/wwwlogs
```

应该看到类似输出：
```
drwxr-xr-x 2 www www 4096 Mar  9 21:30 .
```

### 如果还是报错怎么办？

1. 检查目录权限：
```bash
ls -la /www/wwwlogs
```

2. 重新设置权限：
```bash
chmod 755 /www/wwwlogs
chown -R www:www /www/wwwlogs
```

3. 测试Nginx配置：
```bash
nginx -t
```

---

## ✅ 完成检查

- [ ] 已SSH登录服务器
- [ ] 已执行创建目录命令
- [ ] 已验证目录存在
- [ ] 已在宝塔面板保存Nginx配置
- [ ] Nginx配置保存成功
- [ ] 网站可以正常访问

---

**记住：先创建目录，再保存配置！**
