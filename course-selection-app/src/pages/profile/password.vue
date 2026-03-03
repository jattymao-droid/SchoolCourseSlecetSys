<template>
  <view class="pwd-page pad-container">
    <view class="pwd-form card">
      <view class="form-item" :class="{ error: errors.oldPassword }">
        <text class="field-label">原密码</text>
        <view class="input-wrap">
          <input
            v-model="form.oldPassword"
            class="input"
            :password="!show.old"
            placeholder="请输入原密码"
            placeholder-class="input-ph"
          />
          <text class="eye" @click="show.old = !show.old">{{ show.old ? '👁' : '🙈' }}</text>
        </view>
        <text v-if="errors.oldPassword" class="err-msg">{{ errors.oldPassword }}</text>
      </view>

      <view class="form-item" :class="{ error: errors.newPassword }">
        <text class="field-label">新密码</text>
        <view class="input-wrap">
          <input
            v-model="form.newPassword"
            class="input"
            :password="!show.new"
            placeholder="请输入新密码（至少 6 位）"
            placeholder-class="input-ph"
          />
          <text class="eye" @click="show.new = !show.new">{{ show.new ? '👁' : '🙈' }}</text>
        </view>
        <text v-if="errors.newPassword" class="err-msg">{{ errors.newPassword }}</text>
      </view>

      <view class="form-item" :class="{ error: errors.confirmPassword }">
        <text class="field-label">确认新密码</text>
        <view class="input-wrap">
          <input
            v-model="form.confirmPassword"
            class="input"
            :password="!show.confirm"
            placeholder="请再次输入新密码"
            placeholder-class="input-ph"
          />
          <text class="eye" @click="show.confirm = !show.confirm">{{ show.confirm ? '👁' : '🙈' }}</text>
        </view>
        <text v-if="errors.confirmPassword" class="err-msg">{{ errors.confirmPassword }}</text>
      </view>

      <button class="btn-primary submit-btn" :loading="loading" :disabled="loading" @click="handleSubmit">
        确认修改
      </button>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { updatePassword } from '@/api/auth'
import { useAuthStore } from '@/stores/auth'

const authStore = useAuthStore()
const loading = ref(false)

const form = reactive({ oldPassword: '', newPassword: '', confirmPassword: '' })
const errors = reactive({ oldPassword: '', newPassword: '', confirmPassword: '' })
const show = reactive({ old: false, new: false, confirm: false })

function validate() {
  let valid = true
  errors.oldPassword = form.oldPassword ? '' : '请输入原密码'
  if (!form.oldPassword) valid = false

  if (!form.newPassword || form.newPassword.length < 6) {
    errors.newPassword = '新密码不能少于 6 位'
    valid = false
  } else { errors.newPassword = '' }

  if (form.newPassword !== form.confirmPassword) {
    errors.confirmPassword = '两次输入的密码不一致'
    valid = false
  } else { errors.confirmPassword = '' }

  return valid
}

async function handleSubmit() {
  if (!validate()) return
  loading.value = true
  try {
    await updatePassword(form.oldPassword, form.newPassword)
    uni.showModal({
      title: '修改成功',
      content: '密码已修改，请重新登录',
      showCancel: false,
      success: () => authStore.logout()
    })
  } finally {
    loading.value = false
  }
}
</script>

<style lang="scss" scoped>
.pwd-page { background: #f6f7f8; min-height: 100vh; padding: 32rpx; }
.pwd-form { padding: 40rpx; }

.form-item {
  margin-bottom: 32rpx;
  &.error .input-wrap { border-color: #ef4444; }
}

.field-label { display: block; font-size: 26rpx; color: #4c739a; margin-bottom: 12rpx; font-weight: 500; }

.input-wrap {
  display: flex;
  align-items: center;
  background: #f8fafc;
  border: 2rpx solid #e2e8f0;
  border-radius: 12rpx;
  padding: 0 24rpx;
  height: 96rpx;
  &:focus-within { border-color: #137fec; background: #fff; }
}

.input { flex: 1; height: 96rpx; font-size: 30rpx; background: transparent; color: #0d141b; }
.input-ph { color: #94a3b8; }
.eye { font-size: 36rpx; margin-left: 16rpx; cursor: pointer; }
.err-msg { display: block; font-size: 24rpx; color: #ef4444; margin-top: 8rpx; padding-left: 8rpx; }

.submit-btn { margin-top: 16rpx; height: 96rpx; line-height: 96rpx; }

/* Pad 适配 */
@media (min-width: 768px) {
  .pwd-page { padding: 48rpx; }
  .pwd-form { max-width: 480px; margin: 0 auto; }
}
</style>
