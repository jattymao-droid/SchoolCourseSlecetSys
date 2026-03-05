<template>
  <view class="weekly-grid">
    <view
      v-for="day in 5"
      :key="day"
      class="day-row"
      :class="{ filled: cartStore.hasWeekDay(day) }"
    >
      <!-- 星期标签 -->
      <view class="day-label" :style="{ background: dayBg[day], color: dayColor[day] }">
        <text class="day-text">{{ dayLabels[day] }}</text>
      </view>

      <!-- 课程信息 or 占位 -->
      <view class="day-content">
        <template v-if="cartStore.hasWeekDay(day)">
          <view class="course-info">
            <view class="course-title-row">
              <text class="course-title">{{ cartStore.getByWeekDay(day)?.courseName }}</text>
              <text class="assigned-tag" v-if="cartStore.getByWeekDay(day)?.assigned">指定</text>
            </view>
            <text class="course-teacher" v-if="cartStore.getByWeekDay(day)?.teacherName">
              {{ cartStore.getByWeekDay(day)?.teacherName }}
            </text>
          </view>
          <!-- 移除按钮（管理员指定的课程不显示） -->
          <view class="remove-btn" @click="handleRemove(day)" v-if="removable && !cartStore.getByWeekDay(day)?.assigned">
            <text class="remove-icon">✕</text>
          </view>
        </template>
        <template v-else>
          <text class="placeholder-text">待选择</text>
          <text class="placeholder-hint">去浏览课程添加</text>
        </template>
      </view>

      <!-- 状态图标 -->
      <view class="status-icon">
        <text v-if="cartStore.hasWeekDay(day)" class="icon-check">✓</text>
        <text v-else class="icon-empty">○</text>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { useCartStore } from '@/stores/cart'

defineProps<{ removable?: boolean }>()

const cartStore = useCartStore()

const dayLabels: Record<number, string> = { 1: '周一', 2: '周二', 3: '周三', 4: '周四', 5: '周五' }
const dayColor: Record<number, string> = { 1: '#3b82f6', 2: '#8b5cf6', 3: '#10b981', 4: '#f59e0b', 5: '#ef4444' }
const dayBg: Record<number, string> = { 1: '#eff6ff', 2: '#f5f3ff', 3: '#f0fdf4', 4: '#fffbeb', 5: '#fff1f2' }

async function handleRemove(day: number) {
  const item = cartStore.getByWeekDay(day)
  if (!item) return
  if (item.assigned) {
    uni.showToast({ title: '该课程为教师指定，不可移除', icon: 'none' })
    return
  }
  uni.showModal({
    title: '移出选课车',
    content: `确认移出「${item.courseName}」吗？`,
    success: async (res) => {
      if (res.confirm) {
        try {
          await cartStore.removeByWeekDay(day)
          uni.showToast({ title: '已移出', icon: 'success' })
        } catch (e: unknown) {
          const msg = (e as { data?: { msg?: string }; message?: string })?.data?.msg ?? (e as Error)?.message ?? '移出失败'
          uni.showToast({ title: msg, icon: 'none' })
        }
      }
    }
  })
}
</script>

<style lang="scss" scoped>
.weekly-grid {
  display: flex;
  flex-direction: column;
  gap: 16rpx;
}

.day-row {
  display: flex;
  align-items: center;
  background: #f8fafc;
  border: 2rpx dashed #e2e8f0;
  border-radius: 24rpx;
  padding: 24rpx;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);

  &.filled {
    background: #fff;
    border-style: solid;
    border-color: transparent;
    box-shadow: 0 8rpx 32rpx rgba(15, 23, 42, 0.06), 0 2rpx 12rpx rgba(19, 127, 236, 0.04);
  }
}

.day-label {
  width: 80rpx;
  height: 80rpx;
  border-radius: 12rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  margin-right: 20rpx;
}

.day-text {
  font-size: 26rpx;
  font-weight: 700;
}

.day-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.course-info { flex: 1; }
.course-title-row {
  display: flex;
  align-items: center;
  gap: 8rpx;
}
.course-title {
  display: block;
  font-size: 28rpx;
  font-weight: 600;
  color: #0d141b;
  margin-bottom: 4rpx;
}
.course-teacher { font-size: 24rpx; color: #4c739a; }
.assigned-tag {
  font-size: 20rpx;
  color: #64748b;
  background: #f1f5f9;
  padding: 2rpx 8rpx;
  border-radius: 6rpx;
}

.placeholder-text {
  display: block;
  font-size: 26rpx;
  color: #cbd5e1;
  font-weight: 500;
  margin-bottom: 4rpx;
}
.placeholder-hint { font-size: 22rpx; color: #e2e8f0; }

.remove-btn {
  width: 48rpx;
  height: 48rpx;
  border-radius: 50%;
  background: #fee2e2;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  margin-right: 12rpx;
  cursor: pointer;
}
.remove-icon { font-size: 24rpx; color: #ef4444; }

.status-icon {
  width: 40rpx;
  text-align: center;
  flex-shrink: 0;
}
.icon-check { font-size: 32rpx; color: #16a34a; font-weight: 700; }
.icon-empty { font-size: 32rpx; color: #e2e8f0; }

/* Pad 适配 */
@media (min-width: 768px) {
  .weekly-grid { gap: 20rpx; }
  .day-row { padding: 24rpx; }
  .day-label { width: 96rpx; height: 96rpx; font-size: 28rpx; }
  .course-title { font-size: 30rpx; }
  .course-teacher { font-size: 26rpx; }
}
</style>
