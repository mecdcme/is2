-- -----------------------------------------------------
-- Populate is2
-- -----------------------------------------------------
USE `is2`;
SET FOREIGN_KEY_CHECKS=0;


-- -----------------------------------------------------
-- BUSINESS_PROCESS
-- -----------------------------------------------------

INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (10,'Stima e Predizione','Esegue la stima del modello dati e lo applica per produrre una predizione del dato','Stima',NULL,10);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (15,'Stima e Predizione a Strati','Esegue la stima a strati del modello dati e lo applica per produrre una predizione del dato','Stima a Strati',NULL,15);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (20,'Predizione da Modello','Produce una predizione del dato, in base al modello dati che deve essere fornito in input','Predizione',NULL,20);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (25,'Predizione da Modello a Strati','Produce una predizione del dato stratificato, basata sul modello fornito in input','Predizione a Strati',NULL,25);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (30,'Selezione Errori Influenti monostep','Valuta gli errori influenti, in base alla predizione che deve essere fornita in input','Selezione',NULL,30);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (35,'Selezione Errori Influenti monostep a Strati','Valutazione stratificata degli errori influenti, in base alla predizione fornita in input','Selezione a Strati',NULL,35);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (40,'Ricerca Outlier','Ricerca Outlier. Esegue Predizione, perciĂ˛ necessita di un modello in input','Outlier',NULL,40);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (50,'Stima del modello dati','Esegue la stima per ritornare solamente il modello dei dati','Modello',NULL,50);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (75,'Selezione Errori Influenti multi step','Esegue la stima, predizione e valuta gli errori influenti automaticamente in due step','Selezione2S',NULL,75);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (80,'Selezione Errori Influenti multi process','Esegue la stima, predizione e valuta gli errori influenti in due processi successivi','Selezione2P',NULL,80);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (110,'Stima e Predizione','Escuzione del processo di stima e predizione','Estimates',10,10);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (115,'Stima e Predizione a strati','Escuzione del processo di stima e predizione su strato','Strata Estimates',15,15);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (120,'Predizione con modello','Esecuzione del processo di stima da modello','Prediction',20,20);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (125,'Predizione con modello a Strati','Esecuzione del processo di stima da modello stratificato','Strata Prediction',25,25);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (130,'Editing Selettivo','Esecuzione del processo di selezione dei valori influenti','Selection',30,30);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (135,'Editing Selettivo a Strati','Esecuzione del processo di selezione dei valori influenti Stratificato','Strata Selection',35,35);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (140,'Individuazione Outlier','Esecuzione del processo di individuazione degli Outlier','Outlier',40,40);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (150,'Stima modello dati','Stima del modello dati','Model',50,50);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (160,'Stima e selezione','Esecuzione del processo di stima, predizione e selezione automatica','Bistep',75,60);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (110,'Stima e Predizione','Escuzione del processo di stima e predizione','Estimates',80,10);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (130,'Editing Selettivo','Esecuzione del processo di selezione dei valori influenti','Selection',80,30);

-- -----------------------------------------------------
-- PROCESS_STEP
-- -----------------------------------------------------
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`) 
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
	VALUES (2,10),(2,15),(2,20),(2,25),(2,30),(2,35),(2,40),(2,50),(2,75),(2,80);

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_PROCESS - PROCESS_STEP
-- -----------------------------------------------------
INSERT INTO `is2_link_process_step` (`BUSINESS_PROCESS_ID`, `PROCESS_STEP_ID`) 
	VALUES (4,4),(6,70),(6,71),(6,72),(70,70),(71,71),(72,72);

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_FUNCTION - VIEW_DATA_TYPE
-- -----------------------------------------------------
INSERT INTO `is2_link_function_view_data_type` (`BUSINESS_FUNCTION_ID`, `VIEW_DATA_TYPE_ID`) 
	VALUES (1,1), (2,1), (2,2), (3,1), (3,2);

-- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- CATALOGUE OF APPLICATION SERVICES
-- -----------------------------------------------------
INSERT INTO `is2_app_service` (`ID`, `NAME`, `DESCR`, `IMPLEMENTATION_LANGUAGE`, `SOURCE`, `BUSINESS_SERVICE_ID`) 
	VALUES  
		(100,'SeleMix','R package implementing selective editing algorithms','R','SS_selemix.r',100),
		(200,'Relais R','R package implementing record linkage methods','R','relais/relais.R',200),
		(250,'Relais Java','Java package implementing record linkage methods','JAVA','it.istat.is2.catalogue.relais.service.RelaisService',200),
		(300,'Validate','R package implementing a set of data validation functions','R','validate/validate.r',300);

-- -----------------------------------------------------
-- STEP INSTANCE
-- -----------------------------------------------------
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) 
	VALUES
		(11,'contingencyTable','This function calculates the contingency Table','ContingencyTable',250),
		(12,'fellegisunter','This function implements the Fellegi Sunter algorithm','FellegiSunter',200),
		(13,'resultTables','This function calculates the Matching Table','MatchingTable',250),
		(14,'is2_validate_confront','This function runs the confront algoritm implemented by Van Der Loo','Confront',300);

-- -----------------------------------------------------
-- PARAMETER
-- -----------------------------------------------------
INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`) 
	VALUES
		('1', 'MATCHING VARIABLES', 'MATCHING VARIABLES', NULL, '{"data":[],"schema":{"items":{"properties":{"MatchingVariable":{"maxLength":50,"required":true,"title":"MatchingVariable","type":"string"},"MatchingVariableA":{"maxLength":50,"required":true,"title":"MatchingVariableA","type":"string"},"MatchingVariableB":{"maxLength":50,"required":true,"title":"MatchingVariableB","type":"string"},"Method":{"enum":["Equality","Jaro","Dice","JaroWinkler","Levenshtein","3Grams","Soundex","NumericComparison","NumericEuclideanDistance","WindowEquality","Inclusion3Grams"],"required":true,"title":"Method"},"Threshold":{"title":"Threshold","type":"number"},"Window":{"title":"Window","type":"integer"}},"type":"object"},"type":"array"},"options":{"type":"table","showActionsColumn":false,"hideAddItemsBtn":true,"items":{"fields":{"Method":{"type":"select","noneLabel":"","removeDefaultNone":false},"MatchingVariableA":{"type":"select","noneLabel":"","dataSource":"matchedVariables"},"MatchingVariableB":{"type":"select","noneLabel":"","dataSource":"matchedVariables"}}},"form":{"buttons":{"addRow":"addRow","removeRow":"removeRow"}},"view":{"templates":{"container-array-toolbar":"#addItemsBtn"}}}}'),
        ('2', 'THRESHOLD MATCHING', 'THRESHOLD MATCHING', 1, '{"data":[],"schema":{"name":"THRESHOLD MATCHING","type":"number", "minimum": 0.01,"maximum": 1}}'),
        ('3', 'THRESHOLD UNMATCHING', 'THRESHOLD UNMATCHING', 1, '{"data":[],"schema":{"name":"THRESHOLD UNMATCHING","type":"number", "minimum": 0.01,"maximum": 1}}');

-- -----------------------------------------------------
-- ROLE
-- -----------------------------------------------------
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) 
	VALUES  
		(1,'MATCHING VARIABLES','X','MATCHING VARAIBLES',1,2,1),
		(2,'MATCHING A','X1','MATCHING VARIABLE IN DATASET A',2,1,NULL),
		(3,'MATCHING B','X2','MATCHING VARIABLE IN DATASET B',3,1,NULL),
        (4,'CONTENGENCY TABLE','CT','CONTENGENCY TABLE',4,1,NULL),
        (5,'FELLEGI-SUNTER','FS','FELLEGI-SUNTER',14,1,NULL),
		(6,'BLOCKING','B','SLICING DEL DATASET',7,1,NULL),
		(7,'MATCHING TABLE','MT','MATCHING TABLE',8,1,NULL),
		(8,'THRESHOLD MATCHING','TH','THRESHOLD MATCHING',9,2,2),
		(9,'THRESHOLD UNMATCHING','TU','THRESHOLD UNMATCHING',10,2,3),
		(10,'POSSIBLE MATCHING TABLE','PM','POSSIBLE MATCHING TABLE',11,1,NULL),
        (11,'RANKING','M','INFLUENCE RANKING',5,1,NULL),
		(12,'STRATA','S','PARTIZIONAMENTO DEL DATASET',6,1,NULL),
		(13,'RESIDUAL A','RA','RESIDUAL DATASET  A',12,1,NULL),
		(14,'RESIDUAL B','RB','RESIDUAL DATASET  B',13,1,NULL),
		(15,'DATA','MD','DATA',1,1,NULL),
		(16,'RULESET','RS','RULESET',2,4,NULL);

-- -----------------------------------------------------
-- STEP INSTANCE SIGNATURE
-- -----------------------------------------------------
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) 
	VALUES 
		(166,11,1,1,1),
		(154,11,2,1,1),
        (155,11,3,1,1),
        (161,11,7,2,0),
		(158,11,11,2,NULL),
        (167,12,4,1,1),
        (168,12,5,2,NULL),
        (169,13,2,1,1),
        (170,13,3,1,1),
        (171,13,5,1,1),
        (172,13,4,1,0),
        (173,13,7,2,NULL),
        (176,13,8,1,1),
        (177,13,9,1,1),
        (178,14,15,1,1),
        (179,14,16,1,1);

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - LINK
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
--  MANY TO MANY RELATION -> PROCESS_STEP - PROCESS_STEP_INSTANCE
-- -----------------------------------------------------
INSERT INTO `is2_link_step_instance` (`PROCESS_STEP_INSTANCE_ID`, `PROCESS_STEP_ID`) 
	VALUES (11,70), (12,71), (13,72), (14,4);

-- -----------------------------------------------------
--  MANY TO MANY RELATION -> BUSINESS_SERVICE - APP_ROLE
-- -----------------------------------------------------
INSERT INTO `is2_link_business_service_app_role` (`BUSINESS_SERVICE_ID`, `APP_ROLE_ID`) 
	VALUES (200,1), (200,2), (200,3), (200,4), (200,5), (200,6), (200,7), (200,8), (200,9), (200,10), (200,11), (200,12), (200,13), (200,14), (300,15), (300,16);

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION AUXILIARY - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- USER ROLE
-- -----------------------------------------------------
INSERT INTO `is2_user_roles` (`ID`, `ROLE`) 
	VALUES 
		(1,'ROLE_ADMIN'),
        (2,'ROLE_USER');

-- -----------------------------------------------------
-- USER
-- -----------------------------------------------------
INSERT INTO `is2_users` (`ID`, `EMAIL`, `NAME`, `SURNAME`, `PASSWORD`, `ROLE_ID`) 
	VALUES
		(1,'admin@is2.it','Administrator','Workbench','$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC',1),
        (2,'user@is2.it','User','Workbench','$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82',2);

-- -----------------------------------------------------
-- 
-- SECTION AUXILIARY - END
-- 
-- -----------------------------------------------------

SET FOREIGN_KEY_CHECKS=1;