<template>
  <view class="login-page pad-container">
    <view class="login-wrapper">
      <!-- 顶部装饰区 -->
      <view class="login-hero">
        <view class="logo-circle">
          <image class="logo-icon" src="@/static/logo.png" mode="aspectFit"></image>
        </view>
        <view class="hero-text-wrap">
          <text class="school-name">会泽县东陆高中</text>
          <text class="app-name">选修课选课系统</text>
        </view>
      </view>

      <!-- 表单卡片 -->
      <view class="login-form card">
        <text class="form-title">学生登录</text>

      <!-- 学号 -->
      <view class="form-item" :class="{ error: errors.username }">
        <view class="input-wrap">
          <text class="input-icon">👤</text>
          <input
            v-model="form.username"
            class="input"
            placeholder="请输入学号"
            placeholder-class="input-placeholder"
            @blur="validateUsername"
          />
        </view>
        <text v-if="errors.username" class="error-msg">{{ errors.username }}</text>
      </view>

      <!-- 密码 -->
      <view class="form-item" :class="{ error: errors.password }">
        <view class="input-wrap">
          <text class="input-icon">🔒</text>
          <input
            v-model="form.password"
            class="input"
            :password="!showPassword"
            placeholder="请输入密码"
            placeholder-class="input-placeholder"
            @blur="validatePassword"
          />
          <text class="eye-icon" @click="showPassword = !showPassword">
            {{ showPassword ? '👁' : '🙈' }}
          </text>
        </view>
        <text v-if="errors.password" class="error-msg">{{ errors.password }}</text>
      </view>

      <!-- 验证码（仅 captchaEnabled 时显示） -->
      <view v-if="captchaEnabled" class="form-item" :class="{ error: errors.code }">
        <view class="captcha-row">
          <view class="input-wrap captcha-input-wrap">
            <text class="input-icon">🔢</text>
            <input
              v-model="form.code"
              class="input"
              placeholder="请输入验证码"
              placeholder-class="input-placeholder"
              maxlength="10"
              @blur="validateCode"
            />
          </view>
          <!-- 验证码图片 -->
          <view class="captcha-img-wrap" @click="refreshCaptcha">
            <image
              v-if="captchaImg"
              :src="captchaImg"
              class="captcha-img"
              mode="aspectFill"
            />
            <view v-else class="captcha-loading">
              <text class="captcha-loading-text">{{ captchaLoadError ? '点击刷新' : '加载中...' }}</text>
            </view>
          </view>
        </view>
        <text class="captcha-hint">点击图片可刷新验证码</text>
        <text v-if="errors.code" class="error-msg">{{ errors.code }}</text>
      </view>

      <!-- 登录按钮 -->
      <button
        class="btn-primary login-btn"
        :loading="loading"
        :disabled="loading"
        @click="handleLogin"
      >
        {{ loading ? '登录中...' : '登 录' }}
      </button>

    </view>
    </view>

    <text class="version-text">v1.0.0 · 东陆高中信息技术中心</text>
  </view>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { getCaptcha } from '@/api/auth'

const authStore = useAuthStore()

/** 微信小程序 image 不支持 base64，需转为临时文件路径；H5 直接用 data URI */
function base64ToImageSrc(base64: string): Promise<string> {
  // #ifdef MP-WEIXIN
  return new Promise((resolve, reject) => {
    try {
      const fs = uni.getFileSystemManager()
      const basePath = (uni as any).env?.USER_DATA_PATH || ''
      if (!basePath) return resolve(`data:image/jpg;base64,${base64}`)
      const filePath = `${basePath}/captcha_${Date.now()}.jpg`
      const buffer = uni.base64ToArrayBuffer(base64)
      fs.writeFile({ filePath, data: buffer, encoding: 'binary', success: () => resolve(filePath), fail: reject })
    } catch (e) {
      reject(e)
    }
  })
  // #endif
  // #ifndef MP-WEIXIN
  return Promise.resolve(`data:image/jpg;base64,${base64}`)
  // #endif
}
const loading = ref(false)
const showPassword = ref(false)

// 验证码状态
const captchaEnabled = ref(false)
const captchaImg = ref('')       // data:image/jpg;base64,xxx
const captchaUuid = ref('')
const captchaLoadError = ref(false)

const form = reactive({ username: '', password: '', code: '' })
const errors = reactive({ username: '', password: '', code: '' })

// ---- 验证码 ----
async function fetchCaptcha() {
  captchaImg.value = ''
  captchaLoadError.value = false
  try {
    const res = await getCaptcha()
    captchaEnabled.value = res.captchaEnabled
    if (res.captchaEnabled && res.img) {
      captchaUuid.value = res.uuid
      captchaImg.value = await base64ToImageSrc(res.img)
    }
  } catch {
    captchaLoadError.value = true
  }
}

function refreshCaptcha() {
  form.code = ''
  errors.code = ''
  fetchCaptcha()
}

// ---- 表单校验 ----
function validateUsername() {
  errors.username = form.username.trim() ? '' : '请输入学号'
}
function validatePassword() {
  errors.password = form.password.length >= 6 ? '' : '密码不能少于 6 位'
}
function validateCode() {
  if (!captchaEnabled.value) return
  errors.code = form.code.trim() ? '' : '请输入验证码'
}

// ---- 登录 ----
async function handleLogin() {
  validateUsername()
  validatePassword()
  validateCode()
  if (errors.username || errors.password || errors.code) return

  loading.value = true
  try {
    await authStore.login(
      form.username.trim(),
      form.password,
      form.code.trim(),
      captchaUuid.value
    )
    uni.showToast({ title: '登录成功', icon: 'success' })
    setTimeout(() => {
      uni.switchTab({ url: '/pages/home/index' })
    }, 500)
  } catch {
    // 登录失败后自动刷新验证码
    if (captchaEnabled.value) refreshCaptcha()
  } finally {
    loading.value = false
  }
}

onMounted(fetchCaptcha)
</script>

<style lang="scss" scoped>
.login-page {
  min-height: 100vh;
  background: var(--bg-page);
  position: relative;
  display: flex;
  flex-direction: column;
  padding: 120rpx 40rpx 60rpx;
  overflow: hidden;
}

.login-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  position: relative;
  z-index: 1;
  flex: 1;
}

/* Background floating course elements */
.login-page::before,
.login-page::after {
  content: '';
  position: absolute;
  z-index: 0;
  opacity: 0.05;
  pointer-events: none;
}
.login-page::before {
  top: -10vh;
  left: -20vw;
  width: 80vw;
  height: 80vw;
  border-radius: 40%;
  background: var(--primary-gradient);
  filter: blur(80px);
  transform: rotate(15deg);
}
.login-page::after {
  bottom: -10vh;
  right: -20vw;
  width: 70vw;
  height: 70vw;
  border-radius: 50%;
  background: radial-gradient(circle, var(--primary) 0%, transparent 70%);
  filter: blur(60px);
  opacity: 0.08;
}

.login-hero, .login-form, .version-text {
  position: relative;
  z-index: 1;
}

/* Hero Section */
.login-hero {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  margin-bottom: 70rpx;
  animation: slideDown 0.8s cubic-bezier(0.2, 0.8, 0.2, 1);
}

@keyframes slideDown {
  from { opacity: 0; transform: translateY(-40rpx); }
  to { opacity: 1; transform: translateY(0); }
}

.logo-circle {
  width: 160rpx;
  height: 160rpx;
  border-radius: 48rpx;
  background: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 40rpx;
  box-shadow: 0 20rpx 60rpx -10rpx rgba(59, 130, 246, 0.2);
  padding: 24rpx;
}
.logo-icon { 
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.school-name {
  font-size: 48rpx;
  font-weight: 800;
  color: var(--text-main);
  margin-bottom: 12rpx;
  letter-spacing: -0.5rpx;
}
.app-name { 
  font-size: 30rpx; 
  color: var(--text-sub); 
  letter-spacing: 2rpx; 
  font-weight: 500;
  background: rgba(241, 245, 249, 0.8);
  padding: 8rpx 24rpx;
  border-radius: 999rpx;
}

/* Form Card */
.login-form {
  width: 100%;
  padding: 64rpx 48rpx;
  border-radius: 48rpx;
  background: var(--bg-card);
  box-shadow: var(--shadow-card);
  border: 1rpx solid rgba(255,255,255,0.6);
  animation: slideUp 0.8s cubic-bezier(0.2, 0.8, 0.2, 1) 0.1s both;
}

@keyframes slideUp {
  from { opacity: 0; transform: translateY(60rpx); }
  to { opacity: 1; transform: translateY(0); }
}

.form-title {
  font-size: 40rpx;
  font-weight: 700;
  color: var(--text-main);
  display: block;
  margin-bottom: 60rpx;
  text-align: center;
  position: relative;
}
.form-title::after {
  content: '';
  position: absolute;
  bottom: -20rpx;
  left: 50%;
  transform: translateX(-50%);
  width: 60rpx;
  height: 8rpx;
  background: var(--primary);
  border-radius: 999rpx;
}

.form-item {
  margin-bottom: 40rpx;
  &.error .input-wrap { 
    border-color: #ef4444; 
    background: #fef2f2;
    animation: shake 0.4s cubic-bezier(.36,.07,.19,.97) both;
  }
}

@keyframes shake {
  10%, 90% { transform: translate3d(-1px, 0, 0); }
  20%, 80% { transform: translate3d(2px, 0, 0); }
  30%, 50%, 70% { transform: translate3d(-4px, 0, 0); }
  40%, 60% { transform: translate3d(4px, 0, 0); }
}

.input-wrap {
  display: flex;
  align-items: center;
  background: #f8fafc;
  border: 2rpx solid transparent;
  border-radius: 28rpx;
  padding: 0 32rpx;
  height: 112rpx;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  
  &:focus-within {
    background: #fff;
    border-color: var(--primary);
    box-shadow: 0 0 0 4rpx rgba(59, 130, 246, 0.15);
  }
}

.input-icon { font-size: 40rpx; margin-right: 24rpx; filter: grayscale(1); opacity: 0.6; }
.eye-icon  { font-size: 40rpx; margin-left: 20rpx; cursor: pointer; color: var(--text-sub); transition: color 0.2s; }
.eye-icon:active { color: var(--primary); }

.input {
  flex: 1;
  height: 100%;
  font-size: 32rpx;
  color: var(--text-main);
  background: transparent;
  font-weight: 500;
}
.input-placeholder { color: #94a3b8; font-weight: 400; }

/* Captcha Row */
.captcha-row {
  display: flex;
  gap: 20rpx;
  align-items: stretch;
}

.captcha-input-wrap {
  flex: 1;
}

.captcha-img-wrap {
  width: 240rpx;
  height: 112rpx;
  border-radius: 24rpx;
  overflow: hidden;
  flex-shrink: 0;
  cursor: pointer;
  background: #f8fafc;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2rpx solid transparent;
  transition: all 0.2s;
  
  &:active { 
    transform: scale(0.96); 
    border-color: var(--primary);
  }
}

.captcha-img {
  width: 100%;
  height: 100%;
}

.captcha-loading {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.captcha-loading-text {
  font-size: 24rpx;
  color: var(--text-sub);
}

.captcha-hint, .error-msg {
  display: block;
  font-size: 24rpx;
  margin-top: 12rpx;
  padding-left: 12rpx;
}
.captcha-hint { color: var(--text-sub); }
.error-msg { color: #ef4444; font-weight: 500; }

/* Login Button */
.login-btn {
  margin-top: 64rpx;
  height: 112rpx;
  border-radius: 28rpx;
  background: var(--primary-gradient);
  color: #ffffff;
  font-size: 34rpx;
  font-weight: 600;
  letter-spacing: 4rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  box-shadow: 0 20rpx 40rpx -10rpx rgba(59, 130, 246, 0.4);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  
  &:active {
    transform: scale(0.98);
    box-shadow: 0 10rpx 20rpx -5rpx rgba(59, 130, 246, 0.3);
  }
  
  &[disabled] {
    opacity: 0.7;
    filter: grayscale(0.5);
    box-shadow: none;
  }
}

.hint-text {
  display: block;
  text-align: center;
  font-size: 26rpx;
  color: var(--text-sub);
  margin-top: 40rpx;
}

.version-text {
  margin-top: auto;
  padding-top: 40rpx;
  font-size: 24rpx;
  color: #cbd5e1;
  letter-spacing: 2rpx;
  text-align: center;
  z-index: 1;
  position: relative;
}

/* Pad Layout */
@media (min-width: 768px) {
  .login-page { 
    padding: 0; 
    justify-content: center;
    background: #f1f5f9;
  }
  .login-page::before, .login-page::after { display: none; }
  
  .login-wrapper { 
    flex-direction: row; 
    justify-content: space-around; 
    align-items: center;
    max-width: 1000px;
    margin: 0 auto;
    padding: 60rpx;
    background: #fff;
    border-radius: 40rpx;
    box-shadow: 0 40rpx 80rpx -20rpx rgba(15, 23, 42, 0.1);
    min-height: 600rpx;
  }
  
  .login-hero { 
    flex: 1; 
    margin-bottom: 0; 
    align-items: flex-start;
    text-align: left;
    padding-left: 40rpx;
  }
  .login-form {
    width: 420px;
    box-shadow: none;
    border: 1rpx solid #e2e8f0;
  }
}
</style>
