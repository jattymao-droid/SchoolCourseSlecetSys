import { http } from '@/utils/request'

export interface MySelectionVO {
  id: number | string
  courseId: number | string
  courseName: string
  weekDay: number
  teacherName?: string
  classId?: number | string
  className?: string
  semesterId: number | string
  createTime?: string
  location?: string
  /** 是否管理员指定 1是 0否（指定课程不可退课） */
  assigned?: number
}

export function getMySelections(semesterId: string | number) {
  return http.get<MySelectionVO[]>('/course/selection/my', { semesterId })
}

/** 退课接口返回：msg 提示信息，cart 更新后的选课车（周一到周五） */
export interface DropCourseResult {
  msg?: string
  cart?: Record<string, unknown>
}

// 后端 drop 使用 POST 方法，退课后返回更新后的选课车
export function dropCourse(selectionId: string | number) {
  return http.post<DropCourseResult>(`/course/selection/drop/${selectionId}`)
}
