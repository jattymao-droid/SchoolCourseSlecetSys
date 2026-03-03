import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { login as loginApi, getUserInfo, logout as logoutApi } from '@/api/auth'
import type { UserProfile } from '@/types'

export const useAuthStore = defineStore('auth', () => {
  const token = ref<string>(uni.getStorageSync('token') || '')
  const userInfo = ref<UserProfile | null>(
    (() => {
      const stored = uni.getStorageSync('userInfo')
      return stored ? JSON.parse(stored) : null
    })()
  )

  const isLoggedIn = computed(() => !!token.value)
  const studentName = computed(() => userInfo.value?.nickName || userInfo.value?.userName || '')
  const className = computed(() => userInfo.value?.className || '')

  async function login(username: string, password: string, code: string, uuid: string) {
    const res = await loginApi(username, password, code, uuid)
    // /login 返回 { code: 200, token: "eyJ..." }
    if (!res.token) throw new Error('登录失败，未获取到 token')
    token.value = res.token
    uni.setStorageSync('token', res.token)
    await fetchUserInfo()
  }

  async function fetchUserInfo() {
    // /getInfo 返回 { code: 200, user: {...}, roles: [...], permissions: [...] }
    const res = await getUserInfo()
    const user = res.user || (res as any)
    userInfo.value = user
    uni.setStorageSync('userInfo', JSON.stringify(user))
  }

  async function logout() {
    try { await logoutApi() } catch {}
    token.value = ''
    userInfo.value = null
    uni.removeStorageSync('token')
    uni.removeStorageSync('userInfo')
    uni.reLaunch({
      url: '/pages/login/index',
      fail: () => { uni.navigateTo({ url: '/pages/login/index' }) }
    })
  }

  return { token, userInfo, isLoggedIn, studentName, className, login, fetchUserInfo, logout }
})
