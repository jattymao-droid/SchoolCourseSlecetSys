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

