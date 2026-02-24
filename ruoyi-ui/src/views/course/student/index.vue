<template>
  <div class="app-container">
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
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['course:student:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="info" plain icon="Upload" @click="handleImport" v-hasPermi="['course:student:import']">导入</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['course:student:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="studentList">
      <el-table-column label="学号" align="center" prop="studentNo" width="120" />
      <el-table-column label="姓名" align="center" prop="realName" width="100" />
      <el-table-column label="年级" align="center" prop="gradeName" width="100" />
      <el-table-column label="班级" align="center" prop="className" width="100" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="200" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['course:student:edit']">修改</el-button>
          <el-button link type="primary" icon="Key" @click="handleResetPwd(scope.row)" v-hasPermi="['course:student:edit']">重置密码</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['course:student:remove']">删除</el-button>
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
import { getToken } from "@/utils/auth"
import { listStudent, getStudent, addStudent, updateStudent, delStudent, resetStudentPwd } from "@/api/course/student"
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

function getList() {
  loading.value = true
  listStudent(queryParams.value).then(response => {
    studentList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function getGradeList() {
  listGradeAll({}).then(res => {
    gradeList.value = res.data || []
  })
}

function loadClassList(gradeId) {
  if (!gradeId) {
    classList.value = []
    return
  }
  listClassByGrade(gradeId).then(res => {
    classList.value = res.data || []
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
}

// ── 表格样式增强 ──────────────────────────────────────
:deep(.el-table) {
  // 学号列 - tag 效果由模板控制，此处美化辅助
  td:first-child .cell {
    font-family: 'Courier New', monospace;
    font-weight: 600;
    color: #3B5BDB;
  }

  // 操作按钮色彩
  .el-button[icon=Edit]   { color: #3B5BDB !important; }
  .el-button[icon=Key]    { color: #7950f2 !important; }
  .el-button[icon=Delete] { color: #e03131 !important; }
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
</style>
