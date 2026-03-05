<template>
  <div class="app-container">
    <el-alert v-if="!currentSemester" title="当前无选课学期" type="warning" :closable="false" show-icon style="margin-bottom: 16px" />
    <template v-else>
      <div class="page-header">
        <div class="semester-bar">
          <span class="semester-label">当前学期：</span>
          <el-tag type="primary" size="large">{{ currentSemester.semesterName }}</el-tag>
        </div>
        <div class="view-toggle">
          <el-radio-group v-model="viewMode" size="small">
            <el-radio-button value="list">
              <el-icon><List /></el-icon> 列表
            </el-radio-button>
            <el-radio-button value="week">
              <el-icon><Calendar /></el-icon> 课表
            </el-radio-button>
          </el-radio-group>
        </div>
      </div>

      <el-card shadow="never" class="main-card">
        <template #header>
          <div class="card-header">
            <span>我的选课</span>
            <el-tag v-if="selectionList.length > 0" type="success" effect="plain" round size="small">
              已选 {{ selectionList.length }} 门
            </el-tag>
          </div>
        </template>

        <!-- List View -->
        <el-table v-if="viewMode === 'list'" v-loading="loading" :data="selectionList" stripe>
          <el-table-column label="星期" align="center" prop="weekDay" width="80">
            <template #default="scope">
              <dict-tag :options="weekDayOptions" :value="String(scope.row.weekDay)" />
            </template>
          </el-table-column>
          <el-table-column label="课程名称" align="center" prop="courseName" min-width="140" />
          <el-table-column label="教师" align="center" prop="teacherName" width="100" />
          <el-table-column label="地点" align="center" prop="location" width="120">
            <template #default="scope">
              <span v-if="scope.row.location">📍 {{ scope.row.location }}</span>
              <span v-else>-</span>
            </template>
          </el-table-column>
          <el-table-column label="班级" align="center" prop="className" width="100" />
          <el-table-column label="选课时间" align="center" prop="createTime" width="180">
            <template #default="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" width="120" fixed="right">
            <template #default="scope">
              <el-tag v-if="scope.row.assigned === 1" type="info" size="small" effect="plain">指定</el-tag>
              <el-button
                v-else
                link
                type="danger"
                icon="Delete"
                @click="handleDrop(scope.row)"
                v-hasPermi="['course:selection:drop']"
              >
                退课
              </el-button>
            </template>
          </el-table-column>
        </el-table>

        <!-- Week View -->
        <div v-else-if="viewMode === 'week'" v-loading="loading" class="week-view-container">
          <div class="week-grid">
            <div v-for="day in sortedWeekDays" :key="day.value" class="day-column">
              <div class="day-header" :class="{ 'is-today': isToday(day.value) }">
                {{ day.label }}
              </div>
              <div class="day-body">
                <template v-if="selectionMap[day.value]">
                  <div class="course-card" :style="{ borderLeftColor: getCourseColor(selectionMap[day.value].courseName) }">
                    <div class="course-card-header">
                      <span class="course-name" :title="selectionMap[day.value].courseName">{{ selectionMap[day.value].courseName }}</span>
                    </div>
                    <div class="course-card-body">
                      <div class="info-row"><el-icon><User /></el-icon> {{ selectionMap[day.value].teacherName }}</div>
                      <div class="info-row" v-if="selectionMap[day.value].location"><el-icon><Location /></el-icon> {{ selectionMap[day.value].location }}</div>
                      <div class="info-row"><el-icon><School /></el-icon> {{ selectionMap[day.value].className }}</div>
                    </div>
                    <div class="course-card-footer">
                      <el-tag v-if="selectionMap[day.value].assigned === 1" type="info" size="small" effect="plain">指定</el-tag>
                      <el-button v-else link type="danger" size="small" icon="Delete" @click="handleDrop(selectionMap[day.value])">退课</el-button>
                    </div>
                  </div>
                </template>
                <div v-else class="empty-slot">
                  <div class="empty-icon"><el-icon><Plus /></el-icon></div>
                  <div class="empty-text">无课程</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <el-empty v-if="!loading && selectionList.length === 0 && viewMode === 'list'" description="暂无选课记录" />
      </el-card>
    </template>
  </div>
</template>

<script setup name="MySelection">
import { getMySelections, dropCourse } from '@/api/course/selection'
import { getCurrentSemester } from '@/api/course/semester'

const { proxy } = getCurrentInstance()

const currentSemester = ref(null)
const selectionList = ref([])
const loading = ref(false)
const viewMode = ref('week') // Default to week view for better UX

const { course_week_day } = proxy.useDict('course_week_day')
const weekDayOptions = computed(() => course_week_day.value || [])

const sortedWeekDays = computed(() => {
  // Assuming values are '1', '2', '3', '4', '5', '6', '7'
  // Sort them numerically to ensure Monday to Sunday order
  return [...weekDayOptions.value].sort((a, b) => parseInt(a.value) - parseInt(b.value))
})

const selectionMap = computed(() => {
  const map = {}
  selectionList.value.forEach(item => {
    map[String(item.weekDay)] = item
  })
  return map
})

function loadSemester() {
  getCurrentSemester().then(res => {
    currentSemester.value = res.data
    if (currentSemester.value) {
      loadList()
    }
  })
}

function loadList() {
  if (!currentSemester.value?.id) return
  loading.value = true
  getMySelections(currentSemester.value.id).then(res => {
    selectionList.value = res.data || []
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

function handleDrop(row) {
  if (row.assigned === 1) {
    proxy.$modal.msgWarning('该课程为管理员指定，不可退课')
    return
  }
  // If called from list view, we use confirm modal. 
  // If called from week view popconfirm, we can skip double confirmation or just reuse logic.
  // The popconfirm in template handles the UI confirmation.
  // But here we'll keep the logic generic.
  
  // Check if it's triggered from popconfirm (which doesn't need another modal) 
  // or just reuse the function. 
  // Let's standardise: if row is passed, we check if we need confirmation.
  // Actually, for consistency, let's just call the API if the user confirmed via UI (Popconfirm).
  // But wait, the list view uses `handleDrop` which shows a modal.
  // The week view `el-popconfirm` @confirm calls `handleDrop`.
  // So `handleDrop` will show ANOTHER modal if I am not careful.
  
  // Let's refactor handleDrop to take a second argument `skipConfirm` or check event.
  // OR simply, for week view, we call a new function `executeDrop`.
  
  // Let's stick to the existing `handleDrop` which shows a modal, 
  // and REMOVE `el-popconfirm` from week view to keep interaction consistent (Modal confirmation).
  // Or, use `el-popconfirm` in week view and a separate function.
  
  // Decision: Use Modal for both for consistency.
  
  proxy.$modal.confirm('确定退选《' + row.courseName + '》？退选后可重新选课。').then(() => {
    return doDrop(row.id)
  }).catch(() => {})
}

function doDrop(id) {
    loading.value = true
    dropCourse(id).then(res => {
        proxy.$modal.msgSuccess(res.msg || '退课成功')
        loadList()
    }).catch(err => {
        loading.value = false
        if (err !== 'cancel') {
            // proxy.$modal.msgError(err.msg || '退课失败') // request interceptor handles error usually
        }
    })
}

// Generate color
function getCourseColor(str) {
  const colors = ['#409EFF', '#67C23A', '#E6A23C', '#F56C6C', '#909399', '#36cfc9', '#9254de', '#f759ab']
  let hash = 0
  if (!str) return colors[0]
  for (let i = 0; i < str.length; i++) {
    hash = str.charCodeAt(i) + ((hash << 5) - hash)
  }
  return colors[Math.abs(hash) % colors.length]
}

function isToday(val) {
  const today = new Date().getDay() // 0 (Sun) to 6 (Sat)
  // Our values are likely 1 (Mon) to 7 (Sun)
  // Map JS getDay() to 1-7. 
  // JS: 0=Sun, 1=Mon, ..., 6=Sat
  // Dict: 1=Mon, ..., 5=Fri, 6=Sat, 7=Sun (Usually)
  let day = today
  if (day === 0) day = 7
  return String(day) === String(val)
}

onMounted(() => {
  loadSemester()
})
</script>

<style scoped lang="scss">
// ── 页面头部 ──────────────────────────────────────────
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 18px;
  background: linear-gradient(135deg, #3B5BDB 0%, #5C7CFA 70%, #74C0FC 100%);
  padding: 16px 24px;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(59, 91, 219, 0.3);

  .semester-bar {
    display: flex;
    align-items: center;
    gap: 10px;

    .semester-label {
      font-weight: 700;
      font-size: 15px;
      color: rgba(255,255,255,0.9);
    }

    :deep(.el-tag) {
      background: rgba(255,255,255,0.25);
      border-color: rgba(255,255,255,0.4);
      color: #fff;
      font-weight: 700;
      font-size: 14px;
    }
  }

  :deep(.el-radio-group .el-radio-button__inner) {
    background: rgba(255,255,255,0.15);
    border-color: rgba(255,255,255,0.3);
    color: rgba(255,255,255,0.85);
    font-weight: 600;
  }
  :deep(.el-radio-button.is-active .el-radio-button__inner) {
    background: rgba(255,255,255,0.95);
    color: #3B5BDB;
    box-shadow: none;
  }
}

// ── 主卡片 ────────────────────────────────────────────
.main-card {
  border-radius: 12px;
  border: 1px solid #dde6ff;
  box-shadow: 0 2px 16px rgba(59,91,219,0.08);

  :deep(.el-card__header) {
    background: #f5f7ff;
    border-bottom: 1px solid #dde6ff;
    padding: 14px 20px;

    .card-header {
      display: flex;
      align-items: center;
      gap: 10px;
      font-weight: 700;
      color: #3B5BDB;
      font-size: 15px;
    }
  }
}

// ── 课表视图容器 ──────────────────────────────────────
.week-view-container {
  overflow-x: auto;
  padding-bottom: 10px;
}

.week-grid {
  display: flex;
  gap: 10px;
  min-width: 800px;

  .day-column {
    flex: 1;
    min-width: 130px;
    background-color: #f8f9ff;
    border-radius: 10px;
    overflow: hidden;
    border: 1px solid #dde6ff;
    display: flex;
    flex-direction: column;
    transition: box-shadow 0.2s;

    &:hover {
      box-shadow: 0 4px 16px rgba(59,91,219,0.12);
    }

    .day-header {
      padding: 12px 10px;
      text-align: center;
      background: linear-gradient(to bottom, #eef1fc, #e2e8fc);
      font-weight: 700;
      color: #555e8a;
      border-bottom: 2px solid #d4defc;
      font-size: 14px;
      letter-spacing: 2px;

      &.is-today {
        background: linear-gradient(135deg, #3B5BDB, #5C7CFA);
        color: #fff;
        border-bottom-color: #2f49ae;
      }
    }

    .day-body {
      padding: 10px;
      flex: 1;
      min-height: 200px;
      display: flex;
      flex-direction: column;
    }
  }
}

// ── 课程卡片（周视图） ────────────────────────────────
.course-card {
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(59,91,219,0.1);
  border-left: 4px solid #3B5BDB;
  overflow: hidden;
  transition: all 0.25s cubic-bezier(0.34, 1.56, 0.64, 1);

  &:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(59,91,219,0.18);
  }

  .course-card-header {
    padding: 10px 10px 6px;
    background: linear-gradient(135deg, #f5f7ff, #eef1fc);
    border-bottom: 1px solid #dde6ff;

    .course-name {
      font-weight: 700;
      font-size: 13px;
      color: #1e2a5e;
      display: -webkit-box;
      -webkit-box-orient: vertical;
      -webkit-line-clamp: 2;
      overflow: hidden;
      line-height: 1.4;
    }
  }

  .course-card-body {
    padding: 8px 10px 10px;
    font-size: 12px;
    color: #555e8a;

    .info-row {
      margin-bottom: 4px;
      display: flex;
      align-items: center;
      gap: 5px;

      .el-icon { color: #748fd6; }
    }
  }

  .course-card-footer {
    border-top: 1px solid #eef1fc;
    padding: 4px 10px;
    text-align: right;
    background: #fafbff;
  }
}

// ── 空位插槽 ──────────────────────────────────────────
.empty-slot {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  color: #c6d4f0;
  border: 2px dashed #dde6ff;
  border-radius: 8px;
  height: 100%;
  transition: all 0.2s;

  &:hover {
    border-color: #b3c6ff;
    background: #f5f7ff;
    color: #b3c6ff;
  }

  .empty-icon {
    font-size: 22px;
    margin-bottom: 6px;
  }

  .empty-text {
    font-size: 12px;
    letter-spacing: 1px;
  }
}

// ── 表格样式优化 ──────────────────────────────────────
:deep(.el-table) {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);

  th.el-table__cell {
    background-color: #F8FAFC;
    color: #475569;
    font-weight: 600;
    height: 32px;
    padding: 0;
  }

  td.el-table__cell {
    padding: 0;
  }
  
  .el-table__body tr:hover > td.el-table__cell {
    background-color: #e6f7ff !important;
    background-image: none !important;
  }

  // 操作按钮
  .el-button {
    padding: 4px;
    height: 24px;
    font-size: 12px;
    border-radius: 4px;
  }
}
</style>