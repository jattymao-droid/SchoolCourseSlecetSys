<template>
  <div class="sidebar-logo-container" :class="{ 'collapse': collapse }">
    <transition name="sidebarLogoFade">
      <router-link v-if="collapse" key="collapse" class="sidebar-logo-link" to="/">
        <img v-if="logo" :src="logo" class="sidebar-logo" />
        <h1 v-else class="sidebar-title">{{ title }}</h1>
      </router-link>
      <router-link v-else key="expand" class="sidebar-logo-link" to="/">
        <div class="school-logo-wrapper">
          <div class="logo-decoration-ring">
            <div class="logo-decoration-inner">
              <img v-if="logo" :src="logo" class="sidebar-logo" />
            </div>
          </div>
          <div class="title-wrapper">
            <span class="school-name">会泽县东陆高中</span>
            <div class="divider-decoration">
              <span class="dot left"></span>
              <span class="line"></span>
              <span class="dot right"></span>
            </div>
            <span class="system-name">选修课选课系统</span>
          </div>
        </div>
      </router-link>
    </transition>
  </div>
</template>

<script setup>
import logo from '@/assets/logo/logo.png'
import useSettingsStore from '@/store/modules/settings'
import variables from '@/assets/styles/variables.module.scss'

defineProps({
  collapse: {
    type: Boolean,
    required: true
  }
})

const title = '东陆选课系统'
const settingsStore = useSettingsStore()
const sideTheme = computed(() => settingsStore.sideTheme)

// 获取Logo背景色
const getLogoBackground = computed(() => {
  if (settingsStore.isDark) {
    return 'var(--sidebar-bg)'
  }
  if (settingsStore.navType == 3) {
    return variables.menuLightBg
  }
  return sideTheme.value === 'theme-dark' ? variables.menuBg : variables.menuLightBg
})

// 获取Logo文字颜色
const getLogoTextColor = computed(() => {
  if (settingsStore.isDark) {
    return 'var(--sidebar-text)'
  }
  if (settingsStore.navType == 3) {
    return variables.menuLightText
  }
  return sideTheme.value === 'theme-dark' ? variables.menuText : variables.menuLightText
})
</script>

<style lang="scss" scoped>
.sidebarLogoFade-enter-active {
  transition: opacity 1.5s;
}

.sidebarLogoFade-enter,
.sidebarLogoFade-leave-to {
  opacity: 0;
}

.sidebar-logo-container {
  position: relative;
  height: 140px;
  background: v-bind(getLogoBackground);
  text-align: center;
  overflow: hidden;
  border-bottom: 1px solid rgba(79, 70, 229, 0.08);
  box-shadow: 0 2px 8px rgba(79, 70, 229, 0.06);

  & .sidebar-logo-link {
    height: 100%;
    width: 100%;
    display: flex !important;
    align-items: center;
    justify-content: center;
    padding: 0 16px;
    overflow: visible !important;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    text-decoration: none;

    &:hover {
      background: linear-gradient(180deg, rgba(251, 191, 36, 0.02) 0%, rgba(251, 191, 36, 0.05) 100%);
      
      .sidebar-logo {
        transform: scale(1.05);
        filter: drop-shadow(0 4px 12px rgba(251, 191, 36, 0.25));
      }
    }

    .school-logo-wrapper {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 10px;
      position: relative;
    }

    .logo-decoration-ring {
      width: 54px;
      height: 54px;
      border-radius: 50%;
      background: linear-gradient(135deg, rgba(251, 191, 36, 0.15) 0%, rgba(251, 191, 36, 0.05) 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      border: 1px solid rgba(251, 191, 36, 0.1);
      box-shadow: 0 4px 12px rgba(251, 191, 36, 0.08);

      &::before {
        content: '';
        position: absolute;
        top: -3px;
        left: -3px;
        right: -3px;
        bottom: -3px;
        border-radius: 50%;
        border: 1.5px dashed rgba(251, 191, 36, 0.2);
        animation: rotate 20s linear infinite;
      }
    }

    .logo-decoration-inner {
      width: 44px;
      height: 44px;
      border-radius: 50%;
      background: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: inset 0 2px 4px rgba(217, 119, 6, 0.05);
      border: 1px solid rgba(251, 191, 36, 0.05);
      z-index: 1;
    }

    & .sidebar-logo {
      width: 32px;
      height: 32px;
      vertical-align: middle;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .title-wrapper {
      display: flex;
      flex-direction: column;
      align-items: center;
      line-height: 1.2;
    }

    .school-name {
      font-size: 16px;
      font-weight: 800;
      color: v-bind(getLogoTextColor);
      letter-spacing: 1.5px;
      text-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    .divider-decoration {
      display: flex;
      align-items: center;
      width: 100%;
      margin: 4px 0;
      opacity: 0.8;

      .line {
        flex: 1;
        height: 1px;
        background: linear-gradient(90deg, transparent, rgba(251, 191, 36, 0.5), transparent);
      }

      .dot {
        width: 3px;
        height: 3px;
        border-radius: 50%;
        background: rgba(251, 191, 36, 0.8);
      }
    }

    .system-name {
      font-size: 11px;
      color: v-bind(getLogoTextColor);
      opacity: 0.85;
      font-weight: 600;
      letter-spacing: 3px;
      text-transform: uppercase;
      padding: 0 4px;
    }

    & .sidebar-title {
      display: inline-block;
      margin: 0;
      color: v-bind(getLogoTextColor);
      font-weight: 600;
      line-height: 50px;
      font-size: 14px;
      font-family: Avenir, Helvetica Neue, Arial, Helvetica, sans-serif;
      vertical-align: middle;
    }
  }

  &.collapse {
    height: 60px; // 收起时保持默认高度
    
    .sidebar-logo {
      margin-right: 0px;
      width: 32px;
      height: 32px;
    }
    
    .school-logo-wrapper {
      flex-direction: row;
      gap: 0;
    }

    .logo-decoration-ring {
      width: 40px;
      height: 40px;
      background: transparent;
      border: none;
      box-shadow: none;

      &::before { display: none; }
    }

    .logo-decoration-inner {
      width: 36px;
      height: 36px;
      background: transparent;
      border: none;
      box-shadow: none;
    }
    
    .title-wrapper {
      display: none;
    }
    
    .sidebar-title {
      display: none;
    }
  }
}

@keyframes rotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
</style>