<template>
  <view class="course-card" :class="cardClass" @click="$emit('click')">
    <view class="card-inner">
      <!-- 左侧渐变色条 -->
      <view class="week-strip" :style="{ background: stripGradient }" />
      <view class="card-main">
        <!-- 头部：课程名 + 星期标签 -->
        <view class="card-header">
          <text class="course-name">{{ course.courseName }}</text>
          <view class="week-badge" :style="weekBadgeStyle">{{ weekLabel }}</view>
        </view>

        <!-- 信息行：年级、教师、地点 -->
        <view v-if="course.gradeName || course.teacherName || course.location" class="card-info">
          <view v-if="course.gradeName" class="info-chip">
            <text class="info-icon">📚</text>
            <text class="info-text">{{ course.gradeName }}</text>
          </view>
          <view v-if="course.teacherName" class="info-chip">
            <text class="info-icon">👨‍🏫</text>
            <text class="info-text">{{ course.teacherName }}</text>
          </view>
          <view v-if="course.location" class="info-chip">
            <text class="info-icon">📍</text>
            <text class="info-text">{{ course.location }}</text>
          </view>
        </view>

        <!-- 名额进度 -->
        <view class="quota-section">
          <view class="quota-bar">
            <view class="quota-fill" :style="quotaStyle" />
          </view>
          <text class="quota-text" :class="quotaTextClass">{{ remaining }}/{{ quota }} 剩余</text>
        </view>

        <!-- 操作按钮 -->
        <button
          class="add-btn"
          :class="btnClass"
          :disabled="btnDisabled"
          @click.stop="handleAdd"
        >{{ btnLabel }}</button>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { storeToRefs } from 'pinia'
import { useCartStore } from '@/stores/cart'
import type { Course } from '@/types'

const props = defineProps<{ course: Course }>()
const emit = defineEmits<{ click: []; add: [id: string | number] }>()
const cartStore = useCartStore()
const { cartMap } = storeToRefs(cartStore)

const WEEK_LABELS = ['', '周一', '周二', '周三', '周四', '周五']
const WEEK_BG = ['', '#eff6ff', '#f5f3ff', '#f0fdf4', '#fffbeb', '#fff1f2']
const COLOR_BARS = ['', '#3b82f6', '#8b5cf6', '#10b981', '#f59e0b', '#ef4444']

const weekLabel = computed(() => WEEK_LABELS[props.course.weekDay] || `周${props.course.weekDay}`)
const weekBg = computed(() => WEEK_BG[props.course.weekDay] || '#eff6ff')
const colorBar = computed(() => COLOR_BARS[props.course.weekDay] || '#137fec')

/** 左侧色条渐变 */
const stripGradient = computed(() => {
  const c = colorBar.value
  return `linear-gradient(180deg, ${c} 0%, ${c}dd 50%, ${c}99 100%)`
})

/** 星期标签样式（与色条呼应） */
const weekBadgeStyle = computed(() => ({
  background: weekBg.value,
  color: colorBar.value,
  borderColor: `${colorBar.value}40`
}))

const cardClass = computed(() => ({
  'in-cart': isSelected.value,
  'is-full': isFull.value,
  'day-occupied': weekDayOccupied.value
}))

const quota = computed(() => props.course.quota ?? props.course.totalQuota ?? 0)
const selected = computed(() => props.course.selected ?? props.course.selectedCount ?? 0)
const remaining = computed(() => quota.value - selected.value)
const quotaPercent = computed(() => {
  const q = quota.value
  return q > 0 ? Math.max(0, Math.min(100, (remaining.value / q) * 100)) : 0
})

const quotaStyle = computed(() => {
  const pct = quotaPercent.value
  let bg = 'linear-gradient(90deg, #137fec 0%, #0d6bd9 100%)'
  if (remaining.value <= 0) bg = 'linear-gradient(90deg, #94a3b8 0%, #64748b 100%)'
  else if (remaining.value <= 5) bg = 'linear-gradient(90deg, #f59e0b 0%, #d97706 100%)'
  else if (remaining.value <= 10) bg = 'linear-gradient(90deg, #eab308 0%, #ca8a04 100%)'
  return { width: pct + '%', background: bg }
})

const quotaTextClass = computed(() => {
  if (remaining.value <= 0) return 'quota-empty'
  if (remaining.value <= 5) return 'quota-low'
  if (remaining.value <= 10) return 'quota-medium'
  return ''
})

const normId = (id: string | number) => String(id)
const inCart = computed(() => {
  const item = cartMap.value[props.course.weekDay]
  return item != null && normId(item.courseId) === normId(props.course.id)
})

/** 已选：在选课车或已提交选课 */
const isSelected = computed(() => cartStore.isCourseSelected(props.course.id))

const isFull = computed(() => remaining.value <= 0)
const weekDayOccupied = computed(() => {
  const item = cartMap.value[props.course.weekDay]
  return item != null && !inCart.value
})

const btnLabel = computed(() => {
  if (isSelected.value) return '已选'
  if (isFull.value) return '已满员'
  if (weekDayOccupied.value) return '该天已选'
  return '+ 加入'
})

const btnClass = computed(() => {
  if (isSelected.value) return 'btn-selected'
  if (isFull.value) return 'btn-full'
  if (weekDayOccupied.value) return 'btn-disabled'
  return 'btn-add'
})

const btnDisabled = computed(() =>
  isFull.value || weekDayOccupied.value || isSelected.value
)

async function handleAdd() {
  if (btnDisabled.value) return
  if (!cartStore.currentSemesterId) {
    uni.showToast({ title: '请先回到首页加载学期信息', icon: 'none' })
    return
  }
  try {
    await cartStore.add(props.course.id)
    uni.showToast({ title: '已加入选课车', icon: 'success' })
    emit('add', props.course.id)
  } catch {}
}
</script>

<style lang="scss" scoped>
.course-card {
  position: relative;
  background: linear-gradient(145deg, #ffffff 0%, #fafbfc 100%);
  border-radius: 28rpx;
  margin-bottom: 24rpx;
  overflow: hidden;
  box-shadow:
    0 2rpx 8rpx rgba(15, 23, 42, 0.03),
    0 8rpx 24rpx rgba(15, 23, 42, 0.05),
    0 1rpx 0 rgba(255, 255, 255, 0.8) inset;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border: 1rpx solid rgba(226, 232, 240, 0.6);

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 1rpx;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.9), transparent);
    pointer-events: none;
  }

  &:active {
    transform: scale(0.995);
    box-shadow:
      0 2rpx 6rpx rgba(15, 23, 42, 0.04),
      0 4rpx 16rpx rgba(15, 23, 42, 0.06);
  }

  &.in-cart {
    border-color: rgba(34, 197, 94, 0.35);
    box-shadow:
      0 4rpx 16rpx rgba(34, 197, 94, 0.08),
      0 12rpx 32rpx rgba(34, 197, 94, 0.06);
    background: linear-gradient(145deg, #f0fdf4 0%, #ecfdf5 50%, #d1fae5 100%);
  }
  &.is-full {
    opacity: 0.72;
    filter: grayscale(0.5) saturate(0.85);
  }
}

.card-inner {
  display: flex;
  min-height: 260rpx;
}

.week-strip {
  width: 6rpx;
  flex-shrink: 0;
  border-radius: 28rpx 0 0 28rpx;
}

.card-main {
  flex: 1;
  padding: 36rpx 32rpx 32rpx;
  display: flex;
  flex-direction: column;
  gap: 24rpx;
  min-width: 0;
}

.card-header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 20rpx;
}

.course-name {
  flex: 1;
  font-size: 36rpx;
  font-weight: 700;
  color: #0f172a;
  line-height: 1.32;
  letter-spacing: -0.8rpx;
  min-width: 0;
}

.week-badge {
  flex-shrink: 0;
  padding: 10rpx 20rpx;
  border-radius: 16rpx;
  font-size: 22rpx;
  font-weight: 700;
  border: 1.5rpx solid;
  letter-spacing: 0.8rpx;
}

/* 信息胶囊 */
.card-info {
  display: flex;
  flex-wrap: wrap;
  gap: 12rpx 16rpx;
}

.info-chip {
  display: inline-flex;
  align-items: center;
  gap: 6rpx;
  padding: 8rpx 16rpx;
  background: rgba(241, 245, 249, 0.8);
  border-radius: 20rpx;
  border: 1rpx solid rgba(226, 232, 240, 0.5);
}

.info-icon {
  font-size: 24rpx;
  opacity: 0.85;
}

.info-text {
  font-size: 24rpx;
  font-weight: 500;
  color: #475569;
  letter-spacing: 0.2rpx;
}

.quota-section {
  display: flex;
  align-items: center;
  gap: 24rpx;
  padding: 8rpx 0 4rpx;
}

.quota-bar {
  flex: 1;
  height: 10rpx;
  background: rgba(226, 232, 240, 0.6);
  border-radius: 999rpx;
  overflow: hidden;
}

.quota-fill {
  height: 100%;
  border-radius: 999rpx;
  transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1), background 0.4s;
}

.quota-text {
  font-size: 24rpx;
  color: #475569;
  flex-shrink: 0;
  min-width: 100rpx;
  text-align: right;
  font-weight: 600;
  letter-spacing: 0.3rpx;

  &.quota-medium { color: #b45309; }
  &.quota-low { color: #c2410c; }
  &.quota-empty { color: #94a3b8; font-weight: 500; }
}

.add-btn {
  width: 100%;
  padding: 28rpx 36rpx;
  border-radius: 20rpx;
  font-size: 30rpx;
  font-weight: 600;
  border: none;
  margin-top: 8rpx;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  letter-spacing: 0.5rpx;
  &::after { border: none; }
}

.btn-add {
  background: var(--primary-gradient);
  color: #fff;
  box-shadow:
    0 4rpx 12rpx -2rpx rgba(37, 99, 235, 0.25),
    0 2rpx 4rpx rgba(37, 99, 235, 0.1);

  &:active {
    transform: scale(0.98);
    opacity: 0.96;
  }
}

/* 按钮状态样式 */
.btn-selected.add-btn {
  background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%) !important;
  color: #166534 !important;
  border: 1.5rpx solid rgba(74, 222, 128, 0.5) !important;
  box-shadow: 0 2rpx 8rpx rgba(34, 197, 94, 0.12) !important;
}

.btn-full.add-btn {
  background: linear-gradient(135deg, #fef9c3 0%, #fef08a 100%) !important;
  color: #854d0e !important;
  border: 1.5rpx solid rgba(253, 224, 71, 0.5) !important;
  box-shadow: 0 2rpx 8rpx rgba(245, 158, 11, 0.1) !important;
}

.btn-countdown.add-btn {
  background: linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%) !important;
  color: #3730a3 !important;
  border: 1.5rpx solid rgba(165, 180, 252, 0.5) !important;
  box-shadow: none !important;
}

.btn-ended.add-btn,
.btn-disabled.add-btn {
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%) !important;
  color: #94a3b8 !important;
  border: 1.5rpx solid #e2e8f0 !important;
  box-shadow: none !important;
}
</style>
