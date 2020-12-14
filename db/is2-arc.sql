INSERT INTO is2.is2_business_service VALUES (91, 'ARC', 'ARC file loader INSEE',51);

INSERT INTO is2.is2_parameter VALUES (910, 'LOADER_PARAMETERS', 'LOADER_PARAMETERS', NULL, '{ "data":[],"schema":{"items":{  "properties":{  "FileType":{  "enum":["xml","clef-valeur","plat" ], "required":true, "title":"Type of file" } ,"Delimiter":{  "maxLength":50, "required":true, "title":"Delimiter", "type":"string" } ,"Format":{  "maxLength":1000000, "required":true, "title":"Format", "type":"string" } ,"Comments":{  "maxLength":1000000, "required":true, "title":"Comments", "type":"string" } }, "type":"object" }, "type":"array" } ,"options":{  "type":"table", "showActionsColumn":true, "hideAddItemsBtn":false, "items":{  "fields":{  "FileType":{  "type":"select", "noneLabel":"", "removeDefaultNone":false } } }, "form":{  "buttons":{  "addRow":"addRow" } }, "view":{  "templates":{  "container-array-toolbar":"#addItemsBtn" } } }}');
INSERT INTO is2.is2_parameter VALUES (950, 'MAPPING_PARAMETERS', 'MAPPING_PARAMETERS', NULL, '{ "data":[], "schema":{  "items":{  "properties":{  "VariableName":{  "maxLength":50, "required":true, "title":"Variable Name", "type":"string" } ,"VariableType":{  "enum":["bigint","bigint[]","boolean","date","date[]","float","float[]","interval","text","text[]","timestamp without time zone" ], "required":true, "title":"Variable Type" } ,"Expression":{  "maxLength":100000, "required":true, "title":"Expression", "type":"string" } ,"TargetTables":{  "maxLength":100000, "required":true, "title":"Target tables", "type":"string" } }, "type":"object" }, "type":"array" }, "options":{  "type":"table", "showActionsColumn":true, "hideAddItemsBtn":false, "items":{  "fields":{  "VariableType":{  "type":"select", "noneLabel":"", "removeDefaultNone":false } } }, "form":{  "buttons":{  "addRow":"addRow" } }, "view":{  "templates":{  "container-array-toolbar":"#addItemsBtn" } } }}');


INSERT INTO is2.is2_app_role VALUES (910, 'LP', 'LOADER PARAMETERS', 'LOADER PARAMETERS', 1, 2, 910);
INSERT INTO is2.is2_app_role VALUES (950, 'MP', 'MAPPING PARAMETERS', 'MAPPING PARAMETERS', 5, 2, 950);



INSERT INTO is2_app_service (ID, NAME, DESCR, IMPLEMENTATION_LANGUAGE, ENGINE,SOURCE_PATH, SOURCE_CODE, AUTHOR, LICENCE,CONTACT,BUSINESS_SERVICE_ID) 
	VALUES  
        (91, 'ARC LOADER', 'Java package implementing ARC loader service', 'JAVA','JAVA', 'it.istat.is2.catalogue.arc.service.LoadService','','','','', 91),
        (95, 'MAPPING', 'Java package implementing ARC Mapping service', 'JAVA','JAVA', 'it.istat.is2.catalogue.arc.service.MapService','','','','',91);

INSERT INTO is2.is2_business_function VALUES (2, 'Data Editing', 'Data editing is the process of reviewing the data for consistency, detection of errors and outliers and correction of errors, in order to improve the quality, accuracy and adequacy of the data and make it suitable for the purpose for which it was collected.', 'EDIT', 1);
INSERT INTO is2.is2_business_function VALUES (3, 'Data Validation', 'Data validation is the process of ensuring data have undergone data cleansing to ensure they have data quality, that is, that they are both correct and useful. It uses routines, often called \"validation rules\", that check for correctness, meaningfulness, and security of data that are input to the system.', 'VALIDATE', 1);
INSERT INTO is2.is2_business_function VALUES (4, 'ARC', 'File loader workbench', 'ARC', 1);

INSERT INTO is2.is2_business_process VALUES (9, 'FILE LOADER WORKBENCH', 'FILE LOADER WORKBENCH ', 'PARC', 1, NULL);
INSERT INTO is2.is2_business_process VALUES (92, 'STRUCTURIZE', 'STRUCTURIZE ', 'PARC-02', 3, 9);
INSERT INTO is2.is2_business_process VALUES (93, 'CONTROL', 'CONTROL ', 'PARC-03', 4, 9);
INSERT INTO is2.is2_business_process VALUES (94, 'FILTER', 'FILTER ', 'PARC-04', 5, 9);
INSERT INTO is2.is2_business_process VALUES (91, 'LOAD', 'LOAD ', 'PARC-01', 2, 9);
INSERT INTO is2.is2_business_process VALUES (95, 'MAP', 'MAP ', 'PARC-05', 6, 9);

INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 910);
INSERT INTO is2.is2_link_business_service_app_role VALUES (91, 950);



INSERT INTO is2.is2_link_function_process VALUES (4, 9);

INSERT INTO is2.is2_link_function_view_data_type VALUES (2, 1);
INSERT INTO is2.is2_link_function_view_data_type VALUES (3, 1);
INSERT INTO is2.is2_link_function_view_data_type VALUES (4, 1);

INSERT INTO is2.is2_process_step VALUES (91, 'LOAD','LOAD', 'LOAD ', 91);
INSERT INTO is2.is2_process_step VALUES (92, 'STRUCTURIZE','STRUCTURIZE', 'STRUCTURIZE ', 91);
INSERT INTO is2.is2_process_step VALUES (93, 'CONTROL','CONTROL', 'CONTROL ', 91);
INSERT INTO is2.is2_process_step VALUES (94, 'FILTER','FILTER', 'FILTER ', 91);
INSERT INTO is2.is2_process_step VALUES (95, 'MAP','MAP', 'MAP ', 91);

INSERT INTO is2.is2_step_instance VALUES (91, 'arcLoader', 'Raw file data loader', 'arcLoader', 91);
INSERT INTO is2.is2_step_instance VALUES (95, 'arcMapping', 'ARC Mapping service', 'arcMapping', 95);

INSERT INTO is2.is2_step_instance_signature VALUES (910, 1, 910, 91, 1);
INSERT INTO is2.is2_step_instance_signature VALUES (950, 1, 950, 95, 1);

INSERT INTO is2.is2_link_process_step VALUES (91, 91);
INSERT INTO is2.is2_link_process_step VALUES (95, 95);

INSERT INTO is2.is2_link_step_instance VALUES (91, 91);
INSERT INTO is2.is2_link_step_instance VALUES (95, 95);
