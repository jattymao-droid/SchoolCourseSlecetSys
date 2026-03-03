<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="年级名称" prop="gradeName">
        <el-input
          v-model="queryParams.gradeName"
          placeholder="请输入年级名称"
          clearable
          style="width: 200px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Plus"
          @click="handleAddGrade"
          v-hasPermi="['course:grade:add']"
        >新增年级</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Sort"
          @click="handleUpgrade"
          v-hasPermi="['course:grade:edit']"
        >一键升级</el-button>
      </el-col>
      <el-col :span="1.5" v-if="selectedGradeId">
        <el-button
          type="success"
          plain
          icon="Plus"
          @click="handleAddClass"
          v-hasPermi="['course:class:add']"
        >新增班级</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getGradeList"></right-toolbar>
    </el-row>

    <el-row :gutter="20">
      <!-- 年级列表 -->
      <el-col :span="10">
        <el-card shadow="never" class="grade-card">
          <template #header>
            <div class="card-header">
              <el-icon><Menu /></el-icon>
              <span>年级列表</span>
            </div>
          </template>
          <el-table
            v-loading="gradeLoading"
            :data="gradeList"
            highlight-current-row
            @current-change="handleGradeSelect"
            class="custom-table"
          >
            <el-table-column label="年级名称" prop="gradeName" align="center">
              <template #default="scope">
                <span class="grade-name">{{ scope.row.gradeName }}</span>
              </template>
            </el-table-column>
            <el-table-column label="排序" prop="sort" width="80" align="center" />
            <el-table-column label="操作" align="center" width="120">
              <template #default="scope">
                <div class="action-buttons">
                  <el-tooltip content="修改" placement="top">
                    <el-button link type="primary" icon="Edit" @click="handleUpdateGrade(scope.row)" v-hasPermi="['course:grade:edit']"></el-button>
                  </el-tooltip>
                  <el-tooltip content="删除" placement="top">
                    <el-button link type="danger" icon="Delete" @click="handleDeleteGrade(scope.row)" v-hasPermi="['course:grade:remove']"></el-button>
                  </el-tooltip>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
      <!-- 班级列表 -->
      <el-col :span="14">
        <el-card shadow="never" class="class-card">
          <template #header>
            <div class="card-header">
              <div class="left">
                <el-icon><School /></el-icon>
                <span>班级列表</span>
              </div>
              <el-tag v-if="selectedGradeName" type="primary" effect="plain" class="header-tag">{{ selectedGradeName }}</el-tag>
            </div>
          </template>
          <el-empty v-if="!selectedGradeId" description="请先选择左侧年级" />
          <el-table v-else v-loading="classLoading" :data="classList" class="custom-table" stripe>
            <el-table-column label="班级名称" prop="className" align="center">
              <template #default="scope">
                <el-tag effect="light">{{ scope.row.className }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="所属年级" prop="gradeName" width="120" align="center">
              <template #default="scope">
                 <el-tag type="info" effect="plain">{{ scope.row.gradeName }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="创建时间" prop="createTime" width="180" align="center">
              <template #default="scope">
                <span class="time-text">{{ parseTime(scope.row.createTime) }}</span>
              </template>
            </el-table-column>
            <el-table-column label="操作" align="center" width="120">
              <template #default="scope">
                <div class="action-buttons">
                  <el-tooltip content="修改" placement="top">
                    <el-button link type="primary" icon="Edit" @click="handleUpdateClass(scope.row)" v-hasPermi="['course:class:edit']"></el-button>
                  </el-tooltip>
                  <el-tooltip content="删除" placement="top">
                    <el-button link type="danger" icon="Delete" @click="handleDeleteClass(scope.row)" v-hasPermi="['course:class:remove']"></el-button>
                  </el-tooltip>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <!-- 年级表单 -->
    <el-dialog :title="gradeTitle" v-model="gradeOpen" width="400px" append-to-body>
      <el-form ref="gradeRef" :model="gradeForm" :rules="gradeRules" label-width="80px">
        <el-form-item label="年级名称" prop="gradeName">
          <el-input v-model="gradeForm.gradeName" placeholder="如：高一、高二" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input-number v-model="gradeForm.sort" :min="0" controls-position="right" style="width: 100%" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" @click="submitGradeForm">确 定</el-button>
        <el-button @click="gradeOpen = false">取 消</el-button>
      </template>
    </el-dialog>

    <!-- 班级表单 -->
    <el-dialog :title="classTitle" v-model="classOpen" width="400px" append-to-body>
      <el-form ref="classRef" :model="classForm" :rules="classRules" label-width="80px">
        <el-form-item label="班级名称" prop="className">
          <el-input v-model="classForm.className" placeholder="如：1班、2班" />
        </el-form-item>
        <el-form-item label="所属年级" prop="gradeId">
          <el-select v-model="classForm.gradeId" placeholder="请选择年级" style="width: 100%">
            <el-option
              v-for="g in gradeList"
              :key="g.id"
              :label="g.gradeName"
              :value="g.id"
            />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button type="primary" @click="submitClassForm">确 定</el-button>
        <el-button @click="classOpen = false">取 消</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="GradeClass">
import { listGradeAll, getGrade, addGrade, updateGrade, delGrade, upgradeGrades } from "@/api/course/grade"
import { listClassByGrade, getClass, addClass, updateClass, delClass } from "@/api/course/class"

const { proxy } = getCurrentInstance()

const gradeList = ref([])
const classList = ref([])
const gradeLoading = ref(false)
const classLoading = ref(false)
const showSearch = ref(true)
const selectedGradeId = ref(null)
const selectedGradeName = ref('')
const gradeOpen = ref(false)
const classOpen = ref(false)
const gradeTitle = ref('')
const classTitle = ref('')

const data = reactive({
  queryParams: { gradeName: undefined },
  gradeForm: {},
  classForm: {},
  gradeRules: {
    gradeName: [{ required: true, message: "年级名称不能为空", trigger: "blur" }]
  },
  classRules: {
    className: [{ required: true, message: "班级名称不能为空", trigger: "blur" }],
    gradeId: [{ required: true, message: "请选择年级", trigger: "change" }]
  }
})

const { queryParams, gradeForm, classForm, gradeRules, classRules } = toRefs(data)

function getGradeList() {
  gradeLoading.value = true
  const params = { ...queryParams.value }
  if (params.gradeName === undefined || params.gradeName === '') delete params.gradeName
  listGradeAll(params)
    .then(res => {
      gradeList.value = res.data || []
    })
    .catch(() => {
      gradeList.value = []
    })
    .finally(() => {
      gradeLoading.value = false
    })
}

function getClassList() {
  if (!selectedGradeId.value) {
    classList.value = []
    return
  }
  classLoading.value = true
  listClassByGrade(selectedGradeId.value)
    .then(res => {
      classList.value = res.data || []
    })
    .catch(() => {
      classList.value = []
    })
    .finally(() => {
      classLoading.value = false
    })
}

function handleGradeSelect(row) {
  if (!row) return
  selectedGradeId.value = row.id
  selectedGradeName.value = row.gradeName
  getClassList()
}

function handleQuery() {
  getGradeList()
  selectedGradeId.value = null
  selectedGradeName.value = ''
  classList.value = []
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function handleAddGrade() {
  gradeForm.value = { id: undefined, gradeName: '', sort: 0 }
  gradeTitle.value = '新增年级'
  gradeOpen.value = true
}

function handleUpdateGrade(row) {
  getGrade(row.id).then(res => {
    gradeForm.value = res.data
    gradeTitle.value = '修改年级'
    gradeOpen.value = true
  })
}

function submitGradeForm() {
  proxy.$refs["gradeRef"].validate(valid => {
    if (valid) {
      if (gradeForm.value.id) {
        updateGrade(gradeForm.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          gradeOpen.value = false
          getGradeList()
        })
      } else {
        addGrade(gradeForm.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          gradeOpen.value = false
          getGradeList()
        })
      }
    }
  })
}

function handleDeleteGrade(row) {
  proxy.$modal.confirm('是否确认删除年级"' + row.gradeName + '"？').then(() => {
    return delGrade(row.id)
  }).then(() => {
    getGradeList()
    if (selectedGradeId.value === row.id) {
      selectedGradeId.value = null
      selectedGradeName.value = ''
      classList.value = []
    }
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

function handleUpgrade() {
  proxy.$modal.confirm('一键升级将把所有年级名称升级到下一级（如高一→高二），是否继续？').then(() => {
    return upgradeGrades()
  }).then(res => {
    proxy.$modal.msgSuccess(res.data?.msg || res.msg || "升级成功")
    getGradeList()
    if (selectedGradeId.value) getClassList()
  }).catch(() => {})
}

function handleAddClass() {
  classForm.value = { id: undefined, className: '', gradeId: selectedGradeId.value }
  classTitle.value = '新增班级'
  classOpen.value = true
}

function handleUpdateClass(row) {
  getClass(row.id).then(res => {
    classForm.value = res.data
    classTitle.value = '修改班级'
    classOpen.value = true
  })
}

function submitClassForm() {
  proxy.$refs["classRef"].validate(valid => {
    if (valid) {
      if (classForm.value.id) {
        updateClass(classForm.value).then(() => {
          proxy.$modal.msgSuccess("修改成功")
          classOpen.value = false
          getClassList()
        })
      } else {
        addClass(classForm.value).then(() => {
          proxy.$modal.msgSuccess("新增成功")
          classOpen.value = false
          getClassList()
        })
      }
    }
  })
}

function handleDeleteClass(row) {
  proxy.$modal.confirm('是否确认删除班级"' + row.className + '"？').then(() => {
    return delClass(row.id)
  }).then(() => {
    getClassList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

getGradeList()
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

// ── 年级卡片 ──────────────────────────────────────────
:deep(.el-card) {
  border-radius: 10px;
  border-color: #dde6ff;
  box-shadow: 0 2px 14px rgba(59,91,219,0.08);
  overflow: hidden;
  transition: all 0.3s;
  
  &:hover {
    box-shadow: 0 4px 18px rgba(59,91,219,0.12);
  }

  .el-card__header {
    background: linear-gradient(to right, #f8faff, #fff);
    border-bottom: 1px solid #eef1fc;
    padding: 15px 20px;
  }
}

.card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-weight: 700;
  color: #334155;
  font-size: 15px;
  
  .el-icon {
    margin-right: 8px;
    font-size: 18px;
    color: #3B82F6;
    vertical-align: -2px;
  }
  
  .left {
    display: flex;
    align-items: center;
  }
}

.header-tag {
  font-weight: normal;
  border-radius: 12px;
  padding: 0 10px;
}

// ── 表格通用样式 ──────────────────────────────────────
.custom-table {
  border-radius: 6px;
  
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

// ── 已选年级高亮行 ────────────────────────────────────
:deep(.el-table) {
  .current-row > td {
    background-color: #eff6ff !important;
    background-image: none !important;
    
    .grade-name {
      color: #2563EB;
      font-weight: 700;
    }
  }
}

.grade-name {
  font-weight: 500;
  color: #1e293b;
}

.time-text {
  color: #64748B;
  font-size: 12px;
  font-family: 'Segoe UI', sans-serif;
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

// ── 操作按钮颜色 ──────────────────────────────────────
:deep(.el-table) {
  .el-button[type=primary][icon=Edit]   { color: #3B82F6 !important; }
  .el-button[type=danger][icon=Delete] { color: #EF4444 !important; }
}
</style>
