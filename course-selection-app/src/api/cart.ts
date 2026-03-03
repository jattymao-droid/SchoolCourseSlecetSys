import { http } from '@/utils/request'

// 后端路径: /course/selection/*
// 后端 removeFromCart 参数是 weekDay（非 courseId）
// 后端 submitCart 需要 semesterId
// 后端 dropCourse 使用 POST 方法

export function getCart(semesterId: string | number) {
  return http.get<Record<string, any>>('/course/selection/cart', { semesterId })
}

export function addToCart(semesterId: string | number, courseId: string | number) {
  return http.post<string>('/course/selection/cart/add', undefined, { semesterId, courseId })
}

export function removeFromCart(semesterId: string | number, weekDay: number) {
  return http.delete('/course/selection/cart/remove', { semesterId, weekDay })
}

export function clearCart(semesterId: string | number) {
  return http.delete('/course/selection/cart/clear', { semesterId })
}

export function submitCart(semesterId: string | number) {
  return http.post<string>('/course/selection/submit', undefined, { semesterId })
}
