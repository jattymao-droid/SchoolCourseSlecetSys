<script setup lang="ts">
import { onLaunch } from '@dcloudio/uni-app'
import { safeHideTabBar } from '@/utils/tabBar'

onLaunch(() => {
  safeHideTabBar()
  const token = uni.getStorageSync('token')
  if (token) {
    uni.switchTab({ url: '/pages/home/index' })
  } else {
    // 延迟执行，避免与小程序初始化冲突导致 reLaunch timeout
    setTimeout(() => {
      uni.reLaunch({
        url: '/pages/login/index',
        fail: () => {
          uni.navigateTo({ url: '/pages/login/index' })
        }
      })
    }, 100)
  }
})
</script>

<style lang="scss">
/* 全局样式 */
@import 'uni.scss';

page {
  background: $uni-bg-color-grey;
  font-family: -apple-system, BlinkMacSystemFont, 'PingFang SC', 'Helvetica Neue', sans-serif;
  color: $uni-text-color;
  font-size: $uni-font-size-base;
  box-sizing: border-box;

  /* CSS Variables for Design System */
  --primary: #{$uni-color-primary};
  --primary-dark: #{$uni-color-primary-dark};
  --primary-light: #{$uni-color-primary-light};
  --primary-gradient: linear-gradient(135deg, #{$uni-color-primary} 0%, #{$uni-color-primary-dark} 100%);
  --bg-page: #{$uni-bg-color-grey};
  --bg-card: #{$uni-bg-color};
  --bg-input: #{$uni-bg-color-hover};
  --text-main: #{$uni-text-color};
  --text-sub: #{$uni-text-color-grey};
  --text-placeholder: #{$uni-text-color-placeholder};
  --border-color: #{$uni-border-color};
  --shadow-sm: #{$uni-shadow-sm};
  --shadow-card: #{$uni-shadow-base};
  --shadow-primary: rgba(59, 130, 246, 0.3);
  --radius-sm: #{$uni-border-radius-sm};
  --radius-base: #{$uni-border-radius-base};
  --radius-lg: #{$uni-border-radius-lg};
  --radius-xl: #{$uni-border-radius-xl};
}

view, scroll-view, swiper, button, input, textarea, label, navigator, image { 
  box-sizing: border-box; 
}

/* 工具类 */
.flex { display: flex; }
.flex-col { display: flex; flex-direction: column; }
.items-center { align-items: center; }
.justify-between { justify-content: space-between; }
.justify-center { justify-content: center; }
.flex-1 { flex: 1; }
.text-center { text-align: center; }

/* 主色 */
.text-primary { color: $uni-color-primary; }
.bg-primary { background-color: $uni-color-primary; }

/* 卡片：现代阴影 */
.card {
  background: $uni-bg-color;
  border-radius: $uni-border-radius-lg;
  padding: $uni-spacing-row-lg;
  margin-bottom: $uni-spacing-col-base;
  box-shadow: $uni-shadow-sm;
  border: 1rpx solid $uni-border-color;
  transition: box-shadow 0.2s ease, transform 0.2s ease;
  
  &:active {
    transform: scale(0.995);
    box-shadow: $uni-shadow-base;
  }
}

/* 按钮：现代风格 */
.btn-primary {
  background: linear-gradient(135deg, $uni-color-primary 0%, $uni-color-primary-dark 100%);
  color: $uni-text-color-inverse;
  border-radius: $uni-border-radius-base;
  padding: 24rpx 0;
  text-align: center;
  font-size: $uni-font-size-lg;
  font-weight: 600;
  width: 100%;
  border: none;
  box-shadow: $uni-shadow-base;
  transition: opacity 0.2s, box-shadow 0.2s, transform 0.1s;
  
  &::after { border: none; }
  
  &:active { 
    opacity: 0.9; 
    transform: translateY(2rpx);
    box-shadow: $uni-shadow-sm;
  }
}

.btn-primary[disabled],
.btn-primary.disabled {
  background: $uni-text-color-disable;
  color: $uni-text-color-inverse;
  box-shadow: none;
  opacity: 0.8;
}

.btn-outline {
  background: transparent;
  color: $uni-color-primary;
  border: 2rpx solid $uni-color-primary;
  border-radius: $uni-border-radius-base;
  padding: 22rpx 0;
  text-align: center;
  font-size: $uni-font-size-lg;
  font-weight: 600;
  width: 100%;
  transition: background 0.2s, color 0.2s;
  
  &::after { border: none; }
  
  &:active { 
    background: rgba($uni-color-primary, 0.05); 
  }
}

/* 底部菜单占位：统一高度，避免内容被遮挡 */
.tab-bar-placeholder {
  height: 140rpx;
  flex-shrink: 0;
}
/* 选课车页：底部有操作栏，需更大占位 */
.tab-bar-placeholder--with-bar {
  height: 260rpx;
}

/* 标签 */
.tag {
  display: inline-block;
  padding: 6rpx 16rpx;
  border-radius: 999rpx;
  font-size: $uni-font-size-sm;
  font-weight: 500;
}

/* Pad 适配：内容区最大宽度、居中 */
@media (min-width: 768px) {
  .pad-container {
    max-width: 900px;
    margin-left: auto;
    margin-right: auto;
  }
  .pad-px { padding-left: 48rpx; padding-right: 48rpx; }
}
</style>
