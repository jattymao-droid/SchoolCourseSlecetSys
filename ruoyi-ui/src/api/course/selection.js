import request from '@/utils/request'

// 获取选课车
export function getCart(semesterId) {
  return request({
    url: '/course/selection/cart',
    method: 'get',
    params: { semesterId }
  })
}

// 加入选课车
export function addToCart(semesterId, courseId) {
  return request({
    url: '/course/selection/cart/add',
    method: 'post',
    params: { semesterId, courseId }
  })
}

// 移除选课车
export function removeFromCart(semesterId, weekDay) {
  return request({
    url: '/course/selection/cart/remove',
    method: 'delete',
    params: { semesterId, weekDay }
  })
}

// 清空选课车
export function clearCart(semesterId) {
  return request({
    url: '/course/selection/cart/clear',
    method: 'delete',
    params: { semesterId }
  })
}

// 提交选课
export function submitSelection(semesterId) {
  return request({
    url: '/course/selection/submit',
    method: 'post',
    params: { semesterId }
  })
}

// 退课
export function dropCourse(selectionId) {
  return request({
    url: '/course/selection/drop/' + selectionId,
    method: 'post'
  })
}

// 我的选课列表
export function getMySelections(semesterId) {
  return request({
    url: '/course/selection/my',
    method: 'get',
    params: { semesterId }
  })
}

// 查询课程剩余名额
export function getRemainingQuota(courseId) {
  return request({
    url: '/course/selection/quota/' + courseId,
    method: 'get'
  })
}
