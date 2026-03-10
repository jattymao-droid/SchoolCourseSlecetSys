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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: sys_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_config (
    config_id bigint NOT NULL,
    config_name character varying(100) DEFAULT ''::character varying,
    config_key character varying(100) DEFAULT ''::character varying,
    config_value character varying(500) DEFAULT ''::character varying,
    config_type character(1) DEFAULT 'N'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_config OWNER TO postgres;

--
-- Name: sys_config_config_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_config_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_config_config_id_seq OWNER TO postgres;

--
-- Name: sys_config_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_config_config_id_seq OWNED BY public.sys_config.config_id;


--
-- Name: sys_dept; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_dept (
    dept_id bigint NOT NULL,
    parent_id bigint DEFAULT 0,
    ancestors character varying(50) DEFAULT ''::character varying,
    dept_name character varying(30) DEFAULT ''::character varying,
    order_num integer DEFAULT 0,
    leader character varying(20) DEFAULT NULL::character varying,
    phone character varying(11) DEFAULT NULL::character varying,
    email character varying(50) DEFAULT NULL::character varying,
    status character(1) DEFAULT '0'::bpchar,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sys_dept OWNER TO postgres;

--
-- Name: TABLE sys_dept; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_dept IS '部门表';


--
-- Name: COLUMN sys_dept.dept_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.dept_id IS '部门id';


--
-- Name: COLUMN sys_dept.parent_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.parent_id IS '父部门id';


--
-- Name: COLUMN sys_dept.ancestors; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.ancestors IS '祖级列表';


--
-- Name: COLUMN sys_dept.dept_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.dept_name IS '部门名称';


--
-- Name: COLUMN sys_dept.order_num; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.order_num IS '显示顺序';


--
-- Name: COLUMN sys_dept.leader; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.leader IS '负责人';


--
-- Name: COLUMN sys_dept.phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.phone IS '联系电话';


--
-- Name: COLUMN sys_dept.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.email IS '邮箱';


--
-- Name: COLUMN sys_dept.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.status IS '部门状态（0正常 1停用）';


--
-- Name: COLUMN sys_dept.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.del_flag IS '删除标志（0存在 2删除）';


--
-- Name: sys_dept_dept_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_dept_dept_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_dept_dept_id_seq OWNER TO postgres;

--
-- Name: sys_dept_dept_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_dept_dept_id_seq OWNED BY public.sys_dept.dept_id;


--
-- Name: sys_dict_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_dict_data (
    dict_code bigint NOT NULL,
    dict_sort integer DEFAULT 0,
    dict_label character varying(100) DEFAULT ''::character varying,
    dict_value character varying(100) DEFAULT ''::character varying,
    dict_type character varying(100) DEFAULT ''::character varying,
    css_class character varying(100) DEFAULT ''::character varying,
    list_class character varying(100) DEFAULT ''::character varying,
    is_default character(1) DEFAULT 'N'::bpchar,
    status character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_dict_data OWNER TO postgres;

--
-- Name: sys_dict_data_dict_code_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_dict_data_dict_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_dict_data_dict_code_seq OWNER TO postgres;

--
-- Name: sys_dict_data_dict_code_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_dict_data_dict_code_seq OWNED BY public.sys_dict_data.dict_code;


--
-- Name: sys_dict_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_dict_type (
    dict_id bigint NOT NULL,
    dict_name character varying(100) DEFAULT ''::character varying,
    dict_type character varying(100),
    status character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_dict_type OWNER TO postgres;

--
-- Name: sys_dict_type_dict_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_dict_type_dict_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_dict_type_dict_id_seq OWNER TO postgres;

--
-- Name: sys_dict_type_dict_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_dict_type_dict_id_seq OWNED BY public.sys_dict_type.dict_id;


--
-- Name: sys_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_job (
    job_id bigint NOT NULL,
    job_name character varying(64) DEFAULT ''::character varying,
    job_group character varying(64) DEFAULT ''::character varying,
    invoke_target character varying(500) DEFAULT ''::character varying,
    cron_expression character varying(255) DEFAULT ''::character varying,
    misfire_policy character varying(20) DEFAULT '0'::character varying,
    concurrent character(1) DEFAULT '0'::bpchar,
    status character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_job OWNER TO postgres;

--
-- Name: TABLE sys_job; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_job IS '定时任务调度表';


--
-- Name: COLUMN sys_job.job_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.job_id IS '任务ID';


--
-- Name: COLUMN sys_job.job_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.job_name IS '任务名称';


--
-- Name: COLUMN sys_job.job_group; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.job_group IS '任务组名';


--
-- Name: COLUMN sys_job.invoke_target; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.invoke_target IS '调用目标字符串';


--
-- Name: COLUMN sys_job.cron_expression; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.cron_expression IS '执行表达式';


--
-- Name: COLUMN sys_job.misfire_policy; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.misfire_policy IS '计划策略';


--
-- Name: COLUMN sys_job.concurrent; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.concurrent IS '并发执行（0允许 1禁止）';


--
-- Name: COLUMN sys_job.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.status IS '任务状态（0正常 1暂停）';


--
-- Name: COLUMN sys_job.create_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.create_by IS '创建者';


--
-- Name: COLUMN sys_job.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.create_time IS '创建时间';


--
-- Name: COLUMN sys_job.update_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.update_by IS '更新者';


--
-- Name: COLUMN sys_job.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.update_time IS '更新时间';


--
-- Name: COLUMN sys_job.remark; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job.remark IS '备注';


--
-- Name: sys_job_job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_job_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_job_job_id_seq OWNER TO postgres;

--
-- Name: sys_job_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_job_job_id_seq OWNED BY public.sys_job.job_id;


--
-- Name: sys_job_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_job_log (
    job_log_id bigint NOT NULL,
    job_name character varying(64) DEFAULT ''::character varying,
    job_group character varying(64) DEFAULT ''::character varying,
    invoke_target character varying(500) DEFAULT ''::character varying,
    job_message character varying(500) DEFAULT ''::character varying,
    status character(1) DEFAULT '0'::bpchar,
    exception_info character varying(2000) DEFAULT ''::character varying,
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sys_job_log OWNER TO postgres;

--
-- Name: TABLE sys_job_log; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_job_log IS '定时任务调度日志表';


--
-- Name: COLUMN sys_job_log.job_log_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job_log.job_log_id IS '日志主键';


--
-- Name: COLUMN sys_job_log.job_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job_log.job_name IS '任务名称';


--
-- Name: COLUMN sys_job_log.job_group; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job_log.job_group IS '任务组名';


--
-- Name: COLUMN sys_job_log.invoke_target; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job_log.invoke_target IS '调用目标字符串';


--
-- Name: COLUMN sys_job_log.job_message; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job_log.job_message IS '日志信息';


--
-- Name: COLUMN sys_job_log.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job_log.status IS '执行状态（0正常 1失败）';


--
-- Name: COLUMN sys_job_log.exception_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job_log.exception_info IS '异常信息';


--
-- Name: COLUMN sys_job_log.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_job_log.create_time IS '创建时间';


--
-- Name: sys_job_log_job_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_job_log_job_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_job_log_job_log_id_seq OWNER TO postgres;

--
-- Name: sys_job_log_job_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_job_log_job_log_id_seq OWNED BY public.sys_job_log.job_log_id;


--
-- Name: sys_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role (
    role_id bigint NOT NULL,
    role_name character varying(30) NOT NULL,
    role_key character varying(100) NOT NULL,
    role_sort integer DEFAULT 0 NOT NULL,
    data_scope character(1) DEFAULT '1'::bpchar,
    menu_check_strictly smallint DEFAULT 1,
    dept_check_strictly smallint DEFAULT 1,
    status character(1) DEFAULT '0'::bpchar NOT NULL,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_role OWNER TO postgres;

--
-- Name: TABLE sys_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_role IS '角色信息表';


--
-- Name: COLUMN sys_role.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.role_id IS '角色ID';


--
-- Name: COLUMN sys_role.role_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.role_name IS '角色名称';


--
-- Name: COLUMN sys_role.role_key; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.role_key IS '角色权限字符串';


--
-- Name: COLUMN sys_role.role_sort; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.role_sort IS '显示顺序';


--
-- Name: COLUMN sys_role.data_scope; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.data_scope IS '数据范围（1全部 2自定 3本部门 4本部门及以下）';


--
-- Name: COLUMN sys_role.menu_check_strictly; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.menu_check_strictly IS '菜单树选择项是否关联显示';


--
-- Name: COLUMN sys_role.dept_check_strictly; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.dept_check_strictly IS '部门树选择项是否关联显示';


--
-- Name: COLUMN sys_role.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.status IS '角色状态（0正常 1停用）';


--
-- Name: COLUMN sys_role.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.del_flag IS '删除标志（0存在 2删除）';


--
-- Name: sys_role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_role_role_id_seq OWNER TO postgres;

--
-- Name: sys_role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_role_role_id_seq OWNED BY public.sys_role.role_id;


--
-- Name: sys_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user (
    user_id bigint NOT NULL,
    dept_id bigint,
    user_name character varying(30) NOT NULL,
    nick_name character varying(30) NOT NULL,
    user_type character varying(2) DEFAULT '00'::character varying,
    email character varying(50) DEFAULT ''::character varying,
    phonenumber character varying(11) DEFAULT ''::character varying,
    sex character(1) DEFAULT '0'::bpchar,
    avatar character varying(100) DEFAULT ''::character varying,
    password character varying(100) DEFAULT ''::character varying,
    status character(1) DEFAULT '0'::bpchar,
    del_flag character(1) DEFAULT '0'::bpchar,
    login_ip character varying(128) DEFAULT ''::character varying,
    login_date timestamp without time zone,
    pwd_update_date timestamp without time zone,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_user OWNER TO postgres;

--
-- Name: COLUMN sys_user.phonenumber; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_user.phonenumber IS '鎵嬫満鍙风爜';


--
-- Name: COLUMN sys_user.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_user.create_time IS '鍒涘缓鏃堕棿';


--
-- Name: sys_user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user_role (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.sys_user_role OWNER TO postgres;

--
-- Name: TABLE sys_user_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_user_role IS '用户和角色关联表';


--
-- Name: COLUMN sys_user_role.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_user_role.user_id IS '用户ID';


--
-- Name: COLUMN sys_user_role.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_user_role.role_id IS '角色ID';


--
-- Name: sys_user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_user_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_user_user_id_seq OWNER TO postgres;

--
-- Name: sys_user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_user_user_id_seq OWNED BY public.sys_user.user_id;


--
-- Name: sys_config config_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_config ALTER COLUMN config_id SET DEFAULT nextval('public.sys_config_config_id_seq'::regclass);


--
-- Name: sys_dept dept_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dept ALTER COLUMN dept_id SET DEFAULT nextval('public.sys_dept_dept_id_seq'::regclass);


--
-- Name: sys_dict_data dict_code; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_data ALTER COLUMN dict_code SET DEFAULT nextval('public.sys_dict_data_dict_code_seq'::regclass);


--
-- Name: sys_dict_type dict_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_type ALTER COLUMN dict_id SET DEFAULT nextval('public.sys_dict_type_dict_id_seq'::regclass);


--
-- Name: sys_job job_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job ALTER COLUMN job_id SET DEFAULT nextval('public.sys_job_job_id_seq'::regclass);


--
-- Name: sys_job_log job_log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job_log ALTER COLUMN job_log_id SET DEFAULT nextval('public.sys_job_log_job_log_id_seq'::regclass);


--
-- Name: sys_role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role ALTER COLUMN role_id SET DEFAULT nextval('public.sys_role_role_id_seq'::regclass);


--
-- Name: sys_user user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user ALTER COLUMN user_id SET DEFAULT nextval('public.sys_user_user_id_seq'::regclass);


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
-- Name: sys_config sys_config_config_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_config
    ADD CONSTRAINT sys_config_config_key_key UNIQUE (config_key);


--
-- Name: sys_config sys_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_config
    ADD CONSTRAINT sys_config_pkey PRIMARY KEY (config_id);


--
-- Name: sys_dept sys_dept_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dept
    ADD CONSTRAINT sys_dept_pkey PRIMARY KEY (dept_id);


--
-- Name: sys_dict_data sys_dict_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_data
    ADD CONSTRAINT sys_dict_data_pkey PRIMARY KEY (dict_code);


--
-- Name: sys_dict_type sys_dict_type_dict_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_type
    ADD CONSTRAINT sys_dict_type_dict_type_key UNIQUE (dict_type);


--
-- Name: sys_dict_type sys_dict_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_type
    ADD CONSTRAINT sys_dict_type_pkey PRIMARY KEY (dict_id);


--
-- Name: sys_job_log sys_job_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job_log
    ADD CONSTRAINT sys_job_log_pkey PRIMARY KEY (job_log_id);


--
-- Name: sys_job sys_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job
    ADD CONSTRAINT sys_job_pkey PRIMARY KEY (job_id);


--
-- Name: sys_role sys_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_pkey PRIMARY KEY (role_id);


--
-- Name: sys_user sys_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_pkey PRIMARY KEY (user_id);


--
-- Name: sys_user_role sys_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_role
    ADD CONSTRAINT sys_user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- PostgreSQL database dump complete
--

