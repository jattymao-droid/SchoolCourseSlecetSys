<template>
  <div class="app-container selection-container">
    <el-alert v-if="!currentSemester" title="当前无选课学期" type="warning" :closable="false" show-icon style="margin-bottom: 20px" />
    <template v-else>
      <div class="semester-header">
        <div class="semester-title">
          <el-icon><Calendar /></el-icon>
          <span>当前学期：{{ currentSemester.semesterName }}</span>
        </div>
        <div class="semester-actions">
          <!-- 这里可以放一些全局操作，比如查看课表 -->
        </div>
      </div>

      <el-row :gutter="24">
        <!-- 左侧：课程列表 -->
        <el-col :lg="16" :md="14" :sm="24">
          <el-card shadow="never" class="course-list-card">
            <template #header>
              <div class="card-header">
                <span>可选课程</span>
                <el-tag v-if="currentStudent?.gradeName" type="info" size="small" effect="plain" class="ml-2">
                  {{ currentStudent.gradeName }}
                </el-tag>
              </div>
            </template>
            
            <el-tabs v-model="activeWeekDay" type="border-card" class="week-tabs">
              <el-tab-pane v-for="d in weekDays" :key="d.value" :label="d.label" :name="String(d.value)">
                <div v-loading="courseLoading" class="course-grid">
                  <template v-if="coursesByDay[String(d.value)] && coursesByDay[String(d.value)].length > 0">
                    <div 
                      v-for="c in coursesByDay[String(d.value)]"
                      :key="c.id"
                      class="course-item"
                      :class="{ 
                        'is-selected': isSelected(d.value, c.id),
                        'is-full': remaining(c) <= 0
                      }"
                    >
                      <div class="course-strip" :style="{ background: getStripGradient(c.weekDay) }"></div>
                      <div class="course-main">
                        <div class="course-header">
                          <h4 class="course-name">{{ c.courseName }}</h4>
                          <span class="week-badge" :style="getWeekBadgeStyle(c.weekDay)">{{ weekDayLabel(c.weekDay) }}</span>
                        </div>
                        <div v-if="c.gradeName || c.teacherName || c.location" class="course-info">
                          <span v-if="c.gradeName" class="info-chip">📚 {{ c.gradeName }}</span>
                          <span v-if="c.teacherName" class="info-chip">👨‍🏫 {{ c.teacherName }}</span>
                          <span v-if="c.location" class="info-chip">📍 {{ c.location }}</span>
                        </div>
                        <div class="quota-section">
                          <div class="quota-bar">
                            <div class="quota-fill" :style="getQuotaStyle(c)"></div>
                          </div>
                          <span class="quota-text" :class="getQuotaTextClass(c)">总名额: {{ c.quota }} / 剩余: {{ remaining(c) }}</span>
                        </div>
                        <div class="quota-section" v-if="c.classQuota !== undefined">
                          <span class="info-chip">班级名额: {{ c.classQuota }} / 剩余: {{ c.classRemaining }}</span>
                        </div>
                        <div class="course-action">
                          <el-button
                            :class="getBtnClass(d.value, c)"
                            :disabled="getBtnDisabled(d.value, c)"
                            @click="!getBtnDisabled(d.value, c) && handleAddToCart(c)"
                          >{{ getBtnLabel(d.value, c) }}</el-button>
                        </div>
                      </div>
                    </div>
                  </template>
                  <el-empty v-else description="该时段暂无课程" :image-size="100" />
                </div>
              </el-tab-pane>
            </el-tabs>
          </el-card>
        </el-col>

        <!-- 右侧：选课车 -->
        <el-col :lg="8" :md="10" :sm="24">
          <el-card shadow="always" class="cart-card" :body-style="{ padding: '0px' }">
            <template #header>
              <div class="cart-header">
                <span>我的预选课表</span>
                <el-tag :type="cartCount === 5 ? 'success' : 'warning'" effect="dark" round>
                  {{ cartCount }} / 5
                </el-tag>
              </div>
            </template>
            
            <div class="cart-body">
              <div class="cart-steps">
                <div v-for="d in weekDays" :key="d.value" class="cart-step-item" :class="{ 'is-active': cart[d.value] }">
                  <div class="step-indicator">
                    <div class="step-dot">
                      <el-icon v-if="cart[d.value]"><Check /></el-icon>
                      <span v-else>{{ d.value }}</span>
                    </div>
                    <div class="step-line" v-if="d.value < 5"></div>
                  </div>
                  <div class="step-content">
                    <div class="step-label">{{ d.label }}</div>
                    <div v-if="cart[d.value]" class="step-course">
                      <span class="step-course-name">{{ cart[d.value].courseName }}</span>
                      <el-tag v-if="cart[d.value].assigned" type="info" size="small" effect="plain">指定</el-tag>
                      <el-button v-else type="danger" link icon="Delete" @click="handleRemoveFromCart(d.value)"></el-button>
                    </div>
                    <div v-else class="step-empty">未选择课程</div>
                  </div>
                </div>
              </div>
            </div>

            <div class="cart-footer">
              <div class="cart-summary" v-if="cartCount < 5">
                <el-icon color="#E6A23C"><Warning /></el-icon>
                <span>还需选择 {{ 5 - cartCount }} 门课程</span>
              </div>
              <div class="cart-summary success" v-else>
                <el-icon color="#67C23A"><CircleCheck /></el-icon>
                <span>已完成所有选择，请提交</span>
              </div>
              
              <div class="cart-buttons">
                <el-button @click="handleClearCart" :disabled="cartCount === 0">清空</el-button>
                <el-button type="primary" @click="handleSubmit" :disabled="cartCount !== 5">确认提交选课</el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </template>
  </div>
</template>

<script setup name="SelectionCart">
import { ref, computed, getCurrentInstance, onMounted, onUnmounted } from 'vue'
import { Check, Delete, Calendar, Warning, CircleCheck } from '@element-plus/icons-vue'
import { getCart, addToCart, removeFromCart, clearCart, submitSelection, getMySelections } from '@/api/course/selection'
import { listCourse } from '@/api/course/course'
import { getCurrentSemester } from '@/api/course/semester'
import { getCurrentStudent } from '@/api/course/student'

const { proxy } = getCurrentInstance()

const weekDayLabels = { 1: '周一', 2: '周二', 3: '周三', 4: '周四', 5: '周五' }
function weekDayLabel(day) {
  return weekDayLabels[day] || `周${day}`
}
const currentSemester = ref(null)
const currentStudent = ref(null)
const cart = ref({})
const mySelectionCourseIds = ref(new Set())
const courseList = ref([])
const courseLoading = ref(false)
const activeWeekDay = ref('1') // Ensure string for el-tabs
const now = ref(Date.now())
let countdownTimer = null

const weekDays = [
  { value: 1, label: '周一' },
  { value: 2, label: '周二' },
  { value: 3, label: '周三' },
  { value: 4, label: '周四' },
  { value: 5, label: '周五' }
]

const coursesByDay = computed(() => {
  const map = {}
  weekDays.forEach(d => { map[String(d.value)] = [] })
  ;(courseList.value || []).forEach(c => {
    const k = String(c.weekDay)
    if (map[k]) map[k].push(c)
  })
  return map
})

const cartCount = computed(() => {
  return Object.keys(cart.value).filter(k => cart.value[k]).length
})

function isSelected(weekDay, courseId) {
  const selected = cart.value[weekDay]
  return selected && (selected.id === courseId || selected.courseId === courseId)
}

/** 课程是否已选（含选课车或已提交选课） */
function isCourseSelected(courseId) {
  return mySelectionCourseIds.value.has(courseId) ||
    weekDays.some(d => {
      const s = cart.value[d.value]
      return s && (s.id === courseId || s.courseId === courseId)
    })
}

/** 解析选课时间（yyyy-MM-dd HH:mm:ss 按本地时间，避免被解析为 UTC） */
function parseSelectionTime(str) {
  if (!str) return NaN
  const s = String(str).trim()
  if (!s) return NaN
  const iso = s.replace(' ', 'T')
  const t = new Date(iso).getTime()
  return isNaN(t) ? new Date(str).getTime() : t
}

/** 选课窗口状态：before | ongoing | after */
const selectionStatus = computed(() => {
  const sem = currentSemester.value
  const startStr = sem?.selectionStartTime ?? sem?.selection_start_time
  const endStr = sem?.selectionEndTime ?? sem?.selection_end_time
  if (!startStr || !endStr) return 'ongoing'
  const t = now.value
  const start = parseSelectionTime(startStr)
  const end = parseSelectionTime(endStr)
  if (isNaN(start) || isNaN(end)) return 'ongoing'
  if (start > end) return 'ongoing' // 配置错误：开始晚于结束
  if (t < start) return 'before'
  if (t > end) return 'after'
  return 'ongoing'
})

/** 选课开始前倒计时文本 */
const countdownText = computed(() => {
  const sem = currentSemester.value
  const startStr = sem?.selectionStartTime ?? sem?.selection_start_time
  if (!startStr || selectionStatus.value !== 'before') return ''
  const diff = parseSelectionTime(startStr) - now.value
  if (diff <= 0) return ''
  const h = Math.floor(diff / 3600000)
  const m = Math.floor((diff % 3600000) / 60000)
  const s = Math.floor((diff % 60000) / 1000)
  const pad = n => n < 10 ? '0' + n : n
  return `倒计时 ${pad(h)}:${pad(m)}:${pad(s)}`
})

/** 课程剩余名额 */
function remaining(c) {
  const q = c.quota ?? c.totalQuota ?? 0
  const s = c.selected ?? c.selectedCount ?? 0
  return q - s
}

/** 按钮文案 */
function getBtnLabel(weekDay, c) {
  if (selectionStatus.value === 'before') return countdownText.value || '选课未开始'
  if (selectionStatus.value === 'after') return '选课已结束'
  if (isCourseSelected(c.id)) return '已选'
  if (remaining(c) <= 0) return '已满员'
  if (cart.value[weekDay] && !isSelected(weekDay, c.id)) return '该天已选'
  return '+ 加入'
}

/** 按钮样式类 */
function getBtnClass(weekDay, c) {
  if (selectionStatus.value === 'before') return 'btn-countdown'
  if (selectionStatus.value === 'after') return 'btn-ended'
  if (isCourseSelected(c.id)) return 'btn-selected'
  if (remaining(c) <= 0) return 'btn-full'
  if (cart.value[weekDay] && !isSelected(weekDay, c.id)) return 'btn-disabled'
  return 'btn-add'
}

/** 按钮是否禁用 */
function getBtnDisabled(weekDay, c) {
  if (selectionStatus.value !== 'ongoing') return true
  if (isCourseSelected(c.id)) return true
  if (remaining(c) <= 0) return true
  if (cart.value[weekDay] && !isSelected(weekDay, c.id)) return true
  return false
}

const WEEK_COLORS = ['', '#3b82f6', '#8b5cf6', '#10b981', '#f59e0b', '#ef4444']
const WEEK_BG = ['', '#eff6ff', '#f5f3ff', '#f0fdf4', '#fffbeb', '#fff1f2']

function getCourseColor(weekDay) {
  return WEEK_COLORS[weekDay] || '#3b82f6'
}

function getStripGradient(weekDay) {
  const c = getCourseColor(weekDay)
  return `linear-gradient(180deg, ${c} 0%, ${c}dd 50%, ${c}99 100%)`
}

function getWeekBadgeStyle(weekDay) {
  const c = getCourseColor(weekDay)
  return {
    background: WEEK_BG[weekDay] || '#eff6ff',
    color: c,
    borderColor: `${c}40`
  }
}

function getQuotaStyle(c) {
  const q = c.quota ?? c.totalQuota ?? 0
  const s = c.selected ?? c.selectedCount ?? 0
  const rem = q > 0 ? q - s : 0
  const pct = q > 0 ? Math.max(0, Math.min(100, (rem / q) * 100)) : 0
  let bg = 'linear-gradient(90deg, #137fec 0%, #0d6bd9 100%)'
  if (rem <= 0) bg = 'linear-gradient(90deg, #94a3b8 0%, #64748b 100%)'
  else if (rem <= 5) bg = 'linear-gradient(90deg, #f59e0b 0%, #d97706 100%)'
  else if (rem <= 10) bg = 'linear-gradient(90deg, #eab308 0%, #ca8a04 100%)'
  return { width: pct + '%', background: bg }
}

function getQuotaTextClass(c) {
  const rem = remaining(c)
  if (rem <= 0) return 'quota-empty'
  if (rem <= 5) return 'quota-low'
  if (rem <= 10) return 'quota-medium'
  return ''
}

function loadSemester() {
  return getCurrentSemester().then(res => {
    currentSemester.value = res.data
    return currentSemester.value
  })
}

function loadStudent() {
  return getCurrentStudent().then(res => {
    const data = res.data ?? res
    currentStudent.value = data
    return data
  }).catch(() => {
    currentStudent.value = null
    return null
  })
}

function loadCart() {
  if (!currentSemester.value?.id) return
  const sid = currentSemester.value.id
  Promise.all([
    getCart(sid),
    getMySelections(sid).catch(() => ({ data: [] }))
  ]).then(([cartRes, myRes]) => {
    cart.value = cartRes?.data || {}
    const list = myRes?.data ?? myRes?.rows ?? (Array.isArray(myRes) ? myRes : [])
    const ids = new Set()
    ;(Array.isArray(list) ? list : []).forEach(item => {
      if (item?.courseId != null) ids.add(item.courseId)
    })
    mySelectionCourseIds.value = ids
  })
}

function loadCourses() {
  if (!currentSemester.value?.id) return
  courseLoading.value = true
  const student = currentStudent.value
  listCourse({
    semesterId: currentSemester.value.id,
    gradeId: student?.gradeId,
    classId: student?.classId,
    pageNum: 1,
    pageSize: 500
  }).then(res => {
    const rows = res.rows ?? res.data?.rows ?? []
    courseList.value = rows.map(normalizeCourse)
    courseLoading.value = false
  }).catch(() => {
    courseLoading.value = false
  })
}

/** 统一课程数据格式：兼容 camelCase/snake_case，确保名额字段正确 */
function normalizeCourse(c) {
  // 基础数据
  const totalQuota = c.totalQuota ?? c.total_quota ?? 0
  const totalSelected = c.selectedCount ?? c.selected_count ?? 0
  
  // 班级数据 (仅当查询参数包含 classId 时有效)
  // Mapper 返回的 q.quota 和 q.selected 对应 c.quota 和 c.selected
  let classQuota = undefined
  let classRemaining = undefined
  
  if (c.quota !== undefined && c.quota !== null) {
      classQuota = c.quota
      const classSelected = c.selected ?? 0
      classRemaining = Math.max(0, classQuota - classSelected)
  }

  return {
    ...c,
    // 主显示区使用总名额
    quota: totalQuota,
    selected: totalSelected,
    
    // 原始字段保留或标准化
    totalQuota,
    selectedCount: totalSelected,
    
    // 班级特定字段
    classQuota,
    classRemaining
  }
}

function handleAddToCart(course) {
  if (!currentSemester.value?.id) return
  addToCart(currentSemester.value.id, course.id).then(res => {
    if (res.msg) proxy.$modal.msgSuccess(res.msg)
    // 更新本地购物车状态，避免频繁请求
    cart.value[course.weekDay] = course
    loadCart()
    loadCourses() // 刷新课程列表，更新剩余名额
  }).catch(err => {
    // proxy.$modal.msgError(err.msg || '加入失败')
  })
}

function handleRemoveFromCart(weekDay) {
  if (!currentSemester.value?.id) return
  if (cart.value[weekDay]?.assigned) {
    proxy.$modal.msgWarning('该课程为管理员指定，不可移除')
    return
  }
  removeFromCart(currentSemester.value.id, weekDay).then(() => {
    delete cart.value[weekDay]
    loadCart()
    loadCourses() // 刷新课程列表，更新剩余名额
  }).catch(err => {
    proxy.$modal.msgError(err?.response?.data?.msg || err?.message || '移除失败')
  })
}

function handleClearCart() {
  if (!currentSemester.value?.id) return
  proxy.$modal.confirm('确定清空所有可移除的预选课程吗？（管理员指定的课程将保留）').then(() => {
    return clearCart(currentSemester.value.id)
  }).then(() => {
    loadCart()
    loadCourses() // 刷新课程列表，更新剩余名额
    proxy.$modal.msgSuccess('已清空')
  }).catch(() => {})
}

function handleSubmit() {
  if (!currentSemester.value?.id) return
  proxy.$modal.confirm('确定提交选课结果吗？提交后将无法更改（除非管理员允许）。').then(() => {
    return submitSelection(currentSemester.value.id)
  }).then(() => {
    proxy.$modal.msgSuccess('选课提交成功！')
    loadCart()
    loadCourses() // 刷新课程列表，更新剩余名额
  })
}

onMounted(() => {
  countdownTimer = setInterval(() => { now.value = Date.now() }, 1000)
  loadSemester().then(semester => {
    if (semester) {
      loadStudent().then((student) => {
        currentStudent.value = student ?? currentStudent.value
        loadCourses()
        loadCart()
      })
    }
  })
})

onUnmounted(() => {
  if (countdownTimer) clearInterval(countdownTimer)
})
</script>

<style scoped lang="scss">
@charset "UTF-8";
/* 页面背景 */
.selection-container {
  background-color: var(--cs-bg-page, #f0f4ff);
  min-height: calc(100vh - 84px);
  padding: 20px;
}

/* 学期 Banner */
.semester-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  background: var(--cs-banner-gradient, linear-gradient(135deg, #3B5BDB 0%, #5C7CFA 60%, #74C0FC 100%));
  padding: 18px 24px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(59, 91, 219, 0.3);

  .semester-title {
    display: flex;
    align-items: center;
    font-size: 1.1rem;
    font-weight: 700;
    color: #fff;
    letter-spacing: 0.5px;

    .el-icon {
      margin-right: 10px;
      font-size: 20px;
      color: rgba(255,255,255,0.9);
    }
  }
}

/* 课程列表卡片 */
.course-list-card {
  min-height: 600px;
  margin-bottom: 20px;
  border-radius: 12px !important;

  :deep(.el-card__header) {
    padding: 14px 20px;
    border-bottom: 1px solid #dde6ff;

    .card-header {
      display: flex;
      align-items: center;
      font-weight: 700;
      font-size: 15px;
      color: #3B5BDB;
    }
  }
}

/* 星期 Tab */
.week-tabs {
  border: none;
  box-shadow: none;

  :deep(.el-tabs__header) {
    background-color: #f0f4ff;
    border-bottom: 2px solid #dde6ff;
  }

  :deep(.el-tabs__item) {
    font-weight: 600;
    padding: 0 24px;
    height: 44px;
    line-height: 44px;
    color: #748fd6;
    transition: all 0.2s;

    &.is-active {
      color: #3B5BDB;
    }
  }

  :deep(.el-tabs__active-bar) {
    background-color: #3B5BDB;
    height: 3px;
    border-radius: 2px;
  }
}

/* 课程卡片网格 */
.course-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
  padding: 16px 0;
}

.course-item {
  display: flex;
  background: linear-gradient(145deg, #ffffff 0%, #fafbfc 100%);
  border-radius: 14px;
  overflow: hidden;
  position: relative;
  box-shadow:
    0 1px 4px rgba(15, 23, 42, 0.03),
    0 4px 12px rgba(15, 23, 42, 0.05),
    0 1px 0 rgba(255, 255, 255, 0.8) inset;
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
  border: 1px solid rgba(226, 232, 240, 0.6);

  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.9), transparent);
    pointer-events: none;
  }

  &:hover {
    transform: translateY(-2px);
    box-shadow:
      0 2px 8px rgba(15, 23, 42, 0.04),
      0 8px 24px rgba(15, 23, 42, 0.08);
  }

  &.is-selected {
    border-color: rgba(34, 197, 94, 0.35);
    box-shadow:
      0 2px 8px rgba(34, 197, 94, 0.08),
      0 6px 16px rgba(34, 197, 94, 0.06);
    background: linear-gradient(145deg, #f0fdf4 0%, #ecfdf5 50%, #d1fae5 100%);

    &::after {
      content: "✓ 已预选";
      position: absolute;
      top: 8px;
      right: -1px;
      background: linear-gradient(135deg, #22c55e, #16a34a);
      color: #fff;
      font-size: 11px;
      font-weight: 600;
      padding: 3px 10px 3px 8px;
      border-radius: 12px 0 0 12px;
      letter-spacing: 0.5px;
      box-shadow: 0 2px 6px rgba(34, 197, 94, 0.3);
    }
  }

  &.is-full {
    opacity: 0.72;
    filter: grayscale(0.5) saturate(0.85);
  }

  .course-strip {
    width: 6px;
    flex-shrink: 0;
    border-radius: 14px 0 0 14px;
  }

  .course-main {
    flex: 1;
    padding: 18px 20px 16px;
    display: flex;
    flex-direction: column;
    gap: 14px;
    min-width: 0;
  }

  .course-header {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 12px;
  }

  .course-name {
    margin: 0;
    flex: 1;
    font-size: 1.05rem;
    font-weight: 700;
    color: #0f172a;
    line-height: 1.32;
    letter-spacing: -0.3px;
    min-width: 0;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .week-badge {
    flex-shrink: 0;
    padding: 5px 12px;
    border-radius: 10px;
    font-size: 12px;
    font-weight: 700;
    border: 1.5px solid;
    letter-spacing: 0.5px;
  }

  .course-info {
    display: flex;
    flex-wrap: wrap;
    gap: 8px 12px;
  }

  .info-chip {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 4px 12px;
    background: rgba(241, 245, 249, 0.8);
    border-radius: 12px;
    border: 1px solid rgba(226, 232, 240, 0.5);
    font-size: 12px;
    font-weight: 500;
    color: #475569;
  }

  .quota-section {
    display: flex;
    align-items: center;
    gap: 14px;
    padding: 4px 0;
  }

  .quota-bar {
    flex: 1;
    height: 8px;
    background: rgba(226, 232, 240, 0.6);
    border-radius: 999px;
    overflow: hidden;
  }

  .quota-fill {
    height: 100%;
    border-radius: 999px;
    transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1), background 0.4s;
  }

  .quota-text {
    font-size: 12px;
    color: #475569;
    flex-shrink: 0;
    min-width: 70px;
    text-align: right;
    font-weight: 600;

    &.quota-medium { color: #b45309; }
    &.quota-low { color: #c2410c; }
    &.quota-empty { color: #94a3b8; font-weight: 500; }
  }

  .course-action {
    display: flex;
    justify-content: stretch;
    padding-top: 4px;

    .el-button {
      flex: 1;
      min-width: 0;
      height: 36px;
      padding: 0 16px;
      font-size: 13px;
      font-weight: 600;
      border-radius: 10px;
      letter-spacing: 0.3px;

      &.btn-add {
        background: linear-gradient(135deg, #3B5BDB, #5C7CFA);
        border: none;
        color: #fff;
        box-shadow: 0 2px 8px -2px rgba(59, 91, 219, 0.4);
      }
      &.btn-selected {
        background: linear-gradient(135deg, #dcfce7, #bbf7d0);
        color: #166534;
        border: 1.5px solid rgba(74, 222, 128, 0.5);
        box-shadow: 0 2px 6px rgba(34, 197, 94, 0.12);
      }
      &.btn-full {
        background: linear-gradient(135deg, #fef9c3, #fef08a);
        color: #854d0e;
        border: 1.5px solid rgba(253, 224, 71, 0.5);
        box-shadow: 0 2px 6px rgba(245, 158, 11, 0.1);
      }
      &.btn-countdown {
        background: linear-gradient(135deg, #e0e7ff, #c7d2fe);
        color: #3730a3;
        border: 1.5px solid rgba(165, 180, 252, 0.5);
      }
      &.btn-ended, &.btn-disabled {
        background: linear-gradient(135deg, #f8fafc, #f1f5f9);
        color: #94a3b8;
        border: 1.5px solid #e2e8f0;
      }
    }
  }
}

/* 选课车卡片 */
.cart-card {
  position: sticky;
  top: 20px;
  border-radius: 12px !important;
  overflow: hidden;

  :deep(.el-card__header) {
    background: linear-gradient(135deg, #3B5BDB, #5C7CFA);
    padding: 14px 20px;
    border: none;

    .cart-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-weight: 700;
      font-size: 15px;
      color: #fff;

      .el-tag {
        font-weight: 700;
        font-size: 13px;
      }
    }
  }

  .cart-body {
    padding: 16px;
    min-height: 280px;
    background: #fafbff;
  }

  .cart-footer {
    padding: 14px 16px;
    background: #f0f4ff;
    border-top: 1px solid #dde6ff;

    .cart-summary {
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 12px;
      font-size: 0.9rem;
      color: var(--cs-warning, #e67700);
      font-weight: 500;

      &.success { color: var(--cs-success, #2f9e44); }

      .el-icon { margin-right: 6px; }
    }

    .cart-buttons {
      display: flex;
      gap: 10px;

      .el-button {
        flex: 1;

        &.el-button--primary {
          background: linear-gradient(135deg, #3B5BDB, #5C7CFA);
          border: none;
          font-weight: 700;
          letter-spacing: 0.5px;
          box-shadow: 0 4px 14px rgba(59,91,219,0.35);

          &:not(:disabled):hover {
            background: linear-gradient(135deg, #2f49ae, #3B5BDB);
            box-shadow: 0 6px 18px rgba(59,91,219,0.45);
            transform: translateY(-1px);
          }

          &:disabled {
            background: #c0c4cc;
            box-shadow: none;
          }
        }
      }
    }
  }
}

/* 步骤进度条 */
.cart-steps {
  display: flex;
  flex-direction: column;
  gap: 0;
}

.cart-step-item {
  display: flex;
  margin-bottom: 0;

  &:last-child .step-indicator .step-line { display: none; }

  &.is-active {
    .step-dot {
      background: linear-gradient(135deg, #2f9e44, #40c057);
      border-color: #2f9e44;
      color: #fff;
      box-shadow: 0 2px 8px rgba(47,158,68,0.4);
    }
    .step-label { color: #1e2a5e; font-weight: 700; }
  }

  .step-indicator {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-right: 14px;
    width: 28px;

    .step-dot {
      width: 26px;
      height: 26px;
      border-radius: 50%;
      border: 2px solid #c6d4f0;
      background: #fff;
      color: #8e97c8;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 12px;
      font-weight: 700;
      transition: all 0.25s;
      z-index: 1;
    }

    .step-line {
      flex: 1;
      width: 2px;
      background: linear-gradient(to bottom, #c6d4f0, #edf1fb);
      min-height: 36px;
      margin: 3px 0;
    }
  }

  .step-content {
    flex: 1;
    padding-bottom: 18px;

    .step-label {
      font-size: 0.88rem;
      color: #8e97c8;
      margin-bottom: 5px;
      font-weight: 500;
    }

    .step-course {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: linear-gradient(135deg, #f0fff4, #e8f5e9);
      padding: 8px 12px;
      border-radius: 8px;
      border: 1px solid #a5d6a7;

      .step-course-name {
        font-size: 0.88rem;
        color: #2f4f2f;
        font-weight: 600;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        max-width: 130px;
      }
    }

    .step-empty {
      font-size: 0.82rem;
      color: #b5bde0;
      font-style: italic;
      padding: 8px 12px;
      background: #f5f7ff;
      border-radius: 6px;
      border: 1px dashed #c6d4f0;
      text-align: center;
    }
  }
}

</style>