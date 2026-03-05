-- Quartz 调度表 PostgreSQL 版本
DROP TABLE IF EXISTS QRTZ_FIRED_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_PAUSED_TRIGGER_GRPS;
DROP TABLE IF EXISTS QRTZ_SCHEDULER_STATE;
DROP TABLE IF EXISTS QRTZ_LOCKS;
DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_SIMPROP_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_CRON_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_BLOB_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_JOB_DETAILS;
DROP TABLE IF EXISTS QRTZ_CALENDARS;

-- 1、存储每一个已配置的 jobDetail 的详细信息
CREATE TABLE QRTZ_JOB_DETAILS (
    sched_name           VARCHAR(120) NOT NULL,
    job_name             VARCHAR(200) NOT NULL,
    job_group            VARCHAR(200) NOT NULL,
    description          VARCHAR(250) NULL,
    job_class_name       VARCHAR(250) NOT NULL,
    is_durable           VARCHAR(1) NOT NULL,
    is_nonconcurrent     VARCHAR(1) NOT NULL,
    is_update_data       VARCHAR(1) NOT NULL,
    requests_recovery    VARCHAR(1) NOT NULL,
    job_data             BYTEA NULL,
    PRIMARY KEY (sched_name, job_name, job_group)
);

-- 2、存储已配置的 Trigger 的信息
CREATE TABLE QRTZ_TRIGGERS (
    sched_name           VARCHAR(120) NOT NULL,
    trigger_name         VARCHAR(200) NOT NULL,
    trigger_group        VARCHAR(200) NOT NULL,
    job_name             VARCHAR(200) NOT NULL,
    job_group            VARCHAR(200) NOT NULL,
    description          VARCHAR(250) NULL,
    next_fire_time       BIGINT NULL,
    prev_fire_time       BIGINT NULL,
    priority             INTEGER NULL,
    trigger_state        VARCHAR(16) NOT NULL,
    trigger_type         VARCHAR(8) NOT NULL,
    start_time           BIGINT NOT NULL,
    end_time             BIGINT NULL,
    calendar_name        VARCHAR(200) NULL,
    misfire_instr        SMALLINT NULL,
    job_data             BYTEA NULL,
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    FOREIGN KEY (sched_name, job_name, job_group) REFERENCES QRTZ_JOB_DETAILS(sched_name, job_name, job_group)
);

-- 3、存储简单的 Trigger
CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
    sched_name           VARCHAR(120) NOT NULL,
    trigger_name         VARCHAR(200) NOT NULL,
    trigger_group        VARCHAR(200) NOT NULL,
    repeat_count         BIGINT NOT NULL,
    repeat_interval      BIGINT NOT NULL,
    times_triggered      BIGINT NOT NULL,
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES QRTZ_TRIGGERS(sched_name, trigger_name, trigger_group)
);

-- 4、存储 Cron Trigger
CREATE TABLE QRTZ_CRON_TRIGGERS (
    sched_name           VARCHAR(120) NOT NULL,
    trigger_name         VARCHAR(200) NOT NULL,
    trigger_group        VARCHAR(200) NOT NULL,
    cron_expression      VARCHAR(200) NOT NULL,
    time_zone_id         VARCHAR(80),
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES QRTZ_TRIGGERS(sched_name, trigger_name, trigger_group)
);

-- 5、Blob 类型 Trigger
CREATE TABLE QRTZ_BLOB_TRIGGERS (
    sched_name           VARCHAR(120) NOT NULL,
    trigger_name         VARCHAR(200) NOT NULL,
    trigger_group        VARCHAR(200) NOT NULL,
    blob_data            BYTEA NULL,
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES QRTZ_TRIGGERS(sched_name, trigger_name, trigger_group)
);

-- 6、日历信息表
CREATE TABLE QRTZ_CALENDARS (
    sched_name           VARCHAR(120) NOT NULL,
    calendar_name        VARCHAR(200) NOT NULL,
    calendar             BYTEA NOT NULL,
    PRIMARY KEY (sched_name, calendar_name)
);

-- 7、已暂停的 Trigger 组
CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
    sched_name           VARCHAR(120) NOT NULL,
    trigger_group        VARCHAR(200) NOT NULL,
    PRIMARY KEY (sched_name, trigger_group)
);

-- 8、已触发的 Trigger 状态信息
CREATE TABLE QRTZ_FIRED_TRIGGERS (
    sched_name           VARCHAR(120) NOT NULL,
    entry_id             VARCHAR(95) NOT NULL,
    trigger_name         VARCHAR(200) NOT NULL,
    trigger_group        VARCHAR(200) NOT NULL,
    instance_name        VARCHAR(200) NOT NULL,
    fired_time           BIGINT NOT NULL,
    sched_time           BIGINT NOT NULL,
    priority             INTEGER NOT NULL,
    state                VARCHAR(16) NOT NULL,
    job_name             VARCHAR(200) NULL,
    job_group            VARCHAR(200) NULL,
    is_nonconcurrent     VARCHAR(1) NULL,
    requests_recovery    VARCHAR(1) NULL,
    PRIMARY KEY (sched_name, entry_id)
);

-- 9、调度器状态表
CREATE TABLE QRTZ_SCHEDULER_STATE (
    sched_name           VARCHAR(120) NOT NULL,
    instance_name        VARCHAR(200) NOT NULL,
    last_checkin_time    BIGINT NOT NULL,
    checkin_interval     BIGINT NOT NULL,
    PRIMARY KEY (sched_name, instance_name)
);

-- 10、悲观锁信息表
CREATE TABLE QRTZ_LOCKS (
    sched_name           VARCHAR(120) NOT NULL,
    lock_name            VARCHAR(40) NOT NULL,
    PRIMARY KEY (sched_name, lock_name)
);

-- 11、同步机制行锁表
CREATE TABLE QRTZ_SIMPROP_TRIGGERS (
    sched_name           VARCHAR(120) NOT NULL,
    trigger_name         VARCHAR(200) NOT NULL,
    trigger_group        VARCHAR(200) NOT NULL,
    str_prop_1           VARCHAR(512) NULL,
    str_prop_2           VARCHAR(512) NULL,
    str_prop_3           VARCHAR(512) NULL,
    int_prop_1           INTEGER NULL,
    int_prop_2           INTEGER NULL,
    long_prop_1          BIGINT NULL,
    long_prop_2          BIGINT NULL,
    dec_prop_1           NUMERIC(13,4) NULL,
    dec_prop_2           NUMERIC(13,4) NULL,
    bool_prop_1          VARCHAR(1) NULL,
    bool_prop_2          VARCHAR(1) NULL,
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES QRTZ_TRIGGERS(sched_name, trigger_name, trigger_group)
);
