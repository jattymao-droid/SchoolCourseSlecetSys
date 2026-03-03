<template>
  <view class="list-page pad-container">
    <!-- 顶栏 -->
    <view class="list-header">
      <text class="list-title">课程列表</text>
      <text class="list-sub">按星期筛选</text>
    </view>
    <!-- 星期筛选 -->
    <scroll-view class="filter-scroll" scroll-x>
      <view class="filter-chips">
        <view
          v-for="f in filters"
          :key="f.value"
          class="chip"
          :class="{ active: activeFilter === f.value }"
          @click="setFilter(f.value)"
        >{{ f.label }}</view>
      </view>
    </scroll-view>

    <!-- 课程列表 -->
    <scroll-view
      class="course-list"
      scroll-y
      :refresher-enabled="true"
      :refresher-triggered="refreshing"
      @refresherrefresh="onRefresh"
      @scrolltolower="loadMore"
    >
      <view class="list-inner">
        <!-- 骨架屏 -->
        <view v-if="loading && !courses.length" class="skeleton-list">
          <view v-for="i in 5" :key="i" class="skeleton-card" />
        </view>

        <!-- 课程卡片 -->
        <course-card
          v-for="course in courses"
          :key="course.id"
          :course="course"
          @click="goDetail(course.id)"
        />

        <!-- 加载更多 -->
        <view v-if="loadingMore" class="load-more">
          <text>加载中...</text>
        </view>
        <view v-else-if="noMore && courses.length" class="load-more">
          <text>—— 已加载全部 ——</text>
        </view>

        <!-- 空状态 -->
        <empty-state
          v-if="!loading && !courses.length"
          icon="📚"
          title="暂无课程"
          desc="换个筛选条件试试？"
        />
      </view>
    </scroll-view>

    <tab-bar current="pages/course/list" />
    <view class="tab-bar-placeholder" />
  </view>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { onShow } from '@dcloudio/uni-app'
import { getCourseList, getCurrentStudent } from '@/api/course'
import { safeHideTabBar } from '@/utils/tabBar'
import { useCartStore } from '@/stores/cart'
import type { Course } from '@/types'

const cartStore = useCartStore()
const currentSemesterId = ref<string | number>('')
const currentClassId = ref<number | undefined>(undefined)
const currentGradeId = ref<number | undefined>(undefined)
const activeFilter = ref<number | string>('')
const courses = ref<Course[]>([])
const loading = ref(false)
const loadingMore = ref(false)
const refreshing = ref(false)
const noMore = ref(false)
const pageNum = ref(1)
const pageSize = 10

const filters = [
  { label: '全部', value: '' },
  { label: '周一', value: 1 },
  { label: '周二', value: 2 },
  { label: '周三', value: 3 },
  { label: '周四', value: 4 },
  { label: '周五', value: 5 }
]

async function ensureSemester() {
  await cartStore.loadSemester()
  currentSemesterId.value = cartStore.currentSemesterId
}

async function ensureStudentInfo() {
  if (currentClassId.value === undefined || currentGradeId.value === undefined) {
    try {
      const student = await getCurrentStudent()
      currentClassId.value = student?.classId != null ? Number(student.classId) : undefined
      currentGradeId.value = student?.gradeId != null ? Number(student.gradeId) : undefined
    } catch {
      currentClassId.value = undefined
      currentGradeId.value = undefined
    }
  }
}

async function fetchCourses(reset = false) {
  if (reset) {
    pageNum.value = 1
    noMore.value = false
    courses.value = []
    loading.value = true
  } else {
    if (noMore.value) return
    loadingMore.value = true
  }
  try {
    await ensureSemester()
    await ensureStudentInfo()
    const res = await getCourseList({
      pageNum: pageNum.value,
      pageSize,
      weekDay: activeFilter.value !== '' ? activeFilter.value : undefined,
      semesterId: currentSemesterId.value || undefined,
      classId: currentClassId.value,
      gradeId: currentGradeId.value
    })
    const rows = res?.rows ?? []
    const total = res?.total ?? 0
    if (reset) {
      courses.value = rows
    } else {
      courses.value.push(...rows)
    }
    if (courses.value.length >= total) noMore.value = true
    pageNum.value++
  } finally {
    loading.value = false
    loadingMore.value = false
    refreshing.value = false
  }
}

function setFilter(val: number | string) {
  activeFilter.value = val
  fetchCourses(true)
}

async function onRefresh() {
  refreshing.value = true
  await fetchCourses(true)
}

function loadMore() {
  if (loadingMore.value || noMore.value) return
  fetchCourses(false)
}

function goDetail(id: string | number) {
  uni.navigateTo({ url: `/pages/course/detail?id=${id}` })
}

onMounted(() => fetchCourses(true))
onShow(async () => {
  safeHideTabBar()
  try {
    await cartStore.loadSemester()
    currentSemesterId.value = cartStore.currentSemesterId
  } catch {
    // 网络错误或未登录时静默处理，request 内部会跳转登录页
  }
})
</script>

<style lang="scss" scoped>
.list-page {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background: var(--bg-page);
}

.list-header {
  padding: calc(var(--status-bar-height) + 24rpx) 32rpx 40rpx;
  background: var(--primary-gradient);
  color: #fff;
  box-shadow: 0 4rpx 20rpx rgba(15, 23, 42, 0.1);
  z-index: 10;
}
.list-title {
  font-size: 48rpx;
  font-weight: 800;
  letter-spacing: -1rpx;
  display: block;
  margin-bottom: 8rpx;
}
.list-sub {
  font-size: 26rpx;
  opacity: 0.9;
  font-weight: 500;
}

.filter-scroll {
  background: var(--bg-card);
  padding: 24rpx 0;
  white-space: nowrap;
  border-bottom: 1rpx solid rgba(226, 232, 240, 0.6);
  position: sticky;
  top: 0;
  z-index: 9;
}
.filter-chips {
  display: flex;
  padding: 0 32rpx;
  gap: 20rpx;
}
.chip {
  padding: 14rpx 36rpx;
  background: #f1f5f9;
  border-radius: 999rpx;
  font-size: 28rpx;
  color: #64748b;
  font-weight: 600;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  border: 1rpx solid transparent;

  &.active {
    background: var(--primary);
    color: #fff;
    box-shadow: 0 8rpx 20rpx -6rpx var(--primary);
    transform: translateY(-2rpx);
  }
  
  &:active {
    transform: scale(0.96);
  }
}

.course-list {
  flex: 1;
  background: var(--bg-page);
}

.list-inner {
  padding: 32rpx;
  display: flex;
  flex-direction: column;
  gap: 24rpx;
  padding-bottom: calc(120rpx + env(safe-area-inset-bottom));
}

.skeleton-list {
  display: flex;
  flex-direction: column;
  gap: 24rpx;
}
.skeleton-card {
  height: 240rpx;
  background: #e2e8f0;
  border-radius: 24rpx;
  animation: pulse 1.5s infinite;
}

@keyframes pulse {
  0% { opacity: 1; }
  50% { opacity: 0.6; }
  100% { opacity: 1; }
}

.load-more {
  padding: 32rpx 0;
  text-align: center;
  color: #94a3b8;
  font-size: 26rpx;
}
</style>
