<template>
  <div class="app-container">
    <el-alert v-if="!currentSemester" title="当前无选课学期" type="warning" :closable="false" show-icon style="margin-bottom: 16px" />
    <template v-else>
      <div class="page-header">
        <div class="semester-bar">
          <span class="semester-label">当前学期：</span>
          <el-tag type="primary" size="large">{{ currentSemester.semesterName }}</el-tag>
        </div>
      </div>

      <el-alert v-if="courseList.length === 0 && !loading" title="暂无待评价课程，请先完成选课" type="info" :closable="false" show-icon style="margin-bottom: 16px" />

      <el-row :gutter="16" v-loading="loading">
        <el-col :span="24" v-for="course in courseList" :key="course.courseId">
          <el-card shadow="hover" class="course-card">
            <template #header>
              <div class="card-header">
                <span class="course-name">{{ course.courseName }}</span>
                <el-tag v-if="course.evaluated" type="success" size="small">已评价</el-tag>
                <el-tag v-else type="warning" size="small">待评价</el-tag>
                <el-button
                  v-if="!course.evaluated && course.questions && course.questions.length > 0"
                  type="primary"
                  size="small"
                  @click="openEvaluateDialog(course)"
                >
                  去评价
                </el-button>
                <el-button
                  v-else-if="course.evaluated"
                  type="info"
                  size="small"
                  @click="openEvaluateDialog(course)"
                >
                  修改评价
                </el-button>
              </div>
            </template>
            <div class="course-info">
              <div><el-icon><Calendar /></el-icon> 星期{{ ['一','二','三','四','五'][(course.weekDay || 1) - 1] }}</div>
              <div v-if="course.teacherName"><el-icon><User /></el-icon> {{ course.teacherName }}</div>
            </div>
            <div v-if="!course.questions || course.questions.length === 0" class="no-questions">
              本学期暂无评价题目
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 评价弹窗 -->
      <el-dialog v-model="evalOpen" :title="'评价：' + (evalCourse?.courseName || '')" width="520px" append-to-body>
        <el-form ref="evalFormRef" :model="evalForm" label-width="120px">
          <el-form-item
            v-for="q in evalCourse?.questions || []"
            :key="q.questionId"
            :label="q.content"
            :rules="[{ required: true, message: '请评分', trigger: 'blur' }]"
          >
            <el-slider
              v-model="evalScores[q.questionId]"
              :min="0"
              :max="q.score || 10"
              :marks="sliderMarks(q.score)"
              show-stops
            />
            <span class="score-text">{{ evalScores[q.questionId] ?? 0 }} / {{ q.score }}</span>
          </el-form-item>
        </el-form>
        <template #footer>
          <div class="dialog-footer">
            <el-button type="primary" @click="submitEvaluate">提交</el-button>
            <el-button @click="evalOpen = false">取消</el-button>
          </div>
        </template>
      </el-dialog>
    </template>
  </div>
</template>

<script setup name="CourseEvaluation">
import { getCoursesToEvaluate, submitEvaluation } from '@/api/course/evaluation'
import { getCurrentSemester } from '@/api/course/semester'

const { proxy } = getCurrentInstance()

const currentSemester = ref(null)
const courseList = ref([])
const loading = ref(true)
const evalOpen = ref(false)
const evalCourse = ref(null)
const evalForm = ref({})
const evalFormRef = ref(null)
const evalScores = ref({})

function sliderMarks(max) {
  const m = { 0: '0' }
  if (max) m[max] = String(max)
  return m
}

function loadSemester() {
  return getCurrentSemester().then(res => {
    currentSemester.value = res.data
    return res.data
  })
}

function loadCourses() {
  if (!currentSemester.value?.id) return
  loading.value = true
  getCoursesToEvaluate(currentSemester.value.id).then(res => {
    courseList.value = res.data || []
    loading.value = false
  })
}

function openEvaluateDialog(course) {
  evalCourse.value = course
  evalScores.value = {}
  if (course.questions) {
    course.questions.forEach(q => {
      evalScores.value[q.questionId] = 0
    })
  }
  evalOpen.value = true
}

function submitEvaluate() {
  if (!evalCourse.value || !currentSemester.value) return
  const scores = Object.entries(evalScores.value).map(([questionId, score]) => ({
    questionId: Number(questionId),
    score: Number(score) ?? 0
  }))
  if (scores.some(s => s.score === undefined || s.score === null)) {
    proxy.$modal.msgWarning('请完成所有题目的评分')
    return
  }
  submitEvaluation({
    courseId: evalCourse.value.courseId,
    semesterId: currentSemester.value.id,
    scores
  }).then(() => {
    proxy.$modal.msgSuccess('评价提交成功')
    evalOpen.value = false
    loadCourses()
  })
}

onMounted(() => {
  loadSemester().then(semester => {
    if (semester) loadCourses()
  })
})
</script>

<style scoped>
.page-header {
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.semester-bar {
  display: flex;
  align-items: center;
  gap: 10px;
}
.semester-label {
  font-weight: 600;
  color: #606266;
}
.course-card {
  margin-bottom: 16px;
}
.card-header {
  display: flex;
  align-items: center;
  gap: 12px;
}
.course-name {
  font-weight: 600;
  font-size: 16px;
  flex: 1;
}
.course-info {
  display: flex;
  gap: 20px;
  color: #606266;
  font-size: 14px;
}
.course-info .el-icon {
  margin-right: 4px;
  vertical-align: middle;
}
.no-questions {
  color: #909399;
  font-size: 13px;
  margin-top: 8px;
}
.score-text {
  margin-left: 12px;
  font-weight: 500;
  color: #409eff;
}
</style>
