import request from '@/utils/request'

// 管理员：选课综合统计
export function getAdminStats() {
  return request({
    url: '/course/dashboard/admin',
    method: 'get'
  })
}

// 学生：选课相关统计
export function getStudentStats() {
  return request({
    url: '/course/dashboard/student',
    method: 'get'
  })
}
