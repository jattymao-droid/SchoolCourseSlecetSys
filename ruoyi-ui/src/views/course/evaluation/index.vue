<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="学期" prop="semesterId">
        <el-select v-model="queryParams.semesterId" placeholder="请选择学期" clearable style="width: 200px">
          <el-option v-for="s in semesterList" :key="s.id" :label="s.semesterName" :value="s.id" />
        </el-select>
      </el-form-item>
      <el-form-item label="评价内容" prop="content">
        <el-input v-model="queryParams.content" placeholder="请输入评价内容" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择" clearable style="width: 120px">
          <el-option v-for="d in statusOptions" :key="d.value" :label="d.label" :value="parseInt(d.value)" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="success" plain icon="Plus" @click="handleAdd" v-hasPermi="['course:evaluation:add']">新增</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="questionList">
      <el-table-column label="评价内容" align="center" prop="content" min-width="200" show-overflow-tooltip />
      <el-table-column label="分值" align="center" prop="score" width="80" />
      <el-table-column label="排序" align="center" prop="sort" width="80" />
      <el-table-column label="学期" align="center" prop="semesterName" width="140" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-switch
            v-model="scope.row.status"
            :active-value="1"
            :inactive-value="0"
            @change="handleStatusChange(scope.row)"
            v-hasPermi="['course:evaluation:edit']"
          />
          <span class="ml-2">{{ scope.row.status === 1 ? '启用' : '停用' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="180" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="warning" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['course:evaluation:edit']">修改</el-button>
          <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['course:evaluation:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="560px" append-to-body>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="学期" prop="semesterId">
          <el-select v-model="form.semesterId" placeholder="请选择学期" style="width: 100%">
            <el-option v-for="s in semesterList" :key="s.id" :label="s.semesterName" :value="s.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="评价内容" prop="content">
          <el-input v-model="form.content" type="textarea" :rows="3" placeholder="请输入评价内容" />
        </el-form-item>
        <el-form-item label="分值" prop="score">
          <el-input-number v-model="form.score" :min="1" :max="100" controls-position="right" style="width: 120px" />
          <span class="el-form-item__tip" style="margin-left: 8px; color: #909399">学生评分时 0 至该分值</span>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input-number v-model="form.sort" :min="0" controls-position="right" style="width: 120px" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio :value="1">启用</el-radio>
            <el-radio :value="0">停用</el-radio>
          </el-radio-group>
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

<script setup name="Evaluation">
import { listQuestion, getQuestion, addQuestion, updateQuestion, delQuestion, setQuestionStatus } from '@/api/course/evaluation'
import { listSemesterAll } from '@/api/course/semester'

const { proxy } = getCurrentInstance()

const questionList = ref([])
const semesterList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const total = ref(0)
const title = ref('')

const { eva_question_status } = proxy.useDict('eva_question_status')
const statusOptions = computed(() => eva_question_status.value || [])

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    semesterId: undefined,
    content: undefined,
    status: undefined
  },
  rules: {
    semesterId: [{ required: true, message: '请选择学期', trigger: 'change' }],
    content: [{ required: true, message: '请输入评价内容', trigger: 'blur' }],
    score: [{ required: true, message: '请输入分值', trigger: 'blur' }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listQuestion(queryParams.value).then(res => {
    questionList.value = res.rows || []
    total.value = res.total || 0
    loading.value = false
  })
}

function getSemesterList() {
  listSemesterAll({}).then(res => {
    semesterList.value = res.data || []
  })
}

function handleStatusChange(row) {
  const status = row.status
  const text = status === 1 ? '启用' : '停用'
  proxy.$modal.confirm('确认' + text + '题目"' + row.content + '"？').then(() => {
    return setQuestionStatus(row.id, status)
  }).then(() => {
    proxy.$modal.msgSuccess(text + '成功')
    getList()
  }).catch(() => {
    row.status = status === 1 ? 0 : 1
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    id: undefined,
    content: undefined,
    score: 10,
    sort: 0,
    semesterId: undefined,
    status: 1
  }
  proxy.resetForm('formRef')
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  handleQuery()
}

function handleAdd() {
  reset()
  open.value = true
  title.value = '新增评价题目'
}

function handleUpdate(row) {
  reset()
  getQuestion(row.id).then(res => {
    form.value = res.data
    open.value = true
    title.value = '修改评价题目'
  })
}

function submitForm() {
  proxy.$refs['formRef'].validate(valid => {
    if (valid) {
      if (form.value.id != undefined) {
        updateQuestion(form.value).then(() => {
          proxy.$modal.msgSuccess('修改成功')
          open.value = false
          getList()
        })
      } else {
        addQuestion(form.value).then(() => {
          proxy.$modal.msgSuccess('新增成功')
          open.value = false
          getList()
        })
      }
    }
  })
}

function handleDelete(row) {
  proxy.$modal.confirm('是否确认删除题目"' + row.content + '"？').then(() => {
    return delQuestion(row.id)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess('删除成功')
  }).catch(() => {})
}

getSemesterList()
getList()
</script>
