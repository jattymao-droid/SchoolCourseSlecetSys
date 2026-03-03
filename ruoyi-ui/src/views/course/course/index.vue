<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="学期" prop="semesterId">
        <el-select v-model="queryParams.semesterId" placeholder="请选择学期" clearable style="width: 200px">
          <el-option v-for="s in semesterList" :key="s.id" :label="s.semesterName" :value="s.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="年级" prop="gradeId">
        <el-select v-model="queryParams.gradeId" placeholder="请选择年级" clearable style="width: 200px">
          <el-option v-for="g in gradeList" :key="g.id" :label="g.gradeName" :value="g.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="课程名称" prop="courseName">
        <el-input v-model="queryParams.courseName" placeholder="请输入课程名称" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="星期" prop="weekDay">
        <el-select v-model="queryParams.weekDay" placeholder="请选择星期" clearable style="width: 120px">
          <el-option v-for="d in courseWeekDayOptions" :key="d.value" :label="d.label" :value="parseInt(d.value)" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 选课控制 -->
    <el-row :gutter="10" class="mb8 selection-control-row">
      <el-col :span="1.5">
        <el-tag v-if="!selectionStatus" type="info" size="large">请先设置当前学期</el-tag>
        <el-tag v-else-if="selectionStatus === 'not_started'" type="info" size="large">选课还未开始</el-tag>
        <el-tag v-else-if="selectionStatus === 'ended'" type="danger" size="large">选课已结束</el-tag>
        <el-tag v-else type="success" size="large" class="selection-ongoing-tag">选课进行中</el-tag>
      </el-col>
      <el-col :span="1.5">
        <el-button type="primary" icon="VideoPlay" @click="handleStartSelection" :disabled="!selectionStatus || selectionStatus === 'ongoing'">开始选课</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" icon="VideoPause" @click="handleEndSelection" :disabled="!selectionStatus || selectionStatus !== 'ongoing'">结束选课</el-button>
      </el-col>
    </el-row>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="success" plain icon="Plus" @click="handleAdd" v-hasPermi="['course:course:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="info" plain icon="Upload" @click="handleImport" v-hasPermi="['course:course:import']">导入</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['course:course:export']">导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="RefreshRight" @click="handleInitSelectionData" v-hasPermi="['course:course:edit']">初始化选课数据</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="primary" plain icon="CopyDocument" @click="handleBatchCopy" v-hasPermi="['course:course:add']">复制课程到新学期</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="courseList" border stripe class="course-table">
      <el-table-column label="课程名称" align="left" prop="courseName" min-width="160">
        <template #default="scope">
          <div class="course-name-cell">
            <div class="color-dot" :style="{ backgroundColor: getCourseColor(scope.row.id) }"></div>
            <span class="name-text">{{ scope.row.courseName }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="星期" align="center" prop="weekDay" width="100">
        <template #default="scope">
          <dict-tag :options="courseWeekDayOptions" :value="String(scope.row.weekDay)" />
        </template>
      </el-table-column>
      <el-table-column label="年级" align="center" prop="gradeName" width="100">
        <template #default="scope">
          <el-tag type="info" effect="plain">{{ scope.row.gradeName }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="教师" align="center" prop="teacherName" width="120" show-overflow-tooltip>
        <template #default="scope">
          <div class="icon-text-cell">
            <el-icon class="mr-1"><User /></el-icon>
            <span>{{ scope.row.teacherName || scope.row.teacher_name || '-' }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="上课地点" align="center" prop="location" width="140" show-overflow-tooltip>
        <template #default="scope">
          <div class="icon-text-cell">
            <el-icon class="mr-1"><Location /></el-icon>
            <span>{{ scope.row.location || '-' }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="学期" align="center" prop="semesterName" min-width="130">
        <template #default="scope">
           <el-tag type="warning" effect="plain" class="semester-tag">{{ scope.row.semesterName }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="描述" align="center" prop="description" min-width="150" show-overflow-tooltip />
      <el-table-column label="选课进度" align="center" width="180">
        <template #default="scope">
          <div class="progress-wrapper">
            <el-progress 
              :percentage="calculateProgress(scope.row)" 
              :color="getProgressColor(scope.row)"
              :stroke-width="10"
              :show-text="false"
            />
            <div class="progress-text">
              <span class="current">{{ scope.row.selectedCount || 0 }}</span>
              <span class="separator">/</span>
              <span class="total">{{ scope.row.totalQuota || 0 }}</span>
            </div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="280" class-name="small-padding fixed-width">
        <template #default="scope">
          <div class="action-buttons">
            <el-tooltip content="修改课程" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['course:course:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="复制到新学期" placement="top">
              <el-button link type="success" icon="CopyDocument" @click="handleCopy(scope.row)" v-hasPermi="['course:course:add']"></el-button>
            </el-tooltip>
            <el-tooltip content="查看选课学生" placement="top">
              <el-button link type="info" icon="User" @click="handleViewStudents(scope.row)" v-hasPermi="['course:course:query']"></el-button>
            </el-tooltip>
            <el-tooltip content="指定学生" placement="top">
              <el-button link type="warning" icon="Plus" @click="handleAssignStudents(scope.row)" v-hasPermi="['course:course:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除课程" placement="top">
              <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['course:course:remove']"></el-button>
            </el-tooltip>
          </div>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <!-- 添加或修改课程对话框 -->
    <el-dialog :title="title" v-model="open" width="680px" append-to-body>
      <el-form ref="courseRef" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="课程名称" prop="courseName">
              <el-input v-model="form.courseName" placeholder="请输入课程名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="星期" prop="weekDay">
              <el-select v-model="form.weekDay" placeholder="请选择星期" style="width: 100%">
                <el-option v-for="d in courseWeekDayOptions" :key="d.value" :label="d.label" :value="parseInt(d.value)" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="学期" prop="semesterId">
              <el-select v-model="form.semesterId" placeholder="请选择学期" style="width: 100%">
                <el-option v-for="s in semesterList" :key="s.id" :label="s.semesterName" :value="s.id" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="年级" prop="gradeId">
              <el-select v-model="form.gradeId" placeholder="请选择年级" style="width: 100%" @change="(id) => onFormGradeChange(id, true)">
                <el-option v-for="g in gradeList" :key="g.id" :label="g.gradeName" :value="g.id" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="教师" prop="teacherName">
              <el-input v-model="form.teacherName" placeholder="请输入教师姓名" clearable style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="上课地点" prop="location">
              <el-input v-model="form.location" placeholder="如：教学楼A101" clearable style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入课程描述" :rows="2" />
        </el-form-item>
        <el-form-item label="班级容量">
          <el-button type="success" link icon="Plus" @click="addQuotaRow">添加行</el-button>
          <el-table :data="form.quotaList" border style="margin-top: 8px">
            <el-table-column label="班级" min-width="200">
              <template #default="scope">
                <el-select v-model="scope.row.classId" placeholder="请选择班级" clearable style="width: 100%">
                  <el-option v-for="c in formClassList" :key="c.id" :label="c.className" :value="c.id" />
                </el-select>
              </template>
            </el-table-column>
            <el-table-column label="名额" width="120" align="center">
              <template #default="scope">
                <el-input-number v-model="scope.row.quota" :min="1" :max="999" controls-position="right" style="width: 100%" />
              </template>
            </el-table-column>
            <el-table-column label="操作" width="80" align="center">
              <template #default="scope">
                <el-button link type="danger" icon="Delete" @click="removeQuotaRow(scope.$index)" />
              </template>
            </el-table-column>
          </el-table>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 复制到新学期对话框（单门课程） -->
    <el-dialog title="复制到新学期" v-model="copyOpen" width="400px" append-to-body>
      <el-form label-width="100px">
        <el-form-item label="目标学期">
          <el-select v-model="copyTargetSemesterId" placeholder="请选择目标学期" style="width: 100%">
            <el-option v-for="s in semesterList" :key="s.id" :label="s.semesterName" :value="s.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitCopy">确 定</el-button>
          <el-button @click="copyOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 批量复制课程到新学期对话框 -->
    <el-dialog title="复制课程到新学期" v-model="batchCopyOpen" width="450px" append-to-body>
      <el-form label-width="100px">
        <el-form-item label="源学期">
          <el-tag type="info">{{ batchCopySourceSemesterName || '请先选择学期' }}</el-tag>
        </el-form-item>
        <el-form-item label="目标学期">
          <el-select v-model="batchCopyTargetSemesterId" placeholder="请选择目标学期" style="width: 100%">
            <el-option v-for="s in batchCopyTargetSemesterOptions" :key="s.id" :label="s.semesterName" :value="s.id" />
          </el-select>
        </el-form-item>
        <el-form-item v-if="batchCopyCourseCount >= 0" label="将复制">
          <span class="batch-copy-hint">共 <strong>{{ batchCopyCourseCount }}</strong> 门课程</span>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitBatchCopy" :loading="batchCopyLoading">确 定</el-button>
          <el-button @click="batchCopyOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 选课学生对话框 -->
    <el-dialog title="选课学生" v-model="studentsOpen" width="700px" append-to-body>
      <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
          <el-button type="info" plain icon="Download" @click="exportSelectedStudents" v-hasPermi="['course:course:export']">导出</el-button>
        </el-col>
      </el-row>
      <el-table v-loading="studentsLoading" :data="selectedStudents" max-height="400">
        <el-table-column label="学号" align="center" prop="studentNo" width="120" />
        <el-table-column label="姓名" align="center" prop="realName" width="100" />
        <el-table-column label="班级" align="center" prop="className" min-width="120" />
        <el-table-column label="选课时间" align="center" prop="createTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.createTime) }}</span>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!studentsLoading && selectedStudents.length === 0" description="暂无选课学生" />
    </el-dialog>

    <!-- 指定学生对话框 -->
    <el-dialog title="指定学生" v-model="assignState.open" width="720px" append-to-body>
      <div v-if="assignState.course" style="margin-bottom: 12px; color: #606266">
        <span>课程：<strong>{{ assignState.course.courseName }}</strong></span>
        <el-tag type="info" size="small" class="ml-2">{{ assignState.course.gradeName || assignState.course.grade_name || '未设置年级' }}</el-tag>
      </div>
      <el-form :inline="true" style="margin-bottom: 12px">
        <el-form-item label="按班级筛选">
          <el-select v-model="assignState.classFilter" placeholder="全部班级（按班级遍历）" clearable style="width: 220px">
            <el-option v-for="c in assignState.classList" :key="c.id" :label="c.className || c.class_name" :value="c.id" />
          </el-select>
        </el-form-item>
        <el-form-item v-if="assignState.classList.length > 0">
          <span class="assign-hint">共 {{ assignState.classList.length }} 个班级</span>
        </el-form-item>
      </el-form>
      <el-table v-loading="assignState.loading" :data="assignStateFilteredStudents" max-height="340" @selection-change="handleAssignSelectionChange">
        <el-table-column type="selection" width="55" :selectable="() => true" />
        <el-table-column label="学号" align="center" width="120">
          <template #default="scope">{{ scope.row.studentNo ?? scope.row.student_no }}</template>
        </el-table-column>
        <el-table-column label="姓名" align="center" width="100">
          <template #default="scope">{{ scope.row.realName ?? scope.row.real_name }}</template>
        </el-table-column>
        <el-table-column label="班级" align="center" min-width="120">
          <template #default="scope">{{ scope.row.className ?? scope.row.class_name ?? '-' }}</template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!assignState.loading && assignStateFilteredStudents.length === 0" description="该年级暂无可选学生，或已全部指定。请确认课程适用年级下是否有班级和学生。" />
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitAssign" :disabled="assignState.selectedIds.length === 0">确 定</el-button>
          <el-button @click="assignState.open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 导入课程对话框 -->
    <el-dialog title="导入课程" v-model="upload.open" width="400px" append-to-body>
      <el-upload
        ref="uploadRef"
        :limit="1"
        accept=".xlsx, .xls"
        :headers="upload.headers"
        :action="upload.url"
        :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress"
        :on-success="handleFileSuccess"
        :auto-upload="false"
        drag
      >
        <el-icon class="el-icon--upload"><upload-filled /></el-icon>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <template #tip>
          <div class="el-upload__tip text-center">
            <div class="el-upload__tip">
              <el-checkbox v-model="upload.updateSupport" />是否更新已经存在的课程数据
            </div>
            <span>仅允许导入xls、xlsx格式文件。</span>
            <el-link type="primary" style="font-size:12px" @click="importTemplate">下载模板</el-link>
          </div>
        </template>
      </el-upload>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitFileForm">确 定</el-button>
          <el-button @click="upload.open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Course">
import { listCourse, getCourse, addCourse, updateCourse, delCourse, copyToNewSemester, listSelectedStudents, assignStudents, initSelectionData } from "@/api/course/course"
import { listSemesterAll, getCurrentSemester, startSelection, endSelection } from "@/api/course/semester"
import { listGradeAll } from "@/api/course/grade"
import { listClassByGrade } from "@/api/course/class"
import { listStudent } from "@/api/course/student"
import { getToken } from "@/utils/auth"

const { proxy } = getCurrentInstance()

const courseList = ref([])
const semesterList = ref([])
const gradeList = ref([])
const formClassList = ref([])
const selectedStudents = ref([])
const open = ref(false)
const copyOpen = ref(false)
const studentsOpen = ref(false)
const loading = ref(true)
const studentsLoading = ref(false)
const showSearch = ref(true)
const total = ref(0)
const title = ref("")
const copyTargetSemesterId = ref(undefined)
const copySourceCourseId = ref(undefined)
const viewStudentsCourseId = ref(undefined)
const batchCopyOpen = ref(false)
const batchCopyTargetSemesterId = ref(undefined)
const batchCopyLoading = ref(false)
const batchCopyCourseCount = ref(-1)
const uploadRef = ref()
const assignState = reactive({
  open: false,
  course: null,
  students: [],
  classList: [],
  classFilter: undefined,
  selectedIds: [],
  loading: false
})

// 导入参数
const upload = reactive({
  open: false,
  title: "",
  isUploading: false,
  updateSupport: 0,
  headers: { Authorization: "Bearer " + getToken() },
  url: import.meta.env.VITE_APP_BASE_API + "/course/course/importData"
})

/** 指定学生：按班级筛选并排序（班级遍历） */
const assignStateFilteredStudents = computed(() => {
  const list = assignState.students || []
  let filtered = assignState.classFilter
    ? list.filter(s => (s.classId ?? s.class_id) == assignState.classFilter)
    : list
  const classOrder = (assignState.classList || []).map(c => c.id)
  return filtered.slice().sort((a, b) => {
    const aid = a.classId ?? a.class_id
    const bid = b.classId ?? b.class_id
    const ai = classOrder.indexOf(aid)
    const bi = classOrder.indexOf(bid)
    if (ai >= 0 && bi >= 0) return ai - bi
    if (ai >= 0) return -1
    if (bi >= 0) return 1
    return (a.className ?? a.class_name ?? '').localeCompare(b.className ?? b.class_name ?? '')
  })
})

/** 批量复制：源学期名称 */
const batchCopySourceSemesterName = computed(() => {
  const sid = queryParams.value.semesterId || currentSemesterData.value?.id
  if (!sid) return ''
  return semesterList.value.find(s => s.id === sid)?.semesterName || currentSemesterData.value?.semesterName || ''
})

/** 批量复制：目标学期选项（排除源学期） */
const batchCopyTargetSemesterOptions = computed(() => {
  const sid = queryParams.value.semesterId || currentSemesterData.value?.id
  return (semesterList.value || []).filter(s => s.id !== sid)
})

// 选课状态：not_started | ongoing | ended
const currentSemesterData = ref(null)
const selectionStatus = computed(() => {
  const sem = currentSemesterData.value
  if (!sem) return null
  const start = sem.selectionStartTime ?? sem.selection_start_time
  const end = sem.selectionEndTime ?? sem.selection_end_time
  if (!start || !end) return 'not_started'
  const now = new Date()
  const startDate = start ? new Date(start) : null
  const endDate = end ? new Date(end) : null
  if (!startDate || !endDate) return 'not_started'
  if (now > endDate) return 'ended'
  if (now >= startDate && now <= endDate) return 'ongoing'
  return 'not_started'
})

const { course_week_day } = proxy.useDict("course_week_day")
const courseWeekDayOptions = computed(() => course_week_day.value || [])

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    semesterId: undefined,
    gradeId: undefined,
    courseName: undefined,
    weekDay: undefined,
    location: undefined
  },
  rules: {
    courseName: [{ required: true, message: "课程名称不能为空", trigger: "blur" }],
    weekDay: [{ required: true, message: "请选择星期", trigger: "change" }],
    gradeId: [{ required: true, message: "请选择年级", trigger: "change" }],
    semesterId: [{ required: true, message: "请选择学期", trigger: "change" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listCourse(queryParams.value).then(response => {
    const rows = response.rows || []
    if (rows.length > 0 && import.meta.env.DEV) {
      console.log('[课程列表] 首条数据 keys:', Object.keys(rows[0]), '| location:', rows[0].location)
    }
    courseList.value = rows.map(r => ({ 
      ...r, 
      location: r.location ?? '',
      selectedCount: r.selectedCount ?? 0,
      totalQuota: r.totalQuota ?? 0
    }))
    total.value = response.total
    loading.value = false
  })
}

// 计算选课进度百分比
function calculateProgress(row) {
  const total = row.totalQuota || 0
  const selected = row.selectedCount || 0
  if (total === 0) return 0
  return Math.min(Math.round((selected / total) * 100), 100)
}

// 根据选课情况返回进度条颜色
function getProgressColor(row) {
  const percentage = calculateProgress(row)
  if (percentage >= 90) return '#EF4444' // 红色 - 接近满员
  if (percentage >= 70) return '#F59E0B' // 橙色 - 较多人选
  if (percentage >= 40) return '#10B981' // 绿色 - 正常
  return '#3B82F6' // 蓝色 - 人数较少
}

// 获取课程颜色标记
function getCourseColor(id) {
  const colors = ['#409EFF', '#67C23A', '#E6A23C', '#F56C6C', '#909399', '#3B82F6', '#8B5CF6', '#EC4899']
  return colors[(id || 0) % colors.length]
}

// 获取星期标签类型
function getWeekDayTagType(weekDay) {
  const types = ['', 'success', 'warning', 'danger', 'info', '']
  return types[weekDay % types.length] || ''
}

function fetchCurrentSemester() {
  getCurrentSemester().then(res => {
    currentSemesterData.value = (res && res.data) || res || null
  }).catch(() => {
    currentSemesterData.value = null
  })
}

function handleStartSelection() {
  startSelection().then(() => {
    proxy.$modal.msgSuccess("已开始选课")
    fetchCurrentSemester()
  }).catch(err => {
    proxy.$modal.msgError(err?.response?.data?.msg || err?.message || "操作失败")
  })
}

function handleEndSelection() {
  proxy.$modal.confirm("确认结束选课？结束后学生将无法继续选课。").then(() => {
    return endSelection()
  }).then(() => {
    proxy.$modal.msgSuccess("已结束选课")
    fetchCurrentSemester()
  }).catch(() => {})
}

/** 初始化选课数据：双重确认 */
function handleInitSelectionData() {
  const semesterId = queryParams.value.semesterId || currentSemesterData.value?.id
  if (!semesterId) {
    proxy.$modal.msgWarning("请先选择学期")
    return
  }
  const semesterName = semesterList.value.find(s => s.id === semesterId)?.semesterName || currentSemesterData.value?.semesterName || '当前学期'
  proxy.$modal.confirm(
    `确认要初始化「${semesterName}」的选课数据吗？此操作将清空该学期的所有选课记录并重置班级容量，且不可恢复。`
  ).then(() => {
    return proxy.$modal.confirm('请再次确认：此操作将永久删除所有选课数据，确定要继续吗？')
  }).then(() => {
    return initSelectionData(semesterId)
  }).then((res) => {
    proxy.$modal.msgSuccess(res?.msg || '初始化成功')
    getList()
    fetchCurrentSemester()
  }).catch(() => {})
}

function getSemesterList() {
  listSemesterAll({}).then(res => {
    semesterList.value = res.data || []
    // 如果没有选择学期，默认选中当前学期
    if (!queryParams.value.semesterId) {
      const current = semesterList.value.find(s => s.isCurrent === 1)
      if (current) {
        queryParams.value.semesterId = current.id
        handleQuery() // 重新查询
      }
    }
  })
}

function getGradeList() {
  listGradeAll({}).then(res => {
    gradeList.value = res.data || []
  })
}

function onFormGradeChange(gradeId, clearQuotaClass = false) {
  if (clearQuotaClass && form.value.quotaList) {
    form.value.quotaList.forEach(q => { q.classId = undefined })
  }
  if (!gradeId) {
    formClassList.value = []
    return Promise.resolve()
  }
  return listClassByGrade(gradeId).then(res => {
    formClassList.value = res.data || []
  })
}

function addQuotaRow() {
  if (!form.value.quotaList) form.value.quotaList = []
  form.value.quotaList.push({ classId: undefined, quota: 10 })
}

function removeQuotaRow(index) {
  form.value.quotaList.splice(index, 1)
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    id: undefined,
    courseName: undefined,
    weekDay: undefined,
    gradeId: undefined,
    teacherName: undefined,
    location: undefined,
    description: undefined,
    semesterId: undefined,
    quotaList: []
  }
  formClassList.value = []
  proxy.resetForm("courseRef")
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "添加课程"
}

function handleUpdate(row) {
  reset()
  getCourse(row.id).then(async response => {
    const course = response.data
    form.value = { ...course, quotaList: course.quotaList || [] }
    if (form.value.gradeId) {
      await onFormGradeChange(form.value.gradeId)
    }
    open.value = true
    title.value = "修改课程"
  })
}

function submitForm() {
  proxy.$refs["courseRef"].validate(valid => {
    if (valid) {
      const quotaList = (form.value.quotaList || []).filter(q => q.classId && q.quota > 0)
      const submitData = {
        ...form.value,
        quotaList,
        teacherName: (form.value.teacherName && form.value.teacherName.trim()) || null,
        teacherId: null,
        location: (form.value.location && form.value.location.trim()) || null
      }
      if (form.value.id != undefined) {
        updateCourse(submitData).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addCourse(submitData).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleDelete(row) {
  proxy.$modal.confirm('是否确认删除课程"' + row.courseName + '"？').then(() => {
    return delCourse(row.id)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

function handleCopy(row) {
  copySourceCourseId.value = row.id
  copyTargetSemesterId.value = undefined
  copyOpen.value = true
}

function submitCopy() {
  if (!copyTargetSemesterId.value) {
    proxy.$modal.msgWarning("请选择目标学期")
    return
  }
  copyToNewSemester(copySourceCourseId.value, copyTargetSemesterId.value).then(() => {
    proxy.$modal.msgSuccess("复制成功")
    copyOpen.value = false
    getList()
  })
}

function handleBatchCopy() {
  const sourceId = queryParams.value.semesterId || currentSemesterData.value?.id
  if (!sourceId) {
    proxy.$modal.msgWarning("请先在查询条件中选择学期")
    return
  }
  batchCopyOpen.value = true
  batchCopyTargetSemesterId.value = undefined
  batchCopyCourseCount.value = -1
  listCourse({ semesterId: sourceId, pageNum: 1, pageSize: 5000 }).then(res => {
    const rows = res.rows || []
    batchCopyCourseCount.value = rows.length
    if (rows.length === 0) {
      proxy.$modal.msgWarning("该学期暂无课程")
    }
  })
}

function submitBatchCopy() {
  const sourceId = queryParams.value.semesterId || currentSemesterData.value?.id
  if (!sourceId) {
    proxy.$modal.msgWarning("请先在查询条件中选择学期")
    return
  }
  if (!batchCopyTargetSemesterId.value) {
    proxy.$modal.msgWarning("请选择目标学期")
    return
  }
  if (sourceId === batchCopyTargetSemesterId.value) {
    proxy.$modal.msgWarning("源学期与目标学期不能相同")
    return
  }
  batchCopyLoading.value = true
  listCourse({ semesterId: sourceId, pageNum: 1, pageSize: 5000 }).then(res => {
    const courses = res.rows || []
    if (courses.length === 0) {
      proxy.$modal.msgWarning("该学期暂无课程")
      batchCopyLoading.value = false
      return
    }
    const targetId = batchCopyTargetSemesterId.value
    const promises = courses.map(c => copyToNewSemester(c.id, targetId))
    return Promise.all(promises).then(() => courses.length)
  }).then((count) => {
    if (count != null) {
      proxy.$modal.msgSuccess(`已成功复制 ${count} 门课程到新学期`)
    }
    batchCopyOpen.value = false
    batchCopyLoading.value = false
    getList()
  }).catch(err => {
    proxy.$modal.msgError(err?.response?.data?.msg || err?.message || "复制失败")
    batchCopyLoading.value = false
  })
}

function handleViewStudents(row) {
  viewStudentsCourseId.value = row.id
  selectedStudents.value = []
  studentsOpen.value = true
  studentsLoading.value = true
  listSelectedStudents(row.id).then(res => {
    selectedStudents.value = res.rows || []
    studentsLoading.value = false
  })
}

function exportSelectedStudents() {
  if (!viewStudentsCourseId.value) return
  proxy.download("course/course/" + viewStudentsCourseId.value + "/exportSelectedStudents", {}, `选课学生_${new Date().getTime()}.xlsx`)
}

function handleAssignStudents(row) {
  const gradeId = row.gradeId ?? row.grade_id
  if (!gradeId) {
    proxy.$modal.msgWarning("该课程未设置适用年级，无法指定学生")
    return
  }
  assignState.course = row
  assignState.students = []
  assignState.classList = []
  assignState.classFilter = undefined
  assignState.selectedIds = []
  assignState.open = true
  assignState.loading = true
  Promise.all([
    listStudent({ gradeId, pageNum: 1, pageSize: 2000 }),
    listSelectedStudents(row.id),
    listClassByGrade(gradeId)
  ]).then(([studentRes, selectedRes, classRes]) => {
    const all = studentRes.rows || studentRes.data || []
    const selectedUserIds = new Set((selectedRes.rows || selectedRes.data || []).map(s => s.userId ?? s.user_id).filter(Boolean))
    assignState.students = all.filter(s => !selectedUserIds.has(s.userId ?? s.user_id))
    assignState.classList = classRes.data ?? classRes.rows ?? []
    assignState.loading = false
  }).catch(() => {
    assignState.loading = false
  })
}

function handleAssignSelectionChange(selection) {
  assignState.selectedIds = selection.map(s => s.userId ?? s.user_id).filter(Boolean)
}

function submitAssign() {
  if (!assignState.course || assignState.selectedIds.length === 0) return
  const ids = assignState.selectedIds.map(id => Number(id)).filter(n => !isNaN(n))
  assignStudents(assignState.course.id, ids).then(() => {
    proxy.$modal.msgSuccess("指定成功")
    assignState.open = false
    getList()
  }).catch(err => {
    const msg = err?.response?.data?.msg || err?.message || "指定失败"
    proxy.$modal.msgError(msg)
  })
}

// 导入模板下载
function importTemplate() {
  proxy.download("course/course/importTemplate", {}, `课程导入模板_${new Date().getTime()}.xlsx`)
}

// 打开导入对话框
function handleImport() {
  upload.title = "课程导入"
  upload.open = true
}

// 文件上传中处理
function handleFileUploadProgress() {
  upload.isUploading = true
}

// 文件上传成功处理
function handleFileSuccess(response, file) {
  upload.open = false
  upload.isUploading = false
  uploadRef.value.clearFiles()
  proxy.$alert("<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" + response.msg + "</div>", "导入结果", { dangerouslyUseHTMLString: true })
  getList()
}

// 提交上传文件
function submitFileForm() {
  uploadRef.value.submit()
}

// 导出课程
function handleExport() {
  proxy.download("course/course/export", {
    ...queryParams.value
  }, `课程数据_${new Date().getTime()}.xlsx`)
}

getSemesterList()
getGradeList()
getList()
fetchCurrentSemester()
</script>

<style scoped lang="scss">
// ── 页面容器 ──────────────────────────────────────────
:deep(.app-container) {
  background-color: #f0f4ff;
}

// ── 查询表单卡片化 ────────────────────────────────────
:deep(.el-form.el-form--inline) {
  background: #fff;
  border: 1px solid #dde6ff;
  border-radius: 10px;
  padding: 16px 20px 6px;
  margin-bottom: 16px;
  box-shadow: 0 2px 10px rgba(59,91,219,0.06);
}

// ── 选课控制行 ─────────────────────────────────────────
.selection-control-row {
  background: linear-gradient(135deg, #e0e7ff 0%, #c7d2fe 100%);
  padding: 12px 16px;
  border-radius: 8px;
  border: 1px solid #a5b4fc;
  margin-bottom: 14px;
}

// 选课进行中：呼吸效果
.selection-ongoing-tag {
  animation: breathe 2s ease-in-out infinite;
}
@keyframes breathe {
  0%, 100% { opacity: 1; box-shadow: 0 0 0 0 rgba(103, 194, 58, 0.4); }
  50% { opacity: 0.85; box-shadow: 0 0 12px 4px rgba(103, 194, 58, 0.25); }
}

// ── 操作行 ────────────────────────────────────────────
:deep(.mb8) {
  margin-bottom: 14px;
  background: #f5f7ff;
  padding: 10px 16px;
  border-radius: 8px;
  border: 1px solid #eef1fc;
  
  .el-button {
    height: 34px;
    padding: 0 16px;
    font-size: 13px;
    font-weight: 500;
  }
}

// ── 批量复制提示 ──────────────────────────────────────
.batch-copy-hint {
  color: #606266;
  strong { color: #409EFF; }
}

.assign-hint {
  font-size: 12px;
  color: #909399;
}

// ── 表格样式美化 ──────────────────────────────────────
.course-table {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);

  :deep(th.el-table__cell) {
    background-color: #F8FAFC;
    color: #475569;
    font-weight: 600;
    height: 32px;
    padding: 0;
  }

  :deep(td.el-table__cell) {
    padding: 0;
  }

  // 鼠标悬停行样式优化 - 纯色背景
  :deep(.el-table__body tr:hover > td.el-table__cell) {
    background-color: #e6f7ff !important;
    background-image: none !important;
  }
}

// ── 课程名称列：加色点装饰 ────────────────────────────
.course-name-cell {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 0;

  .color-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    flex-shrink: 0;
    box-shadow: 0 0 4px rgba(0,0,0,0.2);
  }

  .name-text {
    font-weight: 500;
    color: #334155;
    font-size: 13px;
  }
}

// ── 图标文本列 ────────────────────────────────────────
.icon-text-cell {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  color: #64748B;
  
  .el-icon {
    font-size: 13px;
    color: #94A3B8;
  }
  
  span {
    font-size: 13px;
  }
}

// ── 操作按钮组 ────────────────────────────────────────
.action-buttons {
  display: flex;
  justify-content: center;
  gap: 4px;
  
  .el-button {
    padding: 4px;
    height: 24px;
    width: 24px;
    border-radius: 4px;
    font-size: 12px;
    
    &:hover {
      background-color: #F1F5F9;
    }
  }
}

// ── 操作按钮颜色加强（保留原定义，微调） ────────────────
:deep(.el-table) {
  .el-button[type=primary][icon=Edit]    { color: #3B82F6; }
  .el-button[type=success][icon=CopyDocument] { color: #10B981; }
  .el-button[type=info][icon=User]    { color: #8B5CF6; }
  .el-button[type=warning][icon=Plus]    { color: #F59E0B; }
  .el-button[type=danger][icon=Delete]  { color: #EF4444; }
}

// ── 对话框表单分区 ────────────────────────────────────
:deep(.el-dialog .el-form) {
  .el-row + .el-row {
    margin-top: 0;
  }
}

// ── 选课进度样式 ──────────────────────────────────────
.progress-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2px;
  padding: 0;
  
  :deep(.el-progress) {
    width: 100%;
    
    .el-progress-bar__outer {
      background-color: #E0E7FF;
      border-radius: 4px;
      height: 4px !important;
    }
    
    .el-progress-bar__inner {
      border-radius: 4px;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }
  }
  
  .progress-text {
    display: flex;
    align-items: baseline;
    gap: 2px;
    font-size: 12px;
    font-weight: 600;
    color: #475569;
    
    .current {
      color: #4F46E5;
      font-size: 13px;
      font-weight: 700;
    }
    
    .separator {
      color: #94A3B8;
      margin: 0 1px;
    }
    
    .total {
      color: #64748B;
      font-size: 12px;
    }
  }
}
</style>
