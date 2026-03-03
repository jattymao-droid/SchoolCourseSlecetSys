import request from '@/utils/request'

/** 教师考核列表 */
export function listTeacherAssessment(semesterId) {
  return request({
    url: '/course/teacherAssessment/list',
    method: 'get',
    params: { semesterId }
  })
}

/** 教师考核-学生评价详情 */
export function getTeacherEvaluationDetail(teacherId, teacherName, semesterId) {
  return request({
    url: '/course/teacherAssessment/detail',
    method: 'get',
    params: { teacherId, teacherName, semesterId }
  })
}

/** 初始化考核数据 */
export function initAssessmentData(semesterId) {
  return request({
    url: '/course/teacherAssessment/initAssessmentData',
    method: 'post',
    params: { semesterId }
  })
}

/** 删除教师考核数据 */
export function deleteTeacherAssessment(teacherId, semesterId) {
  return request({
    url: '/course/teacherAssessment/delete',
    method: 'post',
    params: { teacherId, semesterId }
  })
}
