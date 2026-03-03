<template>
  <view class="eval-page pad-container">
    <empty-state
      v-if="!loading && !list.length"
      icon="⭐"
      title="暂无待评价课程"
      desc="完成选课后，开启评价时此处将显示课程"
    />

    <scroll-view scroll-y class="eval-scroll" v-else>
      <view class="eval-inner">
        <view v-for="item in list" :key="`${item.courseId}-${item.weekDay}`" class="eval-item card">
          <view class="eval-course">
            <view class="day-chip-sm" :style="{ background: dayBg[item.weekDay], color: dayColor[item.weekDay] }">
              {{ dayLabels[item.weekDay] }}
            </view>
            <view class="eval-info">
              <text class="eval-name">{{ item.courseName }}</text>
              <text class="eval-teacher" v-if="item.teacherName">{{ item.teacherName }}</text>
            </view>
          </view>

          <button
            class="eval-btn"
            :class="{ 'evaluated': item.evaluated }"
            :disabled="item.evaluated"
            @click="openEval(item)"
          >
            {{ item.evaluated ? '✓ 已评价' : '去评价' }}
          </button>
        </view>

        <view v-if="loading" class="loading-text"><text>加载中...</text></view>
      </view>
    </scroll-view>

    <!-- 评价弹窗 -->
    <view class="eval-modal-mask" v-if="showModal" @click.self="closeModal">
      <view class="eval-modal">
        <view class="modal-header">
          <text class="modal-title">{{ activeItem?.courseName }}</text>
          <text class="modal-close" @click="closeModal">✕</text>
        </view>

        <scroll-view scroll-y class="questions-scroll">
          <view class="questions">
            <view v-for="q in activeItem?.questions" :key="q.questionId" class="question-row">
              <text class="question-name">{{ q.content }}</text>
              <text class="question-range">（1~10 分）</text>
              <view class="score-input-wrap">
                <input
                  v-model="scores[String(q.questionId)]"
                  class="score-input"
                  type="number"
                  placeholder="1-10"
                  placeholder-class="score-placeholder"
                />
                <text class="score-unit">分</text>
              </view>
            </view>
          </view>
        </scroll-view>

        <button class="submit-eval-btn btn-primary" :loading="submitting" @click="submitEval">
          提交评价
        </button>
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getPendingEvaluations, submitEvaluation, type CourseToEvaluateVO } from '@/api/evaluation'
import { getCurrentSemester } from '@/api/course'

const list = ref<CourseToEvaluateVO[]>([])
const semesterId = ref<string | number>('')
const loading = ref(false)
const showModal = ref(false)
const activeItem = ref<CourseToEvaluateVO | null>(null)
const scores = ref<Record<string, string>>({})
const submitting = ref(false)

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
    list.value = await getPendingEvaluations(semesterId.value)
  } finally {
    loading.value = false
  }
}

function openEval(item: CourseToEvaluateVO) {
  activeItem.value = item
  scores.value = {}
  showModal.value = true
}

function closeModal() {
  showModal.value = false
  activeItem.value = null
}

async function submitEval() {
  if (!activeItem.value) return
  const questions = activeItem.value.questions || []

  // 校验所有题目都已填写（1~10分）
  for (const q of questions) {
    const val = parseInt(scores.value[String(q.questionId)])
    if (isNaN(val) || val < 1 || val > 10) {
      uni.showToast({ title: `请正确填写「${q.content}」的分值（1~10）`, icon: 'none' })
      return
    }
  }

  submitting.value = true
  try {
    await submitEvaluation({
      courseId: activeItem.value.courseId,
      semesterId: semesterId.value,
      scores: questions.map(q => ({
        questionId: q.questionId,
        score: parseInt(scores.value[String(q.questionId)])
      }))
    })
    uni.showToast({ title: '评价提交成功', icon: 'success' })
    closeModal()
    await loadData()
  } finally {
    submitting.value = false
  }
}

onMounted(loadData)
</script>

<style lang="scss" scoped>
.eval-page { background: #f6f7f8; min-height: 100vh; }
.eval-scroll { height: 100vh; }
.eval-inner { padding: 24rpx 32rpx; }

.eval-item { display: flex; align-items: center; justify-content: space-between; }

.eval-course { display: flex; align-items: center; gap: 16rpx; flex: 1; margin-right: 20rpx; }

.day-chip-sm {
  width: 64rpx;
  height: 64rpx;
  border-radius: 12rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22rpx;
  font-weight: 700;
  flex-shrink: 0;
}

.eval-info { flex: 1; }
.eval-name { display: block; font-size: 28rpx; font-weight: 700; color: #0d141b; margin-bottom: 4rpx; }
.eval-teacher { font-size: 24rpx; color: #4c739a; }

.eval-btn {
  flex-shrink: 0;
  padding: 12rpx 24rpx;
  border-radius: 999rpx;
  background: #137fec;
  color: #fff;
  font-size: 26rpx;
  font-weight: 600;
  border: none;
  &::after { border: none; }
  &.evaluated { background: #f0fdf4; color: #16a34a; }
  &[disabled] { opacity: 1; }
}

.loading-text { text-align: center; padding: 48rpx; color: #94a3b8; font-size: 28rpx; }

/* 评价弹窗 */
.eval-modal-mask {
  position: fixed;
  inset: 0;
  background: rgba(0,0,0,0.5);
  display: flex;
  align-items: flex-end;
  z-index: 1000;
}

.eval-modal {
  background: #fff;
  border-radius: 32rpx 32rpx 0 0;
  padding: 40rpx 32rpx;
  width: 100%;
  max-height: 80vh;
  display: flex;
  flex-direction: column;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32rpx;
}
.modal-title { font-size: 32rpx; font-weight: 700; color: #0d141b; }
.modal-close { font-size: 32rpx; color: #94a3b8; padding: 8rpx; cursor: pointer; }

.questions-scroll { flex: 1; overflow: hidden; }
.questions { display: flex; flex-direction: column; gap: 24rpx; padding-bottom: 20rpx; }

.question-row { background: #f8fafc; border-radius: 12rpx; padding: 24rpx; }
.question-name { display: block; font-size: 28rpx; font-weight: 600; color: #0d141b; margin-bottom: 4rpx; }
.question-range { display: block; font-size: 22rpx; color: #94a3b8; margin-bottom: 16rpx; }

.score-input-wrap {
  display: flex;
  align-items: center;
  background: #fff;
  border: 2rpx solid #e2e8f0;
  border-radius: 12rpx;
  padding: 0 20rpx;
  height: 80rpx;
}
.score-input { flex: 1; height: 80rpx; font-size: 32rpx; font-weight: 700; color: #137fec; }
.score-placeholder { color: #cbd5e1; }
.score-unit { font-size: 26rpx; color: #94a3b8; }

.submit-eval-btn {
  margin-top: 32rpx;
  height: 96rpx;
  line-height: 96rpx;
}

/* Pad 适配 */
@media (min-width: 768px) {
  .eval-page { padding-left: 48rpx; padding-right: 48rpx; }
  .eval-inner { padding: 32rpx 48rpx; }
  .eval-modal {
    max-width: 560px;
    margin: 0 auto;
    border-radius: 24rpx;
    padding: 48rpx 40rpx;
  }
  .eval-modal-mask { align-items: center; }
}
</style>
