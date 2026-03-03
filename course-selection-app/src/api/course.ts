import { http } from '@/utils/request'
import type { Course, Semester } from '@/types'

/** 热门课程（按选课人数排序） */
export interface PopularCourse {
  courseId: number
  courseName: string
  teacherName?: string
  weekDay: number
  selectedCount: number
}

/** 学生看板数据 */
export interface StudentDashboard {
  selectionCount?: number
  pendingEvaluationCount?: number
  coursesToEvaluate?: unknown[]
  popularCourses?: PopularCourse[]
}

export function getStudentDashboard() {
  return http.get<StudentDashboard>('/course/dashboard/student')
}

export interface CourseListParams {
  pageNum?: number
  pageSize?: number
  courseName?: string
  weekDay?: number | string
  semesterId?: number | string
  classId?: number | string
  gradeId?: number | string
}

/** 当前学生信息（含班级、年级，用于按班级显示名额、按年级筛选课程） */
export interface CurrentStudent {
  id: number
  classId?: number
  className?: string
  gradeId?: number
  gradeName?: string
}

export function getCurrentStudent() {
  return http.get<CurrentStudent>('/course/student/me')
}

export function getCurrentSemester() {
  return http.get<Semester>('/course/semester/current')
}

export function getCourseList(params?: CourseListParams) {
  return http.get<{ rows: Course[]; total: number }>('/course/course/list', params as Record<string, any>)
}

export function getCourseDetail(id: string | number) {
  return http.get<Course>(`/course/course/${id}`)
}
