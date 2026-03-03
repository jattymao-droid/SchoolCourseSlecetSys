/**
 * 选课系统并发压力测试
 * 使用 Node.js 内置模块，无需额外依赖
 *
 * 前置条件：
 * 1. 后端已启动 (http://localhost:8080)
 * 2. Redis 已启动
 * 3. 关闭验证码：执行 sql/load_test_prepare.sql
 * 4. 确保有测试用户：student01~student06 / admin123
 */

const http = require('http');

const BASE_URL = 'localhost';
const BASE_PORT = 8080;

// 测试配置（可通过环境变量覆盖：LOAD_TEST_VUS=50 node load-test.js）
const CONFIG = {
  // 并发虚拟用户数
  vus: parseInt(process.env.LOAD_TEST_VUS || '20', 10),
  // 每个用户执行轮数
  iterationsPerVu: parseInt(process.env.LOAD_TEST_ITERATIONS || '10', 10),
  // 请求超时(ms)
  timeout: 10000,
  // 学生账号池（密码均为 admin123）
  students: ['202401001', '202401002', '202401003', '202401004', '202302001', '202302002'],
  password: 'admin123',
};

// 统计
const stats = {
  requests: 0,
  success: 0,
  failed: 0,
  totalTime: 0,
  minTime: Infinity,
  maxTime: 0,
  errors: {},
};

function request(method, path, body, token) {
  return new Promise((resolve, reject) => {
    const url = new URL(path, `http://${BASE_URL}:${BASE_PORT}`);
    const start = Date.now();
    const options = {
      hostname: BASE_URL,
      port: BASE_PORT,
      path: url.pathname + url.search,
      method,
      headers: {
        'Content-Type': 'application/json',
        ...(token && { Authorization: `Bearer ${token}` }),
      },
    };

    const req = http.request(options, (res) => {
      let data = '';
      res.on('data', (chunk) => (data += chunk));
      res.on('end', () => {
        const elapsed = Date.now() - start;
        stats.requests++;
        stats.totalTime += elapsed;
        stats.minTime = Math.min(stats.minTime, elapsed);
        stats.maxTime = Math.max(stats.maxTime, elapsed);

        if (res.statusCode >= 200 && res.statusCode < 300) {
          stats.success++;
          try {
            const json = JSON.parse(data);
            resolve({ ok: true, data: json, status: res.statusCode, elapsed });
          } catch {
            resolve({ ok: true, data, status: res.statusCode, elapsed });
          }
        } else {
          stats.failed++;
          const key = `${method} ${path} -> ${res.statusCode}`;
          stats.errors[key] = (stats.errors[key] || 0) + 1;
          resolve({ ok: false, status: res.statusCode, data, elapsed });
        }
      });
    });

    req.on('error', (err) => {
      stats.requests++;
      stats.failed++;
      stats.errors[err.message] = (stats.errors[err.message] || 0) + 1;
      reject(err);
    });
    req.setTimeout(CONFIG.timeout, () => {
      req.destroy();
      stats.requests++;
      stats.failed++;
      stats.errors['timeout'] = (stats.errors['timeout'] || 0) + 1;
      reject(new Error('timeout'));
    });

    if (body) {
      req.write(JSON.stringify(body));
    }
    req.end();
  });
}

async function login(username) {
  const res = await request('POST', '/login', {
    username,
    password: CONFIG.password,
    code: '',
    uuid: '',
  });
  if (res.ok && res.data && res.data.token) {
    return res.data.token;
  }
  throw new Error(`Login failed: ${username} - ${JSON.stringify(res.data)}`);
}

async function runUser(userIndex) {
  const username = CONFIG.students[userIndex % CONFIG.students.length];
  let token;
  try {
    token = await login(username);
  } catch (e) {
    console.error(`[VU${userIndex}] Login failed:`, e.message);
    return;
  }

  for (let i = 0; i < CONFIG.iterationsPerVu; i++) {
    const semesterId = 1; // 假设当前学期 ID 为 1
    const requests = [
      () => request('GET', `/course/semester/current`, null, token),
      () => request('GET', `/course/selection/cart?semesterId=${semesterId}`, null, token),
      () => request('GET', `/course/selection/my?semesterId=${semesterId}`, null, token),
      () => request('GET', `/course/course/list?pageNum=1&pageSize=20&semesterId=${semesterId}`, null, token),
      () => request('GET', `/course/dashboard/student`, null, token),
    ];

    for (const fn of requests) {
      try {
        await fn();
      } catch (e) {
        // 已计入 stats.errors
      }
      // 模拟用户思考间隔 50-200ms
      await new Promise((r) => setTimeout(r, 50 + Math.random() * 150));
    }
  }
}

async function main() {
  console.log('========================================');
  console.log('  选课系统并发压力测试');
  console.log('========================================');
  console.log(`并发用户数: ${CONFIG.vus}`);
  console.log(`每用户轮数: ${CONFIG.iterationsPerVu}`);
  console.log(`预估请求数: ${CONFIG.vus * CONFIG.iterationsPerVu * 5}`);
  console.log('----------------------------------------');

  const start = Date.now();
  const promises = [];
  for (let i = 0; i < CONFIG.vus; i++) {
    promises.push(runUser(i));
  }
  await Promise.all(promises);
  const totalElapsed = Date.now() - start;

  // 输出报告
  console.log('\n========== 测试报告 ==========');
  console.log(`总耗时: ${(totalElapsed / 1000).toFixed(2)}s`);
  console.log(`总请求数: ${stats.requests}`);
  console.log(`成功: ${stats.success}`);
  console.log(`失败: ${stats.failed}`);
  console.log(`成功率: ${stats.requests ? ((stats.success / stats.requests) * 100).toFixed(2) : 0}%`);
  if (stats.requests > 0) {
    console.log(`平均响应: ${(stats.totalTime / stats.requests).toFixed(0)}ms`);
    console.log(`最小响应: ${stats.minTime === Infinity ? '-' : stats.minTime}ms`);
    console.log(`最大响应: ${stats.maxTime}ms`);
    console.log(`QPS: ${(stats.requests / (totalElapsed / 1000)).toFixed(2)}`);
  }
  if (Object.keys(stats.errors).length > 0) {
    console.log('\n错误分布:');
    for (const [k, v] of Object.entries(stats.errors)) {
      console.log(`  ${k}: ${v}次`);
    }
  }
  console.log('========================================');
}

main().catch(console.error);
