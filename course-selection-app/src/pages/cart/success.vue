<template>
  <view class="success-page pad-container">
    <!-- 成功动画区 -->
    <view class="success-hero">
      <view class="success-circle">
        <text class="success-icon">✓</text>
      </view>
      <text class="success-title">选课成功！</text>
      <text class="success-subtitle">本学期选课已完成，祝学习愉快！</text>
    </view>

    <!-- 已选课程摘要 -->
    <view class="summary-card card">
      <text class="summary-title">本次选课详情</text>
      <view v-for="item in selections" :key="item.id" class="summary-row">
        <view class="day-chip" :style="{ background: dayBg[item.weekDay], color: dayColor[item.weekDay] }">
          {{ dayLabels[item.weekDay] }}
        </view>
        <view class="summary-info">
          <text class="summary-course">{{ item.courseName }}</text>
          <text class="summary-teacher" v-if="item.teacherName">{{ item.teacherName }}</text>
        </view>
      </view>

      <!-- 加载中占位 -->
      <view v-if="loading" class="summary-loading">
        <text>加载中...</text>
      </view>
    </view>

    <!-- 操作按钮 -->
    <view class="action-wrap">
      <button class="btn-primary action-btn" @click="goSchedule">查看我的课表</button>
      <button class="btn-outline action-btn" style="margin-top:20rpx" @click="goHome">返回首页</button>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getMySelections, type MySelectionVO } from '@/api/selection'
import { getCurrentSemester } from '@/api/course'

const selections = ref<MySelectionVO[]>([])
const loading = ref(false)

const dayLabels: Record<number, string> = { 1: '周一', 2: '周二', 3: '周三', 4: '周四', 5: '周五' }
const dayColor: Record<number, string> = { 1: '#3b82f6', 2: '#8b5cf6', 3: '#10b981', 4: '#f59e0b', 5: '#ef4444' }
const dayBg: Record<number, string> = { 1: '#eff6ff', 2: '#f5f3ff', 3: '#f0fdf4', 4: '#fffbeb', 5: '#fff1f2' }

onMounted(async () => {
  loading.value = true
  try {
    const sem = await getCurrentSemester()
    if (sem?.id) {
      selections.value = (await getMySelections(sem.id)).sort((a, b) => a.weekDay - b.weekDay)
    }
  } finally {
    loading.value = false
  }
})

function goSchedule() {
  uni.switchTab({ url: '/pages/schedule/index' })
}

function goHome() {
  uni.switchTab({ url: '/pages/home/index' })
}
</script>

<style lang="scss" scoped>
.success-page {
  min-height: 100vh;
  background: #f6f7f8;
  padding: 80rpx 32rpx 60rpx;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.success-hero {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 48rpx;
}

.success-circle {
  width: 160rpx;
  height: 160rpx;
  border-radius: 50%;
  background: linear-gradient(145deg, #137fec 0%, #0d6bd9 50%, #0b5ebd 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 32rpx;
  box-shadow: 0 12rpx 40rpx rgba(19, 127, 236, 0.4), 0 4rpx 16rpx rgba(0, 0, 0, 0.08);
}

.success-icon { font-size: 80rpx; color: #fff; font-weight: 900; }

.success-title {
  font-size: 48rpx;
  font-weight: 800;
  color: #0d141b;
  margin-bottom: 12rpx;
}

.success-subtitle { font-size: 28rpx; color: #4c739a; }

.summary-card {
  width: 100%;
  margin-bottom: 48rpx;
}

.summary-title {
  display: block;
  font-size: 28rpx;
  font-weight: 700;
  color: #0d141b;
  margin-bottom: 24rpx;
}

.summary-row {
  display: flex;
  align-items: center;
  padding: 16rpx 0;
  border-bottom: 1rpx solid #f1f5f9;
  &:last-child { border-bottom: none; }
}

.day-chip {
  width: 72rpx;
  height: 48rpx;
  border-radius: 999rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24rpx;
  font-weight: 700;
  flex-shrink: 0;
  margin-right: 20rpx;
}

.summary-info { flex: 1; }
.summary-course { display: block; font-size: 28rpx; font-weight: 600; color: #0d141b; }
.summary-teacher { font-size: 24rpx; color: #94a3b8; }

.summary-loading { text-align: center; padding: 24rpx; color: #94a3b8; font-size: 26rpx; }

.action-wrap { width: 100%; max-width: 480px; }
.action-btn { height: 96rpx; line-height: 96rpx; font-size: 32rpx; }

/* Pad 适配 */
@media (min-width: 768px) {
  .success-page { padding: 100rpx 48rpx 80rpx; }
  .success-circle { width: 200rpx; height: 200rpx; }
  .success-icon { font-size: 100rpx; }
  .success-title { font-size: 56rpx; }
  .summary-card { max-width: 560px; }
}
</style>
