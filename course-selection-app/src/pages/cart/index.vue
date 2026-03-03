<template>
  <view class="cart-page pad-container">
    <!-- 进度条 -->
    <view class="progress-card card">
      <view class="progress-header">
        <text class="progress-title">每周选课进度</text>
        <text class="progress-count" :class="isComplete ? 'complete' : 'incomplete'">
          {{ totalSelectedCount }} / 5 天
        </text>
      </view>

      <view class="progress-dots">
        <view
          v-for="d in 5"
          :key="d"
          class="progress-dot"
          :class="{ filled: hasDay(d) }"
        />
      </view>

      <text class="progress-hint" v-if="!isComplete">
        还需选 {{ 5 - totalSelectedCount }} 天课程才能提交
      </text>
      <text class="progress-hint complete" v-else-if="canSubmit">
        ✅ 周一到周五已选齐，可以提交补选！
      </text>
      <text class="progress-hint complete" v-else>
        您已完成本学期选课
      </text>
    </view>

    <!-- 选课车网格 -->
    <view class="grid-section">
      <weekly-cart-grid :removable="true" />
    </view>

    <!-- 去浏览按钮 -->
    <view class="browse-wrap" v-if="totalSelectedCount < 5">
      <button class="btn-outline" @click="goBrowse">去浏览课程</button>
    </view>

    <!-- 清空 + 提交 -->
    <view class="bottom-bar">
      <button
        class="clear-btn"
        :disabled="cartStore.selectedCount === 0"
        @click="handleClear"
      >清空</button>

      <button
        class="submit-btn"
        :class="{ 'submit-ready': canSubmit }"
        :disabled="!canSubmit || cartStore.submitting"
        :loading="cartStore.submitting"
        @click="handleSubmit"
      >
        {{ cartStore.submitting ? '提交中...' : '提交选课' }}
      </button>
    </view>

    <tab-bar current="pages/cart/index" />
    <view class="tab-bar-placeholder tab-bar-placeholder--with-bar" />
  </view>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { useCartStore } from '@/stores/cart'
import { safeHideTabBar } from '@/utils/tabBar'
import { getCurrentSemester } from '@/api/course'
import { getMySelections } from '@/api/selection'

const cartStore = useCartStore()
const confirmedWeekDays = ref<number[]>([])

// 合并已选课程与选课车：周一到周五每天只能一门，取并集
const totalSelectedCount = computed(() => {
  const cartDays = [1, 2, 3, 4, 5].filter(d => cartStore.hasWeekDay(d))
  const allDays = new Set([...confirmedWeekDays.value, ...cartDays])
  return allDays.size
})
const isComplete = computed(() => totalSelectedCount.value >= 5)
// 有选课车内容且满足五天时才能提交（避免已选满五天时误点提交）
const canSubmit = computed(() => isComplete.value && cartStore.selectedCount >= 1)

function hasDay(day: number) {
  return confirmedWeekDays.value.includes(day) || cartStore.hasWeekDay(day)
}

async function loadCart() {
  try {
    const semester = await getCurrentSemester()
    if (semester?.id) {
      await cartStore.fetchCart(semester.id)
      const selections = await getMySelections(semester.id)
      confirmedWeekDays.value = (selections || []).map(s => s.weekDay).filter(Boolean)
    }
  } catch {}
}

onMounted(loadCart)
onShow(() => {
  safeHideTabBar()
  loadCart()
})

function goBrowse() {
  uni.switchTab({ url: '/pages/course/list' })
}

function handleClear() {
  if (cartStore.selectedCount === 0) return
  uni.showModal({
    title: '清空选课车',
    content: '确认清空所有已选课程吗？',
    success: async (res) => {
      if (res.confirm) {
        try {
          await cartStore.clear()
          uni.showToast({ title: '已清空', icon: 'success' })
        } catch {}
      }
    }
  })
}

async function handleSubmit() {
  if (!canSubmit.value || cartStore.submitting) return
  uni.showModal({
    title: '确认提交',
    content: '提交后将生成正式选课记录，确认提交吗？',
    success: async (res) => {
      if (res.confirm) {
        try {
          await cartStore.submit()
          uni.reLaunch({ url: '/pages/cart/success' })
        } catch {}
      }
    }
  })
}
</script>

<style lang="scss" scoped>
.cart-page {
  padding: 32rpx;
  background: linear-gradient(180deg, #f1f5f9 0%, #f8fafc 30%, #ffffff 100%);
  min-height: 100vh;
}

.progress-card.card {
  margin-bottom: 28rpx;
  border-radius: 28rpx;
  padding: 32rpx 36rpx;
  box-shadow: 0 8rpx 32rpx rgba(15, 23, 42, 0.06), 0 2rpx 12rpx rgba(19, 127, 236, 0.04);
}

.progress-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 28rpx;
}

.progress-title { font-size: 32rpx; font-weight: 700; color: #0f172a; }

.progress-count {
  font-size: 30rpx;
  font-weight: 700;
  &.complete { color: #16a34a; }
  &.incomplete { color: #f59e0b; }
}

.progress-dots {
  display: flex;
  gap: 20rpx;
  margin-bottom: 24rpx;
}

.progress-dot {
  flex: 1;
  height: 16rpx;
  background: #e2e8f0;
  border-radius: 999rpx;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: inset 0 2rpx 4rpx rgba(0,0,0,0.04);

  &.filled {
    background: linear-gradient(90deg, #137fec 0%, #0d6bd9 100%);
    box-shadow: 0 0 16rpx rgba(19, 127, 236, 0.35);
  }
}

.progress-hint {
  font-size: 24rpx;
  color: #94a3b8;
  &.complete { color: #16a34a; font-weight: 500; }
}

.grid-section { margin-bottom: 24rpx; }

.browse-wrap {
  margin-bottom: 24rpx;
}

.bottom-bar {
  position: fixed;
  bottom: 140rpx;
  left: 0;
  right: 0;
  display: flex;
  gap: 20rpx;
  padding: 20rpx 32rpx;
  padding-bottom: calc(20rpx + env(safe-area-inset-bottom));
  background: #fff;
  border-top: 1rpx solid #f1f5f9;
  box-shadow: 0 -4rpx 20rpx rgba(0, 0, 0, 0.04);
  z-index: 998;
}

.clear-btn {
  flex: 1;
  height: 88rpx;
  line-height: 88rpx;
  border-radius: 44rpx;
  background: #f1f5f9;
  color: #4c739a;
  font-size: 30rpx;
  border: none;
  &::after { border: none; }
  &[disabled] { opacity: 0.4; }
}

.submit-btn {
  flex: 2;
  height: 92rpx;
  line-height: 92rpx;
  border-radius: 46rpx;
  background: #c0d9f5;
  color: #fff;
  font-size: 32rpx;
  font-weight: 700;
  border: none;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  &::after { border: none; }

  &.submit-ready {
    background: linear-gradient(135deg, #137fec 0%, #0d6bd9 100%);
    box-shadow: 0 8rpx 28rpx rgba(19, 127, 236, 0.35);
  }
  &[disabled]:not(.submit-ready) { opacity: 0.6; }
  &:active.submit-ready { transform: scale(0.98); }
}


/* Pad 适配 */
@media (min-width: 768px) {
  .cart-page { padding-left: 48rpx; padding-right: 48rpx; }
  .bottom-bar {
    left: 50%;
    transform: translateX(-50%);
    max-width: 900px;
    bottom: 160rpx;
    border-radius: 24rpx;
    padding: 24rpx 48rpx;
    padding-bottom: calc(24rpx + env(safe-area-inset-bottom));
  }
}
</style>
