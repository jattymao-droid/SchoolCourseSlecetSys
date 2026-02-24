import request from '@/utils/request'

// 查询课程列表
export function listCourse(query) {
  return request({
    url: '/course/course/list',
    method: 'get',
    params: query
  })
}

// 查询课程详细
export function getCourse(id) {
  return request({
    url: '/course/course/' + id,
    method: 'get'
  })
}

// 新增课程
export function addCourse(data) {
  return request({
    url: '/course/course',
    method: 'post',
    data: data
  })
}

// 修改课程
export function updateCourse(data) {
  return request({
    url: '/course/course',
    method: 'put',
    data: data
  })
}

// 删除课程
export function delCourse(id) {
  return request({
    url: '/course/course/' + id,
    method: 'delete'
  })
}

// 复制课程到新学期
export function copyToNewSemester(oldCourseId, newSemesterId) {
  return request({
    url: '/course/course/copyToNewSemester/' + oldCourseId + '/' + newSemesterId,
    method: 'post'
  })
}

// 查询课程已选学生
export function listSelectedStudents(courseId) {
  return request({
    url: '/course/course/' + courseId + '/selectedStudents',
    method: 'get'
  })
}

// 指定学生到课程
export function assignStudents(courseId, studentIds) {
  return request({
    url: '/course/course/' + courseId + '/assignStudents',
    method: 'post',
    data: { studentIds }
  })
}
