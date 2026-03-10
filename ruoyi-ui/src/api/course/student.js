import request from '@/utils/request'

// 查询学生列表
export function listStudent(query) {
  return request({
    url: '/course/student/list',
    method: 'get',
    params: query
  })
}

// 查询学生详细
export function getStudent(id) {
  return request({
    url: '/course/student/' + id,
    method: 'get'
  })
}

// 新增学生
export function addStudent(data) {
  return request({
    url: '/course/student',
    method: 'post',
    data: data
  })
}

// 修改学生
export function updateStudent(data) {
  return request({
    url: '/course/student',
    method: 'put',
    data: data
  })
}

// 删除学生
export function delStudent(id) {
  return request({
    url: '/course/student/' + id,
    method: 'delete'
  })
}

// 批量删除学生
export function delStudents(ids) {
  return request({
    url: '/course/student/batchRemove',
    method: 'post',
    data: ids
  })
}

// 导出学生
export function exportStudent(query) {
  return request({
    url: '/course/student/export',
    method: 'post',
    params: query,
    responseType: 'blob'
  })
}

// 重置密码
export function resetStudentPwd(userId, password) {
  return request({
    url: '/course/student/resetPwd/' + userId,
    method: 'post',
    params: { password: password || '' }
  })
}

// 重置所有学生密码
export function resetAllStudentPwd() {
  return request({
    url: '/course/student/resetAllPwd',
    method: 'post'
  })
}

// 获取当前登录学生信息（选课中心用）
export function getCurrentStudent() {
  return request({
    url: '/course/student/me',
    method: 'get'
  })
}
