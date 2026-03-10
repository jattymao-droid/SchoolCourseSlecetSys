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
-- Name: TABLE cou_class_quota; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cou_class_quota IS '课程班级容量表';


--
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
-- Name: cou_class_quota_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cou_class_quota_id_seq OWNED BY public.cou_class_quota.id;


--
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
-- Name: TABLE cou_course; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cou_course IS '课程表';


--
-- Name: COLUMN cou_course.week_day; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cou_course.week_day IS '星期几 1-5';


--
-- Name: COLUMN cou_course.location; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cou_course.location IS '上课地点';


--
-- Name: COLUMN cou_course.teacher_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cou_course.teacher_name IS '教师姓名（直接输入）';


--
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
-- Name: cou_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cou_course_id_seq OWNED BY public.cou_course.id;


--
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
-- Name: TABLE eva_question; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.eva_question IS '评价题目表';


--
-- Name: COLUMN eva_question.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.eva_question.status IS '1启用 0停用';


--
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
-- Name: eva_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eva_question_id_seq OWNED BY public.eva_question.id;


--
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
-- Name: TABLE gen_table; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.gen_table IS '代码生成业务表';


--
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
-- Name: TABLE gen_table_column; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.gen_table_column IS '代码生成业务表字段';


--
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
-- Name: gen_table_column_column_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gen_table_column_column_id_seq OWNED BY public.gen_table_column.column_id;


--
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
-- Name: gen_table_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gen_table_table_id_seq OWNED BY public.gen_table.table_id;


--
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
-- Name: qrtz_calendars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_calendars (
    sched_name character varying(120) NOT NULL,
    calendar_name character varying(200) NOT NULL,
    calendar bytea NOT NULL
);


ALTER TABLE public.qrtz_calendars OWNER TO postgres;

--
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
-- Name: qrtz_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_locks (
    sched_name character varying(120) NOT NULL,
    lock_name character varying(40) NOT NULL
);


ALTER TABLE public.qrtz_locks OWNER TO postgres;

--
-- Name: qrtz_paused_trigger_grps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrtz_paused_trigger_grps (
    sched_name character varying(120) NOT NULL,
    trigger_group character varying(200) NOT NULL
);


ALTER TABLE public.qrtz_paused_trigger_grps OWNER TO postgres;

--
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
-- Name: TABLE stu_evaluation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.stu_evaluation IS '学生评分表';


--
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
-- Name: stu_evaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stu_evaluation_id_seq OWNED BY public.stu_evaluation.id;


--
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
-- Name: TABLE stu_selection; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.stu_selection IS '学生选课记录表';


--
-- Name: COLUMN stu_selection.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stu_selection.status IS '1正常 0退课删除';


--
-- Name: COLUMN stu_selection.assigned; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.stu_selection.assigned IS '1管理员指定 0学生自选';


--
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
-- Name: stu_selection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stu_selection_id_seq OWNED BY public.stu_selection.id;


--
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
-- Name: TABLE stu_student_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.stu_student_info IS '学生扩展信息表';


--
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
-- Name: stu_student_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stu_student_info_id_seq OWNED BY public.stu_student_info.id;


--
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
-- Name: TABLE sys_class; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_class IS '班级表';


--
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
-- Name: sys_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_class_id_seq OWNED BY public.sys_class.id;


--
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
-- Name: TABLE sys_config; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_config IS '参数配置表';


--
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
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone
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

COMMENT ON COLUMN public.sys_dept.del_flag IS '删除标志（0代表存在 2代表删除）';


--
-- Name: COLUMN sys_dept.create_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.create_by IS '创建者';


--
-- Name: COLUMN sys_dept.create_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.create_time IS '创建时间';


--
-- Name: COLUMN sys_dept.update_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.update_by IS '更新者';


--
-- Name: COLUMN sys_dept.update_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_dept.update_time IS '更新时间';


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
-- Name: TABLE sys_dict_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_dict_data IS '字典数据表';


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
-- Name: TABLE sys_dict_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_dict_type IS '字典类型表';


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
-- Name: TABLE sys_grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_grade IS '年级表';


--
-- Name: COLUMN sys_grade.sort; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_grade.sort IS '排序，用于一键升级';


--
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
-- Name: sys_grade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_grade_id_seq OWNED BY public.sys_grade.id;


--
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
-- Name: TABLE sys_job; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_job IS '定时任务调度表';


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
-- Name: TABLE sys_job_log; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_job_log IS '定时任务调度日志表';


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
-- Name: TABLE sys_logininfor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_logininfor IS '系统访问记录';


--
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
-- Name: sys_logininfor_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_logininfor_info_id_seq OWNED BY public.sys_logininfor.info_id;


--
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
-- Name: TABLE sys_menu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_menu IS '菜单权限表';


--
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
-- Name: sys_menu_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_menu_menu_id_seq OWNED BY public.sys_menu.menu_id;


--
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
-- Name: TABLE sys_notice; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_notice IS '通知公告表';


--
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
-- Name: sys_notice_notice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_notice_notice_id_seq OWNED BY public.sys_notice.notice_id;


--
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
-- Name: TABLE sys_oper_log; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_oper_log IS '操作日志记录';


--
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
-- Name: sys_oper_log_oper_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_oper_log_oper_id_seq OWNED BY public.sys_oper_log.oper_id;


--
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
-- Name: TABLE sys_post; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_post IS '岗位信息表';


--
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
-- Name: sys_post_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_post_post_id_seq OWNED BY public.sys_post.post_id;


--
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
-- Name: TABLE sys_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_role IS '角色信息表';


--
-- Name: sys_role_dept; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role_dept (
    role_id bigint NOT NULL,
    dept_id bigint NOT NULL
);


ALTER TABLE public.sys_role_dept OWNER TO postgres;

--
-- Name: TABLE sys_role_dept; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_role_dept IS '角色和部门关联表';


--
-- Name: sys_role_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role_menu (
    role_id bigint NOT NULL,
    menu_id bigint NOT NULL
);


ALTER TABLE public.sys_role_menu OWNER TO postgres;

--
-- Name: TABLE sys_role_menu; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_role_menu IS '角色和菜单关联表';


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
-- Name: TABLE sys_semester; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_semester IS '学期表';


--
-- Name: COLUMN sys_semester.is_current; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_semester.is_current IS '是否当前学期 0否 1是';


--
-- Name: COLUMN sys_semester.selection_start_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_semester.selection_start_time IS '选课开始时间';


--
-- Name: COLUMN sys_semester.selection_end_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_semester.selection_end_time IS '选课结束时间';


--
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
-- Name: sys_semester_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sys_semester_id_seq OWNED BY public.sys_semester.id;


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
    create_time timestamp without time zone,
    update_by character varying(64) DEFAULT ''::character varying,
    update_time timestamp without time zone,
    remark character varying(500) DEFAULT NULL::character varying
);


ALTER TABLE public.sys_user OWNER TO postgres;

--
-- Name: TABLE sys_user; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_user IS '用户信息表';


--
-- Name: sys_user_post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user_post (
    user_id bigint NOT NULL,
    post_id bigint NOT NULL
);


ALTER TABLE public.sys_user_post OWNER TO postgres;

--
-- Name: TABLE sys_user_post; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_user_post IS '用户与岗位关联表';


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
-- Name: cou_class_quota id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_class_quota ALTER COLUMN id SET DEFAULT nextval('public.cou_class_quota_id_seq'::regclass);


--
-- Name: cou_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_course ALTER COLUMN id SET DEFAULT nextval('public.cou_course_id_seq'::regclass);


--
-- Name: eva_question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eva_question ALTER COLUMN id SET DEFAULT nextval('public.eva_question_id_seq'::regclass);


--
-- Name: gen_table table_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_table ALTER COLUMN table_id SET DEFAULT nextval('public.gen_table_table_id_seq'::regclass);


--
-- Name: gen_table_column column_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_table_column ALTER COLUMN column_id SET DEFAULT nextval('public.gen_table_column_column_id_seq'::regclass);


--
-- Name: stu_evaluation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_evaluation ALTER COLUMN id SET DEFAULT nextval('public.stu_evaluation_id_seq'::regclass);


--
-- Name: stu_selection id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_selection ALTER COLUMN id SET DEFAULT nextval('public.stu_selection_id_seq'::regclass);


--
-- Name: stu_student_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_student_info ALTER COLUMN id SET DEFAULT nextval('public.stu_student_info_id_seq'::regclass);


--
-- Name: sys_class id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_class ALTER COLUMN id SET DEFAULT nextval('public.sys_class_id_seq'::regclass);


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
-- Name: sys_grade id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grade ALTER COLUMN id SET DEFAULT nextval('public.sys_grade_id_seq'::regclass);


--
-- Name: sys_job job_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job ALTER COLUMN job_id SET DEFAULT nextval('public.sys_job_job_id_seq'::regclass);


--
-- Name: sys_job_log job_log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_job_log ALTER COLUMN job_log_id SET DEFAULT nextval('public.sys_job_log_job_log_id_seq'::regclass);


--
-- Name: sys_logininfor info_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_logininfor ALTER COLUMN info_id SET DEFAULT nextval('public.sys_logininfor_info_id_seq'::regclass);


--
-- Name: sys_menu menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_menu ALTER COLUMN menu_id SET DEFAULT nextval('public.sys_menu_menu_id_seq'::regclass);


--
-- Name: sys_notice notice_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_notice ALTER COLUMN notice_id SET DEFAULT nextval('public.sys_notice_notice_id_seq'::regclass);


--
-- Name: sys_oper_log oper_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_oper_log ALTER COLUMN oper_id SET DEFAULT nextval('public.sys_oper_log_oper_id_seq'::regclass);


--
-- Name: sys_post post_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_post ALTER COLUMN post_id SET DEFAULT nextval('public.sys_post_post_id_seq'::regclass);


--
-- Name: sys_role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role ALTER COLUMN role_id SET DEFAULT nextval('public.sys_role_role_id_seq'::regclass);


--
-- Name: sys_semester id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_semester ALTER COLUMN id SET DEFAULT nextval('public.sys_semester_id_seq'::regclass);


--
-- Name: sys_user user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user ALTER COLUMN user_id SET DEFAULT nextval('public.sys_user_user_id_seq'::regclass);


--
-- Data for Name: cou_class_quota; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (247, 161, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (355, 185, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (461, 207, 1, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (568, 229, 8, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (569, 230, 1, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (570, 230, 2, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (33, 117, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (34, 117, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (35, 117, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (36, 117, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (37, 117, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (38, 118, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (39, 118, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (40, 118, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (41, 118, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (42, 118, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (43, 119, 11, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (44, 119, 12, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (45, 119, 13, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (46, 119, 14, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (47, 119, 15, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (48, 120, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (49, 120, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (50, 120, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (51, 120, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (52, 120, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (53, 121, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (54, 121, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (55, 121, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (56, 121, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (57, 121, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (58, 122, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (59, 122, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (60, 122, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (61, 122, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (62, 122, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (63, 123, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (64, 123, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (65, 123, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (66, 123, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (67, 123, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (68, 124, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (69, 124, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (70, 124, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (71, 124, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (72, 124, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (73, 125, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (74, 125, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (75, 125, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (76, 125, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (77, 125, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (78, 126, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (79, 126, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (80, 126, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (81, 126, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (82, 126, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (83, 127, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (84, 127, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (85, 127, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (86, 127, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (87, 127, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (88, 128, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (89, 128, 12, 38, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (90, 128, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (91, 128, 14, 8, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (92, 128, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (93, 129, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (94, 129, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (95, 129, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (96, 129, 14, 8, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (97, 129, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (98, 130, 11, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (99, 130, 12, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (100, 130, 13, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (101, 130, 14, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (102, 130, 15, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (103, 131, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (104, 131, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (105, 131, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (106, 131, 14, 8, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (107, 131, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (108, 132, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (109, 132, 12, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (110, 132, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (111, 132, 14, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (112, 132, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (113, 133, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (114, 133, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (115, 133, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (116, 133, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (117, 133, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (118, 134, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (571, 230, 7, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (119, 134, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (120, 134, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (121, 134, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (122, 134, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (123, 135, 11, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (124, 135, 12, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (125, 135, 13, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (126, 135, 15, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (127, 136, 11, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (128, 136, 12, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (129, 136, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (130, 136, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (131, 137, 11, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (132, 137, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (133, 137, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (134, 137, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (135, 137, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (136, 138, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (137, 138, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (138, 138, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (139, 138, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (140, 138, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (141, 139, 11, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (142, 139, 12, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (143, 139, 13, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (144, 139, 14, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (145, 139, 15, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (146, 140, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (147, 140, 12, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (148, 140, 13, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (149, 140, 14, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (150, 140, 15, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (151, 141, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (152, 141, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (153, 141, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (154, 141, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (155, 141, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (156, 142, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (157, 142, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (158, 142, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (159, 142, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (160, 142, 15, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (161, 143, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (162, 143, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (163, 143, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (164, 143, 14, 8, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (165, 143, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (166, 144, 11, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (167, 144, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (168, 144, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (169, 144, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (170, 144, 15, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (171, 145, 11, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (172, 145, 12, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (173, 145, 13, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (174, 145, 14, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (175, 145, 15, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (176, 146, 11, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (177, 146, 12, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (178, 146, 13, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (179, 146, 15, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (180, 147, 11, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (181, 147, 15, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (182, 148, 12, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (183, 148, 13, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (184, 148, 15, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (185, 149, 13, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (186, 149, 14, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (187, 149, 15, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (188, 150, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (189, 150, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (190, 150, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (191, 150, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (192, 150, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (193, 151, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (194, 151, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (195, 151, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (196, 151, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (197, 151, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (198, 152, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (199, 152, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (200, 152, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (201, 152, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (202, 152, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (203, 153, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (204, 153, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (205, 153, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (206, 153, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (207, 153, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (208, 154, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (209, 154, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (210, 154, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (211, 154, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (212, 154, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (213, 155, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (214, 155, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (215, 155, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (216, 155, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (217, 155, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (218, 156, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (219, 156, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (220, 156, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (221, 156, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (222, 156, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (223, 157, 11, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (224, 157, 12, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (225, 157, 13, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (226, 157, 14, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (227, 157, 15, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (228, 158, 11, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (229, 158, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (230, 158, 13, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (231, 158, 14, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (232, 158, 15, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (233, 159, 11, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (234, 159, 12, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (235, 159, 13, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (236, 159, 14, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (237, 159, 15, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (238, 160, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (239, 160, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (240, 160, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (241, 160, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (242, 160, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (243, 161, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (244, 161, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (245, 161, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (246, 161, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (248, 162, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (249, 162, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (250, 162, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (251, 162, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (252, 162, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (253, 163, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (254, 163, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (255, 163, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (256, 163, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (257, 163, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (258, 164, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (259, 164, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (260, 164, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (261, 164, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (262, 164, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (263, 165, 11, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (264, 165, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (265, 165, 13, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (266, 165, 14, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (267, 165, 15, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (268, 166, 11, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (269, 166, 12, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (270, 166, 13, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (271, 166, 14, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (272, 166, 15, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (273, 167, 11, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (274, 167, 12, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (275, 167, 13, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (276, 167, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (277, 167, 15, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (278, 168, 11, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (279, 168, 12, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (280, 168, 13, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (281, 168, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (282, 168, 15, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (283, 169, 11, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (284, 169, 12, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (285, 169, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (286, 169, 14, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (287, 169, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (288, 170, 11, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (289, 170, 12, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (290, 170, 13, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (291, 170, 14, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (292, 170, 15, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (293, 171, 12, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (294, 171, 15, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (295, 172, 11, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (296, 172, 15, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (297, 173, 12, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (298, 173, 13, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (299, 173, 15, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (300, 174, 11, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (301, 174, 12, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (302, 174, 13, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (303, 174, 15, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (305, 175, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (306, 175, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (307, 175, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (308, 175, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (310, 176, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (311, 176, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (312, 176, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (313, 176, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (314, 177, 1, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (315, 177, 2, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (316, 177, 7, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (317, 177, 8, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (318, 177, 9, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (319, 178, 1, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (320, 178, 2, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (321, 178, 7, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (322, 178, 8, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (323, 178, 9, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (324, 179, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (325, 179, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (326, 179, 7, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (327, 179, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (328, 179, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (329, 180, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (330, 180, 2, 8, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (331, 180, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (332, 180, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (333, 180, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (334, 181, 1, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (335, 181, 2, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (336, 181, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (337, 181, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (338, 181, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (339, 182, 1, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (340, 182, 2, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (341, 182, 7, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (342, 182, 8, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (343, 182, 9, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (344, 183, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (345, 183, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (346, 183, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (347, 183, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (348, 183, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (349, 184, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (350, 184, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (351, 184, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (352, 184, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (353, 184, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (309, 176, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (356, 185, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (357, 185, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (358, 185, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (360, 186, 2, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (361, 186, 7, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (362, 186, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (363, 186, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (364, 187, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (365, 187, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (366, 187, 7, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (367, 187, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (368, 187, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (369, 188, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (370, 188, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (371, 188, 7, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (372, 188, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (373, 188, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (374, 189, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (375, 189, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (376, 189, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (377, 189, 8, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (378, 189, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (379, 190, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (380, 190, 2, 9, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (381, 190, 7, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (382, 190, 8, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (383, 190, 9, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (384, 191, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (385, 191, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (386, 191, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (387, 191, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (388, 191, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (389, 192, 1, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (390, 192, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (391, 192, 7, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (392, 192, 8, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (393, 192, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (394, 193, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (395, 193, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (396, 193, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (397, 193, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (398, 193, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (399, 194, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (400, 194, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (401, 194, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (402, 194, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (403, 194, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (404, 195, 1, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (405, 195, 7, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (406, 195, 8, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (408, 196, 2, 8, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (409, 196, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (410, 196, 8, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (411, 196, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (412, 197, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (413, 197, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (414, 197, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (415, 197, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (416, 197, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (417, 198, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (418, 198, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (419, 198, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (420, 198, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (421, 198, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (422, 199, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (423, 199, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (424, 199, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (425, 199, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (426, 199, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (428, 200, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (429, 200, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (430, 200, 8, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (431, 200, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (432, 201, 1, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (433, 201, 2, 8, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (434, 201, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (435, 201, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (436, 201, 9, 8, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (437, 202, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (438, 202, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (439, 202, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (440, 202, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (441, 202, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (442, 203, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (443, 203, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (444, 203, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (445, 203, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (446, 203, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (447, 204, 1, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (448, 204, 2, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (449, 204, 7, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (450, 204, 8, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (451, 204, 9, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (452, 205, 1, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (453, 205, 2, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (454, 205, 7, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (455, 205, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (456, 206, 1, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (457, 206, 2, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (458, 206, 7, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (459, 206, 8, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (460, 206, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (407, 196, 1, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (359, 186, 1, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (427, 200, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (462, 207, 2, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (463, 207, 7, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (464, 208, 2, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (465, 208, 7, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (467, 209, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (468, 209, 7, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (469, 209, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (470, 209, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (471, 210, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (472, 210, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (473, 210, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (474, 210, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (475, 210, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (476, 211, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (477, 211, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (478, 211, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (479, 211, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (480, 211, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (481, 212, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (482, 212, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (483, 212, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (484, 212, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (485, 212, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (487, 213, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (488, 213, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (489, 213, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (490, 213, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (491, 214, 1, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (492, 214, 2, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (493, 214, 7, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (494, 214, 8, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (495, 214, 9, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (496, 215, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (497, 215, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (498, 215, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (499, 215, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (500, 215, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (501, 216, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (502, 216, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (503, 216, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (504, 216, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (505, 216, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (506, 217, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (507, 217, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (508, 217, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (509, 217, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (510, 217, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (511, 218, 1, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (512, 218, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (513, 218, 7, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (514, 218, 8, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (515, 218, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (516, 219, 1, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (517, 219, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (518, 219, 7, 4, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (519, 219, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (520, 219, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (522, 220, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (523, 220, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (524, 220, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (525, 220, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (526, 221, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (527, 221, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (528, 221, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (529, 221, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (530, 221, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (532, 222, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (533, 222, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (534, 222, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (535, 222, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (536, 223, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (537, 223, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (538, 223, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (539, 223, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (540, 223, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (541, 224, 1, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (542, 224, 2, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (543, 224, 7, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (544, 224, 8, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (545, 224, 9, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (546, 225, 1, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (547, 225, 2, 8, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (548, 225, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (549, 225, 8, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (550, 225, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (551, 226, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (552, 226, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (553, 226, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (554, 226, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (555, 226, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (556, 227, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (557, 227, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (558, 227, 7, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (559, 227, 8, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (560, 227, 9, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (561, 228, 1, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (562, 228, 2, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (563, 228, 7, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (564, 228, 8, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (565, 228, 9, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (566, 229, 1, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (567, 229, 2, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (466, 209, 1, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (531, 222, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (486, 213, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (572, 230, 8, 2, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (573, 230, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (574, 231, 1, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (575, 231, 2, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (576, 231, 7, 1, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (577, 232, 1, 3, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (578, 232, 2, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (579, 232, 7, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (580, 232, 8, 7, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (581, 232, 9, 5, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (304, 175, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (354, 185, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');
INSERT INTO public.cou_class_quota (id, course_id, class_id, quota, selected, del_flag, create_time) VALUES (521, 220, 1, 6, 0, '0', '2026-03-09 15:56:47.945996');


--
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
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (31, '舞蹈', 2, 1, 119, '', '体道楼4楼403', 1, '2', '2026-03-06 17:57:16.632204', '晏敏');
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
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (32, '羽毛球', 2, 1, 120, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '周克虎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (33, '排球', 2, 1, 109, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (34, '物理特训营', 3, 1, 133, '', '初二4班', 1, '2', '2026-03-06 17:57:16.632204', '秦绍将');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (35, '写作指导与训练', 3, 1, 134, '', '初二1班', 1, '2', '2026-03-06 17:57:16.632204', '张淑琼');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (36, '图（途）说中国', 3, 1, 135, '', '初二2班', 1, '2', '2026-03-06 17:57:16.632204', '陈金粉');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (37, '生物实验及实践', 3, 1, 136, '', '生物实验室', 1, '2', '2026-03-06 17:57:16.632204', '潘晨');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (38, '平板摄影与图形图像处理', 3, 1, 131, '', '会泽院2楼机房', 1, '2', '2026-03-06 17:57:16.632204', '代锦');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (39, '趣味心理学', 3, 1, 107, '', '会泽院4楼心理健康教室', 1, '2', '2026-03-06 17:57:16.632204', '廖臣芸');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (40, '彩铅', 3, 1, 137, '', '体道楼4楼410', 1, '2', '2026-03-06 17:57:16.632204', '李琳');
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
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (62, '化学实验课堂', 5, 1, 150, '', '格致楼2楼化学实验室', 1, '2', '2026-03-06 17:57:16.632204', '王开金');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (63, '器乐', 5, 1, 139, '', '体道楼4楼404', 1, '2', '2026-03-06 17:57:16.632204', '汪延容');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (64, '篆刻', 5, 1, 118, '', '体道楼4楼410', 1, '2', '2026-03-06 17:57:16.632204', '李晨');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (65, '创意编程提高班', 5, 1, 130, '', '格致楼4楼机房', 1, '2', '2026-03-06 17:57:16.632204', '严彩丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (66, '机器人制作', 5, 1, 121, '', '会泽院2楼机房', 1, '2', '2026-03-06 17:57:16.632204', '严明涛');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (67, '足球', 5, 1, 132, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '董嘉');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (68, '物理实验课堂', 5, 1, 151, '', '格致楼4楼物理实验室', 1, '2', '2026-03-06 17:57:16.632204', '赵天英');
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
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (41, '合唱队(七八年级合上)40人', 3, 1, 113, '', '体道楼', 1, '2', '2026-03-06 17:57:16.632204', '唐云莲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (42, '阅读与鉴赏（名著赏析）', 3, 1, 129, '', '初二3班', 1, '2', '2026-03-06 17:57:16.632204', '何欢');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (43, '篮球提高班', 3, 1, 109, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (44, '足球男队12人', 3, 1, 132, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '董嘉');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (45, '语文特训营', 4, 1, 141, '', '初二3班', 1, '2', '2026-03-06 17:57:16.632204', '王会琼');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (46, '国学课堂', 4, 1, 142, '', '初二4班', 1, '2', '2026-03-06 17:57:16.632204', '高连武');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (47, '历史角色扮演/历史剧表演', 4, 1, 143, '', '初二5班', 1, '2', '2026-03-06 17:57:16.632204', '吴丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (48, '硬笔书法与鉴赏', 4, 1, 138, '', '初二2班', 1, '2', '2026-03-06 17:57:16.632204', '段金书');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (49, '民歌赏析', 4, 1, 144, '', '体道楼4楼408', 1, '2', '2026-03-06 17:57:16.632204', '胡庆梅');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (50, '创意编程基础班', 4, 1, 130, '', '格致楼4楼机房', 1, '2', '2026-03-06 17:57:16.632204', '严彩丽');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (51, '塑造艺术', 4, 1, 106, '', '体道楼4楼410', 1, '2', '2026-03-06 17:57:16.632204', '杨俊会');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (52, '篮球基础班', 4, 1, 108, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '唐东');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (53, '篮球校队', 4, 1, 109, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '雷杰');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (54, '足球男女队', 4, 1, 110, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '代龙炎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (55, '排球校队', 4, 1, 111, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '余运波');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (56, '乒乓球校队', 4, 1, 112, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '王卫芬');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (57, '羽毛球校队', 4, 1, 120, '', '篮球场', 1, '2', '2026-03-06 17:57:16.632204', '周克虎');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (58, '时政探寻', 5, 1, 149, '', '初二2班', 1, '2', '2026-03-06 17:57:16.632204', '谢秋梅');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (59, '演讲与主持', 5, 1, 113, '', '初二5班', 1, '2', '2026-03-06 17:57:16.632204', '唐云莲');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (60, '数学特训营', 5, 1, 122, '', '初二1班', 1, '2', '2026-03-06 17:57:16.632204', '肖艳明');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (61, '数学提升营', 5, 1, 123, '', '初二3班', 1, '2', '2026-03-06 17:57:16.632204', '夏瑞');
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (117, '数学特训营', 2, 4, 127, '', '初一4班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (118, '数学提升营', 2, 4, 128, '', '初一3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (119, '武术合上', 2, 4, 124, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (120, '篮球基础班1', 2, 4, 129, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (121, '演讲与主持', 2, 4, 113, '', '初一2班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (122, '创意编程基础班', 2, 4, 130, '', '格致楼4楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (123, '塑造艺术', 2, 4, 106, '', '体道楼4楼410', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (124, '生涯规划及团体辅导29/6/5/6/6/6', 2, 4, 107, '', '会泽院4楼心理健康教室', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (125, '平板摄影与图形图像处理24/5/5/4/4/5', 2, 4, 131, '', '会泽院2楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (126, '足球基础班', 2, 4, 132, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (127, '数学特训营', 3, 4, 127, '', '初一4班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (128, '英语口语俱乐部', 3, 4, 115, '', '初一1班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (129, '硬笔书法与鉴赏', 3, 4, 138, '', '初一5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (130, '器乐', 3, 4, 139, '', '体道楼4楼404', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (131, '国画', 3, 4, 126, '', '初二5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (132, '创意编程提高班', 3, 4, 130, '', '格致楼4楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (133, '机器人制作', 3, 4, 121, '', '会泽院2楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (134, '时政探寻', 3, 4, 140, '', '初一3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (135, '足球男队12人', 3, 4, 132, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (136, '合唱队(七八年级合上)', 3, 4, 113, '', '体道楼', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (137, '乒乓球', 3, 4, 111, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (138, '数学提升营', 4, 4, 128, '', '初一3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (139, '奥数辅导班', 4, 4, 125, '', '初一5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (140, '趣味物理', 4, 4, 145, '', '生物实验室', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (141, '阅读与鉴赏(名著赏析)', 4, 4, 146, '', '初一1班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (142, '历史角色扮演/历史剧表演', 4, 4, 147, '', '初一2班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (143, '黑白木刻', 4, 4, 137, '', '初二1班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (144, '传统文化知识竞赛', 4, 4, 148, '', '初一4班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (145, '篮球校队', 4, 4, 109, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (146, '足球男女队', 4, 4, 110, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (147, '排球校队', 4, 4, 111, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (148, '乒乓球校队', 4, 4, 112, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (149, '羽毛球校队', 4, 4, 120, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (150, '篮球基础班2', 4, 4, 129, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (151, '英语特训营', 5, 4, 114, '', '初一5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (152, '英语经典影视赏析及配音模拟', 5, 4, 116, '', '初一2班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (153, '地图简笔画和模型制作', 5, 4, 152, '', '初一4班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (154, '趣味心理学', 5, 4, 107, '', '会泽院4楼心理健康教室', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (155, '软笔书法与鉴赏', 5, 4, 102, '', '初一3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (156, '篮球提高班', 5, 4, 109, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (157, '生物绘画及模型、标本制作25/5/5/5/5/5', 5, 4, 153, '', '生物实验室', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (158, '声乐课堂', 5, 4, 144, '', '体道楼4楼408', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (159, '排球基础班', 5, 4, 111, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (160, '彩铅', 5, 4, 137, '', '初一1班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (161, '英语特训营', 1, 4, 114, '', '初一5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (162, '英语提升营', 1, 4, 115, '', '初一1班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (163, '英语书写训练', 1, 4, 116, '', '初一2班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (164, '国学课堂', 1, 4, 117, '', '初一3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (165, '篆刻', 1, 4, 118, '', '体道楼4楼410', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (166, '舞蹈', 1, 4, 119, '', '体道楼4楼403', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (167, '心理学心灵短视频分享课（合上）', 1, 4, 105, '', '初二5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (168, '羽毛球', 1, 4, 120, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (169, '影视后期编辑与制作', 1, 4, 121, '', '会泽院2楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (170, '篮球校队', 1, 4, 109, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (171, '足球女队', 1, 4, 110, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (172, '排球校队', 1, 4, 111, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (173, '乒乓球校队', 1, 4, 112, '', '格致楼话吧', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (174, '合唱队(七八年级合上)', 1, 4, 113, '', '体道楼408', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (175, '数学特训营', 2, 1, 122, '', '初二1班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (176, '数学提升营', 2, 1, 123, '', '初二3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (177, '武术合上', 2, 1, 124, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (178, '奥数辅导班', 2, 1, 125, '', '初二2班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (179, '乒乓球', 2, 1, 111, '', '格致楼话吧', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (180, '影视后期编辑与制作', 2, 1, 121, '', '会泽院2楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (181, '国画', 2, 1, 126, '', '初二5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (182, '舞蹈', 2, 1, 119, '', '体道楼4楼403', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (183, '羽毛球', 2, 1, 120, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (184, '排球', 2, 1, 109, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (185, '物理特训营', 3, 1, 133, '', '初二4班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (186, '写作指导与训练', 3, 1, 134, '', '初二1班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (187, '图（途）说中国', 3, 1, 135, '', '初二2班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (188, '生物实验及实践', 3, 1, 136, '', '生物实验室', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (189, '平板摄影与图形图像处理', 3, 1, 131, '', '会泽院2楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (190, '趣味心理学', 3, 1, 107, '', '会泽院4楼心理健康教室', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (191, '彩铅', 3, 1, 137, '', '体道楼4楼410', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (192, '合唱队(七八年级合上)40人', 3, 1, 113, '', '体道楼', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (193, '阅读与鉴赏（名著赏析）', 3, 1, 129, '', '初二3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (194, '篮球提高班', 3, 1, 109, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (195, '足球男队12人', 3, 1, 132, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (196, '语文特训营', 4, 1, 141, '', '初二3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (197, '国学课堂', 4, 1, 142, '', '初二4班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (198, '历史角色扮演/历史剧表演', 4, 1, 143, '', '初二5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (199, '硬笔书法与鉴赏', 4, 1, 138, '', '初二2班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (200, '民歌赏析', 4, 1, 144, '', '体道楼4楼408', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (201, '创意编程基础班', 4, 1, 130, '', '格致楼4楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (202, '塑造艺术', 4, 1, 106, '', '体道楼4楼410', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (203, '篮球基础班', 4, 1, 108, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (204, '篮球校队', 4, 1, 109, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (205, '足球男女队', 4, 1, 110, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (206, '排球校队', 4, 1, 111, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (207, '乒乓球校队', 4, 1, 112, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (208, '羽毛球校队', 4, 1, 120, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (209, '时政探寻', 5, 1, 149, '', '初二2班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (210, '演讲与主持', 5, 1, 113, '', '初二5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (211, '数学特训营', 5, 1, 122, '', '初二1班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (212, '数学提升营', 5, 1, 123, '', '初二3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (213, '化学实验课堂', 5, 1, 150, '', '格致楼2楼化学实验室', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (214, '器乐', 5, 1, 139, '', '体道楼4楼404', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (215, '篆刻', 5, 1, 118, '', '体道楼4楼410', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (216, '创意编程提高班', 5, 1, 130, '', '格致楼4楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (217, '机器人制作', 5, 1, 121, '', '会泽院2楼机房', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (218, '足球', 5, 1, 132, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (219, '物理实验课堂', 5, 1, 151, '', '格致楼4楼物理实验室', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (220, '英语口语俱乐部', 1, 1, 101, '', '初二4班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (221, '软笔书法与鉴赏', 1, 1, 102, '', '初二2班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (222, '英语特训营', 1, 1, 103, '', '初二1班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (223, '英语提升营', 1, 1, 104, '', '初二3班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (224, '心理学心灵短视频分享课（合上）', 1, 1, 105, '', '初二5班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (225, '钢笔淡彩', 1, 1, 106, '', '初一4班', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (226, '生涯规划及团体辅导', 1, 1, 107, '', '会泽院4楼心理健康教室', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (227, '篮球', 1, 1, 108, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (228, '篮球校队', 1, 1, 109, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (229, '足球女队', 1, 1, 110, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (230, '排球校队', 1, 1, 111, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (231, '乒乓球校队', 1, 1, 112, '', '篮球场', 1, '0', '2026-03-09 15:56:47.945996', NULL);
INSERT INTO public.cou_course (id, course_name, week_day, grade_id, teacher_id, description, location, semester_id, del_flag, create_time, teacher_name) VALUES (232, '合唱队(七八年级合上)40人', 1, 1, 113, '', '体道楼408', 1, '0', '2026-03-09 15:56:47.945996', NULL);


--
-- Data for Name: eva_question; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.eva_question (id, content, score, sort, semester_id, status, del_flag, create_time) VALUES (1, '教学内容', 10, 0, 1, 1, '0', '2026-03-08 20:52:17.784765');


--
-- Data for Name: gen_table; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: gen_table_column; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_blob_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_calendars; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_cron_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_fired_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_job_details; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_paused_trigger_grps; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_scheduler_state; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_simple_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_simprop_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: qrtz_triggers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: stu_evaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: stu_selection; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: stu_student_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2034, 2182, '3101', '曹子珺', 1, 1, '0', '2026-03-09 20:02:59.199063');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2035, 2183, '3102', '陈玟憙', 1, 1, '0', '2026-03-09 20:02:59.29481');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2036, 2184, '3103', '陈宇', 1, 1, '0', '2026-03-09 20:02:59.381933');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2037, 2185, '3104', '陈梓榆', 1, 1, '0', '2026-03-09 20:02:59.496785');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2038, 2186, '3105', '崔天雄', 1, 1, '0', '2026-03-09 20:02:59.579856');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2039, 2187, '3107', '单敬骁', 1, 1, '0', '2026-03-09 20:02:59.657948');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2040, 2188, '3108', '道泽鑫', 1, 1, '0', '2026-03-09 20:02:59.73808');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2041, 2189, '3109', '段富敏', 1, 1, '0', '2026-03-09 20:02:59.825819');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2042, 2190, '3110', '范秋菊', 1, 1, '0', '2026-03-09 20:02:59.906553');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2043, 2191, '3111', '冯吉铜', 1, 1, '0', '2026-03-09 20:02:59.990567');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2044, 2192, '3112', '桂浩云', 1, 1, '0', '2026-03-09 20:03:00.077135');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2045, 2193, '3113', '郭书衔', 1, 1, '0', '2026-03-09 20:03:00.16454');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2046, 2194, '3114', '黄毅', 1, 1, '0', '2026-03-09 20:03:00.26514');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2047, 2195, '3115', '姜林遇', 1, 1, '0', '2026-03-09 20:03:00.356254');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2048, 2196, '3116', '蒋克松', 1, 1, '0', '2026-03-09 20:03:00.4436');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2049, 2197, '3117', '康竞丹', 1, 1, '0', '2026-03-09 20:03:00.526868');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2050, 2198, '3118', '孔维和', 1, 1, '0', '2026-03-09 20:03:00.620075');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2051, 2199, '3119', '李炳涵', 1, 1, '0', '2026-03-09 20:03:00.701182');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2052, 2200, '3120', '李昊阳', 1, 1, '0', '2026-03-09 20:03:00.778493');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2053, 2201, '3121', '李瑞欣', 1, 1, '0', '2026-03-09 20:03:00.862337');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2054, 2202, '3122', '李星谊', 1, 1, '0', '2026-03-09 20:03:00.94267');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2055, 2203, '3123', '李予曦', 1, 1, '0', '2026-03-09 20:03:01.022144');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2056, 2204, '3124', '李昱圻', 1, 1, '0', '2026-03-09 20:03:01.118475');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2057, 2205, '3125', '李元淼', 1, 1, '0', '2026-03-09 20:03:01.203038');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2058, 2206, '3126', '聂馨', 1, 1, '0', '2026-03-09 20:03:01.28993');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2059, 2207, '3127', '钱浩然', 1, 1, '0', '2026-03-09 20:03:01.37393');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2060, 2208, '3128', '邱程瑞', 1, 1, '0', '2026-03-09 20:03:01.452179');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2061, 2209, '3129', '束世晨', 1, 1, '0', '2026-03-09 20:03:01.536842');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2062, 2210, '3130', '宋紫萌', 1, 1, '0', '2026-03-09 20:03:01.614892');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2063, 2211, '3131', '孙瑞', 1, 1, '0', '2026-03-09 20:03:01.709202');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2064, 2212, '3132', '孙懿轩', 1, 1, '0', '2026-03-09 20:03:01.791983');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2065, 2213, '3133', '汤雅菡', 1, 1, '0', '2026-03-09 20:03:01.886864');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2066, 2214, '3134', '王传博', 1, 1, '0', '2026-03-09 20:03:01.966235');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2067, 2215, '3135', '王锦', 1, 1, '0', '2026-03-09 20:03:02.047849');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2068, 2216, '3136', '王入希', 1, 1, '0', '2026-03-09 20:03:02.138214');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2069, 2217, '3137', '王瑞1', 1, 1, '0', '2026-03-09 20:03:02.219894');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2070, 2218, '3138', '王烨', 1, 1, '0', '2026-03-09 20:03:02.304964');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2071, 2219, '3139', '韦泓印', 1, 1, '0', '2026-03-09 20:03:02.392367');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2072, 2220, '3140', '吴锦奇', 1, 1, '0', '2026-03-09 20:03:02.476625');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2073, 2221, '3141', '谢文峰', 1, 1, '0', '2026-03-09 20:03:02.556605');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2074, 2222, '3142', '许雅琼', 1, 1, '0', '2026-03-09 20:03:02.641335');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2075, 2223, '3143', '姚宛妤', 1, 1, '0', '2026-03-09 20:03:02.720969');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2076, 2224, '3144', '易文博', 1, 1, '0', '2026-03-09 20:03:02.802529');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2077, 2225, '3145', '殷祥凌', 1, 1, '0', '2026-03-09 20:03:02.88212');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2078, 2226, '3146', '尹若洢', 1, 1, '0', '2026-03-09 20:03:02.965354');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2079, 2227, '3147', '余热', 1, 1, '0', '2026-03-09 20:03:03.058581');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2080, 2228, '3148', '余欣', 1, 1, '0', '2026-03-09 20:03:03.137685');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2081, 2229, '3149', '张高冉', 1, 1, '0', '2026-03-09 20:03:03.218197');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2082, 2230, '3150', '张官雯', 1, 1, '0', '2026-03-09 20:03:03.303732');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2083, 2231, '3151', '赵德忠', 1, 1, '0', '2026-03-09 20:03:03.395756');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2084, 2232, '3152', '郑硕', 1, 1, '0', '2026-03-09 20:03:03.48341');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2085, 2233, '3153', '郑阳', 1, 1, '0', '2026-03-09 20:03:03.570622');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2086, 2234, '3154', '周情缘', 1, 1, '0', '2026-03-09 20:03:03.655804');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2087, 2235, '3155', '周思彤', 1, 1, '0', '2026-03-09 20:03:03.739828');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2088, 2236, '3156', '朱硕', 1, 1, '0', '2026-03-09 20:03:03.827642');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2089, 2237, '3157', '庄程凯', 1, 1, '0', '2026-03-09 20:03:03.914168');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2090, 2238, '3158', '龙锦潇', 1, 1, '0', '2026-03-09 20:03:03.996757');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2091, 2239, '3310', '代姝琰', 1, 1, '0', '2026-03-09 20:03:04.081418');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2092, 2240, '3544', '赵泳新', 1, 1, '0', '2026-03-09 20:03:04.161459');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2093, 2241, '3201', '高馨雅', 2, 1, '0', '2026-03-09 20:03:04.244186');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2094, 2242, '3202', '金泓', 2, 1, '0', '2026-03-09 20:03:04.331035');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2095, 2243, '3203', '邹明耀', 2, 1, '0', '2026-03-09 20:03:04.414103');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2096, 2244, '3204', '尹其参', 2, 1, '0', '2026-03-09 20:03:04.500723');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2097, 2245, '3205', '朱友倩', 2, 1, '0', '2026-03-09 20:03:04.584401');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2098, 2246, '3206', '石砚清', 2, 1, '0', '2026-03-09 20:03:04.670185');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2099, 2247, '3207', '周靖凯', 2, 1, '0', '2026-03-09 20:03:04.748268');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2100, 2248, '3208', '陈熙涵', 2, 1, '0', '2026-03-09 20:03:04.831533');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2101, 2249, '3209', '刘语萱', 2, 1, '0', '2026-03-09 20:03:04.915286');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2102, 2250, '3210', '张倩瑜', 2, 1, '0', '2026-03-09 20:03:04.991784');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2103, 2251, '3211', '韩铭锐', 2, 1, '0', '2026-03-09 20:03:05.066753');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2104, 2252, '3212', '刘家榛', 2, 1, '0', '2026-03-09 20:03:05.171817');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2105, 2253, '3213', '母译心', 2, 1, '0', '2026-03-09 20:03:05.266857');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2106, 2254, '3214', '陈梦瑶', 2, 1, '0', '2026-03-09 20:03:05.349151');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2107, 2255, '3215', '刘馨', 2, 1, '0', '2026-03-09 20:03:05.439247');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2108, 2256, '3216', '邱国睿', 2, 1, '0', '2026-03-09 20:03:05.521487');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2109, 2257, '3217', '王启航', 2, 1, '0', '2026-03-09 20:03:05.615507');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2110, 2258, '3218', '锁帆', 2, 1, '0', '2026-03-09 20:03:05.716028');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2111, 2259, '3219', '肖泽旭', 2, 1, '0', '2026-03-09 20:03:05.798355');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2112, 2260, '3220', '余双文', 2, 1, '0', '2026-03-09 20:03:05.884642');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2113, 2261, '3221', '曹满莲', 2, 1, '0', '2026-03-09 20:03:05.966353');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2114, 2262, '3222', '戴桠楠', 2, 1, '0', '2026-03-09 20:03:06.055297');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2115, 2263, '3223', '陈勋坤', 2, 1, '0', '2026-03-09 20:03:06.139489');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2116, 2264, '3224', '李若菡', 2, 1, '0', '2026-03-09 20:03:06.225985');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2117, 2265, '3225', '李卓恒', 2, 1, '0', '2026-03-09 20:03:06.318016');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2118, 2266, '3226', '徐春媛', 2, 1, '0', '2026-03-09 20:03:06.403455');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2119, 2267, '3227', '杨皓钦', 2, 1, '0', '2026-03-09 20:03:06.489224');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2120, 2268, '3228', '顾洪谨', 2, 1, '0', '2026-03-09 20:03:06.604939');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2121, 2269, '3229', '王开睿', 2, 1, '0', '2026-03-09 20:03:06.699198');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2122, 2270, '3230', '熊梓君', 2, 1, '0', '2026-03-09 20:03:06.784726');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2123, 2271, '3231', '杨琳坚', 2, 1, '0', '2026-03-09 20:03:06.866311');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2124, 2272, '3232', '朱啟萌', 2, 1, '0', '2026-03-09 20:03:06.947436');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2125, 2273, '3233', '康恒', 2, 1, '0', '2026-03-09 20:03:07.029786');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2126, 2274, '3234', '颜成坤', 2, 1, '0', '2026-03-09 20:03:07.126285');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2127, 2275, '3235', '杨立', 2, 1, '0', '2026-03-09 20:03:07.212941');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2128, 2276, '3236', '陈屿珊', 2, 1, '0', '2026-03-09 20:03:07.288341');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2129, 2277, '3237', '李品兑', 2, 1, '0', '2026-03-09 20:03:07.363441');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2130, 2278, '3238', '钟翛然', 2, 1, '0', '2026-03-09 20:03:07.436524');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2131, 2279, '3239', '何鑫', 2, 1, '0', '2026-03-09 20:03:07.512348');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2132, 2280, '3240', '邹学琼', 2, 1, '0', '2026-03-09 20:03:07.585402');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2133, 2281, '3241', '赵万源', 2, 1, '0', '2026-03-09 20:03:07.666253');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2134, 2282, '3242', '解天治', 2, 1, '0', '2026-03-09 20:03:07.754273');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2135, 2283, '3243', '施江楠', 2, 1, '0', '2026-03-09 20:03:07.829196');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2136, 2284, '3244', '康泰然', 2, 1, '0', '2026-03-09 20:03:07.902395');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2137, 2285, '3245', '陈彦臣', 2, 1, '0', '2026-03-09 20:03:07.978865');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2138, 2286, '3246', '田泓彦', 2, 1, '0', '2026-03-09 20:03:08.053351');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2139, 2287, '3247', '陈达昊', 2, 1, '0', '2026-03-09 20:03:08.131095');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2140, 2288, '3248', '丁俊宇', 2, 1, '0', '2026-03-09 20:03:08.203835');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2141, 2289, '3249', '黄诗语', 2, 1, '0', '2026-03-09 20:03:08.280097');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2142, 2290, '3250', '吕玭稀', 2, 1, '0', '2026-03-09 20:03:08.350268');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2143, 2291, '3251', '毛千予', 2, 1, '0', '2026-03-09 20:03:08.429795');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2144, 2292, '3252', '彭熙倬', 2, 1, '0', '2026-03-09 20:03:08.505588');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2145, 2293, '3253', '宋弥南', 2, 1, '0', '2026-03-09 20:03:08.5837');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2146, 2294, '3254', '肖馨雅', 2, 1, '0', '2026-03-09 20:03:08.665288');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2147, 2295, '3255', '杨斯淇', 2, 1, '0', '2026-03-09 20:03:08.748503');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2148, 2296, '3256', '赵钒壹', 2, 1, '0', '2026-03-09 20:03:08.825185');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2149, 2297, '3257', '吕欣', 2, 1, '0', '2026-03-09 20:03:08.90019');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2150, 2298, '3258', '沈梦烯', 2, 1, '0', '2026-03-09 20:03:08.977012');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2151, 2299, '3259', '苏钰涵', 2, 1, '0', '2026-03-09 20:03:09.050206');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2152, 2300, '3262', '贾莉雅', 2, 1, '0', '2026-03-09 20:03:09.125486');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2153, 2301, '3106', '戴龙鑫', 7, 1, '0', '2026-03-09 20:03:09.199819');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2154, 2302, '3301', '毕广涛', 7, 1, '0', '2026-03-09 20:03:09.274916');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2155, 2303, '3302', '毕泽云', 7, 1, '0', '2026-03-09 20:03:09.34798');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2156, 2304, '3303', '蔡雨润', 7, 1, '0', '2026-03-09 20:03:09.422895');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2157, 2305, '3304', '陈吉星', 7, 1, '0', '2026-03-09 20:03:09.499662');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2158, 2306, '3305', '陈禹霏', 7, 1, '0', '2026-03-09 20:03:09.572752');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2159, 2307, '3306', '崔梦涵', 7, 1, '0', '2026-03-09 20:03:09.647794');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2160, 2308, '3307', '代冯之', 7, 1, '0', '2026-03-09 20:03:09.721069');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2161, 2309, '3308', '代龙珠', 7, 1, '0', '2026-03-09 20:03:09.800863');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2162, 2310, '3311', '杜城', 7, 1, '0', '2026-03-09 20:03:09.877356');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2163, 2311, '3312', '高华地', 7, 1, '0', '2026-03-09 20:03:09.952936');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2164, 2312, '3313', '耿德成', 7, 1, '0', '2026-03-09 20:03:10.030523');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2165, 2313, '3314', '芶子优', 7, 1, '0', '2026-03-09 20:03:10.104148');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2166, 2314, '3315', '桂钎浩', 7, 1, '0', '2026-03-09 20:03:10.180193');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2167, 2315, '3316', '胡静', 7, 1, '0', '2026-03-09 20:03:10.255526');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2168, 2316, '3317', '姜山', 7, 1, '0', '2026-03-09 20:03:10.331227');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2169, 2317, '3318', '李冬雨', 7, 1, '0', '2026-03-09 20:03:10.404359');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2170, 2318, '3319', '李佳', 7, 1, '0', '2026-03-09 20:03:10.484235');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2171, 2319, '3320', '李军蓉', 7, 1, '0', '2026-03-09 20:03:10.565238');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2172, 2320, '3321', '李泊锋', 7, 1, '0', '2026-03-09 20:03:10.649163');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2173, 2321, '3322', '李茹玉', 7, 1, '0', '2026-03-09 20:03:10.728683');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2174, 2322, '3323', '李思源', 7, 1, '0', '2026-03-09 20:03:10.803314');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2175, 2323, '3324', '李兴峰', 7, 1, '0', '2026-03-09 20:03:10.881239');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2176, 2324, '3325', '李媛红', 7, 1, '0', '2026-03-09 20:03:10.95404');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2177, 2325, '3326', '李泽楷', 7, 1, '0', '2026-03-09 20:03:11.034203');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2178, 2326, '3327', '刘祺', 7, 1, '0', '2026-03-09 20:03:11.119699');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2179, 2327, '3328', '罗春夕', 7, 1, '0', '2026-03-09 20:03:11.197346');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2180, 2328, '3329', '罗廷孟', 7, 1, '0', '2026-03-09 20:03:11.271992');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2181, 2329, '3330', '马欣然', 7, 1, '0', '2026-03-09 20:03:11.350315');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2182, 2330, '3331', '孟守懿', 7, 1, '0', '2026-03-09 20:03:11.427405');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2183, 2331, '3332', '浦雅迪', 7, 1, '0', '2026-03-09 20:03:11.503804');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2184, 2332, '3333', '沈瑞捷', 7, 1, '0', '2026-03-09 20:03:11.58127');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2185, 2333, '3334', '汤紫涵', 7, 1, '0', '2026-03-09 20:03:11.663131');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2186, 2334, '3335', '唐伟', 7, 1, '0', '2026-03-09 20:03:11.745604');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2187, 2335, '3336', '王茂语', 7, 1, '0', '2026-03-09 20:03:11.836289');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2188, 2336, '3337', '王天越', 7, 1, '0', '2026-03-09 20:03:11.931405');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2189, 2337, '3338', '王文垲', 7, 1, '0', '2026-03-09 20:03:12.015771');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2190, 2338, '3339', '王曦婷', 7, 1, '0', '2026-03-09 20:03:12.105332');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2191, 2339, '3340', '王艺诺', 7, 1, '0', '2026-03-09 20:03:12.18842');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2192, 2340, '3341', '王子瑞', 7, 1, '0', '2026-03-09 20:03:12.273125');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2193, 2341, '3342', '王梓欣', 7, 1, '0', '2026-03-09 20:03:12.362379');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2194, 2342, '3343', '肖弼开', 7, 1, '0', '2026-03-09 20:03:12.446519');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2195, 2343, '3344', '严宁康杰', 7, 1, '0', '2026-03-09 20:03:12.526894');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2196, 2344, '3345', '晏合娇', 7, 1, '0', '2026-03-09 20:03:12.607008');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2197, 2345, '3346', '杨民旭', 7, 1, '0', '2026-03-09 20:03:12.685678');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2198, 2346, '3347', '杨舒然', 7, 1, '0', '2026-03-09 20:03:12.767639');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2199, 2347, '3348', '杨雅婕', 7, 1, '0', '2026-03-09 20:03:12.853082');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2200, 2348, '3349', '袁铱蔚', 7, 1, '0', '2026-03-09 20:03:12.938544');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2201, 2349, '3350', '岳昊', 7, 1, '0', '2026-03-09 20:03:13.020166');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2202, 2350, '3351', '张佳丽', 7, 1, '0', '2026-03-09 20:03:13.108966');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2203, 2351, '3352', '张旭尧', 7, 1, '0', '2026-03-09 20:03:13.188668');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2204, 2352, '3353', '赵国尧', 7, 1, '0', '2026-03-09 20:03:13.267921');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2205, 2353, '3354', '赵婧彤', 7, 1, '0', '2026-03-09 20:03:13.351761');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2206, 2354, '3355', '朱恩泱', 7, 1, '0', '2026-03-09 20:03:13.430539');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2207, 2355, '3356', '朱祉亦', 7, 1, '0', '2026-03-09 20:03:13.510058');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2208, 2356, '3357', '徐磊', 7, 1, '0', '2026-03-09 20:03:13.586981');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2209, 2357, '3508', '代冯兮', 7, 1, '0', '2026-03-09 20:03:13.670781');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2210, 2358, '3401', '安塞玲', 8, 1, '0', '2026-03-09 20:03:13.752145');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2211, 2359, '3402', '包崇锦', 8, 1, '0', '2026-03-09 20:03:13.843437');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2212, 2360, '3404', '陈红志', 8, 1, '0', '2026-03-09 20:03:13.922699');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2213, 2361, '3405', '陈梦圆', 8, 1, '0', '2026-03-09 20:03:14.002423');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2214, 2362, '3406', '陈顺达', 8, 1, '0', '2026-03-09 20:03:14.09763');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2215, 2363, '3407', '陈漪潼', 8, 1, '0', '2026-03-09 20:03:14.177357');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2216, 2364, '3408', '褚秋奕', 8, 1, '0', '2026-03-09 20:03:14.262137');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2217, 2365, '3409', '丁俊衔', 8, 1, '0', '2026-03-09 20:03:14.346167');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2218, 2366, '3410', '付文智', 8, 1, '0', '2026-03-09 20:03:14.426112');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2219, 2367, '3411', '高金阔', 8, 1, '0', '2026-03-09 20:03:14.511021');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2220, 2368, '3412', '桂藤菁', 8, 1, '0', '2026-03-09 20:03:14.592014');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2221, 2369, '3413', '何雨润', 8, 1, '0', '2026-03-09 20:03:14.674154');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2222, 2370, '3414', '胡光秋', 8, 1, '0', '2026-03-09 20:03:14.75785');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2223, 2371, '3415', '胡涵杰', 8, 1, '0', '2026-03-09 20:03:14.839117');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2224, 2372, '3416', '华力莹', 8, 1, '0', '2026-03-09 20:03:14.922861');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2225, 2373, '3417', '黄礼芯', 8, 1, '0', '2026-03-09 20:03:15.01096');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2226, 2374, '3418', '黄曼淇', 8, 1, '0', '2026-03-09 20:03:15.094339');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2227, 2375, '3419', '陈邦仙', 8, 1, '0', '2026-03-09 20:03:15.173101');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2228, 2376, '3420', '李帛燃', 8, 1, '0', '2026-03-09 20:03:15.261378');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2229, 2377, '3421', '李冬成', 8, 1, '0', '2026-03-09 20:03:15.342794');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2230, 2378, '3422', '李文平', 8, 1, '0', '2026-03-09 20:03:15.420346');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2231, 2379, '3423', '林思琦', 8, 1, '0', '2026-03-09 20:03:15.511505');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2232, 2380, '3424', '刘承烨', 8, 1, '0', '2026-03-09 20:03:15.593934');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2233, 2381, '3425', '刘吉昊', 8, 1, '0', '2026-03-09 20:03:15.675686');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2234, 2382, '3426', '刘蕾', 8, 1, '0', '2026-03-09 20:03:15.762055');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2235, 2383, '3427', '刘思绫', 8, 1, '0', '2026-03-09 20:03:15.843648');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2236, 2384, '3428', '卢禹兴', 8, 1, '0', '2026-03-09 20:03:15.9255');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2237, 2385, '3429', '吕贤宇', 8, 1, '0', '2026-03-09 20:03:16.008203');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2238, 2386, '3430', '孟福曦', 8, 1, '0', '2026-03-09 20:03:16.087882');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2239, 2387, '3431', '缪应琼', 8, 1, '0', '2026-03-09 20:03:16.169388');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2240, 2388, '3432', '裴浩翔', 8, 1, '0', '2026-03-09 20:03:16.257643');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2241, 2389, '3433', '彭莹', 8, 1, '0', '2026-03-09 20:03:16.340986');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2242, 2390, '3434', '邱琪茸', 8, 1, '0', '2026-03-09 20:03:16.421858');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2243, 2391, '3435', '阮欣颖', 8, 1, '0', '2026-03-09 20:03:16.50311');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2244, 2392, '3436', '舒彦', 8, 1, '0', '2026-03-09 20:03:16.586087');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2245, 2393, '3437', '孙颢铭', 8, 1, '0', '2026-03-09 20:03:16.667784');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2246, 2394, '3438', '田宇欣', 8, 1, '0', '2026-03-09 20:03:16.750222');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2247, 2395, '3439', '王君瑞', 8, 1, '0', '2026-03-09 20:03:16.837428');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2248, 2396, '3440', '王瑞4', 8, 1, '0', '2026-03-09 20:03:16.931736');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2249, 2397, '3441', '王思博', 8, 1, '0', '2026-03-09 20:03:17.022386');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2250, 2398, '3442', '王梓诚', 8, 1, '0', '2026-03-09 20:03:17.105465');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2251, 2399, '3443', '吴君彩', 8, 1, '0', '2026-03-09 20:03:17.187183');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2252, 2400, '3444', '吴青阳', 8, 1, '0', '2026-03-09 20:03:17.278709');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2253, 2401, '3445', '徐浩瑀', 8, 1, '0', '2026-03-09 20:03:17.363524');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2254, 2402, '3446', '徐祥盛', 8, 1, '0', '2026-03-09 20:03:17.465599');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2255, 2403, '3447', '严宁康博', 8, 1, '0', '2026-03-09 20:03:17.549213');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2256, 2404, '3448', '余其洋', 8, 1, '0', '2026-03-09 20:03:17.631479');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2257, 2405, '3449', '袁萌', 8, 1, '0', '2026-03-09 20:03:17.709701');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2258, 2406, '3450', '张厚林', 8, 1, '0', '2026-03-09 20:03:17.791348');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2259, 2407, '3451', '黄滢睿', 8, 1, '0', '2026-03-09 20:03:17.873393');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2260, 2408, '3452', '张钰滢', 8, 1, '0', '2026-03-09 20:03:17.951442');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2261, 2409, '3453', '郑成柯', 8, 1, '0', '2026-03-09 20:03:18.032555');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2262, 2410, '3454', '周子珺', 8, 1, '0', '2026-03-09 20:03:18.114853');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2263, 2411, '3455', '周祖宇', 8, 1, '0', '2026-03-09 20:03:18.197545');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2264, 2412, '3456', '朱思颖', 8, 1, '0', '2026-03-09 20:03:18.279606');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2265, 2413, '3457', '朱雨潼', 8, 1, '0', '2026-03-09 20:03:18.363529');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2266, 2414, '3309', '代荣泽', 9, 1, '0', '2026-03-09 20:03:18.440509');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2267, 2415, '3501', '曾繁通', 9, 1, '0', '2026-03-09 20:03:18.523848');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2268, 2416, '3502', '曾玺蓉', 9, 1, '0', '2026-03-09 20:03:18.606539');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2269, 2417, '3503', '陈本佳', 9, 1, '0', '2026-03-09 20:03:18.687566');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2270, 2418, '3504', '陈柯函', 9, 1, '0', '2026-03-09 20:03:18.768605');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2271, 2419, '3505', '陈森', 9, 1, '0', '2026-03-09 20:03:18.849319');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2272, 2420, '3506', '陈铱涵', 9, 1, '0', '2026-03-09 20:03:18.941427');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2273, 2421, '3507', '崔汝霞', 9, 1, '0', '2026-03-09 20:03:19.031621');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2274, 2422, '3509', '戴大辉', 9, 1, '0', '2026-03-09 20:03:19.113124');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2275, 2423, '3510', '党颖瑶', 9, 1, '0', '2026-03-09 20:03:19.210504');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2276, 2424, '3511', '杜钰滢', 9, 1, '0', '2026-03-09 20:03:19.289204');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2277, 2425, '3512', '高健铭', 9, 1, '0', '2026-03-09 20:03:19.370659');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2278, 2426, '3513', '何进', 9, 1, '0', '2026-03-09 20:03:19.479535');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2279, 2427, '3514', '胡济鲲', 9, 1, '0', '2026-03-09 20:03:19.584995');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2280, 2428, '3515', '胡宇', 9, 1, '0', '2026-03-09 20:03:19.670964');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2281, 2429, '3516', '黄海航', 9, 1, '0', '2026-03-09 20:03:19.758987');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2282, 2430, '3517', '金源峰', 9, 1, '0', '2026-03-09 20:03:19.841927');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2283, 2431, '3518', '孔文玉', 9, 1, '0', '2026-03-09 20:03:19.923066');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2284, 2432, '3519', '李泽宸', 9, 1, '0', '2026-03-09 20:03:19.999808');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2285, 2433, '3520', '林玟君', 9, 1, '0', '2026-03-09 20:03:20.079274');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2286, 2434, '3521', '凌俊杰', 9, 1, '0', '2026-03-09 20:03:20.160528');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2287, 2435, '3522', '刘思圻', 9, 1, '0', '2026-03-09 20:03:20.241291');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2288, 2436, '3523', '刘思谣', 9, 1, '0', '2026-03-09 20:03:20.329132');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2289, 2437, '3524', '罗冰杰', 9, 1, '0', '2026-03-09 20:03:20.421959');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2290, 2438, '3525', '马想云', 9, 1, '0', '2026-03-09 20:03:20.513964');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2291, 2439, '3526', '宁静', 9, 1, '0', '2026-03-09 20:03:20.616693');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2292, 2440, '3527', '宁思萌', 9, 1, '0', '2026-03-09 20:03:20.708076');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2293, 2441, '3528', '谭庆本', 9, 1, '0', '2026-03-09 20:03:20.800506');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2294, 2442, '3529', '唐铭望', 9, 1, '0', '2026-03-09 20:03:20.885458');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2295, 2443, '3530', '王春洋', 9, 1, '0', '2026-03-09 20:03:20.966211');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2296, 2444, '3531', '王玘萌', 9, 1, '0', '2026-03-09 20:03:21.045962');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2297, 2445, '3532', '王蓉', 9, 1, '0', '2026-03-09 20:03:21.133662');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2298, 2446, '3533', '王圣淼', 9, 1, '0', '2026-03-09 20:03:21.211829');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2299, 2447, '3534', '王姝杨', 9, 1, '0', '2026-03-09 20:03:21.287751');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2300, 2448, '3535', '王思涵', 9, 1, '0', '2026-03-09 20:03:21.36778');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2301, 2449, '3536', '温力源', 9, 1, '0', '2026-03-09 20:03:21.451796');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2302, 2450, '3537', '吴加一', 9, 1, '0', '2026-03-09 20:03:21.53331');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2303, 2451, '3538', '吴金凤', 9, 1, '0', '2026-03-09 20:03:21.635411');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2304, 2452, '3539', '肖弼灏', 9, 1, '0', '2026-03-09 20:03:21.714405');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2305, 2453, '3540', '肖含', 9, 1, '0', '2026-03-09 20:03:21.791577');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2306, 2454, '3541', '谢滨羽', 9, 1, '0', '2026-03-09 20:03:21.879182');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2307, 2455, '3542', '徐琳媛', 9, 1, '0', '2026-03-09 20:03:21.964677');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2308, 2456, '3543', '鄢晨茜', 9, 1, '0', '2026-03-09 20:03:22.053339');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2309, 2457, '3545', '杨涛', 9, 1, '0', '2026-03-09 20:03:22.151883');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2310, 2458, '3546', '杨兴权', 9, 1, '0', '2026-03-09 20:03:22.24127');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2311, 2459, '3547', '杨焱博', 9, 1, '0', '2026-03-09 20:03:22.3202');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2312, 2460, '3548', '袁子鑫', 9, 1, '0', '2026-03-09 20:03:22.409947');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2313, 2461, '3549', '张丽卓', 9, 1, '0', '2026-03-09 20:03:22.495905');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2314, 2462, '3550', '张洺浥', 9, 1, '0', '2026-03-09 20:03:22.574396');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2315, 2463, '3551', '张仁熙', 9, 1, '0', '2026-03-09 20:03:22.653984');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2316, 2464, '3552', '张天鹏', 9, 1, '0', '2026-03-09 20:03:22.737458');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2317, 2465, '3553', '赵庆灵', 9, 1, '0', '2026-03-09 20:03:22.821468');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2318, 2466, '3554', '郑钰澄', 9, 1, '0', '2026-03-09 20:03:22.901956');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2319, 2467, '3555', '朱航辰', 9, 1, '0', '2026-03-09 20:03:22.984943');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2320, 2468, '3556', '朱欣怡', 9, 1, '0', '2026-03-09 20:03:23.072208');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2321, 2469, '3557', '邹潇', 9, 1, '0', '2026-03-09 20:03:23.163932');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2322, 2470, '3559', '王霄萌', 9, 1, '0', '2026-03-09 20:03:23.249391');
INSERT INTO public.stu_student_info (id, user_id, student_no, real_name, class_id, grade_id, del_flag, create_time) VALUES (2323, 2471, '3562', '高连杜', 9, 1, '0', '2026-03-09 20:03:23.337999');


--
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
-- Data for Name: sys_dept; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.196963', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.197308', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.197652', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.197973', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.198276', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.198572', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.198882', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.199192', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.199481', '', NULL);
INSERT INTO public.sys_dept (dept_id, parent_id, ancestors, dept_name, order_num, leader, phone, email, status, del_flag, create_by, create_time, update_by, update_time) VALUES (100, 0, '0', '会泽县东陆高级中学校', 0, '邓良俊', '15888888888', 'monitor@qq.com', '0', '0', 'admin', '2026-03-06 14:47:11.195905', 'admin', '2026-03-09 19:45:32.778875');


--
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
-- Data for Name: sys_grade; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_grade (id, grade_name, sort, del_flag, create_time) VALUES (3, '高三', 3, '2', '2026-03-06 10:31:31.905699');
INSERT INTO public.sys_grade (id, grade_name, sort, del_flag, create_time) VALUES (2, '高二', 2, '2', '2026-03-06 10:31:31.905264');
INSERT INTO public.sys_grade (id, grade_name, sort, del_flag, create_time) VALUES (1, '八年级', 1, '0', '2026-03-06 10:31:31.904369');
INSERT INTO public.sys_grade (id, grade_name, sort, del_flag, create_time) VALUES (4, '七年级', 0, '0', '2026-03-06 17:57:31.714221');


--
-- Data for Name: sys_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-03-06 14:47:11.369457', '', NULL, '');
INSERT INTO public.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(''ry'')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-03-06 14:47:11.370033', '', NULL, '');
INSERT INTO public.sys_job (job_id, job_name, job_group, invoke_target, cron_expression, misfire_policy, concurrent, status, create_by, create_time, update_by, update_time, remark) VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(''ry'', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-03-06 14:47:11.370342', '', NULL, '');


--
-- Data for Name: sys_job_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
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
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 144', 'Windows10', '0', '登录成功', '2026-03-09 07:40:54.95717');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Windows10', '1', '验证码错误', '2026-03-09 15:28:07.987996');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Windows10', '0', '登录成功', '2026-03-09 15:28:10.776731');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (125, '3101', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-03-09 15:48:50.714222');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (126, '3101', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-03-09 15:48:52.926368');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (127, '3101', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-09 15:48:56.456667');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Windows10', '0', '登录成功', '2026-03-09 18:03:07.595066');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Windows10', '0', '登录成功', '2026-03-09 19:38:38.98587');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Windows10', '1', '验证码已失效', '2026-03-09 19:51:16.965146');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 145', 'Windows10', '0', '登录成功', '2026-03-09 19:51:19.96284');
INSERT INTO public.sys_logininfor (info_id, user_name, ipaddr, login_location, browser, os, status, msg, login_time) VALUES (132, '3102', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-09 20:04:41.022117');


--
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
-- Data for Name: sys_notice; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_notice (notice_id, notice_title, notice_type, notice_content, status, create_by, create_time, update_by, update_time, remark) VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', '新版本内容', '0', 'admin', '2026-03-06 14:47:11.384329', '', NULL, '管理员');
INSERT INTO public.sys_notice (notice_id, notice_title, notice_type, notice_content, status, create_by, create_time, update_by, update_time, remark) VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', '维护内容', '0', 'admin', '2026-03-06 14:47:11.384875', '', NULL, '管理员');


--
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
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (215, '重置所有学生密码', 2, 'com.ruoyi.web.controller.course.StudentController.resetAllPwd()', 'POST', 1, 'admin', '研发部门', '/course/student/resetAllPwd', '127.0.0.1', '内网IP', '', '{"msg":"操作成功，共重置 577 位学生的密码为123456","code":200}', 0, NULL, '2026-03-09 07:41:07.116187', 1330);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (216, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[7,8,9,10,11,12,13,14,15,16] ', '{"msg":"成功删除 10 名学生","code":200}', 0, NULL, '2026-03-09 15:28:23.575982', 304);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (217, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:28:32.008637', 957);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (218, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:28:36.225552', 847);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (219, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:28:40.758855', 850);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (220, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:28:45.313488', 777);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (221, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:28:49.841075', 823);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (222, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:28:53.482676', 798);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (223, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:28:56.501877', 807);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (232, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 15:40:43.286216', 2994);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (224, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:29:00.778738', 720);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (225, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:29:04.958956', 726);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (226, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:29:09.372315', 718);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (227, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541,542,543,544,545,546,547,548,549,550,551,552,553,554,555,556,557,558,559,560,561,562,563,564,565,566] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 15:29:13.357398', 714);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (228, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[567,568,569,570,571,572,573,574,575,576,577,578,579,580,581,582,583] ', '{"msg":"成功删除 17 名学生","code":200}', 0, NULL, '2026-03-09 15:29:17.809185', 277);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (229, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 15:29:28.592922', 2533);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (230, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 15:29:42.986398', 1516);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (231, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 15:35:27.296045', 1943);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (233, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 15:44:38.72959', 2843);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (234, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入成功！共 290 条<br/>1、学号 3101 导入成功<br/>2、学号 3102 导入成功<br/>3、学号 3103 导入成功<br/>4、学号 3104 导入成功<br/>5、学号 3105 导入成功<br/>6、学号 3107 导入成功<br/>7、学号 3108 导入成功<br/>8、学号 3109 导入成功<br/>9、学号 3110 导入成功<br/>10、学号 3111 导入成功<br/>11、学号 3112 导入成功<br/>12、学号 3113 导入成功<br/>13、学号 3114 导入成功<br/>14、学号 3115 导入成功<br/>15、学号 3116 导入成功<br/>16、学号 3117 导入成功<br/>17、学号 3118 导入成功<br/>18、学号 3119 导入成功<br/>19、学号 3120 导入成功<br/>20、学号 3121 导入成功<br/>21、学号 3122 导入成功<br/>22、学号 3123 导入成功<br/>23、学号 3124 导入成功<br/>24、学号 3125 导入成功<br/>25、学号 3126 导入成功<br/>26、学号 3127 导入成功<br/>27、学号 3128 导入成功<br/>28、学号 3129 导入成功<br/>29、学号 3130 导入成功<br/>30、学号 3131 导入成功<br/>31、学号 3132 导入成功<br/>32、学号 3133 导入成功<br/>33、学号 3134 导入成功<br/>34、学号 3135 导入成功<br/>35、学号 3136 导入成功<br/>36、学号 3137 导入成功<br/>37、学号 3138 导入成功<br/>38、学号 3139 导入成功<br/>39、学号 3140 导入成功<br/>40、学号 3141 导入成功<br/>41、学号 3142 导入成功<br/>42、学号 3143 导入成功<br/>43、学号 3144 导入成功<br/>44、学号 3145 导入成功<br/>45、学号 3146 导入成功<br/>46、学号 3147 导入成功<br/>47、学号 3148 导入成功<br/>48、学号 3149 导入成功<br/>49、学号 3150 导入成功<br/>50、学号 3151 导入成功<br/>51、学号 3152 导入成功<br/>52、学号 3153 导入成功<br/>53、学号 3154 导入成功<br/>54、学号 3155 导入成功<br/>55、学号 3156 导入成功<br/>56、学号 3157 导入成功<br/>57、学号 3158 导入成功<br/>58、学号 3310 导入成功<br/>59、学号 3544 导入成功<br/>60、学号 3201 导入成功<br/>61、学号 3202 导入成功<br/>62、学号 3203 导入成功<br/>63、学号 3204 导入成功<br/>64、学号 3205 导入成功<br/>65、学号 3206 导入成功<br/>66、学号 3207 导入成功<br/>67、学号 3208 导入成功<br/>68、学号 3209 导入成功<br/>69、学号 3210 导入成功<br/>70、学号 3211 导入成功<br/>71、学号 3212 导入成功<br/>72、学号 3213 导入成功<br/>73、学号 3214 导入成功<br/>74、学号 3215 导入成功<br/>75、学号 3216 导入成功<br/>76、学号 3217 导入成功<br/>77、学号 3218 导入成功<br/>78、学号 3219 导入成功<br/>79、学号 3220 导入成功<br/>80、学号 3221 导入成功<br/>81、学号 3222 导入成功<br/>82、学号 3223 导入成功<br/>83、学号 3224 导入成功<br/>84、学号 3225 导入成功<br/>85、学号 3226 导入成功<br/>86、学号 3227 导入成功<br/>87、学号 3228 导入成功<br/>88、学号 3229 导入成功<br/>89、学号 3230 导入成功<br/>90、学号 3231 导入成功<br/>91、学号 3232 导入成功<br/>92、学号 3233 导入成功<br/>93、学号 3234 导入成功<br/>94、学号 3235 导入成功<br/>95、学号 3236 导入成功<br/>96、学号 3237 导入成功<br/>97、学号 3238 导入成功<br/>98、学号 3239 导入成功<br/>99、学号 3240 导入成功<br/>100、', 0, NULL, '2026-03-09 15:48:20.986663', 27250);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (235, '重置所有学生密码', 2, 'com.ruoyi.web.controller.course.StudentController.resetAllPwd()', 'POST', 1, 'admin', '研发部门', '/course/student/resetAllPwd', '127.0.0.1', '内网IP', '', '{"msg":"操作成功，共重置 290 位学生的密码为123456","code":200}', 0, NULL, '2026-03-09 15:48:31.479063', 564);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (236, '课程管理', 3, 'com.ruoyi.web.controller.course.CourseController.removeBatch()', 'DELETE', 1, 'admin', '研发部门', '/course/course/batch/31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68', '127.0.0.1', '内网IP', '[31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68] ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-09 15:49:28.47697', 252);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (237, '课程管理', 5, 'com.ruoyi.web.controller.course.CourseController.importTemplate()', 'POST', 1, 'admin', '研发部门', '/course/course/importTemplate', '127.0.0.1', '内网IP', '', NULL, 0, NULL, '2026-03-09 15:49:55.887835', 229);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (238, '课程管理', 6, 'com.ruoyi.web.controller.course.CourseController.importData()', 'POST', 1, 'admin', '研发部门', '/course/course/importData', '127.0.0.1', '内网IP', 'false ', '{"msg":"导入完成，成功 0 条，失败 116 条<br/>1、数学特训营：星期格式错误，应为1-5的数字<br/>2、数学提升营：星期格式错误，应为1-5的数字<br/>3、武术合上：星期格式错误，应为1-5的数字<br/>4、篮球基础班1：星期格式错误，应为1-5的数字<br/>5、演讲与主持：星期格式错误，应为1-5的数字<br/>6、创意编程基础班：星期格式错误，应为1-5的数字<br/>7、塑造艺术：星期格式错误，应为1-5的数字<br/>8、生涯规划及团体辅导29/6/5/6/6/6：星期格式错误，应为1-5的数字<br/>9、平板摄影与图形图像处理24/5/5/4/4/5：星期格式错误，应为1-5的数字<br/>10、足球基础班：星期格式错误，应为1-5的数字<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 15:53:06.580514', 68);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (244, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3101', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"185"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 15:57:20.895507', 39);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (248, '退课', 3, 'com.ruoyi.web.controller.course.SelectionController.dropCourse()', 'POST', 1, '3101', NULL, '/course/selection/drop/1', '127.0.0.1', '内网IP', '1 ', '{"msg":"操作成功","code":200,"data":{"msg":"退课成功，其余课程已放回选课车，请补选后提交","cart":{2:{"assigned":false,"classId":1,"className":"1班","courseId":175,"courseName":"数学特训营","semesterId":1,"teacherName":"肖艳明","weekDay":2},3:{"assigned":false,"classId":1,"className":"1班","courseId":185,"courseName":"物理特训营","semesterId":1,"teacherName":"秦绍将","weekDay":3},4:{"assigned":false,"classId":1,"className":"1班","courseId":196,"courseName":"语文特训营","semesterId":1,"teacherName":"王会琼","weekDay":4},5:{"assigned":false,"classId":1,"className":"1班","courseId":209,"courseName":"时政探寻","semesterId":1,"teacherName":"谢秋梅","weekDay":5}}}}', 0, NULL, '2026-03-09 15:57:32.442934', 51);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (251, '学期管理', 3, 'com.ruoyi.web.controller.course.SemesterController.remove()', 'DELETE', 1, 'admin', '研发部门', '/course/semester/2', '127.0.0.1', '内网IP', '2 ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-09 15:57:56.96433', 15);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (239, '课程管理', 6, 'com.ruoyi.web.controller.course.CourseController.importData()', 'POST', 1, 'admin', '研发部门', '/course/course/importData', '127.0.0.1', '内网IP', 'false ', '{"msg":"导入完成，成功 0 条，失败 116 条<br/>1、数学特训营：学期不存在: 陆德贵<br/>2、数学提升营：学期不存在: 解琪<br/>3、武术合上：学期不存在: 毛永洲<br/>4、篮球基础班1：学期不存在: 何欢<br/>5、演讲与主持：学期不存在: 唐云莲<br/>6、创意编程基础班：学期不存在: 严彩丽<br/>7、塑造艺术：学期不存在: 杨俊会<br/>8、生涯规划及团体辅导29/6/5/6/6/6：学期不存在: 廖臣芸<br/>9、平板摄影与图形图像处理24/5/5/4/4/5：学期不存在: 代锦<br/>10、足球基础班：学期不存在: 董嘉<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 15:55:24.490952', 435);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (240, '课程管理', 6, 'com.ruoyi.web.controller.course.CourseController.importData()', 'POST', 1, 'admin', '研发部门', '/course/course/importData', '127.0.0.1', '内网IP', 'false ', '{"msg":"导入完成，成功 0 条，失败 116 条<br/>1、数学特训营：学期不存在: 陆德贵<br/>2、数学提升营：学期不存在: 解琪<br/>3、武术合上：学期不存在: 毛永洲<br/>4、篮球基础班1：学期不存在: 何欢<br/>5、演讲与主持：学期不存在: 唐云莲<br/>6、创意编程基础班：学期不存在: 严彩丽<br/>7、塑造艺术：学期不存在: 杨俊会<br/>8、生涯规划及团体辅导29/6/5/6/6/6：学期不存在: 廖臣芸<br/>9、平板摄影与图形图像处理24/5/5/4/4/5：学期不存在: 代锦<br/>10、足球基础班：学期不存在: 董嘉<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 15:55:35.552468', 276);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (241, '课程管理', 6, 'com.ruoyi.web.controller.course.CourseController.importData()', 'POST', 1, 'admin', '研发部门', '/course/course/importData', '127.0.0.1', '内网IP', 'false ', '{"msg":"导入完成，成功 116 条","code":200}', 0, NULL, '2026-03-09 15:56:51.323877', 3397);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (242, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3101', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"220"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 15:57:17.085571', 34);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (243, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3101', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"175"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 15:57:19.447204', 36);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (245, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3101', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"196"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 15:57:22.242454', 25);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (246, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3101', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"209"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 15:57:23.89196', 31);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (247, '选课', 1, 'com.ruoyi.web.controller.course.SelectionController.submitSelection()', 'POST', 1, '3101', NULL, '/course/selection/submit', '127.0.0.1', '内网IP', '{"semesterId":"1"}', '{"msg":"选课成功","code":200}', 0, NULL, '2026-03-09 15:57:27.397474', 42);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (249, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3101', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"222"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 15:57:36.924818', 32);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (250, '选课', 1, 'com.ruoyi.web.controller.course.SelectionController.submitSelection()', 'POST', 1, '3101', NULL, '/course/selection/submit', '127.0.0.1', '内网IP', '{"semesterId":"1"}', '{"msg":"选课成功","code":200}', 0, NULL, '2026-03-09 15:57:39.163951', 26);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (252, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[584] ', '{"msg":"成功删除 1 名学生","code":200}', 0, NULL, '2026-03-09 18:14:39.38076', 127);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (253, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[585,586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,620,621,622,623,624,625,626,627,628,629,630,631,632,633,634] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 18:14:53.97055', 1967);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (254, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[635,636,637,638,639,640,641,642,643,644,645,646,647,648,649,650,651,652,653,654,655,656,657,658,659,660,661,662,663,664,665,666,667,668,669,670,671,672,673,674,675,676,677,678,679,680,681,682,683,684] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 18:15:03.308775', 1339);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (255, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[685,686,687,688,689,690,691,692,693,694,695,696,697,698,699,700,701,702,703,704,705,706,707,708,709,710,711,712,713,714,715,716,717,718,719,720,721,722,723,724,725,726,727,728,729,730,731,732,733,734] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 18:15:11.772994', 1139);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (256, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[735,736,737,738,739,740,741,742,743,744,745,746,747,748,749,750,751,752,753,754,755,756,757,758,759,760,761,762,763,764,765,766,767,768,769,770,771,772,773,774,775,776,777,778,779,780,781,782,783,784] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 18:15:21.040548', 1245);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (257, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[785,786,787,788,789,790,791,792,793,794,795,796,797,798,799,800,801,802,803,804,805,806,807,808,809,810,811,812,813,814,815,816,817,818,819,820,821,822,823,824,825,826,827,828,829,830,831,832,833,834] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 18:15:27.656532', 1247);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (258, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[835,836,837,838,839,840,841,842,843,844,845,846,847,848,849,850,851,852,853,854,855,856,857,858,859,860,861,862,863,864,865,866,867,868,869,870,871,872,873] ', '{"msg":"成功删除 39 名学生","code":200}', 0, NULL, '2026-03-09 18:15:34.424082', 967);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (259, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 18:15:47.849277', 3701);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (260, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 18:18:13.449355', 2557);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (261, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入成功！共 290 条<br/>1、学号 3101 导入成功<br/>2、学号 3102 导入成功<br/>3、学号 3103 导入成功<br/>4、学号 3104 导入成功<br/>5、学号 3105 导入成功<br/>6、学号 3107 导入成功<br/>7、学号 3108 导入成功<br/>8、学号 3109 导入成功<br/>9、学号 3110 导入成功<br/>10、学号 3111 导入成功<br/>11、学号 3112 导入成功<br/>12、学号 3113 导入成功<br/>13、学号 3114 导入成功<br/>14、学号 3115 导入成功<br/>15、学号 3116 导入成功<br/>16、学号 3117 导入成功<br/>17、学号 3118 导入成功<br/>18、学号 3119 导入成功<br/>19、学号 3120 导入成功<br/>20、学号 3121 导入成功<br/>21、学号 3122 导入成功<br/>22、学号 3123 导入成功<br/>23、学号 3124 导入成功<br/>24、学号 3125 导入成功<br/>25、学号 3126 导入成功<br/>26、学号 3127 导入成功<br/>27、学号 3128 导入成功<br/>28、学号 3129 导入成功<br/>29、学号 3130 导入成功<br/>30、学号 3131 导入成功<br/>31、学号 3132 导入成功<br/>32、学号 3133 导入成功<br/>33、学号 3134 导入成功<br/>34、学号 3135 导入成功<br/>35、学号 3136 导入成功<br/>36、学号 3137 导入成功<br/>37、学号 3138 导入成功<br/>38、学号 3139 导入成功<br/>39、学号 3140 导入成功<br/>40、学号 3141 导入成功<br/>41、学号 3142 导入成功<br/>42、学号 3143 导入成功<br/>43、学号 3144 导入成功<br/>44、学号 3145 导入成功<br/>45、学号 3146 导入成功<br/>46、学号 3147 导入成功<br/>47、学号 3148 导入成功<br/>48、学号 3149 导入成功<br/>49、学号 3150 导入成功<br/>50、学号 3151 导入成功<br/>51、学号 3152 导入成功<br/>52、学号 3153 导入成功<br/>53、学号 3154 导入成功<br/>54、学号 3155 导入成功<br/>55、学号 3156 导入成功<br/>56、学号 3157 导入成功<br/>57、学号 3158 导入成功<br/>58、学号 3310 导入成功<br/>59、学号 3544 导入成功<br/>60、学号 3201 导入成功<br/>61、学号 3202 导入成功<br/>62、学号 3203 导入成功<br/>63、学号 3204 导入成功<br/>64、学号 3205 导入成功<br/>65、学号 3206 导入成功<br/>66、学号 3207 导入成功<br/>67、学号 3208 导入成功<br/>68、学号 3209 导入成功<br/>69、学号 3210 导入成功<br/>70、学号 3211 导入成功<br/>71、学号 3212 导入成功<br/>72、学号 3213 导入成功<br/>73、学号 3214 导入成功<br/>74、学号 3215 导入成功<br/>75、学号 3216 导入成功<br/>76、学号 3217 导入成功<br/>77、学号 3218 导入成功<br/>78、学号 3219 导入成功<br/>79、学号 3220 导入成功<br/>80、学号 3221 导入成功<br/>81、学号 3222 导入成功<br/>82、学号 3223 导入成功<br/>83、学号 3224 导入成功<br/>84、学号 3225 导入成功<br/>85、学号 3226 导入成功<br/>86、学号 3227 导入成功<br/>87、学号 3228 导入成功<br/>88、学号 3229 导入成功<br/>89、学号 3230 导入成功<br/>90、学号 3231 导入成功<br/>91、学号 3232 导入成功<br/>92、学号 3233 导入成功<br/>93、学号 3234 导入成功<br/>94、学号 3235 导入成功<br/>95、学号 3236 导入成功<br/>96、学号 3237 导入成功<br/>97、学号 3238 导入成功<br/>98、学号 3239 导入成功<br/>99、学号 3240 导入成功<br/>100、', 0, NULL, '2026-03-09 19:39:40.447625', 24781);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (262, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[874,875,876,877,878,879,880,881,882,883,884,885,886,887,888,889,890,891,892,893,894,895,896,897,898,899,900,901,902,903,904,905,906,907,908,909,910,911,912,913,914,915,916,917,918,919,920,921,922,923] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:39:56.359503', 746);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (263, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[924,925,926,927,928,929,930,931,932,933,934,935,936,937,938,939,940,941,942,943,944,945,946,947,948,949,950,951,952,953,954,955,956,957,958,959,960,961,962,963,964,965,966,967,968,969,970,971,972,973] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:39:59.86214', 682);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (264, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[974,975,976,977,978,979,980,981,982,983,984,985,986,987,988,989,990,991,992,993,994,995,996,997,998,999,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:40:27.067853', 639);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (265, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1041,1042,1043,1044,1045,1046,1047,1048,1049,1050,1051,1052,1053,1054,1055,1056,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1070,1071,1072,1073] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:40:30.595009', 604);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (266, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1093,1094,1095,1096,1097,1098,1099,1100,1101,1102,1103,1104,1105,1106,1107,1108,1109,1110,1111,1112,1113,1114,1115,1116,1117,1118,1119,1120,1121,1122,1123] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:40:33.830029', 649);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (267, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1124,1125,1126,1127,1128,1129,1130,1131,1132,1133,1134,1135,1136,1137,1138,1139,1140,1141,1142,1143,1144,1145,1146,1147,1148,1149,1150,1151,1152,1153,1154,1155,1156,1157,1158,1159,1160,1161,1162,1163] ', '{"msg":"成功删除 40 名学生","code":200}', 0, NULL, '2026-03-09 19:40:37.246587', 481);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (268, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 19:40:45.528924', 1952);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (269, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 19:41:49.52105', 1538);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (270, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{"ancestors":"0","children":[],"deptId":100,"deptName":"会泽县东陆高级中学校","email":"monitor@qq.com","leader":"邓良俊","orderNum":0,"params":{},"parentId":0,"phone":"15888888888","status":"0","updateBy":"admin"} ', '{"msg":"操作成功","code":200}', 0, NULL, '2026-03-09 19:45:32.802922', 17);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (283, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1518,1519,1520,1521,1522,1523,1524,1525,1526,1527,1528,1529,1530,1531,1532,1533,1534,1535,1536,1537,1538,1539,1540,1541,1542,1543,1544,1545,1546,1547,1548,1549,1550,1551,1552,1553] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:57:49.226497', 823);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (271, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入成功！共 290 条<br/>1、学号 3101 导入成功<br/>2、学号 3102 导入成功<br/>3、学号 3103 导入成功<br/>4、学号 3104 导入成功<br/>5、学号 3105 导入成功<br/>6、学号 3107 导入成功<br/>7、学号 3108 导入成功<br/>8、学号 3109 导入成功<br/>9、学号 3110 导入成功<br/>10、学号 3111 导入成功<br/>11、学号 3112 导入成功<br/>12、学号 3113 导入成功<br/>13、学号 3114 导入成功<br/>14、学号 3115 导入成功<br/>15、学号 3116 导入成功<br/>16、学号 3117 导入成功<br/>17、学号 3118 导入成功<br/>18、学号 3119 导入成功<br/>19、学号 3120 导入成功<br/>20、学号 3121 导入成功<br/>21、学号 3122 导入成功<br/>22、学号 3123 导入成功<br/>23、学号 3124 导入成功<br/>24、学号 3125 导入成功<br/>25、学号 3126 导入成功<br/>26、学号 3127 导入成功<br/>27、学号 3128 导入成功<br/>28、学号 3129 导入成功<br/>29、学号 3130 导入成功<br/>30、学号 3131 导入成功<br/>31、学号 3132 导入成功<br/>32、学号 3133 导入成功<br/>33、学号 3134 导入成功<br/>34、学号 3135 导入成功<br/>35、学号 3136 导入成功<br/>36、学号 3137 导入成功<br/>37、学号 3138 导入成功<br/>38、学号 3139 导入成功<br/>39、学号 3140 导入成功<br/>40、学号 3141 导入成功<br/>41、学号 3142 导入成功<br/>42、学号 3143 导入成功<br/>43、学号 3144 导入成功<br/>44、学号 3145 导入成功<br/>45、学号 3146 导入成功<br/>46、学号 3147 导入成功<br/>47、学号 3148 导入成功<br/>48、学号 3149 导入成功<br/>49、学号 3150 导入成功<br/>50、学号 3151 导入成功<br/>51、学号 3152 导入成功<br/>52、学号 3153 导入成功<br/>53、学号 3154 导入成功<br/>54、学号 3155 导入成功<br/>55、学号 3156 导入成功<br/>56、学号 3157 导入成功<br/>57、学号 3158 导入成功<br/>58、学号 3310 导入成功<br/>59、学号 3544 导入成功<br/>60、学号 3201 导入成功<br/>61、学号 3202 导入成功<br/>62、学号 3203 导入成功<br/>63、学号 3204 导入成功<br/>64、学号 3205 导入成功<br/>65、学号 3206 导入成功<br/>66、学号 3207 导入成功<br/>67、学号 3208 导入成功<br/>68、学号 3209 导入成功<br/>69、学号 3210 导入成功<br/>70、学号 3211 导入成功<br/>71、学号 3212 导入成功<br/>72、学号 3213 导入成功<br/>73、学号 3214 导入成功<br/>74、学号 3215 导入成功<br/>75、学号 3216 导入成功<br/>76、学号 3217 导入成功<br/>77、学号 3218 导入成功<br/>78、学号 3219 导入成功<br/>79、学号 3220 导入成功<br/>80、学号 3221 导入成功<br/>81、学号 3222 导入成功<br/>82、学号 3223 导入成功<br/>83、学号 3224 导入成功<br/>84、学号 3225 导入成功<br/>85、学号 3226 导入成功<br/>86、学号 3227 导入成功<br/>87、学号 3228 导入成功<br/>88、学号 3229 导入成功<br/>89、学号 3230 导入成功<br/>90、学号 3231 导入成功<br/>91、学号 3232 导入成功<br/>92、学号 3233 导入成功<br/>93、学号 3234 导入成功<br/>94、学号 3235 导入成功<br/>95、学号 3236 导入成功<br/>96、学号 3237 导入成功<br/>97、学号 3238 导入成功<br/>98、学号 3239 导入成功<br/>99、学号 3240 导入成功<br/>100、', 0, NULL, '2026-03-09 19:51:56.550482', 23775);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (272, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1164,1165,1166,1167,1168,1169,1170,1171,1172,1173] ', '{"msg":"成功删除 10 名学生","code":200}', 0, NULL, '2026-03-09 19:52:10.244776', 107);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (273, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1174,1175,1176,1177,1178,1179,1180,1181,1182,1183,1184,1185,1186,1187,1188,1189,1190,1191,1192,1193,1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,1206,1207,1208,1209,1210,1211,1212,1213,1214,1215,1216,1217,1218,1219,1220,1221,1222,1223] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:52:17.604516', 567);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (274, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1224,1225,1226,1227,1228,1229,1230,1231,1232,1233,1234,1235,1236,1237,1238,1239,1240,1241,1242,1243,1244,1245,1246,1247,1248,1249,1250,1251,1252,1253,1254,1255,1256,1257,1258,1259,1260,1261,1262,1263,1264,1265,1266,1267,1268,1269,1270,1271,1272,1273] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:52:20.691826', 481);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (275, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1274,1275,1276,1277,1278,1279,1280,1281,1282,1283,1284,1285,1286,1287,1288,1289,1290,1291,1292,1293,1294,1295,1296,1297,1298,1299,1300,1301,1302,1303,1304,1305,1306,1307,1308,1309,1310,1311,1312,1313,1314,1315,1316,1317,1318,1319,1320,1321,1322,1323] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:52:23.461475', 508);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (276, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1324,1325,1326,1327,1328,1329,1330,1331,1332,1333,1334,1335,1336,1337,1338,1339,1340,1341,1342,1343,1344,1345,1346,1347,1348,1349,1350,1351,1352,1353,1354,1355,1356,1357,1358,1359,1360,1361,1362,1363,1364,1365,1366,1367,1368,1369,1370,1371,1372,1373] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:52:26.710886', 537);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (277, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1374,1375,1376,1377,1378,1379,1380,1381,1382,1383,1384,1385,1386,1387,1388,1389,1390,1391,1392,1393,1394,1395,1396,1397,1398,1399,1400,1401,1402,1403,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413,1414,1415,1416,1417,1418,1419,1420,1421,1422,1423] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:52:29.730275', 484);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (278, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1424,1425,1426,1427,1428,1429,1430,1431,1432,1433,1434,1435,1436,1437,1438,1439,1440,1441,1442,1443,1444,1445,1446,1447,1448,1449,1450,1451,1452,1453] ', '{"msg":"成功删除 30 名学生","code":200}', 0, NULL, '2026-03-09 19:52:32.832022', 383);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (279, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 19:52:39.578157', 1257);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (280, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 19:56:17.384021', 3259);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (281, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入成功！共 290 条<br/>1、学号 3101 导入成功<br/>2、学号 3102 导入成功<br/>3、学号 3103 导入成功<br/>4、学号 3104 导入成功<br/>5、学号 3105 导入成功<br/>6、学号 3107 导入成功<br/>7、学号 3108 导入成功<br/>8、学号 3109 导入成功<br/>9、学号 3110 导入成功<br/>10、学号 3111 导入成功<br/>11、学号 3112 导入成功<br/>12、学号 3113 导入成功<br/>13、学号 3114 导入成功<br/>14、学号 3115 导入成功<br/>15、学号 3116 导入成功<br/>16、学号 3117 导入成功<br/>17、学号 3118 导入成功<br/>18、学号 3119 导入成功<br/>19、学号 3120 导入成功<br/>20、学号 3121 导入成功<br/>21、学号 3122 导入成功<br/>22、学号 3123 导入成功<br/>23、学号 3124 导入成功<br/>24、学号 3125 导入成功<br/>25、学号 3126 导入成功<br/>26、学号 3127 导入成功<br/>27、学号 3128 导入成功<br/>28、学号 3129 导入成功<br/>29、学号 3130 导入成功<br/>30、学号 3131 导入成功<br/>31、学号 3132 导入成功<br/>32、学号 3133 导入成功<br/>33、学号 3134 导入成功<br/>34、学号 3135 导入成功<br/>35、学号 3136 导入成功<br/>36、学号 3137 导入成功<br/>37、学号 3138 导入成功<br/>38、学号 3139 导入成功<br/>39、学号 3140 导入成功<br/>40、学号 3141 导入成功<br/>41、学号 3142 导入成功<br/>42、学号 3143 导入成功<br/>43、学号 3144 导入成功<br/>44、学号 3145 导入成功<br/>45、学号 3146 导入成功<br/>46、学号 3147 导入成功<br/>47、学号 3148 导入成功<br/>48、学号 3149 导入成功<br/>49、学号 3150 导入成功<br/>50、学号 3151 导入成功<br/>51、学号 3152 导入成功<br/>52、学号 3153 导入成功<br/>53、学号 3154 导入成功<br/>54、学号 3155 导入成功<br/>55、学号 3156 导入成功<br/>56、学号 3157 导入成功<br/>57、学号 3158 导入成功<br/>58、学号 3310 导入成功<br/>59、学号 3544 导入成功<br/>60、学号 3201 导入成功<br/>61、学号 3202 导入成功<br/>62、学号 3203 导入成功<br/>63、学号 3204 导入成功<br/>64、学号 3205 导入成功<br/>65、学号 3206 导入成功<br/>66、学号 3207 导入成功<br/>67、学号 3208 导入成功<br/>68、学号 3209 导入成功<br/>69、学号 3210 导入成功<br/>70、学号 3211 导入成功<br/>71、学号 3212 导入成功<br/>72、学号 3213 导入成功<br/>73、学号 3214 导入成功<br/>74、学号 3215 导入成功<br/>75、学号 3216 导入成功<br/>76、学号 3217 导入成功<br/>77、学号 3218 导入成功<br/>78、学号 3219 导入成功<br/>79、学号 3220 导入成功<br/>80、学号 3221 导入成功<br/>81、学号 3222 导入成功<br/>82、学号 3223 导入成功<br/>83、学号 3224 导入成功<br/>84、学号 3225 导入成功<br/>85、学号 3226 导入成功<br/>86、学号 3227 导入成功<br/>87、学号 3228 导入成功<br/>88、学号 3229 导入成功<br/>89、学号 3230 导入成功<br/>90、学号 3231 导入成功<br/>91、学号 3232 导入成功<br/>92、学号 3233 导入成功<br/>93、学号 3234 导入成功<br/>94、学号 3235 导入成功<br/>95、学号 3236 导入成功<br/>96、学号 3237 导入成功<br/>97、学号 3238 导入成功<br/>98、学号 3239 导入成功<br/>99、学号 3240 导入成功<br/>100、', 0, NULL, '2026-03-09 19:57:23.325715', 27067);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (282, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1454,1455,1456,1457,1458,1459,1460,1461,1462,1463,1464,1465,1466,1467,1468,1469,1470,1471,1472,1473,1474,1475,1476,1477,1478,1479,1480,1481,1482,1483,1484,1485,1486,1487,1488,1489,1490,1491,1492,1493,1494,1495,1496,1497,1498,1499,1500,1501,1502,1503] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:57:45.594427', 874);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (306, '选课', 1, 'com.ruoyi.web.controller.course.SelectionController.submitSelection()', 'POST', 1, '3102', NULL, '/course/selection/submit', '127.0.0.1', '内网IP', '{"semesterId":"1"}', '{"msg":"选课成功","code":200}', 0, NULL, '2026-03-09 20:05:29.734965', 27);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (284, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1554,1555,1556,1557,1558,1559,1560,1561,1562,1563,1564,1565,1566,1567,1568,1569,1570,1571,1572,1573,1574,1575,1576,1577,1578,1579,1580,1581,1582,1583,1584,1585,1586,1587,1588,1589,1590,1591,1592,1593,1594,1595,1596,1597,1598,1599,1600,1601,1602,1603] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:57:53.447796', 722);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (285, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1604,1605,1606,1607,1608,1609,1610,1611,1612,1613,1614,1615,1616,1617,1618,1619,1620,1621,1622,1623,1624,1625,1626,1627,1628,1629,1630,1631,1632,1633,1634,1635,1636,1637,1638,1639,1640,1641,1642,1643,1644,1645,1646,1647,1648,1649,1650,1651,1652,1653] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:57:56.710321', 737);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (286, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1654,1655,1656,1657,1658,1659,1660,1661,1662,1663,1664,1665,1666,1667,1668,1669,1670,1671,1672,1673,1674,1675,1676,1677,1678,1679,1680,1681,1682,1683,1684,1685,1686,1687,1688,1689,1690,1691,1692,1693,1694,1695,1696,1697,1698,1699,1700,1701,1702,1703] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 19:58:00.8709', 655);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (287, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1704,1705,1706,1707,1708,1709,1710,1711,1712,1713,1714,1715,1716,1717,1718,1719,1720,1721,1722,1723,1724,1725,1726,1727,1728,1729,1730,1731,1732,1733,1734,1735,1736,1737,1738,1739,1740,1741,1742,1743] ', '{"msg":"成功删除 40 名学生","code":200}', 0, NULL, '2026-03-09 19:58:05.350464', 615);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (288, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入失败！共 290 条数据格式不正确：<br/>1、学号 3101 已存在（包含物理冲突或账号冲突）<br/>2、学号 3102 已存在（包含物理冲突或账号冲突）<br/>3、学号 3103 已存在（包含物理冲突或账号冲突）<br/>4、学号 3104 已存在（包含物理冲突或账号冲突）<br/>5、学号 3105 已存在（包含物理冲突或账号冲突）<br/>6、学号 3107 已存在（包含物理冲突或账号冲突）<br/>7、学号 3108 已存在（包含物理冲突或账号冲突）<br/>8、学号 3109 已存在（包含物理冲突或账号冲突）<br/>9、学号 3110 已存在（包含物理冲突或账号冲突）<br/>10、学号 3111 已存在（包含物理冲突或账号冲突）<br/>... (更多错误已省略)","code":200}', 0, NULL, '2026-03-09 19:58:13.281244', 1873);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (289, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入成功！共 290 条<br/>1、学号 3101 导入成功<br/>2、学号 3102 导入成功<br/>3、学号 3103 导入成功<br/>4、学号 3104 导入成功<br/>5、学号 3105 导入成功<br/>6、学号 3107 导入成功<br/>7、学号 3108 导入成功<br/>8、学号 3109 导入成功<br/>9、学号 3110 导入成功<br/>10、学号 3111 导入成功<br/>11、学号 3112 导入成功<br/>12、学号 3113 导入成功<br/>13、学号 3114 导入成功<br/>14、学号 3115 导入成功<br/>15、学号 3116 导入成功<br/>16、学号 3117 导入成功<br/>17、学号 3118 导入成功<br/>18、学号 3119 导入成功<br/>19、学号 3120 导入成功<br/>20、学号 3121 导入成功<br/>21、学号 3122 导入成功<br/>22、学号 3123 导入成功<br/>23、学号 3124 导入成功<br/>24、学号 3125 导入成功<br/>25、学号 3126 导入成功<br/>26、学号 3127 导入成功<br/>27、学号 3128 导入成功<br/>28、学号 3129 导入成功<br/>29、学号 3130 导入成功<br/>30、学号 3131 导入成功<br/>31、学号 3132 导入成功<br/>32、学号 3133 导入成功<br/>33、学号 3134 导入成功<br/>34、学号 3135 导入成功<br/>35、学号 3136 导入成功<br/>36、学号 3137 导入成功<br/>37、学号 3138 导入成功<br/>38、学号 3139 导入成功<br/>39、学号 3140 导入成功<br/>40、学号 3141 导入成功<br/>41、学号 3142 导入成功<br/>42、学号 3143 导入成功<br/>43、学号 3144 导入成功<br/>44、学号 3145 导入成功<br/>45、学号 3146 导入成功<br/>46、学号 3147 导入成功<br/>47、学号 3148 导入成功<br/>48、学号 3149 导入成功<br/>49、学号 3150 导入成功<br/>50、学号 3151 导入成功<br/>51、学号 3152 导入成功<br/>52、学号 3153 导入成功<br/>53、学号 3154 导入成功<br/>54、学号 3155 导入成功<br/>55、学号 3156 导入成功<br/>56、学号 3157 导入成功<br/>57、学号 3158 导入成功<br/>58、学号 3310 导入成功<br/>59、学号 3544 导入成功<br/>60、学号 3201 导入成功<br/>61、学号 3202 导入成功<br/>62、学号 3203 导入成功<br/>63、学号 3204 导入成功<br/>64、学号 3205 导入成功<br/>65、学号 3206 导入成功<br/>66、学号 3207 导入成功<br/>67、学号 3208 导入成功<br/>68、学号 3209 导入成功<br/>69、学号 3210 导入成功<br/>70、学号 3211 导入成功<br/>71、学号 3212 导入成功<br/>72、学号 3213 导入成功<br/>73、学号 3214 导入成功<br/>74、学号 3215 导入成功<br/>75、学号 3216 导入成功<br/>76、学号 3217 导入成功<br/>77、学号 3218 导入成功<br/>78、学号 3219 导入成功<br/>79、学号 3220 导入成功<br/>80、学号 3221 导入成功<br/>81、学号 3222 导入成功<br/>82、学号 3223 导入成功<br/>83、学号 3224 导入成功<br/>84、学号 3225 导入成功<br/>85、学号 3226 导入成功<br/>86、学号 3227 导入成功<br/>87、学号 3228 导入成功<br/>88、学号 3229 导入成功<br/>89、学号 3230 导入成功<br/>90、学号 3231 导入成功<br/>91、学号 3232 导入成功<br/>92、学号 3233 导入成功<br/>93、学号 3234 导入成功<br/>94、学号 3235 导入成功<br/>95、学号 3236 导入成功<br/>96、学号 3237 导入成功<br/>97、学号 3238 导入成功<br/>98、学号 3239 导入成功<br/>99、学号 3240 导入成功<br/>100、', 0, NULL, '2026-03-09 20:02:10.118918', 27110);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (290, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1744,1745,1746,1747,1748,1749,1750,1751,1752,1753,1754,1755,1756,1757,1758,1759,1760,1761,1762,1763,1764,1765,1766,1767,1768,1769,1770,1771,1772,1773,1774,1775,1776,1777,1778,1779,1780,1781,1782,1783,1784,1785,1786,1787,1788,1789,1790,1791,1792,1793] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 20:02:29.119521', 612);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (291, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1794,1795,1796,1797,1798,1799,1800,1801,1802,1803,1804,1805,1806,1807,1808,1809,1810,1811,1812,1813,1814,1815,1816,1817,1818,1819,1820,1821,1822,1823,1824,1825,1826,1827,1828,1829,1830,1831,1832,1833,1834,1835,1836,1837,1838,1839,1840,1841,1842,1843] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 20:02:32.745402', 562);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (292, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1844,1845,1846,1847,1848,1849,1850,1851,1852,1853,1854,1855,1856,1857,1858,1859,1860,1861,1862,1863,1864,1865,1866,1867,1868,1869,1870,1871,1872,1873,1874,1875,1876,1877,1878,1879,1880,1881,1882,1883,1884,1885,1886,1887,1888,1889,1890,1891,1892,1893] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 20:02:36.531998', 562);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (293, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1894,1895,1896,1897,1898,1899,1900,1901,1902,1903,1904,1905,1906,1907,1908,1909,1910,1911,1912,1913,1914,1915,1916,1917,1918,1919,1920,1921,1922,1923,1924,1925,1926,1927,1928,1929,1930,1931,1932,1933,1934,1935,1936,1937,1938,1939,1940,1941,1942,1943] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 20:02:41.746231', 567);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (294, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1944,1945,1946,1947,1948,1949,1950,1951,1952,1953,1954,1955,1956,1957,1958,1959,1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993] ', '{"msg":"成功删除 50 名学生","code":200}', 0, NULL, '2026-03-09 20:02:45.275423', 643);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (295, '学生管理', 3, 'com.ruoyi.web.controller.course.StudentController.removeBatch()', 'POST', 1, 'admin', '研发部门', '/course/student/batchRemove', '127.0.0.1', '内网IP', '[1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033] ', '{"msg":"成功删除 40 名学生","code":200}', 0, NULL, '2026-03-09 20:02:48.506508', 447);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (296, '学生管理', 6, 'com.ruoyi.web.controller.course.StudentController.importData()', 'POST', 1, 'admin', '研发部门', '/course/student/importData', '127.0.0.1', '内网IP', '', '{"msg":"导入成功！共 290 条<br/>1、学号 3101 导入成功<br/>2、学号 3102 导入成功<br/>3、学号 3103 导入成功<br/>4、学号 3104 导入成功<br/>5、学号 3105 导入成功<br/>6、学号 3107 导入成功<br/>7、学号 3108 导入成功<br/>8、学号 3109 导入成功<br/>9、学号 3110 导入成功<br/>10、学号 3111 导入成功<br/>11、学号 3112 导入成功<br/>12、学号 3113 导入成功<br/>13、学号 3114 导入成功<br/>14、学号 3115 导入成功<br/>15、学号 3116 导入成功<br/>16、学号 3117 导入成功<br/>17、学号 3118 导入成功<br/>18、学号 3119 导入成功<br/>19、学号 3120 导入成功<br/>20、学号 3121 导入成功<br/>21、学号 3122 导入成功<br/>22、学号 3123 导入成功<br/>23、学号 3124 导入成功<br/>24、学号 3125 导入成功<br/>25、学号 3126 导入成功<br/>26、学号 3127 导入成功<br/>27、学号 3128 导入成功<br/>28、学号 3129 导入成功<br/>29、学号 3130 导入成功<br/>30、学号 3131 导入成功<br/>31、学号 3132 导入成功<br/>32、学号 3133 导入成功<br/>33、学号 3134 导入成功<br/>34、学号 3135 导入成功<br/>35、学号 3136 导入成功<br/>36、学号 3137 导入成功<br/>37、学号 3138 导入成功<br/>38、学号 3139 导入成功<br/>39、学号 3140 导入成功<br/>40、学号 3141 导入成功<br/>41、学号 3142 导入成功<br/>42、学号 3143 导入成功<br/>43、学号 3144 导入成功<br/>44、学号 3145 导入成功<br/>45、学号 3146 导入成功<br/>46、学号 3147 导入成功<br/>47、学号 3148 导入成功<br/>48、学号 3149 导入成功<br/>49、学号 3150 导入成功<br/>50、学号 3151 导入成功<br/>51、学号 3152 导入成功<br/>52、学号 3153 导入成功<br/>53、学号 3154 导入成功<br/>54、学号 3155 导入成功<br/>55、学号 3156 导入成功<br/>56、学号 3157 导入成功<br/>57、学号 3158 导入成功<br/>58、学号 3310 导入成功<br/>59、学号 3544 导入成功<br/>60、学号 3201 导入成功<br/>61、学号 3202 导入成功<br/>62、学号 3203 导入成功<br/>63、学号 3204 导入成功<br/>64、学号 3205 导入成功<br/>65、学号 3206 导入成功<br/>66、学号 3207 导入成功<br/>67、学号 3208 导入成功<br/>68、学号 3209 导入成功<br/>69、学号 3210 导入成功<br/>70、学号 3211 导入成功<br/>71、学号 3212 导入成功<br/>72、学号 3213 导入成功<br/>73、学号 3214 导入成功<br/>74、学号 3215 导入成功<br/>75、学号 3216 导入成功<br/>76、学号 3217 导入成功<br/>77、学号 3218 导入成功<br/>78、学号 3219 导入成功<br/>79、学号 3220 导入成功<br/>80、学号 3221 导入成功<br/>81、学号 3222 导入成功<br/>82、学号 3223 导入成功<br/>83、学号 3224 导入成功<br/>84、学号 3225 导入成功<br/>85、学号 3226 导入成功<br/>86、学号 3227 导入成功<br/>87、学号 3228 导入成功<br/>88、学号 3229 导入成功<br/>89、学号 3230 导入成功<br/>90、学号 3231 导入成功<br/>91、学号 3232 导入成功<br/>92、学号 3233 导入成功<br/>93、学号 3234 导入成功<br/>94、学号 3235 导入成功<br/>95、学号 3236 导入成功<br/>96、学号 3237 导入成功<br/>97、学号 3238 导入成功<br/>98、学号 3239 导入成功<br/>99、学号 3240 导入成功<br/>100、', 0, NULL, '2026-03-09 20:03:23.36361', 24307);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (297, '重置所有学生密码', 2, 'com.ruoyi.web.controller.course.StudentController.resetAllPwd()', 'POST', 1, 'admin', '研发部门', '/course/student/resetAllPwd', '127.0.0.1', '内网IP', '', '{"msg":"操作成功，共重置 290 位学生的密码为123456","code":200}', 0, NULL, '2026-03-09 20:04:16.461268', 714);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (298, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3102', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"220"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 20:04:51.21857', 55);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (299, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3102', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"176"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 20:04:58.389476', 40);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (300, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3102', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"186"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 20:05:04.470398', 38);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (301, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3102', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"200"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 20:05:07.825188', 37);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (302, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3102', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"213"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 20:05:10.103182', 39);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (303, '选课', 1, 'com.ruoyi.web.controller.course.SelectionController.submitSelection()', 'POST', 1, '3102', NULL, '/course/selection/submit', '127.0.0.1', '内网IP', '{"semesterId":"1"}', '{"msg":"选课成功","code":200}', 0, NULL, '2026-03-09 20:05:12.668254', 55);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (304, '退课', 3, 'com.ruoyi.web.controller.course.SelectionController.dropCourse()', 'POST', 1, '3102', NULL, '/course/selection/drop/7', '127.0.0.1', '内网IP', '7 ', '{"msg":"操作成功","code":200,"data":{"msg":"退课成功，其余课程已放回选课车，请补选后提交","cart":{2:{"assigned":false,"classId":1,"className":"1班","courseId":176,"courseName":"数学提升营","semesterId":1,"teacherName":"夏瑞","weekDay":2},3:{"assigned":false,"classId":1,"className":"1班","courseId":186,"courseName":"写作指导与训练","semesterId":1,"teacherName":"张淑琼","weekDay":3},4:{"assigned":false,"classId":1,"className":"1班","courseId":200,"courseName":"民歌赏析","semesterId":1,"teacherName":"胡庆梅","weekDay":4},5:{"assigned":false,"classId":1,"className":"1班","courseId":213,"courseName":"化学实验课堂","semesterId":1,"teacherName":"王开金","weekDay":5}}}}', 0, NULL, '2026-03-09 20:05:22.285314', 66);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (305, '选课车', 1, 'com.ruoyi.web.controller.course.SelectionController.addToCart()', 'POST', 1, '3102', NULL, '/course/selection/cart/add', '127.0.0.1', '内网IP', '{"semesterId":"1","courseId":"220"}', '{"msg":"已加入选课车","code":200}', 0, NULL, '2026-03-09 20:05:27.407637', 32);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (308, '课程管理', 9, 'com.ruoyi.web.controller.course.CourseController.initSelectionData()', 'POST', 1, 'admin', '研发部门', '/course/course/initSelectionData', '127.0.0.1', '内网IP', '{"semesterId":"1"}', '{"msg":"初始化成功，已清空 12 条选课记录","code":200}', 0, NULL, '2026-03-09 20:06:20.217579', 21);
INSERT INTO public.sys_oper_log (oper_id, title, business_type, method, request_method, operator_type, oper_name, dept_name, oper_url, oper_ip, oper_location, oper_param, json_result, status, error_msg, oper_time, cost_time) VALUES (307, '课程管理', 5, 'com.ruoyi.web.controller.course.CourseController.exportSelectedStudents()', 'POST', 1, 'admin', '研发部门', '/course/course/220/exportSelectedStudents', '127.0.0.1', '内网IP', '220 ', NULL, 0, NULL, '2026-03-09 20:05:51.805347', 333);


--
-- Data for Name: sys_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-03-06 14:47:11.215917', '', NULL, '');
INSERT INTO public.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-03-06 14:47:11.216488', '', NULL, '');
INSERT INTO public.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-03-06 14:47:11.216961', '', NULL, '');
INSERT INTO public.sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark) VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-03-06 14:47:11.217383', '', NULL, '');


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:11.224429', '', NULL, '超级管理员');
INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:11.224943', '', NULL, '普通角色');
INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (100, '教务管理员', 'course_admin', 3, '1', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:31.686982', '', NULL, '选修课教务管理');
INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (101, '教师', 'teacher', 4, '1', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:31.687737', '', NULL, '选修课教师');
INSERT INTO public.sys_role (role_id, role_name, role_key, role_sort, data_scope, menu_check_strictly, dept_check_strictly, status, del_flag, create_by, create_time, update_by, update_time, remark) VALUES (102, '学生', 'student', 5, '1', 1, 1, '0', '0', 'admin', '2026-03-06 14:47:31.688225', '', NULL, '选课学生');


--
-- Data for Name: sys_role_dept; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_role_dept (role_id, dept_id) VALUES (2, 100);
INSERT INTO public.sys_role_dept (role_id, dept_id) VALUES (2, 101);
INSERT INTO public.sys_role_dept (role_id, dept_id) VALUES (2, 105);


--
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
-- Data for Name: sys_semester; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_semester (id, semester_name, start_date, end_date, is_current, del_flag, create_by, create_time, update_by, update_time, selection_start_time, selection_end_time) VALUES (1, '2026年春季学期', '2026-03-04', '2026-07-14', 1, '0', NULL, '2026-03-06 10:31:31.902038', 'admin', '2026-03-08 00:10:43.814245', '2026-03-08 00:00:00', '2026-03-10 00:00:00');
INSERT INTO public.sys_semester (id, semester_name, start_date, end_date, is_current, del_flag, create_by, create_time, update_by, update_time, selection_start_time, selection_end_time) VALUES (2, '2026年秋季学期', NULL, NULL, 0, '2', 'admin', '2026-03-08 20:50:31.979649', NULL, NULL, NULL, NULL);


--
-- Data for Name: sys_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (1021, 103, 'teacher_2026年春季学期', '2026年春季学期', '02', '', '', '0', '', '$2a$10$/vLR3VjSJbztD8InbhIjourBegg1ehhR5WOkqqXUs37HiG1YeiimS', '0', '0', '', NULL, NULL, 'admin', '2026-03-09 15:55:24.0769', '', NULL, NULL);
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
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2182, NULL, '3101', '曹子珺', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.193814', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-09 19:51:19.947', '2026-03-06 14:47:11.208678', 'admin', '2026-03-06 14:47:11.208678', '', NULL, '管理员');
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2184, NULL, '3103', '陈宇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.373874', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2185, NULL, '3104', '陈梓榆', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.489361', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2186, NULL, '3105', '崔天雄', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.575301', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2187, NULL, '3107', '单敬骁', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.651729', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2188, NULL, '3108', '道泽鑫', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.734304', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2189, NULL, '3109', '段富敏', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.820746', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2190, NULL, '3110', '范秋菊', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.901788', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2191, NULL, '3111', '冯吉铜', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.985877', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2192, NULL, '3112', '桂浩云', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.071459', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2193, NULL, '3113', '郭书衔', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.160581', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2194, NULL, '3114', '黄毅', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.259937', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2195, NULL, '3115', '姜林遇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.348586', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2196, NULL, '3116', '蒋克松', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.438071', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2197, NULL, '3117', '康竞丹', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.522234', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2198, NULL, '3118', '孔维和', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.615288', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2199, NULL, '3119', '李炳涵', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.697172', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2200, NULL, '3120', '李昊阳', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.772743', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2201, NULL, '3121', '李瑞欣', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.858423', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2202, NULL, '3122', '李星谊', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:00.93782', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2203, NULL, '3123', '李予曦', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.016437', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2204, NULL, '3124', '李昱圻', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.112565', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2205, NULL, '3125', '李元淼', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.198703', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2206, NULL, '3126', '聂馨', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.285326', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2207, NULL, '3127', '钱浩然', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.368921', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2208, NULL, '3128', '邱程瑞', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.447511', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2209, NULL, '3129', '束世晨', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.533018', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2210, NULL, '3130', '宋紫萌', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.611017', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2211, NULL, '3131', '孙瑞', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.702685', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2212, NULL, '3132', '孙懿轩', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.786524', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2213, NULL, '3133', '汤雅菡', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.882506', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2214, NULL, '3134', '王传博', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:01.962827', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2215, NULL, '3135', '王锦', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.041639', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2216, NULL, '3136', '王入希', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.134427', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2217, NULL, '3137', '王瑞1', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.215454', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2218, NULL, '3138', '王烨', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.300905', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2219, NULL, '3139', '韦泓印', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.386901', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2220, NULL, '3140', '吴锦奇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.470961', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2221, NULL, '3141', '谢文峰', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.552408', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2222, NULL, '3142', '许雅琼', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.636752', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2223, NULL, '3143', '姚宛妤', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.716867', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2224, NULL, '3144', '易文博', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.798628', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2225, NULL, '3145', '殷祥凌', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.878043', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2226, NULL, '3146', '尹若洢', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:02.96144', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2227, NULL, '3147', '余热', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.053374', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2228, NULL, '3148', '余欣', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.133467', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2229, NULL, '3149', '张高冉', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.213648', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2230, NULL, '3150', '张官雯', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.299481', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2231, NULL, '3151', '赵德忠', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.390123', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2232, NULL, '3152', '郑硕', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.476929', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2233, NULL, '3153', '郑阳', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.565806', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2234, NULL, '3154', '周情缘', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.651215', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2235, NULL, '3155', '周思彤', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.735536', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2236, NULL, '3156', '朱硕', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.823145', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2237, NULL, '3157', '庄程凯', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.909618', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2238, NULL, '3158', '龙锦潇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:03.992821', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2239, NULL, '3310', '代姝琰', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.077269', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2240, NULL, '3544', '赵泳新', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.156213', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2241, NULL, '3201', '高馨雅', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.238914', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2242, NULL, '3202', '金泓', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.326733', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2243, NULL, '3203', '邹明耀', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.410027', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2244, NULL, '3204', '尹其参', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.496075', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2245, NULL, '3205', '朱友倩', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.58022', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2246, NULL, '3206', '石砚清', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.665958', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2247, NULL, '3207', '周靖凯', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.744733', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2248, NULL, '3208', '陈熙涵', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.827291', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2249, NULL, '3209', '刘语萱', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.911425', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2250, NULL, '3210', '张倩瑜', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:04.987582', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2251, NULL, '3211', '韩铭锐', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.063728', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2252, NULL, '3212', '刘家榛', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.166991', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2253, NULL, '3213', '母译心', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.262906', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2254, NULL, '3214', '陈梦瑶', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.346005', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2255, NULL, '3215', '刘馨', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.434292', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2256, NULL, '3216', '邱国睿', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.517567', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2257, NULL, '3217', '王启航', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.608133', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2258, NULL, '3218', '锁帆', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.709147', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2259, NULL, '3219', '肖泽旭', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.794844', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2260, NULL, '3220', '余双文', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.880245', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2261, NULL, '3221', '曹满莲', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:05.962149', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2262, NULL, '3222', '戴桠楠', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.050367', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2263, NULL, '3223', '陈勋坤', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.135367', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2264, NULL, '3224', '李若菡', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.220296', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2265, NULL, '3225', '李卓恒', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.313503', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2266, NULL, '3226', '徐春媛', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.399498', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2267, NULL, '3227', '杨皓钦', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.48455', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2268, NULL, '3228', '顾洪谨', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.598602', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2269, NULL, '3229', '王开睿', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.694258', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2270, NULL, '3230', '熊梓君', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.779328', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2271, NULL, '3231', '杨琳坚', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.861796', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2272, NULL, '3232', '朱啟萌', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:06.94178', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2273, NULL, '3233', '康恒', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.022079', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2274, NULL, '3234', '颜成坤', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.117326', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2275, NULL, '3235', '杨立', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.206381', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2276, NULL, '3236', '陈屿珊', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.284645', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2277, NULL, '3237', '李品兑', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.360138', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2278, NULL, '3238', '钟翛然', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.433174', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2279, NULL, '3239', '何鑫', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.508418', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2280, NULL, '3240', '邹学琼', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.581898', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2281, NULL, '3241', '赵万源', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.6601', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2282, NULL, '3242', '解天治', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.750157', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2283, NULL, '3243', '施江楠', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.825946', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2284, NULL, '3244', '康泰然', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.899021', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2285, NULL, '3245', '陈彦臣', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:07.974632', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2286, NULL, '3246', '田泓彦', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.049104', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2287, NULL, '3247', '陈达昊', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.1276', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2288, NULL, '3248', '丁俊宇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.200529', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2289, NULL, '3249', '黄诗语', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.276896', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2290, NULL, '3250', '吕玭稀', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.347417', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2291, NULL, '3251', '毛千予', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.424051', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2292, NULL, '3252', '彭熙倬', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.502029', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2293, NULL, '3253', '宋弥南', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.579349', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2294, NULL, '3254', '肖馨雅', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.66067', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2295, NULL, '3255', '杨斯淇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.744921', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2296, NULL, '3256', '赵钒壹', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.821278', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2297, NULL, '3257', '吕欣', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.896329', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2298, NULL, '3258', '沈梦烯', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:08.972336', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2299, NULL, '3259', '苏钰涵', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.046771', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2300, NULL, '3262', '贾莉雅', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.121351', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2301, NULL, '3106', '戴龙鑫', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.196598', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2302, NULL, '3301', '毕广涛', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.270697', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2303, NULL, '3302', '毕泽云', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.344103', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2304, NULL, '3303', '蔡雨润', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.417836', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2305, NULL, '3304', '陈吉星', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.496596', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2306, NULL, '3305', '陈禹霏', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.569082', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2307, NULL, '3306', '崔梦涵', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.644388', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2308, NULL, '3307', '代冯之', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.717469', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2309, NULL, '3308', '代龙珠', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.797671', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2310, NULL, '3311', '杜城', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.872512', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2311, NULL, '3312', '高华地', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:09.949597', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2312, NULL, '3313', '耿德成', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.02666', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2313, NULL, '3314', '芶子优', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.100451', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2314, NULL, '3315', '桂钎浩', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.176959', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2315, NULL, '3316', '胡静', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.251876', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2316, NULL, '3317', '姜山', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.328045', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2317, NULL, '3318', '李冬雨', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.400814', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2318, NULL, '3319', '李佳', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.480876', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2319, NULL, '3320', '李军蓉', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.56049', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2320, NULL, '3321', '李泊锋', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.645606', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2321, NULL, '3322', '李茹玉', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.724654', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2322, NULL, '3323', '李思源', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.800493', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2323, NULL, '3324', '李兴峰', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.877763', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2324, NULL, '3325', '李媛红', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:10.950539', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2325, NULL, '3326', '李泽楷', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.030348', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2326, NULL, '3327', '刘祺', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.113099', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2327, NULL, '3328', '罗春夕', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.193982', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2328, NULL, '3329', '罗廷孟', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.268889', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2329, NULL, '3330', '马欣然', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.346965', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2330, NULL, '3331', '孟守懿', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.422164', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2331, NULL, '3332', '浦雅迪', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.499925', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2332, NULL, '3333', '沈瑞捷', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.577685', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2333, NULL, '3334', '汤紫涵', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.656437', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2334, NULL, '3335', '唐伟', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.741121', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2335, NULL, '3336', '王茂语', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.829325', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2336, NULL, '3337', '王天越', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:11.924481', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2337, NULL, '3338', '王文垲', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.011287', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2338, NULL, '3339', '王曦婷', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.100422', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2339, NULL, '3340', '王艺诺', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.185011', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2340, NULL, '3341', '王子瑞', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.268249', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2341, NULL, '3342', '王梓欣', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.35627', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2342, NULL, '3343', '肖弼开', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.442289', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2343, NULL, '3344', '严宁康杰', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.521157', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2344, NULL, '3345', '晏合娇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.602505', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2345, NULL, '3346', '杨民旭', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.68138', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2346, NULL, '3347', '杨舒然', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.762956', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2347, NULL, '3348', '杨雅婕', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.849651', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2348, NULL, '3349', '袁铱蔚', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:12.934869', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2349, NULL, '3350', '岳昊', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.016258', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2350, NULL, '3351', '张佳丽', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.10424', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2351, NULL, '3352', '张旭尧', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.18476', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2352, NULL, '3353', '赵国尧', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.264021', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2353, NULL, '3354', '赵婧彤', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.34794', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2354, NULL, '3355', '朱恩泱', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.426645', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2355, NULL, '3356', '朱祉亦', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.504958', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2356, NULL, '3357', '徐磊', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.582978', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2357, NULL, '3508', '代冯兮', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.666892', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2358, NULL, '3401', '安塞玲', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.747761', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2359, NULL, '3402', '包崇锦', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.838015', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2360, NULL, '3404', '陈红志', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.918648', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2361, NULL, '3405', '陈梦圆', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:13.998551', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2362, NULL, '3406', '陈顺达', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.093071', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2363, NULL, '3407', '陈漪潼', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.172026', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2364, NULL, '3408', '褚秋奕', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.258075', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2365, NULL, '3409', '丁俊衔', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.340843', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2366, NULL, '3410', '付文智', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.420927', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2367, NULL, '3411', '高金阔', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.506356', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2368, NULL, '3412', '桂藤菁', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.587315', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2369, NULL, '3413', '何雨润', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.669087', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2370, NULL, '3414', '胡光秋', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.752428', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2371, NULL, '3415', '胡涵杰', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.834935', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2372, NULL, '3416', '华力莹', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:14.918957', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2373, NULL, '3417', '黄礼芯', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.004339', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2374, NULL, '3418', '黄曼淇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.088674', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2375, NULL, '3419', '陈邦仙', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.168644', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2376, NULL, '3420', '李帛燃', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.25581', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2377, NULL, '3421', '李冬成', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.337968', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2378, NULL, '3422', '李文平', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.416533', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2379, NULL, '3423', '林思琦', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.506661', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2380, NULL, '3424', '刘承烨', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.58733', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2381, NULL, '3425', '刘吉昊', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.670633', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2382, NULL, '3426', '刘蕾', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.756202', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2383, NULL, '3427', '刘思绫', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.838777', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2384, NULL, '3428', '卢禹兴', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:15.920705', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2385, NULL, '3429', '吕贤宇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.003315', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2386, NULL, '3430', '孟福曦', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.083362', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2387, NULL, '3431', '缪应琼', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.16525', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2388, NULL, '3432', '裴浩翔', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.253692', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2389, NULL, '3433', '彭莹', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.336657', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2390, NULL, '3434', '邱琪茸', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.417025', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2391, NULL, '3435', '阮欣颖', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.498997', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2392, NULL, '3436', '舒彦', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.582013', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2393, NULL, '3437', '孙颢铭', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.664005', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2394, NULL, '3438', '田宇欣', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.745967', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2395, NULL, '3439', '王君瑞', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.832589', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2183, NULL, '3102', '陈玟憙', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '127.0.0.1', '2026-03-09 20:04:38.283', '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:02:59.287512', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2396, NULL, '3440', '王瑞4', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:16.92711', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2397, NULL, '3441', '王思博', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.018776', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2398, NULL, '3442', '王梓诚', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.101246', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2399, NULL, '3443', '吴君彩', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.183137', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2400, NULL, '3444', '吴青阳', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.273108', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2401, NULL, '3445', '徐浩瑀', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.359191', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2402, NULL, '3446', '徐祥盛', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.460411', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2403, NULL, '3447', '严宁康博', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.54531', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2404, NULL, '3448', '余其洋', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.627898', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2405, NULL, '3449', '袁萌', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.704979', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2406, NULL, '3450', '张厚林', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.78667', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2407, NULL, '3451', '黄滢睿', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.869143', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2408, NULL, '3452', '张钰滢', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:17.94739', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2409, NULL, '3453', '郑成柯', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.02917', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2410, NULL, '3454', '周子珺', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.110795', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2411, NULL, '3455', '周祖宇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.192487', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2412, NULL, '3456', '朱思颖', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.27575', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2413, NULL, '3457', '朱雨潼', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.356085', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2414, NULL, '3309', '代荣泽', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.436576', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2415, NULL, '3501', '曾繁通', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.519089', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2416, NULL, '3502', '曾玺蓉', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.602478', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2417, NULL, '3503', '陈本佳', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.682937', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2418, NULL, '3504', '陈柯函', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.764607', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2419, NULL, '3505', '陈森', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.845395', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2420, NULL, '3506', '陈铱涵', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:18.936043', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2421, NULL, '3507', '崔汝霞', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.02687', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2422, NULL, '3509', '戴大辉', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.109319', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2423, NULL, '3510', '党颖瑶', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.203827', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2424, NULL, '3511', '杜钰滢', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.285318', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2425, NULL, '3512', '高健铭', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.365361', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2426, NULL, '3513', '何进', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.472145', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2427, NULL, '3514', '胡济鲲', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.580131', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2428, NULL, '3515', '胡宇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.667083', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2429, NULL, '3516', '黄海航', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.752587', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2430, NULL, '3517', '金源峰', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.836854', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2431, NULL, '3518', '孔文玉', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.919473', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2432, NULL, '3519', '李泽宸', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:19.996313', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2433, NULL, '3520', '林玟君', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.074345', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2434, NULL, '3521', '凌俊杰', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.155159', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2435, NULL, '3522', '刘思圻', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.236211', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2436, NULL, '3523', '刘思谣', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.323688', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2437, NULL, '3524', '罗冰杰', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.41694', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2438, NULL, '3525', '马想云', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.509276', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2439, NULL, '3526', '宁静', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.612595', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2440, NULL, '3527', '宁思萌', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.702035', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2441, NULL, '3528', '谭庆本', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.796536', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2442, NULL, '3529', '唐铭望', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.879504', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2443, NULL, '3530', '王春洋', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:20.962334', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2444, NULL, '3531', '王玘萌', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.042183', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2445, NULL, '3532', '王蓉', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.129361', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2446, NULL, '3533', '王圣淼', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.207802', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2447, NULL, '3534', '王姝杨', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.283577', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2448, NULL, '3535', '王思涵', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.36371', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2449, NULL, '3536', '温力源', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.448071', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2450, NULL, '3537', '吴加一', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.5289', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2451, NULL, '3538', '吴金凤', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.629899', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2452, NULL, '3539', '肖弼灏', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.71136', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2453, NULL, '3540', '肖含', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.787686', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2454, NULL, '3541', '谢滨羽', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.874943', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2455, NULL, '3542', '徐琳媛', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:21.960569', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2456, NULL, '3543', '鄢晨茜', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.047821', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2457, NULL, '3545', '杨涛', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.148162', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2458, NULL, '3546', '杨兴权', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.236229', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2459, NULL, '3547', '杨焱博', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.315742', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2460, NULL, '3548', '袁子鑫', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.404749', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2461, NULL, '3549', '张丽卓', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.490954', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2462, NULL, '3550', '张洺浥', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.570149', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2463, NULL, '3551', '张仁熙', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.650264', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2464, NULL, '3552', '张天鹏', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.73336', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2465, NULL, '3553', '赵庆灵', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.817467', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2466, NULL, '3554', '郑钰澄', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.89838', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2467, NULL, '3555', '朱航辰', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:22.980643', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2468, NULL, '3556', '朱欣怡', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:23.067433', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2469, NULL, '3557', '邹潇', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:23.156114', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2470, NULL, '3559', '王霄萌', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:23.244251', '', '2026-03-09 20:04:15.722076', NULL);
INSERT INTO public.sys_user (user_id, dept_id, user_name, nick_name, user_type, email, phonenumber, sex, avatar, password, status, del_flag, login_ip, login_date, pwd_update_date, create_by, create_time, update_by, update_time, remark) VALUES (2471, NULL, '3562', '高连杜', '01', '', '', '0', '', '$2a$10$T3XFnXVz0ufKg9v3U8Vy/.Y7f2TpoOO0z5eIJCfAHHV2K3sNfDCYe', '0', '0', '', NULL, '2026-03-09 20:04:15.722076', 'admin', '2026-03-09 20:03:23.333438', '', '2026-03-09 20:04:15.722076', NULL);


--
-- Data for Name: sys_user_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_user_post (user_id, post_id) VALUES (1, 1);
INSERT INTO public.sys_user_post (user_id, post_id) VALUES (2, 2);


--
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
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (1021, 101);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2182, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2183, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2184, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2185, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2186, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2187, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2188, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2189, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2190, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2191, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2192, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2193, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2194, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2195, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2196, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2197, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2198, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2199, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2200, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2201, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2202, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2203, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2204, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2205, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2206, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2207, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2208, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2209, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2210, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2211, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2212, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2213, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2214, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2215, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2216, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2217, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2218, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2219, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2220, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2221, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2222, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2223, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2224, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2225, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2226, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2227, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2228, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2229, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2230, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2231, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2232, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2233, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2234, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2235, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2236, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2237, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2238, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2239, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2240, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2241, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2242, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2243, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2244, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2245, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2246, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2247, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2248, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2249, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2250, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2251, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2252, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2253, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2254, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2255, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2256, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2257, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2258, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2259, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2260, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2261, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2262, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2263, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2264, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2265, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2266, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2267, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2268, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2269, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2270, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2271, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2272, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2273, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2274, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2275, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2276, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2277, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2278, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2279, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2280, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2281, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2282, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2283, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2284, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2285, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2286, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2287, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2288, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2289, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2290, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2291, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2292, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2293, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2294, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2295, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2296, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2297, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2298, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2299, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2300, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2301, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2302, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2303, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2304, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2305, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2306, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2307, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2308, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2309, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2310, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2311, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2312, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2313, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2314, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2315, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2316, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2317, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2318, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2319, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2320, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2321, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2322, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2323, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2324, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2325, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2326, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2327, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2328, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2329, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2330, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2331, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2332, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2333, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2334, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2335, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2336, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2337, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2338, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2339, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2340, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2341, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2342, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2343, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2344, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2345, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2346, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2347, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2348, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2349, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2350, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2351, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2352, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2353, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2354, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2355, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2356, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2357, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2358, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2359, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2360, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2361, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2362, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2363, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2364, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2365, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2366, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2367, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2368, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2369, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2370, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2371, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2372, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2373, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2374, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2375, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2376, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2377, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2378, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2379, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2380, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2381, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2382, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2383, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2384, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2385, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2386, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2387, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2388, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2389, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2390, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2391, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2392, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2393, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2394, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2395, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2396, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2397, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2398, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2399, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2400, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2401, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2402, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2403, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2404, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2405, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2406, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2407, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2408, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2409, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2410, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2411, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2412, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2413, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2414, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2415, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2416, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2417, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2418, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2419, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2420, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2421, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2422, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2423, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2424, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2425, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2426, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2427, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2428, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2429, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2430, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2431, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2432, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2433, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2434, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2435, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2436, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2437, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2438, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2439, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2440, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2441, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2442, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2443, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2444, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2445, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2446, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2447, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2448, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2449, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2450, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2451, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2452, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2453, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2454, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2455, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2456, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2457, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2458, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2459, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2460, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2461, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2462, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2463, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2464, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2465, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2466, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2467, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2468, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2469, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2470, 102);
INSERT INTO public.sys_user_role (user_id, role_id) VALUES (2471, 102);


--
-- Name: cou_class_quota_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cou_class_quota_id_seq', 581, true);


--
-- Name: cou_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cou_course_id_seq', 232, true);


--
-- Name: eva_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eva_question_id_seq', 1, true);


--
-- Name: gen_table_column_column_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gen_table_column_column_id_seq', 1, false);


--
-- Name: gen_table_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gen_table_table_id_seq', 1, false);


--
-- Name: stu_evaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stu_evaluation_id_seq', 1, false);


--
-- Name: stu_selection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stu_selection_id_seq', 12, true);


--
-- Name: stu_student_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stu_student_info_id_seq', 2323, true);


--
-- Name: sys_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_class_id_seq', 16, true);


--
-- Name: sys_config_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_config_config_id_seq', 100, true);


--
-- Name: sys_dept_dept_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_dept_dept_id_seq', 200, true);


--
-- Name: sys_dict_data_dict_code_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_dict_data_dict_code_seq', 110, true);


--
-- Name: sys_dict_type_dict_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_dict_type_dict_id_seq', 103, true);


--
-- Name: sys_grade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_grade_id_seq', 4, true);


--
-- Name: sys_job_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_job_job_id_seq', 100, true);


--
-- Name: sys_job_log_job_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_job_log_job_log_id_seq', 1, false);


--
-- Name: sys_logininfor_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_logininfor_info_id_seq', 132, true);


--
-- Name: sys_menu_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_menu_menu_id_seq', 2000, true);


--
-- Name: sys_notice_notice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_notice_notice_id_seq', 10, true);


--
-- Name: sys_oper_log_oper_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_oper_log_oper_id_seq', 308, true);


--
-- Name: sys_post_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_post_post_id_seq', 1, false);


--
-- Name: sys_role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_role_role_id_seq', 102, true);


--
-- Name: sys_semester_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_semester_id_seq', 2, true);


--
-- Name: sys_user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sys_user_user_id_seq', 2471, true);


--
-- Name: cou_class_quota cou_class_quota_course_id_class_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_class_quota
    ADD CONSTRAINT cou_class_quota_course_id_class_id_key UNIQUE (course_id, class_id);


--
-- Name: cou_class_quota cou_class_quota_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_class_quota
    ADD CONSTRAINT cou_class_quota_pkey PRIMARY KEY (id);


--
-- Name: cou_course cou_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cou_course
    ADD CONSTRAINT cou_course_pkey PRIMARY KEY (id);


--
-- Name: eva_question eva_question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eva_question
    ADD CONSTRAINT eva_question_pkey PRIMARY KEY (id);


--
-- Name: gen_table_column gen_table_column_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_table_column
    ADD CONSTRAINT gen_table_column_pkey PRIMARY KEY (column_id);


--
-- Name: gen_table gen_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gen_table
    ADD CONSTRAINT gen_table_pkey PRIMARY KEY (table_id);


--
-- Name: qrtz_blob_triggers qrtz_blob_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_calendars qrtz_calendars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_calendars
    ADD CONSTRAINT qrtz_calendars_pkey PRIMARY KEY (sched_name, calendar_name);


--
-- Name: qrtz_cron_triggers qrtz_cron_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_fired_triggers qrtz_fired_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_fired_triggers
    ADD CONSTRAINT qrtz_fired_triggers_pkey PRIMARY KEY (sched_name, entry_id);


--
-- Name: qrtz_job_details qrtz_job_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_job_details
    ADD CONSTRAINT qrtz_job_details_pkey PRIMARY KEY (sched_name, job_name, job_group);


--
-- Name: qrtz_locks qrtz_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_locks
    ADD CONSTRAINT qrtz_locks_pkey PRIMARY KEY (sched_name, lock_name);


--
-- Name: qrtz_paused_trigger_grps qrtz_paused_trigger_grps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_paused_trigger_grps
    ADD CONSTRAINT qrtz_paused_trigger_grps_pkey PRIMARY KEY (sched_name, trigger_group);


--
-- Name: qrtz_scheduler_state qrtz_scheduler_state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_scheduler_state
    ADD CONSTRAINT qrtz_scheduler_state_pkey PRIMARY KEY (sched_name, instance_name);


--
-- Name: qrtz_simple_triggers qrtz_simple_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_simprop_triggers qrtz_simprop_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simprop_triggers
    ADD CONSTRAINT qrtz_simprop_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_triggers qrtz_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_pkey PRIMARY KEY (sched_name, trigger_name, trigger_group);


--
-- Name: stu_evaluation stu_evaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_evaluation
    ADD CONSTRAINT stu_evaluation_pkey PRIMARY KEY (id);


--
-- Name: stu_evaluation stu_evaluation_student_id_course_id_question_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_evaluation
    ADD CONSTRAINT stu_evaluation_student_id_course_id_question_id_key UNIQUE (student_id, course_id, question_id);


--
-- Name: stu_selection stu_selection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_selection
    ADD CONSTRAINT stu_selection_pkey PRIMARY KEY (id);


--
-- Name: stu_student_info stu_student_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_student_info
    ADD CONSTRAINT stu_student_info_pkey PRIMARY KEY (id);


--
-- Name: stu_student_info stu_student_info_student_no_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_student_info
    ADD CONSTRAINT stu_student_info_student_no_key UNIQUE (student_no);


--
-- Name: stu_student_info stu_student_info_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stu_student_info
    ADD CONSTRAINT stu_student_info_user_id_key UNIQUE (user_id);


--
-- Name: sys_class sys_class_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_class
    ADD CONSTRAINT sys_class_pkey PRIMARY KEY (id);


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
-- Name: sys_grade sys_grade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_grade
    ADD CONSTRAINT sys_grade_pkey PRIMARY KEY (id);


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
-- Name: sys_logininfor sys_logininfor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_logininfor
    ADD CONSTRAINT sys_logininfor_pkey PRIMARY KEY (info_id);


--
-- Name: sys_menu sys_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_menu
    ADD CONSTRAINT sys_menu_pkey PRIMARY KEY (menu_id);


--
-- Name: sys_notice sys_notice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_notice
    ADD CONSTRAINT sys_notice_pkey PRIMARY KEY (notice_id);


--
-- Name: sys_oper_log sys_oper_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_oper_log
    ADD CONSTRAINT sys_oper_log_pkey PRIMARY KEY (oper_id);


--
-- Name: sys_post sys_post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_post
    ADD CONSTRAINT sys_post_pkey PRIMARY KEY (post_id);


--
-- Name: sys_role_dept sys_role_dept_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_dept
    ADD CONSTRAINT sys_role_dept_pkey PRIMARY KEY (role_id, dept_id);


--
-- Name: sys_role_menu sys_role_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_menu
    ADD CONSTRAINT sys_role_menu_pkey PRIMARY KEY (role_id, menu_id);


--
-- Name: sys_role sys_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sys_role_pkey PRIMARY KEY (role_id);


--
-- Name: sys_semester sys_semester_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_semester
    ADD CONSTRAINT sys_semester_pkey PRIMARY KEY (id);


--
-- Name: sys_user sys_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user
    ADD CONSTRAINT sys_user_pkey PRIMARY KEY (user_id);


--
-- Name: sys_user_post sys_user_post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_post
    ADD CONSTRAINT sys_user_post_pkey PRIMARY KEY (user_id, post_id);


--
-- Name: sys_user_role sys_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_role
    ADD CONSTRAINT sys_user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: idx_sys_logininfor_lt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_logininfor_lt ON public.sys_logininfor USING btree (login_time);


--
-- Name: idx_sys_logininfor_s; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_logininfor_s ON public.sys_logininfor USING btree (status);


--
-- Name: idx_sys_oper_log_bt; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_oper_log_bt ON public.sys_oper_log USING btree (business_type);


--
-- Name: idx_sys_oper_log_ot; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_oper_log_ot ON public.sys_oper_log USING btree (oper_time);


--
-- Name: idx_sys_oper_log_s; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sys_oper_log_s ON public.sys_oper_log USING btree (status);


--
-- Name: stu_selection_unique_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX stu_selection_unique_active ON public.stu_selection USING btree (student_id, semester_id, week_day) WHERE (status = 1);


--
-- Name: qrtz_blob_triggers qrtz_blob_triggers_sched_name_trigger_name_trigger_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_blob_triggers
    ADD CONSTRAINT qrtz_blob_triggers_sched_name_trigger_name_trigger_group_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_cron_triggers qrtz_cron_triggers_sched_name_trigger_name_trigger_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_cron_triggers
    ADD CONSTRAINT qrtz_cron_triggers_sched_name_trigger_name_trigger_group_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_simple_triggers qrtz_simple_triggers_sched_name_trigger_name_trigger_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simple_triggers
    ADD CONSTRAINT qrtz_simple_triggers_sched_name_trigger_name_trigger_group_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_simprop_triggers qrtz_simprop_triggers_sched_name_trigger_name_trigger_grou_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_simprop_triggers
    ADD CONSTRAINT qrtz_simprop_triggers_sched_name_trigger_name_trigger_grou_fkey FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES public.qrtz_triggers(sched_name, trigger_name, trigger_group);


--
-- Name: qrtz_triggers qrtz_triggers_sched_name_job_name_job_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrtz_triggers
    ADD CONSTRAINT qrtz_triggers_sched_name_job_name_job_group_fkey FOREIGN KEY (sched_name, job_name, job_group) REFERENCES public.qrtz_job_details(sched_name, job_name, job_group);


--
-- PostgreSQL database dump complete
--

