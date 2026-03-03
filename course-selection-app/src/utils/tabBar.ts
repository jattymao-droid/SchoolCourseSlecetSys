/** 安全隐藏原生 tabBar，仅在 tabBar 页面有效，非 tabBar 页面会静默忽略 */
export function safeHideTabBar() {
  uni.hideTabBar({
    animation: false,
    fail: () => {
      // 非 tabBar 页面（如登录页）调用会失败，静默忽略
    }
  })
}
