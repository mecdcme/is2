-- server side utf8. Windows compatibility
update pg_database set encoding = pg_char_to_encoding('UTF8');

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


--
-- TOC entry 4915 (class 0 OID 25182)
-- Dependencies: 236
-- Data for Name: is2_cls_data_type; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_data_type VALUES (1, 'VARIABLE', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (2, 'PARAMETER', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (3, 'DATASET', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (4, 'RULESET', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (5, 'RULE', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (6, 'MODEL', NULL);


--
-- TOC entry 4917 (class 0 OID 25190)
-- Dependencies: 238
-- Data for Name: is2_cls_rule; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_rule VALUES (1, 'Dominio', 'Definisce i valori o le modalità ammissibili della variabile', 'Può comprendere missing e/o zero; distinguere tra variabile qualitativa e quantitativa');
INSERT INTO is2.is2_cls_rule VALUES (2, 'Coerenza logica', 'Definisce le combinazioni ammissibili di valori e/o modalità tra due o più variabili ', 'Prevalentemente per  variabli qualitative, anche se la regola può riguardare entrambe le tipologie di variabili (es. ETA(0-15) STACIV(coniugato) con ETA fissa)');
INSERT INTO is2.is2_cls_rule VALUES (3, 'Quadratura', 'Definisce l''uguaglianza ammissibile tra la somma di due o più variabili quantitative e il totale corrispondente (che può essere noto a priori o a sua volta ottenuto dalla somma di altre variabili del dataset)', 'Solo variabili quantitative');
INSERT INTO is2.is2_cls_rule VALUES (4, 'Disuguaglianza forma semplice', 'Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due variabili quantitative', 'Solo variabili quantitative');
INSERT INTO is2.is2_cls_rule VALUES (5, 'Disuguaglianza forma composta', 'Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due quantità, dove ciascuna quantità può essere costituita da una sola variabile X o dalla somma/differenza/prodotto tra due o più variabili X', 'Solo variabili quantitative');
INSERT INTO is2.is2_cls_rule VALUES (6, 'Validazione/Completezza', 'Verifica in base alle regole di compilazione del questionario che i dati siano stati immessi correttamente', 'Distinguere tra variabile qualitativa e quantitativa');
INSERT INTO is2.is2_cls_rule VALUES (7, 'Editing', NULL, 'Valore di default al caricamento del file');


--
-- TOC entry 4919 (class 0 OID 25198)
-- Dependencies: 240
-- Data for Name: is2_cls_statistical_variable; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_statistical_variable VALUES (1, NULL, 'Variabili identificative delle unità', 8, 1, 'VARIABILI IDENTIFICATIVE DELLE UNITÀ', 'UNIT INDENTIFIER');
INSERT INTO is2.is2_cls_statistical_variable VALUES (2, NULL, 'Variabili statistiche di classificazione', 1, 2, 'VARIABILI STATISTICHE DI CLASSIFICAZIONE', 'CLASSIFICATION');
INSERT INTO is2.is2_cls_statistical_variable VALUES (3, NULL, 'Variabili statistiche numeriche', 2, 3, 'VARIABILI STATISTICHE NUMERICHE', 'NUMERIC');
INSERT INTO is2.is2_cls_statistical_variable VALUES (4, NULL, 'Variabili statistiche testuali', 3, 4, 'VARIABILI STATISTICHE TESTUALI', 'TEXTUAL/OPENED');
INSERT INTO is2.is2_cls_statistical_variable VALUES (5, NULL, 'Concetti relativi al contenuto dei dati', 6, 5, 'AGGREGATO', 'AGGREGATE');
INSERT INTO is2.is2_cls_statistical_variable VALUES (6, NULL, 'Concetti di tipo operativo', 4, 6, 'CONCETTI DI TIPO OPERATIVO', 'OPERATIONAL');
INSERT INTO is2.is2_cls_statistical_variable VALUES (7, NULL, 'Concetti di tipo temporale', 5, 7, 'CONCETTI DI TIPO TEMPORALE', 'TEMPORAL');
INSERT INTO is2.is2_cls_statistical_variable VALUES (8, NULL, 'Concetti relativi alla frequenza', 7, 8, 'CONCETTI RELATIVI ALLA FREQUENZA', 'FREQUENCY');
INSERT INTO is2.is2_cls_statistical_variable VALUES (9, NULL, 'Concetti usati per identificare il peso campionario', 10, 9, 'PESO', 'PESO');
INSERT INTO is2.is2_cls_statistical_variable VALUES (10, NULL, 'Paradati ..', 12, 10, 'PARADATO', 'PARADATA');
INSERT INTO is2.is2_cls_statistical_variable VALUES (11, NULL, 'Variabili statistiche composte', 11, 11, 'CONCETTI IDENTIFICATIVI DEL DATASET', 'DATASET IDENTIFIER');
INSERT INTO is2.is2_cls_statistical_variable VALUES (12, NULL, 'Variabili non definite', 9, 12, 'NON DEFINITA', 'UNDEFINED');


--
-- TOC entry 4921 (class 0 OID 25206)
-- Dependencies: 242
-- Data for Name: is2_cls_type_io; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_type_io VALUES (1, 'INPUT');
INSERT INTO is2.is2_cls_type_io VALUES (2, 'OUTPUT');
INSERT INTO is2.is2_cls_type_io VALUES (3, 'INPUT_OUTPUT');




-- 
-- GSBPM_PROCESS
-- 
INSERT INTO is2.is2_gsbpm_process (ID, NAME, PARENT, ORDER_CODE, ACTIVE) 
	VALUES 
		(1,'Specify needs',NULL,1,0),
		(2,'Design',NULL,2,1),
		(3,'Build',NULL,3,1),
		(4,'Collect',NULL,4,1),
		(5,'Process',NULL,5,1),
		(6,'Analyse',NULL,6,1),
		(7,'Disseminate',NULL,7,1),
		(8,'Evaluate',NULL,8,0),
		(11,'1.1 Identify needs',1,1,0),
		(12,'1.2 Consult and confirm needs',1,2,0),
		(13,'1.3 Establish output objectives',1,3,0),
		(14,'1.4 Identify concepts',1,4,0),
		(15,'1.5 Check data availability',1,5,0),
		(16,'1.6 Prepare and submit business case',1,6,0),
		(21,'2.1 Design outputs',2,1,1),
		(22,'2.2 Design variable descriptions',2,2,1),
		(23,'2.3 Design collection',2,3,1),
		(24,'2.4 Design frame & sample',2,4,1),
		(25,'2.5 Design processing & analysis',2,5,1),
		(26,'2.6 Design production systems & workflow',2,6,1),
		(31,'3.1 Reuse or build collection instruments',3,1,1),
		(32,'3.2 Reuse or build processing and analysis components',3,2,1),
		(33,'3.3 Reuse or build dissemination components',3,3,1),
		(34,'3.4 Configure workflows',3,4,1),
		(35,'3.5 Test production system',3,5,1),
		(36,'3.6 Test statistical business process',3,6,1),
		(37,'3.7 Finalise production system',3,7,1),
		(41,'4.1 Create frame and select sample',4,1,1),
		(42,'4.2 Set up collection',4,2,1),
		(43,'4.3 Run collection',4,3,1),
		(44,'4.4 Finalize collection',4,4,1),
		(51,'5.1 Integrate data',5,1,1),
		(52,'5.2 Classify & code',5,2,1),
		(53,'5.3 Review & validate',5,3,1),
		(54,'5.4 Edit & impute',5,4,1),
		(55,'5.5 Derive new variables & units',5,5,1),
		(56,'5.6 Calculate weights',5,6,1),
		(57,'5.7 Calculate aggregates',5,7,1),
		(58,'5.8 Finalise data files',5,8,1),
		(61,'6.1 Prepare draft outputs',6,1,1),
		(62,'6.2 Validate outputs',6,2,1),
		(63,'6.3 Interpret & explain outputs',6,3,1),
		(64,'6.4 Apply disclosure control',6,4,1),
		(65,'6.5 Finalise outputs',6,5,1),
		(71,'7.1 Update output systems',7,1,1),
		(72,'7.2 Produce dissemination products',7,2,1),
		(73,'7.3 Manage release of dissemination products',7,3,1),
		(74,'7.4 Promote dissemination products',7,4,1),
		(75,'7.5 Manage user support',7,5,1),
		(81,'8.1 Update output systems',8,1,0),
		(82,'8.2 Produce dissemination products',8,2,0),
		(83,'8.3 Manage release of dissemination products',8,3,0);
        

-- TOC entry 4952 (class 0 OID 25312)
-- Dependencies: 273
-- Data for Name: is2_user_roles; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_user_roles VALUES (1, 'ROLE_ADMIN');
INSERT INTO is2.is2_user_roles VALUES (2, 'ROLE_USER');


--
-- TOC entry 4954 (class 0 OID 25318)
-- Dependencies: 275
-- Data for Name: is2_users; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_users VALUES (1, 'admin@is2.it', 'Administrator', 'Workbench', '$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC', 1);
INSERT INTO is2.is2_users VALUES (2, 'user@is2.it', 'User', 'Workbench', '$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82', 2);
INSERT INTO is2.is2_users VALUES (3, 'fra@fra.it', 'Francesco Amato', 'fra', '$2a$10$DIcyvIFwhDkEOT9nBugTleDM73OkZffZUdfmvjMCEXdJr3PZP8Kxm', 1);


--
-- TOC entry 4956 (class 0 OID 25323)
-- Dependencies: 277
-- Data for Name: is2_view_data_type; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_view_data_type VALUES (1, 'DATASET', NULL);
INSERT INTO is2.is2_view_data_type VALUES (2, 'RULESET', NULL);


INSERT INTO is2.is2_business_service VALUES (200, 'Relais', 'Record Linkage at Istat',51);

-- TOC entry 4938 (class 0 OID 25260)
-- Dependencies: 259
-- Data for Name: is2_parameter; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (1, 'MATCHING VARIABLES', 'MATCHING VARIABLES', NULL, '{"data":[],"schema":{"items":{"properties":{"MatchingVariable":{"maxLength":50,"required":true,"title":"MatchingVariable","type":"string"},"MatchingVariableA":{"maxLength":50,"required":true,"title":"MatchingVariableA","type":"string"},"MatchingVariableB":{"maxLength":50,"required":true,"title":"MatchingVariableB","type":"string"},"Method":{"enum":["Equality","Jaro","Dice","JaroWinkler","Levenshtein","3Grams","Soundex","NumericComparison","NumericEuclideanDistance","WindowEquality","Inclusion3Grams","SimHash","Weighed3Grams"],"required":true,"title":"Method"},"Threshold":{"title":"Threshold","type":"number"},"Window":{"title":"Window","type":"integer"}},"type":"object"},"type":"array"},"options":{"type":"table","showActionsColumn":false,"hideAddItemsBtn":true,"items":{"fields":{"Method":{"type":"select","noneLabel":"","removeDefaultNone":false},"MatchingVariableA":{"type":"select","noneLabel":"","dataSource":"matchedVariablesbyRoles.X1"},"MatchingVariableB":{"type":"select","noneLabel":"","dataSource":"matchedVariablesbyRoles.X2"}}},"form":{"buttons":{"addRow":"addRow","removeRow":"removeRow"}},"view":{"templates":{"container-array-toolbar":"#addItemsBtn"}}}}');
INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (2, 'THRESHOLD MATCHING', 'THRESHOLD MATCHING', '1', '{"data":[],"schema":{"name":"THRESHOLD MATCHING","type":"number", "minimum": 0.01,"maximum": 1}}');
INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template)  VALUES (3, 'THRESHOLD UNMATCHING', 'THRESHOLD UNMATCHING', '1', '{"data":[],"schema":{"name":"THRESHOLD UNMATCHING","type":"number", "minimum": 0.01,"maximum": 1}}');

INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (5, 'BLOCKING VARIABLES', 'BLOCKING VARIABLES', NULL, '{"data":[],"schema":{"type":"object", "properties": { "BLOCKING_A": { "type":"array", "title":"BLOCKING A","items": {"type": "string"} }, "BLOCKING_B": { "type":"array", "title":"BLOCKING B" ,"items": {"type": "string"}} }}, "options": {"fields":{"BLOCKING_A":{"type":"array",    "toolbarSticky": true,"items":{"type":"select","noneLabel":"","dataSource":"matchedVariables"}},"BLOCKING_B":{"type":"array",   "toolbarSticky": true, "items":{"type":"select","noneLabel":"","dataSource":"matchedVariables"}}}}}');
INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (20, 'REDUCTION METHOD', 'REDUCTION METHOD', NULL, '{"data":[],"schema":{"type":"object","properties":{"REDUCTION-METHOD":{"type":"string","enum":["CartesianProduct","BlockingVariables","SortedNeighborhood","SimHash"]},"BLOCKING":{"type":"object","hidden":true,"name":"BLOCKING VARIABLES","properties":{"BLOCKING A":{"type":"array","required":false,"title":"BLOCKING A","items":{"type":"string"},"properties":{}},"BLOCKING B":{"type":"array","required":false,"title":"BLOCKING B","items":{"type":"string"},"properties":{}}}},"SORTED NEIGHBORHOOD":{"type":"object","hidden":true,"name":"SORTING VARIABLES","properties":{"SORTING A":{"type":"array","required":false,"title":"SORTING A","items":{"type":"string"},"properties":{}},"SORTING B":{"type":"array","required":false,"title":"SORTING B","items":{"type":"string"},"properties":{}},"WINDOW":{"title":"WINDOW","type":"integer","width":"10"}}},"SIMHASH":{"type":"object","hidden":true,"name":"SHINGLING VARIABLES","properties":{"SHINGLING A":{"type":"array","required":false,"title":"SHINGLING A","items":{"type":"string"},"properties":{}},"SHINGLING B":{"type":"array","required":false,"title":"SHINGLING B","items":{"type":"string"},"properties":{}},"HDTHRESHOLD":{"type":"string","items":{"type":"string"},"required":true},"ROTATIONS":{"type":"string","title":"NUMBER OF ROTATIONS","items":{"type":"string"},"required":true}}}}},"options":{"fields":{"REDUCTION-METHOD":{"type":"select","label":"REDUCTION METHOD","removeDefaultNone":true,"id":"REDUCTION-METHOD","sort":false,"optionLabels":["CROSS PRODUCT","BLOCKING","SORTED NEIGHBORHOOD","SIMHASH"]},"BLOCKING":{"type":"object","fields":{"BLOCKING A":{"label":"BLOCKING A","type":"select","multiple":true,"removeDefaultNone":true,"dataSource":"matchedVariablesbyRoles.X1"},"BLOCKING B":{"label":"BLOCKING B","type":"select","removeDefaultNone":true,"dataSource":"matchedVariablesbyRoles.X2"}}},"SORTED NEIGHBORHOOD":{"type":"object","fields":{"SORTING A":{"label":"SORTING KEY A","type":"select","multiple":true,"removeDefaultNone":true,"dataSource":"matchedVariablesbyRoles.X1"},"SORTING B":{"label":"SORTING KEY B","type":"select","removeDefaultNone":true,"dataSource":"matchedVariablesbyRoles.X2"}}},"SIMHASH":{"type":"object","fields":{"SHINGLING A":{"label":"SHINGLING KEY A","type":"select","multiple":true,"removeDefaultNone":true,"dataSource":"matchedVariablesbyRoles.X1"},"SHINGLING B":{"label":"SHINGLING KEY B","type":"select","removeDefaultNone":true,"dataSource":"matchedVariablesbyRoles.X2"},"HDTHRESHOLD":{"label":"HAMMING DISTANCE THRESHOLD","type":"select","removeDefaultNone":true,"dataSource":["30","35","40","45","50"]},"ROTATIONS":{"label":"NUMBER OF ROTATIONS","type":"select","removeDefaultNone":true,"dataSource":[" 4"," 8","16","32"]}}}}},"postRender":"reduction"}');
INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (21, 'INDEXES MATCHED', 'INDEXES MATCHED', NULL, NULL);

INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template)  VALUES (30, 'P', 'MATCH FREQUENCY IN SEARCH SPACE', NULL, '{"data":[],"schema":{"name":"P","type":"number", "minimum": 0.000001,"maximum": 1}}');

-- TOC entry 4938 (class 0 OID 25260)
-- Dependencies: 259
-- Data for Name: is2_app_role; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (1, 'X', 'MATCHING VARIABLES', 'MATCHING VARAIBLES', 1, 2, 1);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (2, 'X1', 'VARIABLES DATASET A', 'SELECTED VARIABLES IN DATASET A', 2, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (3, 'X2', 'VARIABLES DATASET B', 'SELECTED VARIABLES IN DATASET B', 3, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (4, 'CT', 'CONTINGENCY TABLE', 'CONTINGENCY TABLE', 4, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (5, 'FS', 'MU TABLE', 'MU TABLE', 14, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (6, 'B', 'BLOCKING', 'SLICING DEL DATASET', 7, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (7, 'MT', 'MATCHING TABLE', 'MATCHING TABLE', 8, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (8, 'TH', 'THRESHOLD MATCHING', 'THRESHOLD MATCHING', 9, 2, 2);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (9, 'TU', 'THRESHOLD UNMATCHING', 'THRESHOLD UNMATCHING', 10, 2, 3);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (10, 'PM', 'POSSIBLE MATCHING TABLE', 'POSSIBLE MATCHING TABLE', 11, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (13, 'RA', 'RESIDUAL A', 'RESIDUAL DATASET  A', 12, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (14, 'RB', 'RESIDUAL B', 'RESIDUAL DATASET  B', 13, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (15, 'MD', 'DATA', 'DATA', 1, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (16, 'RS', 'RULESET', 'RULESET', 2, 4, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (17, 'MP', 'MARGINAL PROBABILITIES', 'MARGINAL PROBABILITIES', 17, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (18, 'BA', 'BLOCKING A', 'SLICING DEL DATASET A', 18, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (19, 'BB', 'BLOCKING B', 'SLICING DEL DATASET B', 19, 1, NULL);

INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (20, 'RM', 'REDUCTION METHOD', 'METHOD OF REDUCTION OF THE SEARCH SPACE', 20, 2,20 );

INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID, HIDDEN)  VALUES (21, 'CIT','INDEXES MATCHED', 'INDEX ROWS MATCHED CONTENGENCY TABLE', 21, 1,21,'Y');
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (22, 'MTR', 'MATCHING TABLE REDUCED', 'MATCHING TABLE WITH CONSTRAINT', 22, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (23, 'QI', 'QUALITY INDICATORS', 'QUALITY INDICATORS OF RESULTS', 14, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (24, 'PMR', 'POSSIBLE MATCHING TABLE REDUCED', 'POSSIBLE MATCHING TABLE WITH CONSTRAINT', 22, 1, NULL);

INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (26, 'MPV', 'MARGINALS-VARNAMES', 'MARGINAL PROBABILITIES: VARIABLE NAMES', 26, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (27, 'MPC', 'MARGINALS-COMPARISON', 'MARGINAL PROBABILITIES: VARIABLE NAMES', 27, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (28, 'MPM', 'MARGINALS-MFREQ', 'MARGINAL PROBABILITIES: VARIABLE NAMES', 28, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (29, 'MPU', 'MARGINALS-UFREQ', 'MARGINAL PROBABILITIES: VARIABLE NAMES', 29, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (30, 'P', 'P', 'MATCH FREQUENCY IN SEARCH SPACE', 30, 2, 30);
--
-- TOC entry 4907 (class 0 OID 25150)
-- Dependencies: 228
-- Data for Name: is2_app_service; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2_app_service (ID, NAME, DESCR, IMPLEMENTATION_LANGUAGE, ENGINE,SOURCE_PATH, SOURCE_CODE, AUTHOR, LICENCE,CONTACT,BUSINESS_SERVICE_ID) 
	VALUES  
		(200,'Relais','R package implementing record linkage methods','R','RENJIN','relais/relais.R','','Istat','EUPL1.1','Luca Valentino (luvalent@istat.it)',200),
		(250,'Relais Java','Java package implementing record linkage methods','JAVA','JAVA','it.istat.is2.catalogue.relais.service.RelaisService','','Istat','EUPL1.1','Luca Valentino (luvalent@istat.it)',200);
	
 

--
-- TOC entry 4909 (class 0 OID 25158)
-- Dependencies: 230
-- Data for Name: is2_business_function; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_business_function (ID, NAME, DESCR, LABEL, ACTIVE) VALUES (1, 'Record Linkage', 'The purpose of record linkage is to identify the same real world entity that can be differently represented in data sources, even if unique identifiers are not available or are affected by errors.', 'RL', 1);

--
-- TOC entry 4911 (class 0 OID 25166)
-- Dependencies: 232
-- Data for Name: is2_business_process; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent) VALUES (1, 'Probabilistic Record Linkage', 'Probabilistic Record Linkage', 'PRL', 1, NULL);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (2, 'Deterministic Record Linkage', 'Deterministic Record Linkage', 'DRL', 2, NULL);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (3, 'Probabilistic Record Linkage reading Marginals', 'Probabilistic Record Linkage reading Marginals', 'MAR', 3, NULL);

INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (70, 'Contingency Table', 'Calculate contingency table', 'CrossTable', 1, 1);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (71, 'Fellegi Sunter', 'Fellegi Sunter algorithm', 'FellegiSunter', 2, 1);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (72, 'Matching Table', 'Matching records', 'MatchingTable', 3, 1);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (77, 'Matching constraint', 'Constraint apply on matches', 'MatchingTableReduced', 4, 1);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (78, 'Residuals', 'Create residuals', 'Residuals', 5, 1);

INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (5, 'Probabilistic Record Linkage Batch', 'Probabilistic Record Linkage Batch', 'PRL batch', 1, NULL);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (73, 'PRL batch', 'One process with all workflow steps  ', 'PRL batch', 1, 5);

INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (170, 'Contingency Table', 'Calculate contingency table', 'CrossTable', 1, 2);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (76, 'Deterministic Record Linkage', 'Deterministic Record Linkage', 'DRL', 2, 2);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (178, 'Residuals', 'Create residuals', 'Residuals', 4, 2);

INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (270, 'Contingency Table', 'Calculate contingency table', 'CrossTable', 1, 3);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (271, 'Read Marginals', 'Read Marginals Probabilities', 'FellegiSunter', 2, 3);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (272, 'Matching Table', 'Matching records', 'MatchingTable', 3, 3);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (273, 'Matching constraint', 'Constraint apply on matches', 'MatchingTableReduced', 4, 3);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (274, 'Residuals', 'Create residuals', 'Residuals', 5, 3);


--
-- TOC entry 4931 (class 0 OID 25237)
-- Dependencies: 252
-- Data for Name: is2_link_business_service_app_role; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 1);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 2);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 3);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 4);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 5);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 6);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 7);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 8);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 9);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 10);


INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 13);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 14);

INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 17);

INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 18);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 19);

INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 20);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 21);

INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 22);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 23);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 24);

INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 26);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 27);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 28);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 29);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 30);

--
-- TOC entry 4932 (class 0 OID 25240)
-- Dependencies: 253
-- Data for Name: is2_link_function_process; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_function_process VALUES (1, 1);
INSERT INTO is2.is2_link_function_process VALUES (1, 2);
INSERT INTO is2.is2_link_function_process VALUES (1, 3);
INSERT INTO is2.is2_link_function_process VALUES (1, 5);


--
-- TOC entry 4933 (class 0 OID 25243)
-- Dependencies: 254
-- Data for Name: is2_link_function_view_data_type; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_function_view_data_type VALUES (1, 1);


--
-- TOC entry 4940 (class 0 OID 25268)
-- Dependencies: 261
-- Data for Name: is2_process_step; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_process_step ( id, name, label, descr, business_service_id) VALUES (70, 'Contingency Table', 'CONTINGENCY_TABLE','Calculate contingency table', 200);
INSERT INTO is2.is2_process_step ( id, name, label, descr, business_service_id)  VALUES (71, 'Fellegi Sunter', 'FELLEGI_SUNTER','Fellegi Sunter algorithm', 200);
INSERT INTO is2.is2_process_step ( id, name, label, descr, business_service_id)  VALUES (72, 'Matching Table','MATCHING_TABLE', 'Matching records', 200);
INSERT INTO is2.is2_process_step ( id, name, label, descr, business_service_id)  VALUES (77, 'Matching constraint (optional)', 'MATCHING_TABLE_REDUCED','Constraint apply on matches', 200);
INSERT INTO is2.is2_process_step ( id, name, label, descr, business_service_id)  VALUES (78, 'Residuals (optional)', 'RESIDUALS','Create residuals (not matched)', 200);

INSERT INTO is2.is2_process_step  ( id, name, label, descr, business_service_id) VALUES (76, 'Deterministic Matching Table','DETERMINISTIC_MATCHING_TABLE', 'Deterministic Matching records', 200);

INSERT INTO is2.is2_process_step  ( id, name, label, descr, business_service_id) VALUES (80, 'Read Marginals','FELLEGI_SUNTER', 'Read Marginal probabilities', 200);


--
-- TOC entry 4934 (class 0 OID 25246)
-- Dependencies: 255
-- Data for Name: is2_link_process_step; Type: TABLE DATA; Schema: is2; Owner: -
--


INSERT INTO is2.is2_link_process_step VALUES (70, 70);
INSERT INTO is2.is2_link_process_step VALUES (71, 71);
INSERT INTO is2.is2_link_process_step VALUES (72, 72);
INSERT INTO is2.is2_link_process_step VALUES (77, 77);
INSERT INTO is2.is2_link_process_step VALUES (78, 78);

INSERT INTO is2.is2_link_process_step VALUES (73, 70);
INSERT INTO is2.is2_link_process_step VALUES (73, 71);
INSERT INTO is2.is2_link_process_step VALUES (73, 72);

INSERT INTO is2.is2_link_process_step VALUES (170, 70);
INSERT INTO is2.is2_link_process_step VALUES (76, 76);
INSERT INTO is2.is2_link_process_step VALUES (178, 78);

INSERT INTO is2.is2_link_process_step VALUES (270, 70);
INSERT INTO is2.is2_link_process_step VALUES (271, 80);
INSERT INTO is2.is2_link_process_step VALUES (272, 72);
INSERT INTO is2.is2_link_process_step VALUES (273, 77);
INSERT INTO is2.is2_link_process_step VALUES (274, 78);

--
-- TOC entry 4946 (class 0 OID 25294)
-- Dependencies: 267
-- Data for Name: is2_step_instance; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id) VALUES (11, 'probabilisticContingencyTable', 'This function calculates the contingency Table', 'ContingencyTable', 250);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (12, 'fellegisunter', 'This function implements the Fellegi Sunter algorithm', 'FellegiSunter', 200);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (13, 'probabilisticResultTablesByIndex', 'This function calculates the Matching Table', 'MatchingTable', 250);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (14, 'reducedResultTablesGreedy',  'This function implements the constraint on matches', 'MatchingTableReduced', 250);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (15, 'createResiduals',  'This function calculates Residual Tables', 'Residuals', 250);

-- INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (15, 'contingencyTableBlocking', 'This function calculates the contingency Table with Blocking variable', 'ContingencyTableBlocking', 250);
-- INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (16, 'resultTablesBlocking', 'This function calculates the Matching Table with Blocking variable', 'MatchingTableBlocking', 250);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (20, 'deterministicResultTablesByIndex', 'This function calculates the Matching Table with Deterministic Rule', 'MatchingTable', 250);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (21, 'mufrommarginals', 'This function apply Fellegi Sunter model from read marginal probabilities', 'FellegiSunter', 200);

--
-- TOC entry 4935 (class 0 OID 25249)
-- Dependencies: 256
-- Data for Name: is2_link_step_instance; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_step_instance VALUES (70, 11);
INSERT INTO is2.is2_link_step_instance VALUES (71, 12);
INSERT INTO is2.is2_link_step_instance VALUES (72, 13);
INSERT INTO is2.is2_link_step_instance VALUES (77, 14);
INSERT INTO is2.is2_link_step_instance VALUES (78, 15);


-- INSERT INTO is2.is2_link_step_instance VALUES (73, 15);
-- INSERT INTO is2.is2_link_step_instance VALUES (75, 16);
INSERT INTO is2.is2_link_step_instance VALUES (76, 20);
INSERT INTO is2.is2_link_step_instance VALUES (80, 21);



--
-- TOC entry 4948 (class 0 OID 25302)
-- Dependencies: 269
-- Data for Name: is2_step_instance_signature; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (166, 1, 1, 11, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (154, 1, 2, 11, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (155, 1, 3, 11, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (156, 1, 20, 11, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (161, 0, 7, 11, 2);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (162, 0,21, 11, 2);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (167, 1, 4, 12, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (168, 0, 5, 12, 2);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (169, 1, 2, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (170, 1, 3, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (171, 1, 5, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (175, 1, 21, 13, 1);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (173, 0, 7, 13, 2);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (176, 1, 8, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (177, 1, 9, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (178, 0, 23, 13, 2);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (179, 0, 10, 13, 2);

-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (180, 1, 1, 15, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (181, 1, 2, 15, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (182, 1, 3, 15, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (183, 0, 7, 15, 2);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (184, NULL, 11, 15, 2);

-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (195, 1, 18, 15, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (196, 1, 19, 15, 1);


-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (185, 1, 2, 16, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (186, 1, 3, 16, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (187, 1, 5, 16, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (188, 0, 4, 16, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (189, NULL, 7, 16, 2);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (190, 1, 8, 16, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (191, 1, 9, 16, 1);
 
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (197, 1, 18, 16, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (198, 1, 19, 16, 1);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (194, 0, 17, 12, 2);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (195, 1, 7, 14, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (197, 0, 22, 14, 2);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (205, 1, 10, 14, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (207, 0, 24, 14, 2);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (210, 1, 7, 15, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (211, 0, 22, 15, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (212, 1, 2, 15, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (213, 1, 3, 15, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (214, 0, 13, 15, 2);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (215, 0, 14, 15, 2);

--INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (200, 1, 1, 20, 1);
--INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (201, 1, 2, 20, 1);
--INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (202, 1, 3, 20, 1);
--INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (203, 1, 20, 20, 1);
--INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (204, 1, 7, 20, 2);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (200, 0, 4, 20, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (201, 1, 2, 20, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (202, 1, 3, 20, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (203, 1, 21, 20, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (204, 0, 7, 20, 2);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (220, 1, 4, 21, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (221, 1, 26, 21, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (222, 1, 27, 21, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (223, 1, 28, 21, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (224, 1, 29, 21, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (225, 1, 30, 21, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (226, 0, 5, 21, 2);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (227, 0, 17, 21, 2);


INSERT INTO is2.is2_business_service VALUES (91, 'ARC', 'ARC file loader INSEE',51);

INSERT INTO is2.is2_parameter VALUES (910, 'LOADER PARAMETERS', 'LOADER_PARAMETERS', NULL, '{ "data":[],"schema":{"items":{  "properties":{  "FileType":{  "enum":["xml","clef-valeur","plat" ], "required":true, "title":"Type of file" } ,"Delimiter":{  "maxLength":50, "required":false, "title":"Delimiter", "type":"string" } ,"Format":{  "maxLength":1000000, "required":false, "title":"Format", "type":"string" } ,"Comments":{  "maxLength":1000000, "required":false, "title":"Comments", "type":"string" } }, "type":"object" }, "type":"array" } ,"options":{  "type":"table", "showActionsColumn":true, "hideAddItemsBtn":false, "items":{  "fields":{  "FileType":{  "type":"select", "noneLabel":"", "removeDefaultNone":false } } }, "form":{  "buttons":{  "addRow":"addRow" } }, "view":{  "templates":{  "container-array-toolbar":"#addItemsBtn" } } }}');
INSERT INTO is2.is2_parameter VALUES (930, 'CONTROL PARAMETERS', 'CONTROL_PARAMETERS', NULL, '{ "data":[],"schema":{"items":{  "properties":{  "ControlType":{  "enum":["ALPHANUM","CARDINALITY","SQL","DATE","NUM","REGEXP"], "required":true, "title":"Type of control" } ,"TargetColumnMain":{  "maxLength":1000000, "required":true, "title":"Target column", "type":"string" }, "TargetColumnChild":{  "maxLength":1000000, "required":false, "title":"Target child column", "type":"string" }, "MinValue":{  "maxLength":1000000, "required":true, "title":"Min value", "type":"string" }, "MaxValue":{  "maxLength":1000000, "required":true, "title":"Max value", "type":"string" }, "SQLCheck":{  "maxLength":1000000, "required":false, "title":"SQL check", "type":"string" }, "SQLUpdateBeforeCheck":{  "maxLength":1000000, "required":false, "title":"SQL update before check", "type":"string" } ,"Comments":{  "maxLength":1000000, "required":true, "title":"Comments", "type":"string" } }, "type":"object" }, "type":"array" } ,"options":{  "type":"table", "showActionsColumn":true, "hideAddItemsBtn":false, "items":{  "fields":{  "ControlType":{  "type":"select", "noneLabel":"", "removeDefaultNone":false } } }, "form":{  "buttons":{  "addRow":"addRow" } }, "view":{  "templates":{  "container-array-toolbar":"#addItemsBtn" } } }}');
INSERT INTO is2.is2_parameter VALUES (940, 'FILTER PARAMETERS', 'FILTER_PARAMETERS', NULL, '{ "data":[], "schema":{  "items":{  "properties":{  "sqlExpression":{  "maxLength":50, "required":true, "title":"SQL expression", "type":"string" } ,"Comments":{  "maxLength":1000000, "required":true, "title":"Comments", "type":"string" } }, "type":"object" }, "type":"array" }, "options":{  "type":"table", "showActionsColumn":true, "hideAddItemsBtn":false, "form":{  "buttons":{  "addRow":"addRow" } }, "view":{  "templates":{  "container-array-toolbar":"#addItemsBtn" } } }}');
INSERT INTO is2.is2_parameter VALUES (950, 'MAPPING PARAMETERS', 'MAPPING_PARAMETERS', NULL, '{ "data":[], "schema":{  "items":{  "properties":{  "targetVariableName":{  "maxLength":50, "required":true, "title":"Variable Name", "type":"string" } ,"targetVariableType":{  "enum":["bigint","bigint[]","boolean","date","date[]","float","float[]","interval","text","text[]","timestamp without time zone" ], "required":true, "title":"Variable Type" } ,"sqlExpression":{  "maxLength":100000, "required":true, "title":"SQL expression", "type":"string" } ,"targetTables":{  "maxLength":100000, "required":true, "title":"Target tables", "type":"string" } }, "type":"object" }, "type":"array" }, "options":{  "type":"table", "showActionsColumn":true, "hideAddItemsBtn":false, "items":{  "fields":{  "targetVariableType":{  "type":"select", "noneLabel":"", "removeDefaultNone":false } } }, "form":{  "buttons":{  "addRow":"addRow" } }, "view":{  "templates":{  "container-array-toolbar":"#addItemsBtn" } } }}');



INSERT INTO is2.is2_app_role(ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID) VALUES (910, 'LP', 'LOADER PARAMETERS', 'LOADER PARAMETERS', 910, 2, 910);
INSERT INTO is2.is2_app_role(ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID) VALUES (930, 'CP', 'CONTROL PARAMETERS', 'CONTROL PARAMETERS', 930, 2, 930);
INSERT INTO is2.is2_app_role(ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID) VALUES (940, 'FP', 'FILTER PARAMETERS', 'FILTER PARAMETERS', 940, 2, 940);
INSERT INTO is2.is2_app_role(ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID) VALUES (950, 'MP', 'MAPPING PARAMETERS', 'MAPPING PARAMETERS', 950, 2, 950);

INSERT INTO is2_app_service (ID, NAME, DESCR, IMPLEMENTATION_LANGUAGE, ENGINE,SOURCE_PATH, SOURCE_CODE, AUTHOR, LICENCE,CONTACT,BUSINESS_SERVICE_ID) VALUES (91, 'ARC LOADER', 'Java package implementing ARC loader service', 'JAVA','JAVA', 'it.istat.is2.catalogue.arc.service.LoadService','','','','', 91);
INSERT INTO is2_app_service (ID, NAME, DESCR, IMPLEMENTATION_LANGUAGE, ENGINE,SOURCE_PATH, SOURCE_CODE, AUTHOR, LICENCE,CONTACT,BUSINESS_SERVICE_ID) VALUES (93, 'ARC CONTROL', 'Java package implementing ARC control service', 'JAVA','JAVA', 'it.istat.is2.catalogue.arc.service.ControlService','','','','', 91);
INSERT INTO is2_app_service (ID, NAME, DESCR, IMPLEMENTATION_LANGUAGE, ENGINE,SOURCE_PATH, SOURCE_CODE, AUTHOR, LICENCE,CONTACT,BUSINESS_SERVICE_ID) VALUES (94, 'ARC FILTER', 'Java package implementing ARC filter service', 'JAVA','JAVA', 'it.istat.is2.catalogue.arc.service.FilterService','','','','', 91);
INSERT INTO is2_app_service (ID, NAME, DESCR, IMPLEMENTATION_LANGUAGE, ENGINE,SOURCE_PATH, SOURCE_CODE, AUTHOR, LICENCE,CONTACT,BUSINESS_SERVICE_ID) VALUES (95, 'MAPPING', 'Java package implementing ARC Mapping service', 'JAVA','JAVA', 'it.istat.is2.catalogue.arc.service.MapService','','','','',91);

INSERT INTO is2.is2_business_function VALUES (4, 'ARC', 'File loader workbench', 'ARC', 1);

INSERT INTO is2.is2_business_process VALUES (9, 'FILE LOADER WORKBENCH', 'FILE LOADER WORKBENCH ', 'PARC', 1, NULL);
INSERT INTO is2.is2_business_process VALUES (91, 'LOAD', 'LOAD ', 'PARC-01', 2, 9);
INSERT INTO is2.is2_business_process VALUES (93, 'CONTROL', 'CONTROL ', 'PARC-03', 4, 9);
INSERT INTO is2.is2_business_process VALUES (94, 'FILTER', 'FILTER ', 'PARC-04', 5, 9);
INSERT INTO is2.is2_business_process VALUES (95, 'MAP', 'MAP ', 'PARC-05', 6, 9);

INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 910);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 930);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 940);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 950);


INSERT INTO is2.is2_link_function_process VALUES (4, 9);
INSERT INTO is2.is2_link_function_view_data_type VALUES (4, 1);

INSERT INTO is2.is2_process_step VALUES (91, 'LOAD','LOAD', 'LOAD ', 91);
INSERT INTO is2.is2_process_step VALUES (93, 'CONTROL','CONTROL', 'CONTROL ', 91);
INSERT INTO is2.is2_process_step VALUES (94, 'FILTER','FILTER', 'FILTER ', 91);
INSERT INTO is2.is2_process_step VALUES (95, 'MAP','MAP', 'MAP ', 91);

INSERT INTO is2.is2_step_instance VALUES (91, 'arcLoader', 'Raw file data loader', 'arcLoader', 91);
INSERT INTO is2.is2_step_instance VALUES (93, 'arcControl', 'ARC Control service', 'arcControl', 93);
INSERT INTO is2.is2_step_instance VALUES (94, 'arcFilter', 'ARC Filter service', 'arcFilter', 94);
INSERT INTO is2.is2_step_instance VALUES (95, 'arcMapping', 'ARC Mapping service', 'arcMapping', 95);


INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (910, 1, 910, 91, 1);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (930, 1, 930, 93, 1);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (940, 1, 940, 94, 1);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (950, 1, 950, 95, 1);

do '
declare
nb_dataset int:=10;
nb_mapping_tables int:=10;
start int;
o int:=0;
begin

-- load input
start=91000;

for i in 1..nb_dataset loop
--delete from is2.is2_app_role where id=start+i;
o:=o+1;
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (start+i, ''DS''||i, ''DATASET''||i, ''DATASET''||i||''_INPUT_VARIABLES'', o, 1, NULL);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, start+i);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (start+i, case when i=1 then 1 else 0 end, start+i, 91, 1);
end loop;

-- load output
start=91500;

for i in 1..nb_dataset loop
--delete from is2.is2_app_role where id=start+i;
o:=o+1;
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (start+i, ''LOK''||i, ''DATASET''||i||''_LOAD_OUTPUT'', ''DATASET''||i||''_LOAD_OUTPUT'', o, 1, NULL);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, start+i);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (start+i, 0, start+i, 91, 2);
end loop;

-- control output
start=93000;

for i in 1..nb_dataset loop
--delete from is2.is2_app_role where id=start+i*2-1;
o:=o+1;
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (start+i*2-1, ''COK''||i, ''DATASET''||i||''_CONTROL_ACCEPTED'', ''DATASET''||i||''_CONTROL_ACCEPTED'', o, 1, NULL);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, start+i*2-1);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (start+i*2-1, 0, start+i*2-1, 93, 2);

--delete from is2.is2_app_role where id=start+i*2;
o:=o+1;
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (start+i*2, ''CKO''||i, ''DATASET''||i||''_CONTROL_REJECTED'', ''DATASET''||i||''_CONTROL_REJECTED'', o, 1, NULL);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, start+i*2);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (start+i*2, 0, start+i*2, 93, 2);
end loop;

-- filter output
start=94000;

for i in 1..nb_dataset loop
--delete from is2.is2_app_role where id=start+i*2-1;
o:=o+1;
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (start+i*2-1, ''FOK''||i, ''DATASET''||i||''_FILTER_ACCEPTED'', ''DATASET''||i||''_FILTER_ACCEPTED'', o, 1, NULL);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, start+i*2-1);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (start+i*2-1, 0, start+i*2-1, 94, 2);

--delete from is2.is2_app_role where id=start+i*2;
o:=o+1;
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (start+i*2, ''FKO''||i, ''DATASET''||i||''_FILTER_REJECTED'', ''DATASET''||i||''_FILTER_REJECTED'', o, 1, NULL);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, start+i*2);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (start+i*2, 0, start+i*2, 94, 2);
end loop;


-- mapping output
start=95000;

for i in 1..nb_dataset loop
for j in 1..nb_mapping_tables loop
--delete from is2.is2_app_role where id=start+(i-1)*nb_mapping_tables+j;
o:=o+1;
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (start+(i-1)*nb_mapping_tables+j, ''MOK''||i||''_''||j, ''DATASET''||i||''_MAPPING_TABLE''||j, ''DATASET''||i||''_MAPPING_TABLE''||j, o, 1, NULL);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, start+(i-1)*nb_mapping_tables+j);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (start+(i-1)*nb_mapping_tables+j, 0, start+(i-1)*nb_mapping_tables+j, 95, 2);

end loop;
end loop;

end

';

INSERT INTO is2.is2_link_process_step VALUES (91, 91);
INSERT INTO is2.is2_link_process_step VALUES (93, 93);
INSERT INTO is2.is2_link_process_step VALUES (94, 94);
INSERT INTO is2.is2_link_process_step VALUES (95, 95);

INSERT INTO is2.is2_link_step_instance VALUES (91, 91);
INSERT INTO is2.is2_link_step_instance VALUES (93, 93);
INSERT INTO is2.is2_link_step_instance VALUES (94, 94);
INSERT INTO is2.is2_link_step_instance VALUES (95, 95);



