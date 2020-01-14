DO '
BEGIN

CREATE SCHEMA is2;

execute ''alter database ''||current_database()||'' set search_path to is2,public;'';

set search_path to is2,public;

SET default_tablespace = '''';

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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    "order" integer,
    cls_data_type_id integer,
    parameter_id integer
);


--
-- TOC entry 227 (class 1259 OID 25148)
-- Name: is2_app_role_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_app_role_id_seq
    AS integer
    START WITH 1
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
    id integer NOT NULL,
    name character varying(100),
    descr text,
    implementation_language character varying(100),
    source character varying(100),
    business_service_id integer NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 25156)
-- Name: is2_app_service_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_app_service_id_seq
    AS integer
    START WITH 1
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
    START WITH 1
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
    "order" integer,
    parent integer
);


--
-- TOC entry 233 (class 1259 OID 25172)
-- Name: is2_business_process_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_business_process_id_seq
    AS integer
    START WITH 1
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
    descr text
);


--
-- TOC entry 235 (class 1259 OID 25180)
-- Name: is2_business_service_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_business_service_id_seq
    AS integer
    START WITH 1
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
-- TOC entry 347 (class 1259 OID 32768)
-- Name: is2_business_service_sav; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_business_service_sav (
    id integer,
    name character varying(100),
    descr text
);


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
    START WITH 1
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
    START WITH 1
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
    "order" integer,
    variable_name_ita character varying(500),
    variable_name_eng character varying(500)
);


--
-- TOC entry 241 (class 1259 OID 25204)
-- Name: is2_cls_statistical_variable_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_cls_statistical_variable_id_seq
    AS integer
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    name character varying(100),
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
    START WITH 1
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
    START WITH 1
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
-- TOC entry 349 (class 1259 OID 32783)
-- Name: is2_link_business_service_app_role_sav; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_link_business_service_app_role_sav (
    business_service_id integer,
    app_role_id integer
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
    START WITH 1
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
    START WITH 1
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
    descr text,
    business_service_id integer NOT NULL
);


--
-- TOC entry 262 (class 1259 OID 25274)
-- Name: is2_process_step_id_seq; Type: SEQUENCE; Schema: is2; Owner: -
--

CREATE SEQUENCE is2.is2_process_step_id_seq
    AS integer
    START WITH 1
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
-- TOC entry 348 (class 1259 OID 32774)
-- Name: is2_process_step_sav; Type: TABLE; Schema: is2; Owner: -
--

CREATE TABLE is2.is2_process_step_sav (
    id integer,
    name character varying(100),
    descr text,
    business_service_id integer
);


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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    START WITH 1
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
    name character varying(100),
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
    START WITH 1
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

ALTER TABLE ONLY is2.is2_app_role ALTER COLUMN id SET DEFAULT nextval(''is2.is2_app_role_id_seq''::regclass);


--
-- TOC entry 4614 (class 2604 OID 25353)
-- Name: is2_app_service id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_app_service ALTER COLUMN id SET DEFAULT nextval(''is2.is2_app_service_id_seq''::regclass);


--
-- TOC entry 4615 (class 2604 OID 25354)
-- Name: is2_business_function id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_function ALTER COLUMN id SET DEFAULT nextval(''is2.is2_business_function_id_seq''::regclass);


--
-- TOC entry 4616 (class 2604 OID 25355)
-- Name: is2_business_process id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_process ALTER COLUMN id SET DEFAULT nextval(''is2.is2_business_process_id_seq''::regclass);


--
-- TOC entry 4617 (class 2604 OID 25356)
-- Name: is2_business_service id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_business_service ALTER COLUMN id SET DEFAULT nextval(''is2.is2_business_service_id_seq''::regclass);


--
-- TOC entry 4618 (class 2604 OID 25357)
-- Name: is2_cls_data_type id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_data_type ALTER COLUMN id SET DEFAULT nextval(''is2.is2_cls_data_type_id_seq''::regclass);


--
-- TOC entry 4619 (class 2604 OID 25358)
-- Name: is2_cls_rule id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_rule ALTER COLUMN id SET DEFAULT nextval(''is2.is2_cls_rule_id_seq''::regclass);


--
-- TOC entry 4620 (class 2604 OID 25359)
-- Name: is2_cls_statistical_variable id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_statistical_variable ALTER COLUMN id SET DEFAULT nextval(''is2.is2_cls_statistical_variable_id_seq''::regclass);


--
-- TOC entry 4621 (class 2604 OID 25360)
-- Name: is2_cls_type_io id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_cls_type_io ALTER COLUMN id SET DEFAULT nextval(''is2.is2_cls_type_io_id_seq''::regclass);


--
-- TOC entry 4622 (class 2604 OID 25361)
-- Name: is2_data_bridge id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_data_bridge ALTER COLUMN id SET DEFAULT nextval(''is2.is2_data_bridge_id_seq''::regclass);


--
-- TOC entry 4623 (class 2604 OID 25362)
-- Name: is2_data_processing id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_data_processing ALTER COLUMN id SET DEFAULT nextval(''is2.is2_data_processing_id_seq''::regclass);


--
-- TOC entry 4624 (class 2604 OID 25363)
-- Name: is2_dataset_column id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_column ALTER COLUMN id SET DEFAULT nextval(''is2.is2_dataset_column_id_seq''::regclass);


--
-- TOC entry 4625 (class 2604 OID 25364)
-- Name: is2_dataset_file id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_dataset_file ALTER COLUMN id SET DEFAULT nextval(''is2.is2_dataset_file_id_seq''::regclass);


--
-- TOC entry 4626 (class 2604 OID 25365)
-- Name: is2_log id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_log ALTER COLUMN id SET DEFAULT nextval(''is2.is2_log_id_seq''::regclass);


--
-- TOC entry 4627 (class 2604 OID 25366)
-- Name: is2_parameter id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_parameter ALTER COLUMN id SET DEFAULT nextval(''is2.is2_parameter_id_seq''::regclass);


--
-- TOC entry 4628 (class 2604 OID 25367)
-- Name: is2_process_step id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_process_step ALTER COLUMN id SET DEFAULT nextval(''is2.is2_process_step_id_seq''::regclass);


--
-- TOC entry 4631 (class 2604 OID 25368)
-- Name: is2_rule id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_rule ALTER COLUMN id SET DEFAULT nextval(''is2.is2_rule_id_seq''::regclass);


--
-- TOC entry 4632 (class 2604 OID 25369)
-- Name: is2_ruleset id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_ruleset ALTER COLUMN id SET DEFAULT nextval(''is2.is2_ruleset_id_seq''::regclass);


--
-- TOC entry 4633 (class 2604 OID 25370)
-- Name: is2_step_instance id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance ALTER COLUMN id SET DEFAULT nextval(''is2.is2_step_instance_id_seq''::regclass);


--
-- TOC entry 4634 (class 2604 OID 25371)
-- Name: is2_step_instance_signature id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_instance_signature ALTER COLUMN id SET DEFAULT nextval(''is2.is2_step_instance_signature_id_seq''::regclass);


--
-- TOC entry 4635 (class 2604 OID 25372)
-- Name: is2_step_runtime id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_step_runtime ALTER COLUMN id SET DEFAULT nextval(''is2.is2_step_runtime_id_seq''::regclass);


--
-- TOC entry 4637 (class 2604 OID 25373)
-- Name: is2_user_roles id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_user_roles ALTER COLUMN id SET DEFAULT nextval(''is2.is2_user_roles_id_seq''::regclass);


--
-- TOC entry 4638 (class 2604 OID 25374)
-- Name: is2_users id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_users ALTER COLUMN id SET DEFAULT nextval(''is2.is2_users_id_seq''::regclass);


--
-- TOC entry 4639 (class 2604 OID 25375)
-- Name: is2_view_data_type id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_view_data_type ALTER COLUMN id SET DEFAULT nextval(''is2.is2_view_data_type_id_seq''::regclass);


--
-- TOC entry 4640 (class 2604 OID 25376)
-- Name: is2_work_session id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_work_session ALTER COLUMN id SET DEFAULT nextval(''is2.is2_work_session_id_seq''::regclass);


--
-- TOC entry 4641 (class 2604 OID 25377)
-- Name: is2_workflow id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workflow ALTER COLUMN id SET DEFAULT nextval(''is2.is2_workflow_id_seq''::regclass);


--
-- TOC entry 4642 (class 2604 OID 25378)
-- Name: is2_workset id; Type: DEFAULT; Schema: is2; Owner: -
--

ALTER TABLE ONLY is2.is2_workset ALTER COLUMN id SET DEFAULT nextval(''is2.is2_workset_id_seq''::regclass);


--
-- TOC entry 4896 (class 0 OID 25106)
-- Dependencies: 217
-- Data for Name: batch_job_execution; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4897 (class 0 OID 25112)
-- Dependencies: 218
-- Data for Name: batch_job_execution_context; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4898 (class 0 OID 25118)
-- Dependencies: 219
-- Data for Name: batch_job_execution_params; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4900 (class 0 OID 25123)
-- Dependencies: 221
-- Data for Name: batch_job_instance; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4902 (class 0 OID 25128)
-- Dependencies: 223
-- Data for Name: batch_step_execution; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4903 (class 0 OID 25134)
-- Dependencies: 224
-- Data for Name: batch_step_execution_context; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4905 (class 0 OID 25142)
-- Dependencies: 226
-- Data for Name: is2_app_role; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_app_role VALUES (1, ''X'', ''MATCHING VARIABLES'', ''MATCHING VARAIBLES'', 1, 2, 1);
INSERT INTO is2.is2_app_role VALUES (2, ''X1'', ''MATCHING A'', ''MATCHING VARIABLE IN DATASET A'', 2, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (3, ''X2'', ''MATCHING B'', ''MATCHING VARIABLE IN DATASET B'', 3, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (4, ''CT'', ''CONTENGENCY TABLE'', ''CONTENGENCY TABLE'', 4, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (5, ''FS'', ''FELLEGI-SUNTER'', ''FELLEGI-SUNTER'', 14, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (6, ''B'', ''BLOCKING'', ''SLICING DEL DATASET'', 7, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (7, ''MT'', ''MATCHING TABLE'', ''MATCHING TABLE'', 8, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (8, ''TH'', ''THRESHOLD MATCHING'', ''THRESHOLD MATCHING'', 9, 2, 2);
INSERT INTO is2.is2_app_role VALUES (9, ''TU'', ''THRESHOLD UNMATCHING'', ''THRESHOLD UNMATCHING'', 10, 2, 3);
INSERT INTO is2.is2_app_role VALUES (10, ''PM'', ''POSSIBLE MATCHING TABLE'', ''POSSIBLE MATCHING TABLE'', 11, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (11, ''M'', ''RANKING'', ''INFLUENCE RANKING'', 5, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (12, ''S'', ''STRATA'', ''PARTIZIONAMENTO DEL DATASET'', 6, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (13, ''RA'', ''RESIDUAL A'', ''RESIDUAL DATASET  A'', 12, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (14, ''RB'', ''RESIDUAL B'', ''RESIDUAL DATASET  B'', 13, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (15, ''MD'', ''DATA'', ''DATA'', 1, 1, NULL);
INSERT INTO is2.is2_app_role VALUES (16, ''RS'', ''RULESET'', ''RULESET'', 2, 4, NULL);
INSERT INTO is2.is2_app_role VALUES (910, ''LP'', ''LOADER PARAMETERS'', ''LOADER PARAMETERS'', 1, 2, 910);
INSERT INTO is2.is2_app_role VALUES (950, ''MP'', ''MAPPING PARAMETERS'', ''MAPPING PARAMETERS'', 5, 2, 950);


--
-- TOC entry 4907 (class 0 OID 25150)
-- Dependencies: 228
-- Data for Name: is2_app_service; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_app_service VALUES (200, ''Relais R'', ''R package implementing record linkage methods'', ''R'', ''relais/relais.R'', 200);
INSERT INTO is2.is2_app_service VALUES (250, ''Relais Java'', ''Java package implementing record linkage methods'', ''JAVA'', ''it.istat.is2.catalogue.relais.service.RelaisService'', 200);
INSERT INTO is2.is2_app_service VALUES (300, ''Validate'', ''R package implementing a set of data validation functions'', ''R'', ''validate/validate.r'', 300);
INSERT INTO is2.is2_app_service VALUES (91, ''ARC LOADER'', ''Java package implementing ARC loader service'', ''JAVA'', ''it.istat.is2.catalogue.arc.service.loader'', 91);
INSERT INTO is2.is2_app_service VALUES (95, ''MAPPING'', ''Java package implementing ARC Mapping service'', ''JAVA'', ''it.istat.is2.catalogue.arc.service.mapping'', 91);


--
-- TOC entry 4909 (class 0 OID 25158)
-- Dependencies: 230
-- Data for Name: is2_business_function; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_business_function VALUES (1, ''Record Linkage'', ''The purpose of record linkage is to identify the same real world entity that can be differently represented in data sources, even if unique identifiers are not available or are affected by errors.'', ''RL'', 1);
INSERT INTO is2.is2_business_function VALUES (2, ''Data Editing'', ''Data editing is the process of reviewing the data for consistency, detection of errors and outliers and correction of errors, in order to improve the quality, accuracy and adequacy of the data and make it suitable for the purpose for which it was collected.'', ''EDIT'', 1);
INSERT INTO is2.is2_business_function VALUES (3, ''Data Validation'', ''Data validation is the process of ensuring data have undergone data cleansing to ensure they have data quality, that is, that they are both correct and useful. It uses routines, often called \"validation rules\", that check for correctness, meaningfulness, and security of data that are input to the system.'', ''VALIDATE'', 1);
INSERT INTO is2.is2_business_function VALUES (4, ''ARC'', ''File loader workbench'', ''ARC'', 1);


--
-- TOC entry 4911 (class 0 OID 25166)
-- Dependencies: 232
-- Data for Name: is2_business_process; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_business_process VALUES (1, ''Probabilistic Record Linkage'', ''Probabilistic Record Linkage'', ''PRL'', 1, NULL);
INSERT INTO is2.is2_business_process VALUES (2, ''Deterministic Record Linkage'', ''Deterministic Record Linkage'', ''DRL'', 2, NULL);
INSERT INTO is2.is2_business_process VALUES (3, ''R data validation'', ''R data validation'', ''ValidateR'', 1, NULL);
INSERT INTO is2.is2_business_process VALUES (4, ''Data validation Van der Loo'', ''Data validation Van der Loo'', ''VanDerLoo'', 1, 3);
INSERT INTO is2.is2_business_process VALUES (70, ''Contingency Table'', ''Calculate contingency table'', ''CrossTable'', 1, 1);
INSERT INTO is2.is2_business_process VALUES (71, ''Fellegi Sunter'', ''Fellegi Sunter algorithm'', ''FellegiSunter'', 2, 1);
INSERT INTO is2.is2_business_process VALUES (72, ''Matching Table'', ''Matching records'', ''MatchingTable'', 3, 1);
INSERT INTO is2.is2_business_process VALUES (9, ''FILE LOADER WORKBENCH'', ''FILE LOADER WORKBENCH '', ''PARC'', 1, NULL);
INSERT INTO is2.is2_business_process VALUES (92, ''STRUCTURIZE'', ''STRUCTURIZE '', ''PARC-02'', 3, 9);
INSERT INTO is2.is2_business_process VALUES (93, ''CONTROL'', ''CONTROL '', ''PARC-03'', 4, 9);
INSERT INTO is2.is2_business_process VALUES (94, ''FILTER'', ''FILTER '', ''PARC-04'', 5, 9);
INSERT INTO is2.is2_business_process VALUES (91, ''LOAD'', ''LOAD '', ''PARC-01'', 2, 9);
INSERT INTO is2.is2_business_process VALUES (95, ''MAP'', ''MAP '', ''PARC-05'', 6, 9);


--
-- TOC entry 4913 (class 0 OID 25174)
-- Dependencies: 234
-- Data for Name: is2_business_service; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_business_service VALUES (200, ''Relais'', ''Record Linkage at Istat'');
INSERT INTO is2.is2_business_service VALUES (300, ''Validate'', ''R Data Validation'');
INSERT INTO is2.is2_business_service VALUES (91, ''ARC loader'', ''ARC file loader INSEE'');


--
-- TOC entry 4964 (class 0 OID 32768)
-- Dependencies: 347
-- Data for Name: is2_business_service_sav; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_business_service_sav VALUES (200, ''Relais'', ''Record Linkage at Istat'');
INSERT INTO is2.is2_business_service_sav VALUES (300, ''Validate'', ''R Data Validation'');
INSERT INTO is2.is2_business_service_sav VALUES (91, ''LOAD'', ''LOAD '');
INSERT INTO is2.is2_business_service_sav VALUES (92, ''STRUCTURIZE'', ''STRUCTURIZE '');
INSERT INTO is2.is2_business_service_sav VALUES (93, ''CONTROL'', ''CONTROL '');
INSERT INTO is2.is2_business_service_sav VALUES (94, ''FILTER'', ''FILTER '');
INSERT INTO is2.is2_business_service_sav VALUES (95, ''MAP'', ''MAP '');


--
-- TOC entry 4915 (class 0 OID 25182)
-- Dependencies: 236
-- Data for Name: is2_cls_data_type; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_data_type VALUES (1, ''VARIABLE'', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (2, ''PARAMETER'', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (3, ''DATASET'', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (4, ''RULESET'', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (5, ''RULE'', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (6, ''MODEL'', NULL);


--
-- TOC entry 4917 (class 0 OID 25190)
-- Dependencies: 238
-- Data for Name: is2_cls_rule; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_rule VALUES (1, ''Dominio'', ''Definisce i valori o le modalità ammissibili della variabile'', ''Può comprendere missing e/o zero; distinguere tra variabile qualitativa e quantitativa'');
INSERT INTO is2.is2_cls_rule VALUES (2, ''Coerenza logica'', ''Definisce le combinazioni ammissibili di valori e/o modalità tra due o più variabili '', ''Prevalentemente per  variabli qualitative, anche se la regola può riguardare entrambe le tipologie di variabili (es. ETA(0-15) STACIV(coniugato) con ETA fissa)'');
INSERT INTO is2.is2_cls_rule VALUES (3, ''Quadratura'', ''Definisce l''''uguaglianza ammissibile tra la somma di due o più variabili quantitative e il totale corrispondente (che può essere noto a priori o a sua volta ottenuto dalla somma di altre variabili del dataset)'', ''Solo variabili quantitative'');
INSERT INTO is2.is2_cls_rule VALUES (4, ''Disuguaglianza forma semplice'', ''Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due variabili quantitative'', ''Solo variabili quantitative'');
INSERT INTO is2.is2_cls_rule VALUES (5, ''Disuguaglianza forma composta'', ''Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due quantità, dove ciascuna quantità può essere costituita da una sola variabile X o dalla somma/differenza/prodotto tra due o più variabili X'', ''Solo variabili quantitative'');
INSERT INTO is2.is2_cls_rule VALUES (6, ''Validazione/Completezza'', ''Verifica in base alle regole di compilazione del questionario che i dati siano stati immessi correttamente'', ''Distinguere tra variabile qualitativa e quantitativa'');
INSERT INTO is2.is2_cls_rule VALUES (7, ''Editing'', NULL, ''Valore di default al caricamento del file'');


--
-- TOC entry 4919 (class 0 OID 25198)
-- Dependencies: 240
-- Data for Name: is2_cls_statistical_variable; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_statistical_variable VALUES (1, NULL, ''Variabili identificative delle unità'', 8, 1, ''VARIABILI IDENTIFICATIVE DELLE UNITÀ'', ''UNIT INDENTIFIER'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (2, NULL, ''Variabili statistiche di classificazione'', 1, 2, ''VARIABILI STATISTICHE DI CLASSIFICAZIONE'', ''CLASSIFICATION'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (3, NULL, ''Variabili statistiche numeriche'', 2, 3, ''VARIABILI STATISTICHE NUMERICHE'', ''NUMERIC'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (4, NULL, ''Variabili statistiche testuali'', 3, 4, ''VARIABILI STATISTICHE TESTUALI'', ''TEXTUAL/OPENED'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (5, NULL, ''Concetti relativi al contenuto dei dati'', 6, 5, ''AGGREGATO'', ''AGGREGATE'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (6, NULL, ''Concetti di tipo operativo'', 4, 6, ''CONCETTI DI TIPO OPERATIVO'', ''OPERATIONAL'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (7, NULL, ''Concetti di tipo temporale'', 5, 7, ''CONCETTI DI TIPO TEMPORALE'', ''TEMPORAL'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (8, NULL, ''Concetti relativi alla frequenza'', 7, 8, ''CONCETTI RELATIVI ALLA FREQUENZA'', ''FREQUENCY'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (9, NULL, ''Concetti usati per identificare il peso campionario'', 10, 9, ''PESO'', ''PESO'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (10, NULL, ''Paradati ..'', 12, 10, ''PARADATO'', ''PARADATA'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (11, NULL, ''Variabili statistiche composte'', 11, 11, ''CONCETTI IDENTIFICATIVI DEL DATASET'', ''DATASET IDENTIFIER'');
INSERT INTO is2.is2_cls_statistical_variable VALUES (12, NULL, ''Variabili non definite'', 9, 12, ''NON DEFINITA'', ''UNDEFINED'');


--
-- TOC entry 4921 (class 0 OID 25206)
-- Dependencies: 242
-- Data for Name: is2_cls_type_io; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_type_io VALUES (1, ''INPUT'');
INSERT INTO is2.is2_cls_type_io VALUES (2, ''OUTPUT'');
INSERT INTO is2.is2_cls_type_io VALUES (3, ''INPUT_OUTPUT'');


--
-- TOC entry 4923 (class 0 OID 25211)
-- Dependencies: 244
-- Data for Name: is2_data_bridge; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4925 (class 0 OID 25216)
-- Dependencies: 246
-- Data for Name: is2_data_processing; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_data_processing VALUES (3, ''Test RL'', '''', ''2019-12-18 11:20:57.493'', 1, 2);
INSERT INTO is2.is2_data_processing VALUES (4, ''Test ARC'', '''', ''2019-12-18 17:41:32.883'', 9, 3);


--
-- TOC entry 4927 (class 0 OID 25224)
-- Dependencies: 248
-- Data for Name: is2_dataset_column; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_dataset_column VALUES (8, ''DS'', 0, ''["A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A"]'', 449, 2, NULL);
INSERT INTO is2.is2_dataset_column VALUES (9, ''IDENTIFIER'', 1, ''["ID4447124106922810001","ID4447124106922810003","ID4447124106922810004","ID4447124106922810002","ID4447124106881610001","ID4447124106879010001","ID4447124106879010003","ID4447124106879010002","ID4447124106897210001","ID4447124106897210002","ID4447124106897210003","ID4447124106897210004","ID4447124106897210005","ID4447124106923610001","ID4447124106923610002","ID4447124106923610003","ID4447124106894910001","ID4447124106894910002","ID4447124106920210001","ID4447124106920210002","ID4447124106912910004","ID4447124106912910001","ID4447124106912910003","ID4447124106912910002","ID4447124106912910005","ID4447124106899810001","ID4447124106899810002","ID4447124106915210001","ID4447124106909510001","ID4447124106909510002","ID4447124106909510003","ID4447124106877410001","ID4447124106883210001","ID4447124106883210002","ID4447124106874110001","ID4447124106908710003","ID4447124106908710001","ID4447124106908710002","ID4447124106892310001","ID4447124106892310002","ID4447124106913710002","ID4447124106913710003","ID4447124106913710004","ID4447124106913710005","ID4447124106913710001","ID4447124106917810001","ID4447124106917810002","ID4447124106906110001","ID4447124106906110002","ID4447124106916010001","ID4447124106910310001","ID4447124106910310003","ID4447124106910310002","ID4447124106885710001","ID4447124258794710001","ID4447124258795410001","ID4447124106924410001","ID4447124106911110002","ID4447124106911110001","ID4447124106875810001","ID4447124106875810002","ID4447124106876610001","ID4447124106876610002","ID4447124106907910001","ID4447124106887310002","ID4447124106887310003","ID4447124106887310001","ID4447124106905310002","ID4447124106905310001","ID4447124106925120002","ID4447124106890710001","ID4447124106890710004","ID4447124106890710002","ID4447124106890710003","ID4447124106890710005","ID4447124106890710006","ID4447124106891510001","ID4447124106919410002","ID4447124106886510001","ID4447124106886510002","ID4447124106882410001","ID4447124106882410002","ID4447124106896410001","ID4447124106898010001","ID4447124106898010002","ID4447124106889910001","ID4447124106889910002","ID4447124106904610001","ID4447124106904610002","ID4447124106880810001","ID4447124106880810002","ID4447124106880810003","ID4447124106900410001","ID4447124106921010002","ID4447124106921010001","ID4447124106914510001","ID4447124106914510002","ID4448125110715010004","ID4448125110715010005","ID4448125110715010001","ID4448125110715010002","ID4448125110715010003","ID4448125110796010002","ID4448125110796010001","ID4448125110797810002","ID4448125110797810003","ID4448125110797810001","ID4448125110798610004","ID4448125110798610001","ID4448125110798610002","ID4448125110798610003","ID4448125110699610001","ID4448125110699610002","ID4448125110699610003","ID4448125110795210001","ID4448125110801810002","ID4448125110801810001","ID4448125110800010001","ID4448125110811710001","ID4448125110714310002","ID4448125110714310003","ID4448125110714310001","ID4448125110698810002","ID4448125110698810001","ID4448125110818210001","ID4448125110805910001","ID4448125110819010001","ID4448125110819010002","ID4448125110819010003","ID4448125110819010004","ID4448125110705110002","ID4448125110705110001","ID4448125110816610003","ID4448125110816610004","ID4448125110816610005","ID4448125110816610001","ID4448125110816610002","ID4448125110808310002","ID4448125110808310003","ID4448125110808310004","ID4448125110808310001","ID4448125110808310005","ID4448125110822410001","ID4448125110822410002","ID4448125110822410004","ID4448125110822410003","ID4448125110815810005","ID4448125110815810001","ID4448125110815810003","ID4448125110815810004","ID4448125110817410001","ID4448125110702810002","ID4448125110702810003","ID4448125110702810004","ID4448125110702810001","ID4448125110701010004","ID4448125110701010006","ID4448125110701010001","ID4448125110701010002","ID4448125110701010003","ID4448125110701010005","ID4448125110807510001","ID4448125110820810001","ID4448125110803410002","ID4448125110803410003","ID4448125110803410001","ID4448125110803410004","ID4448125110804210001","ID4448125110821610001","ID4448125110821610002","ID4448125110821610003","ID4448125110802610002","ID4448125110802610001","ID4448125110802610003","ID4448125110802610004","ID4450127238368310004","ID4450127238368310001","ID4450127238368310003","ID4450127238368310005","ID4450127238368310002","ID4450127238387310002","ID4450127238387310003","ID4450127238387310001","ID4450127238383210002","ID4450127238383210001","ID4450127238383210004","ID4450127238383210005","ID4450127238376610001","ID4450127238376610003","ID4450127238376610002","ID4450127238404610002","ID4450127238404610001","ID4450127238379010003","ID4450127238379010004","ID4450127238379010001","ID4450127238379010002","ID4450127238398010001","ID4450127238398010002","ID4450127238358410001","ID4450127238350110001","ID4450127238350110002","ID4450127238362610001","ID4450127238362610002","ID4450127238399810001","ID4450127238399810002","ID4450127238399810003","ID4450127238399810004","ID4450127238359210001","ID4450127238359210002","ID4450127238389910001","ID4450127238389910002","ID4450127238389910003","ID4450127238354310001","ID4450127238354310003","ID4450127238354310002","ID4450127238378210004","ID4450127238378210001","ID4450127238378210002","ID4450127238378210003","ID4450127238355010001","ID4450127238355010002","ID4450127238381610002","ID4450127238381610003","ID4450127238381610001","ID4450127238381610004","ID4450127238406110001","ID4450127238360010001","ID4450127238360010002","ID4450127238349310001","ID4450127238349310002","ID4450127238349310003","ID4450127238352710002","ID4450127238352710003","ID4450127238352710001","ID4450127238384010001","ID4450127238384010002","ID4450127238384010003","ID4450127238384010004","ID4450127238384010005","ID4450127238365910002","ID4450127238374110002","ID4450127238374110003","ID4450127238374110001","ID4450127238405310002","ID4450127238405310001","ID4450127238385710001","ID4450127238385710003","ID4450127238385710002","ID4450127238375810001","ID4450127238397210001","ID4450127238397210003","ID4450127238397210002","ID4450127238397210004","ID4450127238372510001","ID4450127238388110002","ID4450127238388110001","ID4450127238394910003","ID4450127238394910004","ID4450127238394910001","ID4450127238394910002","ID4450127238395610001","ID4450127238395610002","ID4450127238391510002","ID4450127238391510001","ID4450127238386510001","ID4450127238386510002","ID4450127238386510003","ID4450127238364210001","ID4450127238364210002","ID4450127238409510001","ID4450127238409510002","ID4450127238409510003","ID4450127238403810002","ID4450127238403810001","ID4450127257775510002","ID4450127257775510001","ID4450127238348510001","ID4450127238367510001","ID4450127238357610001","ID4450127238357610002","ID4450127238396410001","ID4450127238377410001","ID4450127238377410003","ID4450127238377410002","ID4450127238407910002","ID4450127238407910001","ID4450127238401210003","ID4450127238401210001","ID4450127238401210002","ID4450127238361810002","ID4450127238361810004","ID4450127238361810001","ID4450127238361810003","ID4450127238361810005","ID4450127238371710001","ID4450127238371710002","ID4450127238369110001","ID4450127238393110002","ID4450127238393110003","ID4450127238393110001","ID4450127238353510002","ID4450127238353510003","ID4450127238353510001","ID4450127238353510004","ID4450127238366710001","ID4450127238366710002","ID4450127238382410004","ID4450127238382410005","ID4450127238382410001","ID4450127238382410002","ID4450127238382410003","ID4450127238400410001","ID4450127238356810001","ID4450127238356810002","ID4450127238356810003","ID4450127238380810001","ID4450127238380810003","ID4450127238380810004","ID4450127238380810002","ID4450127238370910001","ID4445112314664910001","ID4445112314670610001","ID4445112314670610002","ID4445113314679710001","ID4445113314682110001","ID4445113314682110002","ID4445113314680510001","ID4445113314680510003","ID4445113314680510004","ID4445113314680510002","ID4445113314680510005","ID4445113314680510006","ID4445113314675510001","ID4445113314675510002","ID4445113314675510003","ID4445113314674810001","ID4445113314674810002","ID4445113314674810003","ID4445113314674810005","ID4445113314674810004","ID4445113314681310001","ID4445113314681310003","ID4445113314681310002","ID4445113314681310004","ID4445113314681310005","ID4445113314681310006","ID4445112314672210001","ID4445112314672210003","ID4445112314672210002","ID4445112314666410001","ID4445112314666410002","ID4445113314673010001","ID4445113314673010003","ID4445113314673010004","ID4445113314673010005","ID4445113314673010002","ID4445113314676310001","ID4445113314676310002","ID4445113314676310003","ID4445112314667210001","ID4445112314667210003","ID4445112314667210005","ID4445112314667210006","ID4445112314667210002","ID4445112314667210004","ID4445112314671410001","ID4445112314671410004","ID4445112314671410002","ID4445112314671410003","ID4445113314678910001","ID4445113314678910002","ID4445112314665610001","ID4445112314665610002","ID4445113314677110001","ID4445113314677110002","ID4445113314677110004","ID4445113314677110003","ID4449126128949510001","ID4449126128949510002","ID4449126128933910001","ID4449126128933910003","ID4449126128933910002","ID4449126128936210001","ID4449126128936210004","ID4449126128936210002","ID4449126128936210003","ID4449126128947910001","ID4449126128947910003","ID4449126128947910002","ID4449126128938810001","ID4449126128938810003","ID4449126128938810002","ID4449126128938810004","ID4449126128942010001","ID4449126128942010002","ID4449126128942010003","ID4449126128942010004","ID4449126128948710001","ID4449126128948710003","ID4449126128948710002","ID4449126128939610001","ID4449126128939610002","ID4449126128944610002","ID4449126128944610001","ID4449126128929710001","ID4449126128929710002","ID4449126128929710003","ID4449126128929710004","ID4449126128932110001","ID4449126128932110002","ID4449126128932110003","ID4449126128932110004","ID4449126128932110005","ID4449126128925510001","ID4449126128925510002","ID4449126128943810001","ID4449126128943810002","ID4449126128943810003","ID4449126128926310001","ID4449126128926310002","ID4449126128940410001","ID4449126128940410002","ID4449126128928910001","ID4449126128928910002","ID4449126128935410001","ID4449126128934710001","ID4449126128934710002","ID4449126128934710003","ID4449126128934710004","ID4449126128931310001","ID4449126128931310002","ID4449126128946110001","ID4449126128946110002","ID4449126128930510001","ID4449126128930510005","ID4449126128930510002","ID4449126128930510003","ID4449126128930510004","ID4449126128941210001","ID4449126128941210002","ID4449126128950310001","ID4449126128950310002","ID4449126128927110001","ID4449126128927110003","ID4449126128927110002","ID4449126128937010001","ID4449126128937010002","ID4449126128945310001","ID4449126128945310002"]'', 449, 2, NULL);
INSERT INTO is2.is2_dataset_column VALUES (10, ''SURNAME'', 2, ''["ANDERSON","ANDERSON","ANDERSON","ANDERSON","AQUENDO","BENITEZ","BENITEZ","BENITEZ","BODNER","BODNER","BODNER","BODNER","BODNER","CENTURY","CENTURY","CENTURY","CHEESMAN","CHEESMAN","CONYERE","CONYERE","COSGRAVE","COSGRAVE","COSGRAVE","COSGRAVE","COSGRAVE","DANIEL LEIVA","DANIEL LEIVA","DARCOURT","DECANAY","DECANAY","DECANAY","DIVERS","DOMINGUEZ","DOMINGUEZ","FAUST","FISCHGRUND","FISCHGRUND","FISCHGRUND","GENE","GENE","GIERINGER","GIERINGER","GIERINGER","GIERINGER","GIERINGER","GREEN","GREEN","HENNEGGEY","HENNEGGEY","HILL","JIMENCZ","JIMENCZ","JIMENCZ","JIMENEZ","KAY","KELLY","KILLION","LAKATOS","LAKATOS","LASSITER","LASSITER","LASSITER","LASSITER","LETO","MALDONADO","MALDONADO","MALDONADO","MALENDES","MALENDES","MCCLAIN","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","PAIGIE","PARVA","PARVA","RODRIGUEZ","RODRIGUEZ","ROUNSEVELLE","SKANOS","SKANOS","TORRES","TORRES","VALDES","VALDES","VARGAS","VARGAS","VARGAS","VARGAS","WEBSTER","WEBSTER","WICZALKOWSKI","WICZALKOWSKI","BANK","BANK","BANK","BANK","BANK","BARNES","BARNES","BURGERSS","BURGERSS","BURGERSS","BURGESS","BURGESS","BURGESS","BURGESS","BURRISS","BURRISS","BURRISS","BUTLER","CHISOLM","CHISOLM","COATES","CONRON","COTTEN","COTTEN","COTTEN","DIGGS","DIGGS","DORSIE","DUNNOCK","GOINS","GOINS","GOINS","GOINS","GOWANS","GOWANS","HOERRLING","HOERRLING","HOERRLING","HOERRLING","HOERRLING","HOLMES","HOLMES","HOLMES","HOLMES","HOLMES","HUGGINCHES","HUGGINCHES","HUGGINCHES","HUGGINCHES","HUTCHINSON","HUTCHINSON","HUTCHINSON","HUTCHINSON","LEVEN","MATKIN","MATKIN","MATKIN","MATKIN","OWENS","OWENS","OWENS","OWENS","OWENS","OWENS","PAIGE","SPRINGGS","SYKES","SYKES","SYKES","SYKES","THOMPSON","TREZEVANT","TREZEVANT","TREZEVANT","WHITAKER","WHITAKER","WHITAKER","WHITAKER","1RUMOR","1RUMOR","1RUMOR","1RUMOR","1RUMOR","ALSTIN","ALSTIN","ALSTIN","CAMPBELL","CAMPBELL","CAMPBELL","CAMPBELL","CARR","CARR","CARR","CARTER","CARTER","CAVAJEL","CAVAJEL","CAVAJEL","CAVAJEL","CHAMBARS","CHAMBARS","COLBY","COUPE","COUPE","CRIDER","CRIDER","DAVIES","DAVIES","DAVIES","DAVIES","DEGRAENED","DEGRAENED","DORMAN","DORMAN","DORMAN","DOWOKAKOKO","DOWOKAKOKO","DOWOKAKOKO","EASLEY","EASLEY","EASLEY","EASLEY","ELLIOTT","ELLIOTT","ERVINE","ERVINE","ERVINE","ERVINE","FREY","GARRETT","GARRETT","GORDON","GORDON","GORDON","GRANER","GRANER","GRANER","GREENE","GREENE","GREENE","GREENE","GREENE","GUIDETI","HAMMONDS","HAMMONDS","HAMMONDS","HANKINS","HANKINS","HEAVENER","HEAVENER","HEAVENER","HETTERICH","HOLLEY","HOLLEY","HOLLEY","HOLLEY","HUDSON","HUSSEINKHEL","HUSSEINKHEL","KEARNS","KEARNS","KEARNS","KEARNS","KEICHENBERG","KEICHENBERG","KLEIMAN","KLEIMAN","LESKO","LESKO","LESKO","MACCIO","MACCIO","MARTINEZ STG","MARTINEZ STG","MARTINEZ STG","MCALLISTER","MCALLISTER","MOHRING","MOHRING","MOSES","OBROCK","PEARL","PEARL","RAGLIN","REAVES","REAVES","REAVES","RODRIGUEZ","RODRIGUEZ","ROTHSHILD","ROTHSHILD","ROTHSHILD","RUDASILL","RUDASILL","RUDASILL","RUDASILL","RUDASILL","RUEHLING","RUEHLING","RUMOR","RUSSALL","RUSSALL","RUSSALL","SANTIAGO","SANTIAGO","SANTIAGO","SANTIAGO","SQUILLANTE","SQUILLANTE","SWAGOI","SWAGOI","SWAGOI","SWAGOI","SWAGOI","SYKS","TONSTALL","TONSTALL","TONSTALL","WASHINGTON","WASHINGTON","WASHINGTON","WASHINGTON","WIESMAN","BELL","BRAWD","BRAWD","CARTER","DUCOTY","DUCOTY","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","EHM","EHM","EHM","GASBARRO","GASBARRO","GASBARRO","GASBARRO","GASBARRO","HELLER","HELLER","HELLER","HELLER","HELLER","HELLER","HOPPER","HOPPER","HOPPER","HUBRIC","HUBRIC","PAINE WELLS","PAINE WELLS","PAINE WELLS","PAINE WELLS","PAINE WELLS","PENSETH","PENSETH","PENSETH","POLLACK","POLLACK","POLLACK","POLLACK","POLLACK","POLLACK","ROWEN","ROWEN","ROWEN","ROWEN","SAUNDERS","SAUNDERS","SCCHWARTZ","SCCHWARTZ","SMALLS","SMALLS","SMALLS","SMALLS","ARCHER","ARCHER","BELTRAN","BELTRAN","BELTRAN","BELTRAN","BELTRAN","BELTRAN","BELTRAN","CAGER","CAGER","CAGER","COBEZA","COBEZA","COBEZA","COBEZA","DORSEY","DORSEY","DORSEY","DORSEY","DRENMON","DRENMON","DRENMON","FLEEK","FLEEK","FLOWERS","FLOWERS","GALIDEZ","GALIDEZ","GALIDEZ","GALIDEZ","HILLEGAS","HILLEGAS","HILLEGAS","HILLEGAS","HILLEGAS","HOLLOWAY","HOLLOWAY","KEARNEY","KEARNEY","KEARNEY","MANGUM","MANGUM","MITCHELLL","MITCHELLL","RADRIGZ","RADRIGZ","RAMAS","RHODES","RHODES","RHODES","RHODES","RIBERA","RIBERA","RICHARDSON","RICHARDSON","STAPPY","STAPPY","STAPPY","STAPPY","STAPPY","STEWARD","STEWARD","WCIGNT","WCIGNT","WILKES","WILKES","WILKES","WILLIAMS","WILLIAMS","YETES","YETES"]'', 449, 2, NULL);
INSERT INTO is2.is2_dataset_column VALUES (11, ''NAME'', 3, ''["","","","","CLARA","LEARONAD","SAMUEL","DELORES","JAMEL","ROSETTA","MADGE","ROSALIND","CAROLYN","IVAN","RAMON","ALICIA","DONYA","DONTE","DOMINIQUE","CONNIE","SEKOV","TIERRA","THERSA","","","SAMMY","THAOLYNN","","MICHEAL","AJASIA","BRIANCE","MILEORD","FRANKLIN","SHAVON","ANNA","WESTLEY","NADESDIA","DANYCE","MICHAEL","CASSANDRA","GHOLOM","JEFFERY","JEFFERY","DOUGLAS","MAIRE","TEMPESTT","","","","RAYMOND","IRVIN","AUNDERE","WILLPAMINA","BARBARA","","","JORGE","TONYA","DANEILLE","","","DOROTHEA","LELIA","JOSEPH","DEWIGHT","MARQUISE","MABLE","","","","AISHA","ANDREA","ROMINE","TANYA","PRINCETTA","LAKESHIA","HERMEN","XANTHE","JEMES","","TOWANDA","GEARLDINE","DEREK","DAVON","LENORA","RANDOLPH","FREEMAN","WAYNE","THRESA","BRANDEN","ALEXANDER","ELIZABETH","THUYKIM","DANNY","SHALLY","ALEXANDER","DOLORES","","","","","","","","","","","","","","","","","","","","","","LATISHA","","","","","","","","","","","","","","REFUS","CHRISTOPHER","ZACHARY","TRAINA","ANA","GERALDO","FRANCISCO","ERICK","LUCILLE","","","","","","","","","","","","","","","","","","","","","","ROY","","","","","ROSETTA","JACQUELINE","ANA","","","","","","DIWALDO","BERNADINA","TERRAN","ZAKIYA","","LEO","MICHEAL","ROSE","ANTONINO","JESSICA","MARINELA","","DARRYL","BERRY","ROSELINE","RODRICK","JOANNIE","ADMAN","STEPHEN","MALISSA","SARAH","LAWRENCE","EUGENE","","MARKO","","GUILLERMO","MARCO","W","MICHELE","RENEE","SARAH","GERARDO","ALLAN","","","","GREG","A","","MATTHEW","FLORIPE","KERI","NILSA","CHERYL","FLAINE","ALE JARDRO","JUAN","ZIONARA","","ETHNY","SHAWNETT","HARRIET","KRISTY","DIANE","ROSEMARIE","DANIEL","ROBERT","MARJORIE","EDUARDSO","SONDRA","ANN","MICHELE","ROSETA","","JAMES","LENWOOD","TRACEY","STEPHENE","PAYMM","","","","JOHNNY","MICHEAL","DIMON","KATHERINE","CHARLOTTE","JACQUELINE","ARCHIE","","","","","","SUSAN","JUDY","ANTONIO","JOCELYN","CLEARANCE","BEN","","ORESTE","OLIVIA","ERIKA","","","GEOFFREY","JEANETTE","DOMINIQUE","JANICE","SHIRLEG","","","","REYAN","","","","QUENTIN","STEPHANIE","PHILLIP","J","HILLIARD","DOMINIC","SEPTIMIA","KIMBERLY","ALISA","","TRACIE","MELISSA","","MYRIAM","JORGE","LYNNETTE","PELHAM","GEORGE","ANGELA","JESSEE","LUIS","GERAR","CHARLES","ISRAEL","MARY CAROLE","","","KATHERINE","NICHOLE","MARY","HARRIETT","J","STEPHENS","AMAURY","XIOMARA","","GLORIANNE","ALLEN","ANN0","JEAN","DOUGASS","MICLELLE","L","D","BENJAMIN","ALICIA","GERALDENE","NATSHA","JESUS","ETHEL","","PABLOS","LEANNE","ERIN","JO","","DIXION","DOREN","TEGIRA","AGELEON","","","ARISTIDES","CARLOS","ROSEY","CHARLES","DIANE","SIGFREDO","AGEL","OSWALDO","IGNACIO","BARBARA","JEFFREY","THRESA","ANNE","ANDREW E","JAMAR","DARON","SHAWN","MIRIAM","LEAH","CHRISTOPHER","EARNEST","CATHY","ELFRIEDA","NICOLAS","CATHERINE","JOHN","TRICIA","JEFFREY","INGER","","","MARC","JEAN","LAWRENCE","JEFF","SOUTA","ELMER","WILEY","GISELA","RUTH ANN","EDWIN","EARLE","ROSETTA","RONNIE","KENNETH","SHAWN","","ARY","MELISSA","DEBBIE","ENDA","ISSAC","ERNEST","THERESA","JOANNIE","ANNTIONETTE","STANLY","COVNELIA","KEN","ENZELEE","MICHELLE","CHATERAH","GIANNI","JANICE","HAILLE","ROSA","JAMIE","SCOT","JENIFFER","SHANIKA","ASHELY","SHERMISE","ROB","BAKIA","JEROME","DONETTA","JOSH","RUGY","SONJA","JEFF","HENRIETTE","JANNIE","JOANN","JOHONNY","STUART","EMMETTE","TAMIKA","JEFF","FRANKLIN","ELLA LOUISE","QUAYN","ARLIE","FREDERICK","CHANTEL","BRIAN","MAXICINE","BEN","STEVE","HARRIETTE","CHARLIE","SHERRI","CHANCE","ALFREDRICK"]'', 449, 2, NULL);
INSERT INTO is2.is2_dataset_column VALUES (12, ''LASTCODE'', 4, ''["","","","","J","A","R","R","C","L","R","N","L","R","L","B","L","","S","E","L","","G","L","C","J","R","G","A","M","G","J","K","M","N","M","A","L","C","C","W","W","W","D","T","Z","L","L","L","G","V","V","S","M","","","L","M","S","J","","K","","E","B","","","","A","","C","G","O","O","D","O","M","N","V","G","S","","","B","S","E","R","H","","R","R","L","","A","","J","A","D","","A","P","P","B","C","L","D","L","L","E","C","D","A","","","","A","J","","D","C","R","A","A","A","A","M","L","T","R","","D","M","D","D","B","A","C","S","D","D","W","","R","R","A","M","","","","","M","L","L","","","L","G","E","T","N","S","","","","","","","","M","M","T","F","C","M","T","A","","L","A","A","E","","","E","A","E","D","B","J","D","","","L","D","L","L","","F","J","","P","E","M","U","N","M","N","D","R","W","R","N","S","A","A","","D","D","D","","A","A","E","T","E","B","R","R","L","M","","","R","A","A","C","A","M","A","D","C","M","R","","T","R","R","V","","T","T","A","E","","","","A","","E","M","L","A","B","V","","","","S","E","M","","","M","M","B","M","","G","","C","","B","J","D","R","R","","L","E","A","E","L","M","S","D","A","A","S","L","C","","L","E","T","A","","A","M","T","B","C","M","L","C","J","P","I","P","E","V","M","J","D","B","S","C","A","J","M","","L","M","A","J","M","U","","K","","A","J","J","J","M","J","A","C","C","B","P","","J","J","J","J","C","J","A","A","","F","S","P","J","A","J","A","","C","G","L","F","E","P","B","J","A","C","A","C","J","M","A","A","M","M","M","M","J","","R","E","M","S","J","M","L","F","R","A","","","J","M","E","E","M","M","E","","E","C","E","C","T","E","E","J","J","E","J","M","D","E","K","L","","M","N","U","K","E","R","F","E","F","B","A","A","A","","H","W","M","L","A","V","E","S"]'', 449, 2, NULL);
INSERT INTO is2.is2_dataset_column VALUES (13, ''NUMCODE'', 5, ''["4848","4848","4848","4848","666","660","660","660","102","102","102","102","102","4906","4906","4906","690","690","4836","4836","202","202","202","202","202","729","729","4802","112","112","112","658","672","672","652","110","110","110","686","686","200","200","200","200","200","4816","4816","102","102","4810","214","214","214","674","4926","4932","4914","206","206","654","654","656","656","104","678","678","678","705","705","4920","682","682","682","682","682","682","684","4830","676","676","670","670","100","104","104","680","680","723","723","664","664","664","727","4842","4842","210","210","6540","6540","6540","6540","6540","6550","6550","6556","6556","6556","6560","6560","6560","6560","6500","6500","6500","6546","6578","6578","6566","110","6526","6526","6526","4952","4952","117","953","115","115","115","115","6520","6520","114","114","114","114","114","108","108","108","108","108","109","109","109","109","112","112","112","112","957","6514","6514","6514","6514","6508","6508","6508","6508","6508","6508","106","113","4901","4901","4901","4901","6532","111","111","111","4913","4913","4913","4913","3820","3820","3820","3820","3820","612","612","612","604","604","604","604","501","501","501","14135","14135","607","607","607","607","14180","14180","303","104","104","106","106","14220","14220","14220","14220","128","128","616","616","616","103","103","103","613","613","613","613","102","102","601","601","601","601","14225","124","124","303","303","303","100","100","100","606","606","606","606","606","3454","505","505","505","14215","14215","608","608","608","503","14170","14170","14170","14170","3886","614","614","626","626","626","626","14150","14150","622","622","610","610","610","106","106","14255","14255","14255","14270","14270","701","701","305","3732","209","209","14160","625","625","625","14235","14235","14240","14240","14240","122","122","122","122","122","3870","3870","3840","624","624","624","101","101","101","101","3556","3556","600","600","600","600","600","14230","201","201","201","603","603","603","603","3850","7111","7126","7126","410","7134","7134","400","400","400","400","400","400","419","419","419","401","401","401","401","401","318","318","318","318","318","318","7100","7100","7100","7127","7127","231","231","231","231","231","427","427","427","7139","7139","7139","7139","7139","7139","7112","7112","7112","7112","430","430","7121","7121","441","441","441","441","309","309","108","108","108","114","114","114","114","313","313","313","512","512","512","512","503","503","503","503","311","311","311","514","514","405","405","100","100","100","100","106","106","106","106","106","107","107","501","501","501","105","105","509","509","101","101","112","110","110","110","110","104","104","315","315","102","102","102","102","102","505","505","307","307","103","103","103","510","510","403","403"]'', 449, 2, NULL);
INSERT INTO is2.is2_dataset_column VALUES (14, ''STREET'', 6, ''["BASSWOOD","BASSWOOD","BASSWOOD","BASSWOOD","STARKEY ","STARKEY ","STARKEY ","STARKEY ","BANK","BANK","BANK","BANK","BANK","BASSWOOD","BASSWOOD","BASSWOOD","STARKEY ","STARKEY ","BASSWOOD","BASSWOOD","BANK","BANK","BANK","BANK","BANK","RIDLEY","RIDLEY","BASSWOOD","MITCHELL","MITCHELL","MITCHELL","STARKEY ","STARKEY ","STARKEY ","STARKEY ","MITCHELL","MITCHELL","MITCHELL","STARKEY ","STARKEY ","BANK","BANK","BANK","BANK","BANK","BASSWOOD","BASSWOOD","MITCHELL","MITCHELL","BASSWOOD","BANK","BANK","BANK","STARKEY ","BASSWOOD","BASSWOOD","BASSWOOD","BANK","BANK","STARKEY ","STARKEY ","STARKEY ","STARKEY ","MITCHELL","STARKEY ","STARKEY ","STARKEY ","RIDLEY","RIDLEY","BASSWOOD","STARKEY ","STARKEY ","STARKEY ","STARKEY ","STARKEY ","STARKEY ","STARKEY ","BASSWOOD","STARKEY ","STARKEY ","STARKEY ","STARKEY ","BANK","BANK","BANK","STARKEY ","STARKEY ","RIDLEY","RIDLEY","STARKEY ","STARKEY ","STARKEY ","RIDLEY","BASSWOOD","BASSWOOD","BANK","BANK","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","ELDORADO","MALIBU","MALIBU","MALIBU","BASSWOOD","BASSWOOD","ELDORADO","CARL VINSON ","ELDORADO","ELDORADO","ELDORADO","ELDORADO","MALIBU","MALIBU","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","CARL VINSON ","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","ELDORADO","ELDORADO","MONTEGO ","MONTEGO ","MONTEGO ","MONTEGO ","MALIBU","ELDORADO","ELDORADO","ELDORADO","MONTEGO ","MONTEGO ","MONTEGO ","MONTEGO ","HWY 54","HWY 54","HWY 54","HWY 54","HWY 54","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","RUBY","RUBY","RUBY","22ND","22ND","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","22ND","22ND","MAIN","GEORGE","GEORGE","WARE","WARE","22ND","22ND","22ND","22ND","WARE","WARE","OCONEE","OCONEE","OCONEE","JOHNSON ","JOHNSON ","JOHNSON ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","CHURCH","CHURCH","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","22ND","WARE","WARE","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","GEORGE","GEORGE","GEORGE","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","HWY 54","RUBY","RUBY","RUBY","22ND","22ND","OCONEE","OCONEE","OCONEE","RUBY","22ND","22ND","22ND","22ND","HWY 54","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","22ND","22ND","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","WARE","WARE","22ND","22ND","22ND","22ND","22ND","31ST","31ST","WOODHAVEN ","HWY 54","MAIN","MAIN","22ND","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","22ND","22ND","22ND","22ND","22ND","WARE","WARE","WARE","WARE","WARE","HWY 54","HWY 54","HWY 54","OCONEE","OCONEE","OCONEE","JOHNSON ","JOHNSON ","JOHNSON ","JOHNSON ","HWY 54","HWY 54","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","22ND","MAIN","MAIN","MAIN","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","HWY 54","3RD ","2ND ","2ND ","72ND","3RD ","3RD ","72ND","72ND","72ND","72ND","72ND","72ND","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","72ND","72ND","72ND","72ND","72ND","72ND","2ND ","2ND ","2ND ","3RD ","3RD ","71ST","71ST","71ST","71ST","71ST","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","3RD ","3RD ","3RD ","3RD ","3RD ","3RD ","2ND ","2ND ","2ND ","2ND ","72ND","72ND","3RD ","3RD ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","WOODHAVEN ","WOODHAVEN ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","ELDORADO","ELDORADO","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","ELDORADO","ELDORADO","WOODHAVEN ","WOODHAVEN ","ELDORADO","ELDORADO","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","WOODHAVEN ","WOODHAVEN ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","ELDORADO","ELDORADO","ELDORADO","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN "]'', 449, 2, NULL);
INSERT INTO is2.is2_dataset_column VALUES (15, ''DS'', 0, ''["A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A"]'', 449, 3, NULL);
INSERT INTO is2.is2_dataset_column VALUES (16, ''IDENTIFIER'', 1, ''["ID4447124106922810001","ID4447124106922810003","ID4447124106922810004","ID4447124106922810002","ID4447124106881610001","ID4447124106879010001","ID4447124106879010003","ID4447124106879010002","ID4447124106897210001","ID4447124106897210002","ID4447124106897210003","ID4447124106897210004","ID4447124106897210005","ID4447124106923610001","ID4447124106923610002","ID4447124106923610003","ID4447124106894910001","ID4447124106894910002","ID4447124106920210001","ID4447124106920210002","ID4447124106912910004","ID4447124106912910001","ID4447124106912910003","ID4447124106912910002","ID4447124106912910005","ID4447124106899810001","ID4447124106899810002","ID4447124106915210001","ID4447124106909510001","ID4447124106909510002","ID4447124106909510003","ID4447124106877410001","ID4447124106883210001","ID4447124106883210002","ID4447124106874110001","ID4447124106908710003","ID4447124106908710001","ID4447124106908710002","ID4447124106892310001","ID4447124106892310002","ID4447124106913710002","ID4447124106913710003","ID4447124106913710004","ID4447124106913710005","ID4447124106913710001","ID4447124106917810001","ID4447124106917810002","ID4447124106906110001","ID4447124106906110002","ID4447124106916010001","ID4447124106910310001","ID4447124106910310003","ID4447124106910310002","ID4447124106885710001","ID4447124258794710001","ID4447124258795410001","ID4447124106924410001","ID4447124106911110002","ID4447124106911110001","ID4447124106875810001","ID4447124106875810002","ID4447124106876610001","ID4447124106876610002","ID4447124106907910001","ID4447124106887310002","ID4447124106887310003","ID4447124106887310001","ID4447124106905310002","ID4447124106905310001","ID4447124106925120002","ID4447124106890710001","ID4447124106890710004","ID4447124106890710002","ID4447124106890710003","ID4447124106890710005","ID4447124106890710006","ID4447124106891510001","ID4447124106919410002","ID4447124106886510001","ID4447124106886510002","ID4447124106882410001","ID4447124106882410002","ID4447124106896410001","ID4447124106898010001","ID4447124106898010002","ID4447124106889910001","ID4447124106889910002","ID4447124106904610001","ID4447124106904610002","ID4447124106880810001","ID4447124106880810002","ID4447124106880810003","ID4447124106900410001","ID4447124106921010002","ID4447124106921010001","ID4447124106914510001","ID4447124106914510002","ID4448125110715010004","ID4448125110715010005","ID4448125110715010001","ID4448125110715010002","ID4448125110715010003","ID4448125110796010002","ID4448125110796010001","ID4448125110797810002","ID4448125110797810003","ID4448125110797810001","ID4448125110798610004","ID4448125110798610001","ID4448125110798610002","ID4448125110798610003","ID4448125110699610001","ID4448125110699610002","ID4448125110699610003","ID4448125110795210001","ID4448125110801810002","ID4448125110801810001","ID4448125110800010001","ID4448125110811710001","ID4448125110714310002","ID4448125110714310003","ID4448125110714310001","ID4448125110698810002","ID4448125110698810001","ID4448125110818210001","ID4448125110805910001","ID4448125110819010001","ID4448125110819010002","ID4448125110819010003","ID4448125110819010004","ID4448125110705110002","ID4448125110705110001","ID4448125110816610003","ID4448125110816610004","ID4448125110816610005","ID4448125110816610001","ID4448125110816610002","ID4448125110808310002","ID4448125110808310003","ID4448125110808310004","ID4448125110808310001","ID4448125110808310005","ID4448125110822410001","ID4448125110822410002","ID4448125110822410004","ID4448125110822410003","ID4448125110815810005","ID4448125110815810001","ID4448125110815810003","ID4448125110815810004","ID4448125110817410001","ID4448125110702810002","ID4448125110702810003","ID4448125110702810004","ID4448125110702810001","ID4448125110701010004","ID4448125110701010006","ID4448125110701010001","ID4448125110701010002","ID4448125110701010003","ID4448125110701010005","ID4448125110807510001","ID4448125110820810001","ID4448125110803410002","ID4448125110803410003","ID4448125110803410001","ID4448125110803410004","ID4448125110804210001","ID4448125110821610001","ID4448125110821610002","ID4448125110821610003","ID4448125110802610002","ID4448125110802610001","ID4448125110802610003","ID4448125110802610004","ID4450127238368310004","ID4450127238368310001","ID4450127238368310003","ID4450127238368310005","ID4450127238368310002","ID4450127238387310002","ID4450127238387310003","ID4450127238387310001","ID4450127238383210002","ID4450127238383210001","ID4450127238383210004","ID4450127238383210005","ID4450127238376610001","ID4450127238376610003","ID4450127238376610002","ID4450127238404610002","ID4450127238404610001","ID4450127238379010003","ID4450127238379010004","ID4450127238379010001","ID4450127238379010002","ID4450127238398010001","ID4450127238398010002","ID4450127238358410001","ID4450127238350110001","ID4450127238350110002","ID4450127238362610001","ID4450127238362610002","ID4450127238399810001","ID4450127238399810002","ID4450127238399810003","ID4450127238399810004","ID4450127238359210001","ID4450127238359210002","ID4450127238389910001","ID4450127238389910002","ID4450127238389910003","ID4450127238354310001","ID4450127238354310003","ID4450127238354310002","ID4450127238378210004","ID4450127238378210001","ID4450127238378210002","ID4450127238378210003","ID4450127238355010001","ID4450127238355010002","ID4450127238381610002","ID4450127238381610003","ID4450127238381610001","ID4450127238381610004","ID4450127238406110001","ID4450127238360010001","ID4450127238360010002","ID4450127238349310001","ID4450127238349310002","ID4450127238349310003","ID4450127238352710002","ID4450127238352710003","ID4450127238352710001","ID4450127238384010001","ID4450127238384010002","ID4450127238384010003","ID4450127238384010004","ID4450127238384010005","ID4450127238365910002","ID4450127238374110002","ID4450127238374110003","ID4450127238374110001","ID4450127238405310002","ID4450127238405310001","ID4450127238385710001","ID4450127238385710003","ID4450127238385710002","ID4450127238375810001","ID4450127238397210001","ID4450127238397210003","ID4450127238397210002","ID4450127238397210004","ID4450127238372510001","ID4450127238388110002","ID4450127238388110001","ID4450127238394910003","ID4450127238394910004","ID4450127238394910001","ID4450127238394910002","ID4450127238395610001","ID4450127238395610002","ID4450127238391510002","ID4450127238391510001","ID4450127238386510001","ID4450127238386510002","ID4450127238386510003","ID4450127238364210001","ID4450127238364210002","ID4450127238409510001","ID4450127238409510002","ID4450127238409510003","ID4450127238403810002","ID4450127238403810001","ID4450127257775510002","ID4450127257775510001","ID4450127238348510001","ID4450127238367510001","ID4450127238357610001","ID4450127238357610002","ID4450127238396410001","ID4450127238377410001","ID4450127238377410003","ID4450127238377410002","ID4450127238407910002","ID4450127238407910001","ID4450127238401210003","ID4450127238401210001","ID4450127238401210002","ID4450127238361810002","ID4450127238361810004","ID4450127238361810001","ID4450127238361810003","ID4450127238361810005","ID4450127238371710001","ID4450127238371710002","ID4450127238369110001","ID4450127238393110002","ID4450127238393110003","ID4450127238393110001","ID4450127238353510002","ID4450127238353510003","ID4450127238353510001","ID4450127238353510004","ID4450127238366710001","ID4450127238366710002","ID4450127238382410004","ID4450127238382410005","ID4450127238382410001","ID4450127238382410002","ID4450127238382410003","ID4450127238400410001","ID4450127238356810001","ID4450127238356810002","ID4450127238356810003","ID4450127238380810001","ID4450127238380810003","ID4450127238380810004","ID4450127238380810002","ID4450127238370910001","ID4445112314664910001","ID4445112314670610001","ID4445112314670610002","ID4445113314679710001","ID4445113314682110001","ID4445113314682110002","ID4445113314680510001","ID4445113314680510003","ID4445113314680510004","ID4445113314680510002","ID4445113314680510005","ID4445113314680510006","ID4445113314675510001","ID4445113314675510002","ID4445113314675510003","ID4445113314674810001","ID4445113314674810002","ID4445113314674810003","ID4445113314674810005","ID4445113314674810004","ID4445113314681310001","ID4445113314681310003","ID4445113314681310002","ID4445113314681310004","ID4445113314681310005","ID4445113314681310006","ID4445112314672210001","ID4445112314672210003","ID4445112314672210002","ID4445112314666410001","ID4445112314666410002","ID4445113314673010001","ID4445113314673010003","ID4445113314673010004","ID4445113314673010005","ID4445113314673010002","ID4445113314676310001","ID4445113314676310002","ID4445113314676310003","ID4445112314667210001","ID4445112314667210003","ID4445112314667210005","ID4445112314667210006","ID4445112314667210002","ID4445112314667210004","ID4445112314671410001","ID4445112314671410004","ID4445112314671410002","ID4445112314671410003","ID4445113314678910001","ID4445113314678910002","ID4445112314665610001","ID4445112314665610002","ID4445113314677110001","ID4445113314677110002","ID4445113314677110004","ID4445113314677110003","ID4449126128949510001","ID4449126128949510002","ID4449126128933910001","ID4449126128933910003","ID4449126128933910002","ID4449126128936210001","ID4449126128936210004","ID4449126128936210002","ID4449126128936210003","ID4449126128947910001","ID4449126128947910003","ID4449126128947910002","ID4449126128938810001","ID4449126128938810003","ID4449126128938810002","ID4449126128938810004","ID4449126128942010001","ID4449126128942010002","ID4449126128942010003","ID4449126128942010004","ID4449126128948710001","ID4449126128948710003","ID4449126128948710002","ID4449126128939610001","ID4449126128939610002","ID4449126128944610002","ID4449126128944610001","ID4449126128929710001","ID4449126128929710002","ID4449126128929710003","ID4449126128929710004","ID4449126128932110001","ID4449126128932110002","ID4449126128932110003","ID4449126128932110004","ID4449126128932110005","ID4449126128925510001","ID4449126128925510002","ID4449126128943810001","ID4449126128943810002","ID4449126128943810003","ID4449126128926310001","ID4449126128926310002","ID4449126128940410001","ID4449126128940410002","ID4449126128928910001","ID4449126128928910002","ID4449126128935410001","ID4449126128934710001","ID4449126128934710002","ID4449126128934710003","ID4449126128934710004","ID4449126128931310001","ID4449126128931310002","ID4449126128946110001","ID4449126128946110002","ID4449126128930510001","ID4449126128930510005","ID4449126128930510002","ID4449126128930510003","ID4449126128930510004","ID4449126128941210001","ID4449126128941210002","ID4449126128950310001","ID4449126128950310002","ID4449126128927110001","ID4449126128927110003","ID4449126128927110002","ID4449126128937010001","ID4449126128937010002","ID4449126128945310001","ID4449126128945310002"]'', 449, 3, NULL);
INSERT INTO is2.is2_dataset_column VALUES (17, ''SURNAME'', 2, ''["ANDERSON","ANDERSON","ANDERSON","ANDERSON","AQUENDO","BENITEZ","BENITEZ","BENITEZ","BODNER","BODNER","BODNER","BODNER","BODNER","CENTURY","CENTURY","CENTURY","CHEESMAN","CHEESMAN","CONYERE","CONYERE","COSGRAVE","COSGRAVE","COSGRAVE","COSGRAVE","COSGRAVE","DANIEL LEIVA","DANIEL LEIVA","DARCOURT","DECANAY","DECANAY","DECANAY","DIVERS","DOMINGUEZ","DOMINGUEZ","FAUST","FISCHGRUND","FISCHGRUND","FISCHGRUND","GENE","GENE","GIERINGER","GIERINGER","GIERINGER","GIERINGER","GIERINGER","GREEN","GREEN","HENNEGGEY","HENNEGGEY","HILL","JIMENCZ","JIMENCZ","JIMENCZ","JIMENEZ","KAY","KELLY","KILLION","LAKATOS","LAKATOS","LASSITER","LASSITER","LASSITER","LASSITER","LETO","MALDONADO","MALDONADO","MALDONADO","MALENDES","MALENDES","MCCLAIN","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","PAIGIE","PARVA","PARVA","RODRIGUEZ","RODRIGUEZ","ROUNSEVELLE","SKANOS","SKANOS","TORRES","TORRES","VALDES","VALDES","VARGAS","VARGAS","VARGAS","VARGAS","WEBSTER","WEBSTER","WICZALKOWSKI","WICZALKOWSKI","BANK","BANK","BANK","BANK","BANK","BARNES","BARNES","BURGERSS","BURGERSS","BURGERSS","BURGESS","BURGESS","BURGESS","BURGESS","BURRISS","BURRISS","BURRISS","BUTLER","CHISOLM","CHISOLM","COATES","CONRON","COTTEN","COTTEN","COTTEN","DIGGS","DIGGS","DORSIE","DUNNOCK","GOINS","GOINS","GOINS","GOINS","GOWANS","GOWANS","HOERRLING","HOERRLING","HOERRLING","HOERRLING","HOERRLING","HOLMES","HOLMES","HOLMES","HOLMES","HOLMES","HUGGINCHES","HUGGINCHES","HUGGINCHES","HUGGINCHES","HUTCHINSON","HUTCHINSON","HUTCHINSON","HUTCHINSON","LEVEN","MATKIN","MATKIN","MATKIN","MATKIN","OWENS","OWENS","OWENS","OWENS","OWENS","OWENS","PAIGE","SPRINGGS","SYKES","SYKES","SYKES","SYKES","THOMPSON","TREZEVANT","TREZEVANT","TREZEVANT","WHITAKER","WHITAKER","WHITAKER","WHITAKER","1RUMOR","1RUMOR","1RUMOR","1RUMOR","1RUMOR","ALSTIN","ALSTIN","ALSTIN","CAMPBELL","CAMPBELL","CAMPBELL","CAMPBELL","CARR","CARR","CARR","CARTER","CARTER","CAVAJEL","CAVAJEL","CAVAJEL","CAVAJEL","CHAMBARS","CHAMBARS","COLBY","COUPE","COUPE","CRIDER","CRIDER","DAVIES","DAVIES","DAVIES","DAVIES","DEGRAENED","DEGRAENED","DORMAN","DORMAN","DORMAN","DOWOKAKOKO","DOWOKAKOKO","DOWOKAKOKO","EASLEY","EASLEY","EASLEY","EASLEY","ELLIOTT","ELLIOTT","ERVINE","ERVINE","ERVINE","ERVINE","FREY","GARRETT","GARRETT","GORDON","GORDON","GORDON","GRANER","GRANER","GRANER","GREENE","GREENE","GREENE","GREENE","GREENE","GUIDETI","HAMMONDS","HAMMONDS","HAMMONDS","HANKINS","HANKINS","HEAVENER","HEAVENER","HEAVENER","HETTERICH","HOLLEY","HOLLEY","HOLLEY","HOLLEY","HUDSON","HUSSEINKHEL","HUSSEINKHEL","KEARNS","KEARNS","KEARNS","KEARNS","KEICHENBERG","KEICHENBERG","KLEIMAN","KLEIMAN","LESKO","LESKO","LESKO","MACCIO","MACCIO","MARTINEZ STG","MARTINEZ STG","MARTINEZ STG","MCALLISTER","MCALLISTER","MOHRING","MOHRING","MOSES","OBROCK","PEARL","PEARL","RAGLIN","REAVES","REAVES","REAVES","RODRIGUEZ","RODRIGUEZ","ROTHSHILD","ROTHSHILD","ROTHSHILD","RUDASILL","RUDASILL","RUDASILL","RUDASILL","RUDASILL","RUEHLING","RUEHLING","RUMOR","RUSSALL","RUSSALL","RUSSALL","SANTIAGO","SANTIAGO","SANTIAGO","SANTIAGO","SQUILLANTE","SQUILLANTE","SWAGOI","SWAGOI","SWAGOI","SWAGOI","SWAGOI","SYKS","TONSTALL","TONSTALL","TONSTALL","WASHINGTON","WASHINGTON","WASHINGTON","WASHINGTON","WIESMAN","BELL","BRAWD","BRAWD","CARTER","DUCOTY","DUCOTY","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","EHM","EHM","EHM","GASBARRO","GASBARRO","GASBARRO","GASBARRO","GASBARRO","HELLER","HELLER","HELLER","HELLER","HELLER","HELLER","HOPPER","HOPPER","HOPPER","HUBRIC","HUBRIC","PAINE WELLS","PAINE WELLS","PAINE WELLS","PAINE WELLS","PAINE WELLS","PENSETH","PENSETH","PENSETH","POLLACK","POLLACK","POLLACK","POLLACK","POLLACK","POLLACK","ROWEN","ROWEN","ROWEN","ROWEN","SAUNDERS","SAUNDERS","SCCHWARTZ","SCCHWARTZ","SMALLS","SMALLS","SMALLS","SMALLS","ARCHER","ARCHER","BELTRAN","BELTRAN","BELTRAN","BELTRAN","BELTRAN","BELTRAN","BELTRAN","CAGER","CAGER","CAGER","COBEZA","COBEZA","COBEZA","COBEZA","DORSEY","DORSEY","DORSEY","DORSEY","DRENMON","DRENMON","DRENMON","FLEEK","FLEEK","FLOWERS","FLOWERS","GALIDEZ","GALIDEZ","GALIDEZ","GALIDEZ","HILLEGAS","HILLEGAS","HILLEGAS","HILLEGAS","HILLEGAS","HOLLOWAY","HOLLOWAY","KEARNEY","KEARNEY","KEARNEY","MANGUM","MANGUM","MITCHELLL","MITCHELLL","RADRIGZ","RADRIGZ","RAMAS","RHODES","RHODES","RHODES","RHODES","RIBERA","RIBERA","RICHARDSON","RICHARDSON","STAPPY","STAPPY","STAPPY","STAPPY","STAPPY","STEWARD","STEWARD","WCIGNT","WCIGNT","WILKES","WILKES","WILKES","WILLIAMS","WILLIAMS","YETES","YETES"]'', 449, 3, NULL);
INSERT INTO is2.is2_dataset_column VALUES (18, ''NAME'', 3, ''["","","","","CLARA","LEARONAD","SAMUEL","DELORES","JAMEL","ROSETTA","MADGE","ROSALIND","CAROLYN","IVAN","RAMON","ALICIA","DONYA","DONTE","DOMINIQUE","CONNIE","SEKOV","TIERRA","THERSA","","","SAMMY","THAOLYNN","","MICHEAL","AJASIA","BRIANCE","MILEORD","FRANKLIN","SHAVON","ANNA","WESTLEY","NADESDIA","DANYCE","MICHAEL","CASSANDRA","GHOLOM","JEFFERY","JEFFERY","DOUGLAS","MAIRE","TEMPESTT","","","","RAYMOND","IRVIN","AUNDERE","WILLPAMINA","BARBARA","","","JORGE","TONYA","DANEILLE","","","DOROTHEA","LELIA","JOSEPH","DEWIGHT","MARQUISE","MABLE","","","","AISHA","ANDREA","ROMINE","TANYA","PRINCETTA","LAKESHIA","HERMEN","XANTHE","JEMES","","TOWANDA","GEARLDINE","DEREK","DAVON","LENORA","RANDOLPH","FREEMAN","WAYNE","THRESA","BRANDEN","ALEXANDER","ELIZABETH","THUYKIM","DANNY","SHALLY","ALEXANDER","DOLORES","","","","","","","","","","","","","","","","","","","","","","LATISHA","","","","","","","","","","","","","","REFUS","CHRISTOPHER","ZACHARY","TRAINA","ANA","GERALDO","FRANCISCO","ERICK","LUCILLE","","","","","","","","","","","","","","","","","","","","","","ROY","","","","","ROSETTA","JACQUELINE","ANA","","","","","","DIWALDO","BERNADINA","TERRAN","ZAKIYA","","LEO","MICHEAL","ROSE","ANTONINO","JESSICA","MARINELA","","DARRYL","BERRY","ROSELINE","RODRICK","JOANNIE","ADMAN","STEPHEN","MALISSA","SARAH","LAWRENCE","EUGENE","","MARKO","","GUILLERMO","MARCO","W","MICHELE","RENEE","SARAH","GERARDO","ALLAN","","","","GREG","A","","MATTHEW","FLORIPE","KERI","NILSA","CHERYL","FLAINE","ALE JARDRO","JUAN","ZIONARA","","ETHNY","SHAWNETT","HARRIET","KRISTY","DIANE","ROSEMARIE","DANIEL","ROBERT","MARJORIE","EDUARDSO","SONDRA","ANN","MICHELE","ROSETA","","JAMES","LENWOOD","TRACEY","STEPHENE","PAYMM","","","","JOHNNY","MICHEAL","DIMON","KATHERINE","CHARLOTTE","JACQUELINE","ARCHIE","","","","","","SUSAN","JUDY","ANTONIO","JOCELYN","CLEARANCE","BEN","","ORESTE","OLIVIA","ERIKA","","","GEOFFREY","JEANETTE","DOMINIQUE","JANICE","SHIRLEG","","","","REYAN","","","","QUENTIN","STEPHANIE","PHILLIP","J","HILLIARD","DOMINIC","SEPTIMIA","KIMBERLY","ALISA","","TRACIE","MELISSA","","MYRIAM","JORGE","LYNNETTE","PELHAM","GEORGE","ANGELA","JESSEE","LUIS","GERAR","CHARLES","ISRAEL","MARY CAROLE","","","KATHERINE","NICHOLE","MARY","HARRIETT","J","STEPHENS","AMAURY","XIOMARA","","GLORIANNE","ALLEN","ANN0","JEAN","DOUGASS","MICLELLE","L","D","BENJAMIN","ALICIA","GERALDENE","NATSHA","JESUS","ETHEL","","PABLOS","LEANNE","ERIN","JO","","DIXION","DOREN","TEGIRA","AGELEON","","","ARISTIDES","CARLOS","ROSEY","CHARLES","DIANE","SIGFREDO","AGEL","OSWALDO","IGNACIO","BARBARA","JEFFREY","THRESA","ANNE","ANDREW E","JAMAR","DARON","SHAWN","MIRIAM","LEAH","CHRISTOPHER","EARNEST","CATHY","ELFRIEDA","NICOLAS","CATHERINE","JOHN","TRICIA","JEFFREY","INGER","","","MARC","JEAN","LAWRENCE","JEFF","SOUTA","ELMER","WILEY","GISELA","RUTH ANN","EDWIN","EARLE","ROSETTA","RONNIE","KENNETH","SHAWN","","ARY","MELISSA","DEBBIE","ENDA","ISSAC","ERNEST","THERESA","JOANNIE","ANNTIONETTE","STANLY","COVNELIA","KEN","ENZELEE","MICHELLE","CHATERAH","GIANNI","JANICE","HAILLE","ROSA","JAMIE","SCOT","JENIFFER","SHANIKA","ASHELY","SHERMISE","ROB","BAKIA","JEROME","DONETTA","JOSH","RUGY","SONJA","JEFF","HENRIETTE","JANNIE","JOANN","JOHONNY","STUART","EMMETTE","TAMIKA","JEFF","FRANKLIN","ELLA LOUISE","QUAYN","ARLIE","FREDERICK","CHANTEL","BRIAN","MAXICINE","BEN","STEVE","HARRIETTE","CHARLIE","SHERRI","CHANCE","ALFREDRICK"]'', 449, 3, NULL);
INSERT INTO is2.is2_dataset_column VALUES (19, ''LASTCODE'', 4, ''["","","","","J","A","R","R","C","L","R","N","L","R","L","B","L","","S","E","L","","G","L","C","J","R","G","A","M","G","J","K","M","N","M","A","L","C","C","W","W","W","D","T","Z","L","L","L","G","V","V","S","M","","","L","M","S","J","","K","","E","B","","","","A","","C","G","O","O","D","O","M","N","V","G","S","","","B","S","E","R","H","","R","R","L","","A","","J","A","D","","A","P","P","B","C","L","D","L","L","E","C","D","A","","","","A","J","","D","C","R","A","A","A","A","M","L","T","R","","D","M","D","D","B","A","C","S","D","D","W","","R","R","A","M","","","","","M","L","L","","","L","G","E","T","N","S","","","","","","","","M","M","T","F","C","M","T","A","","L","A","A","E","","","E","A","E","D","B","J","D","","","L","D","L","L","","F","J","","P","E","M","U","N","M","N","D","R","W","R","N","S","A","A","","D","D","D","","A","A","E","T","E","B","R","R","L","M","","","R","A","A","C","A","M","A","D","C","M","R","","T","R","R","V","","T","T","A","E","","","","A","","E","M","L","A","B","V","","","","S","E","M","","","M","M","B","M","","G","","C","","B","J","D","R","R","","L","E","A","E","L","M","S","D","A","A","S","L","C","","L","E","T","A","","A","M","T","B","C","M","L","C","J","P","I","P","E","V","M","J","D","B","S","C","A","J","M","","L","M","A","J","M","U","","K","","A","J","J","J","M","J","A","C","C","B","P","","J","J","J","J","C","J","A","A","","F","S","P","J","A","J","A","","C","G","L","F","E","P","B","J","A","C","A","C","J","M","A","A","M","M","M","M","J","","R","E","M","S","J","M","L","F","R","A","","","J","M","E","E","M","M","E","","E","C","E","C","T","E","E","J","J","E","J","M","D","E","K","L","","M","N","U","K","E","R","F","E","F","B","A","A","A","","H","W","M","L","A","V","E","S"]'', 449, 3, NULL);
INSERT INTO is2.is2_dataset_column VALUES (20, ''NUMCODE'', 5, ''["4848","4848","4848","4848","666","660","660","660","102","102","102","102","102","4906","4906","4906","690","690","4836","4836","202","202","202","202","202","729","729","4802","112","112","112","658","672","672","652","110","110","110","686","686","200","200","200","200","200","4816","4816","102","102","4810","214","214","214","674","4926","4932","4914","206","206","654","654","656","656","104","678","678","678","705","705","4920","682","682","682","682","682","682","684","4830","676","676","670","670","100","104","104","680","680","723","723","664","664","664","727","4842","4842","210","210","6540","6540","6540","6540","6540","6550","6550","6556","6556","6556","6560","6560","6560","6560","6500","6500","6500","6546","6578","6578","6566","110","6526","6526","6526","4952","4952","117","953","115","115","115","115","6520","6520","114","114","114","114","114","108","108","108","108","108","109","109","109","109","112","112","112","112","957","6514","6514","6514","6514","6508","6508","6508","6508","6508","6508","106","113","4901","4901","4901","4901","6532","111","111","111","4913","4913","4913","4913","3820","3820","3820","3820","3820","612","612","612","604","604","604","604","501","501","501","14135","14135","607","607","607","607","14180","14180","303","104","104","106","106","14220","14220","14220","14220","128","128","616","616","616","103","103","103","613","613","613","613","102","102","601","601","601","601","14225","124","124","303","303","303","100","100","100","606","606","606","606","606","3454","505","505","505","14215","14215","608","608","608","503","14170","14170","14170","14170","3886","614","614","626","626","626","626","14150","14150","622","622","610","610","610","106","106","14255","14255","14255","14270","14270","701","701","305","3732","209","209","14160","625","625","625","14235","14235","14240","14240","14240","122","122","122","122","122","3870","3870","3840","624","624","624","101","101","101","101","3556","3556","600","600","600","600","600","14230","201","201","201","603","603","603","603","3850","7111","7126","7126","410","7134","7134","400","400","400","400","400","400","419","419","419","401","401","401","401","401","318","318","318","318","318","318","7100","7100","7100","7127","7127","231","231","231","231","231","427","427","427","7139","7139","7139","7139","7139","7139","7112","7112","7112","7112","430","430","7121","7121","441","441","441","441","309","309","108","108","108","114","114","114","114","313","313","313","512","512","512","512","503","503","503","503","311","311","311","514","514","405","405","100","100","100","100","106","106","106","106","106","107","107","501","501","501","105","105","509","509","101","101","112","110","110","110","110","104","104","315","315","102","102","102","102","102","505","505","307","307","103","103","103","510","510","403","403"]'', 449, 3, NULL);
INSERT INTO is2.is2_dataset_column VALUES (21, ''STREET'', 6, ''["BASSWOOD","BASSWOOD","BASSWOOD","BASSWOOD","STARKEY ","STARKEY ","STARKEY ","STARKEY ","BANK","BANK","BANK","BANK","BANK","BASSWOOD","BASSWOOD","BASSWOOD","STARKEY ","STARKEY ","BASSWOOD","BASSWOOD","BANK","BANK","BANK","BANK","BANK","RIDLEY","RIDLEY","BASSWOOD","MITCHELL","MITCHELL","MITCHELL","STARKEY ","STARKEY ","STARKEY ","STARKEY ","MITCHELL","MITCHELL","MITCHELL","STARKEY ","STARKEY ","BANK","BANK","BANK","BANK","BANK","BASSWOOD","BASSWOOD","MITCHELL","MITCHELL","BASSWOOD","BANK","BANK","BANK","STARKEY ","BASSWOOD","BASSWOOD","BASSWOOD","BANK","BANK","STARKEY ","STARKEY ","STARKEY ","STARKEY ","MITCHELL","STARKEY ","STARKEY ","STARKEY ","RIDLEY","RIDLEY","BASSWOOD","STARKEY ","STARKEY ","STARKEY ","STARKEY ","STARKEY ","STARKEY ","STARKEY ","BASSWOOD","STARKEY ","STARKEY ","STARKEY ","STARKEY ","BANK","BANK","BANK","STARKEY ","STARKEY ","RIDLEY","RIDLEY","STARKEY ","STARKEY ","STARKEY ","RIDLEY","BASSWOOD","BASSWOOD","BANK","BANK","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","ELDORADO","MALIBU","MALIBU","MALIBU","BASSWOOD","BASSWOOD","ELDORADO","CARL VINSON ","ELDORADO","ELDORADO","ELDORADO","ELDORADO","MALIBU","MALIBU","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","ELDORADO","CARL VINSON ","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","MALIBU","ELDORADO","ELDORADO","MONTEGO ","MONTEGO ","MONTEGO ","MONTEGO ","MALIBU","ELDORADO","ELDORADO","ELDORADO","MONTEGO ","MONTEGO ","MONTEGO ","MONTEGO ","HWY 54","HWY 54","HWY 54","HWY 54","HWY 54","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","RUBY","RUBY","RUBY","22ND","22ND","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","22ND","22ND","MAIN","GEORGE","GEORGE","WARE","WARE","22ND","22ND","22ND","22ND","WARE","WARE","OCONEE","OCONEE","OCONEE","JOHNSON ","JOHNSON ","JOHNSON ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","CHURCH","CHURCH","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","22ND","WARE","WARE","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","GEORGE","GEORGE","GEORGE","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","HWY 54","RUBY","RUBY","RUBY","22ND","22ND","OCONEE","OCONEE","OCONEE","RUBY","22ND","22ND","22ND","22ND","HWY 54","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","22ND","22ND","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","WARE","WARE","22ND","22ND","22ND","22ND","22ND","31ST","31ST","WOODHAVEN ","HWY 54","MAIN","MAIN","22ND","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","22ND","22ND","22ND","22ND","22ND","WARE","WARE","WARE","WARE","WARE","HWY 54","HWY 54","HWY 54","OCONEE","OCONEE","OCONEE","JOHNSON ","JOHNSON ","JOHNSON ","JOHNSON ","HWY 54","HWY 54","OCONEE","OCONEE","OCONEE","OCONEE","OCONEE","22ND","MAIN","MAIN","MAIN","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","MARTIN LUTHER K ","HWY 54","3RD ","2ND ","2ND ","72ND","3RD ","3RD ","72ND","72ND","72ND","72ND","72ND","72ND","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","72ND","72ND","72ND","72ND","72ND","72ND","2ND ","2ND ","2ND ","3RD ","3RD ","71ST","71ST","71ST","71ST","71ST","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","3RD ","3RD ","3RD ","3RD ","3RD ","3RD ","2ND ","2ND ","2ND ","2ND ","72ND","72ND","3RD ","3RD ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","VILLAGRANDE ","WOODHAVEN ","WOODHAVEN ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","ELDORADO","ELDORADO","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","ELDORADO","ELDORADO","WOODHAVEN ","WOODHAVEN ","ELDORADO","ELDORADO","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","WOODHAVEN ","WOODHAVEN ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","BRANTWOOD ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","ELDORADO","ELDORADO","ELDORADO","WOODHAVEN ","WOODHAVEN ","WOODHAVEN ","WOODHAVEN "]'', 449, 3, NULL);


--
-- TOC entry 4929 (class 0 OID 25232)
-- Dependencies: 250
-- Data for Name: is2_dataset_file; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_dataset_file VALUES (2, ''census_a.txt'', ''DS1'', ''CSV'', '';'', 449, ''2019-12-18 11:20:28.445'', 1, 2);
INSERT INTO is2.is2_dataset_file VALUES (3, ''census_a.txt'', ''DS1'', ''CSV'', '';'', 449, ''2019-12-18 17:41:21.015'', 1, 3);


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
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 11);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 12);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 13);
INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 14);
INSERT INTO is2.is2_link_business_service_app_role VALUES (300, 15);
INSERT INTO is2.is2_link_business_service_app_role VALUES (300, 16);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 910);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 950);


--
-- TOC entry 4966 (class 0 OID 32783)
-- Dependencies: 349
-- Data for Name: is2_link_business_service_app_role_sav; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 1);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 2);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 3);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 4);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 5);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 6);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 7);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 8);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 9);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 10);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 11);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 12);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 13);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (200, 14);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (300, 15);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (300, 16);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (91, 910);
INSERT INTO is2.is2_link_business_service_app_role_sav VALUES (95, 950);


--
-- TOC entry 4932 (class 0 OID 25240)
-- Dependencies: 253
-- Data for Name: is2_link_function_process; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_function_process VALUES (1, 1);
INSERT INTO is2.is2_link_function_process VALUES (1, 2);
INSERT INTO is2.is2_link_function_process VALUES (3, 3);
INSERT INTO is2.is2_link_function_process VALUES (4, 9);


--
-- TOC entry 4933 (class 0 OID 25243)
-- Dependencies: 254
-- Data for Name: is2_link_function_view_data_type; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_function_view_data_type VALUES (1, 1);
INSERT INTO is2.is2_link_function_view_data_type VALUES (2, 1);
INSERT INTO is2.is2_link_function_view_data_type VALUES (3, 1);
INSERT INTO is2.is2_link_function_view_data_type VALUES (4, 1);


--
-- TOC entry 4934 (class 0 OID 25246)
-- Dependencies: 255
-- Data for Name: is2_link_process_step; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_process_step VALUES (4, 4);
INSERT INTO is2.is2_link_process_step VALUES (70, 70);
INSERT INTO is2.is2_link_process_step VALUES (71, 71);
INSERT INTO is2.is2_link_process_step VALUES (72, 72);
INSERT INTO is2.is2_link_process_step VALUES (91, 91);
INSERT INTO is2.is2_link_process_step VALUES (95, 95);


--
-- TOC entry 4935 (class 0 OID 25249)
-- Dependencies: 256
-- Data for Name: is2_link_step_instance; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_step_instance VALUES (70, 11);
INSERT INTO is2.is2_link_step_instance VALUES (71, 12);
INSERT INTO is2.is2_link_step_instance VALUES (72, 13);
INSERT INTO is2.is2_link_step_instance VALUES (4, 14);
INSERT INTO is2.is2_link_step_instance VALUES (91, 91);
INSERT INTO is2.is2_link_step_instance VALUES (95, 95);


--
-- TOC entry 4936 (class 0 OID 25252)
-- Dependencies: 257
-- Data for Name: is2_log; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_log VALUES (6, ''File DS1 salvato con successo'', ''2019-12-18 11:20:28.826'', ''OUT'', 2);
INSERT INTO is2.is2_log VALUES (7, ''Elaborazione Test RL creata con successo'', ''2019-12-18 11:20:57.666'', ''OUT'', 2);


--
-- TOC entry 4938 (class 0 OID 25260)
-- Dependencies: 259
-- Data for Name: is2_parameter; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_parameter VALUES (1, ''MATCHING VARIABLES'', ''MATCHING VARIABLES'', NULL, ''{"data":[],"schema":{"items":{"properties":{"MatchingVariable":{"maxLength":50,"required":true,"title":"MatchingVariable","type":"string"},"MatchingVariableA":{"maxLength":50,"required":true,"title":"MatchingVariableA","type":"string"},"MatchingVariableB":{"maxLength":50,"required":true,"title":"MatchingVariableB","type":"string"},"Method":{"enum":["Equality","Jaro","Dice","JaroWinkler","Levenshtein","3Grams","Soundex","NumericComparison","NumericEuclideanDistance","WindowEquality","Inclusion3Grams"],"required":true,"title":"Method"},"Threshold":{"title":"Threshold","type":"number"},"Window":{"title":"Window","type":"integer"}},"type":"object"},"type":"array"},"options":{"type":"table","showActionsColumn":false,"hideAddItemsBtn":true,"items":{"fields":{"Method":{"type":"select","noneLabel":"","removeDefaultNone":false},"MatchingVariableA":{"type":"select","noneLabel":"","dataSource":"matchedVariables"},"MatchingVariableB":{"type":"select","noneLabel":"","dataSource":"matchedVariables"}}},"form":{"buttons":{"addRow":"addRow","removeRow":"removeRow"}},"view":{"templates":{"container-array-toolbar":"#addItemsBtn"}}}}'');
INSERT INTO is2.is2_parameter VALUES (2, ''THRESHOLD MATCHING'', ''THRESHOLD MATCHING'', ''1'', ''{"data":[],"schema":{"name":"THRESHOLD MATCHING","type":"number", "minimum": 0.01,"maximum": 1}}'');
INSERT INTO is2.is2_parameter VALUES (3, ''THRESHOLD UNMATCHING'', ''THRESHOLD UNMATCHING'', ''1'', ''{"data":[],"schema":{"name":"THRESHOLD UNMATCHING","type":"number", "minimum": 0.01,"maximum": 1}}'');
INSERT INTO is2.is2_parameter VALUES (910, ''LOADER_PARAMETERS'', ''LOADER_PARAMETERS'', NULL, ''{ "data":[],



	"schema":{ 



	"items":{ 



         "properties":{ 



            "FileType":{ 



               "enum":[ 



				"xml",



				"clef-valeur",



				"plat"



               ],



               "required":true,



               "title":"Type of file"



            }



            ,"Delimiter":{ 



               "maxLength":50,



               "required":true,



               "title":"Delimiter",



               "type":"string"



            }



            ,"Format":{ 



               "maxLength":1000000,



               "required":true,



               "title":"Format",



               "type":"string"



            }



	    ,"Comments":{ 



               "maxLength":1000000,



               "required":true,



               "title":"Comments",



               "type":"string"



            }



         },



         "type":"object"



      },



      "type":"array"



   }



   ,"options":{ 



      "type":"table",



      "showActionsColumn":true,



      "hideAddItemsBtn":false,



      "items":{ 



         "fields":{ 



            "FileType":{ 



               "type":"select",



               "noneLabel":"",



               "removeDefaultNone":false



            }



         }



      },



      "form":{ 



         "buttons":{ 



            "addRow":"addRow"



         }



      },



      "view":{ 



         "templates":{ 



            "container-array-toolbar":"#addItemsBtn"



         }



      }



   }



}'');
INSERT INTO is2.is2_parameter VALUES (950, ''MAPPING_PARAMETERS'', ''MAPPING_PARAMETERS'', NULL, ''{ "data":[],



   "schema":{ 



      "items":{ 



         "properties":{ 



            "VariableName":{ 



               "maxLength":50,



               "required":true,



               "title":"Variable Name",



               "type":"string"



            }



            ,"VariableType":{ 



               "enum":[ 



				"bigint",



				"bigint[]",



				"boolean",



				"date",



				"date[]",



				"float",



				"float[]",



				"interval",



				"text",



				"text[]",



				"timestamp without time zone"



               ],



               "required":true,



               "title":"Variable Type"



            }



            ,"Expression":{ 



               "maxLength":100000,



               "required":true,



               "title":"Expression",



               "type":"string"



            }



            ,"TargetTables":{ 



               "maxLength":100000,



               "required":true,



               "title":"Target tables",



               "type":"string"



            }



         },



         "type":"object"



      },



      "type":"array"



   },



   "options":{ 



      "type":"table",



      "showActionsColumn":true,



      "hideAddItemsBtn":false,



      "items":{ 



         "fields":{ 



            "VariableType":{ 



               "type":"select",



               "noneLabel":"",



               "removeDefaultNone":false



            }



         }



      },



      "form":{ 



         "buttons":{ 



            "addRow":"addRow"



         }



      },



      "view":{ 



         "templates":{ 



            "container-array-toolbar":"#addItemsBtn"



         }



      }



   }



}'');


--
-- TOC entry 4940 (class 0 OID 25268)
-- Dependencies: 261
-- Data for Name: is2_process_step; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_process_step VALUES (4, ''Data validation Van der Loo'', ''Data validation Van der Loo'', 300);
INSERT INTO is2.is2_process_step VALUES (70, ''Contingency Table'', ''Calculate contingency table'', 200);
INSERT INTO is2.is2_process_step VALUES (71, ''Fellegi Sunter'', ''Fellegi Sunter algorithm'', 200);
INSERT INTO is2.is2_process_step VALUES (72, ''Matching Table'', ''Matching records'', 200);
INSERT INTO is2.is2_process_step VALUES (91, ''LOAD'', ''LOAD '', 91);
INSERT INTO is2.is2_process_step VALUES (92, ''STRUCTURIZE'', ''STRUCTURIZE '', 91);
INSERT INTO is2.is2_process_step VALUES (93, ''CONTROL'', ''CONTROL '', 91);
INSERT INTO is2.is2_process_step VALUES (94, ''FILTER'', ''FILTER '', 91);
INSERT INTO is2.is2_process_step VALUES (95, ''MAP'', ''MAP '', 91);


--
-- TOC entry 4965 (class 0 OID 32774)
-- Dependencies: 348
-- Data for Name: is2_process_step_sav; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_process_step_sav VALUES (4, ''Data validation Van der Loo'', ''Data validation Van der Loo'', 300);
INSERT INTO is2.is2_process_step_sav VALUES (70, ''Contingency Table'', ''Calculate contingency table'', 200);
INSERT INTO is2.is2_process_step_sav VALUES (71, ''Fellegi Sunter'', ''Fellegi Sunter algorithm'', 200);
INSERT INTO is2.is2_process_step_sav VALUES (72, ''Matching Table'', ''Matching records'', 200);
INSERT INTO is2.is2_process_step_sav VALUES (91, ''LOAD'', ''LOAD '', 91);
INSERT INTO is2.is2_process_step_sav VALUES (92, ''STRUCTURIZE'', ''STRUCTURIZE '', 92);
INSERT INTO is2.is2_process_step_sav VALUES (93, ''CONTROL'', ''CONTROL '', 93);
INSERT INTO is2.is2_process_step_sav VALUES (94, ''FILTER'', ''FILTER '', 94);
INSERT INTO is2.is2_process_step_sav VALUES (95, ''MAP'', ''MAP '', 95);


--
-- TOC entry 4942 (class 0 OID 25276)
-- Dependencies: 263
-- Data for Name: is2_rule; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4944 (class 0 OID 25286)
-- Dependencies: 265
-- Data for Name: is2_ruleset; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4946 (class 0 OID 25294)
-- Dependencies: 267
-- Data for Name: is2_step_instance; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_step_instance VALUES (11, ''contingencyTable'', ''This function calculates the contingency Table'', ''ContingencyTable'', 250);
INSERT INTO is2.is2_step_instance VALUES (12, ''fellegisunter'', ''This function implements the Fellegi Sunter algorithm'', ''FellegiSunter'', 200);
INSERT INTO is2.is2_step_instance VALUES (13, ''resultTables'', ''This function calculates the Matching Table'', ''MatchingTable'', 250);
INSERT INTO is2.is2_step_instance VALUES (14, ''is2_validate_confront'', ''This function runs the confront algoritm implemented by Van Der Loo'', ''Confront'', 300);
INSERT INTO is2.is2_step_instance VALUES (91, ''arcLoader'', ''Raw file data loader'', ''arcLoader'', 91);
INSERT INTO is2.is2_step_instance VALUES (95, ''arcMapping'', ''ARC Mapping service'', ''arcMapping'', 95);


--
-- TOC entry 4948 (class 0 OID 25302)
-- Dependencies: 269
-- Data for Name: is2_step_instance_signature; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_step_instance_signature VALUES (166, 1, 1, 11, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (154, 1, 2, 11, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (155, 1, 3, 11, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (161, 0, 7, 11, 2);
INSERT INTO is2.is2_step_instance_signature VALUES (158, NULL, 11, 11, 2);
INSERT INTO is2.is2_step_instance_signature VALUES (167, 1, 4, 12, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (168, NULL, 5, 12, 2);
INSERT INTO is2.is2_step_instance_signature VALUES (169, 1, 2, 13, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (170, 1, 3, 13, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (171, 1, 5, 13, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (172, 0, 4, 13, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (173, NULL, 7, 13, 2);
INSERT INTO is2.is2_step_instance_signature VALUES (176, 1, 8, 13, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (177, 1, 9, 13, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (178, 1, 15, 14, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (179, 1, 16, 14, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (910, 1, 910, 91, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (950, 1, 950, 95, 1);


--
-- TOC entry 4950 (class 0 OID 25307)
-- Dependencies: 271
-- Data for Name: is2_step_runtime; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_step_runtime VALUES (15, 5, NULL, 4, 15, 950, 2, 1, NULL);
INSERT INTO is2.is2_step_runtime VALUES (16, 1, NULL, 4, 16, 910, 2, 1, NULL);


--
-- TOC entry 4952 (class 0 OID 25312)
-- Dependencies: 273
-- Data for Name: is2_user_roles; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_user_roles VALUES (1, ''ROLE_ADMIN'');
INSERT INTO is2.is2_user_roles VALUES (2, ''ROLE_USER'');


--
-- TOC entry 4954 (class 0 OID 25318)
-- Dependencies: 275
-- Data for Name: is2_users; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_users VALUES (1, ''admin@is2.it'', ''Administrator'', ''Workbench'', ''$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC'', 1);
INSERT INTO is2.is2_users VALUES (2, ''user@is2.it'', ''User'', ''Workbench'', ''$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82'', 2);
INSERT INTO is2.is2_users VALUES (3, ''fra@fra.it'', ''Francesco Amato'', ''fra'', ''$2a$10$DIcyvIFwhDkEOT9nBugTleDM73OkZffZUdfmvjMCEXdJr3PZP8Kxm'', 1);


--
-- TOC entry 4956 (class 0 OID 25323)
-- Dependencies: 277
-- Data for Name: is2_view_data_type; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_view_data_type VALUES (1, ''DATASET'', NULL);
INSERT INTO is2.is2_view_data_type VALUES (2, ''RULESET'', NULL);


--
-- TOC entry 4958 (class 0 OID 25331)
-- Dependencies: 279
-- Data for Name: is2_work_session; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_work_session VALUES (2, ''Test RL'', '''', ''2019-12-18 11:20:16.303'', 3, 1);
INSERT INTO is2.is2_work_session VALUES (3, ''Test ARC'', '''', ''2019-12-18 17:41:07.408'', 3, 4);
INSERT INTO is2.is2_work_session VALUES (4, ''Test DE'', '''', ''2019-12-20 12:51:48.661'', 3, 2);
INSERT INTO is2.is2_work_session VALUES (5, ''Test DV'', '''', ''2019-12-20 12:52:08.436'', 3, 3);


--
-- TOC entry 4960 (class 0 OID 25339)
-- Dependencies: 281
-- Data for Name: is2_workflow; Type: TABLE DATA; Schema: is2; Owner: -
--



--
-- TOC entry 4962 (class 0 OID 25344)
-- Dependencies: 283
-- Data for Name: is2_workset; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_workset VALUES (2, ''DS'', NULL, ''["A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A"]'', 449, NULL, 1, NULL);
INSERT INTO is2.is2_workset VALUES (3, ''IDENTIFIER'', NULL, ''["ID4447124106922810001","ID4447124106922810003","ID4447124106922810004","ID4447124106922810002","ID4447124106881610001","ID4447124106879010001","ID4447124106879010003","ID4447124106879010002","ID4447124106897210001","ID4447124106897210002","ID4447124106897210003","ID4447124106897210004","ID4447124106897210005","ID4447124106923610001","ID4447124106923610002","ID4447124106923610003","ID4447124106894910001","ID4447124106894910002","ID4447124106920210001","ID4447124106920210002","ID4447124106912910004","ID4447124106912910001","ID4447124106912910003","ID4447124106912910002","ID4447124106912910005","ID4447124106899810001","ID4447124106899810002","ID4447124106915210001","ID4447124106909510001","ID4447124106909510002","ID4447124106909510003","ID4447124106877410001","ID4447124106883210001","ID4447124106883210002","ID4447124106874110001","ID4447124106908710003","ID4447124106908710001","ID4447124106908710002","ID4447124106892310001","ID4447124106892310002","ID4447124106913710002","ID4447124106913710003","ID4447124106913710004","ID4447124106913710005","ID4447124106913710001","ID4447124106917810001","ID4447124106917810002","ID4447124106906110001","ID4447124106906110002","ID4447124106916010001","ID4447124106910310001","ID4447124106910310003","ID4447124106910310002","ID4447124106885710001","ID4447124258794710001","ID4447124258795410001","ID4447124106924410001","ID4447124106911110002","ID4447124106911110001","ID4447124106875810001","ID4447124106875810002","ID4447124106876610001","ID4447124106876610002","ID4447124106907910001","ID4447124106887310002","ID4447124106887310003","ID4447124106887310001","ID4447124106905310002","ID4447124106905310001","ID4447124106925120002","ID4447124106890710001","ID4447124106890710004","ID4447124106890710002","ID4447124106890710003","ID4447124106890710005","ID4447124106890710006","ID4447124106891510001","ID4447124106919410002","ID4447124106886510001","ID4447124106886510002","ID4447124106882410001","ID4447124106882410002","ID4447124106896410001","ID4447124106898010001","ID4447124106898010002","ID4447124106889910001","ID4447124106889910002","ID4447124106904610001","ID4447124106904610002","ID4447124106880810001","ID4447124106880810002","ID4447124106880810003","ID4447124106900410001","ID4447124106921010002","ID4447124106921010001","ID4447124106914510001","ID4447124106914510002","ID4448125110715010004","ID4448125110715010005","ID4448125110715010001","ID4448125110715010002","ID4448125110715010003","ID4448125110796010002","ID4448125110796010001","ID4448125110797810002","ID4448125110797810003","ID4448125110797810001","ID4448125110798610004","ID4448125110798610001","ID4448125110798610002","ID4448125110798610003","ID4448125110699610001","ID4448125110699610002","ID4448125110699610003","ID4448125110795210001","ID4448125110801810002","ID4448125110801810001","ID4448125110800010001","ID4448125110811710001","ID4448125110714310002","ID4448125110714310003","ID4448125110714310001","ID4448125110698810002","ID4448125110698810001","ID4448125110818210001","ID4448125110805910001","ID4448125110819010001","ID4448125110819010002","ID4448125110819010003","ID4448125110819010004","ID4448125110705110002","ID4448125110705110001","ID4448125110816610003","ID4448125110816610004","ID4448125110816610005","ID4448125110816610001","ID4448125110816610002","ID4448125110808310002","ID4448125110808310003","ID4448125110808310004","ID4448125110808310001","ID4448125110808310005","ID4448125110822410001","ID4448125110822410002","ID4448125110822410004","ID4448125110822410003","ID4448125110815810005","ID4448125110815810001","ID4448125110815810003","ID4448125110815810004","ID4448125110817410001","ID4448125110702810002","ID4448125110702810003","ID4448125110702810004","ID4448125110702810001","ID4448125110701010004","ID4448125110701010006","ID4448125110701010001","ID4448125110701010002","ID4448125110701010003","ID4448125110701010005","ID4448125110807510001","ID4448125110820810001","ID4448125110803410002","ID4448125110803410003","ID4448125110803410001","ID4448125110803410004","ID4448125110804210001","ID4448125110821610001","ID4448125110821610002","ID4448125110821610003","ID4448125110802610002","ID4448125110802610001","ID4448125110802610003","ID4448125110802610004","ID4450127238368310004","ID4450127238368310001","ID4450127238368310003","ID4450127238368310005","ID4450127238368310002","ID4450127238387310002","ID4450127238387310003","ID4450127238387310001","ID4450127238383210002","ID4450127238383210001","ID4450127238383210004","ID4450127238383210005","ID4450127238376610001","ID4450127238376610003","ID4450127238376610002","ID4450127238404610002","ID4450127238404610001","ID4450127238379010003","ID4450127238379010004","ID4450127238379010001","ID4450127238379010002","ID4450127238398010001","ID4450127238398010002","ID4450127238358410001","ID4450127238350110001","ID4450127238350110002","ID4450127238362610001","ID4450127238362610002","ID4450127238399810001","ID4450127238399810002","ID4450127238399810003","ID4450127238399810004","ID4450127238359210001","ID4450127238359210002","ID4450127238389910001","ID4450127238389910002","ID4450127238389910003","ID4450127238354310001","ID4450127238354310003","ID4450127238354310002","ID4450127238378210004","ID4450127238378210001","ID4450127238378210002","ID4450127238378210003","ID4450127238355010001","ID4450127238355010002","ID4450127238381610002","ID4450127238381610003","ID4450127238381610001","ID4450127238381610004","ID4450127238406110001","ID4450127238360010001","ID4450127238360010002","ID4450127238349310001","ID4450127238349310002","ID4450127238349310003","ID4450127238352710002","ID4450127238352710003","ID4450127238352710001","ID4450127238384010001","ID4450127238384010002","ID4450127238384010003","ID4450127238384010004","ID4450127238384010005","ID4450127238365910002","ID4450127238374110002","ID4450127238374110003","ID4450127238374110001","ID4450127238405310002","ID4450127238405310001","ID4450127238385710001","ID4450127238385710003","ID4450127238385710002","ID4450127238375810001","ID4450127238397210001","ID4450127238397210003","ID4450127238397210002","ID4450127238397210004","ID4450127238372510001","ID4450127238388110002","ID4450127238388110001","ID4450127238394910003","ID4450127238394910004","ID4450127238394910001","ID4450127238394910002","ID4450127238395610001","ID4450127238395610002","ID4450127238391510002","ID4450127238391510001","ID4450127238386510001","ID4450127238386510002","ID4450127238386510003","ID4450127238364210001","ID4450127238364210002","ID4450127238409510001","ID4450127238409510002","ID4450127238409510003","ID4450127238403810002","ID4450127238403810001","ID4450127257775510002","ID4450127257775510001","ID4450127238348510001","ID4450127238367510001","ID4450127238357610001","ID4450127238357610002","ID4450127238396410001","ID4450127238377410001","ID4450127238377410003","ID4450127238377410002","ID4450127238407910002","ID4450127238407910001","ID4450127238401210003","ID4450127238401210001","ID4450127238401210002","ID4450127238361810002","ID4450127238361810004","ID4450127238361810001","ID4450127238361810003","ID4450127238361810005","ID4450127238371710001","ID4450127238371710002","ID4450127238369110001","ID4450127238393110002","ID4450127238393110003","ID4450127238393110001","ID4450127238353510002","ID4450127238353510003","ID4450127238353510001","ID4450127238353510004","ID4450127238366710001","ID4450127238366710002","ID4450127238382410004","ID4450127238382410005","ID4450127238382410001","ID4450127238382410002","ID4450127238382410003","ID4450127238400410001","ID4450127238356810001","ID4450127238356810002","ID4450127238356810003","ID4450127238380810001","ID4450127238380810003","ID4450127238380810004","ID4450127238380810002","ID4450127238370910001","ID4445112314664910001","ID4445112314670610001","ID4445112314670610002","ID4445113314679710001","ID4445113314682110001","ID4445113314682110002","ID4445113314680510001","ID4445113314680510003","ID4445113314680510004","ID4445113314680510002","ID4445113314680510005","ID4445113314680510006","ID4445113314675510001","ID4445113314675510002","ID4445113314675510003","ID4445113314674810001","ID4445113314674810002","ID4445113314674810003","ID4445113314674810005","ID4445113314674810004","ID4445113314681310001","ID4445113314681310003","ID4445113314681310002","ID4445113314681310004","ID4445113314681310005","ID4445113314681310006","ID4445112314672210001","ID4445112314672210003","ID4445112314672210002","ID4445112314666410001","ID4445112314666410002","ID4445113314673010001","ID4445113314673010003","ID4445113314673010004","ID4445113314673010005","ID4445113314673010002","ID4445113314676310001","ID4445113314676310002","ID4445113314676310003","ID4445112314667210001","ID4445112314667210003","ID4445112314667210005","ID4445112314667210006","ID4445112314667210002","ID4445112314667210004","ID4445112314671410001","ID4445112314671410004","ID4445112314671410002","ID4445112314671410003","ID4445113314678910001","ID4445113314678910002","ID4445112314665610001","ID4445112314665610002","ID4445113314677110001","ID4445113314677110002","ID4445113314677110004","ID4445113314677110003","ID4449126128949510001","ID4449126128949510002","ID4449126128933910001","ID4449126128933910003","ID4449126128933910002","ID4449126128936210001","ID4449126128936210004","ID4449126128936210002","ID4449126128936210003","ID4449126128947910001","ID4449126128947910003","ID4449126128947910002","ID4449126128938810001","ID4449126128938810003","ID4449126128938810002","ID4449126128938810004","ID4449126128942010001","ID4449126128942010002","ID4449126128942010003","ID4449126128942010004","ID4449126128948710001","ID4449126128948710003","ID4449126128948710002","ID4449126128939610001","ID4449126128939610002","ID4449126128944610002","ID4449126128944610001","ID4449126128929710001","ID4449126128929710002","ID4449126128929710003","ID4449126128929710004","ID4449126128932110001","ID4449126128932110002","ID4449126128932110003","ID4449126128932110004","ID4449126128932110005","ID4449126128925510001","ID4449126128925510002","ID4449126128943810001","ID4449126128943810002","ID4449126128943810003","ID4449126128926310001","ID4449126128926310002","ID4449126128940410001","ID4449126128940410002","ID4449126128928910001","ID4449126128928910002","ID4449126128935410001","ID4449126128934710001","ID4449126128934710002","ID4449126128934710003","ID4449126128934710004","ID4449126128931310001","ID4449126128931310002","ID4449126128946110001","ID4449126128946110002","ID4449126128930510001","ID4449126128930510005","ID4449126128930510002","ID4449126128930510003","ID4449126128930510004","ID4449126128941210001","ID4449126128941210002","ID4449126128950310001","ID4449126128950310002","ID4449126128927110001","ID4449126128927110003","ID4449126128927110002","ID4449126128937010001","ID4449126128937010002","ID4449126128945310001","ID4449126128945310002"]'', 449, NULL, 1, NULL);
INSERT INTO is2.is2_workset VALUES (4, ''SURNAME'', NULL, ''["ANDERSON","ANDERSON","ANDERSON","ANDERSON","AQUENDO","BENITEZ","BENITEZ","BENITEZ","BODNER","BODNER","BODNER","BODNER","BODNER","CENTURY","CENTURY","CENTURY","CHEESMAN","CHEESMAN","CONYERE","CONYERE","COSGRAVE","COSGRAVE","COSGRAVE","COSGRAVE","COSGRAVE","DANIEL LEIVA","DANIEL LEIVA","DARCOURT","DECANAY","DECANAY","DECANAY","DIVERS","DOMINGUEZ","DOMINGUEZ","FAUST","FISCHGRUND","FISCHGRUND","FISCHGRUND","GENE","GENE","GIERINGER","GIERINGER","GIERINGER","GIERINGER","GIERINGER","GREEN","GREEN","HENNEGGEY","HENNEGGEY","HILL","JIMENCZ","JIMENCZ","JIMENCZ","JIMENEZ","KAY","KELLY","KILLION","LAKATOS","LAKATOS","LASSITER","LASSITER","LASSITER","LASSITER","LETO","MALDONADO","MALDONADO","MALDONADO","MALENDES","MALENDES","MCCLAIN","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","MOSQUERA","PAIGIE","PARVA","PARVA","RODRIGUEZ","RODRIGUEZ","ROUNSEVELLE","SKANOS","SKANOS","TORRES","TORRES","VALDES","VALDES","VARGAS","VARGAS","VARGAS","VARGAS","WEBSTER","WEBSTER","WICZALKOWSKI","WICZALKOWSKI","BANK","BANK","BANK","BANK","BANK","BARNES","BARNES","BURGERSS","BURGERSS","BURGERSS","BURGESS","BURGESS","BURGESS","BURGESS","BURRISS","BURRISS","BURRISS","BUTLER","CHISOLM","CHISOLM","COATES","CONRON","COTTEN","COTTEN","COTTEN","DIGGS","DIGGS","DORSIE","DUNNOCK","GOINS","GOINS","GOINS","GOINS","GOWANS","GOWANS","HOERRLING","HOERRLING","HOERRLING","HOERRLING","HOERRLING","HOLMES","HOLMES","HOLMES","HOLMES","HOLMES","HUGGINCHES","HUGGINCHES","HUGGINCHES","HUGGINCHES","HUTCHINSON","HUTCHINSON","HUTCHINSON","HUTCHINSON","LEVEN","MATKIN","MATKIN","MATKIN","MATKIN","OWENS","OWENS","OWENS","OWENS","OWENS","OWENS","PAIGE","SPRINGGS","SYKES","SYKES","SYKES","SYKES","THOMPSON","TREZEVANT","TREZEVANT","TREZEVANT","WHITAKER","WHITAKER","WHITAKER","WHITAKER","1RUMOR","1RUMOR","1RUMOR","1RUMOR","1RUMOR","ALSTIN","ALSTIN","ALSTIN","CAMPBELL","CAMPBELL","CAMPBELL","CAMPBELL","CARR","CARR","CARR","CARTER","CARTER","CAVAJEL","CAVAJEL","CAVAJEL","CAVAJEL","CHAMBARS","CHAMBARS","COLBY","COUPE","COUPE","CRIDER","CRIDER","DAVIES","DAVIES","DAVIES","DAVIES","DEGRAENED","DEGRAENED","DORMAN","DORMAN","DORMAN","DOWOKAKOKO","DOWOKAKOKO","DOWOKAKOKO","EASLEY","EASLEY","EASLEY","EASLEY","ELLIOTT","ELLIOTT","ERVINE","ERVINE","ERVINE","ERVINE","FREY","GARRETT","GARRETT","GORDON","GORDON","GORDON","GRANER","GRANER","GRANER","GREENE","GREENE","GREENE","GREENE","GREENE","GUIDETI","HAMMONDS","HAMMONDS","HAMMONDS","HANKINS","HANKINS","HEAVENER","HEAVENER","HEAVENER","HETTERICH","HOLLEY","HOLLEY","HOLLEY","HOLLEY","HUDSON","HUSSEINKHEL","HUSSEINKHEL","KEARNS","KEARNS","KEARNS","KEARNS","KEICHENBERG","KEICHENBERG","KLEIMAN","KLEIMAN","LESKO","LESKO","LESKO","MACCIO","MACCIO","MARTINEZ STG","MARTINEZ STG","MARTINEZ STG","MCALLISTER","MCALLISTER","MOHRING","MOHRING","MOSES","OBROCK","PEARL","PEARL","RAGLIN","REAVES","REAVES","REAVES","RODRIGUEZ","RODRIGUEZ","ROTHSHILD","ROTHSHILD","ROTHSHILD","RUDASILL","RUDASILL","RUDASILL","RUDASILL","RUDASILL","RUEHLING","RUEHLING","RUMOR","RUSSALL","RUSSALL","RUSSALL","SANTIAGO","SANTIAGO","SANTIAGO","SANTIAGO","SQUILLANTE","SQUILLANTE","SWAGOI","SWAGOI","SWAGOI","SWAGOI","SWAGOI","SYKS","TONSTALL","TONSTALL","TONSTALL","WASHINGTON","WASHINGTON","WASHINGTON","WASHINGTON","WIESMAN","BELL","BRAWD","BRAWD","CARTER","DUCOTY","DUCOTY","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","DUFFY TYLER","EHM","EHM","EHM","GASBARRO","GASBARRO","GASBARRO","GASBARRO","GASBARRO","HELLER","HELLER","HELLER","HELLER","HELLER","HELLER","HOPPER","HOPPER","HOPPER","HUBRIC","HUBRIC","PAINE WELLS","PAINE WELLS","PAINE WELLS","PAINE WELLS","PAINE WELLS","PENSETH","PENSETH","PENSETH","POLLACK","POLLACK","POLLACK","POLLACK","POLLACK","POLLACK","ROWEN","ROWEN","ROWEN","ROWEN","SAUNDERS","SAUNDERS","SCCHWARTZ","SCCHWARTZ","SMALLS","SMALLS","SMALLS","SMALLS","ARCHER","ARCHER","BELTRAN","BELTRAN","BELTRAN","BELTRAN","BELTRAN","BELTRAN","BELTRAN","CAGER","CAGER","CAGER","COBEZA","COBEZA","COBEZA","COBEZA","DORSEY","DORSEY","DORSEY","DORSEY","DRENMON","DRENMON","DRENMON","FLEEK","FLEEK","FLOWERS","FLOWERS","GALIDEZ","GALIDEZ","GALIDEZ","GALIDEZ","HILLEGAS","HILLEGAS","HILLEGAS","HILLEGAS","HILLEGAS","HOLLOWAY","HOLLOWAY","KEARNEY","KEARNEY","KEARNEY","MANGUM","MANGUM","MITCHELLL","MITCHELLL","RADRIGZ","RADRIGZ","RAMAS","RHODES","RHODES","RHODES","RHODES","RIBERA","RIBERA","RICHARDSON","RICHARDSON","STAPPY","STAPPY","STAPPY","STAPPY","STAPPY","STEWARD","STEWARD","WCIGNT","WCIGNT","WILKES","WILKES","WILKES","WILLIAMS","WILLIAMS","YETES","YETES"]'', 449, NULL, 1, NULL);
INSERT INTO is2.is2_workset VALUES (13, ''OUTPUT_VARIABLES'', NULL, NULL, 1, ''[{"VariableName":"id_source","VariableType":"text","Expression":"{id_source}","TargetTables":"animal territory"},{"VariableName":"id_biotaupe","VariableType":"bigint","Expression":"{pk:biotaupe}","TargetTables":"biotaupe"},{"VariableName":"id_territory","VariableType":"bigint","Expression":"{pk:vegetation}","TargetTables":"territory biotaupe"},{"VariableName":"id_animal","VariableType":"bigint","Expression":"{pk:animal}","TargetTables":"animal biotaupe"},{"VariableName":"territory_label","VariableType":"text","Expression":"{v_territory_name}","TargetTables":"territory"},{"VariableName":"animal_name","VariableType":"text","Expression":"{v_animal}","TargetTables":"animal"}]'', 2, NULL);
INSERT INTO is2.is2_workset VALUES (15, ''MAPPING_PARAMETERS'', NULL, NULL, 1, ''[{"VariableName":"id_source","VariableType":"text","Expression":"{id_source}","TargetTables":"animal territory biotaupe"},{"VariableName":"id_animal","VariableType":"bigint","Expression":"{pk:animal}","TargetTables":"animal"},{"VariableName":"id_biotaupe","VariableType":"bigint","Expression":"{pk:biotaupe}","TargetTables":"biotaupe"},{"VariableName":"id_territory","VariableType":"bigint","Expression":"{pk:territory}","TargetTables":"territory"},{"VariableName":"territory_name","VariableType":"text","Expression":"{v_territory_name}","TargetTables":"territory"},{"VariableName":"population","VariableType":"bigint","Expression":"{v_number}","TargetTables":"biotaupe"},{"VariableName":"animal_name","VariableType":"text","Expression":"{v_animal}","TargetTables":"animal"}]'', 2, NULL);
INSERT INTO is2.is2_workset VALUES (16, ''LOADER_PARAMETERS'', NULL, NULL, 1, ''[{"FileType":"xml"}]'', 2, NULL);


--
-- TOC entry 4999 (class 0 OID 0)
-- Dependencies: 220
-- Name: batch_job_execution_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.batch_job_execution_seq'', 1, false);


--
-- TOC entry 5000 (class 0 OID 0)
-- Dependencies: 222
-- Name: batch_job_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.batch_job_seq'', 1, false);


--
-- TOC entry 5001 (class 0 OID 0)
-- Dependencies: 225
-- Name: batch_step_execution_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.batch_step_execution_seq'', 1, false);


--
-- TOC entry 5002 (class 0 OID 0)
-- Dependencies: 227
-- Name: is2_app_role_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_app_role_id_seq'', 1, false);


--
-- TOC entry 5003 (class 0 OID 0)
-- Dependencies: 229
-- Name: is2_app_service_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_app_service_id_seq'', 1, false);


--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 231
-- Name: is2_business_function_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_business_function_id_seq'', 1, false);


--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 233
-- Name: is2_business_process_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_business_process_id_seq'', 1, false);


--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 235
-- Name: is2_business_service_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_business_service_id_seq'', 1, false);


--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 237
-- Name: is2_cls_data_type_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_cls_data_type_id_seq'', 1, false);


--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 239
-- Name: is2_cls_rule_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_cls_rule_id_seq'', 1, false);


--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 241
-- Name: is2_cls_statistical_variable_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_cls_statistical_variable_id_seq'', 1, false);


--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 243
-- Name: is2_cls_type_io_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_cls_type_io_id_seq'', 1, false);


--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 245
-- Name: is2_data_bridge_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_data_bridge_id_seq'', 1, false);


--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 247
-- Name: is2_data_processing_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_data_processing_id_seq'', 5, true);


--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 249
-- Name: is2_dataset_column_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_dataset_column_id_seq'', 21, true);


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 251
-- Name: is2_dataset_file_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_dataset_file_id_seq'', 3, true);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 258
-- Name: is2_log_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_log_id_seq'', 13, true);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 260
-- Name: is2_parameter_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_parameter_id_seq'', 1, false);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 262
-- Name: is2_process_step_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_process_step_id_seq'', 1, false);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 264
-- Name: is2_rule_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_rule_id_seq'', 2, true);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 266
-- Name: is2_ruleset_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_ruleset_id_seq'', 3, true);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 268
-- Name: is2_step_instance_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_step_instance_id_seq'', 1, false);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 270
-- Name: is2_step_instance_signature_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_step_instance_signature_id_seq'', 1, false);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 272
-- Name: is2_step_runtime_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_step_runtime_id_seq'', 16, true);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 274
-- Name: is2_user_roles_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_user_roles_id_seq'', 1, false);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 276
-- Name: is2_users_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_users_id_seq'', 1, false);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 278
-- Name: is2_view_data_type_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_view_data_type_id_seq'', 1, false);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 280
-- Name: is2_work_session_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_work_session_id_seq'', 5, true);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 282
-- Name: is2_workflow_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_workflow_id_seq'', 1, false);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 284
-- Name: is2_workset_id_seq; Type: SEQUENCE SET; Schema: is2; Owner: -
--

PERFORM pg_catalog.setval(''is2.is2_workset_id_seq'', 16, true);


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


-- 2020-01-14 10:16:34

EXCEPTION WHEN OTHERS THEN
END;
'
;
