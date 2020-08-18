--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.2

DROP SCHEMA IF EXISTS is2 CASCADE;
CREATE SCHEMA is2;

DO '
BEGIN
execute ''alter database ''||current_database()||'' set search_path to is2,public;'';
END;
';

set search_path to is2,public;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 217 (class 1259 OID 25106)
-- Name: batch_job_execution; Type: TABLE; Schema: is2; Owner: -
--

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


--
-- TOC entry 218 (class 1259 OID 25112)
-- Name: batch_job_execution_context; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.batch_job_execution_context (
    job_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


--
-- TOC entry 219 (class 1259 OID 25118)
-- Name: batch_job_execution_params; Type: TABLE; Schema: is2; Owner: -
--

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


--
-- TOC entry 220 (class 1259 OID 25121)
-- Name: batch_job_execution_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.batch_job_execution_seq
    START WITH 1000000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 221 (class 1259 OID 25123)
-- Name: batch_job_instance; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.batch_job_instance (
    job_instance_id bigint NOT NULL,
    version bigint,
    job_name character varying(100) NOT NULL,
    job_key character varying(32) NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 25126)
-- Name: batch_job_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.batch_job_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 223 (class 1259 OID 25128)
-- Name: batch_step_execution; Type: TABLE; Schema: is2; Owner: -
--

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


--
-- TOC entry 224 (class 1259 OID 25134)
-- Name: batch_step_execution_context; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.batch_step_execution_context (
    step_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


--
-- TOC entry 225 (class 1259 OID 25140)
-- Name: batch_step_execution_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.batch_step_execution_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 226 (class 1259 OID 25142)
-- Name: is2_app_role; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_app_role (
    id integer NOT NULL,
    code character varying(50),
    name character varying(100),
    descr text,
    order_code integer,
    cls_data_type_id integer,
    parameter_id integer
);


--
-- TOC entry 227 (class 1259 OID 25148)
-- Name: is2_app_role_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_app_role_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 227
-- Name: is2_app_role_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_app_role_id_seq OWNED BY is2.is2_app_role.id;


--
-- TOC entry 228 (class 1259 OID 25150)
-- Name: is2_app_service; Type: TABLE; Schema: is2; Owner: -
--

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


--
-- TOC entry 229 (class 1259 OID 25156)
-- Name: is2_app_service_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE sequence IF NOT EXISTS  is2.is2_app_service_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 229
-- Name: is2_app_service_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_app_service_id_seq OWNED BY is2.is2_app_service.id;


--
-- TOC entry 230 (class 1259 OID 25158)
-- Name: is2_business_function; Type: TABLE; Schema: is2; Owner: -
--

-- 
-- GSBPM_PROCESS
-- 

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



--
-- TOC entry 230 (class 1259 OID 25158)
-- Name: is2_business_function; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_business_function (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    label character varying(50),
    active integer
);


--
-- TOC entry 231 (class 1259 OID 25164)
-- Name: is2_business_function_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_business_function_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 231
-- Name: is2_business_function_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_business_function_id_seq OWNED BY is2.is2_business_function.id;


--
-- TOC entry 232 (class 1259 OID 25166)
-- Name: is2_business_process; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_business_process (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    label character varying(50),
    order_code integer,
    parent integer
);


--
-- TOC entry 233 (class 1259 OID 25172)
-- Name: is2_business_process_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_business_process_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 233
-- Name: is2_business_process_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_business_process_id_seq OWNED BY is2.is2_business_process.id;


--
-- TOC entry 234 (class 1259 OID 25174)
-- Name: is2_business_service; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_business_service (
    id integer NOT NULL,
    name character varying(100),
    descr text,
	GSBPM_PROCESS_ID INTEGER
);


--
-- TOC entry 235 (class 1259 OID 25180)
-- Name: is2_business_service_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_business_service_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 235
-- Name: is2_business_service_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_business_service_id_seq OWNED BY is2.is2_business_service.id;

--
-- TOC entry 236 (class 1259 OID 25182)
-- Name: is2_cls_data_type; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_cls_data_type (
    id integer NOT NULL,
    name character varying(100),
    descr text
);


--
-- TOC entry 237 (class 1259 OID 25188)
-- Name: is2_cls_data_type_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_cls_data_type_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 237
-- Name: is2_cls_data_type_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_cls_data_type_id_seq OWNED BY is2.is2_cls_data_type.id;


--
-- TOC entry 238 (class 1259 OID 25190)
-- Name: is2_cls_rule; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_cls_rule (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    note text
);


--
-- TOC entry 239 (class 1259 OID 25196)
-- Name: is2_cls_rule_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_cls_rule_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 239
-- Name: is2_cls_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_cls_rule_id_seq OWNED BY is2.is2_cls_rule.id;


--
-- TOC entry 240 (class 1259 OID 25198)
-- Name: is2_cls_statistical_variable; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_cls_statistical_variable (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    type integer,
    order_code integer,
    variable_name_ita character varying(500),
    variable_name_eng character varying(500)
);


--
-- TOC entry 241 (class 1259 OID 25204)
-- Name: is2_cls_statistical_variable_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_cls_statistical_variable_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4979 (class 0 OID 0)
-- Dependencies: 241
-- Name: is2_cls_statistical_variable_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_cls_statistical_variable_id_seq OWNED BY is2.is2_cls_statistical_variable.id;


--
-- TOC entry 242 (class 1259 OID 25206)
-- Name: is2_cls_type_io; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_cls_type_io (
    id integer NOT NULL,
    name character varying(100)
);


--
-- TOC entry 243 (class 1259 OID 25209)
-- Name: is2_cls_type_io_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_cls_type_io_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 243
-- Name: is2_cls_type_io_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_cls_type_io_id_seq OWNED BY is2.is2_cls_type_io.id;


--
-- TOC entry 244 (class 1259 OID 25211)
-- Name: is2_data_bridge; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_data_bridge (
    id integer NOT NULL,
    name character varying(50),
    descr character varying(100),
    value character varying(50),
    type character varying(50),
    bridge_name character varying(50)
);


--
-- TOC entry 245 (class 1259 OID 25214)
-- Name: is2_data_bridge_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_data_bridge_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 245
-- Name: is2_data_bridge_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_data_bridge_id_seq OWNED BY is2.is2_data_bridge.id;


--
-- TOC entry 246 (class 1259 OID 25216)
-- Name: is2_data_processing; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_data_processing (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    last_update timestamp without time zone,
    business_process_id integer NOT NULL,
    work_session_id integer NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 25222)
-- Name: is2_data_processing_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_data_processing_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 247
-- Name: is2_data_processing_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_data_processing_id_seq OWNED BY is2.is2_data_processing.id;


--
-- TOC entry 248 (class 1259 OID 25224)
-- Name: is2_dataset_column; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_dataset_column (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    order_code integer,
    content text,
    content_size integer,
    dataset_file_id integer,
    statistical_variable_id integer
);


--
-- TOC entry 249 (class 1259 OID 25230)
-- Name: is2_dataset_column_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_dataset_column_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 249
-- Name: is2_dataset_column_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_dataset_column_id_seq OWNED BY is2.is2_dataset_column.id;


--
-- TOC entry 250 (class 1259 OID 25232)
-- Name: is2_dataset_file; Type: TABLE; Schema: is2; Owner: -
--

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


--
-- TOC entry 251 (class 1259 OID 25235)
-- Name: is2_dataset_file_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_dataset_file_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 251
-- Name: is2_dataset_file_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_dataset_file_id_seq OWNED BY is2.is2_dataset_file.id;


--
-- TOC entry 252 (class 1259 OID 25237)
-- Name: is2_link_business_service_app_role; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_link_business_service_app_role (
    business_service_id integer NOT NULL,
    app_role_id integer NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 25240)
-- Name: is2_link_function_process; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_link_function_process (
    business_function_id integer NOT NULL,
    business_process_id integer NOT NULL
);


--
-- TOC entry 254 (class 1259 OID 25243)
-- Name: is2_link_function_view_data_type; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_link_function_view_data_type (
    business_function_id integer NOT NULL,
    view_data_type_id integer NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 25246)
-- Name: is2_link_process_step; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_link_process_step (
    business_process_id integer NOT NULL,
    process_step_id integer NOT NULL
);


--
-- TOC entry 256 (class 1259 OID 25249)
-- Name: is2_link_step_instance; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_link_step_instance (
    process_step_id integer NOT NULL,
    process_step_instance_id integer NOT NULL
);


--
-- TOC entry 257 (class 1259 OID 25252)
-- Name: is2_log; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_log (
    id integer NOT NULL,
    msg text,
    msg_time timestamp without time zone,
    type character varying(50),
    work_session_id integer NOT NULL
);


--
-- TOC entry 258 (class 1259 OID 25258)
-- Name: is2_log_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_log_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 258
-- Name: is2_log_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_log_id_seq OWNED BY is2.is2_log.id;


--
-- TOC entry 259 (class 1259 OID 25260)
-- Name: is2_parameter; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_parameter (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    default_val character varying(50),
    json_template text
);


--
-- TOC entry 260 (class 1259 OID 25266)
-- Name: is2_parameter_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_parameter_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 260
-- Name: is2_parameter_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_parameter_id_seq OWNED BY is2.is2_parameter.id;


--
-- TOC entry 261 (class 1259 OID 25268)
-- Name: is2_process_step; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_process_step (
    id integer NOT NULL,
    name character varying(100),
	label text,
    descr text,
    business_service_id integer NOT NULL
);


--
-- TOC entry 262 (class 1259 OID 25274)
-- Name: is2_process_step_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_process_step_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 262
-- Name: is2_process_step_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_process_step_id_seq OWNED BY is2.is2_process_step.id;


--
-- TOC entry 263 (class 1259 OID 25276)
-- Name: is2_rule; Type: TABLE; Schema: is2; Owner: -
--

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


--
-- TOC entry 264 (class 1259 OID 25284)
-- Name: is2_rule_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_rule_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 264
-- Name: is2_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_rule_id_seq OWNED BY is2.is2_rule.id;


--
-- TOC entry 265 (class 1259 OID 25286)
-- Name: is2_ruleset; Type: TABLE; Schema: is2; Owner: -
--

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


--
-- TOC entry 266 (class 1259 OID 25292)
-- Name: is2_ruleset_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_ruleset_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 266
-- Name: is2_ruleset_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_ruleset_id_seq OWNED BY is2.is2_ruleset.id;


--
-- TOC entry 267 (class 1259 OID 25294)
-- Name: is2_step_instance; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_step_instance (
    id integer NOT NULL,
    method character varying(100),
    descr text,
    label character varying(50),
    app_service_id integer NOT NULL
);


--
-- TOC entry 268 (class 1259 OID 25300)
-- Name: is2_step_instance_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_step_instance_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 268
-- Name: is2_step_instance_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_step_instance_id_seq OWNED BY is2.is2_step_instance.id;


--
-- TOC entry 269 (class 1259 OID 25302)
-- Name: is2_step_instance_signature; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_step_instance_signature (
    id integer NOT NULL,
    required smallint,
    app_role_id integer NOT NULL,
    step_instance_id integer NOT NULL,
    cls_type_io_id integer NOT NULL
);


--
-- TOC entry 270 (class 1259 OID 25305)
-- Name: is2_step_instance_signature_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_step_instance_signature_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 270
-- Name: is2_step_instance_signature_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_step_instance_signature_id_seq OWNED BY is2.is2_step_instance_signature.id;


--
-- TOC entry 271 (class 1259 OID 25307)
-- Name: is2_step_runtime; Type: TABLE; Schema: is2; Owner: -
--

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


--
-- TOC entry 272 (class 1259 OID 25310)
-- Name: is2_step_runtime_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_step_runtime_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 272
-- Name: is2_step_runtime_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_step_runtime_id_seq OWNED BY is2.is2_step_runtime.id;


--
-- TOC entry 273 (class 1259 OID 25312)
-- Name: is2_user_roles; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_user_roles (
    id integer NOT NULL,
    role character varying(50) DEFAULT NULL::character varying
);


--
-- TOC entry 274 (class 1259 OID 25316)
-- Name: is2_user_roles_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_user_roles_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 274
-- Name: is2_user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_user_roles_id_seq OWNED BY is2.is2_user_roles.id;


--
-- TOC entry 275 (class 1259 OID 25318)
-- Name: is2_users; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_users (
    id integer NOT NULL,
    email character varying(255),
    name character varying(100),
    surname character varying(100),
    password character varying(500),
    role_id integer NOT NULL
);


--
-- TOC entry 276 (class 1259 OID 25321)
-- Name: is2_users_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_users_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 276
-- Name: is2_users_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_users_id_seq OWNED BY is2.is2_users.id;


--
-- TOC entry 277 (class 1259 OID 25323)
-- Name: is2_view_data_type; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_view_data_type (
    id integer NOT NULL,
    name character varying(50),
    descr text
);


--
-- TOC entry 278 (class 1259 OID 25329)
-- Name: is2_view_data_type_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_view_data_type_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 278
-- Name: is2_view_data_type_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_view_data_type_id_seq OWNED BY is2.is2_view_data_type.id;


--
-- TOC entry 279 (class 1259 OID 25331)
-- Name: is2_work_session; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_work_session (
    id integer NOT NULL,
    name character varying(100),
    descr text,
    last_update timestamp without time zone,
    user_id integer NOT NULL,
    business_function_id integer NOT NULL
);


--
-- TOC entry 280 (class 1259 OID 25337)
-- Name: is2_work_session_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_work_session_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 280
-- Name: is2_work_session_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_work_session_id_seq OWNED BY is2.is2_work_session.id;


--
-- TOC entry 281 (class 1259 OID 25339)
-- Name: is2_workflow; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_workflow (
    id integer NOT NULL,
    rule_id integer NOT NULL,
    step integer NOT NULL,
    sub_step integer NOT NULL,
    else_step integer NOT NULL
);


--
-- TOC entry 282 (class 1259 OID 25342)
-- Name: is2_workflow_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_workflow_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 282
-- Name: is2_workflow_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_workflow_id_seq OWNED BY is2.is2_workflow.id;


--
-- TOC entry 283 (class 1259 OID 25344)
-- Name: is2_workset; Type: TABLE; Schema: is2; Owner: -
--

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


--
-- TOC entry 284 (class 1259 OID 25350)
-- Name: is2_workset_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_workset_id_seq
    AS integer
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4998 (class 0 OID 0)
-- Dependencies: 284
-- Name: is2_workset_id_seq; Type: SEQUENCE OWNED BY; Schema: is2; Owner: -
--

ALTER SEQUENCE is2.is2_workset_id_seq OWNED BY is2.is2_workset.id;


--
-- TOC entry 4613 (class 2604 OID 25352)
-- Name: is2_app_role id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_app_role ALTER COLUMN id SET DEFAULT nextval('is2.is2_app_role_id_seq'::regclass);


--
-- TOC entry 4614 (class 2604 OID 25353)
-- Name: is2_app_service id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_app_service ALTER COLUMN id SET DEFAULT nextval('is2.is2_app_service_id_seq'::regclass);


--
-- TOC entry 4615 (class 2604 OID 25354)
-- Name: is2_business_function id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_function ALTER COLUMN id SET DEFAULT nextval('is2.is2_business_function_id_seq'::regclass);


--
-- TOC entry 4616 (class 2604 OID 25355)
-- Name: is2_business_process id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_process ALTER COLUMN id SET DEFAULT nextval('is2.is2_business_process_id_seq'::regclass);


--
-- TOC entry 4617 (class 2604 OID 25356)
-- Name: is2_business_service id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_service ALTER COLUMN id SET DEFAULT nextval('is2.is2_business_service_id_seq'::regclass);


--
-- TOC entry 4618 (class 2604 OID 25357)
-- Name: is2_cls_data_type id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_data_type ALTER COLUMN id SET DEFAULT nextval('is2.is2_cls_data_type_id_seq'::regclass);


--
-- TOC entry 4619 (class 2604 OID 25358)
-- Name: is2_cls_rule id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_rule ALTER COLUMN id SET DEFAULT nextval('is2.is2_cls_rule_id_seq'::regclass);


--
-- TOC entry 4620 (class 2604 OID 25359)
-- Name: is2_cls_statistical_variable id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_statistical_variable ALTER COLUMN id SET DEFAULT nextval('is2.is2_cls_statistical_variable_id_seq'::regclass);


--
-- TOC entry 4621 (class 2604 OID 25360)
-- Name: is2_cls_type_io id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_type_io ALTER COLUMN id SET DEFAULT nextval('is2.is2_cls_type_io_id_seq'::regclass);


--
-- TOC entry 4622 (class 2604 OID 25361)
-- Name: is2_data_bridge id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_data_bridge ALTER COLUMN id SET DEFAULT nextval('is2.is2_data_bridge_id_seq'::regclass);


--
-- TOC entry 4623 (class 2604 OID 25362)
-- Name: is2_data_processing id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_data_processing ALTER COLUMN id SET DEFAULT nextval('is2.is2_data_processing_id_seq'::regclass);


--
-- TOC entry 4624 (class 2604 OID 25363)
-- Name: is2_dataset_column id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_column ALTER COLUMN id SET DEFAULT nextval('is2.is2_dataset_column_id_seq'::regclass);


--
-- TOC entry 4625 (class 2604 OID 25364)
-- Name: is2_dataset_file id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_file ALTER COLUMN id SET DEFAULT nextval('is2.is2_dataset_file_id_seq'::regclass);


--
-- TOC entry 4626 (class 2604 OID 25365)
-- Name: is2_log id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_log ALTER COLUMN id SET DEFAULT nextval('is2.is2_log_id_seq'::regclass);


--
-- TOC entry 4627 (class 2604 OID 25366)
-- Name: is2_parameter id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_parameter ALTER COLUMN id SET DEFAULT nextval('is2.is2_parameter_id_seq'::regclass);


--
-- TOC entry 4628 (class 2604 OID 25367)
-- Name: is2_process_step id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_process_step ALTER COLUMN id SET DEFAULT nextval('is2.is2_process_step_id_seq'::regclass);


--
-- TOC entry 4631 (class 2604 OID 25368)
-- Name: is2_rule id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_rule ALTER COLUMN id SET DEFAULT nextval('is2.is2_rule_id_seq'::regclass);


--
-- TOC entry 4632 (class 2604 OID 25369)
-- Name: is2_ruleset id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_ruleset ALTER COLUMN id SET DEFAULT nextval('is2.is2_ruleset_id_seq'::regclass);


--
-- TOC entry 4633 (class 2604 OID 25370)
-- Name: is2_step_instance id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance ALTER COLUMN id SET DEFAULT nextval('is2.is2_step_instance_id_seq'::regclass);


--
-- TOC entry 4634 (class 2604 OID 25371)
-- Name: is2_step_instance_signature id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance_signature ALTER COLUMN id SET DEFAULT nextval('is2.is2_step_instance_signature_id_seq'::regclass);


--
-- TOC entry 4635 (class 2604 OID 25372)
-- Name: is2_step_runtime id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_runtime ALTER COLUMN id SET DEFAULT nextval('is2.is2_step_runtime_id_seq'::regclass);


--
-- TOC entry 4637 (class 2604 OID 25373)
-- Name: is2_user_roles id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_user_roles ALTER COLUMN id SET DEFAULT nextval('is2.is2_user_roles_id_seq'::regclass);


--
-- TOC entry 4638 (class 2604 OID 25374)
-- Name: is2_users id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_users ALTER COLUMN id SET DEFAULT nextval('is2.is2_users_id_seq'::regclass);


--
-- TOC entry 4639 (class 2604 OID 25375)
-- Name: is2_view_data_type id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_view_data_type ALTER COLUMN id SET DEFAULT nextval('is2.is2_view_data_type_id_seq'::regclass);


--
-- TOC entry 4640 (class 2604 OID 25376)
-- Name: is2_work_session id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_work_session ALTER COLUMN id SET DEFAULT nextval('is2.is2_work_session_id_seq'::regclass);


--
-- TOC entry 4641 (class 2604 OID 25377)
-- Name: is2_workflow id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workflow ALTER COLUMN id SET DEFAULT nextval('is2.is2_workflow_id_seq'::regclass);


--
-- TOC entry 4642 (class 2604 OID 25378)
-- Name: is2_workset id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workset ALTER COLUMN id SET DEFAULT nextval('is2.is2_workset_id_seq'::regclass);

--
-- TOC entry 4960 (class 0 OID 25339)
-- Dependencies: 281
-- Data for Name: is2_workflow; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 220
-- Name: batch_job_execution_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.batch_job_execution_seq', 1, false);


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 222
-- Name: batch_job_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.batch_job_seq', 1, false);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 225
-- Name: batch_step_execution_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.batch_step_execution_seq', 1, false);


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 227
-- Name: is2_app_role_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_app_role_id_seq', 1, false);


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 229
-- Name: is2_app_service_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_app_service_id_seq', 1, false);


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 231
-- Name: is2_business_function_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_business_function_id_seq', 1, false);


--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 233
-- Name: is2_business_process_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_business_process_id_seq', 1, false);


--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 235
-- Name: is2_business_service_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_business_service_id_seq', 1, false);


--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 237
-- Name: is2_cls_data_type_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_cls_data_type_id_seq', 1, false);


--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 239
-- Name: is2_cls_rule_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_cls_rule_id_seq', 1, false);


--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 241
-- Name: is2_cls_statistical_variable_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_cls_statistical_variable_id_seq', 1, false);


--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 243
-- Name: is2_cls_type_io_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_cls_type_io_id_seq', 1, false);


--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 245
-- Name: is2_data_bridge_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_data_bridge_id_seq', 1, false);


--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 247
-- Name: is2_data_processing_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_data_processing_id_seq', 5, true);


--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 249
-- Name: is2_dataset_column_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_dataset_column_id_seq', 21, true);


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 251
-- Name: is2_dataset_file_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_dataset_file_id_seq', 3, true);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 258
-- Name: is2_log_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_log_id_seq', 13, true);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 260
-- Name: is2_parameter_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_parameter_id_seq', 1, false);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 262
-- Name: is2_process_step_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_process_step_id_seq', 1, false);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 264
-- Name: is2_rule_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_rule_id_seq', 2, true);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 266
-- Name: is2_ruleset_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_ruleset_id_seq', 3, true);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 268
-- Name: is2_step_instance_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_step_instance_id_seq', 1, false);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 270
-- Name: is2_step_instance_signature_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_step_instance_signature_id_seq', 1, false);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 272
-- Name: is2_step_runtime_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_step_runtime_id_seq', 16, true);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 274
-- Name: is2_user_roles_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_user_roles_id_seq', 1, false);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 276
-- Name: is2_users_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_users_id_seq', 1, false);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 278
-- Name: is2_view_data_type_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_view_data_type_id_seq', 1, false);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 280
-- Name: is2_work_session_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_work_session_id_seq', 5, true);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 282
-- Name: is2_workflow_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_workflow_id_seq', 1, false);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 284
-- Name: is2_workset_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

SELECT pg_catalog.setval('is2.is2_workset_id_seq', 16, true);


--
-- TOC entry 4646 (class 2606 OID 25383)
-- Name: batch_job_execution_context batch_job_execution_context_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_job_execution_context
    ADD CONSTRAINT batch_job_execution_context_pkey PRIMARY KEY (job_execution_id);


--
-- TOC entry 4644 (class 2606 OID 25385)
-- Name: batch_job_execution batch_job_execution_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_job_execution
    ADD CONSTRAINT batch_job_execution_pkey PRIMARY KEY (job_execution_id);


--
-- TOC entry 4648 (class 2606 OID 25387)
-- Name: batch_job_instance batch_job_instance_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_job_instance
    ADD CONSTRAINT batch_job_instance_pkey PRIMARY KEY (job_instance_id);


--
-- TOC entry 4654 (class 2606 OID 25389)
-- Name: batch_step_execution_context batch_step_execution_context_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_step_execution_context
    ADD CONSTRAINT batch_step_execution_context_pkey PRIMARY KEY (step_execution_id);


--
-- TOC entry 4652 (class 2606 OID 25391)
-- Name: batch_step_execution batch_step_execution_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_step_execution
    ADD CONSTRAINT batch_step_execution_pkey PRIMARY KEY (step_execution_id);

-- is2.is2_gsbpm_process

ALTER TABLE ONLY is2.is2_gsbpm_process
    ADD CONSTRAINT is2_gsbpm_process_pkey PRIMARY KEY (id);

--
-- TOC entry 4656 (class 2606 OID 25393)
-- Name: is2_app_role is2_app_role_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_app_role
    ADD CONSTRAINT is2_app_role_pkey PRIMARY KEY (id);


--
-- TOC entry 4658 (class 2606 OID 25395)
-- Name: is2_app_service is2_app_service_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_app_service
    ADD CONSTRAINT is2_app_service_pkey PRIMARY KEY (id);


--
-- TOC entry 4660 (class 2606 OID 25397)
-- Name: is2_business_function is2_business_function_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_function
    ADD CONSTRAINT is2_business_function_pkey PRIMARY KEY (id);


--
-- TOC entry 4662 (class 2606 OID 25399)
-- Name: is2_business_process is2_business_process_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_process
    ADD CONSTRAINT is2_business_process_pkey PRIMARY KEY (id);


--
-- TOC entry 4664 (class 2606 OID 25401)
-- Name: is2_business_service is2_business_service_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_service
    ADD CONSTRAINT is2_business_service_pkey PRIMARY KEY (id);


--
-- TOC entry 4666 (class 2606 OID 25403)
-- Name: is2_cls_data_type is2_cls_data_type_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_data_type
    ADD CONSTRAINT is2_cls_data_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4668 (class 2606 OID 25405)
-- Name: is2_cls_rule is2_cls_rule_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_rule
    ADD CONSTRAINT is2_cls_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 4670 (class 2606 OID 25407)
-- Name: is2_cls_statistical_variable is2_cls_statistical_variable_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_statistical_variable
    ADD CONSTRAINT is2_cls_statistical_variable_pkey PRIMARY KEY (id);


--
-- TOC entry 4672 (class 2606 OID 25409)
-- Name: is2_cls_type_io is2_cls_type_io_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_type_io
    ADD CONSTRAINT is2_cls_type_io_pkey PRIMARY KEY (id);


--
-- TOC entry 4674 (class 2606 OID 25411)
-- Name: is2_data_bridge is2_data_bridge_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_data_bridge
    ADD CONSTRAINT is2_data_bridge_pkey PRIMARY KEY (id);


--
-- TOC entry 4676 (class 2606 OID 25413)
-- Name: is2_data_processing is2_data_processing_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_data_processing
    ADD CONSTRAINT is2_data_processing_pkey PRIMARY KEY (id);


--
-- TOC entry 4678 (class 2606 OID 25415)
-- Name: is2_dataset_column is2_dataset_column_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_column
    ADD CONSTRAINT is2_dataset_column_pkey PRIMARY KEY (id);


--
-- TOC entry 4680 (class 2606 OID 25417)
-- Name: is2_dataset_file is2_dataset_file_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_file
    ADD CONSTRAINT is2_dataset_file_pkey PRIMARY KEY (id);


--
-- TOC entry 4682 (class 2606 OID 25419)
-- Name: is2_link_business_service_app_role is2_link_business_service_app_role_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_business_service_app_role
    ADD CONSTRAINT is2_link_business_service_app_role_pkey PRIMARY KEY (business_service_id, app_role_id);


--
-- TOC entry 4684 (class 2606 OID 25421)
-- Name: is2_link_function_process is2_link_function_process_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_function_process
    ADD CONSTRAINT is2_link_function_process_pkey PRIMARY KEY (business_function_id, business_process_id);


--
-- TOC entry 4686 (class 2606 OID 25423)
-- Name: is2_link_function_view_data_type is2_link_function_view_data_type_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_function_view_data_type
    ADD CONSTRAINT is2_link_function_view_data_type_pkey PRIMARY KEY (business_function_id, view_data_type_id);


--
-- TOC entry 4688 (class 2606 OID 25425)
-- Name: is2_link_process_step is2_link_process_step_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_process_step
    ADD CONSTRAINT is2_link_process_step_pkey PRIMARY KEY (business_process_id, process_step_id);


--
-- TOC entry 4690 (class 2606 OID 25427)
-- Name: is2_link_step_instance is2_link_step_instance_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_step_instance
    ADD CONSTRAINT is2_link_step_instance_pkey PRIMARY KEY (process_step_id, process_step_instance_id);


--
-- TOC entry 4692 (class 2606 OID 25429)
-- Name: is2_log is2_log_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_log
    ADD CONSTRAINT is2_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4694 (class 2606 OID 25431)
-- Name: is2_parameter is2_parameter_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_parameter
    ADD CONSTRAINT is2_parameter_pkey PRIMARY KEY (id);


--
-- TOC entry 4696 (class 2606 OID 25433)
-- Name: is2_process_step is2_process_step_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_process_step
    ADD CONSTRAINT is2_process_step_pkey PRIMARY KEY (id);


--
-- TOC entry 4698 (class 2606 OID 25435)
-- Name: is2_rule is2_rule_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_rule
    ADD CONSTRAINT is2_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 4700 (class 2606 OID 25437)
-- Name: is2_ruleset is2_ruleset_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_ruleset
    ADD CONSTRAINT is2_ruleset_pkey PRIMARY KEY (id);


--
-- TOC entry 4702 (class 2606 OID 25439)
-- Name: is2_step_instance is2_step_instance_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance
    ADD CONSTRAINT is2_step_instance_pkey PRIMARY KEY (id);


--
-- TOC entry 4704 (class 2606 OID 25441)
-- Name: is2_step_instance_signature is2_step_instance_signature_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance_signature
    ADD CONSTRAINT is2_step_instance_signature_pkey PRIMARY KEY (id);


--
-- TOC entry 4706 (class 2606 OID 25443)
-- Name: is2_step_runtime is2_step_runtime_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT is2_step_runtime_pkey PRIMARY KEY (id);


--
-- TOC entry 4708 (class 2606 OID 25445)
-- Name: is2_user_roles is2_user_roles_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_user_roles
    ADD CONSTRAINT is2_user_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4710 (class 2606 OID 25447)
-- Name: is2_users is2_users_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_users
    ADD CONSTRAINT is2_users_pkey PRIMARY KEY (id);


--
-- TOC entry 4712 (class 2606 OID 25449)
-- Name: is2_view_data_type is2_view_data_type_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_view_data_type
    ADD CONSTRAINT is2_view_data_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4714 (class 2606 OID 25451)
-- Name: is2_work_session is2_work_session_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_work_session
    ADD CONSTRAINT is2_work_session_pkey PRIMARY KEY (id);


--
-- TOC entry 4716 (class 2606 OID 25453)
-- Name: is2_workflow is2_workflow_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workflow
    ADD CONSTRAINT is2_workflow_pkey PRIMARY KEY (id);


--
-- TOC entry 4718 (class 2606 OID 25455)
-- Name: is2_workset is2_workset_pkey; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workset
    ADD CONSTRAINT is2_workset_pkey PRIMARY KEY (id);


--
-- TOC entry 4650 (class 2606 OID 25457)
-- Name: batch_job_instance job_inst_un; Type: CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_job_instance
    ADD CONSTRAINT job_inst_un UNIQUE (job_name, job_key);


--
-- TOC entry 4724 (class 2606 OID 25458)
-- Name: is2_app_role fk_is2_app_role_is2_data_type; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_app_role
    ADD CONSTRAINT fk_is2_app_role_is2_data_type FOREIGN KEY (cls_data_type_id) REFERENCES is2.is2_cls_data_type(id);


--
-- TOC entry 4725 (class 2606 OID 25463)
-- Name: is2_app_role fk_is2_app_role_is2_paramter; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_app_role
    ADD CONSTRAINT fk_is2_app_role_is2_paramter FOREIGN KEY (parameter_id) REFERENCES is2.is2_parameter(id);


--
-- TOC entry 4726 (class 2606 OID 25468)
-- Name: is2_app_service fk_is2_app_service_is2_business_service; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_app_service
    ADD CONSTRAINT fk_is2_app_service_is2_business_service FOREIGN KEY (business_service_id) REFERENCES is2.is2_business_service(id);


--
-- TOC entry 4736 (class 2606 OID 25473)
-- Name: is2_link_function_process fk_is2_bfunc_bprocess_is2_business_function; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_function_process
    ADD CONSTRAINT fk_is2_bfunc_bprocess_is2_business_function FOREIGN KEY (business_function_id) REFERENCES is2.is2_business_function(id);


--
-- TOC entry 4737 (class 2606 OID 25478)
-- Name: is2_link_function_process fk_is2_bfunc_bprocess_is2_business_process; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_function_process
    ADD CONSTRAINT fk_is2_bfunc_bprocess_is2_business_process FOREIGN KEY (business_process_id) REFERENCES is2.is2_business_process(id);


--
-- TOC entry 4740 (class 2606 OID 25483)
-- Name: is2_link_process_step fk_is2_bprocess_bstep_is2_business_process; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_process_step
    ADD CONSTRAINT fk_is2_bprocess_bstep_is2_business_process FOREIGN KEY (business_process_id) REFERENCES is2.is2_business_process(id);


--
-- TOC entry 4741 (class 2606 OID 25488)
-- Name: is2_link_process_step fk_is2_bprocess_bstep_is2_process_step; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_process_step
    ADD CONSTRAINT fk_is2_bprocess_bstep_is2_process_step FOREIGN KEY (process_step_id) REFERENCES is2.is2_process_step(id);


--
-- TOC entry 4727 (class 2606 OID 25493)
-- Name: is2_business_process fk_is2_business_process_is2_business_process; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_process
    ADD CONSTRAINT fk_is2_business_process_is2_business_process FOREIGN KEY (parent) REFERENCES is2.is2_business_process(id);


--
-- TOC entry 4734 (class 2606 OID 25498)
-- Name: is2_link_business_service_app_role fk_is2_business_service_app_role_app_role; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_business_service_app_role
    ADD CONSTRAINT fk_is2_business_service_app_role_app_role FOREIGN KEY (app_role_id) REFERENCES is2.is2_app_role(id);


--
-- TOC entry 4735 (class 2606 OID 25503)
-- Name: is2_link_business_service_app_role fk_is2_business_service_app_role_business_service; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_business_service_app_role
    ADD CONSTRAINT fk_is2_business_service_app_role_business_service FOREIGN KEY (business_service_id) REFERENCES is2.is2_business_service(id);


--
-- TOC entry 4728 (class 2606 OID 25508)
-- Name: is2_data_processing fk_is2_data_processing_business_process; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_data_processing
    ADD CONSTRAINT fk_is2_data_processing_business_process FOREIGN KEY (business_process_id) REFERENCES is2.is2_business_process(id);


--
-- TOC entry 4729 (class 2606 OID 25513)
-- Name: is2_data_processing fk_is2_data_processing_worksession; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_data_processing
    ADD CONSTRAINT fk_is2_data_processing_worksession FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);


--
-- TOC entry 4732 (class 2606 OID 25518)
-- Name: is2_dataset_file fk_is2_datakset_file_data_type; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_file
    ADD CONSTRAINT fk_is2_datakset_file_data_type FOREIGN KEY (cls_data_type_id) REFERENCES is2.is2_cls_data_type(id);


--
-- TOC entry 4733 (class 2606 OID 25523)
-- Name: is2_dataset_file fk_is2_datakset_file_worksession; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_file
    ADD CONSTRAINT fk_is2_datakset_file_worksession FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);


--
-- TOC entry 4730 (class 2606 OID 25528)
-- Name: is2_dataset_column fk_is2_dataset_column_dataset_id; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_column
    ADD CONSTRAINT fk_is2_dataset_column_dataset_id FOREIGN KEY (dataset_file_id) REFERENCES is2.is2_dataset_file(id);


--
-- TOC entry 4731 (class 2606 OID 25533)
-- Name: is2_dataset_column fk_is2_dataset_column_statistical_variable; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_column
    ADD CONSTRAINT fk_is2_dataset_column_statistical_variable FOREIGN KEY (statistical_variable_id) REFERENCES is2.is2_cls_statistical_variable(id);


--
-- TOC entry 4744 (class 2606 OID 25538)
-- Name: is2_log fk_is2_log_worksession; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_log
    ADD CONSTRAINT fk_is2_log_worksession FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);


--
-- TOC entry 4746 (class 2606 OID 25543)
-- Name: is2_process_step fk_is2_process_step_business_service; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_process_step
    ADD CONSTRAINT fk_is2_process_step_business_service FOREIGN KEY (business_service_id) REFERENCES is2.is2_business_service(id);


--
-- TOC entry 4751 (class 2606 OID 25548)
-- Name: is2_step_instance fk_is2_step_instance_is2_app_service; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance
    ADD CONSTRAINT fk_is2_step_instance_is2_app_service FOREIGN KEY (app_service_id) REFERENCES is2.is2_app_service(id);


--
-- TOC entry 4742 (class 2606 OID 25553)
-- Name: is2_link_step_instance fk_is2_step_instance_process_step; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_step_instance
    ADD CONSTRAINT fk_is2_step_instance_process_step FOREIGN KEY (process_step_id) REFERENCES is2.is2_process_step(id);


--
-- TOC entry 4752 (class 2606 OID 25558)
-- Name: is2_step_instance_signature fk_is2_step_instance_signature_is2_app_role; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance_signature
    ADD CONSTRAINT fk_is2_step_instance_signature_is2_app_role FOREIGN KEY (app_role_id) REFERENCES is2.is2_app_role(id);


--
-- TOC entry 4753 (class 2606 OID 25563)
-- Name: is2_step_instance_signature fk_is2_step_instance_signature_is2_step_instance; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance_signature
    ADD CONSTRAINT fk_is2_step_instance_signature_is2_step_instance FOREIGN KEY (step_instance_id) REFERENCES is2.is2_step_instance(id);


--
-- TOC entry 4754 (class 2606 OID 25568)
-- Name: is2_step_instance_signature fk_is2_step_instance_signature_is2_type_io; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance_signature
    ADD CONSTRAINT fk_is2_step_instance_signature_is2_type_io FOREIGN KEY (cls_type_io_id) REFERENCES is2.is2_cls_type_io(id);


--
-- TOC entry 4743 (class 2606 OID 25573)
-- Name: is2_link_step_instance fk_is2_step_instance_step_instance; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_step_instance
    ADD CONSTRAINT fk_is2_step_instance_step_instance FOREIGN KEY (process_step_instance_id) REFERENCES is2.is2_step_instance(id);


--
-- TOC entry 4755 (class 2606 OID 25578)
-- Name: is2_step_runtime fk_is2_step_runtime_is2_app_role; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_app_role FOREIGN KEY (app_role_id) REFERENCES is2.is2_app_role(id);


--
-- TOC entry 4756 (class 2606 OID 25583)
-- Name: is2_step_runtime fk_is2_step_runtime_is2_data_processing; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_data_processing FOREIGN KEY (data_processing_id) REFERENCES is2.is2_data_processing(id);


--
-- TOC entry 4757 (class 2606 OID 25588)
-- Name: is2_step_runtime fk_is2_step_runtime_is2_data_type; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_data_type FOREIGN KEY (cls_data_type_id) REFERENCES is2.is2_cls_data_type(id);


--
-- TOC entry 4758 (class 2606 OID 25593)
-- Name: is2_step_runtime fk_is2_step_runtime_is2_signature; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_signature FOREIGN KEY (step_instance_signature_id) REFERENCES is2.is2_step_instance_signature(id);


--
-- TOC entry 4759 (class 2606 OID 25598)
-- Name: is2_step_runtime fk_is2_step_runtime_is2_type_io; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_type_io FOREIGN KEY (cls_type_io_id) REFERENCES is2.is2_cls_type_io(id);


--
-- TOC entry 4760 (class 2606 OID 25603)
-- Name: is2_step_runtime fk_is2_step_runtime_is2_workset; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_runtime
    ADD CONSTRAINT fk_is2_step_runtime_is2_workset FOREIGN KEY (workset_id) REFERENCES is2.is2_workset(id);


--
-- TOC entry 4761 (class 2606 OID 25608)
-- Name: is2_users fk_is2_users_is2_user_roles; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_users
    ADD CONSTRAINT fk_is2_users_is2_user_roles FOREIGN KEY (role_id) REFERENCES is2.is2_user_roles(id);


--
-- TOC entry 4738 (class 2606 OID 25613)
-- Name: is2_link_function_view_data_type fk_is2_view_data_type_is2_business_function; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_function_view_data_type
    ADD CONSTRAINT fk_is2_view_data_type_is2_business_function FOREIGN KEY (business_function_id) REFERENCES is2.is2_business_function(id);


--
-- TOC entry 4739 (class 2606 OID 25618)
-- Name: is2_link_function_view_data_type fk_is2_view_data_type_is2_view_data_type; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_link_function_view_data_type
    ADD CONSTRAINT fk_is2_view_data_type_is2_view_data_type FOREIGN KEY (view_data_type_id) REFERENCES is2.is2_view_data_type(id);


--
-- TOC entry 4762 (class 2606 OID 25623)
-- Name: is2_work_session fk_is2_worksession_business_function; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_work_session
    ADD CONSTRAINT fk_is2_worksession_business_function FOREIGN KEY (business_function_id) REFERENCES is2.is2_business_function(id);


--
-- TOC entry 4763 (class 2606 OID 25628)
-- Name: is2_work_session fk_is2_worksession_user; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_work_session
    ADD CONSTRAINT fk_is2_worksession_user FOREIGN KEY (user_id) REFERENCES is2.is2_users(id);


--
-- TOC entry 4767 (class 2606 OID 25633)
-- Name: is2_workset fk_is2_workset_data_type; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workset
    ADD CONSTRAINT fk_is2_workset_data_type FOREIGN KEY (cls_data_type_id) REFERENCES is2.is2_cls_data_type(id);


--
-- TOC entry 4747 (class 2606 OID 25638)
-- Name: is2_rule fk_rule_cls_rule; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_rule
    ADD CONSTRAINT fk_rule_cls_rule FOREIGN KEY (cls_rule_id) REFERENCES is2.is2_cls_rule(id);


--
-- TOC entry 4748 (class 2606 OID 25643)
-- Name: is2_rule fk_rule_ruleset; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_rule
    ADD CONSTRAINT fk_rule_ruleset FOREIGN KEY (ruleset_id) REFERENCES is2.is2_ruleset(id);


--
-- TOC entry 4749 (class 2606 OID 25648)
-- Name: is2_ruleset fk_ruleset_dataset; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_ruleset
    ADD CONSTRAINT fk_ruleset_dataset FOREIGN KEY (dataset_id) REFERENCES is2.is2_dataset_file(id);


--
-- TOC entry 4750 (class 2606 OID 25653)
-- Name: is2_ruleset fk_ruleset_work_session; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_ruleset
    ADD CONSTRAINT fk_ruleset_work_session FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);


--
-- TOC entry 4745 (class 2606 OID 25658)
-- Name: is2_log is2_log_work_session_id_fkey; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_log
    ADD CONSTRAINT is2_log_work_session_id_fkey FOREIGN KEY (work_session_id) REFERENCES is2.is2_work_session(id);


--
-- TOC entry 4764 (class 2606 OID 25663)
-- Name: is2_workflow is2_workflow_else_step_fkey; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workflow
    ADD CONSTRAINT is2_workflow_else_step_fkey FOREIGN KEY (else_step) REFERENCES is2.is2_process_step(id);


--
-- TOC entry 4765 (class 2606 OID 25668)
-- Name: is2_workflow is2_workflow_step_fkey; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workflow
    ADD CONSTRAINT is2_workflow_step_fkey FOREIGN KEY (step) REFERENCES is2.is2_process_step(id);


--
-- TOC entry 4766 (class 2606 OID 25673)
-- Name: is2_workflow is2_workflow_sub_step_fkey; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workflow
    ADD CONSTRAINT is2_workflow_sub_step_fkey FOREIGN KEY (sub_step) REFERENCES is2.is2_process_step(id);


--
-- TOC entry 4720 (class 2606 OID 25678)
-- Name: batch_job_execution_context job_exec_ctx_fk; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_job_execution_context
    ADD CONSTRAINT job_exec_ctx_fk FOREIGN KEY (job_execution_id) REFERENCES is2.batch_job_execution(job_execution_id);


--
-- TOC entry 4721 (class 2606 OID 25683)
-- Name: batch_job_execution_params job_exec_params_fk; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_job_execution_params
    ADD CONSTRAINT job_exec_params_fk FOREIGN KEY (job_execution_id) REFERENCES is2.batch_job_execution(job_execution_id);


--
-- TOC entry 4722 (class 2606 OID 25688)
-- Name: batch_step_execution job_exec_step_fk; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_step_execution
    ADD CONSTRAINT job_exec_step_fk FOREIGN KEY (job_execution_id) REFERENCES is2.batch_job_execution(job_execution_id);


--
-- TOC entry 4719 (class 2606 OID 25693)
-- Name: batch_job_execution job_inst_exec_fk; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_job_execution
    ADD CONSTRAINT job_inst_exec_fk FOREIGN KEY (job_instance_id) REFERENCES is2.batch_job_instance(job_instance_id);


--
-- TOC entry 4723 (class 2606 OID 25698)
-- Name: batch_step_execution_context step_exec_ctx_fk; Type: FK CONSTRAINT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.batch_step_execution_context
    ADD CONSTRAINT step_exec_ctx_fk FOREIGN KEY (step_execution_id) REFERENCES is2.batch_step_execution(step_execution_id);


-- Completed on 2020-01-14 10:16:34

--
-- PostgreSQL database dump complete
--

