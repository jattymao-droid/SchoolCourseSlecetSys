# 选课系统并发压力测试

## 前置条件

1. **后端已启动**：`http://localhost:8080`
2. **Redis 已启动**
3. **PostgreSQL 已运行**，且已执行选课系统初始化脚本
4. **关闭验证码**（压力测试需要自动登录）：
   - 方式一：双击运行 `prepare.bat`
   - 方式二：`psql -U postgres -d ry_vue -f sql/load_test_prepare.sql`
   - 方式三：用 Navicat/DBeaver 执行 `sql/load_test_prepare.sql`
5. **测试用户存在**：student01~student06，密码 admin123（见 `sql/course_demo_data.sql`）

## 运行测试

```bash
cd load-test
node load-test.js
```

## 配置说明

在 `load-test.js` 中可调整：

| 参数 | 默认值 | 说明 |
|------|--------|------|
| vus | 20 | 并发虚拟用户数 |
| iterationsPerVu | 10 | 每个用户执行轮数 |
| timeout | 10000 | 请求超时(ms) |

## 测试场景

每个虚拟用户会循环执行：

1. 登录获取 token
2. 获取当前学期
3. 获取选课车
4. 获取我的选课
5. 获取课程列表
6. 获取学生看板

## 测试完成后

恢复验证码开关（生产环境务必开启）：

```sql
UPDATE sys_config SET config_value = 'true' WHERE config_key = 'sys.account.captchaEnabled';
```
