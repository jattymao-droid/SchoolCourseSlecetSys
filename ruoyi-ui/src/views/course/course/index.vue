<template>
  <div class="app-container">
    <!-- 课程统计卡片 -->
    <el-row :gutter="16" class="stats-cards-row mb8">
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card stats-card-blue" shadow="hover">
          <div class="stats-content">
            <div class="stats-icon"><el-icon :size="32"><Reading /></el-icon></div>
            <div class="stats-info">
              <div class="stats-value">{{ (courseStats && courseStats.totalCourses) ?? 0 }}</div>
              <div class="stats-label">课程总数</div>
              <div class="stats-trend" v-if="courseStats && courseStats.fullCourses > 0">
                <span>已满 {{ courseStats.fullCourses }} 门</span>
              </div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card stats-card-green" shadow="hover">
          <div class="stats-content">
            <div class="stats-icon"><el-icon :size="32"><User /></el-icon></div>
            <div class="stats-info">
              <div class="stats-value">{{ (courseStats && courseStats.totalSelectedCount) ?? 0 }}</div>
              <div class="stats-label">选课总人数</div>
              <div class="stats-trend">占用 {{ (courseStats && courseStats.quotaUsageRate) ?? 0 }}%</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card stats-card-orange" shadow="hover">
          <div class="stats-content">
            <div class="stats-icon"><el-icon :size="32"><PieChart /></el-icon></div>
            <div class="stats-info">
              <div class="stats-value">{{ (courseStats && courseStats.avgSelectionRate) ?? 0 }}%</div>
              <div class="stats-label">平均选课率</div>
              <div class="stats-trend">{{ courseStats && courseStats.avgSelectionRate >= 80 ? '热门' : '正常' }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="12" :md="6">
        <el-card class="stats-card stats-card-purple" shadow="hover">
          <div class="stats-content">
            <div class="stats-icon"><el-icon :size="32"><Tickets /></el-icon></div>
            <div class="stats-info">
              <div class="stats-value">{{ (courseStats && courseStats.totalQuota) ?? 0 }}</div>
              <div class="stats-label">总名额</div>
              <div class="stats-trend">剩余 {{ (courseStats && courseStats.remainingQuota) ?? 0 }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

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
        <el-tag v-if="!selectionStatus" type="info" size="large">选课状态未知</el-tag>
        <el-tag v-else-if="selectionStatus === 'not_started'" type="info" size="large">选课未开始</el-tag>
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
        <el-button type="primary" plain icon="CopyDocument" @click="handleBatchCopy" v-hasPermi="['course:course:add']">批量复制课程</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleBatchDelete" v-hasPermi="['course:course:remove']">批量删除课程</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="courseList" border stripe class="course-table" @selection-change="handleCourseSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
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
      <el-table-column label="选课人数/名额" align="center" width="180">
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
      <el-table-column label="操作" align="center" width="320" class-name="small-padding fixed-width">
        <template #default="scope">
          <div class="action-buttons">
            <el-tooltip content="修改" placement="top">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['course:course:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="复制到新学期" placement="top">
              <el-button link type="success" icon="CopyDocument" @click="handleCopy(scope.row)" v-hasPermi="['course:course:add']"></el-button>
            </el-tooltip>
            <el-tooltip content="查看选课学生" placement="top">
              <el-button link type="info" icon="User" @click="handleViewStudents(scope.row)" v-hasPermi="['course:course:query']"></el-button>
            </el-tooltip>
            <el-tooltip content="查看分配学生" placement="top">
              <el-button link type="warning" icon="UserFilled" @click="handleViewAssignedStudents(scope.row)" v-hasPermi="['course:course:query']"></el-button>
            </el-tooltip>
            <el-tooltip content="分配学生" placement="top">
              <el-button link type="warning" icon="Plus" @click="handleAssignStudents(scope.row)" v-hasPermi="['course:course:edit']"></el-button>
            </el-tooltip>
            <el-tooltip content="删除" placement="top">
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
              <el-input v-model="form.location" placeholder="例如：A101" clearable style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入描述" :rows="2" />
        </el-form-item>
        <el-form-item label="名额分配">
          <el-button type="success" link icon="Plus" @click="addQuotaRow">添加分配</el-button>
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
          <el-button type="primary" @click="submitForm">确定</el-button>
          <el-button @click="cancel">取消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 复制课程对话框 -->
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
          <el-button type="primary" @click="submitCopy">确定</el-button>
          <el-button @click="copyOpen = false">取消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 批量复制课程对话框 -->
    <el-dialog title="批量复制课程" v-model="batchCopyOpen" width="450px" append-to-body>
      <el-form label-width="100px">
        <el-form-item label="源学期">
          <el-tag type="info">{{ batchCopySourceSemesterName || '未选择' }}</el-tag>
        </el-form-item>
        <el-form-item label="目标学期">
          <el-select v-model="batchCopyTargetSemesterId" placeholder="请选择目标学期" style="width: 100%">
            <el-option v-for="s in batchCopyTargetSemesterOptions" :key="s.id" :label="s.semesterName" :value="s.id" />
          </el-select>
        </el-form-item>
        <el-form-item v-if="batchCopyCourseCount >= 0" label="课程数">
          <span class="batch-copy-hint">共 <strong>{{ batchCopyCourseCount }}</strong> 门课程</span>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitBatchCopy" :loading="batchCopyLoading">确定</el-button>
          <el-button @click="batchCopyOpen = false">取消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 选课学生列表 -->
    <el-dialog title="选课学生列表" v-model="studentsOpen" width="700px" append-to-body>
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

    <!-- 分配学生列表 -->
    <el-dialog title="分配学生列表" v-model="assignedStudentsOpen" width="700px" append-to-body>
      <div v-if="viewAssignedStudentsCourseName" style="margin-bottom: 12px; color: #606266">
        <span><strong>{{ viewAssignedStudentsCourseName }}</strong></span>
      </div>
      <el-table v-loading="assignedStudentsLoading" :data="assignedStudents" max-height="400">
        <el-table-column label="学号" align="center" prop="studentNo" width="120" />
        <el-table-column label="姓名" align="center" prop="realName" width="100" />
        <el-table-column label="班级" align="center" prop="className" min-width="120" />
        <el-table-column label="分配时间" align="center" prop="createTime" width="180">
          <template #default="scope">
            <span>{{ parseTime(scope.row.createTime) }}</span>
          </template>
        </el-table-column>
      </el-table>
      <el-empty v-if="!assignedStudentsLoading && assignedStudents.length === 0" description="暂无分配学生" />
    </el-dialog>

    <!-- 分配学生 -->
    <el-dialog title="分配学生" v-model="assignState.open" width="720px" append-to-body>
      <div v-if="assignState.course" style="margin-bottom: 12px; color: #606266">
        <span><strong>{{ assignState.course.courseName }}</strong></span>
        <el-tag type="info" size="small" class="ml-2">{{ assignState.course.gradeName || assignState.course.grade_name || '未分级' }}</el-tag>
      </div>
      <el-form :inline="true" style="margin-bottom: 12px">
        <el-form-item label="班级筛选">
          <el-select v-model="assignState.classFilter" placeholder="全部班级" clearable style="width: 220px">
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
      <el-empty v-if="!assignState.loading && assignStateFilteredStudents.length === 0" description="该年级下暂无未选课学生" />
      <template #footer>
        <div class="dialog-footer" style="display: flex; justify-content: space-between; align-items: center">
          <div>
            <el-button type="primary" link icon="Upload" @click="openAssignImport">导入分配</el-button>
            <el-button type="primary" @click="submitAssign" :disabled="assignState.selectedIds.length === 0">分配</el-button>
            <el-button @click="assignState.open = false">取消</el-button>
          </div>
        </div>
      </template>
    </el-dialog>

    <!-- 导入分配学生 -->
    <el-dialog title="导入分配学生" v-model="assignImportOpen" width="400px" append-to-body>
      <el-upload
        ref="assignImportRef"
        v-model:file-list="assignImportFileList"
        :limit="1"
        accept=".xlsx, .xls"
        :headers="assignImportUpload.headers"
        :action="assignImportUpload.url"
        :disabled="assignImportUploading"
        :on-progress="() => assignImportUploading = true"
        :on-success="handleAssignImportSuccess"
        :on-error="() => assignImportUploading = false"
        :auto-upload="false"
        drag
      >
        <el-icon class="el-icon--upload"><upload-filled /></el-icon>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <template #tip>
          <div class="el-upload__tip text-center">
            <span>仅允许 xls、xlsx 格式文件。请先下载模板</span>
            <el-link type="primary" style="font-size:12px" @click="downloadAssignImportTemplate">下载模板</el-link>
          </div>
        </template>
      </el-upload>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitAssignImport" :disabled="assignImportUploading">确定</el-button>
          <el-button @click="assignImportOpen = false">取消</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 导入课程 -->
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
            <span>仅允许 xls、xlsx 格式文件</span>
            <el-link type="primary" style="font-size:12px" @click="importTemplate">下载模板</el-link>
          </div>
        </template>
      </el-upload>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitFileForm">确定</el-button>
          <el-button @click="upload.open = false">取消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Course">
import { listCourse, getCourse, addCourse, updateCourse, delCourse, delCourseBatch, copyToNewSemester, listSelectedStudents, listAssignedStudents, assignStudents, initSelectionData } from "@/api/course/course"
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
const assignedStudents = ref([])
const assignedStudentsOpen = ref(false)
const assignedStudentsLoading = ref(false)
const viewAssignedStudentsCourseId = ref(undefined)
const viewAssignedStudentsCourseName = ref('')
const open = ref(false)
const copyOpen = ref(false)
const studentsOpen = ref(false)
const loading = ref(true)
const studentsLoading = ref(false)
const showSearch = ref(true)
const total = ref(0)
const title = ref("")
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const copyTargetSemesterId = ref(undefined)
const copySourceCourseId = ref(undefined)
const viewStudentsCourseId = ref(undefined)
const batchCopyOpen = ref(false)
const batchCopyTargetSemesterId = ref(undefined)
const batchCopyLoading = ref(false)
const batchCopyCourseCount = ref(-1)
const uploadRef = ref()
const assignImportRef = ref()
const assignImportOpen = ref(false)
const assignImportFileList = ref([])
const assignImportUploading = ref(false)
const assignImportUpload = reactive({
  headers: { Authorization: "Bearer " + getToken() },
  get url() {
    return assignState.course
      ? import.meta.env.VITE_APP_BASE_API + "/course/course/" + assignState.course.id + "/assignStudents/import"
      : ""
  }
})
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

/** 分配学生对话框过滤后的学生列表 */
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

/** 批量复制的源学期名称 */
const batchCopySourceSemesterName = computed(() => {
  const sid = queryParams.value.semesterId || currentSemesterData.value?.id
  if (!sid) return ''
  return semesterList.value.find(s => s.id === sid)?.semesterName || currentSemesterData.value?.semesterName || ''
})

/** 批量复制的目标学期选项（排除当前源学期）*/
const batchCopyTargetSemesterOptions = computed(() => {
  const sid = queryParams.value.semesterId || currentSemesterData.value?.id
  return (semesterList.value || []).filter(s => s.id !== sid)
})

// 课程统计（顶部卡片用）
const courseStats = ref({
  totalCourses: 0,
  totalSelectedCount: 0,
  totalQuota: 0,
  avgSelectionRate: 0,
  remainingQuota: 0,
  fullCourses: 0,
  quotaUsageRate: 0
})

// 选课状态 not_started | ongoing | ended
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
    weekDay: [{ required: true, message: "星期不能为空", trigger: "change" }],
    gradeId: [{ required: true, message: "年级不能为空", trigger: "change" }],
    semesterId: [{ required: true, message: "学期不能为空", trigger: "change" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 根据当前课程列表计算统计（供顶部卡片显示）；totalCount 为接口返回的课程总条数，用于“课程总数”卡片 */
function calculateStats(courses, totalCount) {
  if (!Array.isArray(courses)) return
  const totalCourses = (totalCount != null && totalCount >= 0) ? totalCount : courses.length
  const totalSelectedCount = courses.reduce((sum, c) => sum + (c.selectedCount || 0), 0)
  const totalQuota = courses.reduce((sum, c) => sum + (c.totalQuota || 0), 0)
  const avgSelectionRate = totalQuota > 0 ? Math.round((totalSelectedCount / totalQuota) * 100) : 0
  const remainingQuota = Math.max(0, totalQuota - totalSelectedCount)
  const fullCourses = courses.filter(c => (c.selectedCount || 0) >= (c.totalQuota || 0) && (c.totalQuota || 0) > 0).length
  const quotaUsageRate = totalQuota > 0 ? Math.round((totalSelectedCount / totalQuota) * 100) : 0
  courseStats.value = {
    totalCourses,
    totalSelectedCount,
    totalQuota,
    avgSelectionRate,
    remainingQuota,
    fullCourses,
    quotaUsageRate
  }
}

function getList() {
  loading.value = true
  listCourse(queryParams.value).then(response => {
    const rows = response.rows || []
    if (rows.length > 0 && import.meta.env.DEV) {
      console.log('[调试] 课程 keys:', Object.keys(rows[0]), '| location:', rows[0].location)
    }
    courseList.value = rows.map(r => ({ 
      ...r, 
      location: r.location ?? '',
      selectedCount: r.selectedCount ?? r.selected_count ?? 0,
      totalQuota: r.totalQuota ?? r.total_quota ?? 0
    }))
    total.value = response.total
    loading.value = false
    calculateStats(courseList.value, response.total)
  })
}

// 计算选课进度百分比
function calculateProgress(row) {
  const total = row.totalQuota || 0
  const selected = row.selectedCount || 0
  if (total === 0) return 0
  return Math.min(Math.round((selected / total) * 100), 100)
}

// 根据进度返回颜色
function getProgressColor(row) {
  const percentage = calculateProgress(row)
  if (percentage >= 90) return '#EF4444' // 红
  if (percentage >= 70) return '#F59E0B' // 橙
  if (percentage >= 40) return '#10B981' // 绿
  return '#3B82F6' // 蓝
}

// 根据ID获取课程颜色
function getCourseColor(id) {
  const colors = ['#409EFF', '#67C23A', '#E6A23C', '#F56C6C', '#909399', '#3B82F6', '#8B5CF6', '#EC4899']
  return colors[(id || 0) % colors.length]
}

// 获取星期的标签类型
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
    proxy.$modal.msgSuccess("选课已开始")
    fetchCurrentSemester()
  }).catch(err => {
    proxy.$modal.msgError(err?.response?.data?.msg || err?.message || "操作失败")
  })
}

function handleEndSelection() {
  proxy.$modal.confirm("确认要结束当前选课吗？").then(() => {
    return endSelection()
  }).then(() => {
    proxy.$modal.msgSuccess("选课已结束")
    fetchCurrentSemester()
  }).catch(() => {})
}

/** 初始化选课数据（生成学生选课记录表）*/
function handleInitSelectionData() {
  const semesterId = queryParams.value.semesterId || currentSemesterData.value?.id
  if (!semesterId) {
    proxy.$modal.msgWarning("请先选择学期")
    return
  }
  const semesterName = semesterList.value.find(s => s.id === semesterId)?.semesterName || currentSemesterData.value?.semesterName || '当前学期'
  proxy.$modal.confirm(
    `确认要初始化 ${semesterName} 的选课数据吗？这将为所有学生生成选课记录。`
  ).then(() => {
    return proxy.$modal.confirm('此操作耗时较长，请勿重复点击。确认继续？')
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
    // 如果没有选择学期，默认选择当前学期
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

/** 课程表格多选 */
function handleCourseSelectionChange(selection) {
  ids.value = selection.map(r => r.id)
  single.value = selection.length !== 1
  multiple.value = !selection.length
}

/** 批量删除课程 */
function handleBatchDelete() {
  const idList = ids.value
  if (!idList || idList.length === 0) {
    proxy.$modal.msgWarning("请至少选择一条课程")
    return
  }
  proxy.$modal.confirm('是否确认删除所选中的 ' + idList.length + ' 门课程？').then(() => {
    return delCourseBatch(idList.join(','))
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
    proxy.$modal.msgWarning("请先选择源学期")
    return
  }
  batchCopyOpen.value = true
  batchCopyTargetSemesterId.value = undefined
  batchCopyCourseCount.value = -1
  listCourse({ semesterId: sourceId, pageNum: 1, pageSize: 5000 }).then(res => {
    const rows = res.rows || []
    batchCopyCourseCount.value = rows.length
    if (rows.length === 0) {
      proxy.$modal.msgWarning("该学期没有课程")
    }
  })
}

function submitBatchCopy() {
  const sourceId = queryParams.value.semesterId || currentSemesterData.value?.id
  if (!sourceId) {
    proxy.$modal.msgWarning("请先选择源学期")
    return
  }
  if (!batchCopyTargetSemesterId.value) {
    proxy.$modal.msgWarning("请选择目标学期")
    return
  }
  if (sourceId === batchCopyTargetSemesterId.value) {
    proxy.$modal.msgWarning("源学期和目标学期不能相同")
    return
  }
  batchCopyLoading.value = true
  listCourse({ semesterId: sourceId, pageNum: 1, pageSize: 5000 }).then(res => {
    const courses = res.rows || []
    if (courses.length === 0) {
      proxy.$modal.msgWarning("源学期没有课程")
      batchCopyLoading.value = false
      return
    }
    const targetId = batchCopyTargetSemesterId.value
    const promises = courses.map(c => copyToNewSemester(c.id, targetId))
    return Promise.all(promises).then(() => courses.length)
  }).then((count) => {
    if (count != null) {
      proxy.$modal.msgSuccess(`成功复制 ${count} 门课程`)
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

function handleViewAssignedStudents(row) {
  viewAssignedStudentsCourseId.value = row.id
  viewAssignedStudentsCourseName.value = row.courseName ?? row.course_name ?? ''
  assignedStudents.value = []
  assignedStudentsOpen.value = true
  assignedStudentsLoading.value = true
  listAssignedStudents(row.id).then(res => {
    assignedStudents.value = res.rows || []
    assignedStudentsLoading.value = false
  }).catch(() => {
    assignedStudentsLoading.value = false
  })
}

function exportSelectedStudents() {
  if (!viewStudentsCourseId.value) return
  proxy.download("course/course/" + viewStudentsCourseId.value + "/exportSelectedStudents", {}, `选课学生_${new Date().getTime()}.xlsx`)
}

function handleAssignStudents(row) {
  const gradeId = row.gradeId ?? row.grade_id
  if (!gradeId) {
    proxy.$modal.msgWarning("该课程未关联年级，无法分配学生")
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
    proxy.$modal.msgSuccess("分配成功")
    assignState.open = false
    getList()
  }).catch(err => {
    const msg = err?.response?.data?.msg || err?.message || "分配失败"
    proxy.$modal.msgError(msg)
  })
}

function openAssignImport() {
  if (!assignState.course?.id) return
  assignImportFileList.value = []
  assignImportOpen.value = true
}

function downloadAssignImportTemplate() {
  if (!assignState.course?.id) return
  // 后端需提供 POST /course/course/{courseId}/assignStudents/importTemplate 返回 Excel；暂无则使用学生导入模板（学号等列格式兼容）
  const templatePath = 'course/student/importTemplate'
  proxy.download(templatePath, {}, `分配学生导入模板_${new Date().getTime()}.xlsx`)
}

function submitAssignImport() {
  if (!assignImportFileList.value?.length) {
    proxy.$modal.msgWarning("请选择文件")
    return
  }
  assignImportRef.value?.submit()
}

function handleAssignImportSuccess(response) {
  assignImportUploading.value = false
  assignImportOpen.value = false
  assignImportFileList.value = []
  assignImportRef.value?.clearFiles()
  proxy.$alert("<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" + (response.msg || response.data) + "</div>", "导入结果", { dangerouslyUseHTMLString: true })
  refreshAssignData()
}

function refreshAssignData() {
  if (!assignState.course) return
  const gradeId = assignState.course.gradeId ?? assignState.course.grade_id
  if (!gradeId) return
  assignState.loading = true
  Promise.all([
    listStudent({ gradeId, pageNum: 1, pageSize: 2000 }),
    listSelectedStudents(assignState.course.id),
    listClassByGrade(gradeId)
  ]).then(([studentRes, selectedRes]) => {
    const all = studentRes.rows || studentRes.data || []
    const selectedUserIds = new Set((selectedRes.rows || selectedRes.data || []).map(s => s.userId ?? s.user_id).filter(Boolean))
    assignState.students = all.filter(s => !selectedUserIds.has(s.userId ?? s.user_id))
    assignState.loading = false
  }).catch(() => { assignState.loading = false })
}

// 导出按钮操作
function handleExport() {
  proxy.download("course/course/export", {
    ...queryParams.value
  }, `课程数据_${new Date().getTime()}.xlsx`)
}

// 下载导入模板
function importTemplate() {
  proxy.download("course/course/importTemplate", {}, `课程导入模板_${new Date().getTime()}.xlsx`)
}

// 导入按钮操作
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

getSemesterList()
getGradeList()
fetchCurrentSemester()
</script>

<style scoped lang="scss">
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
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  
  .el-button {
    height: 34px;
    padding: 0 16px;
    font-size: 13px;
    font-weight: 500;
  }
}

.course-table {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);

  :deep(th.el-table__cell) {
    background-color: #F8FAFC;
    color: #475569;
    font-weight: 600;
    height: 44px;
  }
}

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
  
  .name-text {
    font-weight: 600;
    color: #1e2a5e;
  }
}

.icon-text-cell {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #64748B;
  font-size: 13px;
  
  .el-icon {
    margin-right: 4px;
    color: #94A3B8;
  }
}

.progress-wrapper {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 0 8px;
  
  :deep(.el-progress) {
    flex: 1;
  }
  
  .progress-text {
    font-size: 12px;
    color: #64748B;
    width: 60px;
    text-align: right;
    font-family: monospace;
    
    .current { color: #1e2a5e; font-weight: 600; }
    .separator { margin: 0 2px; color: #cbd5e1; }
    .total { color: #94a3b8; }
  }
}

.action-buttons {
  display: flex;
  justify-content: center;
  gap: 4px;
  
  .el-button {
    padding: 4px;
    height: 24px;
    width: 24px;
    border-radius: 4px;
    
    &:hover {
      background-color: #F1F5F9;
    }
  }
}

.selection-control-row {
  background: #FFF7ED;
  border: 1px solid #FFEDD5;
  
  :deep(.el-tag) {
    font-weight: 600;
    letter-spacing: 0.5px;
  }
}

.batch-copy-hint {
  font-size: 14px;
  color: #606266;
  strong {
    color: #409EFF;
    font-size: 16px;
    margin: 0 4px;
  }
}

.assign-hint {
  font-size: 12px;
  color: #909399;
  margin-left: 8px;
}

/* 课程统计卡片 - 统一尺寸 */
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
.stats-info { flex: 1; min-width: 0; min-height: 48px; display: flex; flex-direction: column; justify-content: center; }
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
.stats-trend {
  font-size: 12px;
  color: #94a3b8;
  margin-top: 6px;
}
.stats-card-blue .stats-icon { background: linear-gradient(135deg, #3b82f6, #2563eb); }
.stats-card-green .stats-icon { background: linear-gradient(135deg, #10b981, #059669); }
.stats-card-orange .stats-icon { background: linear-gradient(135deg, #f59e0b, #d97706); }
.stats-card-purple .stats-icon { background: linear-gradient(135deg, #8b5cf6, #7c3aed); }
</style>
