<template>
  <view class="tab-bar">
    <view
      v-for="item in tabs"
      :key="item.path"
      class="tab-item"
      :class="{ active: currentPath === item.path }"
      @click="switchTab(item.path)"
    >
      <view class="tab-inner">
        <view class="icon-wrap">
          <image 
            class="tab-svg-img" 
            :src="`/static/tabs/${item.icon}-${currentPath === item.path ? 'active' : 'default'}.svg`" 
            mode="aspectFit" 
          />
          <view v-if="item.badge && cartBadge" class="badge">{{ cartBadge }}</view>
        </view>
        <text class="tab-label">{{ item.label }}</text>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useCartStore } from '@/stores/cart'

const props = defineProps<{ current: string }>()
const cartStore = useCartStore()

const cartBadge = computed(() => cartStore.badgeText)
const currentPath = computed(() => props.current)

const tabs = [
  { path: 'pages/home/index', label: '首页', icon: 'home', badge: false },
  { path: 'pages/course/list', label: '课程', icon: 'course', badge: false },
  { path: 'pages/cart/index', label: '选课车', icon: 'cart', badge: true },
  { path: 'pages/schedule/index', label: '课表', icon: 'schedule', badge: false },
  { path: 'pages/profile/index', label: '我的', icon: 'profile', badge: false }
]

function switchTab(path: string) {
  uni.switchTab({ url: `/${path}` })
}
</script>

<style lang="scss" scoped>
.tab-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  height: calc(110rpx + env(safe-area-inset-bottom));
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20rpx);
  -webkit-backdrop-filter: blur(20rpx);
  border-top: 1rpx solid rgba(226, 232, 240, 0.6);
  display: flex;
  align-items: center;
  justify-content: space-around;
  padding: 0 16rpx;
  padding-bottom: env(safe-area-inset-bottom);
  z-index: 999;
  box-shadow: 0 -8rpx 32rpx rgba(0, 0, 0, 0.06), 0 -2rpx 12rpx rgba(19, 127, 236, 0.04);
}

.tab-item {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 12rpx 0;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  cursor: pointer;

  &:active {
    transform: scale(0.95);
  }
}

.tab-inner {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 8rpx 20rpx;
  border-radius: 20rpx;
  transition: all 0.3s ease;
}

.tab-item.active .tab-inner {
  background: linear-gradient(135deg, rgba(19, 127, 236, 0.12) 0%, rgba(13, 107, 217, 0.08) 100%);
}

.tab-item {
  color: #94a3b8;
  .tab-label {
    font-size: 22rpx;
    font-weight: 500;
    transition: color 0.3s ease;
  }
}

.tab-item.active {
  color: #137fec;
  .tab-label {
    font-weight: 600;
    color: #137fec;
  }
  .tab-svg {
    transform: scale(1.1);
  }
}

.icon-wrap {
  position: relative;
  width: 48rpx;
  height: 48rpx;
  margin-bottom: 6rpx;
  display: flex;
  align-items: center;
  justify-content: center;
}

.tab-svg-img {
  width: 44rpx;
  height: 44rpx;
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.tab-item.active .tab-svg-img {
  transform: scale(1.1);
}

.badge {
  position: absolute;
  top: -10rpx;
  right: -14rpx;
  min-width: 36rpx;
  height: 36rpx;
  background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
  color: #fff;
  border-radius: 999rpx;
  font-size: 20rpx;
  font-weight: 700;
  line-height: 36rpx;
  text-align: center;
  padding: 0 8rpx;
  box-shadow: 0 4rpx 12rpx rgba(239, 68, 68, 0.45);
  border: 2rpx solid #fff;
}

.tab-label {
  font-size: 22rpx;
}

/* Pad 适配：底部居中悬浮 */
@media (min-width: 768px) {
  .tab-bar {
    left: 50%;
    transform: translateX(-50%);
    width: auto;
    max-width: 560px;
    bottom: 28rpx;
    border-radius: 28rpx;
    padding: 16rpx 32rpx;
    padding-bottom: calc(16rpx + env(safe-area-inset-bottom));
    box-shadow: 0 12rpx 48rpx rgba(0, 0, 0, 0.1), 0 4rpx 16rpx rgba(19, 127, 236, 0.06);
    border: 1rpx solid rgba(226, 232, 240, 0.8);
  }
  .tab-item {
    padding: 12rpx 16rpx;
  }
  .tab-inner {
    padding: 12rpx 24rpx;
    border-radius: 24rpx;
  }
  .icon-wrap {
    width: 52rpx;
    height: 52rpx;
    margin-bottom: 8rpx;
  }
  .tab-svg {
    width: 52rpx;
    height: 52rpx;
  }
  .tab-label { font-size: 24rpx; }
}
</style>
