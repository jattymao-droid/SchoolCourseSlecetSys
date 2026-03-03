<template>
  <view class="detail-page pad-container" v-if="course">
    <!-- 顶部色块 -->
    <view class="detail-hero" :style="{ background: heroBg }">
      <view class="week-badge">{{ weekLabel }}</view>
      <text class="detail-title">{{ course.courseName }}</text>
      <text class="detail-teacher" v-if="course.teacherName">👨‍🏫 {{ course.teacherName }}</text>
    </view>

    <!-- 信息区 -->
    <view class="info-section card">
      <view class="info-row" v-if="course.gradeName">
        <text class="info-icon">📚</text>
        <view>
          <text class="info-label">适用年级</text>
          <text class="info-value">{{ course.gradeName }}</text>
        </view>
      </view>
      <view class="info-row" v-if="course.location">
        <text class="info-icon">📍</text>
        <view>
          <text class="info-label">上课地点</text>
          <text class="info-value">{{ course.location }}</text>
        </view>
      </view>
      <view class="info-row">
        <text class="info-icon">📅</text>
        <view>
          <text class="info-label">上课时间</text>
          <text class="info-value">每{{ weekLabel }}</text>
        </view>
      </view>
      <view class="info-row">
        <text class="info-icon">👥</text>
        <view>
          <text class="info-label">课程名额</text>
          <text class="info-value">{{ quota }} 人</text>
        </view>
      </view>
    </view>

    <!-- 名额进度条 -->
    <view class="quota-section card">
      <view class="quota-header">
        <text class="quota-title">名额情况</text>
        <text class="quota-count" :style="{ color: remaining === 0 ? '#ef4444' : '#137fec' }">
          剩余 {{ remaining }} / {{ quota }}
        </text>
      </view>
      <view class="quota-bar">
        <view class="quota-fill" :style="{ width: quotaPercent + '%', background: quotaColor }" />
      </view>
      <text class="quota-hint" v-if="remaining === 0" style="color:#ef4444">⚠️ 名额已满</text>
      <text class="quota-hint" v-else-if="remaining <= 5" style="color:#f59e0b">🔥 仅剩 {{ remaining }} 名，速选！</text>
    </view>

    <!-- 课程介绍 -->
    <view class="desc-section card" v-if="course.description">
      <text class="desc-title">课程介绍</text>
      <text class="desc-content">{{ course.description }}</text>
    </view>

    <!-- 底部按钮 -->
    <view class="bottom-bar">
      <button
        class="add-cart-btn"
        :class="addBtnClass"
        :disabled="isFull || weekDayOccupied || isSelected"
        :loading="adding"
        @click="handleAdd"
      >
        {{ addBtnLabel }}
      </button>
    </view>
  </view>

  <!-- 加载中 -->
  <view v-else class="loading-wrap">
    <text>加载中...</text>
  </view>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { getCourseDetail, getCurrentStudent } from '@/api/course'
import { useCartStore } from '@/stores/cart'
import type { Course } from '@/types'

const cartStore = useCartStore()
const course = ref<Course | null>(null)
const adding = ref(false)
/** 当前学生班级 ID，用于按班级展示名额（与后端校验一致） */
const currentClassId = ref<number | undefined>(undefined)

const WEEK_LABELS = ['', '周一', '周二', '周三', '周四', '周五']
const HERO_COLORS = ['', '#3b82f6', '#8b5cf6', '#10b981', '#f59e0b', '#ef4444']

const weekLabel = computed(() => course.value ? WEEK_LABELS[course.value.weekDay] : '')
const heroBg = computed(() => course.value ? `linear-gradient(135deg, ${HERO_COLORS[course.value.weekDay]}, ${HERO_COLORS[course.value.weekDay]}aa)` : '#137fec')

/** 优先使用本班名额（与后端 addToCart 校验一致），否则用总名额 */
const quota = computed(() => {
  const c = course.value
  if (!c) return 0
  const list = c.quotaList
  const classId = currentClassId.value
  if (classId != null && Array.isArray(list) && list.length) {
    const q = list.find((x) => Number(x.classId) === Number(classId))
    if (q && q.quota != null) return q.quota
  }
  if (c.quota != null) return c.quota
  if (c.totalQuota != null) return c.totalQuota
  if (Array.isArray(list) && list.length) return list.reduce((s, q) => s + (q.quota ?? 0), 0)
  return 0
})
const selected = computed(() => {
  const c = course.value
  if (!c) return 0
  const list = c.quotaList
  const classId = currentClassId.value
  if (classId != null && Array.isArray(list) && list.length) {
    const q = list.find((x) => Number(x.classId) === Number(classId))
    if (q && q.selected != null) return q.selected
  }
  if (c.selected != null) return c.selected
  if (c.selectedCount != null) return c.selectedCount
  if (Array.isArray(list) && list.length) return list.reduce((s, q) => s + (q.selected ?? 0), 0)
  return 0
})
const remaining = computed(() => quota.value - selected.value)
const quotaPercent = computed(() => {
  if (!quota.value) return 0
  return Math.max(0, Math.min(100, (remaining.value / quota.value) * 100))
})
const quotaColor = computed(() => {
  const p = quotaPercent.value
  if (p > 50) return '#137fec'
  if (p > 20) return '#f59e0b'
  return '#ef4444'
})

const inCart = computed(() =>
  course.value ? cartStore.hasWeekDay(course.value.weekDay) &&
    cartStore.getByWeekDay(course.value.weekDay)?.courseId === course.value.id : false
)
/** 已选：在选课车或已提交选课 */
const isSelected = computed(() => course.value ? cartStore.isCourseSelected(course.value.id) : false)
const isFull = computed(() => remaining.value <= 0)
const weekDayOccupied = computed(() =>
  course.value ? cartStore.hasWeekDay(course.value.weekDay) && !inCart.value : false
)

const addBtnLabel = computed(() => {
  if (isSelected.value) return '已选'
  if (isFull.value) return '已满员'
  if (weekDayOccupied.value) return '该天已选'
  return '加入选课车'
})

const addBtnClass = computed(() => {
  if (isSelected.value) return 'btn-selected'
  if (isFull.value) return 'btn-full'
  if (weekDayOccupied.value) return 'btn-disabled'
  return 'btn-add'
})

async function handleAdd() {
  if (!course.value || isFull.value || weekDayOccupied.value || isSelected.value) return
  if (!cartStore.currentSemesterId) {
    try {
      await cartStore.loadSemester()
    } catch {}
  }
  if (!cartStore.currentSemesterId) {
    uni.showToast({ title: '请先回到首页加载学期信息', icon: 'none' })
    return
  }
  adding.value = true
  try {
    await cartStore.add(course.value.id)
    uni.showToast({ title: '已加入选课车 ✓', icon: 'success' })
  } finally {
    adding.value = false
  }
}

onMounted(async () => {
  const pages = getCurrentPages()
  const currentPage = pages[pages.length - 1] as any
  const id = currentPage?.options?.id
  if (id) {
    try {
      if (!cartStore.currentSemesterId) {
        await cartStore.loadSemester()
      }
      const [detailRes, studentRes] = await Promise.all([
        getCourseDetail(id),
        getCurrentStudent().catch(() => null)
      ])
      course.value = detailRes
      currentClassId.value = studentRes?.classId != null ? Number(studentRes.classId) : undefined
    } catch {}
  }
})

</script>

<style lang="scss" scoped>
.detail-page { background: #f6f7f8; min-height: 100vh; padding-bottom: 140rpx; }

.detail-hero {
  padding: 60rpx 40rpx 48rpx;
  color: #fff;
  position: relative;
  overflow: hidden;
  &::before {
    content: '';
    position: absolute;
    top: -30%;
    right: -20%;
    width: 80%;
    height: 160%;
    background: radial-gradient(circle, rgba(255,255,255,0.15) 0%, transparent 60%);
    pointer-events: none;
  }
}

.week-badge {
  display: inline-block;
  background: rgba(255,255,255,0.28);
  border-radius: 999rpx;
  padding: 6rpx 24rpx;
  font-size: 24rpx;
  margin-bottom: 16rpx;
  backdrop-filter: blur(4rpx);
}

.detail-title {
  display: block;
  font-size: 44rpx;
  font-weight: 800;
  margin-bottom: 12rpx;
  line-height: 1.3;
}

.detail-teacher { font-size: 28rpx; opacity: 0.85; }

.info-section, .quota-section, .desc-section {
  margin: 24rpx 32rpx 0;
}

.info-row {
  display: flex;
  align-items: flex-start;
  padding: 20rpx 0;
  border-bottom: 1rpx solid #f1f5f9;
  &:last-child { border-bottom: none; }
}
.info-icon { font-size: 36rpx; margin-right: 20rpx; }
.info-label { display: block; font-size: 24rpx; color: #94a3b8; margin-bottom: 4rpx; }
.info-value { font-size: 28rpx; color: #0d141b; font-weight: 500; }

.quota-header { display: flex; justify-content: space-between; margin-bottom: 20rpx; }
.quota-title { font-size: 28rpx; font-weight: 600; color: #0d141b; }
.quota-count { font-size: 28rpx; font-weight: 600; }
.quota-bar {
  height: 12rpx;
  background: #e2e8f0;
  border-radius: 999rpx;
  overflow: hidden;
  margin-bottom: 12rpx;
}
.quota-fill {
  height: 100%;
  border-radius: 999rpx;
  transition: width 0.5s;
}
.quota-hint { font-size: 24rpx; }

.desc-title {
  display: block;
  font-size: 28rpx;
  font-weight: 600;
  color: #0d141b;
  margin-bottom: 16rpx;
}
.desc-content { font-size: 26rpx; color: #4c739a; line-height: 1.7; }

.bottom-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 20rpx 32rpx;
  padding-bottom: calc(20rpx + env(safe-area-inset-bottom));
  background: #fff;
  border-top: 1rpx solid #f1f5f9;
}

.add-cart-btn {
  width: 100%;
  height: 96rpx;
  line-height: 96rpx;
  border-radius: 24rpx;
  font-size: 32rpx;
  font-weight: 700;
  background: linear-gradient(135deg, #137fec 0%, #0d6bd9 100%);
  color: #fff;
  border: none;
  box-shadow: 0 8rpx 24rpx rgba(19, 127, 236, 0.3);
  transition: opacity 0.2s;
  &::after { border: none; }
  &:active { opacity: 0.9; }

  &.btn-add { background: linear-gradient(135deg, #137fec 0%, #0d6bd9 100%); color: #fff; box-shadow: 0 8rpx 24rpx rgba(19, 127, 236, 0.3); }
  &.btn-selected { background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%); color: #16a34a; box-shadow: none; border: 2rpx solid #86efac; }
  &.btn-full { background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%); color: #b45309; box-shadow: none; border: 2rpx solid #fcd34d; }
  &.btn-countdown { background: linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%); color: #4338ca; box-shadow: none; border: 2rpx solid #a5b4fc; }
  &.btn-ended, &.btn-disabled { background: #f1f5f9; color: #94a3b8; box-shadow: none; }
}

.loading-wrap {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 60vh;
  color: #94a3b8;
  font-size: 30rpx;
}

/* Pad 适配 */
@media (min-width: 768px) {
  .detail-page { padding-left: 48rpx; padding-right: 48rpx; }
  .detail-hero { padding: 80rpx 48rpx 60rpx; }
  .info-section, .quota-section, .desc-section { margin-left: 48rpx; margin-right: 48rpx; }
  .bottom-bar {
    left: 50%;
    transform: translateX(-50%);
    max-width: 900px;
    border-radius: 24rpx 24rpx 0 0;
  }
}
</style>
