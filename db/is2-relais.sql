INSERT INTO is2.is2_business_service VALUES (200, 'Relais', 'Record Linkage at Istat',51);

-- TOC entry 4938 (class 0 OID 25260)
-- Dependencies: 259
-- Data for Name: is2_parameter; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (1, 'MATCHING VARIABLES', 'MATCHING VARIABLES', NULL, '{"data":[],"schema":{"items":{"properties":{"MatchingVariable":{"maxLength":50,"required":true,"title":"MatchingVariable","type":"string"},"MatchingVariableA":{"maxLength":50,"required":true,"title":"MatchingVariableA","type":"string"},"MatchingVariableB":{"maxLength":50,"required":true,"title":"MatchingVariableB","type":"string"},"Method":{"enum":["Equality","Jaro","Dice","JaroWinkler","Levenshtein","3Grams","Soundex","NumericComparison","NumericEuclideanDistance","WindowEquality","Inclusion3Grams"],"required":true,"title":"Method"},"Threshold":{"title":"Threshold","type":"number"},"Window":{"title":"Window","type":"integer"}},"type":"object"},"type":"array"},"options":{"type":"table","showActionsColumn":false,"hideAddItemsBtn":true,"items":{"fields":{"Method":{"type":"select","noneLabel":"","removeDefaultNone":false},"MatchingVariableA":{"type":"select","noneLabel":"","dataSource":"matchedVariablesbyRoles.X1"},"MatchingVariableB":{"type":"select","noneLabel":"","dataSource":"matchedVariablesbyRoles.X2"}}},"form":{"buttons":{"addRow":"addRow","removeRow":"removeRow"}},"view":{"templates":{"container-array-toolbar":"#addItemsBtn"}}}}');
INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (2, 'THRESHOLD MATCHING', 'THRESHOLD MATCHING', '1', '{"data":[],"schema":{"name":"THRESHOLD MATCHING","type":"number", "minimum": 0.01,"maximum": 1}}');
INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template)  VALUES (3, 'THRESHOLD UNMATCHING', 'THRESHOLD UNMATCHING', '1', '{"data":[],"schema":{"name":"THRESHOLD UNMATCHING","type":"number", "minimum": 0.01,"maximum": 1}}');

INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (5, 'BLOCKING VARIABLES', 'BLOCKING VARIABLES', NULL, '{"data":[],"schema":{"type":"object", "properties": { "BLOCKING_A": { "type":"array", "title":"BLOCKING A","items": {"type": "string"} }, "BLOCKING_B": { "type":"array", "title":"BLOCKING B" ,"items": {"type": "string"}} }}, "options": {"fields":{"BLOCKING_A":{"type":"array",    "toolbarSticky": true,"items":{"type":"select","noneLabel":"","dataSource":"matchedVariables"}},"BLOCKING_B":{"type":"array",   "toolbarSticky": true, "items":{"type":"select","noneLabel":"","dataSource":"matchedVariables"}}}}}');

INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (20, 'REDUCTION METHOD', 'REDUCTION METHOD', NULL, '{ "data": [], "schema": { "type": "object", "properties": { "REDUCTION-METHOD": { "type": "string", "enum": [ "CartesianProduct", "BlockingVariables" ] }, "BLOCKING VARIABLES": { "type": "object", "hidden": true, "name": "BLOCKING VARIABLES", "properties": { "BLOCKING A": { "type": "array", "required": false, "title": "BLOCKING A", "items": { "type": "string" }, "properties": {} }, "BLOCKING B": { "type": "array", "required": false, "title": "BLOCKING B", "items": { "type": "string" }, "properties": {} } } } } }, "options": { "fields": { "REDUCTION-METHOD": { "type": "select", "label": "REDUCTION METHOD", "removeDefaultNone":true, "id": "REDUCTION-METHOD", "sort":false, "optionLabels": [ "CARTESIAN PRODUCT", "BLOCKING VARIABLES" ] }, "BLOCKING VARIABLES": { "type": "object", "fields":{ "BLOCKING A":{"label": "BLOCKING A", "type":"select", "multiple": true,"removeDefaultNone":true,"dataSource":"matchedVariablesbyRoles.X1"}, "BLOCKING B":{"label": "BLOCKING B", "type":"select","removeDefaultNone":true,"dataSource":"matchedVariablesbyRoles.X2"}} } } } , "postRender": "reduction" }');
-- INSERT INTO is2.is2_parameter (id, name, descr, default_val, json_template) VALUES (21, 'INDEXES MATCHED', 'INDEXES MATCHED', NULL, NULL);


-- TOC entry 4938 (class 0 OID 25260)
-- Dependencies: 259
-- Data for Name: is2_app_role; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (1, 'X', 'MATCHING VARIABLES', 'MATCHING VARAIBLES', 1, 2, 1);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (2, 'X1', 'VARIABLES DATASET A', 'SELECTED VARIABLES IN DATASET A', 2, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (3, 'X2', 'VARIABLES DATASET B', 'SELECTED VARIABLES IN DATASET B', 3, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (4, 'CT', 'CONTENGENCY TABLE', 'CONTENGENCY TABLE', 4, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (5, 'FS', 'FELLEGI-SUNTER', 'FELLEGI-SUNTER', 14, 1, NULL);
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

-- INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (21, 'CIT','INDEXES MATCHED', 'INDEX ROWS MATCHED CONTENGENCY TABLE', 21, 1,21 );
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (22, 'MTR', 'MATCHING TABLE REDUCED', 'MATCHING TABLE WITH CONSTRAINT', 22, 1, NULL);

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
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (70, 'Contingency Table', 'Calculate contingency table', 'CrossTable', 1, 1);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (71, 'Fellegi Sunter', 'Fellegi Sunter algorithm', 'FellegiSunter', 2, 1);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (72, 'Matching Table', 'Matching records', 'MatchingTable', 3, 1);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (77, 'Matching constraint', 'Constraint apply on matches', 'MatchingTableReduced', 4, 1);

INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (5, 'Probabilistic Record Linkage Multi-Step', 'Probabilistic Record Linkage Multi-Step', 'PRL-MS', 1, NULL);
INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (73, 'PRL multi-step', 'One process with all workflow steps  ', 'PRL Multi Step', 1, 5);

INSERT INTO is2.is2_business_process (id, name, descr, label, order_code, parent)  VALUES (76, 'Deterministic Record Linkage', 'Deterministic Record Linkage', 'DRL', 1, 2);
--
 





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
-- INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 21);

INSERT INTO is2.is2_link_business_service_app_role VALUES (200, 22);

--
-- TOC entry 4932 (class 0 OID 25240)
-- Dependencies: 253
-- Data for Name: is2_link_function_process; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_function_process VALUES (1, 1);
INSERT INTO is2.is2_link_function_process VALUES (1, 2);
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
INSERT INTO is2.is2_process_step ( id, name, label, descr, business_service_id)  VALUES (77, 'Matching constraint', 'MATCHING_TABLE_REDUCED','Constraint apply on matches', 200);

INSERT INTO is2.is2_process_step  ( id, name, label, descr, business_service_id) VALUES (76, 'Deterministic Record Linkage','DETERMINISTIC_RECORD_LINKAGE', 'Deterministic Record Linkage unique step', 200);


--
-- TOC entry 4934 (class 0 OID 25246)
-- Dependencies: 255
-- Data for Name: is2_link_process_step; Type: TABLE DATA; Schema: is2; Owner: -
--


INSERT INTO is2.is2_link_process_step VALUES (70, 70);
INSERT INTO is2.is2_link_process_step VALUES (71, 71);
INSERT INTO is2.is2_link_process_step VALUES (72, 72);
INSERT INTO is2.is2_link_process_step VALUES (77, 77);

INSERT INTO is2.is2_link_process_step VALUES (73, 70);
INSERT INTO is2.is2_link_process_step VALUES (73, 71);
INSERT INTO is2.is2_link_process_step VALUES (73, 72);

INSERT INTO is2.is2_link_process_step VALUES (76, 76);


--
-- TOC entry 4946 (class 0 OID 25294)
-- Dependencies: 267
-- Data for Name: is2_step_instance; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id) VALUES (11, 'probabilisticContencyTable', 'This function calculates the contingency Table', 'ContingencyTable', 250);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (12, 'fellegisunter', 'This function implements the Fellegi Sunter algorithm', 'FellegiSunter', 200);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (13, 'probabilisticResultTables', 'This function calculates the Matching Table', 'MatchingTable', 250);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (14, 'lpreduction', 'This function implements tha constrint on matches', 'MatchingTableReduced', 200);

-- INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (15, 'contingencyTableBlocking', 'This function calculates the contingency Table with Blocking variable', 'ContingencyTableBlocking', 250);
-- INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (16, 'resultTablesBlocking', 'This function calculates the Matching Table with Blocking variable', 'MatchingTableBlocking', 250);
INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id)  VALUES (20, 'deterministicRecorgeLinkage', 'This function calculates the Matching Table with Deterministic Record Linkage', 'DeterministicRecordLinkage', 250);

--
-- TOC entry 4935 (class 0 OID 25249)
-- Dependencies: 256
-- Data for Name: is2_link_step_instance; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_step_instance VALUES (70, 11);
INSERT INTO is2.is2_link_step_instance VALUES (71, 12);
INSERT INTO is2.is2_link_step_instance VALUES (72, 13);
INSERT INTO is2.is2_link_step_instance VALUES (77, 14);


-- INSERT INTO is2.is2_link_step_instance VALUES (73, 15);
-- INSERT INTO is2.is2_link_step_instance VALUES (75, 16);
INSERT INTO is2.is2_link_step_instance VALUES (76, 20);



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
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (162, 0,21, 11, 2);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (167, 1, 4, 12, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (168, 0, 5, 12, 2);

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (169, 1, 2, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (170, 1, 3, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (171, 1, 5, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (172, 0, 4, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (174, 1, 20, 13, 1);
-- INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (175, 1, 21, 13, 1);


INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (173, 0, 7, 13, 2);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (176, 1, 8, 13, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (177, 1, 9, 13, 1);

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

INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (200, 1, 1, 20, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (201, 1, 2, 20, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (202, 1, 3, 20, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (203, 1, 20, 20, 1);
INSERT INTO is2.is2_step_instance_signature (id, required, app_role_id, step_instance_id, cls_type_io_id) VALUES (204, 1, 7, 20, 2);


