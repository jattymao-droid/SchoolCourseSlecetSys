<template>
  <div class="login-container">
    <!-- 左侧：系统特色导引区 -->
    <div class="login-left">
      <div class="overlay"></div>
      <div class="floating-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
        <div class="shape shape-4"></div>
        <div class="shape shape-5"></div>
      </div>
      <div class="content">
        <div class="brand">
          <img :src="logoImg" alt="校徽" class="logo-img" />
          <span class="brand-name">会泽县东陆高级中学校</span>
        </div>
        
        <div class="hero-section">
          <h1 class="hero-title">选课规划<br/><span>开启兴趣之门</span></h1>
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
      </div>
    </div>

    <!-- 分界线 -->
    <div class="login-divider"></div>

    <!-- 右侧：登录操作区 -->
    <div class="login-right">
      <el-form ref="loginRef" :model="loginForm" :rules="loginRules" class="login-form">
        <div class="brand-info">
          <div class="form-logo">
            <img :src="logoImg" alt="校徽" class="form-logo-img" />
          </div>
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
        <el-form-item prop="code" v-if="captchaEnabled" class="captcha-row">
          <div class="captcha-wrap">
            <el-input
              v-model="loginForm.code"
              size="large"
              auto-complete="off"
              placeholder="请输入验证码"
              @keyup.enter="handleLogin"
            >
              <template #prefix><svg-icon icon-class="validCode" class="el-input__icon input-icon" /></template>
            </el-input>
            <div class="login-code" @click="getCode" title="点击刷新验证码">
              <img v-if="codeUrl" :src="codeUrl" class="login-code-img" alt="验证码"/>
              <span v-else class="login-code-placeholder">加载中</span>
            </div>
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
import logoImg from '@/assets/logo/logo.png'

const title = import.meta.env.VITE_APP_TITLE
const footerContent = defaultSettings.footerContent
const userStore = useUserStore()
const route = useRoute()
const router = useRouter()
const { proxy } = getCurrentInstance()

const loginForm = ref({
  username: "",
  password: "",
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
  background: linear-gradient(135deg, #F8FAFC 0%, #F1F5F9 50%, #E2E8F0 100%);
}

// ── 左侧特色导引区 ──────────────────────────────────────────
.login-left {
  flex: 1.2;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 60px;
  background: linear-gradient(160deg, #0F172A 0%, #1E293B 40%, #0F172A 100%);
  background-image: url('../assets/images/bg.jpeg');
  background-size: cover;
  background-position: center;
  overflow: hidden;
  color: #fff;

  .overlay {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    background: linear-gradient(
      120deg,
      rgba(15, 23, 42, 0.72) 0%,
      rgba(30, 41, 59, 0.65) 40%,
      rgba(15, 23, 42, 0.8) 100%
    );
    pointer-events: none;
  }

  .floating-shapes {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    pointer-events: none;
    overflow: hidden;
  }
  .shape {
    position: absolute;
    border-radius: 50%;
    opacity: 0.1;
    animation: float 20s ease-in-out infinite;
  }
  .shape-1 { width: 300px; height: 300px; background: linear-gradient(135deg, #4F46E5, #818CF8); top: 10%; left: -10%; animation-delay: 0s; }
  .shape-2 { width: 180px; height: 180px; background: linear-gradient(135deg, #6366F1, #A78BFA); top: 60%; right: 5%; animation-delay: -5s; animation-duration: 25s; }
  .shape-3 { width: 120px; height: 120px; background: linear-gradient(135deg, #818CF8, #C4B5FD); bottom: 20%; left: 15%; animation-delay: -10s; animation-duration: 18s; }
  .shape-4 { width: 80px; height: 80px; background: rgba(255,255,255,0.1); top: 30%; right: 20%; animation-delay: -3s; animation-duration: 22s; }
  .shape-5 { width: 200px; height: 200px; border: 2px solid rgba(79, 70, 229, 0.3); background: transparent; bottom: 10%; right: 25%; animation-delay: -7s; animation-duration: 28s; }
  @keyframes float {
    0%, 100% { transform: translate(0, 0) scale(1); }
    25% { transform: translate(20px, -30px) scale(1.05); }
    50% { transform: translate(-15px, 20px) scale(0.95); }
    75% { transform: translate(30px, 10px) scale(1.02); }
  }

  .content {
    position: relative;
    z-index: 2;
    max-width: 600px;
    animation: fadeInUp 0.8s ease-out;
  }
  @keyframes fadeInUp {
    from { opacity: 0; transform: translateY(24px); }
    to { opacity: 1; transform: translateY(0); }
  }

  .brand {
    display: flex;
    align-items: center;
    margin-bottom: 60px;
    
    .logo-img {
      width: 64px;
      height: 64px;
      object-fit: contain;
      margin-right: 20px;
      border-radius: 14px;
      box-shadow: 0 8px 24px rgba(79, 70, 229, 0.3);
      transition: transform 0.3s ease;
      &:hover { transform: scale(1.05) rotate(-3deg); }
    }
    .brand-name {
      font-size: 26px;
      font-weight: 800;
      letter-spacing: 1px;
      background: linear-gradient(90deg, #fff, #E0E7FF);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }
  }

  .hero-section {
    margin-bottom: 80px;
    .hero-title {
      font-size: 52px;
      font-weight: 800;
      line-height: 1.25;
      margin-bottom: 24px;
      letter-spacing: -0.5px;
      span {
        background: linear-gradient(135deg, #818CF8 0%, #A78BFA 50%, #C4B5FD 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        text-shadow: 0 0 40px rgba(129, 140, 248, 0.3);
      }
    }
    .hero-desc {
      font-size: 17px;
      color: #94A3B8;
      max-width: 420px;
      line-height: 1.7;
      letter-spacing: 0.3px;
    }
  }

  .feature-steps {
    display: flex;
    align-items: center;
    margin-bottom: 80px;
    gap: 24px;
    
    .step-item {
      flex: 1;
      min-width: 0;
      padding: 16px 12px;
      background: rgba(255,255,255,0.03);
      border-radius: 12px;
      border: 1px solid rgba(255,255,255,0.06);
      transition: all 0.3s ease;
      &:hover {
        background: rgba(255,255,255,0.06);
        border-color: rgba(79, 70, 229, 0.3);
        transform: translateY(-2px);
      }
      .step-num {
        font-size: 12px;
        color: #818CF8;
        font-weight: 800;
        margin-bottom: 8px;
        letter-spacing: 1px;
      }
      .step-text {
        font-size: 13px;
        color: #CBD5E1;
        font-weight: 500;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }
    }
    .step-arrow {
      flex-shrink: 0;
      width: 24px;
      height: 1px;
      background: linear-gradient(90deg, rgba(255,255,255,0.2), transparent);
      position: relative;
      &::after {
        content: '';
        position: absolute;
        right: -3px; top: -4px;
        width: 8px; height: 8px;
        border-right: 2px solid rgba(129, 140, 248, 0.6);
        border-bottom: 2px solid rgba(129, 140, 248, 0.6);
        transform: rotate(-45deg);
      }
    }
  }

}

.login-divider {
  width: 1px;
  background: linear-gradient(180deg, transparent, rgba(203, 213, 225, 0.6), transparent);
  flex-shrink: 0;
}

// ── 右侧登录区 ──────────────────────────────────────────────
.login-right {
  flex: 1;
  background: linear-gradient(180deg, #F8FAFC 0%, #F1F5F9 100%);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  position: relative;
  padding: 40px;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    background-image: 
      radial-gradient(circle at 10% 20%, rgba(79, 70, 229, 0.04) 0%, transparent 40%),
      radial-gradient(circle at 90% 80%, rgba(99, 102, 241, 0.03) 0%, transparent 40%);
    pointer-events: none;
  }
}

.login-form {
  width: 100%;
  max-width: 460px;
  background: #ffffff;
  padding: 56px 60px 48px;
  border-radius: 28px;
  border: 1px solid rgba(226, 232, 240, 0.8);
  box-shadow: 
    0 1px 3px rgba(0,0,0,0.02),
    0 24px 60px -12px rgba(0,0,0,0.08),
    0 0 0 1px rgba(255,255,255,0.1) inset;
  position: relative;
  z-index: 1;
  animation: formSlideIn 0.6s ease-out 0.2s both;
  transition: box-shadow 0.3s ease;

  &:hover {
    box-shadow: 
      0 1px 3px rgba(0,0,0,0.02),
      0 28px 70px -14px rgba(0,0,0,0.1),
      0 0 0 1px rgba(255,255,255,0.1) inset;
  }

  @keyframes formSlideIn {
    from { opacity: 0; transform: translateX(24px); }
    to { opacity: 1; transform: translateX(0); }
  }

  .brand-info {
    text-align: center;
    margin-bottom: 48px;
    .form-logo {
      width: 56px;
      height: 56px;
      margin: 0 auto 20px;
      border-radius: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
      box-shadow: 0 8px 24px rgba(79, 70, 229, 0.25);
      .form-logo-img {
        width: 100%;
        height: 100%;
        object-fit: contain;
      }
    }
    .title {
      font-size: 24px;
      font-weight: 800;
      color: #0F172A;
      margin-bottom: 12px;
      letter-spacing: -0.5px;
    }
    .subtitle {
      font-size: 15px;
      color: #64748B;
      font-weight: 500;
    }
  }

  :deep(.el-form-item) {
    margin-bottom: 24px;
  }

  :deep(.el-input__wrapper) {
    background: #F8FAFC !important;
    border: 1.5px solid #E2E8F0 !important;
    border-radius: 14px !important;
    box-shadow: none !important;
    height: 52px;
    padding: 0 16px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    &:hover {
      border-color: #CBD5E1 !important;
      background: #ffffff !important;
    }
    &.is-focus {
      background: #ffffff !important;
      border-color: #4F46E5 !important;
      box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1) !important;
    }
  }

  :deep(.el-input__inner) {
    color: #0F172A !important;
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
    background: linear-gradient(135deg, #4F46E5 0%, #6366F1 100%);
    border: none;
    font-size: 16px;
    font-weight: 700;
    letter-spacing: 2px;
    box-shadow: 0 8px 24px -4px rgba(79, 70, 229, 0.35);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    &:hover { 
      background: linear-gradient(135deg, #4338CA 0%, #4F46E5 100%);
      transform: translateY(-2px);
      box-shadow: 0 12px 32px -4px rgba(79, 70, 229, 0.45);
    }
    &:active {
      transform: translateY(0);
    }
  }

  .register-link {
    text-align: center;
    margin-top: 24px;
    .link-type { 
      font-size: 14px; 
      color: #4F46E5; 
      font-weight: 600;
      transition: color 0.2s;
      &:hover { color: #4338CA; }
    }
  }
}

.captcha-row :deep(.el-form-item__content) { display: block; }
.captcha-wrap {
  display: flex;
  gap: 12px;
  align-items: stretch;
}
.captcha-wrap .el-input { flex: 1; min-width: 0; }
.login-code {
  flex-shrink: 0;
  width: 130px;
  height: 52px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border-radius: 14px;
  border: 1.5px solid #E2E8F0;
  overflow: hidden;
  position: relative;
  background: #F8FAFC;
  transition: all 0.25s ease;
  &:hover {
    border-color: #4F46E5;
    box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.08);
    background: #fff;
  }
}
.login-code-img {
  height: 100%;
  width: 100%;
  object-fit: contain;
  display: block;
}
.login-code-placeholder {
  font-size: 13px;
  color: #94A3B8;
}

.el-login-footer {
  position: absolute;
  bottom: 24px;
  color: #94A3B8;
  font-size: 13px;
  font-weight: 500;
  z-index: 1;
}

// 响应式
@media (max-width: 1024px) {
  .login-left { display: none; }
  .login-divider { display: none; }
  .login-right { flex: 1; }
  .login-form {
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
  }
}
</style>
