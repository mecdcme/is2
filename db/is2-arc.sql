INSERT INTO is2.is2_business_service VALUES (91, 'ARC', 'ARC file loader INSEE',51);

INSERT INTO is2.is2_parameter VALUES (910, 'LOADER PARAMETERS', 'LOADER_PARAMETERS', NULL, '{ "data":[],"schema":{"items":{  "properties":{  "FileType":{  "enum":["xml","clef-valeur","plat" ], "required":true, "title":"Type of file" } ,"Delimiter":{  "maxLength":50, "required":false, "title":"Delimiter", "type":"string" } ,"Format":{  "maxLength":1000000, "required":false, "title":"Format", "type":"string" } ,"Comments":{  "maxLength":1000000, "required":false, "title":"Comments", "type":"string" } }, "type":"object" }, "type":"array" } ,"options":{  "type":"table", "showActionsColumn":true, "hideAddItemsBtn":false, "items":{  "fields":{  "FileType":{  "type":"select", "noneLabel":"", "removeDefaultNone":false } } }, "form":{  "buttons":{  "addRow":"addRow" } }, "view":{  "templates":{  "container-array-toolbar":"#addItemsBtn" } } }}');
INSERT INTO is2.is2_parameter VALUES (930, 'CONTROL PARAMETERS', 'CONTROL_PARAMETERS', NULL, '{ "data":[],"schema":{"items":{  "properties":{  "ControlType":{  "enum":["ALPHANUM","CARDINALITY","SQL","DATE","NUM","REGEXP"], "required":true, "title":"Type of file" } ,"TargetColumnMain":{  "maxLength":1000000, "required":true, "title":"Delimiter", "type":"string" }, "TargetColumnChild":{  "maxLength":1000000, "required":false, "title":"Delimiter", "type":"string" }, "MinValue":{  "maxLength":1000000, "required":true, "title":"Delimiter", "type":"string" }, "MaxValue":{  "maxLength":1000000, "required":true, "title":"Delimiter", "type":"string" }, "SQLCheck":{  "maxLength":1000000, "required":false, "title":"Delimiter", "type":"string" }, "SQLUpdateBeforeCheck":{  "maxLength":1000000, "required":false, "title":"Delimiter", "type":"string" } ,"Comments":{  "maxLength":1000000, "required":true, "title":"Comments", "type":"string" } }, "type":"object" }, "type":"array" } ,"options":{  "type":"table", "showActionsColumn":true, "hideAddItemsBtn":false, "items":{  "fields":{  "ControlType":{  "type":"select", "noneLabel":"", "removeDefaultNone":false } } }, "form":{  "buttons":{  "addRow":"addRow" } }, "view":{  "templates":{  "container-array-toolbar":"#addItemsBtn" } } }}');

INSERT INTO is2.is2_parameter VALUES (950, 'MAPPING PARAMETERS', 'MAPPING_PARAMETERS', NULL, '{ "data":[], "schema":{  "items":{  "properties":{  "VariableName":{  "maxLength":50, "required":true, "title":"Variable Name", "type":"string" } ,"VariableType":{  "enum":["bigint","bigint[]","boolean","date","date[]","float","float[]","interval","text","text[]","timestamp without time zone" ], "required":true, "title":"Variable Type" } ,"Expression":{  "maxLength":100000, "required":true, "title":"Expression", "type":"string" } ,"TargetTables":{  "maxLength":100000, "required":true, "title":"Target tables", "type":"string" } }, "type":"object" }, "type":"array" }, "options":{  "type":"table", "showActionsColumn":true, "hideAddItemsBtn":false, "items":{  "fields":{  "VariableType":{  "type":"select", "noneLabel":"", "removeDefaultNone":false } } }, "form":{  "buttons":{  "addRow":"addRow" } }, "view":{  "templates":{  "container-array-toolbar":"#addItemsBtn" } } }}');



INSERT INTO is2.is2_app_role(ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID) VALUES (910, 'LP', 'LOADER PARAMETERS', 'LOADER PARAMETERS', 1, 2, 910);
INSERT INTO is2.is2_app_role(ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID) VALUES (930, 'CP', 'CONTROL PARAMETERS', 'CONTROL PARAMETERS', 3, 2, 930);
INSERT INTO is2.is2_app_role(ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID) VALUES (940, 'FP', 'FILTER PARAMETERS', 'FILTER PARAMETERS', 4, 2, 940);
INSERT INTO is2.is2_app_role(ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID) VALUES (950, 'MP', 'MAPPING PARAMETERS', 'MAPPING PARAMETERS', 5, 2, 950);


INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (911, 'DS1', 'DATASET1', 'DATASET1 INPUT VARIABLES', 2, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (913, 'DS2', 'DATASET2', 'DATASET2 INPUT VARIABLES', 2, 1, NULL);

INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (912, 'LOK1', 'DATASET1_LOAD_OUTPUT', 'DATASET1 LOAD OUTPUT', 4, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (914, 'LOK2', 'DATASET2_LOAD_OUTPUT', 'DATASET2 LOAD OUTPUT', 4, 1, NULL);

INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (932, 'COK1', 'DATASET1_CONTROL_OUTPUT', 'DATASET1 CONTROL OUTPUT', 4, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (934, 'COK2', 'DATASET2_CONTROL_OUTPUT', 'DATASET2 CONTROL OUTPUT', 4, 1, NULL);


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
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 950);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 911);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 912);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 913);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 914);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 932);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 934);


INSERT INTO is2.is2_link_function_process VALUES (4, 9);

INSERT INTO is2.is2_link_function_view_data_type VALUES (2, 1);
INSERT INTO is2.is2_link_function_view_data_type VALUES (3, 1);
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

INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (911, 1, 911, 91, 1);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (912, 1, 912, 91, 2);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (913, 0, 913, 91, 1);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (914, 0, 914, 91, 2);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (932, 0, 932, 93, 2);
INSERT INTO is2.is2_step_instance_signature (id,required,app_role_id,step_instance_id,cls_type_io_id) VALUES (934, 0, 934, 93, 2);


INSERT INTO is2.is2_link_process_step VALUES (91, 91);
INSERT INTO is2.is2_link_process_step VALUES (93, 93);
INSERT INTO is2.is2_link_process_step VALUES (94, 94);
INSERT INTO is2.is2_link_process_step VALUES (95, 95);

INSERT INTO is2.is2_link_step_instance VALUES (91, 91);
INSERT INTO is2.is2_link_step_instance VALUES (93, 93);
INSERT INTO is2.is2_link_step_instance VALUES (94, 94);
INSERT INTO is2.is2_link_step_instance VALUES (95, 95);
