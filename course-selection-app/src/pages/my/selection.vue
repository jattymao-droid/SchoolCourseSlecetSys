<template>
  <view class="selection-page pad-container">
    <empty-state
      v-if="!loading && !selections.length"
      icon="📭"
      title="暂无选课记录"
      desc="本学期尚未提交选课"
      btn-text="去选课"
      @action="goCourse"
    />

    <scroll-view
      v-else
      scroll-y
      class="list-scroll"
      :refresher-enabled="true"
      :refresher-triggered="refreshing"
      @refresherrefresh="onRefresh"
    >
      <view class="list-inner">
        <view v-for="item in selections" :key="item.id" class="selection-item card">
          <view class="item-left">
            <view class="day-chip" :style="{ background: dayBg[item.weekDay], color: dayColor[item.weekDay] }">
              {{ dayLabels[item.weekDay] }}
            </view>
          </view>
          <view class="item-info">
            <text class="item-name">{{ item.courseName }}</text>
            <text class="item-teacher" v-if="item.teacherName">{{ item.teacherName }}</text>
            <text class="item-location" v-if="item.location">{{ item.location }}</text>
          </view>
          <text v-if="item.assigned === 1" class="assigned-tag">指定</text>
          <button v-else class="drop-btn" @click="handleDrop(item)">退课</button>
        </view>

        <view v-if="loading" class="loading-text"><text>加载中...</text></view>
      </view>
    </scroll-view>
  </view>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getMySelections, dropCourse, type MySelectionVO } from '@/api/selection'
import { getCurrentSemester } from '@/api/course'
import { useCartStore } from '@/stores/cart'

const cartStore = useCartStore()
const selections = ref<MySelectionVO[]>([])
const loading = ref(false)
const refreshing = ref(false)
const semesterId = ref<string | number>('')

const dayLabels: Record<number, string> = { 1: '周一', 2: '周二', 3: '周三', 4: '周四', 5: '周五' }
const dayColor: Record<number, string> = { 1: '#3b82f6', 2: '#8b5cf6', 3: '#10b981', 4: '#f59e0b', 5: '#ef4444' }
const dayBg: Record<number, string> = { 1: '#eff6ff', 2: '#f5f3ff', 3: '#f0fdf4', 4: '#fffbeb', 5: '#fff1f2' }

async function loadData() {
  loading.value = true
  try {
    if (!semesterId.value) {
      const sem = await getCurrentSemester()
      semesterId.value = sem?.id || ''
    }
    if (!semesterId.value) return
    selections.value = (await getMySelections(semesterId.value)).sort((a, b) => a.weekDay - b.weekDay)
  } finally {
    loading.value = false
  }
}

async function onRefresh() {
  refreshing.value = true
  await loadData()
  refreshing.value = false
}

function handleDrop(item: MySelectionVO) {
  if (item.assigned === 1) {
    uni.showToast({ title: '该课程为管理员指定，不可退课', icon: 'none' })
    return
  }
  uni.showModal({
    title: '确认退课',
    content: `退课后，所有已选课程将退回选课车，「${item.courseName}」将被移除。您需在选课车中补选后提交。确认退课吗？`,
    confirmColor: '#ef4444',
    success: async (res) => {
      if (res.confirm) {
        uni.showLoading({ title: '退课中...', mask: true })
        try {
          const result = await dropCourse(item.id)
          // 用后端返回的选课车数据直接更新 store，确保三端（H5/小程序/App）正确显示
          if (result?.cart && typeof result.cart === 'object') {
            cartStore.setCartFromData(result.cart as Record<string, unknown>)
          } else {
            // 兼容旧接口：若无 cart 则重新拉取
            if (!semesterId.value) {
              const sem = await getCurrentSemester()
              semesterId.value = sem?.id || ''
            }
            if (semesterId.value) {
              await cartStore.fetchCart(semesterId.value)
            }
          }
          await loadData()
          uni.showToast({ title: '退课成功，请到选课车补选课程', icon: 'success' })
          setTimeout(() => {
            uni.switchTab({ url: '/pages/cart/index' })
          }, 500)
        } catch {
          // 错误已由 request 拦截器展示
        } finally {
          uni.hideLoading()
        }
      }
    }
  })
}

function goCourse() {
  uni.switchTab({ url: '/pages/course/list' })
}

onMounted(loadData)
</script>

<style lang="scss" scoped>
.selection-page { background: #f6f7f8; min-height: 100vh; }

.list-scroll { height: 100vh; }

.list-inner { padding: 24rpx 32rpx; }

.selection-item {
  display: flex;
  align-items: center;
  gap: 20rpx;
}

.item-left { flex-shrink: 0; }

.day-chip {
  width: 80rpx;
  height: 80rpx;
  border-radius: 16rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 26rpx;
  font-weight: 700;
}

.item-info { flex: 1; }
.item-name { display: block; font-size: 30rpx; font-weight: 700; color: #0d141b; margin-bottom: 6rpx; }
.item-teacher { display: block; font-size: 24rpx; color: #4c739a; margin-bottom: 4rpx; }
.item-location { font-size: 22rpx; color: #94a3b8; }

.drop-btn {
  flex-shrink: 0;
  padding: 12rpx 24rpx;
  border-radius: 999rpx;
  background: #fff1f2;
  color: #ef4444;
  font-size: 26rpx;
  font-weight: 600;
  border: 2rpx solid #fecaca;
  &::after { border: none; }
}

.assigned-tag {
  flex-shrink: 0;
  font-size: 22rpx;
  color: #64748b;
  background: #f1f5f9;
  padding: 8rpx 16rpx;
  border-radius: 8rpx;
}

.loading-text { text-align: center; padding: 48rpx; color: #94a3b8; font-size: 28rpx; }

/* Pad 适配 */
@media (min-width: 768px) {
  .selection-page { padding-left: 48rpx; padding-right: 48rpx; }
  .list-inner { padding: 32rpx 48rpx; }
}
</style>
