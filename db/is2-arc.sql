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