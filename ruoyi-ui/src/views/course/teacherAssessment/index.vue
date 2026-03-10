<template>
  <div class="app-container teacher-assessment-page">
    <!-- 页头 -->
    <div class="page-header">
      <div class="header-icon">
        <el-icon :size="28"><TrendCharts /></el-icon>
      </div>
      <div class="header-text">
        <h1 class="page-title">教师考核</h1>
        <p class="page-desc">根据学生课程评分计算教师平均得分，可查看评价详情并导出</p>
      </div>
    </div>

    <!-- 统计卡片 -->
    <el-row v-show="assessmentList.length > 0" :gutter="16" class="stats-row">
      <el-col :xs="12" :sm="8" :md="6">
        <div class="stat-card">
          <div class="stat-value">{{ assessmentList.length }}</div>
          <div class="stat-label">考核教师</div>
        </div>
      </el-col>
      <el-col :xs="12" :sm="8" :md="6">
        <div class="stat-card">
          <div class="stat-value">{{ avgScoreDisplay }}</div>
          <div class="stat-label">平均得分</div>
        </div>
      </el-col>
      <el-col :xs="12" :sm="8" :md="6">
        <div class="stat-card">
          <div class="stat-value">{{ totalEvalCount }}</div>
          <div class="stat-label">总评价人次</div>
        </div>
      </el-col>
    </el-row>

    <!-- 得分分析：区间统计 + 分布图 -->
    <el-row v-show="assessmentList.length > 0" :gutter="16" class="analysis-row">
      <el-col :xs="24" :md="10">
        <el-card class="analysis-card" shadow="never">
          <template #header>
            <span class="card-title">得分区间分布</span>
          </template>
          <div class="score-distribution">
            <div class="dist-item" v-for="(item, idx) in scoreDistribution" :key="idx">
              <span class="dist-label">
                <el-tag :type="item.tagType" size="small" effect="plain">{{ item.label }}</el-tag>
                <span class="dist-desc">{{ item.desc }}</span>
              </span>
              <span class="dist-value">{{ item.count }} 人</span>
              <el-progress
                :percentage="scoreDistributionPercent(item.count)"
                :color="item.color"
                :stroke-width="10"
                style="margin-top: 6px; max-width: 200px;"
              />
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :md="14">
        <el-card class="analysis-card chart-card" shadow="never">
          <template #header>
            <span class="card-title">得分分布图</span>
          </template>
          <div ref="chartRef" class="score-chart"></div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 搜索区 -->
    <el-card v-show="showSearch" class="search-card" shadow="never">
      <el-form :model="queryParams" ref="queryRef" :inline="true" label-width="88px">
        <el-form-item label="学期" prop="semesterId">
          <el-select v-model="queryParams.semesterId" placeholder="请选择学期" clearable style="width: 200px" @change="handleQuery">
            <el-option v-for="s in semesterList" :key="s.id" :label="s.semesterName" :value="s.id" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
          <el-button icon="Refresh" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['course:teacherAssessment:export']"
        >导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="RefreshRight"
          @click="handleInitAssessmentData"
          v-hasPermi="['course:teacherAssessment:edit']"
        >初始化考核数据</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-card class="table-card" shadow="never">
      <el-table v-loading="loading" :data="paginatedList" border stripe class="assessment-table" default-sort="{ prop: 'avgScore', order: 'descending' }">
        <el-table-column label="排名" align="center" width="72" class-name="rank-cell">
          <template #default="scope">
            <el-tag v-if="getRank(scope.$index) <= 3" :type="getRank(scope.$index) === 1 ? 'danger' : getRank(scope.$index) === 2 ? 'warning' : 'success'" effect="dark" size="small">
              {{ getRank(scope.$index) }}
            </el-tag>
            <span v-else class="rank-num">{{ getRank(scope.$index) }}</span>
          </template>
        </el-table-column>
        <el-table-column label="教师姓名" align="center" prop="teacherName" min-width="120" show-overflow-tooltip>
          <template #default="scope">
            <div class="teacher-name-cell">
              <el-avatar :size="28" :style="{ backgroundColor: getAvatarColor(scope.row.teacherName) }">
                {{ (scope.row.teacherName || '教').charAt(0) }}
              </el-avatar>
              <span>{{ scope.row.teacherName || '-' }}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="学期" align="center" prop="semesterName" min-width="180">
          <template #default="scope">
            <el-tag type="warning" effect="plain" size="small">{{ scope.row.semesterName }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="平均得分" align="center" prop="avgScore" width="90">
          <template #default="scope">
            <el-tag :type="getScoreTagType(scope.row.avgScore)" effect="dark">
              {{ scope.row.avgScore != null ? scope.row.avgScore : '-' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="评价人次" align="center" prop="evalCount" width="100">
          <template #default="scope">
            <span class="num-cell"><el-icon><ChatDotRound /></el-icon> {{ scope.row.evalCount ?? 0 }}</span>
          </template>
        </el-table-column>
        <el-table-column label="授课门数" align="center" prop="courseCount" width="100">
          <template #default="scope">
            <span class="num-cell"><el-icon><Reading /></el-icon> {{ scope.row.courseCount ?? 0 }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" align="center" width="180" class-name="small-padding fixed-width">
          <template #default="scope">
            <el-button
              link
              type="primary"
              icon="View"
              @click="handleViewDetail(scope.row)"
              v-hasPermi="['course:teacherAssessment:query']"
            >评价详情</el-button>
            <el-button
              v-if="scope.row.teacherId"
              link
              type="danger"
              icon="Delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['course:teacherAssessment:remove']"
            >删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <pagination
        v-show="total > 0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        :page-sizes="[10, 20, 50, 100]"
        @pagination="() => {}"
      />
    </el-card>

    <el-empty v-if="!loading && assessmentList.length === 0" class="empty-state" description="暂无考核数据，请先让学生完成课程评价">
      <template #image>
        <el-icon :size="64" color="#c0c4cc"><TrendCharts /></el-icon>
      </template>
    </el-empty>

    <!-- 评价详情弹窗 -->
    <el-dialog
      v-model="detailOpen"
      :title="'评价详情 - ' + (detailTeacherName || '')"
      width="900px"
      append-to-body
      destroy-on-close
      class="detail-dialog"
    >
      <el-table v-loading="detailLoading" :data="detailList" border stripe max-height="400">
        <el-table-column label="学生" align="center" width="80">
          <template #default="scope">
            {{ maskStudentName(scope.row.studentName ?? scope.row.student_name) }}
          </template>
        </el-table-column>
        <el-table-column label="学号" align="center" prop="studentNo" width="100" />
        <el-table-column label="班级" align="center" prop="className" width="100" />
        <el-table-column label="课程" align="center" prop="courseName" min-width="120" />
        <el-table-column label="评价题目" align="center" prop="questionContent" min-width="150" show-overflow-tooltip />
        <el-table-column label="得分" align="center" width="80">
          <template #default="scope">
            <span>{{ scope.row.score }}/{{ scope.row.maxScore }}</span>
          </template>
        </el-table-column>
        <el-table-column label="评价时间" align="center" prop="createTime" width="160">
          <template #default="scope">
            <span>{{ scope.row.createTime ? parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{i}') : '' }}</span>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!detailLoading && detailList.length === 0" description="暂无评价详情" />
    </el-dialog>
  </div>
</template>

<script setup name="TeacherAssessment">
import { ref, reactive, computed, toRefs, getCurrentInstance, onMounted, onActivated, watch, onBeforeUnmount } from 'vue'
import { TrendCharts, ChatDotRound, Reading } from '@element-plus/icons-vue'
import * as echarts from 'echarts'
import { listTeacherAssessment, getTeacherEvaluationDetail, initAssessmentData, deleteTeacherAssessment } from '@/api/course/teacherAssessment'
import { listSemesterAll, getCurrentSemester } from '@/api/course/semester'
import { parseTime } from '@/utils/ruoyi'

const { proxy } = getCurrentInstance()

const assessmentList = ref([])
const semesterList = ref([])
const loading = ref(true)
const showSearch = ref(true)
const detailOpen = ref(false)
const detailLoading = ref(false)
const detailList = ref([])
const detailTeacherName = ref('')
const chartRef = ref(null)
let chartInstance = null

const data = reactive({
  queryParams: {
    semesterId: undefined,
    pageNum: 1,
    pageSize: 10
  }
})

const { queryParams } = toRefs(data)
const total = ref(0)

/** 平均得分 */
const avgScoreDisplay = computed(() => {
  const list = assessmentList.value
  if (!list.length) return '-'
  const sum = list.reduce((a, r) => a + (r.avgScore ?? 0), 0)
  return (sum / list.length).toFixed(1)
})

/** 总评价人次 */
const totalEvalCount = computed(() => {
  return assessmentList.value.reduce((a, r) => a + (r.evalCount ?? 0), 0)
})

/** 按平均得分降序排序后的列表 */
const sortedAssessmentList = computed(() => {
  const list = [...assessmentList.value]
  return list.sort((a, b) => (b.avgScore ?? 0) - (a.avgScore ?? 0))
})

/** 当前页的列表（分页切片），排名 = (pageNum-1)*pageSize + 行号 */
const paginatedList = computed(() => {
  const list = sortedAssessmentList.value
  const { pageNum, pageSize } = queryParams.value
  const start = (pageNum - 1) * pageSize
  return list.slice(start, start + pageSize)
})

/** 当前页某行的全局排名 */
function getRank(index) {
  const { pageNum, pageSize } = queryParams.value
  return (pageNum - 1) * pageSize + index + 1
}

/** 得分区间分布：优秀≥9、良好7-9、及格5-7、待提升<5 */
const scoreDistribution = computed(() => {
  const list = assessmentList.value
  const excellent = list.filter(r => (r.avgScore ?? 0) >= 9).length
  const good = list.filter(r => { const s = r.avgScore ?? 0; return s >= 7 && s < 9; }).length
  const pass = list.filter(r => { const s = r.avgScore ?? 0; return s >= 5 && s < 7; }).length
  const improve = list.filter(r => (r.avgScore ?? 0) < 5).length
  const total = list.length || 1
  return [
    { label: '优秀', desc: '≥9分', count: excellent, tagType: 'success', color: '#10B981' },
    { label: '良好', desc: '7~9分', count: good, tagType: 'primary', color: '#3B82F6' },
    { label: '及格', desc: '5~7分', count: pass, tagType: 'warning', color: '#F59E0B' },
    { label: '待提升', desc: '<5分', count: improve, tagType: 'danger', color: '#EF4444' }
  ]
})

function scoreDistributionPercent(count) {
  const total = assessmentList.value.length || 1
  return Math.round((count / total) * 100)
}

function getList() {
  loading.value = true
  const semesterId = queryParams.value.semesterId || null
  listTeacherAssessment(semesterId)
    .then(res => {
      // 兼容 AjaxResult.data、rows 或直接数组
      const raw = res?.data ?? res?.rows ?? res
      const list = Array.isArray(raw) ? raw : (raw && Array.isArray(raw.list) ? raw.list : [])
      assessmentList.value = list
      total.value = list.length
    })
    .catch(err => {
      console.error('获取教师考核列表失败:', err)
      assessmentList.value = []
      total.value = 0
    })
    .finally(() => {
      loading.value = false
    })
}

/** 根据姓名生成头像背景色 */
function getAvatarColor(name) {
  const colors = ['#4F46E5', '#3B82F6', '#0EA5E9', '#10B981', '#8B5CF6', '#EC4899', '#F59E0B', '#6366F1']
  let hash = 0
  if (name) {
    for (let i = 0; i < name.length; i++) {
      hash = name.charCodeAt(i) + ((hash << 5) - hash)
    }
  }
  return colors[Math.abs(hash) % colors.length]
}

/** 学生姓名脱敏：李小红 -> 李** */
function maskStudentName(name) {
  if (!name || typeof name !== 'string') return '-'
  const s = String(name).trim()
  if (!s) return '-'
  return s.charAt(0) + '**'
}

function getScoreTagType(score) {
  if (score == null) return 'info'
  if (score >= 9) return 'success'
  if (score >= 7) return 'primary'
  if (score >= 5) return 'warning'
  return 'danger'
}

function handleQuery() {
  data.queryParams.pageNum = 1
  getList()
}

function resetQuery() {
  data.queryParams.semesterId = undefined
  data.queryParams.pageNum = 1
  handleQuery()
}

function handleViewDetail(row) {
  detailTeacherName.value = row.teacherName
  detailOpen.value = true
  detailList.value = []
  detailLoading.value = true
  getTeacherEvaluationDetail(row.teacherId, row.teacherName, row.semesterId)
    .then(res => {
      const raw = res?.data ?? res?.rows ?? res
      detailList.value = Array.isArray(raw) ? raw : []
    })
    .finally(() => {
      detailLoading.value = false
    })
}

function handleExport() {
  proxy.download(
    'course/teacherAssessment/export',
    { semesterId: queryParams.value.semesterId },
    `教师考核_${new Date().getTime()}.xlsx`
  )
}

/** 初始化考核数据：双重确认 */
function handleInitAssessmentData() {
  const semesterId = queryParams.value.semesterId
  if (!semesterId) {
    proxy.$modal.msgWarning('请先选择学期')
    return
  }
  const semesterName = semesterList.value.find(s => s.id === semesterId)?.semesterName || '当前学期'
  proxy.$modal.confirm(
    `确认要初始化「${semesterName}」的考核数据吗？此操作将清空该学期的所有学生评价记录，且不可恢复。`
  ).then(() => {
    return proxy.$modal.confirm('请再次确认：此操作将永久删除所有评价数据，确定要继续吗？')
  }).then(() => {
    return initAssessmentData(semesterId)
  }).then((res) => {
    proxy.$modal.msgSuccess(res?.msg || '初始化成功')
    getList()
  }).catch(() => {})
}

/** 删除教师考核数据 */
function handleDelete(row) {
  const name = row.teacherName || '该教师'
  proxy.$modal.confirm(`确认要删除「${name}」在本学期的考核数据吗？删除后该教师的评价记录将清空。`).then(() => {
    return deleteTeacherAssessment(row.teacherId, row.semesterId)
  }).then((res) => {
    proxy.$modal.msgSuccess(res?.msg || '删除成功')
    getList()
  }).catch(() => {})
}

function loadSemesters() {
  return listSemesterAll({}).then(res => {
    const list = res?.data ?? res?.rows ?? []
    semesterList.value = Array.isArray(list) ? list : []
    return semesterList.value
  }).catch(() => {
    semesterList.value = []
    return []
  })
}

function initDefaultSemester() {
  return getCurrentSemester().then(res => {
    const cur = res?.data ?? res
    if (cur?.id) {
      data.queryParams.semesterId = cur.id
    }
  }).catch(() => {})
}

function loadPageData() {
  loadSemesters()
    .then(() => initDefaultSemester())
    .then(() => getList())
    .catch(() => {
      getList()
    })
}

function initChart() {
  if (!chartRef.value || assessmentList.value.length === 0) return
  if (chartInstance) chartInstance.dispose()
  chartInstance = echarts.init(chartRef.value)
  const dist = scoreDistribution.value
  const option = {
    tooltip: { trigger: 'item' },
    legend: { bottom: 0, left: 'center' },
    color: dist.map(d => d.color),
    series: [{
      type: 'pie',
      radius: ['40%', '70%'],
      center: ['50%', '45%'],
      avoidLabelOverlap: false,
      itemStyle: { borderRadius: 6 },
      label: { show: true, formatter: '{b}: {c}人 ({d}%)' },
      data: dist.map(d => ({ name: d.label + ' ' + d.desc, value: d.count }))
    }]
  }
  chartInstance.setOption(option)
}

watch(assessmentList, () => {
  if (assessmentList.value.length > 0) {
    setTimeout(() => initChart(), 100)
  } else if (chartInstance) {
    chartInstance.clear()
  }
}, { deep: true })

onMounted(() => {
  loadPageData()
})

onActivated(() => {
  if (semesterList.value.length === 0) {
    loadPageData()
  } else {
    getList()
  }
})

onBeforeUnmount(() => {
  if (chartInstance) {
    chartInstance.dispose()
    chartInstance = null
  }
})
</script>

<style scoped lang="scss">
.teacher-assessment-page {
  padding-bottom: 20px;
}

/* 页头 */
.page-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 24px;
  padding: 20px 24px;
  background: linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%);
  border-radius: 12px;
  border: 1px solid #e2e8f0;
}
.header-icon {
  width: 52px;
  height: 52px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #4f46e5 0%, #6366f1 100%);
  border-radius: 12px;
  color: #fff;
}
.header-text {
  flex: 1;
}
.page-title {
  margin: 0 0 4px 0;
  font-size: 20px;
  font-weight: 600;
  color: #1e293b;
}
.page-desc {
  margin: 0;
  font-size: 13px;
  color: #64748b;
}

/* 统计卡片 */
.stats-row {
  margin-bottom: 20px;
}
.stat-card {
  padding: 16px 20px;
  background: #fff;
  border-radius: 10px;
  border: 1px solid #e2e8f0;
  box-shadow: 0 1px 3px rgba(0,0,0,0.04);
}
.stat-value {
  font-size: 24px;
  font-weight: 700;
  color: #4f46e5;
  line-height: 1.2;
}
.stat-label {
  font-size: 12px;
  color: #64748b;
  margin-top: 4px;
}

/* 分析区 */
.analysis-row {
  margin-bottom: 20px;
}
.analysis-card {
  border-radius: 10px;
  :deep(.el-card__header) {
    padding: 12px 16px;
    font-weight: 600;
    color: #334155;
  }
  :deep(.el-card__body) { padding: 16px; }
}
.card-title { font-size: 14px; }
.score-distribution {
  display: flex;
  flex-direction: column;
  gap: 14px;
}
.dist-item {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}
.dist-label {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 2px;
}
.dist-desc { font-size: 12px; color: #64748b; }
.dist-value { font-size: 13px; font-weight: 600; color: #475569; }
.score-chart {
  width: 100%;
  height: 260px;
}
.chart-card .el-card__body { padding: 8px; }

/* 表格排名列 */
.rank-cell { font-weight: 600; }
.rank-num { font-size: 14px; color: #64748b; }

/* 搜索卡片 */
.search-card {
  margin-bottom: 16px;
  border-radius: 10px;
  :deep(.el-card__body) { padding: 16px 20px; }
}

/* 表格卡片 */
.table-card {
  border-radius: 10px;
  :deep(.el-card__body) { padding: 0; }
}
.assessment-table {
  border-radius: 8px;
  overflow: hidden;
}
.assessment-table :deep(.el-table__header th) {
  background: #f8fafc !important;
  font-weight: 600;
  color: #475569;
  font-size: 13px;
}

.el-tag[data-v-] { font-weight: 600; }

.teacher-name-cell {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  font-size: 14px;
  font-weight: 500;
  color: #334155;
}
.teacher-name-cell .el-avatar {
  flex-shrink: 0;
  font-size: 12px;
  color: #fff;
}

.num-cell {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-size: 13px;
  color: #475569;
  .el-icon { font-size: 14px; color: #94a3b8; }
}

/* 空状态 */
.empty-state {
  padding: 48px 0;
}

/* 详情弹窗 */
.detail-dialog :deep(.el-dialog__header) {
  padding: 20px 24px;
  border-bottom: 1px solid #e2e8f0;
  margin-right: 0;
}
.detail-dialog :deep(.el-dialog__title) {
  font-size: 16px;
  font-weight: 600;
  color: #1e293b;
}
</style>
