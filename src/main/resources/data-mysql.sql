-- 
-- Data is2
-- 

USE `is2`;
SET FOREIGN_KEY_CHECKS=0;

INSERT INTO `is2_cls_data_type` (`ID`, `NAME`) 
	VALUES 
		(1,'VARIABLE'),
		(2,'PARAMETER'),
		(3,'DATASET'),
		(4,'RULESET'),
		(5,'RULE'),
		(6,'MODEL');
        
INSERT INTO `is2_cls_type_io` (`ID`, `NAME`) 
	VALUES 
		(1,'INPUT'),
		(2,'OUTPUT'),
		(3,'INPUT_OUTPUT');

INSERT INTO `is2_cls_statistical_variable` (`ID`, `VARIABLE_NAME_ITA`, `VARIABLE_NAME_ENG`, `TYPE`, `DESCR`, `ORDER`) 
	VALUES 
		(1,'VARIABILI IDENTIFICATIVE DELLE UNITÀ','UNIT INDENTIFIER',8,'Variabili identificative delle unità',1),
		(2,'VARIABILI STATISTICHE DI CLASSIFICAZIONE','CLASSIFICATION',1,'Variabili statistiche di classificazione',2),
		(3,'VARIABILI STATISTICHE NUMERICHE','NUMERIC',2,'Variabili statistiche numeriche',3),
		(4,'VARIABILI STATISTICHE TESTUALI','TEXTUAL/OPENED',3,'Variabili statistiche testuali',4),
		(5,'AGGREGATO','AGGREGATE',6,'Concetti relativi al contenuto dei dati',5),
		(6,'CONCETTI DI TIPO OPERATIVO','OPERATIONAL',4,'Concetti di tipo operativo',6),
		(7,'CONCETTI DI TIPO TEMPORALE','TEMPORAL',5,'Concetti di tipo temporale',7),
		(8,'CONCETTI RELATIVI ALLA FREQUENZA','FREQUENCY',7,'Concetti relativi alla frequenza',8),
		(9,'PESO','PESO',10,'Concetti usati per identificare il peso campionario',9),
		(10, 'PARADATO','PARADATA',12,'Paradati ..',10),
		(11,'CONCETTI IDENTIFICATIVI DEL DATASET','DATASET IDENTIFIER',11,'Variabili statistiche composte',11),
		(12,'NON DEFINITA','UNDEFINED',9,'Variabili non definite',12);

INSERT INTO `is2_cls_rule` (`ID`, `NAME`, `DESCR`, `NOTE`) 
	VALUES 
		(1,'Dominio','Definisce i valori o le modalità ammissibili della variabile','Può comprendere missing e/o zero; distinguere tra variabile qualitativa e quantitativa'),
		(2,'Coerenza logica','Definisce le combinazioni ammissibili di valori e/o modalità tra due o più variabili ','Prevalentemente per  variabli qualitative, anche se la regola può riguardare entrambe le tipologie di variabili (es. ETA(0-15) STACIV(coniugato) con ETA fissa)'),
		(3,'Quadratura','Definisce l\'uguaglianza ammissibile tra la somma di due o più variabili quantitative e il totale corrispondente (che può essere noto a priori o a sua volta ottenuto dalla somma di altre variabili del dataset)','Solo variabili quantitative'),
		(4,'Disuguaglianza forma semplice','Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due variabili quantitative','Solo variabili quantitative'),
		(5,'Disuguaglianza forma composta','Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due quantità, dove ciascuna quantità può essere costituita da una sola variabile X o dalla somma/differenza/prodotto tra due o più variabili X','Solo variabili quantitative'),
		(6,'Validazione/Completezza','Verifica in base alle regole di compilazione del questionario che i dati siano stati immessi correttamente','Distinguere tra variabile qualitativa e quantitativa'),
		(7,'Editing',NULL,'Valore di default al caricamento del file');

INSERT INTO `is2_view_data_type` (`ID`, `NAME`) 
	VALUES 
		(1,'DATASET'),
		(2,'RULESET');

INSERT INTO `is2_business_function` (`ID`, `NAME`, `DESCR`, `LABEL`, `ACTIVE`) 
	VALUES 
		(1,'Record Linkage','The purpose of record linkage is to identify the same real world entity that can be differently represented in data sources, even if unique identifiers are not available or are affected by errors.','RL',1),
		(2,'Data Editing','Data editing is the process of reviewing the data for consistency, detection of errors and outliers and correction of errors, in order to improve the quality, accuracy and adequacy of the data and make it suitable for the purpose for which it was collected.','EDIT',1),
		(3,'Data Validation','Data validation is the process of ensuring data have undergone data cleansing to ensure they have data quality, that is, that they are both correct and useful. It uses routines, often called \"validation rules\", that check for correctness, meaningfulness, and security of data that are input to the system.','VALIDATE',1);

INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) 
	VALUES 
		(1,'Probabilistic Record Linkage','Probabilistic Record Linkage','PRL',NULL,1),
        (2,'Deterministic Record Linkage','Deterministic Record Linkage','DRL',NULL,2),
        (3,'R data validation','R data validation','ValidateR',NULL,1),
        (4,'Data validation Van der Loo','Data validation Van der Loo','VanDerLoo',3,1),
        (70,'Contingency Table','Calculate contingency table','CrossTable',1,1),
        (71,'Fellegi Sunter','Fellegi Sunter algorithm','FellegiSunter',1,2),
        (72,'Matching Table','Matching records','MatchingTable',1,3);

INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `ORDER`) VALUES ('5', 'Probabilistic Record Linkage MultiStep', 'Probabilistic Record Linkage MultiStep', 'PRL-MS', '3');
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `ORDER`, `PARENT`) VALUES ('6', 'Probabilistic Record Linkage MultiStep', 'Probabilistic Record Linkage MultiStep', 'PRL-MS1', '4', '5');
INSERT INTO `is2_business_service` (`ID`, `NAME`, `DESCR`) 
	VALUES  
		(200,'Relais','Record Linkage at Istat'),
		(300,'Validate','R Data Validation');

INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`) 
	VALUES 
		(4,'VALIDATE','Validate dataset with ruleset',300),
		(70,'CONTINGENCY_TABLE','Create contingency table',200),
		(71,'FELLEGI SUNTER','Select matching variables',200),
		(72,'MATCHING TABLE','Create result matching table',200);
 
INSERT INTO `is2_link_function_process` (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`) VALUES (1,1),(1,2),(3,3);
INSERT INTO `is2_link_function_process` (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`) VALUES (1,5);

INSERT INTO `is2_link_process_step` (`BUSINESS_PROCESS_ID`, `PROCESS_STEP_ID`) VALUES (4,4),(6,70),(6,71),(6,72),(70,70),(71,71),(72,72);

INSERT INTO `is2_link_function_view_data_type` (`BUSINESS_FUNCTION_ID`, `VIEW_DATA_TYPE_ID`)	VALUES (1,1), (2,1), (2,2), (3,1), (3,2);

INSERT INTO `is2_app_service` (`ID`, `NAME`, `DESCR`, `IMPLEMENTATION_LANGUAGE`, `SOURCE`, `BUSINESS_SERVICE_ID`) 
	VALUES  
		(200,'Relais R','R package implementing record linkage methods','R','relais/relais.R',200),
		(250,'Relais Java','Java package implementing record linkage methods','JAVA','it.istat.is2.catalogue.relais.service.RelaisService',200),
		(300,'Validate','R package implementing a set of data validation functions','R','validate/validate.r',300);

INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) 
	VALUES
		(11,'contingencyTable','This function calculates the contingency Table','ContingencyTable',250),
		(12,'fellegisunter','This function implements the Fellegi Sunter algorithm','FellegiSunter',200),
		(13,'resultTables','This function calculates the Matching Table','MatchingTable',250),
		(14,'is2_validate_confront','This function runs the confront algoritm implemented by Van Der Loo','Confront',300);

INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`) 
	VALUES
		('1', 'MATCHING VARIABLES', 'MATCHING VARIABLES', NULL, '{"data":[],"schema":{"items":{"properties":{"MatchingVariable":{"maxLength":50,"required":true,"title":"MatchingVariable","type":"string"},"MatchingVariableA":{"maxLength":50,"required":true,"title":"MatchingVariableA","type":"string"},"MatchingVariableB":{"maxLength":50,"required":true,"title":"MatchingVariableB","type":"string"},"Method":{"enum":["Equality","Jaro","Dice","JaroWinkler","Levenshtein","3Grams","Soundex","NumericComparison","NumericEuclideanDistance","WindowEquality","Inclusion3Grams"],"required":true,"title":"Method"},"Threshold":{"title":"Threshold","type":"number"}},"type":"object"},"type":"array"},"options":{"type":"table","showActionsColumn":false,"hideAddItemsBtn":true,"items":{"fields":{"Method":{"type":"select","noneLabel":"","removeDefaultNone":false},"MatchingVariableA":{"type":"select","noneLabel":"","dataSource":"matchedVariables"},"MatchingVariableB":{"type":"select","noneLabel":"","dataSource":"matchedVariables"}}},"form":{"buttons":{"addRow":"addRow","removeRow":"removeRow"}},"view":{"templates":{"container-array-toolbar":"#addItemsBtn"}}}}'),
        ('2', 'THRESHOLD MATCHING', 'THRESHOLD MATCHING', 1, '{"data":[],"schema":{"name":"THRESHOLD MATCHING","type":"number", "minimum": 0.01,"maximum": 1}}'),
        ('3', 'THRESHOLD UNMATCHING', 'THRESHOLD UNMATCHING', 1, '{"data":[],"schema":{"name":"THRESHOLD UNMATCHING","type":"number", "minimum": 0.01,"maximum": 1}}');

INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) 
	VALUES  
		(1,'MATCHING VARIABLES','X','MATCHING VARAIBLES',1,2,1),
		(2,'MATCHING A','X1','MATCHING VARIABLE IN DATASET A',2,1,NULL),
		(3,'MATCHING B','X2','MATCHING VARIABLE IN DATASET B',3,1,NULL),
        (4,'CONTENGENCY TABLE','CT','CONTENGENCY TABLE',4,1,NULL),
        (5,'FELLEGI-SUNTER','FS','FELLEGI-SUNTER',2,1,NULL),
		(6,'BLOCKING','B','SLICING DEL DATASET',7,1,NULL),
		(7,'MATCHING TABLE','MT','MATCHING TABLE',10,1,NULL),
		(8,'THRESHOLD MATCHING','TH','THRESHOLD MATCHING',9,2,2),
		(9,'THRESHOLD UNMATCHING','TU','THRESHOLD UNMATCHING',10,2,3),
		(10,'POSSIBLE MATCHING TABLE','PM','POSSIBLE MATCHING TABLE',9,1,NULL),
        (11,'RANKING','M','INFLUENCE RANKING',5,1,NULL),
		(12,'STRATA','S','PARTIZIONAMENTO DEL DATASET',6,1,NULL),
		(13,'RESIDUAL A','RA','RESIDUAL DATASET  A',6,1,NULL),
		(14,'RESIDUAL B','RB','RESIDUAL DATASET  B',5,1,NULL),
		(15,'DATA','MD','DATA',1,1,NULL),
		(16,'RULESET','RS','RULESET',2,4,NULL);

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

INSERT INTO `is2_link_step_instance` (`PROCESS_STEP_INSTANCE_ID`, `PROCESS_STEP_ID`) 
	VALUES (11,70), (12,71), (13,72), (14,4);

INSERT INTO `is2_link_business_service_app_role` (`BUSINESS_SERVICE_ID`, `APP_ROLE_ID`) 
	VALUES (200,1), (200,2), (200,3), (200,4), (200,5), (200,6), (200,7), (200,8), (200,9), (200,10), (200,11), (200,12), (200,13), (200,14), (300,15), (300,16);

INSERT INTO `is2_user_roles` (`ID`, `ROLE`) 
	VALUES 
		(1,'ROLE_ADMIN'),
        (2,'ROLE_USER');

INSERT INTO `is2_users` (`ID`, `EMAIL`, `NAME`, `SURNAME`, `PASSWORD`, `ROLE_ID`) 
	VALUES
		(1,'admin@is2.it','Administrator','Workbench','$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC',1),
        (2,'user@is2.it','User','Workbench','$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82',2);

INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (80,'Selezione Errori Influenti multi process','Esegue la stima, predizione e valuta gli errori influenti in due processi successivi','Selezione2P',NULL,1);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (110,'Stima e Predizione','Escuzione del processo di stima e predizione','Estimates',80,1);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (130,'Editing Selettivo','Esecuzione del processo di selezione dei valori influenti','Selection',80,2);

INSERT INTO `is2_business_service` (`ID`, `NAME`, `DESCR`) 	VALUES	(100,'SeleMix','Selective editing via Mixture models') ;

INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (10,'MLEST','Stima',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (15,'STMLEST','Stima stratificata',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (20,'PRED','Predizione',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (25,'STRPRED','Predizione stratificata',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (30,'SELED','Editing Seletivo',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (35,'STRSELED','Editing Seletivo Stratificato',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (40,'OUTL','Scelta Outlier',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (50,'MOD','Imposta Modello',100);

INSERT INTO `is2_link_function_process` (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`)
	VALUES (2,80);

INSERT INTO `is2_link_process_step` (`BUSINESS_PROCESS_ID`, `PROCESS_STEP_ID`) 
	VALUES (110,10),(130,30);

INSERT INTO `is2_app_service` (`ID`, `NAME`, `DESCR`, `IMPLEMENTATION_LANGUAGE`, `SOURCE`, `BUSINESS_SERVICE_ID`) 
	VALUES  
		(100,'SeleMix','R package implementing selective editing algorithms','R','selemix/IS2_selemix.r',100);

INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (1,'is2_mlest','Stima e predizione','STIMA',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (2,'is2_ypred','Predizione da modello','PREDIZIONE',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (3,'is2_seledit','Selezione Errori Influenti','SELEZIONE',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (4,'is2_modest','Valutazione del modello','MODEL',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (5,'is2_selpairs','Generazione Grafico','GRAPH',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (7,'is2_strata_mlest','Stima stratificata','STRATST',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (8,'is2_strata_ypred','Predizione stratificata','STRATPR',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (9,'is2_strata_seledit','Selezione stratificata','STRATSE',100);

INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`)  VALUES (101,'MODEL','DATA MODEL',NULL,'{ "data": [], "schema": {"items": {"properties": { "lambda": {"required": true,"title": "Lambda","description":"Estimated value for the variance inflation factor","type": "number", "default":3,"minimum": 0.01,"maximum": 10 },"w": {"required": true,"title": "W","description":"Estimated value for the proportion of contaminated data","type": "number","default":0.05,"minimum": 0.01,"maximum": 1 }, "B": {"required": true,"title": "B","description":"Matrix of estimated regression coefficients","type": "number"}, "sigma": {"required": true,"title": "sigma","description":"Estimated covariance matrix","type": "number"} },"type": "object"},"type": "array" }, "options": {"type": "array","showActionsColumn": false,"hideAddItemsBtn": true }}');
INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`)  VALUES (102,'INPUT_PARAMETERS','INPUT PARAMETERS',NULL,'{"data": [],"schema": { "properties": {"graph": {"required": true,"title": "Graph","description": "Activates graphic output","type": "number","default": 0,"minimum": 0.01,"maximum": 10},"model": {"required": true,"title": "Model","description": "Data Distribution: LN lognormal / N Normal","default": "LN"},"tot": {"title": "Tot","description": "Estimates of originals vector for the target variables"},"t.sel": {"title": "t.sel","description": "Optional vector of threshold values for selective edinting on the target variables"},"t.outl": {"required": true,"title": "t.outl","description": "Threshold value for posterior probabilities of identifying outliers","type": "number","default": 0.05,"minimum": 0.01,"maximum": 10},"eps": {"required": true,"title": "eps","description": "Tolerance for the log-likelihood convergence","type": "number","default": 0.0000001,"minimum": 0.0000001,"maximum": 1},"lambda.fix": {"required": true,"title": "lambda.fix","description": "TRUE if w is known","type": "number","default": 0,"maximum": 1 },"w.fix": {"required": true,"title": "w.fix","description": "TRUE if w is known","type": "number","default": 0,"minimum": 0.01,"maximum": 1}},"type": "object" }}');
INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`)  VALUES (103,'OUTPUT_PARAMETERS','OUTPUT PARAMETERS - INFO REPORT',NULL,NULL);
 
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (100,'SKIP','N','VARIABILE NON UTILIZZATA',100,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (101,'IDENTIFICATIVO','I','CHIAVE OSSERVAZIONE',1,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (102,'TARGET','Y','VARIABILE DI OGGETTO DI ANALISI',3,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (103,'COVARIATA','X','VARIABILE INDIPENDENTE',4,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (104,'PREDIZIONE','P','VARIABILE DI PREDIZIONE',5,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (105,'OUTLIER','O','FLAG OUTLIER',6,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (106,'PESO','W','PESO CAMPIONARIO',7,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (107,'ERRORE','E','ERRORE INFLUENTE',10,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (108,'RANKING','R','INFLUENCE RANKING',11,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (109,'OUTPUT','T','VARIABILE DI OUTPUT',20,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (110,'STRATO','S','PARTIZIONAMENTO DEL DATASET',2,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (111,'PARAMETRI','Z','PARAMETRI DI INPUT',997,2,102);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (112,'MODELLO','M','MODELLO DATI',998,2,101);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (113,'SCORE','F','INFLUENCE SCORE',12,1,NULL);
INSERT INTO `is2_app_role` (`ID`, `NAME`, `CODE`, `DESCR`, `ORDER`, `CLS_DATA_TYPE_ID`,`PARAMETER_ID`) VALUES (114,'INFO','G','PARAMETRI OUT - INFO RIEPILOGO',999,2,103);

INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (1,1,102,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (2,1,103,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (3,1,105,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (4,1,104,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (5,0,110,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (6,0,111,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (7,1,112,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (8,2,102,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (9,2,103,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (10,2,105,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (11,2,104,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (12,2,110,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (13,2,111,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (14,2,112,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (15,3,102,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (17,3,104,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (18,3,110,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (19,3,111,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (20,3,107,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (21,3,108,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (22,3,113,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (23,4,102,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (24,4,103,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (25,4,111,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (26,4,112,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (27,1,114,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (28,2,114,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (29,3,114,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (30,4,114,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (31,7,111,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (32,7,110,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (33,7,104,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (34,7,105,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (35,7,103,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (36,7,102,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (37,7,114,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (38,9,102,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (39,9,113,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (40,9,114,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (41,9,111,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (42,9,110,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (43,9,104,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (44,9,108,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (45,9,107,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (46,8,114,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (47,8,103,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (48,8,105,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (49,8,104,2,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (50,8,110,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (51,8,111,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (52,8,102,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (53,8,112,1,1);
INSERT INTO `is2_step_instance_signature` (`ID`, `STEP_INSTANCE_ID`, `APP_ROLE_ID`, `CLS_TYPE_IO_ID`, `REQUIRED`) VALUES (54,8,111,1,1);

INSERT INTO `is2_link_step_instance` (`PROCESS_STEP_ID`,`PROCESS_STEP_INSTANCE_ID`) 
	VALUES (10,1),(20,2),(30,3),(40,2),(50,4),(25,8),(35,9),(15,7);

INSERT INTO `is2_link_business_service_app_role` (`BUSINESS_SERVICE_ID`, `APP_ROLE_ID`) 
	VALUES (100,100),(100,101),(100,102),(100,103),(100,104),(100,105),(100,106),(100,107),(100,108),(100,109),(100,110),(100,111),(100,112),(100,113),(100,114);

SET FOREIGN_KEY_CHECKS=1;