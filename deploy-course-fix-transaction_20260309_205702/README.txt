课程导入事务错误修复 - 部署包
========================================

修复内容:
修复了云服务器上导入课程时的PostgreSQL事务错误

代码修改:
修改了 CourseServiceImpl.java 中的事务处理，将查询方法设置为非事务执行

部署步骤:
1. 上传到服务器: scp course-fix-transaction_20260309_205702.zip root@your-server:/tmp/
2. SSH登录: ssh root@your-server
3. 解压: cd /tmp && unzip course-fix-transaction_20260309_205702.zip && cd deploy-course-fix-transaction_20260309_205702
4. 部署: chmod +x deploy.sh && ./deploy.sh
5. 验证: tail -f /www/wwwroot/course-selection/logs/backend.log

文件清单:
- backend/ruoyi-admin.jar (83.28 MB)
- deploy.sh (自动部署脚本)
- README.txt (本文档)
- docs/ (详细文档)

版本信息:
- 修复版本: v1.1
- 创建日期: 2026-03-09 20:57
- JAR大小: 83.28 MB
- JAR编译时间: 2026-03-09 20:51

回滚方案:
如果部署后出现问题，可以快速回滚:
1. 停止后端: pkill -f ruoyi-admin.jar
2. 恢复备份: cp /www/wwwroot/course-selection/backups/ruoyi-admin.jar.backup_YYYYMMDD_HHMMSS /www/wwwroot/course-selection/backend/ruoyi-admin.jar
3. 启动后端: cd /www/wwwroot/course-selection/backend && nohup java -jar ruoyi-admin.jar --spring.profiles.active=druid,prod > /www/wwwroot/course-selection/logs/backend.log 2>&1 &
