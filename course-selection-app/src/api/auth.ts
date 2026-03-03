import { http } from '@/utils/request'
import type { UserProfile } from '@/types'

// ---------- 验证码 ----------
export interface CaptchaResult {
  captchaEnabled: boolean
  uuid: string
  img: string
}

export function getCaptcha() {
  // 响应: { code, captchaEnabled, uuid, img } — 字段在根上
  return http.getBody<CaptchaResult>('/captchaImage')
}

// ---------- 登录 ----------
export interface LoginRawResult {
  code: number
  msg: string
  token: string
}

export function login(username: string, password: string, code: string, uuid: string) {
  // 响应: { code, token } — token 在根上
  return http.postBody<LoginRawResult>('/login', { username, password, code, uuid })
}

// ---------- 用户信息 ----------
export interface GetInfoResult {
  code: number
  user: UserProfile
  roles: string[]
  permissions: string[]
}

export function getUserInfo() {
  // 响应: { code, user, roles, permissions } — user 在根上
  return http.getBody<GetInfoResult>('/getInfo')
}

// ---------- 修改密码 ----------
export function updatePassword(oldPassword: string, newPassword: string) {
  return http.put('/system/user/profile/updatePwd', { oldPassword, newPassword })
}

// ---------- 退出登录 ----------
export function logout() {
  return http.post('/logout')
}
