<template>
  <view class="profile-page pad-container">
    <!-- 用户信息头部 -->
    <view class="profile-hero">
      <view class="profile-avatar">
        <text class="avatar-text">{{ avatarText }}</text>
      </view>
      <text class="profile-name">{{ authStore.studentName }}</text>
      <text class="profile-class">{{ authStore.className }}</text>
    </view>

    <!-- 功能菜单 -->
    <view class="menu-section card">
      <view class="menu-item" @click="goMySelection">
        <text class="menu-icon">📋</text>
        <text class="menu-label">我的选课</text>
        <text class="menu-arrow">›</text>
      </view>
      <view class="menu-divider" />
      <view class="menu-item" @click="goEvaluation">
        <text class="menu-icon">⭐</text>
        <text class="menu-label">课程评价</text>
        <text class="menu-arrow">›</text>
      </view>
      <view class="menu-divider" />
      <view class="menu-item" @click="goPassword">
        <text class="menu-icon">🔑</text>
        <text class="menu-label">修改密码</text>
        <text class="menu-arrow">›</text>
      </view>
    </view>

    <!-- 关于 -->
    <view class="menu-section card">
      <view class="menu-item">
        <text class="menu-icon">ℹ️</text>
        <text class="menu-label">关于应用</text>
        <text class="menu-value">v1.0.0</text>
      </view>
      <view class="menu-divider" />
      <view class="menu-item">
        <text class="menu-icon">🏫</text>
        <text class="menu-label">系统开发：东陆信息中心  </text>
        <text class="menu-link" @click="callDeveloper">王茂明</text>
      </view>
    </view>

    <!-- 退出登录 -->
    <view class="logout-wrap">
      <button class="logout-btn" @click="handleLogout">退出登录</button>
    </view>

    <tab-bar current="pages/profile/index" />
    <view class="tab-bar-placeholder" />
  </view>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { useAuthStore } from '@/stores/auth'
import { safeHideTabBar } from '@/utils/tabBar'

const authStore = useAuthStore()

const avatarText = computed(() => {
  const name = authStore.studentName
  return name ? name.charAt(0) : '学'
})

function goMySelection() { uni.navigateTo({ url: '/pages/my/selection' }) }
function goEvaluation() { uni.navigateTo({ url: '/pages/my/evaluation' }) }
function goPassword() { uni.navigateTo({ url: '/pages/profile/password' }) }

function callDeveloper() {
  uni.makePhoneCall({ phoneNumber: '15825100582' })
}

onShow(() => safeHideTabBar())

function handleLogout() {
  uni.showModal({
    title: '退出登录',
    content: '确认退出当前账号吗？',
    success: (res) => {
      if (res.confirm) authStore.logout()
    }
  })
}
</script>

<style lang="scss" scoped>
.profile-page {
  background: var(--bg-page);
  min-height: 100vh;
  padding-bottom: calc(var(--window-bottom) + 24rpx);
}

.profile-hero {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: calc(var(--status-bar-height) + 80rpx) 32rpx 80rpx;
  background: var(--primary-gradient);
  position: relative;
  overflow: hidden;
  border-radius: 0 0 48rpx 48rpx;
  box-shadow: 0 20rpx 40rpx -10rpx rgba(15, 23, 42, 0.15);
  margin-bottom: 40rpx;
}
.profile-hero::before {
  content: '';
  position: absolute;
  top: -50%;
  right: -20%;
  width: 100%;
  height: 200%;
  background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 60%);
  pointer-events: none;
}

.profile-avatar {
  width: 160rpx;
  height: 160rpx;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 32rpx;
  box-shadow: 0 12rpx 32rpx rgba(0, 0, 0, 0.15);
  border: 4rpx solid rgba(255, 255, 255, 0.4);
  position: relative;
  z-index: 1;
}
.avatar-text { font-size: 64rpx; color: #fff; font-weight: 700; }

.profile-name { 
  font-size: 44rpx; 
  font-weight: 800; 
  color: #fff; 
  margin-bottom: 12rpx; 
  text-shadow: 0 2rpx 4rpx rgba(0,0,0,0.1); 
  position: relative; 
  z-index: 1; 
}
.profile-class { 
  font-size: 28rpx; 
  color: rgba(255,255,255,0.85); 
  background: rgba(0,0,0,0.1);
  padding: 6rpx 20rpx;
  border-radius: 999rpx;
  position: relative; 
  z-index: 1; 
}

.menu-section {
  margin: 0 32rpx 32rpx;
  overflow: hidden;
  padding: 0;
  background: var(--bg-card);
  border-radius: 32rpx;
  box-shadow: var(--shadow-card);
}

.menu-item {
  display: flex;
  align-items: center;
  padding: 36rpx 32rpx;
  cursor: pointer;
  transition: all 0.2s;
  
  &:active { 
    background: #f8fafc; 
  }
}

.menu-icon { font-size: 40rpx; margin-right: 24rpx; filter: grayscale(0.2); }
.menu-label { flex: 1; font-size: 30rpx; color: var(--text-main); font-weight: 500; }
.menu-link { font-size: 30rpx; color: #137fec; font-weight: 500; text-decoration: underline; }
.menu-arrow { font-size: 32rpx; color: #cbd5e1; font-weight: 600; }
.menu-value { font-size: 26rpx; color: var(--text-sub); margin-right: 12rpx; }

.menu-divider {
  height: 1rpx;
  background: #f1f5f9;
  margin: 0 32rpx;
}

.logout-wrap {
  margin: 60rpx 32rpx 40rpx;
}

.logout-btn {
  width: 100%;
  height: 96rpx;
  line-height: 96rpx;
  border-radius: 28rpx;
  background: #fee2e2;
  color: #ef4444;
  font-size: 32rpx;
  font-weight: 600;
  border: none;
  transition: all 0.2s;
  
  &::after { border: none; }
  &:active { 
    transform: scale(0.98);
    background: #fecaca;
  }
}

/* Pad 适配 */
@media (min-width: 768px) {
  .profile-page { padding-left: 0; padding-right: 0; align-items: center; }
  .profile-hero { 
    width: 100%; 
    padding-top: 120rpx;
    border-radius: 0 0 60rpx 60rpx;
  }
  .menu-section, .logout-wrap {
    width: 100%;
    max-width: 800rpx;
    margin-left: auto;
    margin-right: auto;
  }
}
</style>
