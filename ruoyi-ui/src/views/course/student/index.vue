<template>
  <div class="app-container">
    <!-- 学生统计卡片 -->
    <el-row :gutter="16" class="stats-cards-row mb8">
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card stats-card-blue" shadow="hover">
          <div class="stats-content">
            <div class="stats-icon"><el-icon :size="32"><User /></el-icon></div>
            <div class="stats-info">
              <div class="stats-value">{{ (studentStats && studentStats.totalCount) ?? 0 }}</div>
              <div class="stats-label">学生总数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card stats-card-green" shadow="hover">
          <div class="stats-content">
            <div class="stats-icon"><el-icon :size="32"><School /></el-icon></div>
            <div class="stats-info">
              <div class="stats-value">{{ (studentStats && studentStats.gradeCount) ?? 0 }}</div>
              <div class="stats-label">年级数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card stats-card-orange" shadow="hover">
          <div class="stats-content">
            <div class="stats-icon"><el-icon :size="32"><OfficeBuilding /></el-icon></div>
            <div class="stats-info">
              <div class="stats-value">{{ (studentStats && studentStats.classCount) ?? 0 }}</div>
              <div class="stats-label">班级数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card stats-card-purple" shadow="hover">
          <div class="stats-content">
            <div class="stats-icon"><el-icon :size="32"><List /></el-icon></div>
            <div class="stats-info">
              <div class="stats-value">{{ (studentStats && studentStats.pageCount) ?? 0 }}</div>
              <div class="stats-label">当前页条数</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="学号" prop="studentNo">
        <el-input v-model="queryParams.studentNo" placeholder="请输入学号" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="姓名" prop="realName">
        <el-input v-model="queryParams.realName" placeholder="请输入姓名" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="年级" prop="gradeId">
        <el-select v-model="queryParams.gradeId" placeholder="请选择年级" clearable style="width: 200px" @change="onGradeChange">
          <el-option v-for="g in gradeList" :key="g.id" :label="g.gradeName" :value="g.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="班级" prop="classId">
        <el-select v-model="queryParams.classId" placeholder="请选择班级" clearable style="width: 200px">
          <el-option v-for="c in classList" :key="c.id" :label="c.className" :value="c.id" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="success" plain icon="Plus" @click="handleAdd" v-hasPermi="['course:student:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="info" plain icon="Upload" @click="handleImport" v-hasPermi="['course:student:import']">导入</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="info" plain icon="Download" @click="handleExport" v-hasPermi="['course:student:export']">导出</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Refresh" @click="handleResetAllPwd" v-hasPermi="['course:student:edit']">一键重置密码</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleBatchDelete" v-hasPermi="['course:student:remove']">批量删除</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="studentList" border stripe class="student-table" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="学号" align="center" prop="studentNo" min-width="140">
        <template #default="scope">
          <div class="student-no-cell">
            <el-icon><IdCard /></el-icon>
            <span>{{ scope.row.studentNo }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="姓名" align="center" prop="realName" min-width="120">
        <template #default="scope">
          <div class="student-name-cell">
            <el-avatar :size="24" :style="{ backgroundColor: getAvatarColor(scope.row.realName) }">{{ scope.row.realName.charAt(0) }}</el-avatar>
            <span>{{ scope.row.realName }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="年级" align="center" prop="gradeName" min-width="120">
        <template #default="scope">
          <el-tag effect="plain" type="info">{{ scope.row.gradeName }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="班级" align="center" prop="className" min-width="140">
        <template #default="scope">
           <el-tag effect="light">{{ scope.row.className }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" min-width="180">
        <template #default="scope">
          <div class="time-cell">
            <el-icon><Clock /></el-icon>
            <span>{{ parseTime(scope.row.createTime) }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width">
        <template #default="scope">
          <div class="action-buttons">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['course:student:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="重置密码" placement="top">
              <el-button link type="warning" icon="Key" @click="handleResetPwd(scope.row)" v-hasPermi="['course:student:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
              <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['course:student:remove']"></el-button>
            </el-tooltip>
          </div>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <!-- 添加或修改学生对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="studentRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="学号" prop="studentNo">
          <el-input v-model="form.studentNo" placeholder="请输入学号" :disabled="!!form.id" />
        </el-form-item>
        <el-form-item label="姓名" prop="realName">
          <el-input v-model="form.realName" placeholder="请输入姓名" />
        </el-form-item>
        <el-form-item label="年级" prop="gradeId">
          <el-select v-model="form.gradeId" placeholder="请选择年级" style="width: 100%" @change="onFormGradeChange">
            <el-option v-for="g in gradeList" :key="g.id" :label="g.gradeName" :value="g.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="班级" prop="classId">
          <el-select v-model="form.classId" placeholder="请选择班级" style="width: 100%">
            <el-option v-for="c in formClassList" :key="c.id" :label="c.className" :value="c.id" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 导入对话框 -->
    <el-dialog :title="upload.title" v-model="upload.open" width="400px" append-to-body>
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
            <span>仅允许导入xls、xlsx格式文件。</span>
            <el-link type="primary" :underline="false" style="font-size: 12px" @click="importTemplate">下载模板</el-link>
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

    <!-- 重置密码对话框 -->
    <el-dialog title="重置密码" v-model="resetPwdOpen" width="400px" append-to-body>
      <el-form ref="resetPwdRef" :model="resetPwdForm" :rules="resetPwdRules" label-width="80px">
        <el-form-item label="学号">
          <el-input v-model="resetPwdForm.studentNo" disabled />
        </el-form-item>
        <el-form-item label="新密码" prop="password">
          <el-input v-model="resetPwdForm.password" type="password" placeholder="留空则使用默认规则" show-password />
          <div class="el-form-item__tip" style="color: var(--el-text-color-secondary); font-size: 12px; margin-top: 4px">{{ defaultPasswordHint }}</div>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitResetPwd">确 定</el-button>
          <el-button @click="resetPwdOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Student">
import { User, School, OfficeBuilding, List } from '@element-plus/icons-vue'
import { getToken } from "@/utils/auth"
import { listStudent, getStudent, addStudent, updateStudent, delStudent, delStudents, resetStudentPwd, resetAllStudentPwd } from "@/api/course/student"
import { listGradeAll } from "@/api/course/grade"
import { listClassByGrade } from "@/api/course/class"
import { getConfigKey } from "@/api/system/config"

const { proxy } = getCurrentInstance()

const studentList = ref([])
const gradeList = ref([])
const classList = ref([])
const formClassList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const total = ref(0)
const title = ref("")
const resetPwdOpen = ref(false)
const studentStats = ref({
  totalCount: 0,
  gradeCount: 0,
  classCount: 0,
  pageCount: 0
})
/** 系统班级总数（未选年级时用；在年级列表加载后按年级汇总得到） */
const totalSystemClassCount = ref(0)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    studentNo: undefined,
    realName: undefined,
    gradeId: undefined,
    classId: undefined
  },
  rules: {
    studentNo: [{ required: true, message: "学号不能为空", trigger: "blur" }],
    realName: [{ required: true, message: "姓名不能为空", trigger: "blur" }],
    gradeId: [{ required: true, message: "请选择年级", trigger: "change" }],
    classId: [{ required: true, message: "请选择班级", trigger: "change" }]
  }
})

const upload = reactive({
  open: false,
  title: "学生导入",
  isUploading: false,
  headers: { Authorization: "Bearer " + getToken() },
  url: import.meta.env.VITE_APP_BASE_API + "/course/student/importData"
})

const resetPwdForm = ref({ studentNo: "", userId: null, password: "" })
const defaultPasswordHint = ref("留空则重置为学号后6位")
const resetPwdRules = {
  password: [{ validator: (rule, value, cb) => { if (!value) cb(); else if (value.length < 5 || value.length > 20) cb(new Error("密码长度必须介于 5 和 20 之间")); else cb(); }, trigger: "blur" }]
}

const { queryParams, form, rules } = toRefs(data)

function calculateStudentStats(list, totalCount) {
  const rows = Array.isArray(list) ? list : []
  const gradeId = queryParams.value.gradeId
  // 选中年级时：该年级下的班级数（classList）；未选年级时：系统班级总数（totalSystemClassCount）
  const classCount = gradeId
    ? (classList.value?.length ?? 0)
    : (totalSystemClassCount.value ?? 0)
  studentStats.value = {
    totalCount: totalCount != null && totalCount >= 0 ? totalCount : rows.length,
    gradeCount: gradeList.value?.length ?? 0,
    classCount,
    pageCount: rows.length
  }
}

/** 加载系统班级总数（按年级分别请求后汇总） */
function loadTotalClassCount() {
  const grades = gradeList.value || []
  if (grades.length === 0) {
    totalSystemClassCount.value = 0
    return Promise.resolve(0)
  }
  return Promise.all(grades.map(g => listClassByGrade(g.id)))
    .then(resList => resList.reduce((sum, res) => sum + (res.data?.length ?? 0), 0))
    .then(n => {
      totalSystemClassCount.value = n
      return n
    })
    .catch(() => { totalSystemClassCount.value = 0; return 0 })
}

function getList() {
  loading.value = true
  listStudent(queryParams.value).then(response => {
    studentList.value = response.rows
    total.value = response.total
    loading.value = false
    calculateStudentStats(response.rows, response.total)
  })
}

function getGradeList() {
  listGradeAll({}).then(res => {
    gradeList.value = res.data || []
    loadTotalClassCount().then(() => {
      calculateStudentStats(studentList.value, total.value)
    })
  })
}

function loadClassList(gradeId) {
  if (!gradeId) {
    classList.value = []
    return
  }
  listClassByGrade(gradeId).then(res => {
    classList.value = res.data || []
    calculateStudentStats(studentList.value, total.value)
  })
}

function onGradeChange(gradeId) {
  queryParams.value.classId = undefined
  loadClassList(gradeId)
}

function onFormGradeChange(gradeId) {
  form.value.classId = undefined
  if (!gradeId) {
    formClassList.value = []
    return
  }
  listClassByGrade(gradeId).then(res => {
    formClassList.value = res.data || []
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    id: undefined,
    studentNo: undefined,
    realName: undefined,
    gradeId: undefined,
    classId: undefined
  }
  formClassList.value = []
  proxy.resetForm("studentRef")
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  queryParams.value.gradeId = undefined
  queryParams.value.classId = undefined
  classList.value = []
  handleQuery()
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "添加学生"
}

function handleUpdate(row) {
  reset()
  getStudent(row.id).then(response => {
    form.value = response.data
    if (form.value.gradeId) {
      onFormGradeChange(form.value.gradeId)
    }
    open.value = true
    title.value = "修改学生"
  })
}

function submitForm() {
  proxy.$refs["studentRef"].validate(valid => {
    if (valid) {
      if (form.value.id != undefined) {
        updateStudent(form.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addStudent(form.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id)
  single.value = selection.length !== 1
  multiple.value = !selection.length
}

function handleBatchDelete() {
  const idList = ids.value
  proxy.$modal.confirm('是否确认删除选中的 ' + idList.length + ' 名学生？').then(() => {
    return delStudents(idList)
  }).then(res => {
    getList()
    proxy.$modal.msgSuccess(res.msg || "删除成功")
  }).catch(() => {})
}

function handleDelete(row) {
  proxy.$modal.confirm('是否确认删除学生"' + row.realName + "（" + row.studentNo + "）" + '"？').then(() => {
    return delStudent(row.id)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

function handleResetPwd(row) {
  resetPwdForm.value = { studentNo: row.studentNo, userId: row.userId, password: "" }
  getConfigKey("course.default_password").then(res => {
    const rule = (res.data || "").trim().toLowerCase()
    defaultPasswordHint.value = rule === "full" ? "留空则重置为学号" : rule === "last6" ? "留空则重置为学号后6位" : rule && rule.length >= 5 ? "留空则重置为系统配置的固定密码" : "留空则重置为学号后6位"
  }).catch(() => {
    defaultPasswordHint.value = "留空则重置为学号后6位"
  })
  resetPwdOpen.value = true
}

function submitResetPwd() {
  proxy.$refs["resetPwdRef"].validate(valid => {
    if (valid) {
      resetStudentPwd(resetPwdForm.value.userId, resetPwdForm.value.password).then(() => {
        proxy.$modal.msgSuccess("重置成功")
        resetPwdOpen.value = false
      })
    }
  })
}

function handleImport() {
  upload.title = "学生导入"
  upload.open = true
}

function importTemplate() {
  proxy.download("course/student/importTemplate", {}, `student_template_${new Date().getTime()}.xlsx`)
}

function handleFileUploadProgress(event, file, fileList) {
  upload.isUploading = true
}

function handleFileSuccess(response, file, fileList) {
  upload.open = false
  upload.isUploading = false
  proxy.$refs["uploadRef"].handleRemove(file)
  proxy.$modal.msgSuccess(response.msg)
  getList()
}

function submitFileForm() {
  proxy.$refs["uploadRef"].submit()
}

function getAvatarColor(name) {
  const colors = ['#409EFF', '#67C23A', '#E6A23C', '#F56C6C', '#909399', '#3B82F6', '#8B5CF6', '#EC4899']
  let hash = 0
  if (name) {
    for (let i = 0; i < name.length; i++) {
      hash = name.charCodeAt(i) + ((hash << 5) - hash)
    }
  }
  return colors[Math.abs(hash) % colors.length]
}

/** 重置所有学生密码 */
function handleResetAllPwd() {
  proxy.$modal.confirm('是否确认重置所有学生的登录密码为 123456？此操作不可逆！').then(function() {
    return resetAllStudentPwd();
  }).then(response => {
    proxy.$modal.msgSuccess(response.msg);
  }).catch(() => {});
}

function handleExport() {
  proxy.download("course/student/export", {
    ...queryParams.value
  }, `student_${new Date().getTime()}.xlsx`)
}

getGradeList()
getList()
</script>

<style scoped lang="scss">
// ── 查询区域卡片化 ────────────────────────────────────
:deep(.el-form.el-form--inline) {
  background: #fff;
  border: 1px solid #dde6ff;
  border-radius: 10px;
  padding: 16px 20px 6px;
  margin-bottom: 16px;
  box-shadow: 0 2px 10px rgba(59,91,219,0.06);
}

:deep(.mb8) {
  background: #f5f7ff;
  padding: 10px 16px;
  border-radius: 8px;
  border: 1px solid #eef1fc;
  margin-bottom: 14px;
  
  .el-button {
    height: 34px;
    padding: 0 16px;
    font-size: 13px;
    font-weight: 500;
  }
}

// ── 表格样式增强 ──────────────────────────────────────
.student-table {
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
  
  :deep(.el-table__body tr:hover > td.el-table__cell) {
    background-color: #e6f7ff !important;
    background-image: none !important;
  }
}

// ── 学号列样式 ────────────────────────────────────────
.student-no-cell {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  font-family: 'Courier New', monospace;
  font-weight: 600;
  color: #3B5BDB;
  font-size: 13px;
  
  .el-icon {
    font-size: 14px;
    color: #94A3B8;
  }
}

// ── 姓名列样式 ────────────────────────────────────────
.student-name-cell {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  font-size: 13px;
  
  .el-avatar {
    width: 20px !important;
    height: 20px !important;
    line-height: 20px !important;
    font-size: 11px;
    color: #fff;
  }
}

// ── 时间列样式 ────────────────────────────────────────
.time-cell {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  color: #64748B;
  font-size: 12px;
  
  .el-icon {
    font-size: 13px;
    color: #94A3B8;
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
  .el-button[type=warning][icon=Key]    { color: #F59E0B; }
  .el-button[type=danger][icon=Delete]  { color: #EF4444; }
}

// ── 导入提示文字 ──────────────────────────────────────
:deep(.el-upload__tip) {
  color: #748fd6;
  font-size: 12px;
  text-align: center;
  margin-top: 8px;
}

// ── 重置密码提示 ──────────────────────────────────────
.el-form-item__tip {
  padding: 6px 10px;
  background: #f0f4ff;
  border-radius: 6px;
  border-left: 3px solid #748fd6;
  color: #555e8a;
  font-size: 12px;
  line-height: 1.5;
  margin-top: 6px;
}

// ── 学生统计卡片（与课程管理统一尺寸） ─────────────────
.stats-cards-row {
  margin-bottom: 16px;
}
.stats-cards-row .el-col {
  display: flex;
}
.stats-card {
  border-radius: 12px;
  width: 100%;
  min-height: 120px;
  display: flex;
  flex-direction: column;
  :deep(.el-card__body) {
    padding: 16px;
    flex: 1;
    display: flex;
    align-items: stretch;
  }
}
.stats-content {
  display: flex;
  align-items: center;
  gap: 14px;
  width: 100%;
  min-height: 88px;
}
.stats-icon {
  width: 48px;
  height: 48px;
  min-width: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
}
.stats-info {
  flex: 1;
  min-width: 0;
  min-height: 48px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.stats-value {
  font-size: 24px;
  font-weight: 700;
  line-height: 1.3;
  color: #1e293b;
}
.stats-label {
  font-size: 13px;
  color: #64748b;
  margin-top: 4px;
}
.stats-card-blue .stats-icon { background: linear-gradient(135deg, #3b82f6, #2563eb); }
.stats-card-green .stats-icon { background: linear-gradient(135deg, #10b981, #059669); }
.stats-card-orange .stats-icon { background: linear-gradient(135deg, #f59e0b, #d97706); }
.stats-card-purple .stats-icon { background: linear-gradient(135deg, #8b5cf6, #7c3aed); }
</style>
