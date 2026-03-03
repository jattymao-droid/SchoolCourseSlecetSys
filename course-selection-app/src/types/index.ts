/** 统一接口响应结构 */
export interface ApiResponse<T = any> {
  code: number
  msg: string
  data: T
}

/** 分页响应结构（RuoYi 格式） */
export interface PageResult<T = any> {
  rows: T[]
  total: number
  code: number
  msg: string
}

/** 登录响应 */
export interface LoginResult {
  token: string
}

/** 用户信息 */
export interface UserInfo {
  userId: number | string
  userName: string
  nickName: string
  userType: string
  studentId?: string
  className?: string
  gradeId?: number | string
  classId?: number | string
  avatar?: string
}

/** 学期 */
export interface Semester {
  id: string | number
  semesterName: string
  startDate: string
  endDate: string
  isCurrent: number
  selectionStartTime?: string
  selectionEndTime?: string
}

/** 课程 */
export interface Course {
  id: string | number
  courseName: string
  teacherName?: string
  weekDay: number        // 1=周一 ... 5=周五
  weekDayLabel?: string
  gradeName?: string     // 适用年级
  location?: string
  description?: string
  quota?: number         // 按班级时可能为空
  selected?: number
  totalQuota?: number    // 后端总容量
  selectedCount?: number // 后端已选人数
  remaining?: number
  /** 班级名额列表（详情接口返回，含 classId 用于按班级展示） */
  quotaList?: { classId?: number; quota?: number; selected?: number }[]
  semesterId: string | number
  semesterName?: string
  category?: string
  coverColor?: string    // 前端展示用随机背景色
}

/** 选课车条目 */
export interface CartItem {
  courseId: string | number
  courseName: string
  teacherName?: string
  weekDay: number
  location?: string
  /** 是否管理员指定（不可删除） */
  assigned?: boolean
}

/** 选课车（按 weekDay 分组） */
export type CartMap = Record<number, CartItem | null>  // key: 1~5

/** 选课记录 */
export interface Selection {
  id: string | number
  courseId: string | number
  courseName: string
  teacherName?: string
  weekDay: number
  weekDayLabel?: string
  location?: string
  semesterId: string | number
  semesterName?: string
  status: number
  createTime?: string
}

/** 评价题目 */
export interface EvaQuestion {
  id: string | number
  questionName: string
  description?: string
  minScore: number
  maxScore: number
  status: number
}

/** 待评价课程 */
export interface PendingEvaluation {
  selectionId: string | number
  courseId: string | number
  courseName: string
  teacherName?: string
  weekDay: number
  weekDayLabel?: string
  evaluated: boolean
  questions?: EvaQuestion[]
}

/** 评价提交参数 */
export interface EvaluationSubmit {
  courseId: string | number
  scores: { questionId: string | number; score: number }[]
}

/** 个人资料 */
export interface UserProfile extends UserInfo {
  phonenumber?: string
  email?: string
}
