--
-- PostgreSQL database dump
-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.2

DROP SCHEMA IF EXISTS is2 CASCADE;
CREATE SCHEMA is2;

DO '
BEGIN
execute ''alter database ''||current_database()||'' set search_path to is2,public;'';
END;
';

SET search_path to is2,public;
SET default_tablespace = '';
SET default_with_oids = false;

CREATE TABLE is2.batch_job_execution (
    job_execution_id bigint NOT NULL,
    version bigint,
    job_instance_id bigint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status character varying(10),
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone,
    job_configuration_location character varying(2500),
    wf_session_id bigint,
    wf_elab_id bigint,
    wf_proc_id bigint
);


CREATE TABLE is2.batch_job_execution_context (
    job_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);

CREATE TABLE is2.batch_job_execution_params (
    job_execution_id bigint NOT NULL,
    type_cd character varying(6) NOT NULL,
    key_name character varying(100) NOT NULL,
    string_val character varying(250),
    date_val timestamp without time zone,
    long_val bigint,
    double_val double precision,
    identifying character(1) NOT NULL
);

CREATE SEQUENCE is2.batch_job_execution_seq
    START WITH 1000000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE is2.batch_job_instance (
    job_instance_id bigint NOT NULL,
    version bigint,
    job_name character varying(100) NOT NULL,
    job_key character varying(32) NOT NULL
);


CREATE SEQUENCE is2.batch_job_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE is2.batch_step_execution (
    step_execution_id bigint NOT NULL,
    version bigint NOT NULL,
    step_name character varying(100) NOT NULL,
    job_execution_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    status character varying(10),
    commit_count bigint,
    read_count bigint,
    filter_count bigint,
    write_count bigint,
    read_skip_count bigint,
    write_skip_count bigint,
    process_skip_count bigint,
    rollback_count bigint,
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone
);

CREATE TABLE is2.batch_step_execution_context (
    step_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);

CREATE SEQUENCE is2.batch_step_execution_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE is2.is2_app_role (
    id integer NOT NULL,
    code character varying(50),
    name character varying(100),
    descr text,
    order_code integer,
    cls_data_type_id integer,
    parameter_id integer,
    hidden character(1)
);

CREATE SEQUENCE is2.is2_app_role_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_app_role_id_seq OWNED BY is2.is2_app_role.id;

CREATE TABLE is2.is2_app_service (
	id serial NOT NULL,
	"name" varchar(100) NULL,
	descr text NULL,
	implementation_language varchar(100) NULL,
	business_service_id int4 NOT NULL,
	author varchar(255) NULL,
	contact varchar(255) NULL,
	engine varchar(255) NULL,
	licence varchar(255) NULL,
	source_path varchar(255) NULL,
	source_code varchar(255) NULL

);

CREATE sequence IF NOT EXISTS  is2.is2_app_service_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_app_service_id_seq OWNED BY is2.is2_app_service.id;

-- GSBPM_PROCESS

CREATE TABLE is2.is2_gsbpm_process (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    active integer,
	order_code integer,
	parent integer
);


CREATE SEQUENCE is2.is2_gsbpm_process_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE is2.is2_gsbpm_process_id_seq OWNED BY is2.is2_gsbpm_process.id;

CREATE TABLE is2.is2_business_function (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    label character varying(50),
    active integer
);

CREATE SEQUENCE is2.is2_business_function_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_business_function_id_seq OWNED BY is2.is2_business_function.id;

CREATE TABLE is2.is2_business_process (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    label character varying(50),
    order_code integer,
    parent integer
);

CREATE SEQUENCE is2.is2_business_process_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_business_process_id_seq OWNED BY is2.is2_business_process.id;

CREATE TABLE is2.is2_business_service (
    id integer NOT NULL,
    name character varying(100),
    descr text,
	GSBPM_PROCESS_ID INTEGER
);

CREATE SEQUENCE is2.is2_business_service_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_business_service_id_seq OWNED BY is2.is2_business_service.id;

CREATE TABLE is2.is2_cls_data_type (
    id integer NOT NULL,
    name character varying(100),
    descr text
);

CREATE SEQUENCE is2.is2_cls_data_type_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_cls_data_type_id_seq OWNED BY is2.is2_cls_data_type.id;

CREATE TABLE is2.is2_cls_rule (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    note text
);

CREATE SEQUENCE is2.is2_cls_rule_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_cls_rule_id_seq OWNED BY is2.is2_cls_rule.id;

CREATE TABLE is2.is2_cls_statistical_variable (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    type integer,
    order_code integer,
    variable_name_ita character varying(500),
    variable_name_eng character varying(500)
);

CREATE SEQUENCE is2.is2_cls_statistical_variable_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_cls_statistical_variable_id_seq OWNED BY is2.is2_cls_statistical_variable.id;

CREATE TABLE is2.is2_cls_type_io (
    id integer NOT NULL,
    name character varying(100)
);

CREATE SEQUENCE is2.is2_cls_type_io_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_cls_type_io_id_seq OWNED BY is2.is2_cls_type_io.id;


CREATE TABLE is2.is2_data_bridge (
    id integer NOT NULL,
    name character varying(50),
    descr character varying(100),
    value character varying(50),
    type character varying(50),
    bridge_name character varying(50)
);


CREATE SEQUENCE is2.is2_data_bridge_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_data_bridge_id_seq OWNED BY is2.is2_data_bridge.id;

CREATE TABLE is2.is2_data_processing (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    last_update timestamp without time zone,
    business_process_id integer NOT NULL,
    work_session_id integer NOT NULL
);


CREATE SEQUENCE is2.is2_data_processing_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_data_processing_id_seq OWNED BY is2.is2_data_processing.id;

CREATE TABLE is2.is2_dataset_column (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    order_code integer,
    content text,
    content_size integer,
    dataset_file_id integer,
    statistical_variable_id integer
);

CREATE SEQUENCE is2.is2_dataset_column_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_dataset_column_id_seq OWNED BY is2.is2_dataset_column.id;

CREATE TABLE is2.is2_dataset_file (
    id integer NOT NULL,
    file_name character varying(100),
    file_label character varying(50),
    file_format character varying(50),
    field_separator character varying(50),
    total_rows integer,
    last_update timestamp without time zone,
    cls_data_type_id integer,
    work_session_id integer
);

CREATE SEQUENCE is2.is2_dataset_file_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_dataset_file_id_seq OWNED BY is2.is2_dataset_file.id;

CREATE TABLE is2.is2_link_business_service_app_role (
    business_service_id integer NOT NULL,
    app_role_id integer NOT NULL
);

CREATE TABLE is2.is2_link_function_process (
    business_function_id integer NOT NULL,
    business_process_id integer NOT NULL
);

CREATE TABLE is2.is2_link_function_view_data_type (
    business_function_id integer NOT NULL,
    view_data_type_id integer NOT NULL
);

CREATE TABLE is2.is2_link_process_step (
    business_process_id integer NOT NULL,
    process_step_id integer NOT NULL
);

CREATE TABLE is2.is2_link_step_instance (
    process_step_id integer NOT NULL,
    process_step_instance_id integer NOT NULL
);

CREATE TABLE is2.is2_log (
    id integer NOT NULL,
    msg text,
    msg_time timestamp without time zone,
    type character varying(50),
    work_session_id integer NOT NULL
);

CREATE SEQUENCE is2.is2_log_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_log_id_seq OWNED BY is2.is2_log.id;


CREATE TABLE is2.is2_parameter (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    default_val character varying(50),
    json_template text
);

CREATE SEQUENCE is2.is2_parameter_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_parameter_id_seq OWNED BY is2.is2_parameter.id;

CREATE TABLE is2.is2_process_step (
    id integer NOT NULL,
    name character varying(100),
	label text,
    descr text,
    business_service_id integer NOT NULL
);

CREATE SEQUENCE is2.is2_process_step_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_process_step_id_seq OWNED BY is2.is2_process_step.id;

CREATE TABLE is2.is2_rule (
    id integer NOT NULL,
    name character varying(100) DEFAULT NULL::character varying,
    code character varying(50) DEFAULT NULL::character varying,
    descr text,
    blocking integer,
    error_code integer,
    active integer,
    rule text,
    variable_id integer,
    cls_rule_id integer NOT NULL,
    ruleset_id integer NOT NULL
);

CREATE SEQUENCE is2.is2_rule_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_rule_id_seq OWNED BY is2.is2_rule.id;

CREATE TABLE is2.is2_ruleset (
    id integer NOT NULL,
    file_name character varying(100),
    file_label character varying(50),
    descr text,
    rules_total integer,
    last_update timestamp without time zone,
    work_session_id integer NOT NULL,
    dataset_id integer
);

CREATE SEQUENCE is2.is2_ruleset_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_ruleset_id_seq OWNED BY is2.is2_ruleset.id;

CREATE TABLE is2.is2_step_instance (
    id integer NOT NULL,
    method character varying(100),
    descr text,
    label character varying(50),
    app_service_id integer NOT NULL
);

CREATE SEQUENCE is2.is2_step_instance_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_step_instance_id_seq OWNED BY is2.is2_step_instance.id;

CREATE TABLE is2.is2_step_instance_signature (
    id integer NOT NULL,
    required smallint,
    app_role_id integer NOT NULL,
    step_instance_id integer NOT NULL,
    cls_type_io_id integer NOT NULL
);

CREATE SEQUENCE is2.is2_step_instance_signature_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_step_instance_signature_id_seq OWNED BY is2.is2_step_instance_signature.id;

CREATE TABLE is2.is2_step_runtime (
    id integer NOT NULL,
    order_code integer,
    role_group integer,
    data_processing_id integer NOT NULL,
    workset_id integer NOT NULL,
    app_role_id integer NOT NULL,
    cls_data_type_id integer NOT NULL,
    cls_type_io_id integer NOT NULL,
    step_instance_signature_id integer
);

CREATE SEQUENCE is2.is2_step_runtime_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_step_runtime_id_seq OWNED BY is2.is2_step_runtime.id;

CREATE TABLE is2.is2_user_roles (
    id integer NOT NULL,
    role character varying(50) DEFAULT NULL::character varying
);

CREATE SEQUENCE is2.is2_user_roles_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_user_roles_id_seq OWNED BY is2.is2_user_roles.id;

CREATE TABLE is2.is2_users (
    id integer NOT NULL,
    email character varying(255),
    name character varying(100),
    surname character varying(100),
    password character varying(500),
    role_id integer NOT NULL
);

CREATE SEQUENCE is2.is2_users_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_users_id_seq OWNED BY is2.is2_users.id;

CREATE TABLE is2.is2_view_data_type (
    id integer NOT NULL,
    name character varying(50),
    descr text
);

CREATE SEQUENCE is2.is2_view_data_type_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_view_data_type_id_seq OWNED BY is2.is2_view_data_type.id;

CREATE TABLE is2.is2_work_session (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    last_update timestamp without time zone,
    user_id integer NOT NULL,
    business_function_id integer NOT NULL
);

CREATE SEQUENCE is2.is2_work_session_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_work_session_id_seq OWNED BY is2.is2_work_session.id;

CREATE TABLE is2.is2_workflow (
    id integer NOT NULL,
    rule_id integer NOT NULL,
    step integer NOT NULL,
    sub_step integer NOT NULL,
    else_step integer NOT NULL
);

CREATE SEQUENCE is2.is2_workflow_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_workflow_id_seq OWNED BY is2.is2_workflow.id;


CREATE TABLE is2.is2_workset (
    id integer NOT NULL,
    name character varying(100)  NOT NULL,
    order_code integer,
    content text,
    content_size integer,
    value_parameter text,
    cls_data_type_id integer NOT NULL,
    dataset_column integer
);

CREATE SEQUENCE is2.is2_workset_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE is2.is2_workset_id_seq OWNED BY is2.is2_workset.id;
ALTER TABLE ONLY is2.is2_app_role ALTER COLUMN id SET DEFAULT nextval('is2.is2_app_role_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_app_service ALTER COLUMN id SET DEFAULT nextval('is2.is2_app_service_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_business_function ALTER COLUMN id SET DEFAULT nextval('is2.is2_business_function_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_business_process ALTER COLUMN id SET DEFAULT nextval('is2.is2_business_process_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_business_service ALTER COLUMN id SET DEFAULT nextval('is2.is2_business_service_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_cls_data_type ALTER COLUMN id SET DEFAULT nextval('is2.is2_cls_data_type_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_cls_rule ALTER COLUMN id SET DEFAULT nextval('is2.is2_cls_rule_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_cls_statistical_variable ALTER COLUMN id SET DEFAULT nextval('is2.is2_cls_statistical_variable_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_cls_type_io ALTER COLUMN id SET DEFAULT nextval('is2.is2_cls_type_io_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_data_bridge ALTER COLUMN id SET DEFAULT nextval('is2.is2_data_bridge_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_data_processing ALTER COLUMN id SET DEFAULT nextval('is2.is2_data_processing_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_dataset_column ALTER COLUMN id SET DEFAULT nextval('is2.is2_dataset_column_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_dataset_file ALTER COLUMN id SET DEFAULT nextval('is2.is2_dataset_file_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_log ALTER COLUMN id SET DEFAULT nextval('is2.is2_log_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_parameter ALTER COLUMN id SET DEFAULT nextval('is2.is2_parameter_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_process_step ALTER COLUMN id SET DEFAULT nextval('is2.is2_process_step_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_rule ALTER COLUMN id SET DEFAULT nextval('is2.is2_rule_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_ruleset ALTER COLUMN id SET DEFAULT nextval('is2.is2_ruleset_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_step_instance ALTER COLUMN id SET DEFAULT nextval('is2.is2_step_instance_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_step_instance_signature ALTER COLUMN id SET DEFAULT nextval('is2.is2_step_instance_signature_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_step_runtime ALTER COLUMN id SET DEFAULT nextval('is2.is2_step_runtime_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_user_roles ALTER COLUMN id SET DEFAULT nextval('is2.is2_user_roles_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_users ALTER COLUMN id SET DEFAULT nextval('is2.is2_users_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_view_data_type ALTER COLUMN id SET DEFAULT nextval('is2.is2_view_data_type_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_work_session ALTER COLUMN id SET DEFAULT nextval('is2.is2_work_session_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_workflow ALTER COLUMN id SET DEFAULT nextval('is2.is2_workflow_id_seq'::regclass);
ALTER TABLE ONLY is2.is2_workset ALTER COLUMN id SET DEFAULT nextval('is2.is2_workset_id_seq'::regclass);

SELECT pg_catalog.setval('is2.batch_job_execution_seq', 1, false);
SELECT pg_catalog.setval('is2.batch_job_seq', 1, false);
SELECT pg_catalog.setval('is2.batch_step_execution_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_app_role_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_app_service_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_business_function_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_business_process_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_business_service_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_cls_data_type_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_cls_rule_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_cls_statistical_variable_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_cls_type_io_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_data_bridge_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_data_processing_id_seq', 5, true);
SELECT pg_catalog.setval('is2.is2_dataset_column_id_seq', 21, true);
SELECT pg_catalog.setval('is2.is2_dataset_file_id_seq', 3, true);
SELECT pg_catalog.setval('is2.is2_log_id_seq', 13, true);
SELECT pg_catalog.setval('is2.is2_parameter_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_process_step_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_rule_id_seq', 2, true);
SELECT pg_catalog.setval('is2.is2_ruleset_id_seq', 3, true);
SELECT pg_catalog.setval('is2.is2_step_instance_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_step_instance_signature_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_step_runtime_id_seq', 16, true);
SELECT pg_catalog.setval('is2.is2_user_roles_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_users_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_view_data_type_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_work_session_id_seq', 5, true);
SELECT pg_catalog.setval('is2.is2_workflow_id_seq', 1, false);
SELECT pg_catalog.setval('is2.is2_workset_id_seq', 16, true);

ALTER TABLE ONLY is2.batch_job_execution_context 
    ADD CONSTRAINT batch_job_execution_context_pkey PRIMARY KEY (job_execution_id);

ALTER TABLE ONLY is2.batch_job_execution
    ADD CONSTRAINT batch_job_execution_pkey PRIMARY KEY (job_execution_id);

ALTER TABLE ONLY is2.batch_job_instance
    ADD CONSTRAINT batch_job_instance_pkey PRIMARY KEY (job_instance_id);

ALTER TABLE ONLY is2.batch_step_execution_context
    ADD CONSTRAINT batch_step_execution_context_pkey PRIMARY KEY (step_execution_id);

ALTER TABLE ONLY is2.batch_step_execution
    ADD CONSTRAINT batch_step_execution_pkey PRIMARY KEY (step_execution_id);

ALTER TABLE ONLY is2.is2_gsbpm_process
    ADD CONSTRAINT is2_gsbpm_process_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_app_role
    ADD CONSTRAINT is2_app_role_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_app_service
    ADD CONSTRAINT is2_app_service_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_business_function
    ADD CONSTRAINT is2_business_function_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_business_process
    ADD CONSTRAINT is2_business_process_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_business_service
    ADD CONSTRAINT is2_business_service_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_cls_data_type
    ADD CONSTRAINT is2_cls_data_type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_cls_rule
    ADD CONSTRAINT is2_cls_rule_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_cls_statistical_variable
    ADD CONSTRAINT is2_cls_statistical_variable_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_cls_type_io
    ADD CONSTRAINT is2_cls_type_io_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_data_bridge
    ADD CONSTRAINT is2_data_bridge_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_data_processing
    ADD CONSTRAINT is2_data_processing_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_dataset_column
    ADD CONSTRAINT is2_dataset_column_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_dataset_file
    ADD CONSTRAINT is2_dataset_file_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_link_business_service_app_role
    ADD CONSTRAINT is2_link_business_service_app_role_pkey PRIMARY KEY (business_service_id, app_role_id);


ALTER TABLE ONLY is2.is2_link_function_process
    ADD CONSTRAINT is2_link_function_process_pkey PRIMARY KEY (business_function_id, business_process_id);


ALTER TABLE ONLY is2.is2_link_function_view_data_type
    ADD CONSTRAINT is2_link_function_view_data_type_pkey PRIMARY KEY (business_function_id, view_data_type_id);

ALTER TABLE ONLY is2.is2_link_process_step
    ADD CONSTRAINT is2_link_process_step_pkey PRIMARY KEY (business_process_id, process_step_id);

ALTER TABLE ONLY is2.is2_link_step_instance
    ADD CONSTRAINT is2_link_step_instance_pkey PRIMARY KEY (process_step_id, process_step_instance_id);


ALTER TABLE ONLY is2.is2_log
    ADD CONSTRAINT is2_log_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_parameter
    ADD CONSTRAINT is2_parameter_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_process_step
    ADD CONSTRAINT is2_process_step_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_rule
    ADD CONSTRAINT is2_rule_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_ruleset
    ADD CONSTRAINT is2_ruleset_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_step_instance
    ADD CONSTRAINT is2_step_instance_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_step_instance_signature
    ADD CONSTRAINT is2_step_instance_signature_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT is2_step_runtime_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_user_roles
    ADD CONSTRAINT is2_user_roles_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_users
    ADD CONSTRAINT is2_users_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_view_data_type
    ADD CONSTRAINT is2_view_data_type_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_work_session
    ADD CONSTRAINT is2_work_session_pkey PRIMARY KEY (id);


ALTER TABLE ONLY is2.is2_workflow
    ADD CONSTRAINT is2_workflow_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.is2_workset
    ADD CONSTRAINT is2_workset_pkey PRIMARY KEY (id);

ALTER TABLE ONLY is2.batch_job_instance
    ADD CONSTRAINT job_inst_un UNIQUE (job_name, job_key);

ALTER TABLE ONLY is2.is2_app_role
    ADD CONSTRAINT fk_is2_app_role_is2_data_type FOREIGN KEY (cls_data_type_id) REFERENCES is2.is2_cls_data_type(id);

ALTER TABLE ONLY is2.is2_app_role
    ADD CONSTRAINT fk_is2_app_role_is2_paramter FOREIGN KEY (parameter_id) REFERENCES is2.is2_parameter(id);

ALTER TABLE ONLY is2.is2_app_service
    ADD CONSTRAINT fk_is2_app_service_is2_business_service FOREIGN KEY (business_service_id) REFERENCES is2.is2_business_service(id);

ALTER TABLE ONLY is2.is2_link_function_process
    ADD CONSTRAINT fk_is2_bfunc_bprocess_is2_business_function FOREIGN KEY (business_function_id) REFERENCES is2.is2_business_function(id);

ALTER TABLE ONLY is2.is2_link_function_process
    ADD CONSTRAINT fk_is2_bfunc_bprocess_is2_business_process FOREIGN KEY (business_process_id) REFERENCES is2.is2_business_process(id);

ALTER TABLE ONLY is2.is2_link_process_step
    ADD CONSTRAINT fk_is2_bprocess_bstep_is2_business_process FOREIGN KEY (business_process_id) REFERENCES is2.is2_business_process(id);

ALTER TABLE ONLY is2.is2_link_process_step
    ADD CONSTRAINT fk_is2_bprocess_bstep_is2_process_step FOREIGN KEY (process_step_id) REFERENCES is2.is2_process_step(id);

ALTER TABLE ONLY is2.is2_business_process
    ADD CONSTRAINT fk_is2_business_process_is2_business_process FOREIGN KEY (parent) REFERENCES is2.is2_business_process(id);

ALTER TABLE ONLY is2.is2_link_business_service_app_role
    ADD CONSTRAINT fk_is2_business_service_app_role_app_role FOREIGN KEY (app_role_id) REFERENCES is2.is2_app_role(id);

ALTER TABLE ONLY is2.is2_link_business_service_app_role
    ADD CONSTRAINT fk_is2_business_service_app_role_business_service FOREIGN KEY (business_service_id) REFERENCES is2.is2_business_service(id);

ALTER TABLE ONLY is2.is2_data_processing
    ADD CONSTRAINT fk_is2_data_processing_business_process FOREIGN KEY (business_process_id) REFERENCES is2.is2_business_process(id);

ALTER TABLE ONLY is2.is2_data_processing
    ADD CONSTRAINT fk_is2_data_processing_worksession FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);

ALTER TABLE ONLY is2.is2_dataset_file
    ADD CONSTRAINT fk_is2_datakset_file_data_type FOREIGN KEY (cls_data_type_id) REFERENCES is2.is2_cls_data_type(id);

ALTER TABLE ONLY is2.is2_dataset_file
    ADD CONSTRAINT fk_is2_datakset_file_worksession FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);

ALTER TABLE ONLY is2.is2_dataset_column
    ADD CONSTRAINT fk_is2_dataset_column_dataset_id FOREIGN KEY (dataset_file_id) REFERENCES is2.is2_dataset_file(id);

ALTER TABLE ONLY is2.is2_dataset_column
    ADD CONSTRAINT fk_is2_dataset_column_statistical_variable FOREIGN KEY (statistical_variable_id) REFERENCES is2.is2_cls_statistical_variable(id);

ALTER TABLE ONLY is2.is2_log
    ADD CONSTRAINT fk_is2_log_worksession FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);

ALTER TABLE ONLY is2.is2_process_step
    ADD CONSTRAINT fk_is2_process_step_business_service FOREIGN KEY (business_service_id) REFERENCES is2.is2_business_service(id);

ALTER TABLE ONLY is2.is2_step_instance
    ADD CONSTRAINT fk_is2_step_instance_is2_app_service FOREIGN KEY (app_service_id) REFERENCES is2.is2_app_service(id);

ALTER TABLE ONLY is2.is2_link_step_instance
    ADD CONSTRAINT fk_is2_step_instance_process_step FOREIGN KEY (process_step_id) REFERENCES is2.is2_process_step(id);

ALTER TABLE ONLY is2.is2_step_instance_signature
    ADD CONSTRAINT fk_is2_step_instance_signature_is2_app_role FOREIGN KEY (app_role_id) REFERENCES is2.is2_app_role(id);

ALTER TABLE ONLY is2.is2_step_instance_signature
    ADD CONSTRAINT fk_is2_step_instance_signature_is2_step_instance FOREIGN KEY (step_instance_id) REFERENCES is2.is2_step_instance(id);

ALTER TABLE ONLY is2.is2_step_instance_signature
    ADD CONSTRAINT fk_is2_step_instance_signature_is2_type_io FOREIGN KEY (cls_type_io_id) REFERENCES is2.is2_cls_type_io(id);

ALTER TABLE ONLY is2.is2_link_step_instance
    ADD CONSTRAINT fk_is2_step_instance_step_instance FOREIGN KEY (process_step_instance_id) REFERENCES is2.is2_step_instance(id);

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_app_role FOREIGN KEY (app_role_id) REFERENCES is2.is2_app_role(id);

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_data_processing FOREIGN KEY (data_processing_id) REFERENCES is2.is2_data_processing(id);

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_data_type FOREIGN KEY (cls_data_type_id) REFERENCES is2.is2_cls_data_type(id);

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_signature FOREIGN KEY (step_instance_signature_id) REFERENCES is2.is2_step_instance_signature(id);

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_type_io FOREIGN KEY (cls_type_io_id) REFERENCES is2.is2_cls_type_io(id);

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_workset FOREIGN KEY (workset_id) REFERENCES is2.is2_workset(id);

ALTER TABLE ONLY is2.is2_users
    ADD CONSTRAINT fk_is2_users_is2_user_roles FOREIGN KEY (role_id) REFERENCES is2.is2_user_roles(id);

ALTER TABLE ONLY is2.is2_link_function_view_data_type
    ADD CONSTRAINT fk_is2_view_data_type_is2_business_function FOREIGN KEY (business_function_id) REFERENCES is2.is2_business_function(id);


ALTER TABLE ONLY is2.is2_link_function_view_data_type
    ADD CONSTRAINT fk_is2_view_data_type_is2_view_data_type FOREIGN KEY (view_data_type_id) REFERENCES is2.is2_view_data_type(id);

ALTER TABLE ONLY is2.is2_work_session
    ADD CONSTRAINT fk_is2_worksession_business_function FOREIGN KEY (business_function_id) REFERENCES is2.is2_business_function(id);

ALTER TABLE ONLY is2.is2_work_session
    ADD CONSTRAINT fk_is2_worksession_user FOREIGN KEY (user_id) REFERENCES is2.is2_users(id);

ALTER TABLE ONLY is2.is2_workset
    ADD CONSTRAINT fk_is2_workset_data_type FOREIGN KEY (cls_data_type_id) REFERENCES is2.is2_cls_data_type(id);

ALTER TABLE ONLY is2.is2_rule
    ADD CONSTRAINT fk_rule_cls_rule FOREIGN KEY (cls_rule_id) REFERENCES is2.is2_cls_rule(id);

ALTER TABLE ONLY is2.is2_rule
    ADD CONSTRAINT fk_rule_ruleset FOREIGN KEY (ruleset_id) REFERENCES is2.is2_ruleset(id);

ALTER TABLE ONLY is2.is2_ruleset
    ADD CONSTRAINT fk_ruleset_dataset FOREIGN KEY (dataset_id) REFERENCES is2.is2_dataset_file(id);

ALTER TABLE ONLY is2.is2_ruleset
    ADD CONSTRAINT fk_ruleset_work_session FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);

ALTER TABLE ONLY is2.is2_log
    ADD CONSTRAINT is2_log_work_session_id_fkey FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);

ALTER TABLE ONLY is2.is2_workflow
    ADD CONSTRAINT is2_workflow_else_step_fkey FOREIGN KEY (else_step) REFERENCES is2.is2_process_step(id);

ALTER TABLE ONLY is2.is2_workflow
    ADD CONSTRAINT is2_workflow_step_fkey FOREIGN KEY (step) REFERENCES is2.is2_process_step(id);

ALTER TABLE ONLY is2.is2_workflow
    ADD CONSTRAINT is2_workflow_sub_step_fkey FOREIGN KEY (sub_step) REFERENCES is2.is2_process_step(id);

ALTER TABLE ONLY is2.batch_job_execution_context
    ADD CONSTRAINT job_exec_ctx_fk FOREIGN KEY (job_execution_id) REFERENCES is2.batch_job_execution(job_execution_id);

ALTER TABLE ONLY is2.batch_job_execution_params
    ADD CONSTRAINT job_exec_params_fk FOREIGN KEY (job_execution_id) REFERENCES is2.batch_job_execution(job_execution_id);

ALTER TABLE ONLY is2.batch_step_execution
    ADD CONSTRAINT job_exec_step_fk FOREIGN KEY (job_execution_id) REFERENCES is2.batch_job_execution(job_execution_id);

ALTER TABLE ONLY is2.batch_job_execution
    ADD CONSTRAINT job_inst_exec_fk FOREIGN KEY (job_instance_id) REFERENCES is2.batch_job_instance(job_instance_id);

    ALTER TABLE ONLY is2.batch_step_execution_context
    ADD CONSTRAINT step_exec_ctx_fk FOREIGN KEY (step_execution_id) REFERENCES is2.batch_step_execution(step_execution_id);


-- Completed on 2020-01-14 10:16:34
