<template>
  <div class="login-container">
    <!-- 左侧：系统特色导引区 -->
    <div class="login-left">
      <div class="overlay"></div>
      <div class="content">
        <div class="brand">
          <div class="logo-icon">
            <svg-icon icon-class="education" />
          </div>
          <span class="brand-name">东陆高中</span>
        </div>
        
        <div class="hero-section">
          <h1 class="hero-title">选修课规划<br/><span>开启志趣之窗</span></h1>
          <p class="hero-desc">Discover your passion through our diverse elective programs.</p>
        </div>

        <div class="feature-steps">
          <div class="step-item">
            <div class="step-num">01</div>
            <div class="step-text">身份认证登录</div>
          </div>
          <div class="step-arrow"></div>
          <div class="step-item">
            <div class="step-num">02</div>
            <div class="step-text">查阅选课方案</div>
          </div>
          <div class="step-arrow"></div>
          <div class="step-item">
            <div class="step-num">03</div>
            <div class="step-text">勾选志趣课程</div>
          </div>
          <div class="step-arrow"></div>
          <div class="step-item">
            <div class="step-num">04</div>
            <div class="step-text">提交确认成功</div>
          </div>
        </div>

        <div class="notice-card">
          <div class="notice-tag">最新公告</div>
          <div class="notice-content">
            <p>1. 2026学年春季选修课通道将于3月1日正式开启。</p>
            <p>2. 请各位同学提前在“查阅方案”中了解课程学分要求。</p>
          </div>
        </div>
      </div>
    </div>

    <!-- 右侧：登录操作区 -->
    <div class="login-right">
      <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form">
        <div class="brand-info">
          <h3 class="title">{{ title }}</h3>
          <p class="subtitle">欢迎使用选修课管理系统</p>
        </div>
        <el-form-item prop="username">
          <el-input
            v-model="loginForm.username"
            type="text"
            size="large"
            auto-complete="off"
            placeholder="请输入账号"
          >
            <template #prefix><svg-icon icon-class="user" class="el-input__icon input-icon" /></template>
          </el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            type="password"
            size="large"
            auto-complete="off"
            placeholder="请输入密码"
            @keyup.enter="handleLogin"
          >
            <template #prefix><svg-icon icon-class="password" class="el-input__icon input-icon" /></template>
          </el-input>
        </el-form-item>
        <el-form-item prop="code" v-if="captchaEnabled">
          <el-input
            v-model="loginForm.code"
            size="large"
            auto-complete="off"
            placeholder="验证码"
            style="width: 63%"
            @keyup.enter="handleLogin"
          >
            <template #prefix><svg-icon icon-class="validCode" class="el-input__icon input-icon" /></template>
          </el-input>
          <div class="login-code">
            <img :src="codeUrl" @click="getCode" class="login-code-img"/>
          </div>
        </el-form-item>
        <el-checkbox v-model="loginForm.rememberMe">记住密码</el-checkbox>
        <el-form-item style="width:100%;">
          <el-button
            :loading="loading"
            size="large"
            type="primary"
            @click.prevent="handleLogin"
          >
            <span v-if="!loading">进 入 系 统</span>
            <span v-else>正 在 登 录...</span>
          </el-button>
          <div class="register-link" v-if="register">
            <router-link class="link-type" :to="'/register'">还没有账号？立即注册</router-link>
          </div>
        </el-form-item>
      </el-form>
      
      <!--  底部  -->
      <div class="el-login-footer">
        <span>{{ footerContent }}</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { getCodeImg } from "@/api/login"
import Cookies from "js-cookie"
import { encrypt, decrypt } from "@/utils/jsencrypt"
import useUserStore from '@/store/modules/user'
import defaultSettings from '@/settings'

const title = import.meta.env.VITE_APP_TITLE
const footerContent = defaultSettings.footerContent
const userStore = useUserStore()
const route = useRoute()
const router = useRouter()
const { proxy } = getCurrentInstance()

const loginForm = ref({
  username: "admin",
  password: "admin123",
  rememberMe: false,
  code: "",
  uuid: ""
})

const loginRules = {
  username: [{ required: true, trigger: "blur", message: "请输入您的账号" }],
  password: [{ required: true, trigger: "blur", message: "请输入您的密码" }],
  code: [{ required: true, trigger: "change", message: "请输入验证码" }]
}

const codeUrl = ref("")
const loading = ref(false)
// 验证码开关
const captchaEnabled = ref(true)
// 注册开关
const register = ref(false)
const redirect = ref(undefined)

watch(route, (newRoute) => {
    redirect.value = newRoute.query && newRoute.query.redirect
}, { immediate: true })

function handleLogin() {
  proxy.$refs.loginRef.validate(valid => {
    if (valid) {
      loading.value = true
      // 勾选了需要记住密码设置在 cookie 中设置记住用户名和密码
      if (loginForm.value.rememberMe) {
        Cookies.set("username", loginForm.value.username, { expires: 30 })
        Cookies.set("password", encrypt(loginForm.value.password), { expires: 30 })
        Cookies.set("rememberMe", loginForm.value.rememberMe, { expires: 30 })
      } else {
        // 否则移除
        Cookies.remove("username")
        Cookies.remove("password")
        Cookies.remove("rememberMe")
      }
      // 调用action的登录方法
      userStore.login(loginForm.value).then(() => {
        const query = route.query
        const otherQueryParams = Object.keys(query).reduce((acc, cur) => {
          if (cur !== "redirect") {
            acc[cur] = query[cur]
          }
          return acc
        }, {})
        router.push({ path: redirect.value || "/", query: otherQueryParams })
      }).catch(() => {
        loading.value = false
        // 重新获取验证码
        if (captchaEnabled.value) {
          getCode()
        }
      })
    }
  })
}

function getCode() {
  getCodeImg().then(res => {
    captchaEnabled.value = res.captchaEnabled === undefined ? true : res.captchaEnabled
    if (captchaEnabled.value) {
      codeUrl.value = "data:image/gif;base64," + res.img
      loginForm.value.uuid = res.uuid
    }
  })
}

function getCookie() {
  const username = Cookies.get("username")
  const password = Cookies.get("password")
  const rememberMe = Cookies.get("rememberMe")
  loginForm.value = {
    username: username === undefined ? loginForm.value.username : username,
    password: password === undefined ? loginForm.value.password : decrypt(password),
    rememberMe: rememberMe === undefined ? false : Boolean(rememberMe)
  }
}

getCode()
getCookie()
</script>

<style lang="scss" scoped>
.login-container {
  display: flex;
  min-height: 100vh;
  background-color: #FAFAFA;
}

// ── 左侧特色导引区 ──────────────────────────────────────────
.login-left {
  flex: 1.2;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 60px;
  background-color: #111827; 
  background-image: 
    radial-gradient(circle at 0% 0%, rgba(59, 91, 219, 0.15) 0%, transparent 50%),
    radial-gradient(circle at 100% 100%, rgba(130, 201, 30, 0.08) 0%, transparent 50%);
  overflow: hidden;
  color: #fff;

  .overlay {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    background: url('https://www.transparenttextures.com/patterns/carbon-fibre.png');
    opacity: 0.1;
    pointer-events: none;
  }

  .content {
    position: relative;
    z-index: 2;
    max-width: 600px;
  }

  .brand {
    display: flex;
    align-items: center;
    margin-bottom: 60px;
    
    .logo-icon {
      width: 48px;
      height: 48px;
      background: #3B5BDB;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 16px;
      .svg-icon { font-size: 24px; color: #fff; }
    }
    .brand-name {
      font-size: 22px;
      font-weight: 700;
      letter-spacing: 1px;
    }
  }

  .hero-section {
    margin-bottom: 80px;
    .hero-title {
      font-size: 52px;
      font-weight: 800;
      line-height: 1.2;
      margin-bottom: 24px;
      span {
        color: #3B5BDB;
        background: linear-gradient(90deg, #3B5BDB, #74C0FC);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
      }
    }
    .hero-desc {
      font-size: 18px;
      color: #9CA3AF;
      max-width: 400px;
      line-height: 1.6;
    }
  }

  .feature-steps {
    display: flex;
    align-items: center;
    margin-bottom: 80px;
    
    .step-item {
      .step-num {
        font-size: 13px;
        color: #3B5BDB;
        font-weight: 800;
        margin-bottom: 8px;
      }
      .step-text {
        font-size: 14px;
        color: #E5E7EB;
        font-weight: 500;
        white-space: nowrap;
      }
    }
    .step-arrow {
      width: 30px;
      height: 1px;
      background: rgba(255,255,255,0.1);
      margin: 20px 20px 0;
      position: relative;
      &::after {
        content: '';
        position: absolute;
        right: -4px; top: -3px;
        width: 6px; height: 6px;
        border-right: 1px solid rgba(255,255,255,0.3);
        border-bottom: 1px solid rgba(255,255,255,0.3);
        transform: rotate(-45deg);
      }
    }
  }

  .notice-card {
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 20px;
    padding: 24px;
    backdrop-filter: blur(10px);
    
    .notice-tag {
      display: inline-block;
      padding: 4px 12px;
      background: #3B5BDB;
      border-radius: 6px;
      font-size: 12px;
      font-weight: 700;
      margin-bottom: 16px;
    }
    .notice-content {
      p {
        margin: 8px 0;
        font-size: 14px;
        color: #9CA3AF;
        line-height: 1.5;
      }
    }
  }
}

// ── 右侧登录区 ──────────────────────────────────────────────
.login-right {
  flex: 1;
  background-color: #FAFAFA;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  position: relative;
  padding: 40px;
}

.login-form {
  width: 100%;
  max-width: 460px;
  background: #ffffff;
  padding: 56px 60px 48px;
  border-radius: 32px;
  border: 1px solid #F2F4F7;
  box-shadow: 
    0 1px 3px rgba(0,0,0,0.02),
    0 20px 50px -10px rgba(0,0,0,0.05);

  .brand-info {
    text-align: center;
    margin-bottom: 48px;
    .title {
      font-size: 28px;
      font-weight: 800;
      color: #111827;
      margin-bottom: 12px;
    }
    .subtitle {
      font-size: 15px;
      color: #6B7280;
    }
  }

  :deep(.el-form-item) {
    margin-bottom: 24px;
  }

  :deep(.el-input__wrapper) {
    background: #F9FAFB !important;
    border: 1.5px solid transparent !important;
    border-radius: 14px !important;
    box-shadow: none !important;
    height: 52px;
    padding: 0 16px;
    transition: all 0.2s;
    &.is-focus {
      background: #ffffff !important;
      border-color: #3B5BDB !important;
      box-shadow: 0 0 0 4px rgba(59, 91, 219, 0.12) !important;
    }
  }

  :deep(.el-input__inner) {
    color: #111827 !important;
    font-weight: 500;
  }

  :deep(.el-checkbox) {
    margin-bottom: 32px;
    .el-checkbox__label { color: #374151; font-weight: 500; }
  }

  :deep(.el-button--primary) {
    width: 100%;
    height: 56px;
    border-radius: 16px;
    background: #111827;
    border: none;
    font-size: 16px;
    font-weight: 700;
    box-shadow: 0 10px 15px -3px rgba(17, 24, 39, 0.2);
    transition: all 0.2s;
    &:hover { background: #1F2937; transform: translateY(-2px); }
  }

  .register-link {
    text-align: center;
    margin-top: 24px;
    .link-type { font-size: 14px; color: #3B5BDB; }
  }
}

.login-code {
  height: 52px;
  display: flex;
  align-items: center;
}
.login-code-img {
  height: 48px;
  border-radius: 12px;
  margin-left: 12px;
  cursor: pointer;
  border: 1.5px solid #F3F4F6;
}

.el-login-footer {
  position: absolute;
  bottom: 24px;
  color: #9CA3AF;
  font-size: 13px;
  font-weight: 500;
}

// 响应式
@media (max-width: 1024px) {
  .login-left { display: none; }
  .login-right { flex: 1; }
}
</style>
