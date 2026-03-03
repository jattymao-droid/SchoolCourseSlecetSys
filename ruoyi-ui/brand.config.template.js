/**
 * 品牌定制化配置模板
 * 复制此文件为 brand.config.js 并修改配置项
 */

export default {
  // ========== 主题色配置 ==========
  theme: {
    // 主色调 - 用于按钮、链接、选中状态等主要交互元素
    primaryColor: '#4F46E5', // 靛蓝色（默认）
    
    // 辅助色 - 用于悬停状态、次要按钮等辅助交互元素
    secondaryColor: '#6366F1', // 浅靛蓝色（默认）
    
    // 成功色
    successColor: '#10B981', // 翠绿色
    
    // 警告色
    warningColor: '#F59E0B', // 琥珀色
    
    // 危险色
    dangerColor: '#EF4444', // 红色
    
    // 信息色
    infoColor: '#6B7280', // 灰色
  },

  // ========== Logo 配置 ==========
  logo: {
    // 侧边栏 Logo 图片路径（相对于 src/assets/ 目录）
    sidebarLogo: 'logo/logo.png',
    
    // 登录页 Logo 图片路径（如果不设置，使用 sidebarLogo）
    loginLogo: '',
    
    // Logo 尺寸配置
    size: {
      sidebar: { width: '36px', height: '36px' },
      login: { width: '48px', height: '48px' }
    }
  },

  // ========== 系统标题配置 ==========
  title: {
    // 系统名称（显示在侧边栏、浏览器标签页、登录页）
    systemName: '东陆高中选修课管理系统',
    
    // 简短名称（侧边栏收起时显示）
    shortName: '选课系统',
    
    // 登录页标题
    loginTitle: '欢迎使用选修课管理系统'
  },

  // ========== 登录页配置 ==========
  login: {
    // 背景配置（支持图片路径或纯色值）
    background: {
      type: 'gradient', // 'image' | 'color' | 'gradient'
      value: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)'
      // 如果 type 为 'image'，value 为图片路径：'@/assets/images/login-bg.jpg'
      // 如果 type 为 'color'，value 为颜色值：'#F8FAFC'
    },
    
    // 左侧特色区配置
    feature: {
      // 品牌名称
      brandName: '东陆高中',
      
      // 主标题
      heroTitle: '选修课规划',
      heroSubtitle: '开启志趣之窗',
      
      // 描述文字
      description: 'Discover your passion through our diverse elective programs.',
      
      // 流程步骤
      steps: [
        { num: '01', text: '身份认证登录' },
        { num: '02', text: '查阅选课方案' },
        { num: '03', text: '勾选志趣课程' },
        { num: '04', text: '提交确认成功' }
      ],
      
      // 公告内容
      notice: {
        tag: '最新公告',
        content: [
          '1. 2026学年春季选修课通道将于3月1日正式开启。',
          '2. 请各位同学提前在"查阅方案"中了解课程学分要求。'
        ]
      }
    }
  },

  // ========== 侧边栏配置 ==========
  sidebar: {
    // 主题模式：'light' | 'dark'
    theme: 'light',
    
    // 宽度
    width: '200px',
    
    // 背景渐变
    background: 'linear-gradient(180deg, #F8FAFC 0%, #F1F5F9 100%)',
    
    // 菜单项样式
    menu: {
      textColor: '#64748B',
      activeTextColor: '#4F46E5',
      hoverBackground: 'linear-gradient(90deg, #EEF2FF 0%, #E0E7FF 100%)',
      activeBackground: 'linear-gradient(90deg, #EEF2FF 0%, #E0E7FF 100%)'
    }
  },

  // ========== 导航栏配置 ==========
  navbar: {
    // 高度
    height: '60px',
    
    // 背景
    background: 'linear-gradient(135deg, #FFFFFF 0%, #F8FAFC 100%)',
    
    // 文字颜色
    textColor: '#64748B',
    
    // 悬停颜色
    hoverColor: '#4F46E5'
  },

  // ========== 底部版权配置 ==========
  footer: {
    visible: true,
    content: 'Copyright © 2026 东陆高中. All Rights Reserved.'
  },

  // ========== 高级配置 ==========
  advanced: {
    // 是否启用圆角设计
    borderRadius: true,
    
    // 圆角大小
    borderRadiusSize: '8px',
    
    // 是否启用阴影效果
    boxShadow: true,
    
    // 是否启用动画效果
    animation: true,
    
    // 动画持续时间
    animationDuration: '0.3s',
    
    // 动画缓动函数
    animationTimingFunction: 'cubic-bezier(0.4, 0, 0.2, 1)'
  }
}
