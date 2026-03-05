import { defineConfig } from 'vite'
import uni from '@dcloudio/vite-plugin-uni'

// 部署到 /h5/ 子路径时设置 base，本地开发为 /
export default defineConfig({
  base: process.env.VITE_BASE_PATH || '/',
  plugins: [uni()],
  server: {
    port: 5173,
    proxy: {
      // H5 开发时所有 /api 请求代理到后端，消除 CORS 跨域问题
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '')
      }
    }
  }
})
