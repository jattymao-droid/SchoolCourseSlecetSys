<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="学期名称" prop="semesterName">
        <el-input
          v-model="queryParams.semesterName"
          placeholder="请输入学期名称"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="是否当前" prop="isCurrent">
        <el-select v-model="queryParams.isCurrent" placeholder="请选择" clearable style="width: 200px">
          <el-option label="是" :value="1" />
          <el-option label="否" :value="0" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['course:semester:add']"
        >新增</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="semesterList">
      <el-table-column label="学期名称" align="center" prop="semesterName" />
      <el-table-column label="开始日期" align="center" prop="startDate" width="120">
        <template #default="scope">
          <span>{{ scope.row.startDate || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="结束日期" align="center" prop="endDate" width="120">
        <template #default="scope">
          <span>{{ scope.row.endDate || '-' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="是否当前" align="center" prop="isCurrent" width="100">
        <template #default="scope">
          <el-tag v-if="scope.row.isCurrent === 1" type="success">当前学期</el-tag>
          <el-tag v-else type="info">否</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="220" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button
            v-if="scope.row.isCurrent !== 1"
            link
            type="success"
            icon="Check"
            @click="handleSetCurrent(scope.row)"
            v-hasPermi="['course:semester:edit']"
          >设为当前</el-button>
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['course:semester:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['course:semester:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改学期对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="semesterRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="学期名称" prop="semesterName">
          <el-input v-model="form.semesterName" placeholder="请输入学期名称，如：2024-2025学年第一学期" />
        </el-form-item>
        <el-form-item label="开始日期" prop="startDate">
          <el-date-picker
            v-model="form.startDate"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="选择开始日期"
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="结束日期" prop="endDate">
          <el-date-picker
            v-model="form.endDate"
            type="date"
            value-format="YYYY-MM-DD"
            placeholder="选择结束日期"
            style="width: 100%"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Semester">
import { listSemester, getSemester, addSemester, updateSemester, delSemester, setCurrentSemester } from "@/api/course/semester"

const { proxy } = getCurrentInstance()

const semesterList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    semesterName: undefined,
    isCurrent: undefined
  },
  rules: {
    semesterName: [{ required: true, message: "学期名称不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询学期列表 */
function getList() {
  loading.value = true
  listSemester(queryParams.value).then(response => {
    semesterList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 取消按钮 */
function cancel() {
  open.value = false
  reset()
}

/** 表单重置 */
function reset() {
  form.value = {
    id: undefined,
    semesterName: undefined,
    startDate: undefined,
    endDate: undefined,
    isCurrent: 0
  }
  proxy.resetForm("semesterRef")
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加学期"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const id = row.id
  getSemester(id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改学期"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["semesterRef"].validate(valid => {
    if (valid) {
      if (form.value.id != undefined) {
        updateSemester(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addSemester(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 设为当前学期 */
function handleSetCurrent(row) {
  proxy.$modal.confirm('是否将"' + row.semesterName + '"设为当前学期？').then(function () {
    return setCurrentSemester(row.id)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("设置成功")
  }).catch(() => {})
}

/** 删除按钮操作 */
function handleDelete(row) {
  proxy.$modal.confirm('是否确认删除学期"' + row.semesterName + '"？').then(function () {
    return delSemester(row.id)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

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

// ── 当前学期行高亮 ────────────────────────────────────
:deep(.el-table) {
  // 表格内"当前学期" tag 特殊样式
  .el-tag--success {
    background: linear-gradient(135deg, #ebfbee, #d3f9d8);
    border-color: #8ce99a;
    color: #2f9e44;
    font-weight: 700;
    padding: 2px 10px;
    border-radius: 20px;
  }

  .el-tag--info {
    background: #f3f4f8;
    border-color: #dee2ef;
    color: #909399;
    border-radius: 20px;
  }

  // 设为当前 / 修改 / 删除 按钮色
  .el-button[type=success] { color: #2f9e44 !important; }
  .el-button[type=primary][icon=Edit]   { color: #3B5BDB !important; }
  .el-button[type=primary][icon=Delete] { color: #e03131 !important; }
}

// ── 学期名显示增强 ────────────────────────────────────
.semester-name-col {
  font-weight: 600;
  color: #1e2a5e;
}
</style>
