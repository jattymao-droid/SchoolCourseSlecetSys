<template>
  <view class="empty-state">
    <text class="empty-icon">{{ icon }}</text>
    <text class="empty-title">{{ title }}</text>
    <text v-if="desc" class="empty-desc">{{ desc }}</text>
    <button v-if="btnText" class="btn-primary empty-btn" @click="$emit('action')">{{ btnText }}</button>
  </view>
</template>

<script setup lang="ts">
defineProps<{
  icon?: string
  title?: string
  desc?: string
  btnText?: string
}>()
defineEmits<{ action: [] }>()
</script>

<style lang="scss" scoped>
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 80rpx 40rpx;
  position: relative;
}

.empty-icon {
  font-size: 96rpx;
  margin-bottom: 28rpx;
  padding: 36rpx;
  background: linear-gradient(135deg, #f0f7ff 0%, #e8f3ff 100%);
  border-radius: 50%;
  box-shadow: 0 8rpx 32rpx rgba(15, 23, 42, 0.06), 0 2rpx 12rpx rgba(19, 127, 236, 0.08);
}

.empty-title {
  font-size: 32rpx;
  font-weight: 600;
  color: #334155;
  margin-bottom: 12rpx;
}

.empty-desc {
  font-size: 26rpx;
  color: #64748b;
  text-align: center;
  margin-bottom: 40rpx;
  line-height: 1.5;
}

.empty-btn {
  max-width: 320rpx;
  box-shadow: 0 6rpx 20rpx rgba(19, 127, 236, 0.2);
}
</style>
