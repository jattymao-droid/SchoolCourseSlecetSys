import request from '@/utils/request'

/* ========== 管理员：题目管理 ========== */

export function listQuestion(params) {
  return request({
    url: '/course/evaluation/question/list',
    method: 'get',
    params
  })
}

export function getQuestion(id) {
  return request({
    url: '/course/evaluation/question/' + id,
    method: 'get'
  })
}

export function addQuestion(data) {
  return request({
    url: '/course/evaluation/question',
    method: 'post',
    data
  })
}

export function updateQuestion(data) {
  return request({
    url: '/course/evaluation/question',
    method: 'put',
    data
  })
}

export function delQuestion(id) {
  return request({
    url: '/course/evaluation/question/' + id,
    method: 'delete'
  })
}

export function setQuestionStatus(id, status) {
  return request({
    url: '/course/evaluation/question/' + id + '/status/' + status,
    method: 'put'
  })
}

/* ========== 学生：课程评价 ========== */

export function getCoursesToEvaluate(semesterId) {
  return request({
    url: '/course/evaluation/my/courses',
    method: 'get',
    params: { semesterId }
  })
}

export function submitEvaluation(data) {
  return request({
    url: '/course/evaluation/my/submit',
    method: 'post',
    data
  })
}
