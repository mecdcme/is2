-- -----------------------------------------------------
-- Populate is2
-- -----------------------------------------------------
USE `is2`;
SET FOREIGN_KEY_CHECKS=0;
 
-- -----------------------------------------------------
-- 
-- SECTION SERVICE CATALOGUE - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- CATALOGUE OF BUSINESS SERVICES
-- -----------------------------------------------------
INSERT INTO `is2_business_service` (`ID`, `NAME`, `DESCR`) 	VALUES	(100,'SeleMix','Selective editing via Mixture models') ;

-- -----------------------------------------------------
-- CATALOGUE OF APPLICATION SERVICES
-- -----------------------------------------------------
INSERT INTO `is2_app_service` (`ID`, `NAME`, `DESCR`, `IMPLEMENTATION_LANGUAGE`, `SOURCE`, `BUSINESS_SERVICE_ID`) 
	VALUES  
		(100,'SeleMix','R package implementing selective editing algorithms','R','selemix/IS2_selemix.r',100);

-- -----------------------------------------------------
-- CATALOGUE OF AVAILABLE FUNCTIONALITIES (FOR EACH APPLICATION SERVICE)
-- -----------------------------------------------------
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) 
	VALUES 
		(1,'mlest','Stima e predizione','STIMA',100),
		(2,'ypred','Predizione da modello','PREDIZIONE',100),
		(3,'seledit','Selezione Errori Influenti','SELEZIONE',100),
		(4,'modest','Valutazione del modello','MODEL',100),
		(5,'selpairs','Generazione Grafico','GRAPH',100),
		(7,'strata.mlest','Stima stratificata','STRATST',100),
		(8,'strata.ypred','Predizione stratificata','STRATPR',100),
		(9,'strata.seledit','Selezione stratificata','STRATSE',100);

-- -----------------------------------------------------
-- CATALOGUE OF PARAMETERS NEEDED BY EACH FUNCTIONALITY (STEP_INSTANCE)
-- -----------------------------------------------------
INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`)  
    VALUES 
		(101,'MODEL','DATA MODEL',NULL,'{ "data": [], "schema": {"items": {"properties": { "lambda": {"required": true,"title": "Lambda","description":"Estimated value for the variance inflation factor","type": "number", "default":3,"minimum": 0.01,"maximum": 10 },"w": {"required": true,"title": "W","description":"Estimated value for the proportion of contaminated data","type": "number","default":0.05,"minimum": 0.01,"maximum": 1 }, "B": {"required": true,"title": "B","description":"Matrix of estimated regression coefficients","type": "number"}, "sigma": {"required": true,"title": "sigma","description":"Estimated covariance matrix","type": "number"} },"type": "object"},"type": "array" }, "options": {"type": "array","showActionsColumn": false,"hideAddItemsBtn": true }}'),
		(102,'INPUT_PARAMETERS','INPUT PARAMETERS',NULL,'{"data": [],"schema": { "properties": {"graph": {"required": true,"title": "Graph","description": "Activates graphic output","type": "number","default": 0,"minimum": 0.01,"maximum": 10},"model": {"required": true,"title": "Model","description": "Data Distribution: LN lognormal / N Normal","default": "LN"},"tot": {"title": "Tot","description": "Estimates of originals vector for the target variables"},"t.sel": {"title": "t.sel","description": "Optional vector of threshold values for selective edinting on the target variables"},"t.outl": {"required": true,"title": "t.outl","description": "Threshold value for posterior probabilities of identifying outliers","type": "number","default": 0.05,"minimum": 0.01,"maximum": 10},"eps": {"required": true,"title": "eps","description": "Tolerance for the log-likelihood convergence","type": "number","default": 0.0000001,"minimum": 0.0000001,"maximum": 1},"lambda.fix": {"required": true,"title": "lambda.fix","description": "TRUE if w is known","type": "number","default": 0,"maximum": 1 },"w.fix": {"required": true,"title": "w.fix","description": "TRUE if w is known","type": "number","default": 0,"minimum": 0.01,"maximum": 1}},"type": "object" }}'),
		(103,'OUTPUT_PARAMETERS','OUTPUT PARAMETERS - INFO REPORT',NULL,NULL);
 
-- -----------------------------------------------------
-- CATALOGUE OF ROLES, NEEDED TO DESCRIBE INPUT/OUTPUT OF EACH AVAILABLE FUNCTIONALITY (STEP_INSTANCE)
-- -----------------------------------------------------
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) 
	VALUES 
		(100,'SKIP','N','VARIABILE NON UTILIZZATA',100,1,NULL),
		(101,'IDENTIFICATIVO','I','CHIAVE OSSERVAZIONE',1,1,NULL),
		(102,'TARGET','Y','VARIABILE DI OGGETTO DI ANALISI',3,1,NULL),
		(103,'COVARIATA','X','VARIABILE INDIPENDENTE',4,1,NULL),
		(104,'PREDIZIONE','P','VARIABILE DI PREDIZIONE',5,1,NULL),
		(105,'OUTLIER','O','FLAG OUTLIER',6,1,NULL),
		(106,'PESO','W','PESO CAMPIONARIO',7,1,NULL),
		(107,'ERRORE','E','ERRORE INFLUENTE',10,1,NULL),
		(108,'RANKING','R','INFLUENCE RANKING',11,1,NULL),
		(109,'OUTPUT','T','VARIABILE DI OUTPUT',20,1,NULL),
		(110,'STRATO','S','PARTIZIONAMENTO DEL DATASET',2,1,NULL),
		(111,'PARAMETRI','Z','PARAMETRI DI INPUT',997,2,102),
		(112,'MODELLO','M','MODELLO DATI',998,2,101),
		(113,'SCORE','F','INFLUENCE SCORE',12,1,NULL),
		(114,'INFO','G','PARAMETRI OUT - INFO RIEPILOGO',999,2,103);

-- -----------------------------------------------------
-- STEP INSTANCE SIGNATURE
-- -----------------------------------------------------

INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) 
	VALUES 
		(1,1,102,1,1),(2,1,103,1,1),(3,1,105,2,1),(4,1,104,2,1),(5,1,110,1,1),(6,1,111,1,1),(7,1,112,2,1),
		(8,2,102,1,1),(9,2,103,1,1),(10,2,105,2,1),(11,2,104,2,1),(12,2,110,1,1),(13,2,111,1,1),(14,2,112,1,1),
		(15,3,102,1,1),(17,3,104,1,1),(18,3,110,1,1),(19,3,111,1,1),(20,3,107,2,1),(21,3,108,2,1),(22,3,113,2,1),
		(23,4,102,1,1),(24,4,103,1,1),(25,4,111,1,1),(26,4,112,2,1),(27,1,114,2,1),(28,2,114,2,1),(29,3,114,2,1),
		(30,4,114,2,1),(31,7,111,1,1),(32,7,110,1,1),(33,7,104,2,1),(34,7,105,2,1),(35,7,103,1,1),(36,7,102,1,1),
		(37,7,114,2,1),(38,9,102,1,1),(39,9,113,2,1),(40,9,114,2,1),(41,9,111,1,1),(42,9,110,1,1),(43,9,104,1,1),(44,9,108,2,1),
		(45,9,107,2,1),(46,8,114,2,1),(47,8,103,1,1),(48,8,105,2,1),(49,8,104,2,1),(50,8,110,1,1),(51,8,111,1,1),(52,8,102,1,1),
		(53,8,112,1,1);

-- -----------------------------------------------------
-- 
-- SECTION SERVICE CATALOGUE - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- BUSINESS_PROCESS
-- -----------------------------------------------------
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (80,'Selezione Errori Influenti multi process','Esegue la stima, predizione e valuta gli errori influenti in due processi successivi','Selezione2P',NULL,1);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (110,'Stima e Predizione','Escuzione del processo di stima e predizione','Estimates',80,1);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (130,'Editing Selettivo','Esecuzione del processo di selezione dei valori influenti','Selection',80,2);

-- -----------------------------------------------------
-- PROCESS_STEP
-- -----------------------------------------------------
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (10,'MLEST','Stima',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (15,'STMLEST','Stima stratificata',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (20,'PRED','Predizione',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (25,'STRPRED','Predizione stratificata',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (30,'SELED','Editing Seletivo',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (35,'STRSELED','Editing Seletivo Stratificato',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (40,'OUTL','Scelta Outlier',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (50,'MOD','Imposta Modello',100);

- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - LINK TABLES
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_FUNCTION - BUSINESS_PROCESS
-- -----------------------------------------------------
INSERT INTO `is2_link_function_process` (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`)
	VALUES (2,80);

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_PROCESS - PROCESS_STEP
-- -----------------------------------------------------
INSERT INTO `is2_link_process_step` (`BUSINESS_PROCESS_ID`, `PROCESS_STEP_ID`) 
	VALUES (110,10),(130,30);
    
-- -----------------------------------------------------
--  MANY TO MANY RELATION -> PROCESS_STEP - PROCESS_STEP_INSTANCE
-- -----------------------------------------------------
INSERT INTO `is2_link_step_instance` (`PROCESS_STEP_ID`,`PROCESS_STEP_INSTANCE_ID`) 
	VALUES (10,1),(20,2),(30,3),(40,2),(50,4),(25,8),(35,9),(15,7);

-- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
--  MANY TO MANY RELATION -> BUSINESS_SERVICE - APP_ROLE
-- -----------------------------------------------------
INSERT INTO `is2_link_business_service_app_role` (`BUSINESS_SERVICE_ID`, `APP_ROLE_ID`) 
	VALUES (100,100),(100,101),(100,102),(100,103),(100,104),(100,105),(100,106),(100,107),(100,108),(100,109),(100,110),(100,111),(100,112),(100,113),(100,114);


SET FOREIGN_KEY_CHECKS=1;