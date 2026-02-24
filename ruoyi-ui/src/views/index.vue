<template>
  <div class="app-container dashboard-container">
    <!-- 管理员/教务：选课综合看板 -->
    <template v-if="isAdminView">
      <div class="dashboard-header">
        <h1 class="dashboard-title">选课管理看板</h1>
        <p class="dashboard-subtitle">选课系统综合数据概览</p>
      </div>

      <div v-if="adminStats.currentSemester" class="semester-banner">
        <el-icon><Calendar /></el-icon>
        <span>当前选课学期：</span>
        <strong>{{ adminStats.currentSemester.semesterName }}</strong>
        <span v-if="adminStats.currentSemester.startDate" class="dates">
          {{ adminStats.currentSemester.startDate }} 至 {{ adminStats.currentSemester.endDate }}
        </span>
      </div>
      <div v-else class="semester-banner empty">
        <el-icon><WarningFilled /></el-icon>
        <span>请先在「学期管理」中设置当前选课学期</span>
      </div>

      <!-- KPI 卡片 -->
      <el-row :gutter="20" class="kpi-row">
        <el-col :xs="12" :sm="12" :md="6">
          <el-card shadow="hover" class="kpi-card" @click="router.push('/course/course')">
            <div class="kpi-content">
              <div class="kpi-value">{{ adminStats.courseCount || 0 }}</div>
              <div class="kpi-label">本学期课程</div>
            </div>
            <div class="kpi-chart">
              <div ref="chartCourse" class="mini-chart"></div>
            </div>
          </el-card>
        </el-col>
        <el-col :xs="12" :sm="12" :md="6">
          <el-card shadow="hover" class="kpi-card">
            <div class="kpi-content">
              <div class="kpi-value">{{ adminStats.selectionCount || 0 }}</div>
              <div class="kpi-label">选课人次</div>
            </div>
            <div class="kpi-chart">
              <div ref="chartSelection" class="mini-chart"></div>
            </div>
          </el-card>
        </el-col>
        <el-col :xs="12" :sm="12" :md="6">
          <el-card shadow="hover" class="kpi-card">
            <div class="kpi-content">
              <div class="kpi-value">{{ adminStats.studentCount || 0 }}</div>
              <div class="kpi-label">学生总数</div>
            </div>
            <div class="kpi-chart">
              <div ref="chartStudent" class="mini-chart"></div>
            </div>
          </el-card>
        </el-col>
        <el-col :xs="12" :sm="12" :md="6">
          <el-card shadow="hover" class="kpi-card" @click="router.push('/course/evaluation')">
            <div class="kpi-content">
              <div class="kpi-value">{{ adminStats.questionCount || 0 }}</div>
              <div class="kpi-label">评价题目</div>
            </div>
            <div class="kpi-chart">
              <div ref="chartQuestion" class="mini-chart"></div>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 选课趋势 + 最近选课 -->
      <el-row :gutter="20" class="chart-row">
        <el-col :xs="24" :lg="16">
          <el-card shadow="hover" class="chart-card">
            <template #header>
              <span>选课趋势</span>
              <span class="chart-sub">近14天选课人次</span>
            </template>
            <div ref="trendChart" class="chart-main"></div>
          </el-card>
        </el-col>
        <el-col :xs="24" :lg="8">
          <el-card shadow="hover" class="list-card">
            <template #header>
              <span>最近选课</span>
              <el-button link type="primary" size="small" @click="router.push('/course/course')">查看全部</el-button>
            </template>
            <div class="recent-list">
              <div v-for="(item, i) in (adminStats.recentSelections || [])" :key="i" class="recent-item">
                <el-avatar :size="36" class="avatar">{{ (item.studentName || '学')[0] }}</el-avatar>
                <div class="recent-info">
                  <div class="name">{{ item.studentName }}</div>
                  <div class="desc">{{ item.courseName }} · {{ item.weekDayName }}</div>
                </div>
                <div class="recent-time">{{ formatTime(item.createTime) }}</div>
              </div>
              <el-empty v-if="!(adminStats.recentSelections || []).length" description="暂无选课记录" :image-size="60" />
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 星期分布 + 热门课程 -->
      <el-row :gutter="20" class="chart-row">
        <el-col :xs="24" :lg="10">
          <el-card shadow="hover" class="chart-card">
            <template #header><span>选课分布（按星期）</span></template>
            <div ref="weekdayChart" class="chart-pie"></div>
          </el-card>
        </el-col>
        <el-col :xs="24" :lg="14">
          <el-card shadow="hover" class="course-card">
            <template #header>
              <span>热门课程</span>
              <el-radio-group v-model="courseFilter" size="small">
                <el-radio-button label="popular">热门</el-radio-button>
                <el-radio-button label="all" @click="router.push('/course/course')">全部课程</el-radio-button>
              </el-radio-group>
            </template>
            <div class="course-list">
              <div v-for="c in (adminStats.popularCourses || [])" :key="c.courseId" class="course-item" @click="router.push('/course/course')">
                <div class="course-main">
                  <span class="course-name">{{ c.courseName }}</span>
                  <el-tag size="small">{{ ['周一','周二','周三','周四','周五'][(c.weekDay || 1) - 1] }}</el-tag>
                </div>
                <div class="course-meta">{{ c.teacherName || '-' }} · 已选 {{ c.selectedCount || 0 }} 人</div>
              </div>
              <el-empty v-if="!(adminStats.popularCourses || []).length" description="暂无课程" :image-size="50" />
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 快捷入口 -->
      <el-row :gutter="20" class="action-row">
        <el-col :xs="24" :sm="8">
          <el-card shadow="hover" class="action-card" @click="router.push('/course/semester')">
            <div class="action-content">
              <div class="icon-wrapper blue"><el-icon><Calendar /></el-icon></div>
              <div class="text-wrapper"><h3>学期管理</h3><p>设置选课学期</p></div>
            </div>
          </el-card>
        </el-col>
        <el-col :xs="24" :sm="8">
          <el-card shadow="hover" class="action-card" @click="router.push('/course/course')">
            <div class="action-content">
              <div class="icon-wrapper green"><el-icon><List /></el-icon></div>
              <div class="text-wrapper"><h3>课程管理</h3><p>维护课程与容量</p></div>
            </div>
          </el-card>
        </el-col>
        <el-col :xs="24" :sm="8">
          <el-card shadow="hover" class="action-card" @click="router.push('/course/evaluation')">
            <div class="action-content">
              <div class="icon-wrapper orange"><el-icon><Star /></el-icon></div>
              <div class="text-wrapper"><h3>评价管理</h3><p>配置评价题目</p></div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </template>

    <!-- 学生：选课中心首页 -->
    <template v-else>
      <div class="dashboard-header">
        <h1 class="dashboard-title">欢迎使用选课系统</h1>
        <p class="dashboard-subtitle">轻松选课，规划学习之旅</p>
      </div>

      <div v-if="studentStats.currentSemester" class="semester-card">
        <div class="semester-header">
          <el-icon><Calendar /></el-icon>
          <span>当前学期</span>
        </div>
        <div class="semester-body">
          <h2 class="semester-name">{{ studentStats.currentSemester.semesterName }}</h2>
          <p class="semester-dates" v-if="studentStats.currentSemester.startDate">
            {{ studentStats.currentSemester.startDate }} 至 {{ studentStats.currentSemester.endDate }}
          </p>
        </div>
      </div>
      <div v-else class="semester-card empty">
        <el-empty description="当前非选课时间" :image-size="60" />
      </div>

      <!-- 学生 KPI -->
      <el-row :gutter="20" class="kpi-row" v-if="studentStats.currentSemester">
        <el-col :span="12">
          <el-card shadow="hover" class="kpi-card student">
            <div class="kpi-value">{{ studentStats.selectionCount || 0 }}</div>
            <div class="kpi-label">已选课程</div>
          </el-card>
        </el-col>
        <el-col :span="12">
          <el-card shadow="hover" class="kpi-card student">
            <div class="kpi-value">{{ studentStats.pendingEvaluationCount || 0 }}</div>
            <div class="kpi-label">待评价</div>
          </el-card>
        </el-col>
      </el-row>

      <el-alert v-if="(studentStats.pendingEvaluationCount || 0) > 0" type="warning" :closable="false" show-icon class="eval-alert">
        <template #title>您有 {{ studentStats.pendingEvaluationCount }} 门课程待评价</template>
        <el-button type="primary" size="small" @click="handleGoEvaluation">去评价</el-button>
      </el-alert>

      <!-- 热门课程推荐 -->
      <el-card v-if="studentStats.currentSemester" shadow="hover" class="course-card">
        <template #header>
          <span>热门课程</span>
          <el-button link type="primary" size="small" @click="handleGoSelection">去选课</el-button>
        </template>
        <div class="course-list">
          <div v-for="c in (studentStats.popularCourses || [])" :key="c.courseId" class="course-item" @click="handleGoSelection">
            <div class="course-main">
              <span class="course-name">{{ c.courseName }}</span>
              <el-tag size="small">{{ ['周一','周二','周三','周四','周五'][(c.weekDay || 1) - 1] }}</el-tag>
            </div>
            <div class="course-meta">{{ c.teacherName || '-' }} · 已选 {{ c.selectedCount || 0 }} 人</div>
          </div>
          <el-empty v-if="!(studentStats.popularCourses || []).length" description="暂无课程" :image-size="50" />
        </div>
      </el-card>

      <!-- 快捷入口 -->
      <el-row :gutter="24" class="action-row">
        <el-col :xs="24" :sm="8">
          <el-card shadow="hover" class="action-card" @click="handleGoSelection">
            <div class="action-content">
              <div class="icon-wrapper blue"><el-icon><List /></el-icon></div>
              <div class="text-wrapper"><h3>开始选课</h3><p>浏览课程并加入选课单</p></div>
            </div>
          </el-card>
        </el-col>
        <el-col :xs="24" :sm="8">
          <el-card shadow="hover" class="action-card" @click="handleGoMyCourse">
            <div class="action-content">
              <div class="icon-wrapper green"><el-icon><DataBoard /></el-icon></div>
              <div class="text-wrapper"><h3>我的课表</h3><p>查看已选课程</p></div>
            </div>
          </el-card>
        </el-col>
        <el-col :xs="24" :sm="8">
          <el-card shadow="hover" class="action-card" @click="handleGoEvaluation">
            <div class="action-content">
              <div class="icon-wrapper orange"><el-icon><Star /></el-icon></div>
              <div class="text-wrapper"><h3>课程评价</h3><p>对已选课程评分</p></div>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <div class="footer-tips">请在规定时间内完成选课，如有疑问请联系教务处。</div>
    </template>
  </div>
</template>

<script setup name="Index">
import { ref, computed, onMounted, nextTick } from 'vue'
import { useRouter } from 'vue-router'
import { getAdminStats, getStudentStats } from '@/api/course/dashboard'
import auth from '@/plugins/auth'
import { parseTime } from '@/utils/ruoyi'
import * as echarts from 'echarts'

const router = useRouter()
const adminStats = ref({})
const studentStats = ref({})
const loading = ref(false)
const courseFilter = ref('popular')

const chartCourse = ref(null)
const chartSelection = ref(null)
const chartStudent = ref(null)
const chartQuestion = ref(null)
const trendChart = ref(null)
const weekdayChart = ref(null)

let trendInstance = null
let weekdayInstance = null

const isAdminView = computed(() =>
  auth.hasRoleOr(['admin', 'course_admin']) || auth.hasPermiOr(['course:semester:list', 'course:evaluation:list']))

function formatTime(time) {
  if (!time) return '-'
  return parseTime(time, '{m}-{d} {h}:{i}')
}

function loadData() {
  loading.value = true
  if (isAdminView.value) {
    getAdminStats().then(res => {
      adminStats.value = res.data || {}
      loading.value = false
      nextTick(() => initAdminCharts())
    }).catch(() => { loading.value = false })
  } else {
    getStudentStats().then(res => {
      studentStats.value = res.data || {}
      loading.value = false
    }).catch(() => { loading.value = false })
  }
}

function initAdminCharts() {
  initMiniCharts()
  initTrendChart()
  initWeekdayChart()
}

function initMiniCharts() {
  const colors = ['#667eea', '#f59e0b', '#10b981', '#ef4444']
  const refs = [chartCourse, chartSelection, chartStudent, chartQuestion]
  const vals = [
    adminStats.value.courseCount || 0,
    adminStats.value.selectionCount || 0,
    adminStats.value.studentCount || 0,
    adminStats.value.questionCount || 0
  ]
  const max = Math.max(...vals, 1)
  refs.forEach((r, i) => {
    if (!r.value) return
    const inst = echarts.init(r.value)
    inst.setOption({
      series: [{
        type: 'pie',
        radius: ['70%', '90%'],
        avoidLabelOverlap: false,
        label: { show: false },
        data: [
          { value: vals[i], itemStyle: { color: colors[i] } },
          { value: max - vals[i], itemStyle: { color: '#f0f0f0' } }
        ]
      }]
    })
  })
}

function initTrendChart() {
  if (!trendChart.value) return
  if (trendInstance) trendInstance.dispose()
  trendInstance = echarts.init(trendChart.value)
  const trend = adminStats.value.selectionTrend || []
  const trendMap = Object.fromEntries(trend.map(t => [t.dateStr, t.count || 0]))
  const last14 = []
  for (let i = 13; i >= 0; i--) {
    const d = new Date()
    d.setDate(d.getDate() - i)
    const str = d.toISOString().slice(0, 10)
    last14.push([str.slice(5), trendMap[str] ?? 0])
  }
  const dates = last14.map(([d]) => d)
  const counts = last14.map(([, c]) => c)
  trendInstance.setOption({
    tooltip: { trigger: 'axis' },
    grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
    xAxis: { type: 'category', data: dates, boundaryGap: false },
    yAxis: { type: 'value', name: '人次' },
    series: [{
      name: '选课人次',
      type: 'bar',
      data: counts,
      itemStyle: { color: '#667eea' }
    }]
  })
  window.addEventListener('resize', () => trendInstance?.resize())
}

function initWeekdayChart() {
  if (!weekdayChart.value) return
  if (weekdayInstance) weekdayInstance.dispose()
  weekdayInstance = echarts.init(weekdayChart.value)
  const byWeekday = adminStats.value.selectionByWeekday || []
  const weekNames = ['周一', '周二', '周三', '周四', '周五']
  const data = [1,2,3,4,5].map(d => {
    const item = byWeekday.find(w => Number(w.week_day || w.weekDay) === d)
    return { name: weekNames[d - 1], value: item ? Number(item.cnt) : 0 }
  })
  weekdayInstance.setOption({
    tooltip: { trigger: 'item' },
    series: [{
      type: 'pie',
      radius: ['40%', '70%'],
      data,
      emphasis: { itemStyle: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0,0,0,0.2)' } }
    }]
  })
  window.addEventListener('resize', () => weekdayInstance?.resize())
}

function handleGoSelection() { router.push('/selection/cart') }
function handleGoMyCourse() { router.push('/selection/my') }
function handleGoEvaluation() { router.push('/selection/evaluation') }

onMounted(() => loadData())
</script>

<style scoped lang="scss">
.dashboard-container {
  padding: 24px;
  background: #f5f7fa;
  min-height: calc(100vh - 84px);
}

.dashboard-header {
  margin-bottom: 24px;
  .dashboard-title { font-size: 1.75rem; color: #303133; margin: 0 0 8px; font-weight: 600; }
  .dashboard-subtitle { font-size: 0.95rem; color: #909399; margin: 0; }
}

.semester-banner {
  display: flex; align-items: center; gap: 10px; padding: 16px 24px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white; border-radius: 12px; margin-bottom: 24px; font-size: 1rem;
  &.empty { background: #f56c6c; }
  .el-icon { font-size: 1.5rem; }
  .dates { font-size: 0.9rem; opacity: 0.9; }
}

.semester-card {
  background: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 12px rgba(0,0,0,0.05);
  display: inline-block; min-width: 280px; margin-bottom: 24px;
  &.empty { padding: 16px; }
  .semester-header { display: flex; align-items: center; justify-content: center; color: #909399; font-size: 0.9rem; margin-bottom: 10px; .el-icon { margin-right: 6px; } }
  .semester-body .semester-name { margin: 0 0 5px; color: #409EFF; font-size: 1.4rem; }
  .semester-body .semester-dates { margin: 0; color: #909399; font-size: 0.9rem; }
}

.kpi-row { margin-bottom: 20px; }
.kpi-card {
  border: none; cursor: pointer; transition: all 0.3s;
  display: flex; align-items: center; justify-content: space-between; padding: 20px;
  &:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(0,0,0,0.1); }
  &.student { flex-direction: column; text-align: center; .kpi-value { font-size: 2rem; color: #409EFF; } }
  .kpi-content { flex: 1; }
  .kpi-value { font-size: 1.75rem; font-weight: 700; color: #303133; }
  .kpi-label { font-size: 0.9rem; color: #909399; margin-top: 4px; }
  .kpi-chart { width: 60px; height: 60px; }
  .mini-chart { width: 100%; height: 100%; }
}

.chart-row { margin-bottom: 20px; }
.chart-card, .list-card, .course-card {
  border: none; min-height: 320px;
  :deep(.el-card__header) { display: flex; justify-content: space-between; align-items: center; }
  .chart-sub { font-size: 0.85rem; color: #909399; }
}
.chart-main { height: 280px; }
.chart-pie { height: 260px; }

.recent-list { max-height: 320px; overflow-y: auto; }
.recent-item {
  display: flex; align-items: center; padding: 12px 0; border-bottom: 1px solid #f0f0f0;
  &:last-child { border-bottom: none; }
  .avatar { margin-right: 12px; background: #667eea; }
  .recent-info { flex: 1; .name { font-weight: 500; } .desc { font-size: 0.85rem; color: #909399; } }
  .recent-time { font-size: 0.8rem; color: #c0c4cc; }
}

.course-list { max-height: 280px; overflow-y: auto; }
.course-item {
  padding: 12px 0; border-bottom: 1px solid #f0f0f0; cursor: pointer;
  &:last-child { border-bottom: none; }
  &:hover { background: #fafafa; }
  .course-main { display: flex; align-items: center; justify-content: space-between; .course-name { font-weight: 500; } }
  .course-meta { font-size: 0.85rem; color: #909399; margin-top: 4px; }
}

.eval-alert { margin-bottom: 20px; }

.action-row { margin-top: 24px; }
.action-card {
  border: none; cursor: pointer; transition: all 0.3s; height: 100%;
  &:hover { transform: translateY(-4px); box-shadow: 0 8px 24px rgba(0,0,0,0.1); }
  .action-content { display: flex; align-items: center; padding: 12px; }
  .icon-wrapper {
    width: 56px; height: 56px; border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 16px; font-size: 24px;
    &.blue { background: #ecf5ff; color: #409EFF; }
    &.green { background: #f0f9eb; color: #67C23A; }
    &.orange { background: #fdf6ec; color: #E6A23C; }
  }
  .text-wrapper h3 { margin: 0 0 4px; font-size: 1rem; } .text-wrapper p { margin: 0; font-size: 0.85rem; color: #909399; }
}

.footer-tips { margin-top: 24px; color: #c0c4cc; font-size: 0.9rem; text-align: center; }
</style>
