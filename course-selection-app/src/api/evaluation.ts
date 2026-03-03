import { http } from '@/utils/request'

export interface QuestionVO {
  questionId: number | string
  content: string
  score?: number
}

export interface CourseToEvaluateVO {
  courseId: number | string
  courseName: string
  weekDay: number
  teacherName?: string
  semesterId: number | string
  questions: QuestionVO[]
  evaluated: boolean
}

export interface EvaluationSubmit {
  courseId: number | string
  semesterId: number | string
  scores: { questionId: number | string; score: number }[]
}

export function getPendingEvaluations(semesterId: string | number) {
  return http.get<CourseToEvaluateVO[]>('/course/evaluation/my/courses', { semesterId })
}

export function submitEvaluation(data: EvaluationSubmit) {
  return http.post('/course/evaluation/my/submit', data as unknown as Record<string, any>)
}
