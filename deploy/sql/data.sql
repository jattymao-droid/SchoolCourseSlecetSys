--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: sys_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) FROM stdin;
1	主框架页-默认皮肤样式名称	sys.index.skinName	skin-blue	Y	admin	2025-11-06 14:13:43.626214		2025-11-06 14:13:43.626214	\N
2	用户管理-账号初始密码	sys.user.initPassword	123456	Y	admin	2025-11-06 14:13:43.629947		2025-11-06 14:13:43.629947	\N
3	主框架页-侧边栏主题	sys.index.sideTheme	theme-dark	Y	admin	2025-11-06 14:13:43.63085		2025-11-06 14:13:43.63085	\N
4	账号自助-验证码开关	sys.account.captchaEnabled	true	Y	admin	2025-11-06 14:13:43.631209		2025-11-06 14:13:43.631209	\N
5	账号自助-是否开启用户注册功能	sys.account.registerUser	false	Y	admin	2025-11-06 14:13:43.63153		2025-11-06 14:13:43.63153	\N
6	用户登录-黑名单列表	sys.login.blackIPList		Y	admin	2025-11-06 14:13:43.631822		2025-11-06 14:13:43.631822	\N
7	用户管理-初始密码修改策略	sys.account.initPasswordModify	1	Y	admin	2025-11-06 14:13:43.632127		2025-11-06 14:13:43.632127	\N
8	用户管理-账号密码更新周期	sys.account.passwordValidateDays	0	Y	admin	2025-11-06 14:13:43.632494		2025-11-06 14:13:43.632494	\N
\.


--
-- Data for Name: sys_dept; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) FROM stdin;
\.


--
-- Data for Name: sys_dict_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) FROM stdin;
1	1	男	0	sys_user_sex		primary	N	0	admin	2025-11-06 21:44:29.107107		2025-11-06 21:44:29.107107	男
2	2	女	1	sys_user_sex		warning	N	0	admin	2025-11-06 21:44:29.10786		2025-11-06 21:44:29.10786	女
3	3	未知	2	sys_user_sex		info	N	0	admin	2025-11-06 21:44:29.108253		2025-11-06 21:44:29.108253	未知
4	1	是	Y	sys_yes_no		primary	N	0	admin	2025-11-06 21:44:29.108769		2025-11-06 21:44:29.108769	是
5	2	否	N	sys_yes_no		danger	N	0	admin	2025-11-06 21:44:29.109276		2025-11-06 21:44:29.109276	否
6	1	正常	0	sys_normal_disable		success	N	0	admin	2025-11-06 21:44:29.109852		2025-11-06 21:44:29.109852	正常
7	2	停用	1	sys_normal_disable		danger	N	0	admin	2025-11-06 21:44:29.110445		2025-11-06 21:44:29.110445	停用
8	1	成功	0	sys_common_status		success	N	0	admin	2025-11-06 21:44:29.11107		2025-11-06 21:44:29.11107	成功状态
9	2	失败	1	sys_common_status		danger	N	0	admin	2025-11-06 21:44:29.111511		2025-11-06 21:44:29.111511	停用状态
10	1	通知	1	sys_notice_type		primary	N	0	admin	2025-11-06 21:44:29.112038		2025-11-06 21:44:29.112038	\N
11	2	公告	2	sys_notice_type		warning	N	0	admin	2025-11-06 21:44:29.112525		2025-11-06 21:44:29.112525	\N
12	1	正常	0	sys_notice_status		success	N	0	admin	2025-11-06 21:44:29.112953		2025-11-06 21:44:29.112953	\N
13	2	关闭	1	sys_notice_status		danger	N	0	admin	2025-11-06 21:44:29.113426		2025-11-06 21:44:29.113426	\N
14	1	其他	0	sys_oper_type			N	0	admin	2025-11-06 21:44:29.113856		2025-11-06 21:44:29.113856	\N
15	2	新增	1	sys_oper_type			N	0	admin	2025-11-06 21:44:29.114279		2025-11-06 21:44:29.114279	\N
16	3	修改	2	sys_oper_type			N	0	admin	2025-11-06 21:44:29.114651		2025-11-06 21:44:29.114651	\N
17	4	删除	3	sys_oper_type			N	0	admin	2025-11-06 21:44:29.115004		2025-11-06 21:44:29.115004	\N
18	5	授权	4	sys_oper_type			N	0	admin	2025-11-06 21:44:29.11538		2025-11-06 21:44:29.11538	\N
19	6	导出	5	sys_oper_type			N	0	admin	2025-11-06 21:44:29.11579		2025-11-06 21:44:29.11579	\N
20	7	导入	6	sys_oper_type			N	0	admin	2025-11-06 21:44:29.116155		2025-11-06 21:44:29.116155	\N
21	8	强退	7	sys_oper_type			N	0	admin	2025-11-06 21:44:29.1165		2025-11-06 21:44:29.1165	\N
22	9	生成代码	8	sys_oper_type			N	0	admin	2025-11-06 21:44:29.116904		2025-11-06 21:44:29.116904	\N
23	10	清空数据	9	sys_oper_type			N	0	admin	2025-11-06 21:44:29.117296		2025-11-06 21:44:29.117296	\N
24	1	正常	0	sys_job_status		success	N	0	admin	2025-11-06 21:44:29.117643		2025-11-06 21:44:29.117643	\N
25	2	暂停	1	sys_job_status		danger	N	0	admin	2025-11-06 21:44:29.11803		2025-11-06 21:44:29.11803	\N
26	1	系统默认（无集群）	DEFAULT	sys_job_group			N	0	admin	2025-11-06 21:44:29.118456		2025-11-06 21:44:29.118456	\N
27	2	系统任务	SYSTEM	sys_job_group			N	0	admin	2025-11-06 21:44:29.11884		2025-11-06 21:44:29.11884	\N
\.


--
-- Data for Name: sys_dict_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) FROM stdin;
1	用户性别	sys_user_sex	0	admin	2025-11-06 21:44:29.097292		2025-11-06 21:44:29.097292	用户性别列表
2	系统开关	sys_normal_disable	0	admin	2025-11-06 21:44:29.098431		2025-11-06 21:44:29.098431	系统开关列表
3	任务状态	sys_job_status	0	admin	2025-11-06 21:44:29.098856		2025-11-06 21:44:29.098856	任务状态列表
4	任务分组	sys_job_group	0	admin	2025-11-06 21:44:29.099262		2025-11-06 21:44:29.099262	任务分组列表
5	系统是否	sys_yes_no	0	admin	2025-11-06 21:44:29.09974		2025-11-06 21:44:29.09974	系统是否列表
6	通知类型	sys_notice_type	0	admin	2025-11-06 21:44:29.100202		2025-11-06 21:44:29.100202	通知类型列表
7	通知状态	sys_notice_status	0	admin	2025-11-06 21:44:29.100624		2025-11-06 21:44:29.100624	通知状态列表
8	操作类型	sys_oper_type	0	admin	2025-11-06 21:44:29.101057		2025-11-06 21:44:29.101057	操作类型列表
9	系统状态	sys_common_status	0	admin	2025-11-06 21:44:29.101497		2025-11-06 21:44:29.101497	登录状态列表
\.


--
-- Data for Name: sys_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) FROM stdin;
\.


--
-- Data for Name: sys_job_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_job_log (job_log_id, job_name, job_group, invoke_target, job_message, status, exception_info, create_time) FROM stdin;
\.


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) FROM stdin;
1	超级管理员	admin	1	1	1	1	0	0	admin	2025-11-06 21:44:29.08719		2025-11-06 21:44:29.08719	系统内置角色
2	普通角色	common	2	1	1	1	0	0	admin	2025-11-06 21:44:29.088405		2025-11-06 21:44:29.088405	系统默认普通角色
\.


--
-- Data for Name: sys_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) FROM stdin;
\.


--
-- Data for Name: sys_user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sys_user_role (user_id, role_id) FROM stdin;
1	1
2	2
\.


--
-- Name: sys_config_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_config_config_id_seq', 48, true);


--
-- Name: sys_dept_dept_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_dept_dept_id_seq', 1, false);


--
-- Name: sys_dict_data_dict_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_dict_data_dict_code_seq', 27, true);


--
-- Name: sys_dict_type_dict_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_dict_type_dict_id_seq', 9, true);


--
-- Name: sys_job_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_job_job_id_seq', 1, false);


--
-- Name: sys_job_log_job_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_job_log_job_log_id_seq', 1, false);


--
-- Name: sys_role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_role_role_id_seq', 2, true);


--
-- Name: sys_user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_user_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

