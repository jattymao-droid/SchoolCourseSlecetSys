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

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['course:course:add']">新增</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="courseList">
      <el-table-column label="课程名称" align="center" prop="courseName" min-width="120" />
      <el-table-column label="星期" align="center" prop="weekDay" width="80">
        <template #default="scope">
          <dict-tag :options="courseWeekDayOptions" :value="String(scope.row.weekDay)" />
        </template>
      </el-table-column>
      <el-table-column label="年级" align="center" prop="gradeName" width="100" />
      <el-table-column label="教师" align="center" prop="teacherName" width="100" show-overflow-tooltip>
        <template #default="scope">
          {{ scope.row.teacherName || scope.row.teacher_name || '' }}
        </template>
      </el-table-column>
      <el-table-column label="上课地点" align="center" prop="location" width="120" show-overflow-tooltip>
        <template #default="scope">
          {{ scope.row.location || '' }}
        </template>
      </el-table-column>
      <el-table-column label="学期" align="center" prop="semesterName" width="120" />
      <el-table-column label="描述" align="center" prop="description" min-width="120" show-overflow-tooltip />
      <el-table-column label="操作" align="center" width="340" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['course:course:edit']">修改</el-button>
          <el-button link type="primary" icon="CopyDocument" @click="handleCopy(scope.row)" v-hasPermi="['course:course:add']">复制</el-button>
          <el-button link type="primary" icon="User" @click="handleViewStudents(scope.row)" v-hasPermi="['course:course:query']">选课学生</el-button>
          <el-button link type="primary" icon="Plus" @click="handleAssignStudents(scope.row)" v-hasPermi="['course:course:edit']">指定学生</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['course:course:remove']">删除</el-button>
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
          <el-button type="primary" link icon="Plus" @click="addQuotaRow">添加行</el-button>
          <el-table :data="form.quotaList" border style="margin-top: 8px">
            <el-table-column label="班级" width="200">
              <template #default="scope">
                <el-select v-model="scope.row.classId" placeholder="请选择班级" clearable style="width: 100%">
                  <el-option v-for="c in formClassList" :key="c.id" :label="c.className" :value="c.id" />
                </el-select>
              </template>
            </el-table-column>
            <el-table-column label="名额" width="120">
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

    <!-- 复制到新学期对话框 -->
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

    <!-- 选课学生对话框 -->
    <el-dialog title="选课学生" v-model="studentsOpen" width="700px" append-to-body>
      <el-row :gutter="10" class="mb8">
        <el-col :span="1.5">
          <el-button type="warning" plain icon="Download" @click="exportSelectedStudents" v-hasPermi="['course:course:export']">导出</el-button>
        </el-col>
      </el-row>
      <el-table v-loading="studentsLoading" :data="selectedStudents" max-height="400">
        <el-table-column label="学号" align="center" prop="studentNo" width="120" />
        <el-table-column label="姓名" align="center" prop="realName" width="100" />
        <el-table-column label="班级" align="center" prop="className" width="120" />
        <el-table-column label="选课时间" align="center" prop="createTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.createTime) }}</span>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!studentsLoading && selectedStudents.length === 0" description="暂无选课学生" />
    </el-dialog>

    <!-- 指定学生对话框 -->
    <el-dialog title="指定学生" v-model="assignState.open" width="700px" append-to-body>
      <div v-if="assignState.course" style="margin-bottom: 8px; color: #606266">
        课程：{{ assignState.course.courseName }}（{{ assignState.course.gradeName }}）
      </div>
      <el-form :inline="true" style="margin-bottom: 12px">
        <el-form-item label="按班级筛选">
          <el-select v-model="assignState.classFilter" placeholder="全部班级" clearable style="width: 180px">
            <el-option v-for="c in assignState.classList" :key="c.id" :label="c.className" :value="c.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <el-table v-loading="assignState.loading" :data="assignStateFilteredStudents" max-height="320" @selection-change="handleAssignSelectionChange">
        <el-table-column type="selection" width="55" :selectable="() => true" />
        <el-table-column label="学号" align="center" prop="studentNo" width="120" />
        <el-table-column label="姓名" align="center" prop="realName" width="100" />
        <el-table-column label="班级" align="center" prop="className" width="120" />
      </el-table>
      <el-empty v-if="!assignState.loading && assignStateFilteredStudents.length === 0" description="该年级暂无可选学生，或已全部指定" />
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitAssign" :disabled="assignState.selectedIds.length === 0">确 定</el-button>
          <el-button @click="assignState.open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Course">
import { listCourse, getCourse, addCourse, updateCourse, delCourse, copyToNewSemester, listSelectedStudents, assignStudents } from "@/api/course/course"
import { listSemesterAll } from "@/api/course/semester"
import { listGradeAll } from "@/api/course/grade"
import { listClassByGrade } from "@/api/course/class"
import { listStudent } from "@/api/course/student"

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
const assignState = reactive({
  open: false,
  course: null,
  students: [],
  classList: [],
  classFilter: undefined,
  selectedIds: [],
  loading: false
})

const assignStateFilteredStudents = computed(() => {
  const list = assignState.students || []
  if (!assignState.classFilter) return list
  return list.filter(s => s.classId === assignState.classFilter)
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
    courseList.value = rows.map(r => ({ ...r, location: r.location ?? '' }))
    total.value = response.total
    loading.value = false
  })
}

function getSemesterList() {
  listSemesterAll({}).then(res => {
    semesterList.value = res.data || []
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
  assignState.course = row
  assignState.students = []
  assignState.classList = []
  assignState.classFilter = undefined
  assignState.selectedIds = []
  assignState.open = true
  assignState.loading = true
  Promise.all([
    listStudent({ gradeId: row.gradeId, pageNum: 1, pageSize: 500 }),
    listSelectedStudents(row.id),
    listClassByGrade(row.gradeId)
  ]).then(([studentRes, selectedRes, classRes]) => {
    const all = studentRes.rows || []
    const selectedUserIds = new Set((selectedRes.rows || []).map(s => s.userId).filter(Boolean))
    assignState.students = all.filter(s => !selectedUserIds.has(s.userId))
    assignState.classList = classRes.data || []
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
  }).catch(err => {
    const msg = err?.response?.data?.msg || err?.message || "指定失败"
    proxy.$modal.msgError(msg)
  })
}

getSemesterList()
getGradeList()
getList()
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

// ── 操作行 ────────────────────────────────────────────
:deep(.mb8) {
  margin-bottom: 14px;
  background: #f5f7ff;
  padding: 10px 16px;
  border-radius: 8px;
  border: 1px solid #eef1fc;
}

// ── 课程名称列：加色点装饰 ────────────────────────────
.course-name-cell {
  display: flex;
  align-items: center;
  gap: 8px;

  .color-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    flex-shrink: 0;
  }
}

// ── 操作按钮颜色加强 ──────────────────────────────────
:deep(.el-table) {
  .el-button[type=primary][icon=Edit]    { color: #3B5BDB; }
  .el-button[type=primary][icon=CopyDocument] { color: #0ca678; }
  .el-button[type=primary][icon=User]    { color: #7950f2; }
  .el-button[type=primary][icon=Plus]    { color: #1971c2; }
  .el-button[type=primary][icon=Delete]  { color: #e03131; }
}

// ── 对话框表单分区 ────────────────────────────────────
:deep(.el-dialog .el-form) {
  .el-row + .el-row {
    margin-top: 0;
  }
}
</style>
