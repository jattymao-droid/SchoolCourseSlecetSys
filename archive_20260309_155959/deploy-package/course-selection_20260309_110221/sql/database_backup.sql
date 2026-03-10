--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2026-03-08 21:02:41

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
-- TOC entry 228 (class 1259 OID 89831)
-- Name: cou_class_quota; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cou_class_quota (
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    class_id bigint NOT NULL,
    quota integer NOT NULL,
    selected integer DEFAULT 0,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_time timestamp without time zone
);


ALTER TABLE public.cou_class_quota OWNER TO postgres;

--
-- TOC entry 5391 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE cou_class_quota; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cou_class_quota IS '课程班级容量表';


--
-- TOC entry 227 (class 1259 OID 89830)
-- Name: cou_class_quota_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cou_class_quota_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cou_class_quota_id_seq OWNER TO postgres;

--
-- TOC entry 5392 (class 0 OID 0)
-- Dependencies: 227
-- Name: cou_class_quota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cou_class_quota_id_seq OWNED BY public.cou_class_quota.id;


--
-- TOC entry 226 (class 1259 OID 89821)
-- Name: cou_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cou_course (
    id bigint NOT NULL,
    course_name character varying(100) NOT NULL,
    week_day smallint NOT NULL,
    grade_id bigint NOT NULL,
    teacher_id bigint,
    description text,
    location character varying(100),
    semester_id bigint NOT NULL,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_time timestamp without time zone,
    teacher_name character varying(50)
);


ALTER TABLE public.cou_course OWNER TO postgres;

--
-- TOC entry 5393 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE cou_course; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cou_course IS '课程表';


--
-- TOC entry 5394 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN cou_course.week_day; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cou_course.week_day IS '星期几 1-5';


--
-- TOC entry 5395 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN cou_course.location; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cou_course.location IS '上课地点';


--
-- TOC entry 5396 (class 0 OID 0)
-- Dependencies: 226
-- Name: COLUMN cou_course.teacher_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cou_course.teacher_name IS '教师姓名（直接输入）';


--
-- TOC entry 225 (class 1259 OID 89820)
-- Name: cou_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cou_course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cou_course_id_seq OWNER TO postgres;

--
-- TOC entry 5397 (class 0 OID 0)
-- Dependencies: 225
-- Name: cou_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cou_course_id_seq OWNED BY public.cou_course.id;


--
-- TOC entry 232 (class 1259 OID 89851)
-- Name: eva_question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eva_question (
    id bigint NOT NULL,
    content character varying(255) NOT NULL,
    score integer NOT NULL,
    sort integer,
    semester_id bigint NOT NULL,
    status smallint DEFAULT 1,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_time timestamp without time zone
);


ALTER TABLE public.eva_question OWNER TO postgres;

--
-- TOC entry 5398 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE eva_question; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.eva_question IS '评价题目表';


--
-- TOC entry 5399 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN eva_question.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.eva_question.status IS '1启用 0停用';


--
-- TOC entry 231 (class 1259 OID 89850)
-- Name: eva_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eva_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eva_question_id_seq OWNER TO postgres;

--
-- TOC entry 5400 (class 0 OID 0)
-- Dependencies: 231
-- Name: eva_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eva_question_id_seq OWNED BY public.eva_question.id;


--
-- TOC entry 266 (class 1259 OID 91363)
-- Name: gen_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gen_table (
    table_id bigint NOT NULL,
    table_name character varying(200) DEFAULT ''::character varying,
    table_comment character varying(500) DEFAULT ''::character varying,
    sub_table_name character varying(64) DEFAULT NULL::character varying,
    sub_table_fk_name character varying(64) DEFAULT NULL::character varying,
    class_name character varying(100) DEFAULT ''::character varying,
    tpl_category character varying(200) DEFAULT 'crud'::character varying,
    tpl_web_type character varying(30) DEFAULT ''::character varying,
    package_name character varying(100),
    module_name character varying(30),
    business_name character varying(30),
    function_name character varying(50),
    function_author character varying(50),
    gen_type character(1) DEFAULT '0'::bpchar,
    gen_path character varying(200) DEFAULT '/'::character varying,
    options character varying(1000),
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.gen_table OWNER TO postgres;

--
-- TOC entry 5401 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE gen_table; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.gen_table IS '代码生成业务表';


--
-- TOC entry 268 (class 1259 OID 91384)
-- Name: gen_table_column; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gen_table_column (
    column_id bigint NOT NULL,
    table_id bigint,
    column_name character varying(200),
    column_comment character varying(500),
    column_type character varying(100),
    java_type character varying(500),
    java_field character varying(200),
    is_pk character(1),
    is_increment character(1),
    is_required character(1),
    is_insert character(1),
    is_edit character(1),
    is_list character(1),
    is_query character(1),
    query_type character varying(200) DEFAULT 'EQ'::character varying,
    html_type character varying(200),
    dict_type character varying(200) DEFAULT ''::character varying,
    sort integer,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone
);


ALTER TABLE public.gen_table_column OWNER TO postgres;

--
-- TOC entry 5402 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE gen_table_column; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.gen_table_column IS '代码生成业务表字段';


--
-- TOC entry 267 (class 1259 OID 91383)
-- Name: gen_table_column_column_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gen_table_column_column_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gen_table_column_column_id_seq OWNER TO postgres;

--
-- TOC entry 5403 (class 0 OID 0)
-- Dependencies: 267
-- Name: gen_table_column_column_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gen_table_column_column_id_seq OWNED BY public.gen_table_column.column_id;


--
-- TOC entry 265 (class 1259 OID 91362)
-- Name: gen_table_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gen_table_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gen_table_table_id_seq OWNER TO postgres;

--
-- TOC entry 5404 (class 0 OID 0)
-- Dependencies: 265
-- Name: gen_table_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gen_table_table_id_seq OWNED BY public.gen_table.table_id;


--
-- TOC entry 273 (class 1259 OID 91439)
-- Name: qrtz_blob_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_blob_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    blob_data bytea
);


ALTER TABLE public.qrtz_blob_triggers OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 91451)
-- Name: qrtz_calendars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_calendars (
    sched_name character varying(120) NOT NULL,
    calendar_name character varying(200) NOT NULL,
    calendar bytea NOT NULL
);


ALTER TABLE public.qrtz_calendars OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 91427)
-- Name: qrtz_cron_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_cron_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    cron_expression character varying(200) NOT NULL,
    time_zone_id character varying(80)
);


ALTER TABLE public.qrtz_cron_triggers OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 91463)
-- Name: qrtz_fired_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_fired_triggers (
    sched_name character varying(120) NOT NULL,
    entry_id character varying(95) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    instance_name character varying(200) NOT NULL,
    fired_time bigint NOT NULL,
    sched_time bigint NOT NULL,
    priority integer NOT NULL,
    state character varying(16) NOT NULL,
    job_name character varying(200),
    job_group character varying(200),
    is_nonconcurrent character varying(1),
    requests_recovery character varying(1)
);


ALTER TABLE public.qrtz_fired_triggers OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 91396)
-- Name: qrtz_job_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_job_details (
    sched_name character varying(120) NOT NULL,
    job_name character varying(200) NOT NULL,
    job_group character varying(200) NOT NULL,
    description character varying(250),
    job_class_name character varying(250) NOT NULL,
    is_durable character varying(1) NOT NULL,
    is_nonconcurrent character varying(1) NOT NULL,
    is_update_data character varying(1) NOT NULL,
    requests_recovery character varying(1) NOT NULL,
    job_data bytea
);


ALTER TABLE public.qrtz_job_details OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 91475)
-- Name: qrtz_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_locks (
    sched_name character varying(120) NOT NULL,
    lock_name character varying(40) NOT NULL
);


ALTER TABLE public.qrtz_locks OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 91458)
-- Name: qrtz_paused_trigger_grps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_paused_trigger_grps (
    sched_name character varying(120) NOT NULL,
    trigger_group character varying(200) NOT NULL
);


ALTER TABLE public.qrtz_paused_trigger_grps OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 91470)
-- Name: qrtz_scheduler_state; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_scheduler_state (
    sched_name character varying(120) NOT NULL,
    instance_name character varying(200) NOT NULL,
    last_checkin_time bigint NOT NULL,
    checkin_interval bigint NOT NULL
);


ALTER TABLE public.qrtz_scheduler_state OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 91415)
-- Name: qrtz_simple_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_simple_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    repeat_count bigint NOT NULL,
    repeat_interval bigint NOT NULL,
    times_triggered bigint NOT NULL
);


ALTER TABLE public.qrtz_simple_triggers OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 91480)
-- Name: qrtz_simprop_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_simprop_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    str_prop_1 character varying(512),
    str_prop_2 character varying(512),
    str_prop_3 character varying(512),
    int_prop_1 integer,
    int_prop_2 integer,
    long_prop_1 bigint,
    long_prop_2 bigint,
    dec_prop_1 numeric(13,4),
    dec_prop_2 numeric(13,4),
    bool_prop_1 character varying(1),
    bool_prop_2 character varying(1)
);


ALTER TABLE public.qrtz_simprop_triggers OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 91403)
-- Name: qrtz_triggers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_triggers (
    sched_name character varying(120) NOT NULL,
    trigger_name character varying(200) NOT NULL,
    trigger_group character varying(200) NOT NULL,
    job_name character varying(200) NOT NULL,
    job_group character varying(200) NOT NULL,
    description character varying(250),
    next_fire_time bigint,
    prev_fire_time bigint,
    priority integer,
    trigger_state character varying(16) NOT NULL,
    trigger_type character varying(8) NOT NULL,
    start_time bigint NOT NULL,
    end_time bigint,
    calendar_name character varying(200),
    misfire_instr smallint,
    job_data bytea
);


ALTER TABLE public.qrtz_triggers OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 89860)
-- Name: stu_evaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stu_evaluation (
    id bigint NOT NULL,
    student_id bigint NOT NULL,
    course_id bigint NOT NULL,
    question_id bigint NOT NULL,
    score integer NOT NULL,
    semester_id bigint NOT NULL,
    create_time timestamp without time zone
);


ALTER TABLE public.stu_evaluation OWNER TO postgres;

--
-- TOC entry 5405 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE stu_evaluation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.stu_evaluation IS '学生评分表';


--
-- TOC entry 233 (class 1259 OID 89859)
-- Name: stu_evaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stu_evaluation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stu_evaluation_id_seq OWNER TO postgres;

--
-- TOC entry 5406 (class 0 OID 0)
-- Dependencies: 233
-- Name: stu_evaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stu_evaluation_id_seq OWNED BY public.stu_evaluation.id;


--
-- TOC entry 230 (class 1259 OID 89842)
-- Name: stu_selection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stu_selection (
    id bigint NOT NULL,
    student_id bigint NOT NULL,
    course_id bigint NOT NULL,
    semester_id bigint NOT NULL,
    week_day smallint NOT NULL,
    class_id bigint,
    create_time timestamp without time zone,
    status smallint DEFAULT 1,
    assigned smallint DEFAULT 0
);


ALTER TABLE public.stu_selection OWNER TO postgres;

--
-- TOC entry 5407 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE stu_selection; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.stu_selection IS '学生选课记录表';


--
-- TOC entry 5408 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN stu_selection.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stu_selection.status IS '1正常 0退课删除';


--
-- TOC entry 5409 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN stu_selection.assigned; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stu_selection.assigned IS '1管理员指定 0学生自选';


--
-- TOC entry 229 (class 1259 OID 89841)
-- Name: stu_selection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stu_selection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stu_selection_id_seq OWNER TO postgres;

--
-- TOC entry 5410 (class 0 OID 0)
-- Dependencies: 229
-- Name: stu_selection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stu_selection_id_seq OWNED BY public.stu_selection.id;


--
-- TOC entry 224 (class 1259 OID 89809)
-- Name: stu_student_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stu_student_info (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    student_no character varying(20) NOT NULL,
    real_name character varying(50) NOT NULL,
    class_id bigint NOT NULL,
    grade_id bigint,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_time timestamp without time zone
);


ALTER TABLE public.stu_student_info OWNER TO postgres;

--
-- TOC entry 5411 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE stu_student_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.stu_student_info IS '学生扩展信息表';


--
-- TOC entry 223 (class 1259 OID 89808)
-- Name: stu_student_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stu_student_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stu_student_info_id_seq OWNER TO postgres;

--
-- TOC entry 5412 (class 0 OID 0)
-- Dependencies: 223
-- Name: stu_student_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stu_student_info_id_seq OWNED BY public.stu_student_info.id;


--
-- TOC entry 222 (class 1259 OID 89801)
-- Name: sys_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_class (
    id bigint NOT NULL,
    class_name character varying(50) NOT NULL,
    grade_id bigint NOT NULL,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_time timestamp without time zone
);


ALTER TABLE public.sys_class OWNER TO postgres;

--
-- TOC entry 5413 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE sys_class; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_class IS '班级表';


--
-- TOC entry 221 (class 1259 OID 89800)
-- Name: sys_class_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_class_id_seq OWNER TO postgres;

--
-- TOC entry 5414 (class 0 OID 0)
-- Dependencies: 221
-- Name: sys_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_class_id_seq OWNED BY public.sys_class.id;


--
-- TOC entry 256 (class 1259 OID 91287)
-- Name: sys_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_config (
    config_id integer NOT NULL,
    config_name character varying(100) DEFAULT ''::character varying,
    config_key character varying(100) DEFAULT ''::character varying,
    config_value character varying(500) DEFAULT ''::character varying,
    config_type character(1) DEFAULT 'N'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_config OWNER TO postgres;

--
-- TOC entry 5415 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE sys_config; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_config IS '参数配置表';


--
-- TOC entry 255 (class 1259 OID 91286)
-- Name: sys_config_config_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_config_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_config_config_id_seq OWNER TO postgres;

--
-- TOC entry 5416 (class 0 OID 0)
-- Dependencies: 255
-- Name: sys_config_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_config_config_id_seq OWNED BY public.sys_config.config_id;


--
-- TOC entry 236 (class 1259 OID 91111)
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
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone
);


ALTER TABLE public.sys_dept OWNER TO postgres;

--
-- TOC entry 5417 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE sys_dept; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_dept IS '部门表';


--
-- TOC entry 5418 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.dept_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.dept_id IS '部门id';


--
-- TOC entry 5419 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.parent_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.parent_id IS '父部门id';


--
-- TOC entry 5420 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.ancestors; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.ancestors IS '祖级列表';


--
-- TOC entry 5421 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.dept_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.dept_name IS '部门名称';


--
-- TOC entry 5422 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.order_num; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.order_num IS '显示顺序';


--
-- TOC entry 5423 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.leader; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.leader IS '负责人';


--
-- TOC entry 5424 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.phone IS '联系电话';


--
-- TOC entry 5425 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.email IS '邮箱';


--
-- TOC entry 5426 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.status IS '部门状态（0正常 1停用）';


--
-- TOC entry 5427 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.del_flag IS '删除标志（0代表存在 2代表删除）';


--
-- TOC entry 5428 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.create_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.create_by IS '创建者';


--
-- TOC entry 5429 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.create_time IS '创建时间';


--
-- TOC entry 5430 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.update_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.update_by IS '更新者';


--
-- TOC entry 5431 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN sys_dept.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.update_time IS '更新时间';


--
-- TOC entry 235 (class 1259 OID 91110)
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
-- TOC entry 5432 (class 0 OID 0)
-- Dependencies: 235
-- Name: sys_dept_dept_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_dept_dept_id_seq OWNED BY public.sys_dept.dept_id;


--
-- TOC entry 254 (class 1259 OID 91267)
-- Name: sys_dict_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_dict_data (
    dict_code bigint NOT NULL,
    dict_sort integer DEFAULT 0,
    dict_label character varying(100) DEFAULT ''::character varying,
    dict_value character varying(100) DEFAULT ''::character varying,
    dict_type character varying(100) DEFAULT ''::character varying,
    css_class character varying(100) DEFAULT NULL::character varying,
    list_class character varying(100) DEFAULT NULL::character varying,
    is_default character(1) DEFAULT 'N'::bpchar,
    status character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_dict_data OWNER TO postgres;

--
-- TOC entry 5433 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE sys_dict_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_dict_data IS '字典数据表';


--
-- TOC entry 253 (class 1259 OID 91266)
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
-- TOC entry 5434 (class 0 OID 0)
-- Dependencies: 253
-- Name: sys_dict_data_dict_code_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_dict_data_dict_code_seq OWNED BY public.sys_dict_data.dict_code;


--
-- TOC entry 252 (class 1259 OID 91250)
-- Name: sys_dict_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_dict_type (
    dict_id bigint NOT NULL,
    dict_name character varying(100) DEFAULT ''::character varying,
    dict_type character varying(100) DEFAULT ''::character varying,
    status character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_dict_type OWNER TO postgres;

--
-- TOC entry 5435 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE sys_dict_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_dict_type IS '字典类型表';


--
-- TOC entry 251 (class 1259 OID 91249)
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
-- TOC entry 5436 (class 0 OID 0)
-- Dependencies: 251
-- Name: sys_dict_type_dict_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_dict_type_dict_id_seq OWNED BY public.sys_dict_type.dict_id;


--
-- TOC entry 220 (class 1259 OID 89793)
-- Name: sys_grade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_grade (
    id bigint NOT NULL,
    grade_name character varying(50) NOT NULL,
    sort integer,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_time timestamp without time zone
);


ALTER TABLE public.sys_grade OWNER TO postgres;

--
-- TOC entry 5437 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE sys_grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_grade IS '年级表';


--
-- TOC entry 5438 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN sys_grade.sort; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_grade.sort IS '排序，用于一键升级';


--
-- TOC entry 219 (class 1259 OID 89792)
-- Name: sys_grade_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_grade_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_grade_id_seq OWNER TO postgres;

--
-- TOC entry 5439 (class 0 OID 0)
-- Dependencies: 219
-- Name: sys_grade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_grade_id_seq OWNED BY public.sys_grade.id;


--
-- TOC entry 260 (class 1259 OID 91321)
-- Name: sys_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_job (
    job_id bigint NOT NULL,
    job_name character varying(64) DEFAULT ''::character varying,
    job_group character varying(64) DEFAULT 'DEFAULT'::character varying,
    invoke_target character varying(500) NOT NULL,
    cron_expression character varying(255) DEFAULT ''::character varying,
    misfire_policy character varying(20) DEFAULT '3'::character varying,
    concurrent character(1) DEFAULT '1'::bpchar,
    status character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT ''::character varying
);


ALTER TABLE public.sys_job OWNER TO postgres;

--
-- TOC entry 5440 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE sys_job; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_job IS '定时任务调度表';


--
-- TOC entry 259 (class 1259 OID 91320)
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
-- TOC entry 5441 (class 0 OID 0)
-- Dependencies: 259
-- Name: sys_job_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_job_job_id_seq OWNED BY public.sys_job.job_id;


--
-- TOC entry 262 (class 1259 OID 91339)
-- Name: sys_job_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_job_log (
    job_log_id bigint NOT NULL,
    job_name character varying(64) NOT NULL,
    job_group character varying(64) NOT NULL,
    invoke_target character varying(500) NOT NULL,
    job_message character varying(500),
    status character(1) DEFAULT '0'::bpchar,
    exception_info character varying(2000) DEFAULT ''::character varying,
    create_time timestamp without time zone
);


ALTER TABLE public.sys_job_log OWNER TO postgres;

--
-- TOC entry 5442 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE sys_job_log; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_job_log IS '定时任务调度日志表';


--
-- TOC entry 261 (class 1259 OID 91338)
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
-- TOC entry 5443 (class 0 OID 0)
-- Dependencies: 261
-- Name: sys_job_log_job_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_job_log_job_log_id_seq OWNED BY public.sys_job_log.job_log_id;


--
-- TOC entry 258 (class 1259 OID 91303)
-- Name: sys_logininfor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_logininfor (
    info_id bigint NOT NULL,
    user_name character varying(50) DEFAULT ''::character varying,
    ipaddr character varying(128) DEFAULT ''::character varying,
    login_location character varying(255) DEFAULT ''::character varying,
    browser character varying(50) DEFAULT ''::character varying,
    os character varying(50) DEFAULT ''::character varying,
    status character(1) DEFAULT '0'::bpchar,
    msg character varying(255) DEFAULT ''::character varying,
    login_time timestamp without time zone
);


ALTER TABLE public.sys_logininfor OWNER TO postgres;

--
-- TOC entry 5444 (class 0 OID 0)
-- Dependencies: 258
-- Name: TABLE sys_logininfor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_logininfor IS '系统访问记录';


--
-- TOC entry 257 (class 1259 OID 91302)
-- Name: sys_logininfor_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_logininfor_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_logininfor_info_id_seq OWNER TO postgres;

--
-- TOC entry 5445 (class 0 OID 0)
-- Dependencies: 257
-- Name: sys_logininfor_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_logininfor_info_id_seq OWNED BY public.sys_logininfor.info_id;


--
-- TOC entry 244 (class 1259 OID 91178)
-- Name: sys_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_menu (
    menu_id bigint NOT NULL,
    menu_name character varying(50) NOT NULL,
    parent_id bigint DEFAULT 0,
    order_num integer DEFAULT 0,
    path character varying(200) DEFAULT ''::character varying,
    component character varying(255) DEFAULT NULL::character varying,
    query character varying(255) DEFAULT NULL::character varying,
    route_name character varying(50) DEFAULT ''::character varying,
    is_frame integer DEFAULT 1,
    is_cache integer DEFAULT 0,
    menu_type character(1) DEFAULT ''::bpchar,
    visible character(1) DEFAULT '0'::bpchar,
    status character(1) DEFAULT '0'::bpchar,
    perms character varying(100) DEFAULT NULL::character varying,
    icon character varying(100) DEFAULT '#'::character varying,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT ''::character varying
);


ALTER TABLE public.sys_menu OWNER TO postgres;

--
-- TOC entry 5446 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE sys_menu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_menu IS '菜单权限表';


--
-- TOC entry 243 (class 1259 OID 91177)
-- Name: sys_menu_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_menu_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_menu_menu_id_seq OWNER TO postgres;

--
-- TOC entry 5447 (class 0 OID 0)
-- Dependencies: 243
-- Name: sys_menu_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_menu_menu_id_seq OWNED BY public.sys_menu.menu_id;


--
-- TOC entry 264 (class 1259 OID 91350)
-- Name: sys_notice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_notice (
    notice_id integer NOT NULL,
    notice_title character varying(50) NOT NULL,
    notice_type character(1) NOT NULL,
    notice_content text,
    status character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_notice OWNER TO postgres;

--
-- TOC entry 5448 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE sys_notice; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_notice IS '通知公告表';


--
-- TOC entry 263 (class 1259 OID 91349)
-- Name: sys_notice_notice_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_notice_notice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_notice_notice_id_seq OWNER TO postgres;

--
-- TOC entry 5449 (class 0 OID 0)
-- Dependencies: 263
-- Name: sys_notice_notice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_notice_notice_id_seq OWNED BY public.sys_notice.notice_id;


--
-- TOC entry 250 (class 1259 OID 91223)
-- Name: sys_oper_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_oper_log (
    oper_id bigint NOT NULL,
    title character varying(50) DEFAULT ''::character varying,
    business_type smallint DEFAULT 0,
    method character varying(200) DEFAULT ''::character varying,
    request_method character varying(10) DEFAULT ''::character varying,
    operator_type smallint DEFAULT 0,
    oper_name character varying(50) DEFAULT ''::character varying,
    dept_name character varying(50) DEFAULT ''::character varying,
    oper_url character varying(255) DEFAULT ''::character varying,
    oper_ip character varying(128) DEFAULT ''::character varying,
    oper_location character varying(255) DEFAULT ''::character varying,
    oper_param character varying(2000) DEFAULT ''::character varying,
    json_result character varying(2000) DEFAULT ''::character varying,
    status smallint DEFAULT 0,
    error_msg character varying(2000) DEFAULT ''::character varying,
    oper_time timestamp without time zone,
    cost_time bigint DEFAULT 0
);


ALTER TABLE public.sys_oper_log OWNER TO postgres;

--
-- TOC entry 5450 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE sys_oper_log; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_oper_log IS '操作日志记录';


--
-- TOC entry 249 (class 1259 OID 91222)
-- Name: sys_oper_log_oper_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_oper_log_oper_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_oper_log_oper_id_seq OWNER TO postgres;

--
-- TOC entry 5451 (class 0 OID 0)
-- Dependencies: 249
-- Name: sys_oper_log_oper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_oper_log_oper_id_seq OWNED BY public.sys_oper_log.oper_id;


--
-- TOC entry 240 (class 1259 OID 91150)
-- Name: sys_post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_post (
    post_id bigint NOT NULL,
    post_code character varying(64) NOT NULL,
    post_name character varying(50) NOT NULL,
    post_sort integer NOT NULL,
    status character(1) NOT NULL,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_post OWNER TO postgres;

--
-- TOC entry 5452 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE sys_post; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_post IS '岗位信息表';


--
-- TOC entry 239 (class 1259 OID 91149)
-- Name: sys_post_post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_post_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_post_post_id_seq OWNER TO postgres;

--
-- TOC entry 5453 (class 0 OID 0)
-- Dependencies: 239
-- Name: sys_post_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_post_post_id_seq OWNED BY public.sys_post.post_id;


--
-- TOC entry 242 (class 1259 OID 91162)
-- Name: sys_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role (
    role_id bigint NOT NULL,
    role_name character varying(30) NOT NULL,
    role_key character varying(100) NOT NULL,
    role_sort integer NOT NULL,
    data_scope character(1) DEFAULT '1'::bpchar,
    menu_check_strictly smallint DEFAULT 1,
    dept_check_strictly smallint DEFAULT 1,
    status character(1) NOT NULL,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_by character varying(64) DEFAULT ''::character varying,
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_role OWNER TO postgres;

--
-- TOC entry 5454 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE sys_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_role IS '角色信息表';


--
-- TOC entry 247 (class 1259 OID 91212)
-- Name: sys_role_dept; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role_dept (
    role_id bigint NOT NULL,
    dept_id bigint NOT NULL
);


ALTER TABLE public.sys_role_dept OWNER TO postgres;

--
-- TOC entry 5455 (class 0 OID 0)
-- Dependencies: 247
-- Name: TABLE sys_role_dept; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_role_dept IS '角色和部门关联表';


--
-- TOC entry 246 (class 1259 OID 91207)
-- Name: sys_role_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role_menu (
    role_id bigint NOT NULL,
    menu_id bigint NOT NULL
);


ALTER TABLE public.sys_role_menu OWNER TO postgres;

--
-- TOC entry 5456 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE sys_role_menu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_role_menu IS '角色和菜单关联表';


--
-- TOC entry 241 (class 1259 OID 91161)
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
-- TOC entry 5457 (class 0 OID 0)
-- Dependencies: 241
-- Name: sys_role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_role_role_id_seq OWNED BY public.sys_role.role_id;


--
-- TOC entry 218 (class 1259 OID 89784)
-- Name: sys_semester; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_semester (
    id bigint NOT NULL,
    semester_name character varying(50) NOT NULL,
    start_date date,
    end_date date,
    is_current smallint DEFAULT 0,
    del_flag character(1) DEFAULT '0'::bpchar,
    create_by character varying(64),
    create_time timestamp without time zone,
    update_by character varying(64),
    update_time timestamp without time zone,
    selection_start_time timestamp without time zone,
    selection_end_time timestamp without time zone
);


ALTER TABLE public.sys_semester OWNER TO postgres;

--
-- TOC entry 5458 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE sys_semester; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_semester IS '学期表';


--
-- TOC entry 5459 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN sys_semester.is_current; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_semester.is_current IS '是否当前学期 0否 1是';


--
-- TOC entry 5460 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN sys_semester.selection_start_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_semester.selection_start_time IS '选课开始时间';


--
-- TOC entry 5461 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN sys_semester.selection_end_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_semester.selection_end_time IS '选课结束时间';


--
-- TOC entry 217 (class 1259 OID 89783)
-- Name: sys_semester_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sys_semester_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sys_semester_id_seq OWNER TO postgres;

--
-- TOC entry 5462 (class 0 OID 0)
-- Dependencies: 217
-- Name: sys_semester_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_semester_id_seq OWNED BY public.sys_semester.id;


--
-- TOC entry 238 (class 1259 OID 91129)
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
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_user OWNER TO postgres;

--
-- TOC entry 5463 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE sys_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_user IS '用户信息表';


--
-- TOC entry 248 (class 1259 OID 91217)
-- Name: sys_user_post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user_post (
    user_id bigint NOT NULL,
    post_id bigint NOT NULL
);


ALTER TABLE public.sys_user_post OWNER TO postgres;

--
-- TOC entry 5464 (class 0 OID 0)
-- Dependencies: 248
-- Name: TABLE sys_user_post; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_user_post IS '用户与岗位关联表';


--
-- TOC entry 245 (class 1259 OID 91202)
-- Name: sys_user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user_role (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.sys_user_role OWNER TO postgres;

--
-- TOC entry 5465 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE sys_user_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_user_role IS '用户和角色关联表';


--
-- TOC entry 237 (class 1259 OID 91128)
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
-- TOC entry 5466 (class 0 OID 0)
-- Dependencies: 237
-- Name: sys_user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_user_user_id_seq OWNED BY public.sys_user.user_id;


--
-- TOC entry 4928 (class 2604 OID 89834)
-- Name: cou_class_quota id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_class_quota ALTER COLUMN id SET DEFAULT nextval('public.cou_class_quota_id_seq'::regclass);


--
-- TOC entry 4926 (class 2604 OID 89824)
-- Name: cou_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_course ALTER COLUMN id SET DEFAULT nextval('public.cou_course_id_seq'::regclass);


--
-- TOC entry 4934 (class 2604 OID 89854)
-- Name: eva_question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eva_question ALTER COLUMN id SET DEFAULT nextval('public.eva_question_id_seq'::regclass);


--
-- TOC entry 5061 (class 2604 OID 91366)
-- Name: gen_table table_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_table ALTER COLUMN table_id SET DEFAULT nextval('public.gen_table_table_id_seq'::regclass);


--
-- TOC entry 5074 (class 2604 OID 91387)
-- Name: gen_table_column column_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_table_column ALTER COLUMN column_id SET DEFAULT nextval('public.gen_table_column_column_id_seq'::regclass);


--
-- TOC entry 4937 (class 2604 OID 89863)
-- Name: stu_evaluation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_evaluation ALTER COLUMN id SET DEFAULT nextval('public.stu_evaluation_id_seq'::regclass);


--
-- TOC entry 4931 (class 2604 OID 89845)
-- Name: stu_selection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_selection ALTER COLUMN id SET DEFAULT nextval('public.stu_selection_id_seq'::regclass);


--
-- TOC entry 4924 (class 2604 OID 89812)
-- Name: stu_student_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_student_info ALTER COLUMN id SET DEFAULT nextval('public.stu_student_info_id_seq'::regclass);


--
-- TOC entry 4922 (class 2604 OID 89804)
-- Name: sys_class id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_class ALTER COLUMN id SET DEFAULT nextval('public.sys_class_id_seq'::regclass);


--
-- TOC entry 5027 (class 2604 OID 91290)
-- Name: sys_config config_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_config ALTER COLUMN config_id SET DEFAULT nextval('public.sys_config_config_id_seq'::regclass);


--
-- TOC entry 4938 (class 2604 OID 91114)
-- Name: sys_dept dept_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dept ALTER COLUMN dept_id SET DEFAULT nextval('public.sys_dept_dept_id_seq'::regclass);


--
-- TOC entry 5015 (class 2604 OID 91270)
-- Name: sys_dict_data dict_code; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_data ALTER COLUMN dict_code SET DEFAULT nextval('public.sys_dict_data_dict_code_seq'::regclass);


--
-- TOC entry 5008 (class 2604 OID 91253)
-- Name: sys_dict_type dict_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_type ALTER COLUMN dict_id SET DEFAULT nextval('public.sys_dict_type_dict_id_seq'::regclass);


--
-- TOC entry 4920 (class 2604 OID 89796)
-- Name: sys_grade id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grade ALTER COLUMN id SET DEFAULT nextval('public.sys_grade_id_seq'::regclass);


--
-- TOC entry 5043 (class 2604 OID 91324)
-- Name: sys_job job_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job ALTER COLUMN job_id SET DEFAULT nextval('public.sys_job_job_id_seq'::regclass);


--
-- TOC entry 5053 (class 2604 OID 91342)
-- Name: sys_job_log job_log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job_log ALTER COLUMN job_log_id SET DEFAULT nextval('public.sys_job_log_job_log_id_seq'::regclass);


--
-- TOC entry 5035 (class 2604 OID 91306)
-- Name: sys_logininfor info_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_logininfor ALTER COLUMN info_id SET DEFAULT nextval('public.sys_logininfor_info_id_seq'::regclass);


--
-- TOC entry 4975 (class 2604 OID 91181)
-- Name: sys_menu menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_menu ALTER COLUMN menu_id SET DEFAULT nextval('public.sys_menu_menu_id_seq'::regclass);


--
-- TOC entry 5056 (class 2604 OID 91353)
-- Name: sys_notice notice_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_notice ALTER COLUMN notice_id SET DEFAULT nextval('public.sys_notice_notice_id_seq'::regclass);


--
-- TOC entry 4992 (class 2604 OID 91226)
-- Name: sys_oper_log oper_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_oper_log ALTER COLUMN oper_id SET DEFAULT nextval('public.sys_oper_log_oper_id_seq'::regclass);


--
-- TOC entry 4963 (class 2604 OID 91153)
-- Name: sys_post post_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_post ALTER COLUMN post_id SET DEFAULT nextval('public.sys_post_post_id_seq'::regclass);


--
-- TOC entry 4967 (class 2604 OID 91165)
-- Name: sys_role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role ALTER COLUMN role_id SET DEFAULT nextval('public.sys_role_role_id_seq'::regclass);


--
-- TOC entry 4917 (class 2604 OID 89787)
-- Name: sys_semester id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_semester ALTER COLUMN id SET DEFAULT nextval('public.sys_semester_id_seq'::regclass);


--
-- TOC entry 4950 (class 2604 OID 91132)
-- Name: sys_user user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user ALTER COLUMN user_id SET DEFAULT nextval('public.sys_user_user_id_seq'::regclass);


--
-- TOC entry 5334 (class 0 OID 89831)
-- Dependencies: 228
-- Data for Name: cou_class_quota; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5332 (class 0 OID 89821)
-- Dependencies: 226
-- Data for Name: cou_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (1, '经典诵读', 1, 1, 20, '诵读经典文学作品，提升文学素养', NULL, 1, '2', '2026-03-06 10:31:31.928222', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (2, '趣味数学', 1, 1, 21, '拓展数学思维，趣味解题', NULL, 1, '2', '2026-03-06 10:31:31.930074', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (9, '辩论与演讲', 1, 2, 20, '提升表达与思辨能力', NULL, 1, '2', '2026-03-06 10:31:31.940559', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (3, '英语戏剧', 2, 1, 20, '英语情景剧表演，提升口语', NULL, 1, '2', '2026-03-06 10:31:31.93118', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (4, '物理实验', 2, 1, 21, '动手做物理实验，探索科学', NULL, 1, '2', '2026-03-06 10:31:31.932345', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (10, '科技创新', 2, 2, 21, '科技创新项目实践', NULL, 1, '2', '2026-03-06 10:31:31.941215', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (5, '书法艺术', 3, 1, 20, '软笔书法入门与提高', NULL, 1, '2', '2026-03-06 10:31:31.933162', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (6, '编程入门', 3, 1, 21, 'Python 编程基础', NULL, 1, '2', '2026-03-06 10:31:31.93471', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (7, '合唱团', 4, 1, 20, '校园合唱团排练', NULL, 1, '2', '2026-03-06 10:31:31.936556', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (8, '篮球社', 5, 1, 21, '篮球训练与比赛', NULL, 1, '2', '2026-03-06 10:31:31.937906', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (31, '舞蹈', 2, 1, 119, '', '体道楼4楼403', 1, '0', '2026-03-06 17:57:16.632204', '晏敏');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (32, '羽毛球', 2, 1, 120, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '周克虎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (33, '排球', 2, 1, 109, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (34, '物理特训营', 3, 1, 133, '', '初二4班', 1, '0', '2026-03-06 17:57:16.632204', '秦绍将');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (35, '写作指导与训练', 3, 1, 134, '', '初二1班', 1, '0', '2026-03-06 17:57:16.632204', '张淑琼');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (36, '图（途）说中国', 3, 1, 135, '', '初二2班', 1, '0', '2026-03-06 17:57:16.632204', '陈金粉');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (37, '生物实验及实践', 3, 1, 136, '', '生物实验室', 1, '0', '2026-03-06 17:57:16.632204', '潘晨');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (38, '平板摄影与图形图像处理', 3, 1, 131, '', '会泽院2楼机房', 1, '0', '2026-03-06 17:57:16.632204', '代锦');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (39, '趣味心理学', 3, 1, 107, '', '会泽院4楼心理健康教室', 1, '0', '2026-03-06 17:57:16.632204', '廖臣芸');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (40, '彩铅', 3, 1, 137, '', '体道楼4楼410', 1, '0', '2026-03-06 17:57:16.632204', '李琳');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (41, '合唱队(七八年级合上)40人', 3, 1, 113, '', '体道楼', 1, '0', '2026-03-06 17:57:16.632204', '唐云莲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (42, '阅读与鉴赏（名著赏析）', 3, 1, 129, '', '初二3班', 1, '0', '2026-03-06 17:57:16.632204', '何欢');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (43, '篮球提高班', 3, 1, 109, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (44, '足球男队12人', 3, 1, 132, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '董嘉');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (45, '语文特训营', 4, 1, 141, '', '初二3班', 1, '0', '2026-03-06 17:57:16.632204', '王会琼');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (46, '国学课堂', 4, 1, 142, '', '初二4班', 1, '0', '2026-03-06 17:57:16.632204', '高连武');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (47, '历史角色扮演/历史剧表演', 4, 1, 143, '', '初二5班', 1, '0', '2026-03-06 17:57:16.632204', '吴丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (48, '硬笔书法与鉴赏', 4, 1, 138, '', '初二2班', 1, '0', '2026-03-06 17:57:16.632204', '段金书');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (49, '民歌赏析', 4, 1, 144, '', '体道楼4楼408', 1, '0', '2026-03-06 17:57:16.632204', '胡庆梅');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (50, '创意编程基础班', 4, 1, 130, '', '格致楼4楼机房', 1, '0', '2026-03-06 17:57:16.632204', '严彩丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (51, '塑造艺术', 4, 1, 106, '', '体道楼4楼410', 1, '0', '2026-03-06 17:57:16.632204', '杨俊会');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (52, '篮球基础班', 4, 1, 108, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '唐东');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (53, '篮球校队', 4, 1, 109, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (54, '足球男女队', 4, 1, 110, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '代龙炎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (55, '排球校队', 4, 1, 111, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '余运波');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (56, '乒乓球校队', 4, 1, 112, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '王卫芬');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (57, '羽毛球校队', 4, 1, 120, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '周克虎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (58, '时政探寻', 5, 1, 149, '', '初二2班', 1, '0', '2026-03-06 17:57:16.632204', '谢秋梅');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (59, '演讲与主持', 5, 1, 113, '', '初二5班', 1, '0', '2026-03-06 17:57:16.632204', '唐云莲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (60, '数学特训营', 5, 1, 122, '', '初二1班', 1, '0', '2026-03-06 17:57:16.632204', '肖艳明');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (61, '数学提升营', 5, 1, 123, '', '初二3班', 1, '0', '2026-03-06 17:57:16.632204', '夏瑞');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (21, '排球校队', 1, 1, NULL, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '余运波');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (22, '乒乓球校队', 1, 1, 112, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '王卫芬');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (23, '合唱队(七八年级合上)40人', 1, 1, 113, '', '体道楼408', 1, '2', '2026-03-06 17:57:16.632204', '唐云莲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (24, '数学特训营', 2, 1, 122, '', '初二1班', 1, '2', '2026-03-06 17:57:16.632204', '肖艳明');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (25, '数学提升营', 2, 1, 123, '', '初二3班', 1, '2', '2026-03-06 17:57:16.632204', '夏瑞');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (26, '武术合上', 2, 1, 124, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '毛永洲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (27, '奥数辅导班', 2, 1, 125, '', '初二2班', 1, '2', '2026-03-06 17:57:16.632204', '杨佳');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (28, '乒乓球', 2, 1, 111, '', '格致楼话吧', 1, '2', '2026-03-06 17:57:16.632204', '余运波');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (29, '影视后期编辑与制作', 2, 1, 121, '', '会泽院2楼机房', 1, '2', '2026-03-06 17:57:16.632204', '严明涛');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (30, '国画', 2, 1, 126, '', '初二5班', 1, '2', '2026-03-06 17:57:16.632204', '王世慧');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (62, '化学实验课堂', 5, 1, 150, '', '格致楼2楼化学实验室', 1, '0', '2026-03-06 17:57:16.632204', '王开金');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (63, '器乐', 5, 1, 139, '', '体道楼4楼404', 1, '0', '2026-03-06 17:57:16.632204', '汪延容');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (64, '篆刻', 5, 1, 118, '', '体道楼4楼410', 1, '0', '2026-03-06 17:57:16.632204', '李晨');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (65, '创意编程提高班', 5, 1, 130, '', '格致楼4楼机房', 1, '0', '2026-03-06 17:57:16.632204', '严彩丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (66, '机器人制作', 5, 1, 121, '', '会泽院2楼机房', 1, '0', '2026-03-06 17:57:16.632204', '严明涛');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (67, '足球', 5, 1, 132, '', '篮球场', 1, '0', '2026-03-06 17:57:16.632204', '董嘉');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (68, '物理实验课堂', 5, 1, 151, '', '格致楼4楼物理实验室', 1, '0', '2026-03-06 17:57:16.632204', '赵天英');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (11, '英语口语俱乐部', 1, 1, 101, '', '初二4班', 1, '2', '2026-03-06 17:57:16.632204', '张艾');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (12, '软笔书法与鉴赏', 1, 1, 102, '', '初二2班', 1, '2', '2026-03-06 17:57:16.632204', '李正金');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (13, '英语特训营', 1, 1, 103, '', '初二1班', 1, '2', '2026-03-06 17:57:16.632204', '肖瀛');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (14, '英语提升营', 1, 1, 104, '', '初二3班', 1, '2', '2026-03-06 17:57:16.632204', '张蓉');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (15, '心理学心灵短视频分享课（合上）', 1, 1, 105, '', '初二5班', 1, '2', '2026-03-06 17:57:16.632204', '曹燕丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (16, '钢笔淡彩', 1, 1, 106, '', '初一4班', 1, '2', '2026-03-06 17:57:16.632204', '杨俊会');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (17, '生涯规划及团体辅导', 1, 1, 107, '', '会泽院4楼心理健康教室', 1, '2', '2026-03-06 17:57:16.632204', '廖臣芸');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (18, '篮球', 1, 1, 108, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '唐东');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (19, '篮球校队', 1, 1, 109, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (20, '足球女队', 1, 1, 110, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '代龙炎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (79, '排球', 2, 1, 109, '', '篮球场', 2, '2', '2026-03-08 20:50:57.19744', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (80, '羽毛球', 2, 1, 120, '', '篮球场', 2, '2', '2026-03-08 20:50:57.223701', '周克虎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (81, '舞蹈', 2, 1, 119, '', '体道楼4楼403', 2, '2', '2026-03-08 20:50:57.245947', '晏敏');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (82, '写作指导与训练', 3, 1, 134, '', '初二1班', 2, '2', '2026-03-08 20:50:57.265037', '张淑琼');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (83, '物理特训营', 3, 1, 133, '', '初二4班', 2, '2', '2026-03-08 20:50:57.298531', '秦绍将');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (84, '图（途）说中国', 3, 1, 135, '', '初二2班', 2, '2', '2026-03-08 20:50:57.323163', '陈金粉');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (85, '平板摄影与图形图像处理', 3, 1, 131, '', '会泽院2楼机房', 2, '2', '2026-03-08 20:50:57.361144', '代锦');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (86, '生物实验及实践', 3, 1, 136, '', '生物实验室', 2, '2', '2026-03-08 20:50:57.383313', '潘晨');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (87, '趣味心理学', 3, 1, 107, '', '会泽院4楼心理健康教室', 2, '2', '2026-03-08 20:50:57.383971', '廖臣芸');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (89, '彩铅', 3, 1, 137, '', '体道楼4楼410', 2, '2', '2026-03-08 20:50:57.449734', '李琳');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (90, '阅读与鉴赏（名著赏析）', 3, 1, 129, '', '初二3班', 2, '2', '2026-03-08 20:50:57.477676', '何欢');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (91, '篮球提高班', 3, 1, 109, '', '篮球场', 2, '2', '2026-03-08 20:50:57.51388', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (92, '足球男队12人', 3, 1, 132, '', '篮球场', 2, '2', '2026-03-08 20:50:57.617031', '董嘉');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (93, '硬笔书法与鉴赏', 4, 1, 138, '', '初二2班', 2, '2', '2026-03-08 20:50:57.652198', '段金书');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (94, '民歌赏析', 4, 1, 144, '', '体道楼4楼408', 2, '2', '2026-03-08 20:50:57.697143', '胡庆梅');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (95, '语文特训营', 4, 1, 141, '', '初二3班', 2, '2', '2026-03-08 20:50:57.714863', '王会琼');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (96, '国学课堂', 4, 1, 142, '', '初二4班', 2, '2', '2026-03-08 20:50:57.759573', '高连武');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (97, '塑造艺术', 4, 1, 106, '', '体道楼4楼410', 2, '2', '2026-03-08 20:50:57.782879', '杨俊会');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (98, '创意编程基础班', 4, 1, 130, '', '格致楼4楼机房', 2, '2', '2026-03-08 20:50:57.767511', '严彩丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (99, '历史角色扮演/历史剧表演', 4, 1, 143, '', '初二5班', 2, '2', '2026-03-08 20:50:57.782668', '吴丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (100, '篮球基础班', 4, 1, 108, '', '篮球场', 2, '2', '2026-03-08 20:50:57.839386', '唐东');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (101, '篮球校队', 4, 1, 109, '', '篮球场', 2, '2', '2026-03-08 20:50:57.90155', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (102, '足球男女队', 4, 1, 110, '', '篮球场', 2, '2', '2026-03-08 20:50:57.918966', '代龙炎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (103, '乒乓球校队', 4, 1, 112, '', '篮球场', 2, '2', '2026-03-08 20:50:57.957466', '王卫芬');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (104, '羽毛球校队', 4, 1, 120, '', '篮球场', 2, '2', '2026-03-08 20:50:57.98509', '周克虎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (105, '排球校队', 4, 1, 111, '', '篮球场', 2, '2', '2026-03-08 20:50:57.98258', '余运波');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (106, '数学提升营', 5, 1, 123, '', '初二3班', 2, '2', '2026-03-08 20:50:58.02895', '夏瑞');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (107, '时政探寻', 5, 1, 149, '', '初二2班', 2, '2', '2026-03-08 20:50:58.028203', '谢秋梅');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (108, '化学实验课堂', 5, 1, 150, '', '格致楼2楼化学实验室', 2, '2', '2026-03-08 20:50:58.094129', '王开金');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (109, '演讲与主持', 5, 1, 113, '', '初二5班', 2, '2', '2026-03-08 20:50:58.097967', '唐云莲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (110, '器乐', 5, 1, 139, '', '体道楼4楼404', 2, '2', '2026-03-08 20:50:58.158266', '汪延容');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (111, '篆刻', 5, 1, 118, '', '体道楼4楼410', 2, '2', '2026-03-08 20:50:58.165015', '李晨');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (112, '创意编程提高班', 5, 1, 130, '', '格致楼4楼机房', 2, '2', '2026-03-08 20:50:58.164554', '严彩丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (113, '数学特训营', 5, 1, 122, '', '初二1班', 2, '2', '2026-03-08 20:50:58.150083', '肖艳明');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (114, '机器人制作', 5, 1, 121, '', '会泽院2楼机房', 2, '2', '2026-03-08 20:50:58.215887', '严明涛');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (69, '乒乓球校队', 1, 1, 112, '', '篮球场', 2, '2', '2026-03-08 20:50:56.705504', '王卫芬');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (70, '排球校队', 1, 1, NULL, '', '篮球场', 2, '2', '2026-03-08 20:50:56.705401', '余运波');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (71, '合唱队(七八年级合上)40人', 1, 1, 113, '', '体道楼408', 2, '2', '2026-03-08 20:50:56.714014', '唐云莲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (72, '数学特训营', 2, 1, 122, '', '初二1班', 2, '2', '2026-03-08 20:50:56.799168', '肖艳明');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (73, '数学提升营', 2, 1, 123, '', '初二3班', 2, '2', '2026-03-08 20:50:56.801685', '夏瑞');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (74, '武术合上', 2, 1, 124, '', '篮球场', 2, '2', '2026-03-08 20:50:56.841903', '毛永洲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (75, '乒乓球', 2, 1, 111, '', '格致楼话吧', 2, '2', '2026-03-08 20:50:57.009477', '余运波');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (76, '奥数辅导班', 2, 1, 125, '', '初二2班', 2, '2', '2026-03-08 20:50:56.981808', '杨佳');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (77, '影视后期编辑与制作', 2, 1, 121, '', '会泽院2楼机房', 2, '2', '2026-03-08 20:50:57.050749', '严明涛');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (78, '国画', 2, 1, 126, '', '初二5班', 2, '2', '2026-03-08 20:50:57.100899', '王世慧');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (115, '物理实验课堂', 5, 1, 151, '', '格致楼4楼物理实验室', 2, '2', '2026-03-08 20:50:58.265776', '赵天英');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (88, '合唱队(七八年级合上)40人', 3, 1, 113, '', '体道楼', 2, '2', '2026-03-08 20:50:57.434736', '唐云莲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (116, '足球', 5, 1, 132, '', '篮球场', 2, '2', '2026-03-08 20:50:58.265855', '董嘉');


--
-- TOC entry 5338 (class 0 OID 89851)
-- Dependencies: 232
-- Data for Name: eva_question; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.eva_question (id, content, score, sort, semester_id, status, del_flag, create_time) VALUES (1, '教学内容', 10, 0, 1, 1, '0', '2026-03-08 20:52:17.784765');


--
-- TOC entry 5372 (class 0 OID 91363)
-- Dependencies: 266
-- Data for Name: gen_table; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5374 (class 0 OID 91384)
-- Dependencies: 268
-- Data for Name: gen_table_column; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5379 (class 0 OID 91439)
-- Dependencies: 273
-- Data for Name: qrtz_blob_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5380 (class 0 OID 91451)
-- Dependencies: 274
-- Data for Name: qrtz_calendars; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5378 (class 0 OID 91427)
-- Dependencies: 272
-- Data for Name: qrtz_cron_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5382 (class 0 OID 91463)
-- Dependencies: 276
-- Data for Name: qrtz_fired_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5375 (class 0 OID 91396)
-- Dependencies: 269
-- Data for Name: qrtz_job_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5384 (class 0 OID 91475)
-- Dependencies: 278
-- Data for Name: qrtz_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5381 (class 0 OID 91458)
-- Dependencies: 275
-- Data for Name: qrtz_paused_trigger_grps; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5383 (class 0 OID 91470)
-- Dependencies: 277
-- Data for Name: qrtz_scheduler_state; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5377 (class 0 OID 91415)
-- Dependencies: 271
-- Data for Name: qrtz_simple_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5385 (class 0 OID 91480)
-- Dependencies: 279
-- Data for Name: qrtz_simprop_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5376 (class 0 OID 91403)
-- Dependencies: 270
-- Data for Name: qrtz_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5340 (class 0 OID 89860)
-- Dependencies: 234
-- Data for Name: stu_evaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5336 (class 0 OID 89842)
-- Dependencies: 230
-- Data for Name: stu_selection; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5330 (class 0 OID 89809)
-- Dependencies: 224
-- Data for Name: stu_student_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (1, 10, '202401001', '王小明', 1, 1, '2', '2026-03-06 10:31:31.921433');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2, 11, '202401002', '李小红', 1, 1, '2', '2026-03-06 10:31:31.923957');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (3, 12, '202401003', '陈小华', 2, 1, '2', '2026-03-06 10:31:31.924863');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (4, 13, '202401004', '刘小芳', 2, 1, '2', '2026-03-06 10:31:31.925665');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (5, 14, '202302001', '赵小强', 3, 2, '2', '2026-03-06 10:31:31.926412');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (6, 15, '202302002', '孙小丽', 4, 2, '2', '2026-03-06 10:31:31.92716');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (7, 154, '4101', '陈明阳', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (8, 155, '4102', '陈尚博', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (9, 156, '4103', '陈烁颖', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (10, 157, '4104', '陈亚桐', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (11, 158, '4105', '代晨熙', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (12, 159, '4106', '代娜', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (13, 160, '4107', '丁小航', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (14, 161, '4108', '段兴利', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (15, 162, '4109', '段致远', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (16, 163, '4110', '冯浠然', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (17, 164, '4111', '高涵', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (18, 165, '4112', '关堡元', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (19, 166, '4113', '何思辰', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (20, 167, '4114', '胡锦', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (21, 168, '4115', '胡艺曦', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (22, 169, '4116', '虎羽丹', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (23, 170, '4117', '蒋梅莹', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (24, 171, '4118', '康婧媛', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (25, 172, '4119', '李恒茁', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (26, 173, '4120', '李江浩', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (27, 174, '4121', '李思弦', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (28, 175, '4122', '李亭薇', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (29, 176, '4123', '李阳', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (30, 177, '4124', '刘畅', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (31, 178, '4125', '刘东峄', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (32, 179, '4126', '柳玉然', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (33, 180, '4127', '陆雨鑫', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (34, 181, '4128', '罗俊熙', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (35, 182, '4129', '罗翔', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (36, 183, '4130', '马彪', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (37, 184, '4131', '马博一', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (38, 185, '4132', '马钰涵', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (39, 186, '4133', '马煜洋', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (40, 187, '4134', '孟遵域', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (41, 188, '4135', '庞博', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (42, 189, '4136', '戚埕', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (43, 190, '4137', '邱晨希', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (44, 191, '4138', '邵明玥', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (45, 192, '4139', '孙贤', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (46, 193, '4140', '唐源', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (47, 194, '4141', '王瑞琦', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (48, 195, '4142', '王若曦', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (49, 196, '4143', '王滢媛', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (50, 197, '4144', '吴鑫艺', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (51, 198, '4145', '刘骅瑾', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (52, 199, '4146', '徐薇雲', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (53, 200, '4147', '杨采薇', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (54, 201, '4148', '杨舒然', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (55, 202, '4149', '杨梓毅', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (56, 203, '4150', '张瑾', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (57, 204, '4151', '张璟琦', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (58, 205, '4152', '张清铨', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (59, 206, '4153', '张茹冰', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (60, 207, '4154', '张钰晨', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (61, 208, '4155', '赵晨曦', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (62, 209, '4156', '赵继元', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (63, 210, '4157', '赵寅志', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (64, 211, '4160', '李彦霖', 11, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (65, 212, '4201', '周搏秋', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (66, 213, '4202', '林世桂', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (67, 214, '4203', '李昌欢', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (68, 215, '4204', '方冉', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (69, 216, '4205', '王福泽', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (70, 217, '4206', '晏祥胜', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (71, 218, '4207', '蒋博', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (72, 219, '4208', '李俊熙', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (73, 220, '4209', '夏语阳', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (74, 221, '4210', '杨壁安', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (75, 222, '4211', '黄韦博', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (76, 223, '4212', '庄永恒', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (77, 224, '4213', '周照阳', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (78, 225, '4214', '刘盛', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (79, 226, '4215', '王理源', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (80, 227, '4216', '张远欢', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (81, 228, '4217', '樊宇善', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (82, 229, '4218', '王宇', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (83, 230, '4219', '胡芮杰', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (84, 231, '4220', '欧泓辛', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (85, 232, '4221', '潘喆', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (86, 233, '4222', '晏韶辰', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (87, 234, '4223', '李盛', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (88, 235, '4224', '吕思昱', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (89, 236, '4225', '冯婧钰', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (90, 237, '4226', '包如意', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (91, 238, '4227', '付瑗', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (92, 239, '4228', '杨紫妍', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (93, 240, '4229', '代春雨', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (94, 241, '4230', '计美琳', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (95, 242, '4231', '贺娅妮', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (96, 243, '4232', '王幂', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (97, 244, '4233', '马文婷', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (98, 245, '4234', '戚丽雪', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (99, 246, '4235', '左吉丽', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (100, 247, '4236', '李蓉', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (101, 248, '4237', '曾娅赛', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (102, 249, '4238', '夏曦悦', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (103, 250, '4239', '施丽琨', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (104, 251, '4240', '陈选麟', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (105, 252, '4241', '贾叠', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (106, 253, '4242', '杨成娇', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (107, 254, '4243', '山宵云', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (108, 255, '4244', '李婷', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (109, 256, '4245', '吕维优', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (110, 257, '4246', '蒋蕊', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (111, 258, '4247', '朱娅', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (112, 259, '4248', '李皎', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (113, 260, '4249', '许香琴', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (114, 261, '4250', '杨会仙', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (115, 262, '4251', '张婉琦', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (116, 263, '4252', '应佳颖', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (117, 264, '4253', '陈曦瑶', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (118, 265, '4254', '撒召颖', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (119, 266, '4255', '陈帆', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (120, 267, '4256', '冯光泽', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (121, 268, '4257', '王晨霁', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (122, 269, '4258', '严子俊', 12, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (123, 270, '4301', '刘唐浩然', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (124, 271, '4302', '秦熙瑶', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (125, 272, '4303', '尹国玲', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (126, 273, '4304', '王加弼', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (127, 274, '4305', '朱芯', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (128, 275, '4306', '范熠', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (129, 276, '4307', '吕兴巧', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (130, 277, '4308', '刘淼', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (131, 278, '4309', '金鑫欣', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (132, 279, '4310', '欧江平', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (133, 280, '4311', '陆思轩', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (134, 281, '4312', '刘思辰', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (135, 282, '4313', '周遇', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (136, 283, '4314', '顾翌', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (137, 284, '4315', '高楚烨', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (138, 285, '4316', '黄腾锋', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (139, 286, '4317', '柳梦洁', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (140, 287, '4318', '鲍欣怡', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (141, 288, '4319', '徐璐璐', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (142, 289, '4320', '余冠霆', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (143, 290, '4321', '马关爽', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (144, 291, '4322', '马浩荣', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (145, 292, '4323', '贺文县', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (146, 293, '4324', '李达粲', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (147, 294, '4325', '周梦绮', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (148, 295, '4326', '刘曦雅', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (149, 296, '4327', '李秋燚', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (150, 297, '4328', '陈兴幔', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (151, 298, '4329', '邹汶辛', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (152, 299, '4330', '刘悦', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (153, 300, '4331', '李艳琳', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (154, 301, '4332', '张梦琳', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (155, 302, '4333', '杨泓雯', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (156, 303, '4334', '王丽娜', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (157, 304, '4335', '刘佳', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (158, 305, '4336', '谢雨鑫', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (159, 306, '4337', '柳正权', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (160, 307, '4338', '王翎旭', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (161, 308, '4339', '晏贤莎', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (162, 309, '4340', '潘沐晨', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (163, 310, '4341', '罗传龙', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (164, 311, '4342', '朱恩瑾', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (165, 312, '4343', '姚姝熠', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (166, 313, '4344', '张诗雯', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (167, 314, '4345', '刘东亚', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (168, 315, '4346', '马一懿', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (169, 316, '4347', '李卓壕', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (170, 317, '4348', '吕曜桦', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (171, 318, '4349', '张馨月', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (172, 319, '4350', '华学昊', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (173, 320, '4351', '李昊', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (174, 321, '4352', '李红辰', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (175, 322, '4353', '唐浩然', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (176, 323, '4354', '殷承邦', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (177, 324, '4355', '孙叶嘉', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (178, 325, '4356', '王馨怡', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (179, 326, '4357', '晋家昊', 13, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (180, 327, '4401', '陈浩宇', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (181, 328, '4402', '陈梦婷', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (182, 329, '4403', '陈兴月', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (183, 330, '4404', '陈奕璇', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (184, 331, '4405', '代东', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (185, 332, '4406', '代煜', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (186, 333, '4407', '管鑫淼', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (187, 334, '4408', '郭力匀', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (188, 335, '4409', '贺莹鑫', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (189, 336, '4410', '姜好', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (190, 337, '4411', '蒋佳明', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (191, 338, '4412', '蒋奕辰', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (192, 339, '4413', '金吉红', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (193, 340, '4414', '李辰傲洋', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (194, 341, '4415', '李旒旖', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (195, 342, '4416', '李若兮', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (196, 343, '4417', '李彦昭', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (197, 344, '4418', '李泽雨', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (198, 345, '4419', '李正东', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (199, 346, '4420', '刘江', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (200, 347, '4421', '卢昆燕', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (201, 348, '4422', '马祥伟', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (202, 349, '4423', '马玉琼', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (203, 350, '4424', '倪荣吉', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (204, 351, '4425', '宁友毅', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (205, 352, '4426', '浦皓', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (206, 353, '4427', '权梓鑫', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (207, 354, '4428', '王雯瑾', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (208, 355, '4429', '王藻', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (209, 356, '4430', '王梓涵4', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (210, 357, '4431', '吴海艳', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (211, 358, '4432', '吴靖瑶', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (212, 359, '4433', '夏雪', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (213, 360, '4434', '谢宗晓', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (214, 361, '4435', '晏贤烨', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (215, 362, '4436', '晏梓宸', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (216, 363, '4437', '杨官胤', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (217, 364, '4438', '杨磊', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (218, 365, '4439', '杨雄超', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (219, 366, '4440', '尹恒', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (220, 367, '4441', '尹若婷', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (221, 368, '4442', '尹思源', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (222, 369, '4443', '张澜馨', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (223, 370, '4444', '张萌', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (224, 371, '4445', '张梦涵', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (225, 372, '4446', '张正昕', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (226, 373, '4447', '赵得屹', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (227, 374, '4448', '赵敏琪', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (228, 375, '4449', '赵梓涵', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (229, 376, '4450', '郑婷', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (230, 377, '4451', '周朝园', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (231, 378, '4452', '周文静', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (232, 379, '4453', '周心圆', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (233, 380, '4454', '周孜轩', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (234, 381, '4455', '朱昱光', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (235, 382, '4456', '朱珠', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (236, 383, '4457', '邹安治', 14, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (237, 384, '3458', '庄雨微', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (238, 385, '4501', '陈金丽', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (239, 386, '4502', '陈馨怡', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (240, 387, '4503', '陈娅宣', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (241, 388, '4504', '代涛', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (242, 389, '4505', '丁怡', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (243, 390, '4506', '段应旺', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (244, 391, '4507', '冯莹', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (245, 392, '4508', '桂智宸', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (246, 393, '4510', '胡项帆', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (247, 394, '4511', '蒋院梅', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (248, 395, '4512', '李峻熙', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (249, 396, '4513', '李太行', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (250, 397, '4514', '李腾', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (251, 398, '4515', '李欣蕊', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (252, 399, '4516', '李正楠', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (253, 400, '4517', '李梓涵', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (254, 401, '4518', '刘芳州', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (255, 402, '4519', '刘锦越', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (256, 403, '4520', '刘莉婷', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (257, 404, '4521', '刘明瑞', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (258, 405, '4522', '刘文博', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (259, 406, '4523', '刘一冉', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (260, 407, '4524', '刘怡菡', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (261, 408, '4525', '陆玉钒', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (262, 409, '4526', '罗永康', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (263, 410, '4527', '马勋晖', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (264, 411, '4528', '缪迪', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (265, 412, '4529', '宁一帆', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (266, 413, '4530', '任清淏', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (267, 414, '4531', '石璨菡', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (268, 415, '4532', '宋承昊', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (269, 416, '4533', '苏成可', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (270, 417, '4534', '汤照升', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (271, 418, '4535', '田露', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (272, 419, '4536', '万盛阳', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (273, 420, '4537', '王芳', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (274, 421, '4538', '王梦婕', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (275, 422, '4539', '王然微', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (276, 423, '4540', '王润灵', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (277, 424, '4541', '王姝', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (278, 425, '4542', '王鑫瑞', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (279, 426, '4543', '王艳娟', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (280, 427, '4544', '王一帆', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (281, 428, '4545', '王梓涵5', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (282, 429, '4546', '伍清馨', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (283, 430, '4547', '杨可欣', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (284, 431, '4548', '杨时瑞', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (285, 432, '4549', '杨洋', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (286, 433, '4550', '尹正杰', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (287, 434, '4551', '尹卓', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (288, 435, '4552', '张微婧', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (289, 436, '4553', '张雅楠', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (290, 437, '4554', '张峪宁', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (291, 438, '4555', '周鸿', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (292, 439, '4556', '周民洋', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (293, 440, '4557', '和钰欣', 15, 4, '0', '2026-03-07 18:07:16.504866');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (294, 441, '3101', '曹子珺', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (295, 442, '3102', '陈玟憙', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (296, 443, '3103', '陈宇', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (297, 444, '3104', '陈梓榆', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (298, 445, '3105', '崔天雄', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (299, 446, '3107', '单敬骁', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (300, 447, '3108', '道泽鑫', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (301, 448, '3109', '段富敏', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (302, 449, '3110', '范秋菊', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (303, 450, '3111', '冯吉铜', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (304, 451, '3112', '桂浩云', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (305, 452, '3113', '郭书衔', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (306, 453, '3114', '黄毅', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (307, 454, '3115', '姜林遇', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (308, 455, '3116', '蒋克松', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (309, 456, '3117', '康竞丹', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (310, 457, '3118', '孔维和', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (311, 458, '3119', '李炳涵', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (312, 459, '3120', '李昊阳', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (313, 460, '3121', '李瑞欣', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (314, 461, '3122', '李星谊', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (315, 462, '3123', '李予曦', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (316, 463, '3124', '李昱圻', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (317, 464, '3125', '李元淼', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (318, 465, '3126', '聂馨', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (319, 466, '3127', '钱浩然', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (320, 467, '3128', '邱程瑞', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (321, 468, '3129', '束世晨', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (322, 469, '3130', '宋紫萌', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (323, 470, '3131', '孙瑞', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (324, 471, '3132', '孙懿轩', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (325, 472, '3133', '汤雅菡', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (326, 473, '3134', '王传博', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (327, 474, '3135', '王锦', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (328, 475, '3136', '王入希', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (329, 476, '3137', '王瑞1', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (330, 477, '3138', '王烨', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (331, 478, '3139', '韦泓印', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (332, 479, '3140', '吴锦奇', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (333, 480, '3141', '谢文峰', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (334, 481, '3142', '许雅琼', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (335, 482, '3143', '姚宛妤', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (336, 483, '3144', '易文博', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (337, 484, '3145', '殷祥凌', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (338, 485, '3146', '尹若洢', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (339, 486, '3147', '余热', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (340, 487, '3148', '余欣', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (341, 488, '3149', '张高冉', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (342, 489, '3150', '张官雯', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (343, 490, '3151', '赵德忠', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (344, 491, '3152', '郑硕', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (345, 492, '3153', '郑阳', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (346, 493, '3154', '周情缘', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (347, 494, '3155', '周思彤', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (348, 495, '3156', '朱硕', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (349, 496, '3157', '庄程凯', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (350, 497, '3158', '龙锦潇', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (351, 498, '3310', '代姝琰', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (352, 499, '3544', '赵泳新', 1, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (353, 500, '3201', '高馨雅', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (354, 501, '3202', '金泓', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (355, 502, '3203', '邹明耀', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (356, 503, '3204', '尹其参', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (357, 504, '3205', '朱友倩', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (358, 505, '3206', '石砚清', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (359, 506, '3207', '周靖凯', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (360, 507, '3208', '陈熙涵', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (361, 508, '3209', '刘语萱', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (362, 509, '3210', '张倩瑜', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (363, 510, '3211', '韩铭锐', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (364, 511, '3212', '刘家榛', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (365, 512, '3213', '母译心', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (366, 513, '3214', '陈梦瑶', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (367, 514, '3215', '刘馨', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (368, 515, '3216', '邱国睿', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (369, 516, '3217', '王启航', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (370, 517, '3218', '锁帆', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (371, 518, '3219', '肖泽旭', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (372, 519, '3220', '余双文', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (373, 520, '3221', '曹满莲', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (374, 521, '3222', '戴桠楠', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (375, 522, '3223', '陈勋坤', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (376, 523, '3224', '李若菡', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (377, 524, '3225', '李卓恒', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (378, 525, '3226', '徐春媛', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (379, 526, '3227', '杨皓钦', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (380, 527, '3228', '顾洪谨', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (381, 528, '3229', '王开睿', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (382, 529, '3230', '熊梓君', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (383, 530, '3231', '杨琳坚', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (384, 531, '3232', '朱啟萌', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (385, 532, '3233', '康恒', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (386, 533, '3234', '颜成坤', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (387, 534, '3235', '杨立', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (388, 535, '3236', '陈屿珊', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (389, 536, '3237', '李品兑', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (390, 537, '3238', '钟翛然', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (391, 538, '3239', '何鑫', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (392, 539, '3240', '邹学琼', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (393, 540, '3241', '赵万源', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (394, 541, '3242', '解天治', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (395, 542, '3243', '施江楠', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (396, 543, '3244', '康泰然', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (397, 544, '3245', '陈彦臣', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (398, 545, '3246', '田泓彦', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (399, 546, '3247', '陈达昊', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (400, 547, '3248', '丁俊宇', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (401, 548, '3249', '黄诗语', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (402, 549, '3250', '吕玭稀', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (403, 550, '3251', '毛千予', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (404, 551, '3252', '彭熙倬', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (405, 552, '3253', '宋弥南', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (406, 553, '3254', '肖馨雅', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (407, 554, '3255', '杨斯淇', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (408, 555, '3256', '赵钒壹', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (409, 556, '3257', '吕欣', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (410, 557, '3258', '沈梦烯', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (411, 558, '3259', '苏钰涵', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (412, 559, '3262', '贾莉雅', 2, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (413, 560, '3106', '戴龙鑫', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (414, 561, '3301', '毕广涛', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (415, 562, '3302', '毕泽云', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (416, 563, '3303', '蔡雨润', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (417, 564, '3304', '陈吉星', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (418, 565, '3305', '陈禹霏', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (419, 566, '3306', '崔梦涵', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (420, 567, '3307', '代冯之', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (421, 568, '3308', '代龙珠', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (422, 569, '3311', '杜城', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (423, 570, '3312', '高华地', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (424, 571, '3313', '耿德成', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (425, 572, '3314', '芶子优', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (426, 573, '3315', '桂钎浩', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (427, 574, '3316', '胡静', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (428, 575, '3317', '姜山', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (429, 576, '3318', '李冬雨', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (430, 577, '3319', '李佳', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (431, 578, '3320', '李军蓉', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (432, 579, '3321', '李泊锋', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (433, 580, '3322', '李茹玉', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (434, 581, '3323', '李思源', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (435, 582, '3324', '李兴峰', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (436, 583, '3325', '李媛红', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (437, 584, '3326', '李泽楷', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (438, 585, '3327', '刘祺', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (439, 586, '3328', '罗春夕', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (440, 587, '3329', '罗廷孟', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (441, 588, '3330', '马欣然', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (442, 589, '3331', '孟守懿', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (443, 590, '3332', '浦雅迪', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (444, 591, '3333', '沈瑞捷', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (445, 592, '3334', '汤紫涵', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (446, 593, '3335', '唐伟', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (447, 594, '3336', '王茂语', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (448, 595, '3337', '王天越', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (449, 596, '3338', '王文垲', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (450, 597, '3339', '王曦婷', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (451, 598, '3340', '王艺诺', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (452, 599, '3341', '王子瑞', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (453, 600, '3342', '王梓欣', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (454, 601, '3343', '肖弼开', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (455, 602, '3344', '严宁康杰', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (456, 603, '3345', '晏合娇', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (457, 604, '3346', '杨民旭', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (458, 605, '3347', '杨舒然', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (459, 606, '3348', '杨雅婕', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (460, 607, '3349', '袁铱蔚', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (461, 608, '3350', '岳昊', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (462, 609, '3351', '张佳丽', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (463, 610, '3352', '张旭尧', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (464, 611, '3353', '赵国尧', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (465, 612, '3354', '赵婧彤', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (466, 613, '3355', '朱恩泱', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (467, 614, '3356', '朱祉亦', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (468, 615, '3357', '徐磊', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (469, 616, '3508', '代冯兮', 7, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (470, 617, '3401', '安塞玲', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (471, 618, '3402', '包崇锦', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (472, 619, '3404', '陈红志', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (473, 620, '3405', '陈梦圆', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (474, 621, '3406', '陈顺达', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (475, 622, '3407', '陈漪潼', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (476, 623, '3408', '褚秋奕', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (477, 624, '3409', '丁俊衔', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (478, 625, '3410', '付文智', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (479, 626, '3411', '高金阔', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (480, 627, '3412', '桂藤菁', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (481, 628, '3413', '何雨润', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (482, 629, '3414', '胡光秋', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (483, 630, '3415', '胡涵杰', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (484, 631, '3416', '华力莹', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (485, 632, '3417', '黄礼芯', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (486, 633, '3418', '黄曼淇', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (487, 634, '3419', '陈邦仙', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (488, 635, '3420', '李帛燃', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (489, 636, '3421', '李冬成', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (490, 637, '3422', '李文平', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (491, 638, '3423', '林思琦', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (492, 639, '3424', '刘承烨', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (493, 640, '3425', '刘吉昊', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (494, 641, '3426', '刘蕾', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (495, 642, '3427', '刘思绫', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (496, 643, '3428', '卢禹兴', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (497, 644, '3429', '吕贤宇', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (498, 645, '3430', '孟福曦', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (499, 646, '3431', '缪应琼', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (500, 647, '3432', '裴浩翔', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (501, 648, '3433', '彭莹', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (502, 649, '3434', '邱琪茸', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (503, 650, '3435', '阮欣颖', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (504, 651, '3436', '舒彦', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (505, 652, '3437', '孙颢铭', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (506, 653, '3438', '田宇欣', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (507, 654, '3439', '王君瑞', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (508, 655, '3440', '王瑞4', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (509, 656, '3441', '王思博', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (510, 657, '3442', '王梓诚', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (511, 658, '3443', '吴君彩', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (512, 659, '3444', '吴青阳', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (513, 660, '3445', '徐浩瑀', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (514, 661, '3446', '徐祥盛', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (515, 662, '3447', '严宁康博', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (516, 663, '3448', '余其洋', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (517, 664, '3449', '袁萌', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (518, 665, '3450', '张厚林', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (519, 666, '3451', '黄滢睿', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (520, 667, '3452', '张钰滢', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (521, 668, '3453', '郑成柯', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (522, 669, '3454', '周子珺', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (523, 670, '3455', '周祖宇', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (524, 671, '3456', '朱思颖', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (525, 672, '3457', '朱雨潼', 8, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (526, 673, '3309', '代荣泽', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (527, 674, '3501', '曾繁通', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (528, 675, '3502', '曾玺蓉', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (529, 676, '3503', '陈本佳', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (530, 677, '3504', '陈柯函', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (531, 678, '3505', '陈森', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (532, 679, '3506', '陈铱涵', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (533, 680, '3507', '崔汝霞', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (534, 681, '3509', '戴大辉', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (535, 682, '3510', '党颖瑶', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (536, 683, '3511', '杜钰滢', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (537, 684, '3512', '高健铭', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (538, 685, '3513', '何进', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (539, 686, '3514', '胡济鲲', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (540, 687, '3515', '胡宇', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (541, 688, '3516', '黄海航', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (542, 689, '3517', '金源峰', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (543, 690, '3518', '孔文玉', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (544, 691, '3519', '李泽宸', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (545, 692, '3520', '林玟君', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (546, 693, '3521', '凌俊杰', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (547, 694, '3522', '刘思圻', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (548, 695, '3523', '刘思谣', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (549, 696, '3524', '罗冰杰', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (550, 697, '3525', '马想云', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (551, 698, '3526', '宁静', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (552, 699, '3527', '宁思萌', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (553, 700, '3528', '谭庆本', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (554, 701, '3529', '唐铭望', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (555, 702, '3530', '王春洋', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (556, 703, '3531', '王玘萌', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (557, 704, '3532', '王蓉', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (558, 705, '3533', '王圣淼', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (559, 706, '3534', '王姝杨', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (560, 707, '3535', '王思涵', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (561, 708, '3536', '温力源', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (562, 709, '3537', '吴加一', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (563, 710, '3538', '吴金凤', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (564, 711, '3539', '肖弼灏', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (565, 712, '3540', '肖含', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (566, 713, '3541', '谢滨羽', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (567, 714, '3542', '徐琳媛', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (568, 715, '3543', '鄢晨茜', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (569, 716, '3545', '杨涛', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (570, 717, '3546', '杨兴权', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (571, 718, '3547', '杨焱博', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (572, 719, '3548', '袁子鑫', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (573, 720, '3549', '张丽卓', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (574, 721, '3550', '张洺浥', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (575, 722, '3551', '张仁熙', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (576, 723, '3552', '张天鹏', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (577, 724, '3553', '赵庆灵', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (578, 725, '3554', '郑钰澄', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (579, 726, '3555', '朱航辰', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (580, 727, '3556', '朱欣怡', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (581, 728, '3557', '邹潇', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (582, 729, '3559', '王霄萌', 9, 1, '0', '2026-03-07 18:12:51.650929');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (583, 730, '3562', '高连杜', 9, 1, '0', '2026-03-07 18:12:51.650929');


--
-- TOC entry 5328 (class 0 OID 89801)
-- Dependencies: 222
-- Data for Name: sys_class; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (3, '高二1班', 2, '0', '2026-03-06 10:31:31.90755');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (4, '高二2班', 2, '0', '2026-03-06 10:31:31.908108');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (5, '高三1班', 3, '0', '2026-03-06 10:31:31.908593');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (6, '高三2班', 3, '0', '2026-03-06 10:31:31.909237');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (1, '1班', 1, '0', '2026-03-06 10:31:31.906116');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (2, '2班', 1, '0', '2026-03-06 10:31:31.907071');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (7, '3班', 1, '0', '2026-03-06 15:24:00.750949');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (8, '4班', 1, '0', '2026-03-06 15:24:04.811372');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (9, '5班', 1, '0', '2026-03-06 15:24:08.855576');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (10, '6班', 1, '0', '2026-03-06 15:24:14.037698');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (11, '1班', 4, '0', '2026-03-06 17:57:39.033393');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (12, '2班', 4, '0', '2026-03-06 17:57:45.405224');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (13, '3班', 4, '0', '2026-03-06 17:57:50.353635');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (14, '4班', 4, '0', '2026-03-06 17:57:55.667873');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (15, '5班', 4, '0', '2026-03-06 17:58:00.082344');
INSERT INTO public.sys_class (id, class_name, grade_id, del_flag, create_time) VALUES (16, '6班', 4, '0', '2026-03-06 17:58:04.570138');


--
-- TOC entry 5362 (class 0 OID 91287)
-- Dependencies: 256
-- Data for Name: sys_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-03-06 14:47:11.351081', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO public.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-03-06 14:47:11.351665', '', NULL, '初始化密码 123456');
INSERT INTO public.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-03-06 14:47:11.351867', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO public.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2026-03-06 14:47:11.35208', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO public.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-03-06 14:47:11.35234', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO public.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-03-06 14:47:11.352607', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO public.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-03-06 14:47:11.352829', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO public.sys_config (config_id, config_name, config_key, config_value, config_type, create_by, create_time, update_by, update_time, remark) VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-03-06 14:47:11.353028', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');


--
-- TOC entry 5342 (class 0 OID 91111)
-- Dependencies: 236
-- Data for Name: sys_dept; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.195905', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.196963', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.197308', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.197652', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.197973', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.198276', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.198572', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.198882', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.199192', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.199481', '', NULL);


--
-- TOC entry 5360 (class 0 OID 91267)
-- Dependencies: 254
-- Data for Name: sys_dict_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-03-06 14:47:11.336263', '', NULL, '性别男');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-03-06 14:47:11.336862', '', NULL, '性别女');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-03-06 14:47:11.337096', '', NULL, '性别未知');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-03-06 14:47:11.337376', '', NULL, '显示菜单');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:11.337617', '', NULL, '隐藏菜单');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-03-06 14:47:11.337789', '', NULL, '正常状态');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:11.337958', '', NULL, '停用状态');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-03-06 14:47:11.338111', '', NULL, '正常状态');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:11.338367', '', NULL, '停用状态');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-03-06 14:47:11.338608', '', NULL, '默认分组');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-03-06 14:47:11.338854', '', NULL, '系统分组');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-03-06 14:47:11.339124', '', NULL, '系统默认是');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:11.339411', '', NULL, '系统默认否');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-03-06 14:47:11.339675', '', NULL, '通知');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-03-06 14:47:11.339968', '', NULL, '公告');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-03-06 14:47:11.340231', '', NULL, '正常状态');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:11.340526', '', NULL, '关闭状态');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-06 14:47:11.340867', '', NULL, '其他操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-06 14:47:11.34126', '', NULL, '新增操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-03-06 14:47:11.341542', '', NULL, '修改操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:11.3418', '', NULL, '删除操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-03-06 14:47:11.341998', '', NULL, '授权操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-06 14:47:11.342273', '', NULL, '导出操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-06 14:47:11.342575', '', NULL, '导入操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:11.342866', '', NULL, '强退操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-03-06 14:47:11.34317', '', NULL, '生成操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:11.343432', '', NULL, '清空操作');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-03-06 14:47:11.343708', '', NULL, '正常状态');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:11.343933', '', NULL, '停用状态');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (101, 1, '系统用户', '00', 'sys_user_type', '', '', 'Y', '0', 'admin', '2026-03-06 14:47:31.685196', '', NULL, '系统管理员等');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (102, 2, '学生', '01', 'sys_user_type', '', 'primary', 'N', '0', 'admin', '2026-03-06 14:47:31.686115', '', NULL, '学生用户');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (103, 3, '教师', '02', 'sys_user_type', '', 'success', 'N', '0', 'admin', '2026-03-06 14:47:31.686599', '', NULL, '教师用户');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (104, 1, '启用', '1', 'eva_question_status', '', 'success', 'Y', '0', 'admin', '2026-03-06 14:47:45.864134', '', NULL, '');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (105, 2, '停用', '0', 'eva_question_status', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:45.86505', '', NULL, '');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (106, 1, '周一', '1', 'course_week_day', '', 'primary', 'N', '0', 'admin', '2026-03-06 14:47:46.110708', '', NULL, '');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (107, 2, '周二', '2', 'course_week_day', '', 'success', 'N', '0', 'admin', '2026-03-06 14:47:46.112098', '', NULL, '');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (108, 3, '周三', '3', 'course_week_day', '', 'info', 'N', '0', 'admin', '2026-03-06 14:47:46.112628', '', NULL, '');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (109, 4, '周四', '4', 'course_week_day', '', 'warning', 'N', '0', 'admin', '2026-03-06 14:47:46.112979', '', NULL, '');
INSERT INTO public.sys_dict_data (dict_code, dict_sort, dict_label, dict_value, dict_type, css_class, list_class, is_default, status, create_by, create_time, update_by, update_time, remark) VALUES (110, 5, '周五', '5', 'course_week_day', '', 'danger', 'N', '0', 'admin', '2026-03-06 14:47:46.113323', '', NULL, '');


--
-- TOC entry 5358 (class 0 OID 91250)
-- Dependencies: 252
-- Data for Name: sys_dict_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-03-06 14:47:11.323926', '', NULL, '用户性别列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-03-06 14:47:11.324693', '', NULL, '菜单状态列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-03-06 14:47:11.324976', '', NULL, '系统开关列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-03-06 14:47:11.325261', '', NULL, '任务状态列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-03-06 14:47:11.325521', '', NULL, '任务分组列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-03-06 14:47:11.325828', '', NULL, '系统是否列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-03-06 14:47:11.326106', '', NULL, '通知类型列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-03-06 14:47:11.326407', '', NULL, '通知状态列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-03-06 14:47:11.326669', '', NULL, '操作类型列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-03-06 14:47:11.326903', '', NULL, '登录状态列表');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (101, '用户类型', 'sys_user_type', '0', 'admin', '2026-03-06 14:47:31.68365', '', NULL, '用户类型：系统用户/学生/教师');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (102, '评价题目状态', 'eva_question_status', '0', 'admin', '2026-03-06 14:47:45.861982', '', NULL, '1启用 0停用');
INSERT INTO public.sys_dict_type (dict_id, dict_name, dict_type, status, create_by, create_time, update_by, update_time, remark) VALUES (103, '课程星期', 'course_week_day', '0', 'admin', '2026-03-06 14:47:46.109001', '', NULL, '课程上课星期：1周一至5周五');


--
-- TOC entry 5326 (class 0 OID 89793)
-- Dependencies: 220
-- Data for Name: sys_grade; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_grade (id, grade_name, sort, del_flag, create_time) VALUES (3, '高三', 3, '2', '2026-03-06 10:31:31.905699');
INSERT INTO public.sys_grade (id, grade_name, sort, del_flag, create_time) VALUES (2, '高二', 2, '2', '2026-03-06 10:31:31.905264');
INSERT INTO public.sys_grade (id, grade_name, sort, del_flag, create_time) VALUES (1, '八年级', 1, '0', '2026-03-06 10:31:31.904369');
INSERT INTO public.sys_grade (id, grade_name, sort, del_flag, create_time) VALUES (4, '七年级', 0, '0', '2026-03-06 17:57:31.714221');


--
-- TOC entry 5366 (class 0 OID 91321)
-- Dependencies: 260
-- Data for Name: sys_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-03-06 14:47:11.369457', '', NULL, '');
INSERT INTO public.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(''ry'')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-03-06 14:47:11.370033', '', NULL, '');
INSERT INTO public.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(''ry'', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-03-06 14:47:11.370342', '', NULL, '');


--
-- TOC entry 5368 (class 0 OID 91339)
-- Dependencies: 262
-- Data for Name: sys_job_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5364 (class 0 OID 91303)
-- Dependencies: 258
-- Data for Name: sys_logininfor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '1', '验证码错误', '2026-03-06 17:56:09.777266');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-06 17:56:11.973031');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-06 20:26:58.309084');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-06 22:08:49.011201');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-06 22:46:28.621959');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-07 06:56:10.919598');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-07 17:58:35.518978');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (108, '4101', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-03-07 18:09:01.239223');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (109, '4101', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '退出成功', '2026-03-07 18:15:12.638335');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (110, '3101', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-03-07 18:15:21.112118');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-07 21:28:41.166553');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-03-07 21:43:59.941668');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-07 21:48:51.448233');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '退出成功', '2026-03-07 21:56:30.274195');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-07 21:56:50.89641');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '退出成功', '2026-03-07 22:01:54.372756');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-07 22:02:04.324206');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '退出成功', '2026-03-07 22:21:05.426711');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-07 22:22:28.570818');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (120, '3101', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-03-08 00:13:29.124838');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-08 20:35:29.321012');


--
-- TOC entry 5350 (class 0 OID 91178)
-- Dependencies: 244
-- Data for Name: sys_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-03-06 14:47:11.234513', '', NULL, '用户管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-03-06 14:47:11.23478', '', NULL, '角色管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-03-06 14:47:11.235033', '', NULL, '菜单管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-03-06 14:47:11.235269', '', NULL, '部门管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-03-06 14:47:11.235506', '', NULL, '岗位管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-03-06 14:47:11.235777', '', NULL, '字典管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-03-06 14:47:11.236129', '', NULL, '参数设置菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-03-06 14:47:11.236422', '', NULL, '通知公告菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-03-06 14:47:11.236688', '', NULL, '日志管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-03-06 14:47:11.236956', '', NULL, '在线用户菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-03-06 14:47:11.237234', '', NULL, '定时任务菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-03-06 14:47:11.237508', '', NULL, '数据监控菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-03-06 14:47:11.237783', '', NULL, '服务监控菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-03-06 14:47:11.238062', '', NULL, '缓存监控菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-03-06 14:47:11.238423', '', NULL, '缓存列表菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-03-06 14:47:11.238687', '', NULL, '表单构建菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-03-06 14:47:11.238958', '', NULL, '代码生成菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-03-06 14:47:11.239247', '', NULL, '系统接口菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-03-06 14:47:11.239592', '', NULL, '操作日志菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-03-06 14:47:11.239861', '', NULL, '登录日志菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-03-06 14:47:11.240101', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-03-06 14:47:11.240369', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-03-06 14:47:11.240617', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-03-06 14:47:11.240942', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-03-06 14:47:11.24125', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-03-06 14:47:11.241552', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-03-06 14:47:11.241806', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-03-06 14:47:11.242028', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-03-06 14:47:11.24228', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-03-06 14:47:11.242515', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-03-06 14:47:11.242763', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-03-06 14:47:11.243011', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-03-06 14:47:11.243225', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-03-06 14:47:11.243417', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-03-06 14:47:11.243653', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-03-06 14:47:11.244067', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-03-06 14:47:11.244436', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-03-06 14:47:11.24479', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-03-06 14:47:11.245061', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-03-06 14:47:11.245335', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-03-06 14:47:11.245558', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-03-06 14:47:11.245822', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-03-06 14:47:11.246168', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-03-06 14:47:11.246426', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-03-06 14:47:11.246698', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-03-06 14:47:11.246979', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-03-06 14:47:11.247271', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-03-06 14:47:11.247707', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-03-06 14:47:11.248038', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1, '系统管理', 0, 7, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-03-06 14:47:11.232981', 'admin', '2026-03-06 15:14:03.009347', '系统管理目录');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统工具', 0, 9, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-03-06 14:47:11.233934', 'admin', '2026-03-06 15:14:11.955115', '系统工具目录');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-03-06 14:47:11.248352', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-03-06 14:47:11.249793', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-03-06 14:47:11.250104', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-03-06 14:47:11.250376', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-03-06 14:47:11.250599', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-03-06 14:47:11.250777', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-03-06 14:47:11.25093', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-03-06 14:47:11.25112', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-03-06 14:47:11.251351', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-03-06 14:47:11.251555', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-03-06 14:47:11.251724', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-03-06 14:47:11.251922', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-03-06 14:47:11.252139', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-03-06 14:47:11.252364', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-03-06 14:47:11.252565', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-03-06 14:47:11.252803', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-03-06 14:47:11.253093', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-03-06 14:47:11.253382', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-03-06 14:47:11.253647', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-03-06 14:47:11.253899', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-03-06 14:47:11.254195', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-03-06 14:47:11.254448', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-03-06 14:47:11.254741', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-03-06 14:47:11.254952', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-03-06 14:47:11.255212', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-03-06 14:47:11.255474', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-03-06 14:47:11.255715', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-03-06 14:47:11.25604', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-03-06 14:47:11.25638', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-03-06 14:47:11.256658', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-03-06 14:47:11.256957', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-03-06 14:47:11.257268', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2000, '选修课管理', 0, 5, 'course', NULL, '', '', 1, 0, 'M', '0', '0', '', 'education', 'admin', '2026-03-06 14:47:31.689546', '', NULL, '选修课管理目录');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2100, '选课中心', 0, 6, 'selection', NULL, '', '', 1, 0, 'M', '0', '0', '', 'shopping', 'admin', '2026-03-06 14:47:31.690363', '', NULL, '学生选课中心');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2001, '学期管理', 2000, 1, 'semester', 'course/semester/index', '', '', 1, 0, 'C', '0', '0', 'course:semester:list', 'date', 'admin', '2026-03-06 14:47:31.690816', '', NULL, '学期管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2002, '学期查询', 2001, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:semester:query', '#', 'admin', '2026-03-06 14:47:31.691193', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2003, '学期新增', 2001, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:semester:add', '#', 'admin', '2026-03-06 14:47:31.691579', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2004, '学期修改', 2001, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:semester:edit', '#', 'admin', '2026-03-06 14:47:31.691934', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2005, '学期删除', 2001, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:semester:remove', '#', 'admin', '2026-03-06 14:47:31.692255', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2111, '提交选课', 2110, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:selection:submit', '#', 'admin', '2026-03-06 14:47:45.367522', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2112, '剩余名额', 2110, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:selection:quota', '#', 'admin', '2026-03-06 14:47:45.368059', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2120, '我的选课', 2100, 2, 'my', 'selection/my', '', '', 1, 0, 'C', '0', '0', 'course:selection:my', 'list', 'admin', '2026-03-06 14:47:45.368508', '', NULL, '我的选课');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2121, '退课', 2120, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:selection:drop', '#', 'admin', '2026-03-06 14:47:45.36907', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2030, '课程管理', 2000, 4, 'course', 'course/course/index', '', 'CourseManage', 1, 0, 'C', '0', '0', 'course:course:list', 'list', 'admin', '2026-03-06 14:47:45.503834', '', NULL, '课程管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2031, '课程查询', 2030, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:query', '#', 'admin', '2026-03-06 14:47:45.505076', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2032, '课程新增', 2030, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:add', '#', 'admin', '2026-03-06 14:47:45.505442', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2033, '课程修改', 2030, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:edit', '#', 'admin', '2026-03-06 14:47:45.505771', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2034, '课程删除', 2030, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:remove', '#', 'admin', '2026-03-06 14:47:45.506063', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2035, '课程导出', 2030, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'course:course:export', '#', 'admin', '2026-03-06 14:47:45.506423', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2010, '年级班级管理', 2000, 2, 'grade', 'course/grade/index', '', '', 1, 0, 'C', '0', '0', 'course:grade:list', 'tree', 'admin', '2026-03-06 14:47:45.62497', '', NULL, '年级班级管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2011, '年级查询', 2010, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:grade:query', '#', 'admin', '2026-03-06 14:47:45.626505', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2012, '年级新增', 2010, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:grade:add', '#', 'admin', '2026-03-06 14:47:45.62683', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2013, '年级修改', 2010, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:grade:edit', '#', 'admin', '2026-03-06 14:47:45.627192', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2014, '年级删除', 2010, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:grade:remove', '#', 'admin', '2026-03-06 14:47:45.627776', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2015, '班级查询', 2010, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:query', '#', 'admin', '2026-03-06 14:47:45.628361', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2016, '班级新增', 2010, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:add', '#', 'admin', '2026-03-06 14:47:45.629181', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2017, '班级修改', 2010, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:edit', '#', 'admin', '2026-03-06 14:47:45.630003', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2018, '班级删除', 2010, 8, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:remove', '#', 'admin', '2026-03-06 14:47:45.630389', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2019, '班级列表', 2010, 9, '', '', '', '', 1, 0, 'F', '0', '0', 'course:class:list', '#', 'admin', '2026-03-06 14:47:45.630704', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2020, '学生管理', 2000, 3, 'student', 'course/student/index', '', '', 1, 0, 'C', '0', '0', 'course:student:list', 'user', 'admin', '2026-03-06 14:47:45.741687', '', NULL, '学生管理菜单');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2021, '学生查询', 2020, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:query', '#', 'admin', '2026-03-06 14:47:45.743683', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2022, '学生新增', 2020, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:add', '#', 'admin', '2026-03-06 14:47:45.74404', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2023, '学生修改', 2020, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:edit', '#', 'admin', '2026-03-06 14:47:45.744879', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2024, '学生删除', 2020, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:remove', '#', 'admin', '2026-03-06 14:47:45.745305', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2025, '学生导入', 2020, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:import', '#', 'admin', '2026-03-06 14:47:45.745638', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2026, '学生导出', 2020, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'course:student:export', '#', 'admin', '2026-03-06 14:47:45.745935', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2040, '评价管理', 2000, 5, 'evaluation', 'course/evaluation/index', '', '', 1, 0, 'C', '0', '0', 'course:evaluation:list', 'star', 'admin', '2026-03-06 14:47:45.865411', '', NULL, '评价题目管理');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2041, '题目查询', 2040, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:evaluation:query', '#', 'admin', '2026-03-06 14:47:45.866061', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2042, '题目新增', 2040, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:evaluation:add', '#', 'admin', '2026-03-06 14:47:45.866433', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2043, '题目修改', 2040, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:evaluation:edit', '#', 'admin', '2026-03-06 14:47:45.8668', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2044, '题目删除', 2040, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:evaluation:remove', '#', 'admin', '2026-03-06 14:47:45.867107', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2130, '课程评价', 2100, 3, 'evaluation', 'selection/evaluation', '', '', 1, 0, 'C', '0', '0', 'course:evaluation:student', 'edit', 'admin', '2026-03-06 14:47:45.867408', '', NULL, '学生对已选课程评分');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2, '系统监控', 0, 8, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-03-06 14:47:11.233631', 'admin', '2026-03-06 15:14:07.510749', '系统监控目录');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (4, '若依官网', 0, 10, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '1', '1', '', 'guide', 'admin', '2026-03-06 14:47:11.234237', 'admin', '2026-03-06 15:14:17.858589', '若依官网地址');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2110, '课程列表', 2100, 1, 'cart', 'selection/index', '', '', 1, 0, 'C', '0', '0', 'course:selection:cart', 'table', 'admin', '2026-03-06 14:47:45.36553', 'admin', '2026-03-07 18:10:34.852173', '选课车');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2050, '教师考核', 2000, 6, 'teacherAssessment', 'course/teacherAssessment/index', '', '', 1, 0, 'C', '0', '0', 'course:teacherAssessment:list', 'peoples', 'admin', '2026-03-07 21:55:03.082577', '', NULL, '教师考核：按学生评分计算平均分、查看详情、导出');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2051, '考核查询', 2050, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:query', '#', 'admin', '2026-03-07 21:55:17.850394', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2052, '考核导出', 2050, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:export', '#', 'admin', '2026-03-07 21:55:17.850394', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2053, '考核编辑', 2050, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:edit', '#', 'admin', '2026-03-07 21:55:17.850394', '', NULL, '');
INSERT INTO public.sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query, route_name, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark) VALUES (2054, '考核删除', 2050, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'course:teacherAssessment:remove', '#', 'admin', '2026-03-07 21:55:17.850394', '', NULL, '');


--
-- TOC entry 5370 (class 0 OID 91350)
-- Dependencies: 264
-- Data for Name: sys_notice; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_notice (notice_id, notice_title, notice_type, notice_content, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', '新版本内容', '0', 'admin', '2026-03-06 14:47:11.384329', '', NULL, '管理员');
INSERT INTO public.sys_notice (notice_id, notice_title, notice_type, notice_content, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', '维护内容', '0', 'admin', '2026-03-06 14:47:11.384875', '', NULL, '管理员');


--
-- TOC entry 5356 (class 0 OID 91223)
-- Dependencies: 250
-- Data for Name: sys_oper_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (101, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"createTime":"2026-03-06 14:47:11","icon":"guide","isCache":"0","isFrame":"0","menuId":4,"menuName":"若依官网","menuType":"M","orderNum":4,"params":{},"parentId":0,"path":"http://ruoyi.vip","perms":"","query":"","routeName":"","status":"1","updateBy":"admin","visible":"1"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:13:51.194218', 32);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (102, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"createTime":"2026-03-06 14:47:11","icon":"system","isCache":"0","isFrame":"1","menuId":1,"menuName":"系统管理","menuType":"M","orderNum":7,"params":{},"parentId":0,"path":"system","perms":"","query":"","routeName":"","status":"0","updateBy":"admin","visible":"0"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:14:03.035369', 18);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (103, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"createTime":"2026-03-06 14:47:11","icon":"monitor","isCache":"0","isFrame":"1","menuId":2,"menuName":"系统监控","menuType":"M","orderNum":8,"params":{},"parentId":0,"path":"monitor","perms":"","query":"","routeName":"","status":"0","updateBy":"admin","visible":"0"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:14:07.539123', 18);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (104, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"createTime":"2026-03-06 14:47:11","icon":"tool","isCache":"0","isFrame":"1","menuId":3,"menuName":"系统工具","menuType":"M","orderNum":9,"params":{},"parentId":0,"path":"tool","perms":"","query":"","routeName":"","status":"0","updateBy":"admin","visible":"0"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:14:11.989978', 23);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (105, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"createTime":"2026-03-06 14:47:11","icon":"guide","isCache":"0","isFrame":"0","menuId":4,"menuName":"若依官网","menuType":"M","orderNum":10,"params":{},"parentId":0,"path":"http://ruoyi.vip","perms":"","query":"","routeName":"","status":"1","updateBy":"admin","visible":"1"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:14:17.874195', 12);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (106, '课程管理', 9, 'com.ruoyi.web.controller.course.CourseController.initSelectionData()', 'POST', 1, 'admin', '研发部门', '/course/course/initSelectionData', '127.0.0.1', '内网IP', '{"semesterId":"1"}', '{"msg":"初始化成功，已清空 0 条选课记录","code":200}', 0, NULL, '2026-03-06 15:14:38.423162', 23);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (107, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/1', '127.0.0.1', '内网IP', '1 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:14:49.24287', 18);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (108, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/2', '127.0.0.1', '内网IP', '2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:14:51.162445', 19);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (109, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/9', '127.0.0.1', '内网IP', '9 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:14:54.972207', 17);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (110, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/3', '127.0.0.1', '内网IP', '3 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:14:57.243429', 12);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (111, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/4', '127.0.0.1', '内网IP', '4 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:14:59.405682', 10);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (112, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/10', '127.0.0.1', '内网IP', '10 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:15:01.394229', 13);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (113, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/5', '127.0.0.1', '内网IP', '5 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:15:03.445679', 12);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (114, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/6', '127.0.0.1', '内网IP', '6 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:15:05.638821', 15);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (115, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/7', '127.0.0.1', '内网IP', '7 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:15:07.278293', 5);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (116, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/course/8', '127.0.0.1', '内网IP', '8 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:15:10.470265', 18);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (117, '课程管理', 5, 'com.ruoyi.web.controller.course.CourseController.importTemplate()', 'POST', 1, 'admin', '研发部门', '/course/course/importTemplate', '127.0.0.1', '内网IP', '', NULL, 0, NULL, '2026-03-06 15:22:47.291375', 806);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (118, '年级管理', 3, 'com.ruoyi.web.controller.course.GradeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/grade/3', '127.0.0.1', '内网IP', '3 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:23:34.389368', 24);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (119, '年级管理', 3, 'com.ruoyi.web.controller.course.GradeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/grade/2', '127.0.0.1', '内网IP', '2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:23:35.803743', 5);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (120, '年级管理', 2, 'com.ruoyi.web.controller.course.GradeController.edit()', 'PUT', 1, 'admin', '研发部门', '/course/grade', '127.0.0.1', '内网IP', '{"createTime":"2026-03-06 10:31:31","delFlag":"0","gradeName":"八年级","id":1,"params":{},"sort":1} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:23:43.869439', 18);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (121, '班级管理', 2, 'com.ruoyi.web.controller.course.ClassController.edit()', 'PUT', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"1班","createTime":"2026-03-06 10:31:31","delFlag":"0","gradeId":1,"gradeName":"八年级","id":1,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:23:49.417862', 7);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (122, '班级管理', 2, 'com.ruoyi.web.controller.course.ClassController.edit()', 'PUT', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"2班","createTime":"2026-03-06 10:31:31","delFlag":"0","gradeId":1,"gradeName":"八年级","id":2,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:23:55.15405', 4);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (123, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"3班","gradeId":1,"id":7,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:24:00.771062', 9);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (124, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"4班","gradeId":1,"id":8,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:24:04.836995', 12);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (125, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"5班","gradeId":1,"id":9,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:24:08.877201', 4);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (126, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"6班","gradeId":1,"id":10,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 15:24:14.071296', 15);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (127, '课程管理', 6, 'com.ruoyi.web.controller.course.CourseController.importData()', 'POST', 1, 'admin', '研发部门', '/course/course/importData', '127.0.0.1', '内网IP', 'false ', '{"msg":"导入完成，成功 0 条，失败 116 条<br/>1、英语口语俱乐部：学期不存在: 2026年春季学期<br/>2、软笔书法与鉴赏：学期不存在: 2026年春季学期<br/>3、英语特训营：学期不存在: 2026年春季学期<br/>4、英语提升营：学期不存在: 2026年春季学期<br/>5、心理学心灵短视频分享课（合上）：学期不存在: 2026年春季学期<br/>6、钢笔淡彩：学期不存在: 2026年春季学期<br/>7、生涯规划及团体辅导：学期不存在: 2026年春季学期<br/>8、篮球：学期不存在: 2026年春季学期<br/>9、篮球校队：学期不存在: 2026年春季学期<br/>10、足球女队：学期不存在: 2026年春季学期<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-06 17:56:34.050562', 6524);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (128, '学期管理', 2, 'com.ruoyi.web.controller.course.SemesterController.edit()', 'PUT', 1, 'admin', '研发部门', '/course/semester', '127.0.0.1', '内网IP', '{"createTime":"2026-03-06 10:31:31","delFlag":"0","endDate":"2026-07-14","id":1,"isCurrent":1,"params":{},"semesterName":"2026年春季学期","startDate":"2026-03-04","updateBy":"admin"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 17:57:07.712861', 20);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (129, '课程管理', 6, 'com.ruoyi.web.controller.course.CourseController.importData()', 'POST', 1, 'admin', '研发部门', '/course/course/importData', '127.0.0.1', '内网IP', 'false ', '{"msg":"导入完成，成功 58 条，失败 58 条<br/>1、英语特训营：年级不存在: 七年级<br/>2、英语提升营：年级不存在: 七年级<br/>3、英语书写训练：年级不存在: 七年级<br/>4、国学课堂：年级不存在: 七年级<br/>5、篆刻：年级不存在: 七年级<br/>6、舞蹈：年级不存在: 七年级<br/>7、心理学心灵短视频分享课（合上）：年级不存在: 七年级<br/>8、羽毛球：年级不存在: 七年级<br/>9、影视后期编辑与制作：年级不存在: 七年级<br/>10、篮球校队：年级不存在: 七年级<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-06 17:57:17.458624', 844);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (130, '年级管理', 1, 'com.ruoyi.web.controller.course.GradeController.add()', 'POST', 1, 'admin', '研发部门', '/course/grade', '127.0.0.1', '内网IP', '{"gradeName":"七年级","id":4,"params":{},"sort":0} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 17:57:31.7451', 18);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (131, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"1班","gradeId":4,"id":11,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 17:57:39.074529', 17);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (132, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"2班","gradeId":4,"id":12,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 17:57:45.428326', 4);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (133, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"3班","gradeId":4,"id":13,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 17:57:50.379093', 12);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (134, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"4班","gradeId":4,"id":14,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 17:57:55.704743', 12);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (135, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"5班","gradeId":4,"id":15,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 17:58:00.100994', 4);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (136, '班级管理', 1, 'com.ruoyi.web.controller.course.ClassController.add()', 'POST', 1, 'admin', '研发部门', '/course/class', '127.0.0.1', '内网IP', '{"className":"6班","gradeId":4,"id":16,"params":{}} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-06 17:58:04.595391', 11);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (137, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1,2,3,4,5,6] ', '{"msg":"成功删除 6 名学生","code":200}', 0, NULL, '2026-03-06 18:27:05.60228', 413);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (138, '课程管理', 9, 'com.ruoyi.web.controller.course.CourseController.initSelectionData()', 'POST', 1, 'admin', '研发部门', '/course/course/initSelectionData', '127.0.0.1', '内网IP', '{"semesterId":"1"}', '{"msg":"初始化成功，已清空 0 条选课记录","code":200}', 0, NULL, '2026-03-06 23:05:05.048376', 33);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (139, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入成功！共 287 条<br/>1、学号 4101 导入成功<br/>2、学号 4102 导入成功<br/>3、学号 4103 导入成功<br/>4、学号 4104 导入成功<br/>5、学号 4105 导入成功<br/>6、学号 4106 导入成功<br/>7、学号 4107 导入成功<br/>8、学号 4108 导入成功<br/>9、学号 4109 导入成功<br/>10、学号 4110 导入成功<br/>11、学号 4111 导入成功<br/>12、学号 4112 导入成功<br/>13、学号 4113 导入成功<br/>14、学号 4114 导入成功<br/>15、学号 4115 导入成功<br/>16、学号 4116 导入成功<br/>17、学号 4117 导入成功<br/>18、学号 4118 导入成功<br/>19、学号 4119 导入成功<br/>20、学号 4120 导入成功<br/>21、学号 4121 导入成功<br/>22、学号 4122 导入成功<br/>23、学号 4123 导入成功<br/>24、学号 4124 导入成功<br/>25、学号 4125 导入成功<br/>26、学号 4126 导入成功<br/>27、学号 4127 导入成功<br/>28、学号 4128 导入成功<br/>29、学号 4129 导入成功<br/>30、学号 4130 导入成功<br/>31、学号 4131 导入成功<br/>32、学号 4132 导入成功<br/>33、学号 4133 导入成功<br/>34、学号 4134 导入成功<br/>35、学号 4135 导入成功<br/>36、学号 4136 导入成功<br/>37、学号 4137 导入成功<br/>38、学号 4138 导入成功<br/>39、学号 4139 导入成功<br/>40、学号 4140 导入成功<br/>41、学号 4141 导入成功<br/>42、学号 4142 导入成功<br/>43、学号 4143 导入成功<br/>44、学号 4144 导入成功<br/>45、学号 4145 导入成功<br/>46、学号 4146 导入成功<br/>47、学号 4147 导入成功<br/>48、学号 4148 导入成功<br/>49、学号 4149 导入成功<br/>50、学号 4150 导入成功<br/>51、学号 4151 导入成功<br/>52、学号 4152 导入成功<br/>53、学号 4153 导入成功<br/>54、学号 4154 导入成功<br/>55、学号 4155 导入成功<br/>56、学号 4156 导入成功<br/>57、学号 4157 导入成功<br/>58、学号 4160 导入成功<br/>59、学号 4201 导入成功<br/>60、学号 4202 导入成功<br/>61、学号 4203 导入成功<br/>62、学号 4204 导入成功<br/>63、学号 4205 导入成功<br/>64、学号 4206 导入成功<br/>65、学号 4207 导入成功<br/>66、学号 4208 导入成功<br/>67、学号 4209 导入成功<br/>68、学号 4210 导入成功<br/>69、学号 4211 导入成功<br/>70、学号 4212 导入成功<br/>71、学号 4213 导入成功<br/>72、学号 4214 导入成功<br/>73、学号 4215 导入成功<br/>74、学号 4216 导入成功<br/>75、学号 4217 导入成功<br/>76、学号 4218 导入成功<br/>77、学号 4219 导入成功<br/>78、学号 4220 导入成功<br/>79、学号 4221 导入成功<br/>80、学号 4222 导入成功<br/>81、学号 4223 导入成功<br/>82、学号 4224 导入成功<br/>83、学号 4225 导入成功<br/>84、学号 4226 导入成功<br/>85、学号 4227 导入成功<br/>86、学号 4228 导入成功<br/>87、学号 4229 导入成功<br/>88、学号 4230 导入成功<br/>89、学号 4231 导入成功<br/>90、学号 4232 导入成功<br/>91、学号 4233 导入成功<br/>92、学号 4234 导入成功<br/>93、学号 4235 导入成功<br/>94、学号 4236 导入成功<br/>95、学号 4237 导入成功<br/>96、学号 4238 导入成功<br/>97、学号 4239 导入成功<br/>98、学号 4240 导入成功<br/>99、学号 4241 导入成功<br/>100、', 0, NULL, '2026-03-07 18:07:41.777701', 25551);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (140, '重置所有学生密码', 2, 'com.ruoyi.web.controller.course.StudentController.resetAllPwd()', 'POST', 1, 'admin', '研发部门', '/course/student/resetAllPwd', '127.0.0.1', '内网IP', '', '{"msg":"操作成功，共重置 287 位学生的密码为123456","code":200}', 0, NULL, '2026-03-07 18:08:05.799786', 996);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (141, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"selection/index","createTime":"2026-03-06 14:47:45","icon":"list","isCache":"0","isFrame":"1","menuId":2110,"menuName":"选课车","menuType":"C","orderNum":1,"params":{},"parentId":2100,"path":"cart","perms":"course:selection:cart","query":"","routeName":"","status":"0","updateBy":"admin","visible":"0"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-07 18:09:51.553779', 40);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (142, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"selection/index","createTime":"2026-03-06 14:47:45","icon":"table","isCache":"0","isFrame":"1","menuId":2110,"menuName":"选课车","menuType":"C","orderNum":1,"params":{},"parentId":2100,"path":"cart","perms":"course:selection:cart","query":"","routeName":"","status":"0","updateBy":"admin","visible":"0"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-07 18:10:13.681354', 17);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (168, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/29/2', '127.0.0.1', '内网IP', '29 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.263946', 250);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (169, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/33/2', '127.0.0.1', '内网IP', '33 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.301276', 105);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (143, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{"children":[],"component":"selection/index","createTime":"2026-03-06 14:47:45","icon":"table","isCache":"0","isFrame":"1","menuId":2110,"menuName":"课程列表","menuType":"C","orderNum":1,"params":{},"parentId":2100,"path":"cart","perms":"course:selection:cart","query":"","routeName":"","status":"0","updateBy":"admin","visible":"0"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-07 18:10:34.883354', 20);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (145, '重置所有学生密码', 2, 'com.ruoyi.web.controller.course.StudentController.resetAllPwd()', 'POST', 1, 'admin', '研发部门', '/course/student/resetAllPwd', '127.0.0.1', '内网IP', '', '{"msg":"操作成功，共重置 577 位学生的密码为123456","code":200}', 0, NULL, '2026-03-07 18:14:43.045612', 1148);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (144, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入成功！共 290 条<br/>1、学号 3101 导入成功<br/>2、学号 3102 导入成功<br/>3、学号 3103 导入成功<br/>4、学号 3104 导入成功<br/>5、学号 3105 导入成功<br/>6、学号 3107 导入成功<br/>7、学号 3108 导入成功<br/>8、学号 3109 导入成功<br/>9、学号 3110 导入成功<br/>10、学号 3111 导入成功<br/>11、学号 3112 导入成功<br/>12、学号 3113 导入成功<br/>13、学号 3114 导入成功<br/>14、学号 3115 导入成功<br/>15、学号 3116 导入成功<br/>16、学号 3117 导入成功<br/>17、学号 3118 导入成功<br/>18、学号 3119 导入成功<br/>19、学号 3120 导入成功<br/>20、学号 3121 导入成功<br/>21、学号 3122 导入成功<br/>22、学号 3123 导入成功<br/>23、学号 3124 导入成功<br/>24、学号 3125 导入成功<br/>25、学号 3126 导入成功<br/>26、学号 3127 导入成功<br/>27、学号 3128 导入成功<br/>28、学号 3129 导入成功<br/>29、学号 3130 导入成功<br/>30、学号 3131 导入成功<br/>31、学号 3132 导入成功<br/>32、学号 3133 导入成功<br/>33、学号 3134 导入成功<br/>34、学号 3135 导入成功<br/>35、学号 3136 导入成功<br/>36、学号 3137 导入成功<br/>37、学号 3138 导入成功<br/>38、学号 3139 导入成功<br/>39、学号 3140 导入成功<br/>40、学号 3141 导入成功<br/>41、学号 3142 导入成功<br/>42、学号 3143 导入成功<br/>43、学号 3144 导入成功<br/>44、学号 3145 导入成功<br/>45、学号 3146 导入成功<br/>46、学号 3147 导入成功<br/>47、学号 3148 导入成功<br/>48、学号 3149 导入成功<br/>49、学号 3150 导入成功<br/>50、学号 3151 导入成功<br/>51、学号 3152 导入成功<br/>52、学号 3153 导入成功<br/>53、学号 3154 导入成功<br/>54、学号 3155 导入成功<br/>55、学号 3156 导入成功<br/>56、学号 3157 导入成功<br/>57、学号 3158 导入成功<br/>58、学号 3310 导入成功<br/>59、学号 3544 导入成功<br/>60、学号 3201 导入成功<br/>61、学号 3202 导入成功<br/>62、学号 3203 导入成功<br/>63、学号 3204 导入成功<br/>64、学号 3205 导入成功<br/>65、学号 3206 导入成功<br/>66、学号 3207 导入成功<br/>67、学号 3208 导入成功<br/>68、学号 3209 导入成功<br/>69、学号 3210 导入成功<br/>70、学号 3211 导入成功<br/>71、学号 3212 导入成功<br/>72、学号 3213 导入成功<br/>73、学号 3214 导入成功<br/>74、学号 3215 导入成功<br/>75、学号 3216 导入成功<br/>76、学号 3217 导入成功<br/>77、学号 3218 导入成功<br/>78、学号 3219 导入成功<br/>79、学号 3220 导入成功<br/>80、学号 3221 导入成功<br/>81、学号 3222 导入成功<br/>82、学号 3223 导入成功<br/>83、学号 3224 导入成功<br/>84、学号 3225 导入成功<br/>85、学号 3226 导入成功<br/>86、学号 3227 导入成功<br/>87、学号 3228 导入成功<br/>88、学号 3229 导入成功<br/>89、学号 3230 导入成功<br/>90、学号 3231 导入成功<br/>91、学号 3232 导入成功<br/>92、学号 3233 导入成功<br/>93、学号 3234 导入成功<br/>94、学号 3235 导入成功<br/>95、学号 3236 导入成功<br/>96、学号 3237 导入成功<br/>97、学号 3238 导入成功<br/>98、学号 3239 导入成功<br/>99、学号 3240 导入成功<br/>100、', 0, NULL, '2026-03-07 18:13:14.96765', 23375);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (146, '课程管理', 9, 'com.ruoyi.web.controller.course.CourseController.initSelectionData()', 'POST', 1, 'admin', '研发部门', '/course/course/initSelectionData', '127.0.0.1', '内网IP', '{"semesterId":"1"}', '{"msg":"初始化成功，已清空 0 条选课记录","code":200}', 0, NULL, '2026-03-07 18:15:58.163308', 8);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (147, '课程管理', 5, 'com.ruoyi.web.controller.course.CourseController.importTemplate()', 'POST', 1, 'admin', '研发部门', '/course/course/importTemplate', '127.0.0.1', '内网IP', '', NULL, 0, NULL, '2026-03-07 18:16:57.703293', 45);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (148, '课程管理', 5, 'com.ruoyi.web.controller.course.CourseController.importTemplate()', 'POST', 1, 'admin', '研发部门', '/course/course/importTemplate', '127.0.0.1', '内网IP', '', NULL, 0, NULL, '2026-03-07 21:29:01.322793', 1358);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (149, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.removeBatch()', 'DELETE', 1, 'admin', '研发部门', '/course/course/batch/11,12,13,14,15,16,17,18,19,20', '127.0.0.1', '内网IP', '[11,12,13,14,15,16,17,18,19,20] ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-07 22:10:26.673804', 390);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (150, '教师考核', 5, 'com.ruoyi.web.controller.course.TeacherAssessmentController.export()', 'POST', 1, 'admin', '研发部门', '/course/teacherAssessment/export', '127.0.0.1', '内网IP', '{"semesterId":"1"}', NULL, 0, NULL, '2026-03-07 22:45:08.278965', 2615);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (151, '教师考核', 5, 'com.ruoyi.web.controller.course.TeacherAssessmentController.export()', 'POST', 1, 'admin', '研发部门', '/course/teacherAssessment/export', '127.0.0.1', '内网IP', '{"semesterId":"1"}', NULL, 0, NULL, '2026-03-07 22:50:19.545314', 219);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (152, '学期管理', 2, 'com.ruoyi.web.controller.course.SemesterController.edit()', 'PUT', 1, 'admin', '研发部门', '/course/semester', '127.0.0.1', '内网IP', '{"createTime":"2026-03-06 10:31:31","delFlag":"0","endDate":"2026-07-14","id":1,"isCurrent":1,"params":{},"selectionEndTime":"2026-03-10 00:00:00","selectionStartTime":"2026-03-08 00:00:00","semesterName":"2026年春季学期","startDate":"2026-03-04","updateBy":"admin","updateTime":"2026-03-06 17:57:07"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 00:10:43.882202', 51);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (153, '课程管理', 2, 'com.ruoyi.web.controller.course.CourseController.assignStudents()', 'POST', 1, 'admin', '研发部门', '/course/course/21/assignStudents', '127.0.0.1', '内网IP', '21 {"studentIds":[441],"studentIdsAsLong":[441]} ', '{"msg":"成功指定 1 名学生","code":200}', 0, NULL, '2026-03-08 00:11:21.200782', 261);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (154, '课程管理', 2, 'com.ruoyi.web.controller.course.CourseController.edit()', 'PUT', 1, 'admin', '研发部门', '/course/course', '127.0.0.1', '内网IP', '{"courseName":"排球校队","createTime":"2026-03-06 17:57:16","delFlag":"0","description":"","gradeId":1,"gradeName":"八年级","id":21,"location":"篮球场","params":{},"quotaList":[{"classId":1,"courseId":21,"params":{},"quota":10,"selected":0},{"classId":2,"courseId":21,"params":{},"quota":10,"selected":0},{"classId":7,"courseId":21,"params":{},"quota":10,"selected":0},{"classId":8,"courseId":21,"params":{},"quota":10,"selected":0},{"classId":9,"courseId":21,"params":{},"quota":10,"selected":0},{"classId":10,"courseId":21,"params":{},"quota":10,"selected":0}],"semesterId":1,"semesterName":"2026年春季学期","teacherName":"余运波","weekDay":1} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 00:11:59.215908', 127);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (155, '课程管理', 2, 'com.ruoyi.web.controller.course.CourseController.assignStudents()', 'POST', 1, 'admin', '研发部门', '/course/course/21/assignStudents', '127.0.0.1', '内网IP', '21 {"studentIds":[441],"studentIdsAsLong":[441]} ', '{"msg":"成功指定 1 名学生","code":200}', 0, NULL, '2026-03-08 00:12:28.598712', 151);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (156, '课程管理', 9, 'com.ruoyi.web.controller.course.CourseController.initSelectionData()', 'POST', 1, 'admin', '研发部门', '/course/course/initSelectionData', '127.0.0.1', '内网IP', '{"semesterId":"1"}', '{"msg":"初始化成功，已清空 0 条选课记录","code":200}', 0, NULL, '2026-03-08 00:16:21.153415', 35);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (157, '课程管理-导入分配学生', 6, 'com.ruoyi.web.controller.course.CourseController.importAssignStudents()', 'POST', 1, 'admin', '研发部门', '/course/course/21/assignStudents/import', '127.0.0.1', '内网IP', '21 ', '{"msg":"导入完成，成功分配 2 名学生","code":200}', 0, NULL, '2026-03-08 20:49:21.148293', 928);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (158, '课程管理', 2, 'com.ruoyi.web.controller.course.CourseController.assignStudents()', 'POST', 1, 'admin', '研发部门', '/course/course/21/assignStudents', '127.0.0.1', '内网IP', '21 {"studentIds":[500],"studentIdsAsLong":[500]} ', '{"msg":"成功指定 1 名学生","code":200}', 0, NULL, '2026-03-08 20:49:50.481193', 165);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (159, '学期管理', 1, 'com.ruoyi.web.controller.course.SemesterController.add()', 'POST', 1, 'admin', '研发部门', '/course/semester', '127.0.0.1', '内网IP', '{"createBy":"admin","id":2,"isCurrent":0,"params":{},"semesterName":"2026年秋季学期"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:32.039813', 39);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (160, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/22/2', '127.0.0.1', '内网IP', '22 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:56.898884', 112);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (161, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/23/2', '127.0.0.1', '内网IP', '23 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:56.959381', 161);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (162, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/25/2', '127.0.0.1', '内网IP', '25 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:56.966289', 141);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (163, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/24/2', '127.0.0.1', '内网IP', '24 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:56.968388', 120);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (164, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/21/2', '127.0.0.1', '内网IP', '21 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:56.997136', 230);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (165, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/26/2', '127.0.0.1', '内网IP', '26 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.129056', 293);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (166, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/28/2', '127.0.0.1', '内网IP', '28 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.131672', 160);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (167, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/27/2', '127.0.0.1', '内网IP', '27 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.246475', 348);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (170, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/30/2', '127.0.0.1', '内网IP', '30 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.301215', 277);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (171, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/32/2', '127.0.0.1', '内网IP', '32 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.330535', 116);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (176, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/38/2', '127.0.0.1', '内网IP', '38 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.493836', 119);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (194, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/56/2', '127.0.0.1', '内网IP', '56 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.027663', 58);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (198, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/58/2', '127.0.0.1', '内网IP', '58 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.145508', 86);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (201, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/63/2', '127.0.0.1', '内网IP', '63 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.228898', 69);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (207, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/67/2', '127.0.0.1', '内网IP', '67 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.332185', 77);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (172, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/35/2', '127.0.0.1', '内网IP', '35 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.378997', 108);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (174, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/34/2', '127.0.0.1', '内网IP', '34 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.428752', 115);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (175, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/36/2', '127.0.0.1', '内网IP', '36 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.449727', 101);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (180, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/42/2', '127.0.0.1', '内网IP', '42 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.617767', 123);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (183, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/44/2', '127.0.0.1', '内网IP', '44 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.763732', 148);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (187, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/45/2', '127.0.0.1', '内网IP', '45 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.899989', 249);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (173, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/31/2', '127.0.0.1', '内网IP', '31 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.399287', 163);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (177, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/37/2', '127.0.0.1', '内网IP', '37 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.539524', 134);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (186, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/46/2', '127.0.0.1', '内网IP', '46 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.895945', 152);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (192, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/54/2', '127.0.0.1', '内网IP', '54 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.01631', 82);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (202, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/64/2', '127.0.0.1', '内网IP', '64 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.22899', 50);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (203, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/65/2', '127.0.0.1', '内网IP', '65 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.249504', 62);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (178, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/41/2', '127.0.0.1', '内网IP', '41 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.5857', 121);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (179, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/40/2', '127.0.0.1', '内网IP', '40 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.600409', 151);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (184, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/48/2', '127.0.0.1', '内网IP', '48 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.778894', 116);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (185, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/49/2', '127.0.0.1', '内网IP', '49 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.831307', 97);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (188, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/51/2', '127.0.0.1', '内网IP', '51 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.901149', 105);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (197, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/55/2', '127.0.0.1', '内网IP', '55 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.144754', 172);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (204, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/66/2', '127.0.0.1', '内网IP', '66 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.285004', 66);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (205, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/60/2', '127.0.0.1', '内网IP', '60 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.300362', 198);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (181, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/39/2', '127.0.0.1', '内网IP', '39 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.680385', 142);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (182, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/43/2', '127.0.0.1', '内网IP', '43 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.694771', 168);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (190, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/52/2', '127.0.0.1', '内网IP', '52 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.947006', 89);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (189, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/50/2', '127.0.0.1', '内网IP', '50 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.946155', 171);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (191, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/47/2', '127.0.0.1', '内网IP', '47 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:57.961956', 227);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (193, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/53/2', '127.0.0.1', '内网IP', '53 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.018493', 78);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (195, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/57/2', '127.0.0.1', '内网IP', '57 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.067106', 85);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (196, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/61/2', '127.0.0.1', '内网IP', '61 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.135048', 77);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (199, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/62/2', '127.0.0.1', '内网IP', '62 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.198734', 88);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (200, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/59/2', '127.0.0.1', '内网IP', '59 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.225171', 154);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (206, '课程管理', 1, 'com.ruoyi.web.controller.course.CourseController.copyToNewSemester()', 'POST', 1, 'admin', '研发部门', '/course/course/copyToNewSemester/68/2', '127.0.0.1', '内网IP', '68 2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:50:58.332185', 75);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (208, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.removeBatch()', 'DELETE', 1, 'admin', '研发部门', '/course/course/batch/21,22,23,24,25,26,27,28,29,30', '127.0.0.1', '内网IP', '[21,22,23,24,25,26,27,28,29,30] ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:51:22.299398', 249);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (209, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.removeBatch()', 'DELETE', 1, 'admin', '研发部门', '/course/course/batch/69,70,71,72,73,74,75,76,77,78', '127.0.0.1', '内网IP', '[69,70,71,72,73,74,75,76,77,78] ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:51:28.676097', 187);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (210, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.removeBatch()', 'DELETE', 1, 'admin', '研发部门', '/course/course/batch/79,80,81,82,83,84,85,86,87,88', '127.0.0.1', '内网IP', '[79,80,81,82,83,84,85,86,87,88] ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:51:36.194228', 261);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (211, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.removeBatch()', 'DELETE', 1, 'admin', '研发部门', '/course/course/batch/89,90,91,92,93,94,95,96,97,98', '127.0.0.1', '内网IP', '[89,90,91,92,93,94,95,96,97,98] ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:51:42.931111', 246);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (212, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.removeBatch()', 'DELETE', 1, 'admin', '研发部门', '/course/course/batch/99,100,101,102,103,104,105,106,107,108', '127.0.0.1', '内网IP', '[99,100,101,102,103,104,105,106,107,108] ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:51:52.242682', 173);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (213, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.removeBatch()', 'DELETE', 1, 'admin', '研发部门', '/course/course/batch/109,110,111,112,113,114,115,116', '127.0.0.1', '内网IP', '[109,110,111,112,113,114,115,116] ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:51:58.80564', 152);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (214, '评价题目', 1, 'com.ruoyi.web.controller.course.EvaluationController.addQuestion()', 'POST', 1, 'admin', '研发部门', '/course/evaluation/question', '127.0.0.1', '内网IP', '{"content":"教学内容","id":1,"params":{},"score":10,"semesterId":1,"sort":0,"status":1} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-08 20:52:17.817731', 14);


--
-- TOC entry 5346 (class 0 OID 91150)
-- Dependencies: 240
-- Data for Name: sys_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-03-06 14:47:11.215917', '', NULL, '');
INSERT INTO public.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-03-06 14:47:11.216488', '', NULL, '');
INSERT INTO public.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-03-06 14:47:11.216961', '', NULL, '');
INSERT INTO public.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-03-06 14:47:11.217383', '', NULL, '');


--
-- TOC entry 5348 (class 0 OID 91162)
-- Dependencies: 242
-- Data for Name: sys_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:11.224429', '', NULL, '超级管理员');
INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:11.224943', '', NULL, '普通角色');
INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (100, '教务管理员', 'course_admin', 3, '1', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:31.686982', '', NULL, '选修课教务管理');
INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (101, '教师', 'teacher', 4, '1', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:31.687737', '', NULL, '选修课教师');
INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (102, '学生', 'student', 5, '1', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:31.688225', '', NULL, '选课学生');


--
-- TOC entry 5353 (class 0 OID 91212)
-- Dependencies: 247
-- Data for Name: sys_role_dept; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_role_dept (role_id, dept_id) VALUES (2, 100);
INSERT INTO public.sys_role_dept (role_id, dept_id) VALUES (2, 101);
INSERT INTO public.sys_role_dept (role_id, dept_id) VALUES (2, 105);


--
-- TOC entry 5352 (class 0 OID 91207)
-- Dependencies: 246
-- Data for Name: sys_role_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 2);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 3);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 4);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 100);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 101);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 102);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 103);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 104);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 105);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 106);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 107);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 108);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 109);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 110);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 111);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 112);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 113);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 114);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 115);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 116);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 117);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 500);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 501);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1000);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1001);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1002);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1003);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1004);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1005);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1006);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1007);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1008);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1009);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1010);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1011);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1012);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1013);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1014);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1015);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1016);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1017);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1018);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1019);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1020);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1021);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1022);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1023);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1024);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1025);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1026);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1027);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1028);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1029);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1030);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1031);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1032);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1033);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1034);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1035);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1036);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1037);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1038);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1039);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1040);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1041);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1042);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1043);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1044);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1045);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1046);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1047);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1048);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1049);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1050);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1051);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1052);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1053);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1054);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1055);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1056);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1057);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1058);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1059);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (2, 1060);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2000);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2001);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2002);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2003);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2004);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2005);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2000);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2001);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2002);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2003);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2004);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2005);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2100);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2110);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2111);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2112);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2120);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2121);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (102, 2100);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (102, 2110);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (102, 2111);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (102, 2112);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (102, 2120);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (102, 2121);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2030);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2031);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2032);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2033);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2034);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2035);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2030);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2031);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2032);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2033);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2034);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2035);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2010);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2011);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2012);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2013);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2014);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2015);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2016);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2017);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2018);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2010);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2011);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2012);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2013);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2014);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2015);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2016);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2017);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2018);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2019);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2019);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2020);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2021);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2022);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2023);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2024);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2025);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2026);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2020);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2021);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2022);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2023);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2024);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2025);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2026);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2040);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2041);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2042);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2043);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2044);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2040);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2041);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2042);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2043);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (100, 2044);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (102, 2130);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2050);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2051);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2052);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2053);
INSERT INTO public.sys_role_menu (role_id, menu_id) VALUES (1, 2054);


--
-- TOC entry 5324 (class 0 OID 89784)
-- Dependencies: 218
-- Data for Name: sys_semester; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_semester (id, semester_name, start_date, end_date, is_current, del_flag, create_by, create_time, update_by, update_time, selection_start_time, selection_end_time) VALUES (1, '2026年春季学期', '2026-03-04', '2026-07-14', 1, '0', NULL, '2026-03-06 10:31:31.902038', 'admin', '2026-03-08 00:10:43.814245', '2026-03-08 00:00:00', '2026-03-10 00:00:00');
INSERT INTO public.sys_semester (id, semester_name, start_date, end_date, is_current, del_flag, create_by, create_time, update_by, update_time, selection_start_time, selection_end_time) VALUES (2, '2026年秋季学期', NULL, NULL, 0, '0', 'admin', '2026-03-08 20:50:31.979649', NULL, NULL, NULL, NULL);


--
-- TOC entry 5344 (class 0 OID 91129)
-- Dependencies: 238
-- Data for Name: sys_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-06 14:47:11.209289', '2026-03-06 14:47:11.209289', 'admin', '2026-03-06 14:47:11.209289', '', NULL, '测试员');
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (101, 103, 'teacher_张艾', '张艾', '02', '', '', '0', '', '$2a$10$AIEXOK2XAFtSjmC.VGMUAenaK5uf0XN/BN7iCyBEyLMAp05FNDIpO', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (102, 103, 'teacher_李正金', '李正金', '02', '', '', '0', '', '$2a$10$rd2Wqhm8tY3Mc3a2sSFQBOmdoHfj6.Alg2.FVZIZCyWZZMN8taBtq', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (103, 103, 'teacher_肖瀛', '肖瀛', '02', '', '', '0', '', '$2a$10$Cv3raDxxXI7vwgBZDPYVu.vJWhUr3z01resARNROLpQDKwr4CmD96', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (104, 103, 'teacher_张蓉', '张蓉', '02', '', '', '0', '', '$2a$10$X7dJZQsWkZKS5iOZMTHAkOdEHkVWjwK2ZGGrlHmt/YjfQi3ZU0UEC', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (105, 103, 'teacher_曹燕丽', '曹燕丽', '02', '', '', '0', '', '$2a$10$Yyg.7VZx5R/rHoUHjSCwZOx/NFISqYbBWGbV/NcWDu6NpSOqWPyRO', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (106, 103, 'teacher_杨俊会', '杨俊会', '02', '', '', '0', '', '$2a$10$/.2cfhTMWn0PZshQRRp9Pugpszjw0G8TWsqmNYALD0P9XJLAKMhcC', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (107, 103, 'teacher_廖臣芸', '廖臣芸', '02', '', '', '0', '', '$2a$10$GEKxXTrtJK83isxgClxxoedvgWymmESbY3MYhDG7kWl8IP6v9Q66a', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (108, 103, 'teacher_唐东', '唐东', '02', '', '', '0', '', '$2a$10$AWlA87VrlDGjWtvqsHKnZeqEOzv13mMl7EhCWjgJ5.zlb8st2tiW.', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (109, 103, 'teacher_雷杰', '雷杰', '02', '', '', '0', '', '$2a$10$1Z0at6ragnkOghmX0EJFx.0Jl.FuGERq7X.6/gBFYrtmtgj/0KuD2', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (110, 103, 'teacher_代龙炎', '代龙炎', '02', '', '', '0', '', '$2a$10$jtsCBuherIphhTvMUjq7QuSVrbQu/ZEt6cSFWM8FPYo6YTKuB9Ut2', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (111, 103, 'teacher_余运波', '余运波', '02', '', '', '0', '', '$2a$10$GsU.pqONYzQyotLlKBRhquReOU44vyz6ssCpE5u8Wq6HCyj3aj0rS', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (112, 103, 'teacher_王卫芬', '王卫芬', '02', '', '', '0', '', '$2a$10$WL6Uxcjyy484rd1QkqGoBeUTSUPjaKg/XPwFWLDhdYIHm.UGDG9BW', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (113, 103, 'teacher_唐云莲', '唐云莲', '02', '', '', '0', '', '$2a$10$MBxKn8nzBDWC38eB6oa/b.xxnhZfLaTGA.tv7bQ7eZIuQ2VRIdf0a', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (114, 103, 'teacher_陈传花', '陈传花', '02', '', '', '0', '', '$2a$10$Re/GtSrgVI.Z4kx8PxiW.OvcyQB7lQUzCmq5bABQN40s8X33QzPK6', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (115, 103, 'teacher_赵婷', '赵婷', '02', '', '', '0', '', '$2a$10$cOM87B.2pYDpjlF3nWMeceJpr71bHjslTN5VGwHNYtlNXqmmMBB.a', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (116, 103, 'teacher_孔敏', '孔敏', '02', '', '', '0', '', '$2a$10$SR/kx9NxqEKAcqvHvZ1al.EIccIDxUTdkOs0MF8RSH70jHqsAUmA2', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (117, 103, 'teacher_张德香', '张德香', '02', '', '', '0', '', '$2a$10$WbJ6izviuLp7zny9nYZLTuIN76QaoSPL1EfqyQNN7TSl/oFzXuWHe', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (118, 103, 'teacher_李晨', '李晨', '02', '', '', '0', '', '$2a$10$7I/k5a9.tywjt7xoLlHTo.9JQw.EGHWlX92dnGqalYHPuk.69uEzq', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (119, 103, 'teacher_晏敏', '晏敏', '02', '', '', '0', '', '$2a$10$wj6enW8aHvT2KNmbHWllw.aWeZozaC5OInd2QyLY5dRs3s2TXsLoe', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (120, 103, 'teacher_周克虎', '周克虎', '02', '', '', '0', '', '$2a$10$SoPUj581F32Gb4yqi5Wi/ubBwXT2nGPXjhl4mHp8nI75BMvwNtli.', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (121, 103, 'teacher_严明涛', '严明涛', '02', '', '', '0', '', '$2a$10$OtHKaOcxpAq8ZuGxvwENfeDehE4mvu24GRlADMl791Ah./e3huwoq', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (122, 103, 'teacher_肖艳明', '肖艳明', '02', '', '', '0', '', '$2a$10$HATeHzLcepa5btUesY1qL.AifIfjXPsGFZAoqqOsOzYwngHWYHmW2', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (123, 103, 'teacher_夏瑞', '夏瑞', '02', '', '', '0', '', '$2a$10$BtB4E3HRfx.p8XAV2DVPcOPr/IdbmDWceVEvrhQbk.4YpDp8tZkvK', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (124, 103, 'teacher_毛永洲', '毛永洲', '02', '', '', '0', '', '$2a$10$KcLz6.cEwGEoZ9Mw/CPIYOsnnbc8EjtHwqu/GpkmuCcnNMWWmW9Ca', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (125, 103, 'teacher_杨佳', '杨佳', '02', '', '', '0', '', '$2a$10$qaq89T2pE3no8s5vFIimEOFum4Pjg.WYkxGbS16qsOLr63n5m4I8.', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (126, 103, 'teacher_王世慧', '王世慧', '02', '', '', '0', '', '$2a$10$OuQeXv.XAj67LWZGjfbanu0e87etLVc.jIwlBTWkhZE.2coDA8.0C', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (127, 103, 'teacher_陆德贵', '陆德贵', '02', '', '', '0', '', '$2a$10$niihTy5uJRmbKoAkOWf3ReLMe84hebDX0PHuH8PY2aVn.5j6I5UCW', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (128, 103, 'teacher_解琪', '解琪', '02', '', '', '0', '', '$2a$10$ZyWW4Sfkr2s5s5eq6gVHEuoBdmms.WG6rmunC1xjHPGXdCmj0wTI6', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (129, 103, 'teacher_何欢', '何欢', '02', '', '', '0', '', '$2a$10$QnJx5MS0jvwaE7WoWWw7D.XbbBZH5fpLAu6R1spLeg.PWjYTht0g.', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (130, 103, 'teacher_严彩丽', '严彩丽', '02', '', '', '0', '', '$2a$10$ynQmu89apZzVb9Wp61.WIuIuL.faBW8x2AcwIyVJqKnG6VEeGtDWS', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (131, 103, 'teacher_代锦', '代锦', '02', '', '', '0', '', '$2a$10$qv3FXXSiDqUEBTrG5GQsM.47FXE25dizmKXmsQ8oyK66ILnBVr7jy', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (132, 103, 'teacher_董嘉', '董嘉', '02', '', '', '0', '', '$2a$10$KyVBpbYavu5bZ03mtnmAgO4eu/39dTpEY0GlSvCCr0oNQ3d7FVDIm', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (133, 103, 'teacher_秦绍将', '秦绍将', '02', '', '', '0', '', '$2a$10$GtcuxZ/ew74/nCcYFbvgxe6.DL3QejkTYlSIrOCuwfWOVgwXc3c1K', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (134, 103, 'teacher_张淑琼', '张淑琼', '02', '', '', '0', '', '$2a$10$ewbo26zHZmN9A7qHr8BeKuCvn7ezcynCMxx95HYdxe0rf.uIm.fae', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (135, 103, 'teacher_陈金粉', '陈金粉', '02', '', '', '0', '', '$2a$10$sYg5ny3cDJ0amwTE63WzX.Qb1huw7rzYmaXl48O49UGZWV3h1BLfi', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (136, 103, 'teacher_潘晨', '潘晨', '02', '', '', '0', '', '$2a$10$8mcowWJyqEn5qO5ehH8yoOQVQaSJ5Qzo1RUkY3KYVlsZmd8SBhz1y', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (137, 103, 'teacher_李琳', '李琳', '02', '', '', '0', '', '$2a$10$kkI7DCLfhUKMQQ2k3P1a0.ggAO/2gmIlmHqUPX7OZrudgwHggd1ZS', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (138, 103, 'teacher_段金书', '段金书', '02', '', '', '0', '', '$2a$10$JwO7CfLXWV5wMhleQVahv.S4bJRbfqkgIOtxlJoIxb6.t.hbygZfq', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (139, 103, 'teacher_汪延容', '汪延容', '02', '', '', '0', '', '$2a$10$suMBAJ04EnyiwdRegOyubeiUDKgUlmcEModo1goEGRy517xLW7c3q', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (140, 103, 'teacher_唐艳芳', '唐艳芳', '02', '', '', '0', '', '$2a$10$v5GCRxS35Z4rQ.pHW/LlueqdS2dWv6nzHKH8E6b6qeneRMAeGhnnu', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (141, 103, 'teacher_王会琼', '王会琼', '02', '', '', '0', '', '$2a$10$TmcXmnuldMTd3Z4EN0ANyue9YdOVNum4RwlpNCc0BYm17wTcIh5PK', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (142, 103, 'teacher_高连武', '高连武', '02', '', '', '0', '', '$2a$10$0xXYn32oRZwStZra3thCQ.TU15XRYjy6cNM00Hyedo8kqMHo6OEsy', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (143, 103, 'teacher_吴丽', '吴丽', '02', '', '', '0', '', '$2a$10$NwwrHFTnRSRurLN3xmKKmePzounJCRmYjB/AngyA9gY.bj7tY/heK', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (144, 103, 'teacher_胡庆梅', '胡庆梅', '02', '', '', '0', '', '$2a$10$VE8SEsolzsuSRdNL8DQAGuF/LncAV2W/lL6CumzFhOzbpAvJjNHCC', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (145, 103, 'teacher_方由伟', '方由伟', '02', '', '', '0', '', '$2a$10$Dg5ptiYWydB.aji1rFIgROzB7BtsNQIcEZYRCily.a4msYJATawFO', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (146, 103, 'teacher_史艳', '史艳', '02', '', '', '0', '', '$2a$10$U8PCTNdHNa8trI3.7yJLbu8k6hXt/rqI5v5ovF0KJWQfbw.cSYu56', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (147, 103, 'teacher_陆艳娇', '陆艳娇', '02', '', '', '0', '', '$2a$10$0f2Ba2s7QGqJpybvnFmrKO3gZTQhKhjhoX4z3rmNeWnDRRBxdvaoK', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (148, 103, 'teacher_赵忠亚', '赵忠亚', '02', '', '', '0', '', '$2a$10$Mzx.DRcrnF5KmgOlqbGYAe2/Jqdnfv97035NfrM5oX.4ztafeMDCW', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (149, 103, 'teacher_谢秋梅', '谢秋梅', '02', '', '', '0', '', '$2a$10$YRCs7CYby1YffAk4q9fwfOSUFWEnI9RDZds5yyRXudsJjjLdA4Wr2', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (150, 103, 'teacher_王开金', '王开金', '02', '', '', '0', '', '$2a$10$uhzJi3JP.d3ronmdWSrD7upcYE/e8WeZ2xZcV9sKcPzasYO2A5hlG', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (151, 103, 'teacher_赵天英', '赵天英', '02', '', '', '0', '', '$2a$10$3cIEHji/.BE8mvlBIeIyUOWgV8BT3hX718N2kLGoLEIEvO6TlEQtS', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (152, 103, 'teacher_赵庆梅', '赵庆梅', '02', '', '', '0', '', '$2a$10$l88sOnd/tV9DsWXJB/FlD.c3KFx1cVkE99j0BN.303Rr3PBsIcVB.', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (153, 103, 'teacher_史聪仙', '史聪仙', '02', '', '', '0', '', '$2a$10$Txi78Fp00HzR9CDaV9eJEut.thOeBhAHmQoHFSbT5uxsp9h4Q2vDq', '0', '0', '', NULL, NULL, 'admin', '2026-03-06 17:56:27.979305', '', NULL, NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (441, NULL, '3101', '曹子珺', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '127.0.0.1', '2026-03-08 00:13:28.995', '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-08 20:35:27.003', '2026-03-06 14:47:11.208678', 'admin', '2026-03-06 14:47:11.208678', '', NULL, '管理员');
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (154, NULL, '4101', '陈明阳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '127.0.0.1', '2026-03-07 18:08:58.189', '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (155, NULL, '4102', '陈尚博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (156, NULL, '4103', '陈烁颖', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (157, NULL, '4104', '陈亚桐', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (158, NULL, '4105', '代晨熙', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (159, NULL, '4106', '代娜', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (160, NULL, '4107', '丁小航', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (161, NULL, '4108', '段兴利', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (162, NULL, '4109', '段致远', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (163, NULL, '4110', '冯浠然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (164, NULL, '4111', '高涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (165, NULL, '4112', '关堡元', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (166, NULL, '4113', '何思辰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (167, NULL, '4114', '胡锦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (168, NULL, '4115', '胡艺曦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (169, NULL, '4116', '虎羽丹', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (170, NULL, '4117', '蒋梅莹', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (171, NULL, '4118', '康婧媛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (172, NULL, '4119', '李恒茁', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (173, NULL, '4120', '李江浩', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (174, NULL, '4121', '李思弦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (175, NULL, '4122', '李亭薇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (176, NULL, '4123', '李阳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (177, NULL, '4124', '刘畅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (178, NULL, '4125', '刘东峄', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (179, NULL, '4126', '柳玉然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (180, NULL, '4127', '陆雨鑫', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (181, NULL, '4128', '罗俊熙', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (182, NULL, '4129', '罗翔', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (183, NULL, '4130', '马彪', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (184, NULL, '4131', '马博一', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (185, NULL, '4132', '马钰涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (186, NULL, '4133', '马煜洋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (187, NULL, '4134', '孟遵域', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (188, NULL, '4135', '庞博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (189, NULL, '4136', '戚埕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (190, NULL, '4137', '邱晨希', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (191, NULL, '4138', '邵明玥', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (192, NULL, '4139', '孙贤', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (193, NULL, '4140', '唐源', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (194, NULL, '4141', '王瑞琦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (195, NULL, '4142', '王若曦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (196, NULL, '4143', '王滢媛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (197, NULL, '4144', '吴鑫艺', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (198, NULL, '4145', '刘骅瑾', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (199, NULL, '4146', '徐薇雲', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (200, NULL, '4147', '杨采薇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (201, NULL, '4148', '杨舒然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (202, NULL, '4149', '杨梓毅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (203, NULL, '4150', '张瑾', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (204, NULL, '4151', '张璟琦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (205, NULL, '4152', '张清铨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (206, NULL, '4153', '张茹冰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (207, NULL, '4154', '张钰晨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (208, NULL, '4155', '赵晨曦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (209, NULL, '4156', '赵继元', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (210, NULL, '4157', '赵寅志', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (211, NULL, '4160', '李彦霖', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (212, NULL, '4201', '周搏秋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (213, NULL, '4202', '林世桂', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (214, NULL, '4203', '李昌欢', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (215, NULL, '4204', '方冉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (216, NULL, '4205', '王福泽', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (217, NULL, '4206', '晏祥胜', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (218, NULL, '4207', '蒋博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (219, NULL, '4208', '李俊熙', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (220, NULL, '4209', '夏语阳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (221, NULL, '4210', '杨壁安', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (222, NULL, '4211', '黄韦博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (223, NULL, '4212', '庄永恒', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (224, NULL, '4213', '周照阳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (225, NULL, '4214', '刘盛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (226, NULL, '4215', '王理源', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (227, NULL, '4216', '张远欢', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (228, NULL, '4217', '樊宇善', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (229, NULL, '4218', '王宇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (230, NULL, '4219', '胡芮杰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (231, NULL, '4220', '欧泓辛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (232, NULL, '4221', '潘喆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (233, NULL, '4222', '晏韶辰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (234, NULL, '4223', '李盛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (235, NULL, '4224', '吕思昱', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (236, NULL, '4225', '冯婧钰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (237, NULL, '4226', '包如意', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (238, NULL, '4227', '付瑗', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (239, NULL, '4228', '杨紫妍', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (240, NULL, '4229', '代春雨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (241, NULL, '4230', '计美琳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (242, NULL, '4231', '贺娅妮', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (243, NULL, '4232', '王幂', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (244, NULL, '4233', '马文婷', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (245, NULL, '4234', '戚丽雪', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (246, NULL, '4235', '左吉丽', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (247, NULL, '4236', '李蓉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (248, NULL, '4237', '曾娅赛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (249, NULL, '4238', '夏曦悦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (250, NULL, '4239', '施丽琨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (251, NULL, '4240', '陈选麟', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (252, NULL, '4241', '贾叠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (253, NULL, '4242', '杨成娇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (254, NULL, '4243', '山宵云', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (255, NULL, '4244', '李婷', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (256, NULL, '4245', '吕维优', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (257, NULL, '4246', '蒋蕊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (258, NULL, '4247', '朱娅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (259, NULL, '4248', '李皎', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (260, NULL, '4249', '许香琴', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (261, NULL, '4250', '杨会仙', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (262, NULL, '4251', '张婉琦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (263, NULL, '4252', '应佳颖', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (264, NULL, '4253', '陈曦瑶', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (265, NULL, '4254', '撒召颖', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (266, NULL, '4255', '陈帆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (267, NULL, '4256', '冯光泽', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (268, NULL, '4257', '王晨霁', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (269, NULL, '4258', '严子俊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (270, NULL, '4301', '刘唐浩然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (271, NULL, '4302', '秦熙瑶', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (272, NULL, '4303', '尹国玲', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (273, NULL, '4304', '王加弼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (274, NULL, '4305', '朱芯', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (275, NULL, '4306', '范熠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (276, NULL, '4307', '吕兴巧', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (277, NULL, '4308', '刘淼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (278, NULL, '4309', '金鑫欣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (279, NULL, '4310', '欧江平', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (280, NULL, '4311', '陆思轩', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (281, NULL, '4312', '刘思辰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (282, NULL, '4313', '周遇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (283, NULL, '4314', '顾翌', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (284, NULL, '4315', '高楚烨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (285, NULL, '4316', '黄腾锋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (286, NULL, '4317', '柳梦洁', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (287, NULL, '4318', '鲍欣怡', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (288, NULL, '4319', '徐璐璐', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (289, NULL, '4320', '余冠霆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (290, NULL, '4321', '马关爽', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (291, NULL, '4322', '马浩荣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (292, NULL, '4323', '贺文县', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (293, NULL, '4324', '李达粲', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (294, NULL, '4325', '周梦绮', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (295, NULL, '4326', '刘曦雅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (296, NULL, '4327', '李秋燚', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (297, NULL, '4328', '陈兴幔', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (298, NULL, '4329', '邹汶辛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (299, NULL, '4330', '刘悦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (300, NULL, '4331', '李艳琳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (301, NULL, '4332', '张梦琳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (302, NULL, '4333', '杨泓雯', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (303, NULL, '4334', '王丽娜', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (304, NULL, '4335', '刘佳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (305, NULL, '4336', '谢雨鑫', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (306, NULL, '4337', '柳正权', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (307, NULL, '4338', '王翎旭', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (308, NULL, '4339', '晏贤莎', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (309, NULL, '4340', '潘沐晨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (310, NULL, '4341', '罗传龙', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (311, NULL, '4342', '朱恩瑾', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (312, NULL, '4343', '姚姝熠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (313, NULL, '4344', '张诗雯', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (314, NULL, '4345', '刘东亚', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (315, NULL, '4346', '马一懿', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (316, NULL, '4347', '李卓壕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (317, NULL, '4348', '吕曜桦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (318, NULL, '4349', '张馨月', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (319, NULL, '4350', '华学昊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (320, NULL, '4351', '李昊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (321, NULL, '4352', '李红辰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (322, NULL, '4353', '唐浩然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (323, NULL, '4354', '殷承邦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (324, NULL, '4355', '孙叶嘉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (325, NULL, '4356', '王馨怡', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (326, NULL, '4357', '晋家昊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (327, NULL, '4401', '陈浩宇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (328, NULL, '4402', '陈梦婷', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (329, NULL, '4403', '陈兴月', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (330, NULL, '4404', '陈奕璇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (331, NULL, '4405', '代东', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (332, NULL, '4406', '代煜', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (333, NULL, '4407', '管鑫淼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (334, NULL, '4408', '郭力匀', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (335, NULL, '4409', '贺莹鑫', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (336, NULL, '4410', '姜好', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (337, NULL, '4411', '蒋佳明', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (338, NULL, '4412', '蒋奕辰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (339, NULL, '4413', '金吉红', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (340, NULL, '4414', '李辰傲洋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (341, NULL, '4415', '李旒旖', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (342, NULL, '4416', '李若兮', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (343, NULL, '4417', '李彦昭', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (344, NULL, '4418', '李泽雨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (345, NULL, '4419', '李正东', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (346, NULL, '4420', '刘江', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (347, NULL, '4421', '卢昆燕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (348, NULL, '4422', '马祥伟', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (349, NULL, '4423', '马玉琼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (350, NULL, '4424', '倪荣吉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (351, NULL, '4425', '宁友毅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (352, NULL, '4426', '浦皓', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (353, NULL, '4427', '权梓鑫', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (354, NULL, '4428', '王雯瑾', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (355, NULL, '4429', '王藻', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (356, NULL, '4430', '王梓涵4', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (357, NULL, '4431', '吴海艳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (358, NULL, '4432', '吴靖瑶', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (359, NULL, '4433', '夏雪', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (360, NULL, '4434', '谢宗晓', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (361, NULL, '4435', '晏贤烨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (362, NULL, '4436', '晏梓宸', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (363, NULL, '4437', '杨官胤', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (364, NULL, '4438', '杨磊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (365, NULL, '4439', '杨雄超', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (366, NULL, '4440', '尹恒', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (367, NULL, '4441', '尹若婷', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (368, NULL, '4442', '尹思源', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (369, NULL, '4443', '张澜馨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (370, NULL, '4444', '张萌', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (371, NULL, '4445', '张梦涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (372, NULL, '4446', '张正昕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (373, NULL, '4447', '赵得屹', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (374, NULL, '4448', '赵敏琪', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (375, NULL, '4449', '赵梓涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (376, NULL, '4450', '郑婷', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (377, NULL, '4451', '周朝园', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (378, NULL, '4452', '周文静', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (379, NULL, '4453', '周心圆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (380, NULL, '4454', '周孜轩', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (381, NULL, '4455', '朱昱光', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (382, NULL, '4456', '朱珠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (383, NULL, '4457', '邹安治', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (384, NULL, '3458', '庄雨微', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (385, NULL, '4501', '陈金丽', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (386, NULL, '4502', '陈馨怡', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (387, NULL, '4503', '陈娅宣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (388, NULL, '4504', '代涛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (389, NULL, '4505', '丁怡', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (390, NULL, '4506', '段应旺', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (391, NULL, '4507', '冯莹', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (392, NULL, '4508', '桂智宸', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (393, NULL, '4510', '胡项帆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (394, NULL, '4511', '蒋院梅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (395, NULL, '4512', '李峻熙', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (396, NULL, '4513', '李太行', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (397, NULL, '4514', '李腾', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (398, NULL, '4515', '李欣蕊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (399, NULL, '4516', '李正楠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (400, NULL, '4517', '李梓涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (401, NULL, '4518', '刘芳州', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (402, NULL, '4519', '刘锦越', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (403, NULL, '4520', '刘莉婷', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (404, NULL, '4521', '刘明瑞', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (405, NULL, '4522', '刘文博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (406, NULL, '4523', '刘一冉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (407, NULL, '4524', '刘怡菡', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (408, NULL, '4525', '陆玉钒', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (409, NULL, '4526', '罗永康', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (410, NULL, '4527', '马勋晖', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (411, NULL, '4528', '缪迪', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (412, NULL, '4529', '宁一帆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (413, NULL, '4530', '任清淏', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (414, NULL, '4531', '石璨菡', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (415, NULL, '4532', '宋承昊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (416, NULL, '4533', '苏成可', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (417, NULL, '4534', '汤照升', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (418, NULL, '4535', '田露', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (419, NULL, '4536', '万盛阳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (420, NULL, '4537', '王芳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (421, NULL, '4538', '王梦婕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (422, NULL, '4539', '王然微', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (423, NULL, '4540', '王润灵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (424, NULL, '4541', '王姝', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (425, NULL, '4542', '王鑫瑞', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (426, NULL, '4543', '王艳娟', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (427, NULL, '4544', '王一帆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (428, NULL, '4545', '王梓涵5', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (429, NULL, '4546', '伍清馨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (430, NULL, '4547', '杨可欣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (431, NULL, '4548', '杨时瑞', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (432, NULL, '4549', '杨洋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (433, NULL, '4550', '尹正杰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (434, NULL, '4551', '尹卓', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (435, NULL, '4552', '张微婧', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (436, NULL, '4553', '张雅楠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (437, NULL, '4554', '张峪宁', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (438, NULL, '4555', '周鸿', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (439, NULL, '4556', '周民洋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (440, NULL, '4557', '和钰欣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:07:16.504866', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (442, NULL, '3102', '陈玟憙', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (443, NULL, '3103', '陈宇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (444, NULL, '3104', '陈梓榆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (445, NULL, '3105', '崔天雄', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (446, NULL, '3107', '单敬骁', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (447, NULL, '3108', '道泽鑫', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (448, NULL, '3109', '段富敏', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (449, NULL, '3110', '范秋菊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (450, NULL, '3111', '冯吉铜', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (451, NULL, '3112', '桂浩云', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (452, NULL, '3113', '郭书衔', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (453, NULL, '3114', '黄毅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (454, NULL, '3115', '姜林遇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (455, NULL, '3116', '蒋克松', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (456, NULL, '3117', '康竞丹', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (457, NULL, '3118', '孔维和', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (458, NULL, '3119', '李炳涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (459, NULL, '3120', '李昊阳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (460, NULL, '3121', '李瑞欣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (461, NULL, '3122', '李星谊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (462, NULL, '3123', '李予曦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (463, NULL, '3124', '李昱圻', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (464, NULL, '3125', '李元淼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (465, NULL, '3126', '聂馨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (466, NULL, '3127', '钱浩然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (467, NULL, '3128', '邱程瑞', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (468, NULL, '3129', '束世晨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (469, NULL, '3130', '宋紫萌', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (470, NULL, '3131', '孙瑞', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (471, NULL, '3132', '孙懿轩', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (472, NULL, '3133', '汤雅菡', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (473, NULL, '3134', '王传博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (474, NULL, '3135', '王锦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (475, NULL, '3136', '王入希', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (476, NULL, '3137', '王瑞1', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (477, NULL, '3138', '王烨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (478, NULL, '3139', '韦泓印', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (479, NULL, '3140', '吴锦奇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (480, NULL, '3141', '谢文峰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (481, NULL, '3142', '许雅琼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (482, NULL, '3143', '姚宛妤', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (483, NULL, '3144', '易文博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (484, NULL, '3145', '殷祥凌', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (485, NULL, '3146', '尹若洢', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (486, NULL, '3147', '余热', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (487, NULL, '3148', '余欣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (488, NULL, '3149', '张高冉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (489, NULL, '3150', '张官雯', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (490, NULL, '3151', '赵德忠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (491, NULL, '3152', '郑硕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (492, NULL, '3153', '郑阳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (493, NULL, '3154', '周情缘', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (494, NULL, '3155', '周思彤', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (495, NULL, '3156', '朱硕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (496, NULL, '3157', '庄程凯', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (497, NULL, '3158', '龙锦潇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (498, NULL, '3310', '代姝琰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (499, NULL, '3544', '赵泳新', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (500, NULL, '3201', '高馨雅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (501, NULL, '3202', '金泓', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (502, NULL, '3203', '邹明耀', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (503, NULL, '3204', '尹其参', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (504, NULL, '3205', '朱友倩', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (505, NULL, '3206', '石砚清', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (506, NULL, '3207', '周靖凯', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (507, NULL, '3208', '陈熙涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (508, NULL, '3209', '刘语萱', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (509, NULL, '3210', '张倩瑜', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (510, NULL, '3211', '韩铭锐', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (511, NULL, '3212', '刘家榛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (512, NULL, '3213', '母译心', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (513, NULL, '3214', '陈梦瑶', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (514, NULL, '3215', '刘馨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (515, NULL, '3216', '邱国睿', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (516, NULL, '3217', '王启航', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (517, NULL, '3218', '锁帆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (518, NULL, '3219', '肖泽旭', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (519, NULL, '3220', '余双文', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (520, NULL, '3221', '曹满莲', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (521, NULL, '3222', '戴桠楠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (522, NULL, '3223', '陈勋坤', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (523, NULL, '3224', '李若菡', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (524, NULL, '3225', '李卓恒', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (525, NULL, '3226', '徐春媛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (526, NULL, '3227', '杨皓钦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (527, NULL, '3228', '顾洪谨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (528, NULL, '3229', '王开睿', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (529, NULL, '3230', '熊梓君', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (530, NULL, '3231', '杨琳坚', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (531, NULL, '3232', '朱啟萌', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (532, NULL, '3233', '康恒', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (533, NULL, '3234', '颜成坤', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (534, NULL, '3235', '杨立', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (535, NULL, '3236', '陈屿珊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (536, NULL, '3237', '李品兑', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (537, NULL, '3238', '钟翛然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (538, NULL, '3239', '何鑫', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (539, NULL, '3240', '邹学琼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (540, NULL, '3241', '赵万源', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (541, NULL, '3242', '解天治', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (542, NULL, '3243', '施江楠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (543, NULL, '3244', '康泰然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (544, NULL, '3245', '陈彦臣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (545, NULL, '3246', '田泓彦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (546, NULL, '3247', '陈达昊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (547, NULL, '3248', '丁俊宇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (548, NULL, '3249', '黄诗语', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (549, NULL, '3250', '吕玭稀', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (550, NULL, '3251', '毛千予', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (551, NULL, '3252', '彭熙倬', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (552, NULL, '3253', '宋弥南', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (553, NULL, '3254', '肖馨雅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (554, NULL, '3255', '杨斯淇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (555, NULL, '3256', '赵钒壹', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (556, NULL, '3257', '吕欣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (557, NULL, '3258', '沈梦烯', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (558, NULL, '3259', '苏钰涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (559, NULL, '3262', '贾莉雅', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (560, NULL, '3106', '戴龙鑫', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (561, NULL, '3301', '毕广涛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (562, NULL, '3302', '毕泽云', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (563, NULL, '3303', '蔡雨润', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (564, NULL, '3304', '陈吉星', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (565, NULL, '3305', '陈禹霏', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (566, NULL, '3306', '崔梦涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (567, NULL, '3307', '代冯之', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (568, NULL, '3308', '代龙珠', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (569, NULL, '3311', '杜城', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (570, NULL, '3312', '高华地', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (571, NULL, '3313', '耿德成', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (572, NULL, '3314', '芶子优', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (573, NULL, '3315', '桂钎浩', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (574, NULL, '3316', '胡静', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (575, NULL, '3317', '姜山', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (576, NULL, '3318', '李冬雨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (577, NULL, '3319', '李佳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (578, NULL, '3320', '李军蓉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (579, NULL, '3321', '李泊锋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (580, NULL, '3322', '李茹玉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (581, NULL, '3323', '李思源', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (582, NULL, '3324', '李兴峰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (583, NULL, '3325', '李媛红', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (584, NULL, '3326', '李泽楷', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (585, NULL, '3327', '刘祺', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (586, NULL, '3328', '罗春夕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (587, NULL, '3329', '罗廷孟', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (588, NULL, '3330', '马欣然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (589, NULL, '3331', '孟守懿', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (590, NULL, '3332', '浦雅迪', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (591, NULL, '3333', '沈瑞捷', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (592, NULL, '3334', '汤紫涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (593, NULL, '3335', '唐伟', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (594, NULL, '3336', '王茂语', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (595, NULL, '3337', '王天越', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (596, NULL, '3338', '王文垲', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (597, NULL, '3339', '王曦婷', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (598, NULL, '3340', '王艺诺', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (599, NULL, '3341', '王子瑞', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (600, NULL, '3342', '王梓欣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (601, NULL, '3343', '肖弼开', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (602, NULL, '3344', '严宁康杰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (603, NULL, '3345', '晏合娇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (604, NULL, '3346', '杨民旭', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (605, NULL, '3347', '杨舒然', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (606, NULL, '3348', '杨雅婕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (607, NULL, '3349', '袁铱蔚', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (608, NULL, '3350', '岳昊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (609, NULL, '3351', '张佳丽', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (610, NULL, '3352', '张旭尧', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (611, NULL, '3353', '赵国尧', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (612, NULL, '3354', '赵婧彤', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (613, NULL, '3355', '朱恩泱', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (614, NULL, '3356', '朱祉亦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (615, NULL, '3357', '徐磊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (616, NULL, '3508', '代冯兮', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (617, NULL, '3401', '安塞玲', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (618, NULL, '3402', '包崇锦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (619, NULL, '3404', '陈红志', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (620, NULL, '3405', '陈梦圆', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (621, NULL, '3406', '陈顺达', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (622, NULL, '3407', '陈漪潼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (623, NULL, '3408', '褚秋奕', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (624, NULL, '3409', '丁俊衔', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (625, NULL, '3410', '付文智', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (626, NULL, '3411', '高金阔', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (627, NULL, '3412', '桂藤菁', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (628, NULL, '3413', '何雨润', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (629, NULL, '3414', '胡光秋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (630, NULL, '3415', '胡涵杰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (631, NULL, '3416', '华力莹', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (632, NULL, '3417', '黄礼芯', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (633, NULL, '3418', '黄曼淇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (634, NULL, '3419', '陈邦仙', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (635, NULL, '3420', '李帛燃', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (636, NULL, '3421', '李冬成', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (637, NULL, '3422', '李文平', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (638, NULL, '3423', '林思琦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (639, NULL, '3424', '刘承烨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (640, NULL, '3425', '刘吉昊', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (641, NULL, '3426', '刘蕾', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (642, NULL, '3427', '刘思绫', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (643, NULL, '3428', '卢禹兴', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (644, NULL, '3429', '吕贤宇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (645, NULL, '3430', '孟福曦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (646, NULL, '3431', '缪应琼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (647, NULL, '3432', '裴浩翔', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (648, NULL, '3433', '彭莹', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (649, NULL, '3434', '邱琪茸', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (650, NULL, '3435', '阮欣颖', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (651, NULL, '3436', '舒彦', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (652, NULL, '3437', '孙颢铭', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (653, NULL, '3438', '田宇欣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (654, NULL, '3439', '王君瑞', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (655, NULL, '3440', '王瑞4', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (656, NULL, '3441', '王思博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (657, NULL, '3442', '王梓诚', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (658, NULL, '3443', '吴君彩', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (659, NULL, '3444', '吴青阳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (660, NULL, '3445', '徐浩瑀', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (661, NULL, '3446', '徐祥盛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (662, NULL, '3447', '严宁康博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (663, NULL, '3448', '余其洋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (664, NULL, '3449', '袁萌', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (665, NULL, '3450', '张厚林', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (666, NULL, '3451', '黄滢睿', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (667, NULL, '3452', '张钰滢', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (668, NULL, '3453', '郑成柯', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (669, NULL, '3454', '周子珺', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (670, NULL, '3455', '周祖宇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (671, NULL, '3456', '朱思颖', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (672, NULL, '3457', '朱雨潼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (673, NULL, '3309', '代荣泽', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (674, NULL, '3501', '曾繁通', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (675, NULL, '3502', '曾玺蓉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (676, NULL, '3503', '陈本佳', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (677, NULL, '3504', '陈柯函', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (678, NULL, '3505', '陈森', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (679, NULL, '3506', '陈铱涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (680, NULL, '3507', '崔汝霞', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (681, NULL, '3509', '戴大辉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (682, NULL, '3510', '党颖瑶', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (683, NULL, '3511', '杜钰滢', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (684, NULL, '3512', '高健铭', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (685, NULL, '3513', '何进', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (686, NULL, '3514', '胡济鲲', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (687, NULL, '3515', '胡宇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (688, NULL, '3516', '黄海航', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (689, NULL, '3517', '金源峰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (690, NULL, '3518', '孔文玉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (691, NULL, '3519', '李泽宸', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (692, NULL, '3520', '林玟君', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (693, NULL, '3521', '凌俊杰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (694, NULL, '3522', '刘思圻', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (695, NULL, '3523', '刘思谣', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (696, NULL, '3524', '罗冰杰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (697, NULL, '3525', '马想云', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (698, NULL, '3526', '宁静', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (699, NULL, '3527', '宁思萌', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (700, NULL, '3528', '谭庆本', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (701, NULL, '3529', '唐铭望', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (702, NULL, '3530', '王春洋', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (703, NULL, '3531', '王玘萌', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (704, NULL, '3532', '王蓉', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (705, NULL, '3533', '王圣淼', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (706, NULL, '3534', '王姝杨', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (707, NULL, '3535', '王思涵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (708, NULL, '3536', '温力源', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (709, NULL, '3537', '吴加一', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (710, NULL, '3538', '吴金凤', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (711, NULL, '3539', '肖弼灏', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (712, NULL, '3540', '肖含', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (713, NULL, '3541', '谢滨羽', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (714, NULL, '3542', '徐琳媛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (715, NULL, '3543', '鄢晨茜', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (716, NULL, '3545', '杨涛', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (717, NULL, '3546', '杨兴权', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (718, NULL, '3547', '杨焱博', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (719, NULL, '3548', '袁子鑫', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (720, NULL, '3549', '张丽卓', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (721, NULL, '3550', '张洺浥', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (722, NULL, '3551', '张仁熙', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (723, NULL, '3552', '张天鹏', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (724, NULL, '3553', '赵庆灵', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (725, NULL, '3554', '郑钰澄', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (726, NULL, '3555', '朱航辰', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (727, NULL, '3556', '朱欣怡', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (728, NULL, '3557', '邹潇', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (729, NULL, '3559', '王霄萌', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (730, NULL, '3562', '高连杜', '01', '', '', '0', '', '$2a$10$4xDZIgYknvmVAiqtQ8SU8uhROfo.det7xqa9Im2wEwZ5LleuZ/AEK', '0', '0', '', NULL, '2026-03-07 18:14:41.886717', 'admin', '2026-03-07 18:12:51.650929', '', '2026-03-07 18:14:41.886717', NULL);


--
-- TOC entry 5354 (class 0 OID 91217)
-- Dependencies: 248
-- Data for Name: sys_user_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_user_post (user_id, post_id) VALUES (1, 1);
INSERT INTO public.sys_user_post (user_id, post_id) VALUES (2, 2);


--
-- TOC entry 5351 (class 0 OID 91202)
-- Dependencies: 245
-- Data for Name: sys_user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_user_role (user_id, role_id) VALUES (1, 1);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2, 2);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (101, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (102, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (103, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (104, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (105, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (106, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (107, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (108, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (109, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (110, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (111, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (112, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (113, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (114, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (115, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (116, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (117, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (118, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (119, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (120, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (121, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (122, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (123, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (124, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (125, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (126, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (127, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (128, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (129, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (130, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (131, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (132, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (133, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (134, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (135, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (136, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (137, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (138, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (139, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (140, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (141, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (142, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (143, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (144, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (145, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (146, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (147, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (148, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (149, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (150, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (151, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (152, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (153, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (154, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (155, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (156, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (157, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (158, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (159, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (160, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (161, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (162, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (163, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (164, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (165, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (166, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (167, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (168, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (169, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (170, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (171, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (172, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (173, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (174, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (175, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (176, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (177, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (178, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (179, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (180, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (181, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (182, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (183, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (184, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (185, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (186, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (187, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (188, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (189, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (190, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (191, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (192, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (193, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (194, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (195, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (196, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (197, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (198, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (199, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (200, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (201, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (202, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (203, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (204, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (205, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (206, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (207, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (208, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (209, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (210, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (211, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (212, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (213, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (214, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (215, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (216, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (217, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (218, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (219, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (220, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (221, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (222, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (223, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (224, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (225, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (226, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (227, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (228, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (229, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (230, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (231, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (232, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (233, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (234, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (235, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (236, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (237, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (238, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (239, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (240, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (241, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (242, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (243, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (244, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (245, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (246, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (247, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (248, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (249, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (250, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (251, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (252, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (253, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (254, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (255, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (256, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (257, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (258, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (259, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (260, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (261, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (262, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (263, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (264, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (265, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (266, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (267, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (268, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (269, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (270, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (271, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (272, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (273, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (274, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (275, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (276, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (277, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (278, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (279, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (280, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (281, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (282, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (283, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (284, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (285, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (286, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (287, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (288, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (289, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (290, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (291, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (292, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (293, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (294, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (295, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (296, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (297, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (298, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (299, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (300, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (301, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (302, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (303, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (304, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (305, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (306, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (307, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (308, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (309, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (310, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (311, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (312, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (313, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (314, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (315, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (316, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (317, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (318, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (319, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (320, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (321, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (322, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (323, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (324, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (325, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (326, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (327, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (328, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (329, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (330, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (331, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (332, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (333, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (334, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (335, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (336, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (337, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (338, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (339, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (340, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (341, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (342, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (343, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (344, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (345, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (346, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (347, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (348, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (349, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (350, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (351, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (352, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (353, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (354, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (355, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (356, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (357, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (358, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (359, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (360, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (361, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (362, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (363, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (364, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (365, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (366, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (367, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (368, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (369, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (370, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (371, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (372, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (373, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (374, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (375, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (376, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (377, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (378, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (379, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (380, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (381, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (382, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (383, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (384, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (385, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (386, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (387, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (388, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (389, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (390, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (391, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (392, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (393, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (394, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (395, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (396, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (397, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (398, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (399, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (400, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (401, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (402, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (403, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (404, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (405, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (406, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (407, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (408, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (409, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (410, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (411, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (412, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (413, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (414, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (415, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (416, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (417, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (418, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (419, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (420, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (421, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (422, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (423, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (424, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (425, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (426, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (427, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (428, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (429, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (430, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (431, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (432, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (433, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (434, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (435, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (436, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (437, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (438, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (439, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (440, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (441, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (442, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (443, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (444, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (445, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (446, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (447, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (448, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (449, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (450, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (451, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (452, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (453, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (454, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (455, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (456, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (457, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (458, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (459, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (460, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (461, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (462, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (463, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (464, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (465, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (466, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (467, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (468, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (469, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (470, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (471, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (472, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (473, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (474, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (475, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (476, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (477, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (478, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (479, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (480, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (481, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (482, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (483, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (484, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (485, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (486, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (487, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (488, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (489, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (490, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (491, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (492, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (493, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (494, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (495, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (496, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (497, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (498, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (499, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (500, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (501, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (502, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (503, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (504, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (505, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (506, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (507, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (508, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (509, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (510, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (511, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (512, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (513, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (514, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (515, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (516, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (517, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (518, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (519, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (520, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (521, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (522, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (523, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (524, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (525, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (526, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (527, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (528, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (529, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (530, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (531, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (532, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (533, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (534, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (535, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (536, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (537, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (538, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (539, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (540, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (541, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (542, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (543, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (544, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (545, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (546, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (547, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (548, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (549, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (550, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (551, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (552, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (553, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (554, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (555, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (556, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (557, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (558, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (559, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (560, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (561, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (562, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (563, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (564, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (565, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (566, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (567, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (568, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (569, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (570, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (571, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (572, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (573, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (574, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (575, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (576, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (577, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (578, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (579, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (580, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (581, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (582, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (583, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (584, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (585, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (586, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (587, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (588, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (589, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (590, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (591, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (592, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (593, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (594, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (595, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (596, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (597, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (598, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (599, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (600, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (601, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (602, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (603, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (604, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (605, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (606, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (607, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (608, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (609, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (610, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (611, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (612, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (613, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (614, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (615, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (616, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (617, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (618, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (619, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (620, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (621, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (622, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (623, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (624, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (625, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (626, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (627, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (628, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (629, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (630, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (631, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (632, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (633, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (634, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (635, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (636, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (637, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (638, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (639, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (640, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (641, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (642, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (643, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (644, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (645, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (646, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (647, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (648, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (649, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (650, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (651, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (652, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (653, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (654, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (655, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (656, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (657, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (658, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (659, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (660, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (661, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (662, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (663, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (664, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (665, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (666, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (667, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (668, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (669, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (670, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (671, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (672, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (673, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (674, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (675, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (676, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (677, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (678, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (679, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (680, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (681, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (682, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (683, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (684, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (685, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (686, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (687, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (688, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (689, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (690, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (691, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (692, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (693, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (694, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (695, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (696, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (697, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (698, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (699, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (700, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (701, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (702, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (703, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (704, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (705, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (706, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (707, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (708, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (709, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (710, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (711, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (712, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (713, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (714, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (715, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (716, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (717, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (718, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (719, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (720, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (721, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (722, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (723, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (724, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (725, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (726, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (727, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (728, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (729, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (730, 102);


--
-- TOC entry 5467 (class 0 OID 0)
-- Dependencies: 227
-- Name: cou_class_quota_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cou_class_quota_id_seq', 32, true);


--
-- TOC entry 5468 (class 0 OID 0)
-- Dependencies: 225
-- Name: cou_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cou_course_id_seq', 116, true);


--
-- TOC entry 5469 (class 0 OID 0)
-- Dependencies: 231
-- Name: eva_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eva_question_id_seq', 1, true);


--
-- TOC entry 5470 (class 0 OID 0)
-- Dependencies: 267
-- Name: gen_table_column_column_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gen_table_column_column_id_seq', 1, false);


--
-- TOC entry 5471 (class 0 OID 0)
-- Dependencies: 265
-- Name: gen_table_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gen_table_table_id_seq', 1, false);


--
-- TOC entry 5472 (class 0 OID 0)
-- Dependencies: 233
-- Name: stu_evaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stu_evaluation_id_seq', 1, false);


--
-- TOC entry 5473 (class 0 OID 0)
-- Dependencies: 229
-- Name: stu_selection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stu_selection_id_seq', 1, false);


--
-- TOC entry 5474 (class 0 OID 0)
-- Dependencies: 223
-- Name: stu_student_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stu_student_info_id_seq', 583, true);


--
-- TOC entry 5475 (class 0 OID 0)
-- Dependencies: 221
-- Name: sys_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_class_id_seq', 16, true);


--
-- TOC entry 5476 (class 0 OID 0)
-- Dependencies: 255
-- Name: sys_config_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_config_config_id_seq', 100, true);


--
-- TOC entry 5477 (class 0 OID 0)
-- Dependencies: 235
-- Name: sys_dept_dept_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_dept_dept_id_seq', 200, true);


--
-- TOC entry 5478 (class 0 OID 0)
-- Dependencies: 253
-- Name: sys_dict_data_dict_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_dict_data_dict_code_seq', 110, true);


--
-- TOC entry 5479 (class 0 OID 0)
-- Dependencies: 251
-- Name: sys_dict_type_dict_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_dict_type_dict_id_seq', 103, true);


--
-- TOC entry 5480 (class 0 OID 0)
-- Dependencies: 219
-- Name: sys_grade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_grade_id_seq', 4, true);


--
-- TOC entry 5481 (class 0 OID 0)
-- Dependencies: 259
-- Name: sys_job_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_job_job_id_seq', 100, true);


--
-- TOC entry 5482 (class 0 OID 0)
-- Dependencies: 261
-- Name: sys_job_log_job_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_job_log_job_log_id_seq', 1, false);


--
-- TOC entry 5483 (class 0 OID 0)
-- Dependencies: 257
-- Name: sys_logininfor_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_logininfor_info_id_seq', 121, true);


--
-- TOC entry 5484 (class 0 OID 0)
-- Dependencies: 243
-- Name: sys_menu_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_menu_menu_id_seq', 2000, true);


--
-- TOC entry 5485 (class 0 OID 0)
-- Dependencies: 263
-- Name: sys_notice_notice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_notice_notice_id_seq', 10, true);


--
-- TOC entry 5486 (class 0 OID 0)
-- Dependencies: 249
-- Name: sys_oper_log_oper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_oper_log_oper_id_seq', 214, true);


--
-- TOC entry 5487 (class 0 OID 0)
-- Dependencies: 239
-- Name: sys_post_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_post_post_id_seq', 1, false);


--
-- TOC entry 5488 (class 0 OID 0)
-- Dependencies: 241
-- Name: sys_role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_role_role_id_seq', 102, true);


--
-- TOC entry 5489 (class 0 OID 0)
-- Dependencies: 217
-- Name: sys_semester_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_semester_id_seq', 2, true);


--
-- TOC entry 5490 (class 0 OID 0)
-- Dependencies: 237
-- Name: sys_user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_user_id_seq', 730, true);


--
-- TOC entry 5094 (class 2606 OID 89840)
-- Name: cou_class_quota cou_class_quota_course_id_class_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_class_quota
    ADD CONSTRAINT cou_class_quota_course_id_class_id_key UNIQUE (course_id, class_id);


--
-- TOC entry 5096 (class 2606 OID 89838)
-- Name: cou_class_quota cou_class_quota_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_class_quota
    ADD CONSTRAINT cou_class_quota_pkey PRIMARY KEY (id);


--
-- TOC entry 5092 (class 2606 OID 89829)
-- Name: cou_course cou_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_course
    ADD CONSTRAINT cou_course_pkey PRIMARY KEY (id);


--
-- TOC entry 5101 (class 2606 OID 89858)
-- Name: eva_question eva_question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eva_question
    ADD CONSTRAINT eva_question_pkey PRIMARY KEY (id);


--
-- TOC entry 5150 (class 2606 OID 91395)
-- Name: gen_table_column gen_table_column_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_table_column
    ADD CONSTRAINT gen_table_column_pkey PRIMARY KEY (column_id);


--
-- TOC entry 5148 (class 2606 OID 91382)
-- Name: gen_table gen_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_table
    ADD CONSTRAINT gen_table_pkey PRIMARY KEY (table_id);


--
-- TOC entry 5160 (class 2606 OID 91445)
-- Name: qrtz_blob_triggers qrtz_blob_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- TOC entry 5162 (class 2606 OID 91457)
-- Name: qrtz_calendars qrtz_calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_calendars
    ADD CONSTRAINT qrtz_calendars_pkey PRIMARY KEY (sched_name, calendar_name);


--
-- TOC entry 5158 (class 2606 OID 91433)
-- Name: qrtz_cron_triggers qrtz_cron_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- TOC entry 5166 (class 2606 OID 91469)
-- Name: qrtz_fired_triggers qrtz_fired_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_fired_triggers
    ADD CONSTRAINT qrtz_fired_triggers_pkey PRIMARY KEY (sched_name, entry_id);


--
-- TOC entry 5152 (class 2606 OID 91402)
-- Name: qrtz_job_details qrtz_job_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_job_details
    ADD CONSTRAINT qrtz_job_details_pkey PRIMARY KEY (sched_name, job_name, job_group);


--
-- TOC entry 5170 (class 2606 OID 91479)
-- Name: qrtz_locks qrtz_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_locks
    ADD CONSTRAINT qrtz_locks_pkey PRIMARY KEY (sched_name, lock_name);


--
-- TOC entry 5164 (class 2606 OID 91462)
-- Name: qrtz_paused_trigger_grps qrtz_paused_trigger_grps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_paused_trigger_grps
    ADD CONSTRAINT qrtz_paused_trigger_grps_pkey PRIMARY KEY (sched_name, trigger_group);


--
-- TOC entry 5168 (class 2606 OID 91474)
-- Name: qrtz_scheduler_state qrtz_scheduler_state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_scheduler_state
    ADD CONSTRAINT qrtz_scheduler_state_pkey PRIMARY KEY (sched_name, instance_name);


--
-- TOC entry 5156 (class 2606 OID 91421)
-- Name: qrtz_simple_triggers qrtz_simple_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- TOC entry 5172 (class 2606 OID 91486)
-- Name: qrtz_simprop_triggers qrtz_simprop_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simprop_triggers
    ADD CONSTRAINT qrtz_simprop_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- TOC entry 5154 (class 2606 OID 91409)
-- Name: qrtz_triggers qrtz_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- TOC entry 5103 (class 2606 OID 89865)
-- Name: stu_evaluation stu_evaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_evaluation
    ADD CONSTRAINT stu_evaluation_pkey PRIMARY KEY (id);


--
-- TOC entry 5105 (class 2606 OID 89867)
-- Name: stu_evaluation stu_evaluation_student_id_course_id_question_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_evaluation
    ADD CONSTRAINT stu_evaluation_student_id_course_id_question_id_key UNIQUE (student_id, course_id, question_id);


--
-- TOC entry 5098 (class 2606 OID 89848)
-- Name: stu_selection stu_selection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_selection
    ADD CONSTRAINT stu_selection_pkey PRIMARY KEY (id);


--
-- TOC entry 5086 (class 2606 OID 89815)
-- Name: stu_student_info stu_student_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_student_info
    ADD CONSTRAINT stu_student_info_pkey PRIMARY KEY (id);


--
-- TOC entry 5088 (class 2606 OID 89819)
-- Name: stu_student_info stu_student_info_student_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_student_info
    ADD CONSTRAINT stu_student_info_student_no_key UNIQUE (student_no);


--
-- TOC entry 5090 (class 2606 OID 89817)
-- Name: stu_student_info stu_student_info_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_student_info
    ADD CONSTRAINT stu_student_info_user_id_key UNIQUE (user_id);


--
-- TOC entry 5084 (class 2606 OID 89807)
-- Name: sys_class sys_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_class
    ADD CONSTRAINT sys_class_pkey PRIMARY KEY (id);


--
-- TOC entry 5136 (class 2606 OID 91301)
-- Name: sys_config sys_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_config
    ADD CONSTRAINT sys_config_pkey PRIMARY KEY (config_id);


--
-- TOC entry 5107 (class 2606 OID 91127)
-- Name: sys_dept sys_dept_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dept
    ADD CONSTRAINT sys_dept_pkey PRIMARY KEY (dept_id);


--
-- TOC entry 5134 (class 2606 OID 91285)
-- Name: sys_dict_data sys_dict_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_data
    ADD CONSTRAINT sys_dict_data_pkey PRIMARY KEY (dict_code);


--
-- TOC entry 5130 (class 2606 OID 91265)
-- Name: sys_dict_type sys_dict_type_dict_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_type
    ADD CONSTRAINT sys_dict_type_dict_type_key UNIQUE (dict_type);


--
-- TOC entry 5132 (class 2606 OID 91263)
-- Name: sys_dict_type sys_dict_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_dict_type
    ADD CONSTRAINT sys_dict_type_pkey PRIMARY KEY (dict_id);


--
-- TOC entry 5082 (class 2606 OID 89799)
-- Name: sys_grade sys_grade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grade
    ADD CONSTRAINT sys_grade_pkey PRIMARY KEY (id);


--
-- TOC entry 5144 (class 2606 OID 91348)
-- Name: sys_job_log sys_job_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job_log
    ADD CONSTRAINT sys_job_log_pkey PRIMARY KEY (job_log_id);


--
-- TOC entry 5142 (class 2606 OID 91337)
-- Name: sys_job sys_job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job
    ADD CONSTRAINT sys_job_pkey PRIMARY KEY (job_id);


--
-- TOC entry 5140 (class 2606 OID 91317)
-- Name: sys_logininfor sys_logininfor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_logininfor
    ADD CONSTRAINT sys_logininfor_pkey PRIMARY KEY (info_id);


--
-- TOC entry 5115 (class 2606 OID 91201)
-- Name: sys_menu sys_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_menu
    ADD CONSTRAINT sys_menu_pkey PRIMARY KEY (menu_id);


--
-- TOC entry 5146 (class 2606 OID 91361)
-- Name: sys_notice sys_notice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_notice
    ADD CONSTRAINT sys_notice_pkey PRIMARY KEY (notice_id);


--
-- TOC entry 5128 (class 2606 OID 91245)
-- Name: sys_oper_log sys_oper_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_oper_log
    ADD CONSTRAINT sys_oper_log_pkey PRIMARY KEY (oper_id);


--
-- TOC entry 5111 (class 2606 OID 91160)
-- Name: sys_post sys_post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_post
    ADD CONSTRAINT sys_post_pkey PRIMARY KEY (post_id);


--
-- TOC entry 5121 (class 2606 OID 91216)
-- Name: sys_role_dept sys_role_dept_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_dept
    ADD CONSTRAINT sys_role_dept_pkey PRIMARY KEY (role_id, dept_id);


--
-- TOC entry 5119 (class 2606 OID 91211)
-- Name: sys_role_menu sys_role_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_menu
    ADD CONSTRAINT sys_role_menu_pkey PRIMARY KEY (role_id, menu_id);


--
-- TOC entry 5113 (class 2606 OID 91176)
-- Name: sys_role sys_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 5080 (class 2606 OID 89791)
-- Name: sys_semester sys_semester_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_semester
    ADD CONSTRAINT sys_semester_pkey PRIMARY KEY (id);


--
-- TOC entry 5109 (class 2606 OID 91148)
-- Name: sys_user sys_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 5123 (class 2606 OID 91221)
-- Name: sys_user_post sys_user_post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_post
    ADD CONSTRAINT sys_user_post_pkey PRIMARY KEY (user_id, post_id);


--
-- TOC entry 5117 (class 2606 OID 91206)
-- Name: sys_user_role sys_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_role
    ADD CONSTRAINT sys_user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 5137 (class 1259 OID 91319)
-- Name: idx_sys_logininfor_lt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_logininfor_lt ON public.sys_logininfor USING btree (login_time);


--
-- TOC entry 5138 (class 1259 OID 91318)
-- Name: idx_sys_logininfor_s; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_logininfor_s ON public.sys_logininfor USING btree (status);


--
-- TOC entry 5124 (class 1259 OID 91246)
-- Name: idx_sys_oper_log_bt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_oper_log_bt ON public.sys_oper_log USING btree (business_type);


--
-- TOC entry 5125 (class 1259 OID 91248)
-- Name: idx_sys_oper_log_ot; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_oper_log_ot ON public.sys_oper_log USING btree (oper_time);


--
-- TOC entry 5126 (class 1259 OID 91247)
-- Name: idx_sys_oper_log_s; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_oper_log_s ON public.sys_oper_log USING btree (status);


--
-- TOC entry 5099 (class 1259 OID 89849)
-- Name: stu_selection_unique_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX stu_selection_unique_active ON public.stu_selection USING btree (student_id, semester_id, week_day) WHERE (status = 1);


--
-- TOC entry 5176 (class 2606 OID 91446)
-- Name: qrtz_blob_triggers qrtz_blob_triggers_sched_name_trigger_name_trigger_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_sched_name_trigger_name_trigger_group_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- TOC entry 5175 (class 2606 OID 91434)
-- Name: qrtz_cron_triggers qrtz_cron_triggers_sched_name_trigger_name_trigger_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_sched_name_trigger_name_trigger_group_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- TOC entry 5174 (class 2606 OID 91422)
-- Name: qrtz_simple_triggers qrtz_simple_triggers_sched_name_trigger_name_trigger_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_sched_name_trigger_name_trigger_group_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- TOC entry 5177 (class 2606 OID 91487)
-- Name: qrtz_simprop_triggers qrtz_simprop_triggers_sched_name_trigger_name_trigger_grou_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simprop_triggers
    ADD CONSTRAINT qrtz_simprop_triggers_sched_name_trigger_name_trigger_grou_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- TOC entry 5173 (class 2606 OID 91410)
-- Name: qrtz_triggers qrtz_triggers_sched_name_job_name_job_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_sched_name_job_name_job_group_fkey FOREIGN KEY (sched_name, job_name, job_group) REFERENCES public.qrtz_job_details(sched_name, job_name, job_group);


-- Completed on 2026-03-08 21:02:41

--
-- PostgreSQL database dump complete
--

