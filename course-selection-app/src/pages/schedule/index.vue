<template>
  <view class="schedule-page pad-container">
    <!-- 学期标题 -->
    <view class="schedule-header card">
      <view class="sem-info">
        <text class="sem-label">当前学期</text>
        <text class="sem-name">{{ semName || '加载中...' }}</text>
      </view>
      <view v-if="selections.length" class="sem-badge">
        <text class="sem-count">{{ selections.length }}</text>
        <text class="sem-unit">门课</text>
      </view>
    </view>

    <!-- 加载骨架 -->
    <view v-if="loading && !selections.length" class="skeleton-grid">
      <view v-for="day in 5" :key="day" class="skeleton-col">
        <view class="skeleton-head" />
        <view class="skeleton-block" />
      </view>
    </view>

    <!-- 无数据 -->
    <empty-state
      v-else-if="!selections.length"
      icon="📋"
      title="暂无选课记录"
      desc="当前学期尚未完成选课，去选课车提交选课吧"
      btn-text="去选课"
      @action="goCourse"
    />

    <!-- 周课表视图 -->
    <scroll-view
      v-else
      scroll-y
      class="schedule-scroll"
      :refresher-enabled="true"
      :refresher-triggered="refreshing"
      @refresherrefresh="onRefresh"
    >
      <view class="schedule-content">
      <view class="week-grid">
        <view v-for="day in 5" :key="day" class="week-col">
          <!-- 星期标题 -->
          <view class="week-head" :style="{ background: dayBg[day], color: dayColor[day] }">
            <text class="week-head-text">{{ dayLabels[day] }}</text>
          </view>

          <!-- 课程块 -->
          <view
            v-if="selectionMap[day]"
            class="course-block"
            :style="{ background: dayColor[day] }"
            @click="goCourseDetail(selectionMap[day]!)"
          >
            <text class="block-name">{{ selectionMap[day]?.courseName }}</text>
            <text class="block-teacher" v-if="selectionMap[day]?.teacherName">
              {{ selectionMap[day]?.teacherName }}
            </text>
            <text class="block-location" v-if="selectionMap[day]?.location">
              📍 {{ selectionMap[day]?.location }}
            </text>
            <text v-if="selectionMap[day]?.assigned === 1" class="block-assigned">指定</text>
          </view>
          <view v-else class="course-block empty-block" />
        </view>
      </view>

      <!-- 已选列表入口 -->
      <view class="list-entry card" @click="goMySelection">
        <text class="list-entry-text">查看已选课程列表 →</text>
      </view>
      </view>
    </scroll-view>

    <tab-bar current="pages/schedule/index" />
    <view class="tab-bar-placeholder" />
  </view>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getMySelections, type MySelectionVO } from '@/api/selection'
import { safeHideTabBar } from '@/utils/tabBar'
import { getCurrentSemester } from '@/api/course'

const selections = ref<MySelectionVO[]>([])
const loading = ref(false)
const refreshing = ref(false)
const semName = ref('')

const dayLabels: Record<number, string> = { 1: '周一', 2: '周二', 3: '周三', 4: '周四', 5: '周五' }
const dayColor: Record<number, string> = { 1: '#3b82f6', 2: '#8b5cf6', 3: '#10b981', 4: '#f59e0b', 5: '#ef4444' }
const dayBg: Record<number, string> = { 1: '#eff6ff', 2: '#f5f3ff', 3: '#f0fdf4', 4: '#fffbeb', 5: '#fff1f2' }

const selectionMap = computed(() => {
  const map: Record<number, MySelectionVO | null> = { 1: null, 2: null, 3: null, 4: null, 5: null }
  selections.value.forEach(s => { map[s.weekDay] = s })
  return map
})

async function loadData() {
  loading.value = true
  try {
    const sem = await getCurrentSemester()
    semName.value = sem?.semesterName || ''
    if (sem?.id) {
      const res = await getMySelections(sem.id)
      selections.value = Array.isArray(res) ? res : (res as any)?.data ?? []
    }
  } finally {
    loading.value = false
  }
}

async function onRefresh() {
  refreshing.value = true
  await loadData()
  refreshing.value = false
}

onMounted(loadData)
onShow(() => {
  safeHideTabBar()
  loadData()
})

function goCourse() {
  uni.switchTab({ url: '/pages/course/list' })
}

function goMySelection() {
  uni.navigateTo({ url: '/pages/my/selection' })
}

function goCourseDetail(item: MySelectionVO) {
  uni.navigateTo({ url: `/pages/course/detail?id=${item.courseId}` })
}
</script>

<style lang="scss" scoped>
.schedule-page {
  padding: calc(var(--status-bar-height) + 24rpx) 32rpx 32rpx;
  background: var(--bg-page);
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.schedule-header {
  margin-bottom: 32rpx;
  padding: 32rpx;
  background: var(--bg-card);
  border-radius: 32rpx;
  box-shadow: var(--shadow-card);
  display: flex;
  align-items: center;
  justify-content: space-between;
  border: 1rpx solid rgba(226, 232, 240, 0.6);
}

.sem-info { display: flex; flex-direction: column; }
.sem-label { font-size: 24rpx; color: var(--text-sub); margin-bottom: 4rpx; font-weight: 500; }
.sem-name { 
  font-size: 32rpx; 
  font-weight: 800; 
  background: var(--primary-gradient);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  letter-spacing: -0.5rpx;
}

.sem-badge {
  display: flex;
  align-items: baseline;
  gap: 4rpx;
  padding: 12rpx 20rpx;
  background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
  border-radius: 16rpx;
  border: 1rpx solid rgba(59, 130, 246, 0.2);
}
.sem-count { font-size: 36rpx; font-weight: 800; color: var(--primary); }
.sem-unit { font-size: 22rpx; color: #64748b; font-weight: 500; }

.schedule-scroll {
  flex: 1;
  min-height: 400rpx;
}

.skeleton-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 16rpx;
  margin-bottom: 32rpx;
}
.skeleton-col { display: flex; flex-direction: column; gap: 16rpx; }
.skeleton-head {
  height: 60rpx;
  background: #e2e8f0;
  border-radius: 20rpx;
  animation: pulse 1.5s infinite;
}
.skeleton-block {
  height: 180rpx;
  background: #f1f5f9;
  border-radius: 24rpx;
  animation: pulse 1.5s infinite 0.2s;
}
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

.schedule-content {
  padding-bottom: calc(120rpx + env(safe-area-inset-bottom));
}

.week-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 16rpx;
  margin-bottom: 32rpx;
}

.week-col {
  display: flex;
  flex-direction: column;
  gap: 16rpx;
}

.week-head {
  border-radius: 20rpx;
  padding: 16rpx 0;
  text-align: center;
  box-shadow: 0 4rpx 12rpx rgba(0,0,0,0.03);
}
.week-head-text { font-size: 26rpx; font-weight: 700; }

.course-block {
  border-radius: 24rpx;
  padding: 20rpx 12rpx;
  min-height: 180rpx;
  display: flex;
  flex-direction: column;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 8rpx 20rpx -4rpx rgba(0,0,0,0.1);
  position: relative;
  overflow: hidden;
  
  &:active { transform: scale(0.96); }
  
  &::after {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    background: linear-gradient(180deg, rgba(255,255,255,0.1) 0%, rgba(0,0,0,0.05) 100%);
    pointer-events: none;
  }
}

.block-name { 
  font-size: 24rpx; 
  font-weight: 700; 
  color: #fff; 
  margin-bottom: 8rpx; 
  line-height: 1.3; 
  text-shadow: 0 2rpx 4rpx rgba(0,0,0,0.1);
}
.block-teacher { 
  font-size: 20rpx; 
  color: rgba(255,255,255,0.9); 
  background: rgba(0,0,0,0.1);
  align-self: flex-start;
  padding: 2rpx 8rpx;
  border-radius: 8rpx;
  margin-bottom: 4rpx;
}
.block-location {
  font-size: 20rpx;
  color: rgba(255,255,255,0.85);
  display: block;
  margin-top: 4rpx;
}
.block-assigned {
  position: absolute;
  top: 12rpx;
  right: 12rpx;
  font-size: 20rpx;
  color: rgba(255,255,255,0.95);
  background: rgba(0,0,0,0.2);
  padding: 4rpx 12rpx;
  border-radius: 12rpx;
}

.empty-block {
  background: #f1f5f9;
  min-height: 180rpx;
  border-radius: 24rpx;
  border: 2rpx dashed #e2e8f0;
  position: relative;
  &::after { display: none; }
}

.list-entry {
  padding: 32rpx;
  background: var(--bg-card);
  border-radius: 24rpx;
  box-shadow: var(--shadow-card);
  text-align: center;
  border: 1rpx solid rgba(226, 232, 240, 0.6);
  transition: all 0.2s;
  
  &:active { 
    background: #f8fafc;
    transform: scale(0.99); 
  }
}
.list-entry-text { font-size: 28rpx; color: var(--primary); font-weight: 600; }

.loading-text { text-align: center; padding: 48rpx; color: var(--text-sub); font-size: 28rpx; }


/* Pad 适配 */
@media (min-width: 768px) {
  .schedule-page { 
    padding: 48rpx; 
    max-width: 1000px; 
    margin: 0 auto; 
    width: 100%;
  }
  .week-grid { gap: 24rpx; }
  .course-block { min-height: 240rpx; padding: 32rpx 20rpx; }
  .block-name { font-size: 28rpx; }
  .block-teacher { font-size: 24rpx; }
}
</style>
