import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { getCart, addToCart, removeFromCart, clearCart, submitCart } from '@/api/cart'
import { getMySelections } from '@/api/selection'
import { getCurrentSemester } from '@/api/course'
import type { Semester } from '@/types'

export interface CartItem {
  courseId: number | string
  courseName: string
  weekDay: number
  teacherName?: string
  className?: string
  semesterId?: number | string
  /** 是否管理员指定（不可删除） */
  assigned?: boolean
}

const WEEK_DAYS = [1, 2, 3, 4, 5]

export const useCartStore = defineStore('cart', () => {
  // 后端返回 Map<Integer, CartItemVO>，key 为 weekDay 字符串，值为 CartItemVO 或 null
  const cartMap = ref<Record<number, CartItem | null>>({ 1: null, 2: null, 3: null, 4: null, 5: null })
  const mySelectionCourseIds = ref<Set<string>>(new Set())
  const loading = ref(false)
  const submitting = ref(false)
  const currentSemesterId = ref<string | number>('')
  const currentSemester = ref<Semester | null>(null)

  const selectedCount = computed(() =>
    WEEK_DAYS.filter(d => cartMap.value[d] !== null).length
  )
  const isComplete = computed(() => selectedCount.value === 5)
  const badgeText = computed(() => selectedCount.value > 0 ? `${selectedCount.value}` : '')

  /** 加载当前学期并更新 store（用于确保选课时间等数据可用） */
  async function loadSemester() {
    try {
      const sem = await getCurrentSemester()
      if (sem?.id) {
        currentSemesterId.value = sem.id
        currentSemester.value = sem
        await fetchCart(sem.id, sem)
        return sem
      }
    } catch {
      // 静默失败
    }
    return null
  }

  async function fetchCart(semesterId?: string | number, semester?: Semester) {
    if (semesterId) currentSemesterId.value = semesterId
    if (semester) currentSemester.value = semester
    const sid = currentSemesterId.value
    if (!sid) return
    loading.value = true
    try {
      const [cartData, myList] = await Promise.all([
        getCart(sid),
        getMySelections(sid).catch(() => [])
      ])
      const map: Record<number, CartItem | null> = { 1: null, 2: null, 3: null, 4: null, 5: null }
      if (cartData && typeof cartData === 'object') {
        WEEK_DAYS.forEach(d => {
          const item = (cartData as Record<string, unknown>)[String(d)]
          map[d] = (item && typeof item === 'object') ? (item as CartItem) : null
        })
      }
      cartMap.value = map
      const ids = new Set<string>()
      const raw = myList as Record<string, unknown> | unknown[] | null | undefined
      const list = Array.isArray(raw)
        ? raw
        : (raw && typeof raw === 'object' && Array.isArray((raw as Record<string, unknown>).rows)
          ? ((raw as Record<string, unknown>).rows as unknown[])
          : [])
      list.forEach((s: { courseId?: string | number }) => {
        if (s?.courseId != null) ids.add(String(s.courseId))
      })
      mySelectionCourseIds.value = ids
    } finally {
      loading.value = false
    }
  }

  async function add(courseId: string | number) {
    await addToCart(currentSemesterId.value, courseId)
    await fetchCart()
  }

  // 后端 removeFromCart 参数是 weekDay，不是 courseId
  async function removeByWeekDay(weekDay: number) {
    await removeFromCart(currentSemesterId.value, weekDay)
    cartMap.value[weekDay] = null
  }

  async function clear() {
    await clearCart(currentSemesterId.value)
    await fetchCart()
  }

  async function submit() {
    submitting.value = true
    try {
      const result = await submitCart(currentSemesterId.value)
      cartMap.value = { 1: null, 2: null, 3: null, 4: null, 5: null }
      return result
    } finally {
      submitting.value = false
    }
  }

  function hasWeekDay(weekDay: number) {
    return cartMap.value[weekDay] !== null
  }

  function getByWeekDay(weekDay: number) {
    return cartMap.value[weekDay]
  }

  /** 课程是否已选（含选课车或已提交选课） */
  function isCourseSelected(courseId: string | number) {
    const id = String(courseId)
    return mySelectionCourseIds.value.has(id) ||
      WEEK_DAYS.some(d => cartMap.value[d] != null && String(cartMap.value[d]!.courseId) === id)
  }

  /** 从后端返回的 cart 数据直接更新 store（退课后使用） */
  function setCartFromData(data: Record<string, unknown> | null) {
    const map: Record<number, CartItem | null> = { 1: null, 2: null, 3: null, 4: null, 5: null }
    if (data && typeof data === 'object') {
      WEEK_DAYS.forEach(d => {
        const item = (data as Record<string, unknown>)[String(d)]
        map[d] = (item && typeof item === 'object') ? (item as CartItem) : null
      })
    }
    cartMap.value = map
  }

  return {
    cartMap, loading, submitting, currentSemesterId, currentSemester,
    selectedCount, isComplete, badgeText,
    loadSemester, fetchCart, add, removeByWeekDay, clear, submit, hasWeekDay, getByWeekDay, setCartFromData,
    isCourseSelected
  }
})
