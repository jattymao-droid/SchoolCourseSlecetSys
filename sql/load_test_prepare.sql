-- 压力测试前置：关闭登录验证码
-- 执行此脚本后，load-test 可自动登录，无需验证码
-- 测试完成后建议改回 true

UPDATE sys_config
SET config_value = 'false'
WHERE config_key = 'sys.account.captchaEnabled';

-- 验证
SELECT config_key, config_value FROM sys_config WHERE config_key = 'sys.account.captchaEnabled';
