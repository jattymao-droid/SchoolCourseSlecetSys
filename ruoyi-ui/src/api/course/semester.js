import request from '@/utils/request'

// 查询学期列表
export function listSemester(query) {
  return request({
    url: '/course/semester/list',
    method: 'get',
    params: query
  })
}

// 查询学期列表（不分页）
export function listSemesterAll(query) {
  return request({
    url: '/course/semester/listAll',
    method: 'get',
    params: query
  })
}

// 查询学期详细
export function getSemester(id) {
  return request({
    url: '/course/semester/' + id,
    method: 'get'
  })
}

// 新增学期
export function addSemester(data) {
  return request({
    url: '/course/semester',
    method: 'post',
    data: data
  })
}

// 修改学期
export function updateSemester(data) {
  return request({
    url: '/course/semester',
    method: 'put',
    data: data
  })
}

// 删除学期
export function delSemester(id) {
  return request({
    url: '/course/semester/' + id,
    method: 'delete'
  })
}

// 设置当前学期
export function setCurrentSemester(id) {
  return request({
    url: '/course/semester/setCurrent/' + id,
    method: 'put'
  })
}

// 获取当前学期
export function getCurrentSemester() {
  return request({
    url: '/course/semester/current',
    method: 'get'
  })
}
