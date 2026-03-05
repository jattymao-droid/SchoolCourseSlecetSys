<template>
  <view class="home-page">
    <!-- 深蓝顶栏（图片风格） -->
    <view class="hero-header">
      <view class="hero-top">
        <view class="avatar" @click="goProfile">
          <text class="avatar-text">{{ avatarText }}</text>
        </view>
        <view class="hero-title-wrap">
          <text class="hero-title">欢迎进入东陆选课系统</text>
          <text class="hero-sub">{{ authStore.studentName || '同学' }}{{ authStore.className ? ' · ' + authStore.className : '' }}</text>
        </view>
      </view>
    </view>

    <!-- 内容区 -->
    <view class="content-wrap pad-container">
    <!-- 当前学期 -->
    <view class="semester-card">
      <view class="semester-header">
        <text class="semester-label">当前学期</text>
        <view class="semester-status" v-if="semester">进行中</view>
      </view>
      <text class="semester-name">{{ semester?.semesterName || '加载中...' }}</text>
      <text class="semester-date" v-if="semester">{{ semester.startDate }} 至 {{ semester.endDate }}</text>
    </view>

    <!-- 选课进度 -->
    <view class="progress-section">
      <view class="progress-header">
        <text class="progress-title">选课进度</text>
        <text class="progress-count">{{ totalSelectedCount }}/5 天</text>
      </view>
      <view class="progress-bar">
        <view class="progress-fill" :style="{ width: progressPercent + '%' }" />
      </view>
    </view>

    <!-- 快捷功能 -->
    <view class="section">
      <text class="section-title">快捷入口</text>
      <view class="quick-grid">
        <view class="quick-item" @click="goCourse">
          <view class="quick-icon-wrap icon-course">
            <text class="quick-icon">课程</text>
          </view>
          <text class="quick-label">浏览课程</text>
          <text class="quick-desc">查找并加入选课车</text>
        </view>

        <view class="quick-item" @click="goCart">
          <view class="quick-icon-wrap icon-cart">
            <text class="quick-icon">选课</text>
            <view v-if="cartStore.badgeText" class="quick-badge">{{ cartStore.badgeText }}</view>
          </view>
          <text class="quick-label">选课车</text>
          <text class="quick-desc">{{ isSelectionComplete ? '已选齐，可提交' : `已选 ${totalSelectedCount}/5 天` }}</text>
        </view>

        <view class="quick-item" @click="goSchedule">
          <view class="quick-icon-wrap icon-schedule">
            <text class="quick-icon">课表</text>
          </view>
          <text class="quick-label">我的课表</text>
          <text class="quick-desc">查看已选课程</text>
        </view>

        <view class="quick-item" @click="go('/pages/my/evaluation')">
          <view class="quick-icon-wrap icon-eval">
            <text class="quick-icon">评价</text>
          </view>
          <text class="quick-label">课程评价</text>
          <text class="quick-desc">对已选课程打分</text>
        </view>
      </view>
    </view>

    <!-- 热门课程（图片风格：彩色卡片+装饰） -->
    <view class="section" v-if="popularCourses.length">
      <view class="section-header">
        <text class="section-title">热门课程</text>
        <text class="section-more" @click.stop="goCourse">全部 ></text>
      </view>
      <scroll-view class="popular-scroll" scroll-x>
        <view
          v-for="(c, i) in popularCourses"
          :key="c.courseId"
          class="popular-card"
          :class="'card-' + (i % 3)"
          @click="goDetail(c.courseId)"
        >
          <view class="card-deco card-deco-1" />
          <view class="card-deco card-deco-2" />
          <view class="card-tag">{{ weekLabels[c.weekDay] }}</view>
          <text class="card-name">{{ c.courseName }}</text>
          <text class="card-meta">{{ c.selectedCount }} 人已选</text>
        </view>
      </scroll-view>
    </view>

    <!-- 操作提示 -->
    <view class="tip-card tip-success" v-if="isSelectionComplete && cartStore.selectedCount > 0" @click="goCart">
      <view class="tip-icon success">✓</view>
      <text class="tip-text">选课车已选齐，点击前往提交</text>
    </view>
    <view class="tip-card tip-warn" v-else-if="!isSelectionComplete && totalSelectedCount > 0">
      <view class="tip-icon warn">!</view>
      <text class="tip-text">还需选 {{ 5 - totalSelectedCount }} 天课程方可提交</text>
    </view>

    <tab-bar current="pages/home/index" />
    <view class="tab-bar-placeholder" />
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { safeHideTabBar } from '@/utils/tabBar'
import { useAuthStore } from '@/stores/auth'
import { useCartStore } from '@/stores/cart'
import { getStudentDashboard } from '@/api/course'
import type { Semester } from '@/types'
import type { PopularCourse } from '@/api/course'

const authStore = useAuthStore()
const cartStore = useCartStore()
const semester = ref<Semester | null>(null)
const popularCourses = ref<PopularCourse[]>([])
const confirmedCount = ref(0)

const weekLabels: Record<number, string> = { 1: '周一', 2: '周二', 3: '周三', 4: '周四', 5: '周五' }

const avatarText = computed(() => {
  const name = authStore.studentName
  return name ? name.charAt(0) : '学'
})

const totalSelectedCount = computed(() => confirmedCount.value + cartStore.selectedCount)
const progressPercent = computed(() => Math.min((totalSelectedCount.value / 5) * 100, 100))
const isSelectionComplete = computed(() => totalSelectedCount.value >= 5)

async function loadData() {
  try {
    const sem = await cartStore.loadSemester()
    semester.value = sem
    const dash = await getStudentDashboard()
    const d = dash as Record<string, unknown> | null
    confirmedCount.value = Math.min(5, Math.max(0, Number(d?.selectionCount ?? 0)))
    popularCourses.value = (Array.isArray(d?.popularCourses) ? d?.popularCourses : []) as PopularCourse[]
  } catch {
    // 静默失败，保持上次数据
  }
}

function goDetail(id: number) {
  uni.navigateTo({ url: `/pages/course/detail?id=${id}` })
}

onMounted(loadData)
onShow(() => {
  safeHideTabBar()
  loadData()
})

function go(url: string) {
  uni.navigateTo({ url })
}

function goCourse() {
  uni.switchTab({ url: '/pages/course/list' })
}

function goCart() {
  uni.switchTab({ url: '/pages/cart/index' })
}

function goSchedule() {
  uni.switchTab({ url: '/pages/schedule/index' })
}

function goProfile() {
  uni.switchTab({ url: '/pages/profile/index' })
}
</script>

<style lang="scss" scoped>
@use "sass:color";
.home-page {
  min-height: 100vh;
  background: linear-gradient(180deg, #EFF6FF 0%, $uni-bg-color-grey 30%, $uni-bg-color 100%);
}

/* 深蓝顶栏 */
.hero-header {
  position: relative;
  background: linear-gradient(135deg, $uni-color-primary-dark 0%, #1E40AF 100%);
  padding: calc(var(--status-bar-height) + 28rpx) $uni-spacing-row-lg 60rpx;
  color: $uni-text-color-inverse;
  border-radius: 0 0 40rpx 40rpx;
  box-shadow: 0 10rpx 30rpx rgba(37, 99, 235, 0.2);
  overflow: hidden;
}
.hero-header::before {
  content: '';
  position: absolute;
  top: -50%;
  right: -20%;
  width: 80%;
  height: 100%;
  background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
  pointer-events: none;
}

.hero-top {
  display: flex;
  align-items: center;
  gap: $uni-spacing-row-base;
  position: relative;
  z-index: 1;
}

.avatar {
  width: 100rpx;
  height: 100rpx;
  border-radius: 50%;
  background: rgba(255,255,255,0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  transition: transform 0.2s;
  border: 4rpx solid rgba(255,255,255,0.3);
  backdrop-filter: blur(10rpx);
  
  &:active { transform: scale(0.95); }
}
.avatar-text { 
  color: #fff; 
  font-size: 40rpx; 
  font-weight: 700; 
}

.hero-title-wrap { flex: 1; min-width: 0; }
.hero-title {
  display: block;
  font-size: 36rpx;
  font-weight: 700;
  letter-spacing: 1rpx;
  margin-bottom: 8rpx;
}
.hero-sub {
  font-size: $uni-font-size-sm;
  opacity: 0.85;
  background: rgba(0,0,0,0.1);
  padding: 4rpx 16rpx;
  border-radius: 999rpx;
}

/* 内容区 */
.content-wrap {
  padding: 0 $uni-spacing-row-lg;
  margin-top: -40rpx;
  position: relative;
  z-index: 1;
}

/* 学期卡片 */
.semester-card {
  background: $uni-bg-color;
  border-radius: $uni-border-radius-lg;
  padding: 36rpx;
  margin-bottom: $uni-spacing-col-lg;
  box-shadow: $uni-shadow-base;
  position: relative;
  overflow: hidden;
}
.semester-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16rpx;
}
.semester-label {
  font-size: $uni-font-size-sm;
  color: $uni-text-color-grey;
}
.semester-status {
  font-size: 20rpx;
  color: $uni-color-success;
  background: rgba($uni-color-success, 0.1);
  padding: 4rpx 12rpx;
  border-radius: 8rpx;
  font-weight: 600;
}
.semester-name {
  display: block;
  font-size: 34rpx;
  font-weight: 700;
  color: $uni-text-color;
  margin-bottom: 8rpx;
}
.semester-date {
  font-size: $uni-font-size-sm;
  color: $uni-text-color-placeholder;
}

/* 选课进度 */
.progress-section {
  background: $uni-bg-color;
  border-radius: $uni-border-radius-lg;
  padding: 32rpx;
  margin-bottom: $uni-spacing-col-lg;
  box-shadow: $uni-shadow-sm;
}
.progress-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24rpx;
}
.progress-title { font-size: $uni-font-size-base; color: $uni-text-color; font-weight: 600; }
.progress-count { font-size: $uni-font-size-base; color: $uni-color-primary; font-weight: 700; }
.progress-bar {
  height: 12rpx;
  background: $uni-bg-color-hover;
  border-radius: 999rpx;
  overflow: hidden;
}
.progress-fill {
  height: 100%;
  background: $uni-color-primary;
  border-radius: 999rpx;
  transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

/* 快捷入口 */
.section { margin-bottom: 40rpx; }
.section-title {
  display: block;
  font-size: 30rpx;
  font-weight: 700;
  color: $uni-text-color;
  margin-bottom: 24rpx;
  padding-left: 8rpx;
  border-left: 6rpx solid $uni-color-primary;
}

.quick-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 24rpx;
}

.quick-item {
  background: $uni-bg-color;
  border-radius: $uni-border-radius-lg;
  padding: 32rpx;
  position: relative;
  box-shadow: $uni-shadow-sm;
  border: 1rpx solid $uni-border-color;
  transition: all 0.2s;

  &:active {
    transform: scale(0.98);
    background: $uni-bg-color-hover;
  }
}

.quick-icon-wrap {
  width: 88rpx;
  height: 88rpx;
  border-radius: 24rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 24rpx;
  position: relative;
}
.quick-icon {
  font-size: 28rpx;
  font-weight: 600;
  color: #fff;
}
.icon-course { background: linear-gradient(135deg, #60A5FA 0%, #3B82F6 100%); box-shadow: 0 8rpx 20rpx rgba(59, 130, 246, 0.3); }
.icon-cart { background: linear-gradient(135deg, #34D399 0%, #10B981 100%); box-shadow: 0 8rpx 20rpx rgba(16, 185, 129, 0.3); }
.icon-schedule { background: linear-gradient(135deg, #A78BFA 0%, #8B5CF6 100%); box-shadow: 0 8rpx 20rpx rgba(139, 92, 246, 0.3); }
.icon-eval { background: linear-gradient(135deg, #FBBF24 0%, #F59E0B 100%); box-shadow: 0 8rpx 20rpx rgba(245, 158, 11, 0.3); }

.quick-badge {
  position: absolute;
  top: -8rpx;
  right: -8rpx;
  min-width: 36rpx;
  height: 36rpx;
  background: $uni-color-error;
  color: #fff;
  border-radius: 999rpx;
  font-size: 20rpx;
  line-height: 36rpx;
  text-align: center;
  padding: 0 8rpx;
  border: 2rpx solid #fff;
}

.quick-label {
  display: block;
  font-size: 28rpx;
  font-weight: 600;
  color: $uni-text-color;
  margin-bottom: 8rpx;
}
.quick-desc { font-size: 22rpx; color: $uni-text-color-grey; }

/* 热门课程 */
.section-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 24rpx;
}
.section-more {
  font-size: 24rpx;
  color: $uni-color-primary;
}

.popular-scroll {
  white-space: nowrap;
  margin: 0 -32rpx;
  padding: 0 32rpx 20rpx;
}
.popular-card {
  display: inline-block;
  width: 320rpx;
  height: 200rpx;
  border-radius: 24rpx;
  padding: 28rpx;
  margin-right: 24rpx;
  position: relative;
  overflow: hidden;
  vertical-align: top;
  box-shadow: 0 8rpx 24rpx rgba(0, 0, 0, 0.08);
  
  &:active { transform: scale(0.98); }
}
.popular-card.card-0 { background: linear-gradient(135deg, #1E293B 0%, #334155 100%); }
.popular-card.card-1 { background: linear-gradient(135deg, #4F46E5 0%, #4338CA 100%); }
.popular-card.card-2 { background: linear-gradient(135deg, #BE185D 0%, #9D174D 100%); }

.card-tag {
  display: inline-block;
  padding: 6rpx 16rpx;
  background: rgba(255,255,255,0.2);
  border-radius: 8rpx;
  font-size: 20rpx;
  color: #fff;
  margin-bottom: 20rpx;
}
.card-name {
  display: block;
  font-size: 30rpx;
  font-weight: 600;
  color: #fff;
  margin-bottom: 12rpx;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.card-meta {
  font-size: 22rpx;
  color: rgba(255,255,255,0.7);
}

/* 提示卡片 */
.tip-card {
  display: flex;
  align-items: center;
  gap: 20rpx;
  border-radius: $uni-border-radius-lg;
  padding: 24rpx;
  margin-bottom: 24rpx;
  
  &.tip-success { 
    background: rgba($uni-color-success, 0.08); 
    border: 1rpx solid rgba($uni-color-success, 0.2);
  }
  &.tip-warn { 
    background: rgba($uni-color-warning, 0.08); 
    border: 1rpx solid rgba($uni-color-warning, 0.2);
  }
}
.tip-icon {
  width: 40rpx;
  height: 40rpx;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24rpx;
  font-weight: 700;
  flex-shrink: 0;
  color: #fff;
  &.success { background: $uni-color-success; }
  &.warn { background: $uni-color-warning; }
}
.tip-text { 
  font-size: 26rpx; 
  font-weight: 500;
}
.tip-success .tip-text { color: color.adjust($uni-color-success, $lightness: -10%); }
.tip-warn .tip-text { color: color.adjust($uni-color-warning, $lightness: -10%); }

/* Pad */
@media (min-width: 768px) {
  .home-page { padding-left: 48rpx; padding-right: 48rpx; }
  .quick-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}
</style>
