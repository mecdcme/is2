-- 
-- Insert VALIDATE statistical service
-- 
-- USE is2;
 -- BUSINESS SERVICE
INSERT INTO is2.is2_business_service (ID, NAME, DESCR, GSBPM_PROCESS_ID) VALUES	(300,'Validate','R Data Validation', 53) ;


 -- ROLES
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (15, 'MD', 'DATA', 'DATA', 1, 1, NULL);
INSERT INTO is2.is2_app_role (ID, CODE, NAME, DESCR, ORDER_CODE,CLS_DATA_TYPE_ID, PARAMETER_ID)  VALUES (16, 'RS', 'RULESET', 'RULESET', 2, 4, NULL);

 -- APP SERVICES
INSERT INTO is2_app_service (ID, NAME, DESCR, IMPLEMENTATION_LANGUAGE, ENGINE,SOURCE_PATH, SOURCE_CODE, AUTHOR, LICENCE,CONTACT,BUSINESS_SERVICE_ID) 
	VALUES  
		(300,'Validate','R package implementing a set of data validation functions','R','RSERVE','validate/validate.R','','Istat','EUPL1.1','Francesco Amato (fra@istat.it)',300)
 
 --BUSINESS FUNCTION
INSERT INTO is2.is2_business_function (ID, NAME, DESCR, LABEL, ACTIVE) VALUES (3, 'Data Validation', 'Data validation is the process of ensuring data have undergone data cleansing to ensure they have data quality, that is, that they are both correct and useful. It uses routines, often called \"validation rules\", that check for correctness, meaningfulness, and security of data that are input to the system.', 'VALIDATE', 1);

--
-- TOC entry 4933 (class 0 OID 25243)
-- Dependencies: 254
-- Data for Name: is2_link_function_view_data_type; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_link_function_view_data_type VALUES (3, 1);
INSERT INTO is2.is2_link_function_view_data_type VALUES (3, 2);


-- BUSINESS_PROCESS
INSERT INTO is2.is2_business_process (ID, NAME, DESCR, LABEL, PARENT, ORDER_CODE) VALUES (303,'R data validation','R data validation','ValidateR',NULL,1);
INSERT INTO is2.is2_business_process (ID, NAME, DESCR, LABEL, PARENT, ORDER_CODE) VALUES (304,'Data validation Van der Loo','Data validation Van der Loo','VanDerLoo',303,1);
  
 --is2_link_business_service_app_role
INSERT INTO is2.is2_link_business_service_app_role VALUES (300, 15);
INSERT INTO is2.is2_link_business_service_app_role VALUES (300, 16);
 
 --is2_link_function_process
 INSERT INTO is2.is2_link_function_process VALUES (3, 303);
 
 --BUSINESS PROCESS_STEP
 INSERT INTO is2.is2_process_step ( id, name, label, descr, business_service_id) VALUES (304, 'VALIDATE', 'VALIDATE','Validate dataset with ruleset', 300);
 
 --is2_link_process_step
 INSERT INTO is2.is2_link_process_step VALUES (304, 304);
 
 --STEP INSTANCES
 INSERT INTO is2.is2_step_instance (id, method, descr, label, app_service_id) 
  VALUES (314, 'is2_validate_confront', 'This function runs the confront algoritm implemented by Van Der Loo', 'Confront', 300);

 --is2_link_step_instance 
 INSERT INTO is2.is2_link_step_instance VALUES (304, 314);
 
 -- is2_step_instance_signature
 
  -- STEP INSTANCE SIGNATURE
INSERT INTO is2.is2_step_instance_signature (ID, STEP_INSTANCE_ID, APP_ROLE_ID, CLS_TYPE_IO_ID, REQUIRED) VALUES (378,314,15,1,1);
INSERT INTO is2.is2_step_instance_signature (ID, STEP_INSTANCE_ID, APP_ROLE_ID, CLS_TYPE_IO_ID, REQUIRED) VALUES (379,314,16,1,1);

 
