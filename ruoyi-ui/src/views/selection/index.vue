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
                      :class="{ 'is-selected': isSelected(d.value, c.id) }"
                    >
                      <div class="course-left-border" :style="{ backgroundColor: getCourseColor(c.courseName) }"></div>
                      <div class="course-content">
                        <h4 class="course-name">{{ c.courseName }}</h4>
                        <div class="course-info">
                          <span class="info-item"><el-icon><User /></el-icon> {{ c.teacherName }}</span>
                          <span v-if="c.location" class="info-item"><el-icon><Location /></el-icon> {{ c.location }}</span>
                          <span class="info-item"><el-icon><School /></el-icon> {{ c.gradeName }}</span>
                          <span class="info-item"><el-icon><Timer /></el-icon> {{ weekDayLabel(c.weekDay) }}</span>
                          <span v-if="c.quota != null && c.selected != null" class="info-item quota-info" :title="'班级名额\\已选人数'">
                            <el-icon><UserFilled /></el-icon> {{ c.quota }}\{{ c.selected }}
                          </span>
                        </div>
                        <p class="course-desc" :title="c.description">{{ c.description || '暂无简介' }}</p>
                      </div>
                      <div class="course-action">
                        <el-button
                          v-if="isSelected(d.value, c.id)"
                          type="success"
                          icon="Check"
                          circle
                          disabled
                        ></el-button>
                        <el-button
                          v-else
                          type="primary"
                          icon="Plus"
                          circle
                          :disabled="!!cart[d.value]"
                          @click="handleAddToCart(c)"
                        ></el-button>
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
                      <el-button type="danger" link icon="Delete" @click="handleRemoveFromCart(d.value)"></el-button>
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
import { ref, computed, getCurrentInstance, onMounted } from 'vue'
import { User, UserFilled, School, Timer, Location, Check, Plus, Delete, Calendar, Warning, CircleCheck } from '@element-plus/icons-vue'
import { getCart, addToCart, removeFromCart, clearCart, submitSelection } from '@/api/course/selection'
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
const courseList = ref([])
const courseLoading = ref(false)
const activeWeekDay = ref('1') // Ensure string for el-tabs

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
  return selected && selected.id === courseId
}

// Generate a consistent color based on string
function getCourseColor(str) {
  const colors = ['#409EFF', '#67C23A', '#E6A23C', '#F56C6C', '#909399', '#36cfc9', '#9254de', '#f759ab']
  let hash = 0
  if (!str) return colors[0]
  for (let i = 0; i < str.length; i++) {
    hash = str.charCodeAt(i) + ((hash << 5) - hash)
  }
  return colors[Math.abs(hash) % colors.length]
}

function loadSemester() {
  return getCurrentSemester().then(res => {
    currentSemester.value = res.data
    return currentSemester.value
  })
}

function loadStudent() {
  return getCurrentStudent().then(res => {
    currentStudent.value = res.data
    return res.data
  }).catch(() => {
    currentStudent.value = null
    return null
  })
}

function loadCart() {
  if (!currentSemester.value?.id) return
  getCart(currentSemester.value.id).then(res => {
    // 假设后端返回的是 Map<Integer, Course> 或者类似的结构
    // 需要确保 cart.value 是一个对象，key 是 weekDay
    cart.value = res.data || {}
  })
}

function loadCourses() {
  if (!currentSemester.value?.id) return
  courseLoading.value = true
  listCourse({
    semesterId: currentSemester.value.id,
    gradeId: currentStudent.value?.gradeId,
    classId: currentStudent.value?.classId,
    pageNum: 1,
    pageSize: 500
  }).then(res => {
    courseList.value = res.rows || []
    courseLoading.value = false
  }).catch(() => {
    courseLoading.value = false
  })
}

function handleAddToCart(course) {
  if (!currentSemester.value?.id) return
  addToCart(currentSemester.value.id, course.id).then(res => {
    if (res.msg) proxy.$modal.msgSuccess(res.msg)
    // 更新本地购物车状态，避免频繁请求
    cart.value[course.weekDay] = course
    loadCart() // 还是重新加载以确保一致性
  }).catch(err => {
    // proxy.$modal.msgError(err.msg || '加入失败')
  })
}

function handleRemoveFromCart(weekDay) {
  if (!currentSemester.value?.id) return
  removeFromCart(currentSemester.value.id, weekDay).then(() => {
    delete cart.value[weekDay]
    loadCart()
  })
}

function handleClearCart() {
  if (!currentSemester.value?.id) return
  proxy.$modal.confirm('确定清空所有预选课程吗？').then(() => {
    return clearCart(currentSemester.value.id)
  }).then(() => {
    cart.value = {}
    proxy.$modal.msgSuccess('已清空')
  })
}

function handleSubmit() {
  if (!currentSemester.value?.id) return
  proxy.$modal.confirm('确定提交选课结果吗？提交后将无法更改（除非管理员允许）。').then(() => {
    return submitSelection(currentSemester.value.id)
  }).then(res => {
    proxy.$modal.msgSuccess('选课提交成功！')
    // 跳转到我的课表页面
    // router.push('/selection/my') // 如果需要
  })
}

onMounted(() => {
  loadSemester().then(semester => {
    if (semester) {
      loadStudent().then(() => {
        loadCourses()
        loadCart()
      })
    }
  })
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
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 18px;
  padding: 16px 0;
}

.course-item {
  display: flex;
  flex-direction: column;
  background: #fff;
  border: 1px solid #dde6ff;
  border-radius: 12px;
  transition: all 0.28s cubic-bezier(0.34, 1.56, 0.64, 1);
  overflow: hidden;
  position: relative;

  &:hover {
    box-shadow: var(--cs-card-hover-shadow, 0 8px 28px rgba(59,91,219,0.16));
    transform: translateY(-5px);
    border-color: #b3c6ff;
  }

  /* 已选角标 */
  &.is-selected {
    background: linear-gradient(135deg, #f0fff4, #e8f5e9);
    border-color: #a5d6a7;

    &::after {
      content: "\2713 已预选";
      position: absolute;
      top: 10px;
      right: -1px;
      background: #2f9e44;
      color: #fff;
      font-size: 11px;
      font-weight: 600;
      padding: 2px 10px 2px 8px;
      border-radius: 10px 0 0 10px;
      letter-spacing: 0.5px;
    }

    .course-left-border { opacity: 0.7; }
  }

  .course-left-border {
    width: 100%;
    height: 6px;
    flex-shrink: 0;
    border-radius: 0;
  }

  .course-content {
    flex: 1;
    padding: 16px 18px 12px;
    display: flex;
    flex-direction: column;

    .course-name {
      margin: 0 0 10px;
      font-size: 1.05rem;
      font-weight: 700;
      color: #1e2a5e;
      line-height: 1.4;
      height: 2.8em;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .course-info {
      display: flex;
      flex-direction: column;
      gap: 6px;
      margin-bottom: 12px;
      flex: 1;

      .info-item {
        display: flex;
        align-items: center;
        font-size: 0.875rem;
        color: #555e8a;

        .el-icon {
          margin-right: 7px;
          color: #748fd6;
          font-size: 15px;
          flex-shrink: 0;
        }
      }

      .quota-info {
        display: inline-flex;
        align-self: flex-start;
        background: linear-gradient(135deg, #edf1fb, #dde6ff);
        padding: 3px 10px;
        border-radius: 20px;
        color: #3B5BDB;
        font-size: 0.82rem;
        font-weight: 600;
        margin-top: 2px;
        border: 1px solid #c6d4f0;
      }
    }

    .course-desc {
      margin-top: auto;
      font-size: 0.82rem;
      color: #8e97c8;
      line-height: 1.6;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
      border-top: 1px dashed #dde6ff;
      padding-top: 10px;
      font-style: italic;
    }
  }

  .course-action {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    padding: 10px 18px;
    background: #f8f9ff;
    border-top: 1px solid #eef1fc;
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