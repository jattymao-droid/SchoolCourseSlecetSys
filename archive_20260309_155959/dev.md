基于 RuoYi-Vue3 的学生选修课选课系统开发方案

1. 项目概述
本项目基于 RuoYi-Vue3 框架（若依前后端分离 Vue3 版）进行二次开发，数据库采用 PostgreSQL，构建一套面向学校的学生选修课选课系统。系统分为管理员端和学生端，涵盖学期管理、年级班级管理、学生管理、课程管理、选课车机制、课程评价等功能。

核心业务流程：

管理员维护基础数据（学期、年级班级、学生、课程、课程班级容量、评价配置）。

学生使用学号+密码登录，在指定学期内进行选课：采用“选课车”模式，必须为周一至周五每天选择一门课（不能多选、不能少选），满足条件后方可提交。提交后生成正式选课记录。

学生可退课：退课时将已选课程全部移回选课车，释放名额，学生可调整选课车后再次提交。

课程评价：管理员可启动/停止评价，学生按评价内容对所选课程打分。

2. 技术栈
前端：Vue 3 + Element Plus + Vite（RuoYi-Vue3 默认栈）

后端：Spring Boot 2.x + Spring Security + JWT + MyBatis + PageHelper + Redis

数据库：PostgreSQL 12+（使用 PostgreSQL 方言，主键采用雪花算法 ID）

工具：EasyExcel（学生导入导出）、Maven、Redis（选课车缓存/并发控制）

部署：Nginx + Jar

利用 RuoYi 代码生成器快速构建基础 CRUD，再根据业务定制复杂逻辑。代码生成器需配置 PostgreSQL 数据源，并调整模板以适配 PostgreSQL 语法（如分页使用 LIMIT）。

3. 数据库设计（PostgreSQL 适配）
3.1 通用说明
所有表主键使用 雪花算法 ID（RuoYi 默认 @TableId(type = IdType.ASSIGN_ID)），对应 PostgreSQL 字段类型 int8（bigint）。

逻辑删除字段 del_flag 统一使用 char(1) 或 int2（smallint），默认 '0' 表示未删除。

时间字段使用 timestamp 类型。

布尔类型字段可使用 boolean 或 int2，本方案采用 int2（0/1）以兼容 RuoYi 原有习惯。

分页查询时，MyBatis 通过 PageHelper 自动生成 LIMIT ? OFFSET ? 语法。

3.2 主要表结构
3.2.1 学期表 (sys_semester)
sql
CREATE TABLE sys_semester (
    id bigint PRIMARY KEY,
    semester_name varchar(50) NOT NULL,
    start_date date,
    end_date date,
    is_current smallint DEFAULT 0,  -- 0否 1是
    del_flag char(1) DEFAULT '0',
    create_time timestamp,
    create_by varchar(64),
    update_time timestamp,
    update_by varchar(64)
);
COMMENT ON COLUMN sys_semester.is_current IS '是否当前学期';
3.2.2 年级表 (sys_grade)
sql
CREATE TABLE sys_grade (
    id bigint PRIMARY KEY,
    grade_name varchar(50) NOT NULL,
    sort int,                        -- 排序（用于一键升级逻辑）
    del_flag char(1) DEFAULT '0',
    create_time timestamp
);
3.2.3 班级表 (sys_class)
sql
CREATE TABLE sys_class (
    id bigint PRIMARY KEY,
    class_name varchar(50) NOT NULL,
    grade_id bigint NOT NULL,
    del_flag char(1) DEFAULT '0',
    create_time timestamp
);
3.2.4 学生表
复用 RuoYi 的 sys_user 表，增加 user_type 字段区分学生和教师。同时创建学生扩展信息表 stu_student_info。

sys_user 扩展（可在原表基础上增加字段，或通过关联表）：

sql
-- 若直接修改 sys_user 表，可增加 student_no, class_id 等字段
ALTER TABLE sys_user ADD COLUMN student_no varchar(20);
ALTER TABLE sys_user ADD COLUMN class_id bigint;
ALTER TABLE sys_user ADD COLUMN grade_id bigint;
ALTER TABLE sys_user ADD COLUMN real_name varchar(50);
但为避免与系统用户表过度耦合，建议单独建表：

sql
CREATE TABLE stu_student_info (
    id bigint PRIMARY KEY,
    user_id bigint NOT NULL UNIQUE,
    student_no varchar(20) NOT NULL UNIQUE,
    real_name varchar(50) NOT NULL,
    class_id bigint NOT NULL,
    grade_id bigint,                -- 冗余年级，便于查询
    del_flag char(1) DEFAULT '0',
    create_time timestamp
);
登录时使用 sys_user 的 user_name 字段存储学号，密码加密存储。

3.2.5 课程表 (cou_course)
sql
CREATE TABLE cou_course (
    id bigint PRIMARY KEY,
    course_name varchar(100) NOT NULL,
    week_day smallint NOT NULL,      -- 1-5 周一至周五
    grade_id bigint NOT NULL,
    teacher_id bigint,               -- 关联 sys_user (教师类型)
    description text,
    semester_id bigint NOT NULL,
    del_flag char(1) DEFAULT '0',
    create_time timestamp
);
COMMENT ON COLUMN cou_course.week_day IS '星期几 1-5';
3.2.6 课程班级容量表 (cou_class_quota)
sql
CREATE TABLE cou_class_quota (
    id bigint PRIMARY KEY,
    course_id bigint NOT NULL,
    class_id bigint NOT NULL,
    quota int NOT NULL,               -- 名额上限
    selected int DEFAULT 0,            -- 已选人数（可实时统计或通过触发器维护）
    del_flag char(1) DEFAULT '0',
    create_time timestamp
);
为保证性能，建议在选课提交/退课时使用事务更新 selected 字段，同时配合唯一索引 (course_id, class_id)。

3.2.7 学生选课记录表 (stu_selection)
sql
CREATE TABLE stu_selection (
    id bigint PRIMARY KEY,
    student_id bigint NOT NULL,        -- 关联 sys_user 或 stu_student_info 的 user_id
    course_id bigint NOT NULL,
    semester_id bigint NOT NULL,
    week_day smallint NOT NULL,        -- 冗余，与课程表一致
    class_id bigint,                   -- 学生所在班级（冗余）
    create_time timestamp,
    status smallint DEFAULT 1,          -- 1正常 0退课删除（逻辑删除）
    UNIQUE (student_id, semester_id, week_day, status)  -- 确保同一学期每周只选一门课
);
注意：逻辑删除时需处理唯一索引冲突，可改为物理删除或使用 status 包含删除状态（如 -1）并用部分索引。

3.2.8 评价题目表 (eva_question)
sql
CREATE TABLE eva_question (
    id bigint PRIMARY KEY,
    content varchar(255) NOT NULL,
    score int NOT NULL,                 -- 分值
    sort int,
    semester_id bigint NOT NULL,
    status smallint DEFAULT 1,           -- 1启用 0停用
    del_flag char(1) DEFAULT '0',
    create_time timestamp
);
3.2.9 学生评分表 (stu_evaluation)
sql
CREATE TABLE stu_evaluation (
    id bigint PRIMARY KEY,
    student_id bigint NOT NULL,
    course_id bigint NOT NULL,
    question_id bigint NOT NULL,
    score int NOT NULL,
    semester_id bigint NOT NULL,
    create_time timestamp,
    UNIQUE (student_id, course_id, question_id)  -- 一个学生一门课每个题目只能评一次
);
4. 后端模块设计
4.1 模块划分
系统管理（RuoYi原生）：用户管理（学生、教师）、角色权限、菜单等。需扩展 user_type 字段，并为学生角色单独配置权限。

学期管理：SemesterController，提供增删改查及设置当前学期接口。

年级班级管理：GradeController、ClassController，额外提供“一键升级”接口。

学生管理：StudentController，支持导入模板下载、Excel导入、重置密码、查询等。

课程管理：CourseController，增删改查，复制课程到新学期的接口；查看选课学生列表及导出。

课程容量配置：CourseQuotaController，管理某课程下各班级的名额。

选课系统（核心）：SelectionController，处理选课车数据、提交、退课、查询剩余名额等。

评价管理：EvaluationController，管理评价题目、开启/关闭，学生提交评分。

4.2 PostgreSQL 适配要点
分页：RuoYi 使用 PageHelper，在 application.yml 中配置 helperDialect=postgresql 即可。

主键生成：RuoYi 默认使用雪花算法，无需修改。

批量插入：PostgreSQL 语法为 INSERT INTO ... VALUES (...), (...), ...，MyBatis 的 <foreach> 拼接同样适用。

日期函数：使用 now() 代替 sysdate()。

4.3 关键服务层逻辑
4.3.1 学生导入与重置密码
下载模板：使用 EasyExcel 生成包含“学号、姓名、班级（需按年级班级级联）”的模板。

导入：解析 Excel，逐行验证班级是否存在，创建 sys_user（user_name = 学号，默认密码加密，user_type = 'student'），同时插入 stu_student_info。需保证事务一致性。

重置密码：管理员点击重置，将对应 sys_user 的密码修改为预设值（如学号后六位，加盐加密）。

4.3.2 一键升级年级班级
逻辑：将所有年级按 sort 排序，依次将 grade_name 修改为下一个年级名称（如“一年级”→“二年级”），同时 sort 值保持不变（或重新排序）。若最高年级需要毕业处理（如删除或移出），需根据学校规则定制。

实现：在 GradeService 中添加 upgradeGrades() 方法，开启事务，查询所有未删除年级，按 sort 升序，循环更新每个年级的名称（可预定义映射表），最后提交。

4.3.3 课程容量管理
每个课程针对每个班级有一条 cou_class_quota 记录。新增/编辑课程时，需同时维护该课程的班级名额（可用前端表格批量提交）。

实时剩余名额计算：剩余 = quota - selected。selected 可通过统计 stu_selection 中该课程、该班级的有效记录数得到。为提高性能，在选课提交/退课时原子更新 selected 字段。

4.3.4 选课车实现（Redis）
使用 Redis 存储学生未提交的选课车内容，数据结构与之前相同：

Key: cart:studentId:semesterId

Value: Hash，field 为 weekDay，value 为 courseId

过期时间：30分钟。

选课流程（同前，略）需注意 PostgreSQL 事务处理。

4.3.5 课程复制到新学期
接口：POST /course/copyToNewSemester/{oldSemesterId}/{newSemesterId}

逻辑：查询旧学期所有课程及对应的班级容量配置，复制课程基本信息（semester_id 改为新学期），同时复制班级容量记录（关联新课程 ID）。使用事务，先插入课程，再获取新 ID 插入容量。

4.3.6 课程评价
管理员维护题目列表，可设置启用/停用。

学生评分时，需校验题目是否启用、分值范围，并插入 stu_evaluation。

5. 前端设计（Vue3 + Element Plus）
5.1 管理员端
基于 RuoYi-Vue3 的布局，菜单和路由使用框架自动生成。主要页面：

学期管理：表格 + 表单弹窗，设置当前学期按钮。

年级班级管理：可采用两个表格联动，或树形控件 + 表格。一键升级按钮触发 API。

学生管理：集成导入组件（使用 Element Plus Upload），下载模板按钮，重置密码按钮（带确认）。

课程管理：表单包含基本信息、班级容量表格（可动态添加行）。查看选课学生按钮弹出对话框，显示该课程已选学生列表，支持导出。

课程复制：在课程列表操作栏添加“复制到新学期”下拉选项，选择目标学期后调用接口。

评价管理：题目列表，可启用/禁用。

5.2 学生端（定制页面）
登录页：学号+密码，登录后根据角色跳转。
主页/选课中心：

顶部显示当前学期。

使用 Element Plus 的 Card 组件展示课程。

选课车区域：按周一至周五排列，每个卡片显示课程名称和移除按钮。

课程卡片显示：课程名称、教师、剩余名额、加入按钮。

底部提交按钮，绑定计算属性：当选课车中周一至周五都有课程时启用。

退课操作：

若学生已有正式选课，页面展示已选课程列表，并提供“退课重选”按钮。

点击后退课接口，刷新页面进入选课车编辑模式。

课程评价：

单独页面列出已选课程（评价开启时），点击评价弹出对话框，使用 Form 和 Rate 或数字输入框进行评分。

6. 安全与权限设计
使用 RuoYi-Vue3 的 Spring Security + JWT 认证。

管理员角色拥有所有管理模块权限（通过 @PreAuthorize 注解控制）。

学生角色仅能访问选课、退课、评价相关接口，并需校验当前用户只能操作自己的数据。

选课提交接口需防止重复提交（可使用 Redis 令牌）。

并发控制：更新 cou_class_quota 时使用 UPDATE ... SET selected = selected + 1 WHERE ... AND selected < quota，根据返回行数判断是否成功。若失败则回滚事务。

7. PostgreSQL 与 MySQL 差异处理总结
差异点	MySQL	PostgreSQL	本方案处理
自增主键	AUTO_INCREMENT	SERIAL / IDENTITY	改用雪花算法 ID，无需数据库自增
分页	LIMIT offset, size	LIMIT size OFFSET offset	PageHelper 自动适配
布尔类型	TINYINT(1)	BOOLEAN 或 SMALLINT	使用 SMALLINT 兼容
日期函数	NOW()	NOW()	通用，无需修改
批量插入	INSERT INTO ... VALUES (...), (...)	相同	MyBatis 语法兼容
唯一索引冲突处理	INSERT IGNORE / ON DUPLICATE	ON CONFLICT	本方案未使用，可手动判断
字符串连接	CONCAT(a,b)	a || b	若需使用，需调整，但业务中很少
8. 部署与测试建议
开发环境：拉取 RuoYi-Vue3 源码，修改 application-druid.yml 配置 PostgreSQL 数据源，添加 PageHelper 方言配置。

代码生成：在代码生成器中配置 PostgreSQL 数据源，生成基础 CRUD 代码。

测试：重点测试并发选课、退课、Redis 选课车数据一致性、Excel 导入导出。

部署：前端打包后置于 Nginx，后端打包为 Jar，配置 Redis 和 PostgreSQL 连接。

9. 总结
本方案基于 RuoYi-Vue3 和 PostgreSQL 进行了全面适配，保留了原方案的所有业务功能，同时针对 Vue3 组件库和 PostgreSQL 语法特点进行了调整。开发过程中需注意 PostgreSQL 的分页和事务特性，以及 RuoYi-Vue3 的前端权限控制机制。通过本方案，可快速搭建一套稳定、可扩展的学生选修课选课系统。