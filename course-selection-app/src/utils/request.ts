import type { ApiResponse } from '@/types'

// H5: 走 /api 前缀 → Vite 代理（开发）/ Nginx 代理（部署），无 CORS 问题
// 非 H5（微信小程序/App）: 直连后端，需确保后端已启动；真机调试时改为本机 IP
// 微信小程序需在开发者工具勾选：详情 → 本地设置 → 不校验合法域名
const BASE_URL = ((): string => {
  // #ifdef H5
  return '/api'
  // #endif
  // #ifdef MP-WEIXIN
  return 'http://127.0.0.1:8080'
  // #endif
  // #ifndef H5 || MP-WEIXIN
  return (import.meta.env.VITE_API_BASE_URL as string) || 'http://127.0.0.1:8080'
  // #endif
})()

type Method = 'GET' | 'POST' | 'PUT' | 'DELETE'

interface RequestOptions {
  url: string
  method?: Method
  data?: Record<string, any>
  params?: Record<string, any>
  showLoading?: boolean
}

function buildQuery(params?: Record<string, any>): string {
  if (!params) return ''
  const query = Object.entries(params)
    .filter(([, v]) => v !== undefined && v !== null && v !== '')
    .map(([k, v]) => `${encodeURIComponent(k)}=${encodeURIComponent(v)}`)
    .join('&')
  return query ? `?${query}` : ''
}

function getToken(): string {
  return uni.getStorageSync('token') || ''
}

let redirecting = false
function redirectLogin() {
  if (redirecting) return
  const pages = getCurrentPages()
  const last = pages[pages.length - 1] as any
  if (last?.route === 'pages/login/index') return
  redirecting = true
  uni.removeStorageSync('token')
  uni.removeStorageSync('userInfo')
  const goLogin = () => {
    uni.reLaunch({
      url: '/pages/login/index',
      fail: () => {
        uni.redirectTo({ url: '/pages/login/index' })
      },
      complete: () => { redirecting = false }
    })
  }
  goLogin()
}

export function request<T = any>(options: RequestOptions): Promise<T> {
  const { url, method = 'GET', data, params, showLoading = false } = options
  const fullUrl = BASE_URL + url + buildQuery(params)
  const token = getToken()

  if (showLoading) {
    uni.showLoading({ title: '加载中...', mask: true })
  }

  return new Promise((resolve, reject) => {
    uni.request({
      url: fullUrl,
      method,
      data,
      header: {
        'Content-Type': 'application/json',
        ...(token ? { Authorization: `Bearer ${token}` } : {})
      },
      success(res) {
        if (showLoading) uni.hideLoading()
        const body = res.data as ApiResponse<T>

        if (res.statusCode === 401) {
          redirectLogin()
          return reject(new Error('登录已过期，请重新登录'))
        }
        if (res.statusCode !== 200) {
          uni.showToast({ title: body?.msg || '请求失败', icon: 'none' })
          return reject(new Error(body?.msg || '请求失败'))
        }
        if (body.code === 200) {
          // RuoYi TableDataInfo 将 rows/total 放在根级，非 data 下
          const b = body as unknown as Record<string, unknown>
          const data = b.data !== undefined
            ? b.data
            : (b.rows !== undefined ? { rows: b.rows, total: (b.total as number) ?? 0 } : body)
          resolve(data as T)
        } else if (body.code === 401) {
          redirectLogin()
          reject(new Error('未登录'))
        } else {
          uni.showToast({ title: body.msg || '操作失败', icon: 'none' })
          reject(new Error(body.msg || '操作失败'))
        }
      },
      fail(err) {
        if (showLoading) uni.hideLoading()
        uni.showToast({ title: '网络连接失败', icon: 'none' })
        reject(err)
      }
    })
  })
}

export const http = {
  get<T = any>(url: string, params?: Record<string, any>) {
    return request<T>({ url, method: 'GET', params })
  },
  post<T = any>(url: string, data?: Record<string, any>, params?: Record<string, any>) {
    return request<T>({ url, method: 'POST', data, params })
  },
  put<T = any>(url: string, data?: Record<string, any>) {
    return request<T>({ url, method: 'PUT', data })
  },
  delete<T = any>(url: string, params?: Record<string, any>) {
    return request<T>({ url, method: 'DELETE', params })
  },
  /**
   * 返回完整响应体（RuoYi AjaxResult 将字段直接挂在根对象上的接口）
   * 例如 /captchaImage → { code, captchaEnabled, uuid, img }
   *      /login        → { code, token }
   *      /getInfo      → { code, user, roles, permissions }
   */
  getBody<T = any>(url: string, params?: Record<string, any>): Promise<T> {
    return rawRequest<T>('GET', url, undefined, params)
  },

  postBody<T = any>(url: string, data?: Record<string, any>): Promise<T> {
    return rawRequest<T>('POST', url, data)
  }
}

function rawRequest<T>(method: Method, url: string, data?: Record<string, any>, params?: Record<string, any>): Promise<T> {
  const fullUrl = BASE_URL + url + buildQuery(params)
  const token = getToken()
  return new Promise((resolve, reject) => {
    uni.request({
      url: fullUrl,
      method,
      data,
      header: {
        'Content-Type': 'application/json',
        ...(token ? { Authorization: `Bearer ${token}` } : {})
      },
      success(res) {
        const body = res.data as any
        if (res.statusCode === 200 && (body?.code === 200 || body?.code === undefined)) {
          resolve(body as T)
        } else if (body?.code === 401) {
          redirectLogin()
          reject(new Error('未登录'))
        } else {
          const msg = body?.msg || `请求失败(${res.statusCode})`
          uni.showToast({ title: msg, icon: 'none' })
          reject(new Error(msg))
        }
      },
      fail(err) {
        uni.showToast({ title: '网络连接失败', icon: 'none' })
        reject(err)
      }
    })
  })
}
