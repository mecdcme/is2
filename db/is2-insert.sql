-- 
-- Populate is2
-- 
USE `is2`;
SET FOREIGN_KEY_CHECKS=0;

-- 
-- CLASSIFICATION TABLES
--

-- 
-- DATA TYPE CLASSIFICATION
-- 
INSERT INTO `is2_cls_data_type` (`ID`, `NAME`) 
	VALUES 
		(1,'VARIABLE'),
		(2,'PARAMETER'),
		(3,'DATASET'),
		(4,'RULESET'),
		(5,'RULE'),
		(6,'MODEL');
        
-- 
-- INPUT/OUTPUT CLASSIFICATION
-- 
INSERT INTO `is2_cls_type_io` (`ID`, `NAME`) 
	VALUES 
		(1,'INPUT'),
		(2,'OUTPUT'),
		(3,'INPUT_OUTPUT');

-- 
-- VARIABLE CLASSIFICATION (FROM ISTAT CORPORATE METADATA SYSTEM)
-- 
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

-- 
-- RULE TYPE CLASSIFICATION
-- 
INSERT INTO `is2_cls_rule` (`ID`, `NAME`, `DESCR`, `NOTE`) 
	VALUES 
		(1,'Dominio','Definisce i valori o le modalità ammissibili della variabile','Può comprendere missing e/o zero; distinguere tra variabile qualitativa e quantitativa'),
		(2,'Coerenza logica','Definisce le combinazioni ammissibili di valori e/o modalità tra due o più variabili ','Prevalentemente per  variabli qualitative, anche se la regola può riguardare entrambe le tipologie di variabili (es. ETA(0-15) STACIV(coniugato) con ETA fissa)'),
		(3,'Quadratura','Definisce l\'uguaglianza ammissibile tra la somma di due o più variabili quantitative e il totale corrispondente (che può essere noto a priori o a sua volta ottenuto dalla somma di altre variabili del dataset)','Solo variabili quantitative'),
		(4,'Disuguaglianza forma semplice','Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due variabili quantitative','Solo variabili quantitative'),
		(5,'Disuguaglianza forma composta','Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due quantità, dove ciascuna quantità può essere costituita da una sola variabile X o dalla somma/differenza/prodotto tra due o più variabili X','Solo variabili quantitative'),
		(6,'Validazione/Completezza','Verifica in base alle regole di compilazione del questionario che i dati siano stati immessi correttamente','Distinguere tra variabile qualitativa e quantitativa'),
		(7,'Editing',NULL,'Valore di default al caricamento del file');

-- 
-- VIEW_DATA_TYPE
-- 
INSERT INTO `is2_view_data_type` (`ID`, `NAME`) 
	VALUES 
		(1,'DATASET'),
		(2,'RULESET');


-- 
-- GSBPM_PROCESS
-- 
INSERT INTO `is2_gsbpm_process` (`ID`, `NAME`, `PARENT`, `ORDER_CODE`, `ACTIVE`) 
	VALUES 
		(1,'Specify needs',NULL,1,0),
		(2,'Design',NULL,2,1),
		(3,'Build',NULL,3,1),
		(4,'Collect',NULL,4,1),
		(5,'Process',NULL,5,1),
		(6,'Analyse',NULL,6,1),
		(7,'Disseminate',NULL,7,1),
		(8,'Evaluate',NULL,8,0),
		(11,'1.1 Identify needs',1,1,0),
		(12,'1.2 Consult and confirm needs',1,2,0),
		(13,'1.3 Establish output objectives',1,3,0),
		(14,'1.4 Identify concepts',1,4,0),
		(15,'1.5 Check data availability',1,5,0),
		(16,'1.6 Prepare and submit business case',1,6,0),
		(21,'2.1 Design outputs',2,1,1),
		(22,'2.2 Design variable descriptions',2,2,1),
		(23,'2.3 Design collection',2,3,1),
		(24,'2.4 Design frame & sample',2,4,1),
		(25,'2.5 Design processing & analysis',2,5,1),
		(26,'2.6 Design production systems & workflow',2,6,1),
		(31,'3.1 Reuse or build collection instruments',3,1,1),
		(32,'3.2 Reuse or build processing and analysis components',3,2,1),
		(33,'3.3 Reuse or build dissemination components',3,3,1),
		(34,'3.4 Configure workflows',3,4,1),
		(35,'3.5 Test production system',3,5,1),
		(36,'3.6 Test statistical business process',3,6,1),
		(37,'3.7 Finalise production system',3,7,1),
		(41,'4.1 Create frame and select sample',4,1,1),
		(42,'4.2 Set up collection',4,2,1),
		(43,'4.3 Run collection',4,3,1),
		(44,'4.4 Finalize collection',4,4,1),
		(51,'5.1 Integrate data',5,1,1),
		(52,'5.2 Classify & code',5,2,1),
		(53,'5.3 Review & validate',5,3,1),
		(54,'5.4 Edit & impute',5,4,1),
		(55,'5.5 Derive new variables & units',5,5,1),
		(56,'5.6 Calculate weights',5,6,1),
		(57,'5.7 Calculate aggregates',5,7,1),
		(58,'5.8 Finalise data files',5,8,1),
		(61,'6.1 Prepare draft outputs',6,1,1),
		(62,'6.2 Validate outputs',6,2,1),
		(63,'6.3 Interpret & explain outputs',6,3,1),
		(64,'6.4 Apply disclosure control',6,4,1),
		(65,'6.5 Finalise outputs',6,5,1),
		(71,'7.1 Update output systems',7,1,1),
		(72,'7.2 Produce dissemination products',7,2,1),
		(73,'7.3 Manage release of dissemination products',7,3,1),
		(74,'7.4 Promote dissemination products',7,4,1),
		(75,'7.5 Manage user support',7,5,1),
		(81,'8.1 Update output systems',8,1,0),
		(82,'8.2 Produce dissemination products',8,2,0),
		(83,'8.3 Manage release of dissemination products',8,3,0);
        

-- 
-- 
-- PROCESS DESIGN SECTION
--
-- 

-- 
-- BUSINESS_FUNCTION
-- 
INSERT INTO `is2_business_function` (`ID`, `NAME`, `DESCR`, `LABEL`, `ACTIVE`) 
	VALUES 
		(1,'Record Linkage','The purpose of record linkage is to identify the same real world entity that can be differently represented in data sources, even if unique identifiers are not available or are affected by errors.','RL',1),
		(2,'Data Editing','Data editing is the process of reviewing the data for consistency, detection of errors and outliers and correction of errors, in order to improve the quality, accuracy and adequacy of the data and make it suitable for the purpose for which it was collected.','EDIT',1),
		(3,'Data Validation','Data validation is the process of ensuring data have undergone data cleansing to ensure they have data quality, that is, that they are both correct and useful. It uses routines, often called \"validation rules\", that check for correctness, meaningfulness, and security of data that are input to the system.','VALIDATE',1);

-- 
-- BUSINESS_PROCESS
-- 
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) 
	VALUES 
		(1,'Probabilistic Record Linkage','Probabilistic Record Linkage','PRL',NULL,1),
        (2,'Deterministic Record Linkage','Deterministic Record Linkage','DRL',NULL,2),
        (3,'R data validation','R data validation','ValidateR',NULL,1),
        (4,'Data validation Van der Loo','Data validation Van der Loo','VanDerLoo',3,1),
        (70,'Contingency Table','Calculate contingency table','CrossTable',1,1),
        (71,'Fellegi Sunter','Fellegi Sunter algorithm','FellegiSunter',1,2),
        (72,'Matching Table','Matching records','MatchingTable',1,3);

-- add multi-step process
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `ORDER`) VALUES ('5', 'Probabilistic Record Linkage MultiStep', 'Probabilistic Record Linkage MultiStep', 'PRL-MS', '3');
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `ORDER`, `PARENT`) VALUES ('6', 'Probabilistic Record Linkage MultiStep', 'Probabilistic Record Linkage MultiStep', 'PRL-MS1', '4', '5');


-- 
-- CATALOGUE OF BUSINESS SERVICES
-- 
INSERT INTO `is2_business_service` (`ID`, `NAME`, `DESCR`, `GSBPM_PROCESS_ID`) 
	VALUES  
		(200,'Relais','RELAIS (REcord Linkage At IStat) is a toolkit providing a set of techniques for dealing with record linkage projects. The principal features of RELAIS are: It is designed and developed to allow the combination of different techniques for each of the record linkage phases. It has been developed as an open source project under the EUPL license (European Union Public License).', 51),
		(300,'Validate','The validate R-package makes it easy to check whether data lives up to expectations you have based on domain knowledge. It works by allowing you to define data validation rules independent of the code or data set', 53);

-- 
-- PROCESS_STEP
-- 
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`) 
	VALUES 
		(4,'VALIDATE','Validate dataset with ruleset',300),
		(70,'CONTINGENCY_TABLE','The first step of the probabilistic procedure consists of computing the comparison vector, given by the result of the function on the k matching variables, for all the pairs in the space. Indeed, starting from the vector distribution among the pairs (reported in the contingency table) the goal is the estimation of the probability distribution of the unknown random variable “link status”, which assigns each pair to the set M or to the set U. The comparison vector considered in RELAIS is a binary one, i.e. for each matching variable it reports the equality (corresponding to value 1) or the inequality (corresponding to value 0) between the units.',200),
		(71,'FELLEGI_SUNTER','The Fellegi and Sunter method is a probabilistic approach to solve record linkage problem based on decision model.  According to the method, given two (or more) sources of data, all pairs coming from the Cartesian product of the two sources has to be classified in three independent and mutually exclusive subsets: the set of matches, the set of non-matches and the set of pairs requiring manual review. In order to classify the pairs, the comparisons on common attributes are used to estimate for each pair the probabilities to belong to both the set of matches and the set of non-matches. The pair classification criteria is based on the ratio between such conditional probabilities. The decision model aims to minimize both the misclassification errors and the probability of classifying a pair as belonging to the subset of pairs requiring manual review',200),
		(72,'MATCHING_TABLE','Create result matching table',200);


-- 
-- MANY TO MANY RELATION -> BUSINESS_FUNCTION - BUSINESS_PROCESS
-- 
INSERT INTO `is2_link_function_process` (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`) VALUES (1,1),(1,2),(3,3);
    
-- add multi-step process
INSERT INTO `is2_link_function_process` (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`) VALUES (1,5);

-- 
-- MANY TO MANY RELATION -> BUSINESS_PROCESS - PROCESS_STEP
-- 
INSERT INTO `is2_link_process_step` (`BUSINESS_PROCESS_ID`, `PROCESS_STEP_ID`) 
	VALUES (4,4),(6,70),(6,71),(6,72),(70,70),(71,71),(72,72);

-- 
-- MANY TO MANY RELATION -> BUSINESS_FUNCTION - VIEW_DATA_TYPE
-- 
INSERT INTO `is2_link_function_view_data_type` (`BUSINESS_FUNCTION_ID`, `VIEW_DATA_TYPE_ID`) 
	VALUES (1,1), (2,1), (2,2), (3,1), (3,2);

-- 
-- 
-- SECTION PROCESS IMPLEMENTATION
-- 
-- 

-- 
-- CATALOGUE OF APPLICATION SERVICES
-- 
INSERT INTO `is2_app_service` (`ID`, `NAME`, `DESCR`, `IMPLEMENTATION_LANGUAGE`, `SOURCE`, `BUSINESS_SERVICE_ID`) 
	VALUES  
		(200,'Relais R','R package implementing record linkage methods','R','relais/relais.R',200),
		(250,'Relais Java','Java package implementing record linkage methods','JAVA','it.istat.is2.catalogue.relais.service.RelaisService',200),
		(300,'Validate','R package implementing a set of data validation functions','R','validate/validate.r',300);

-- 
-- STEP INSTANCE
-- 
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) 
	VALUES
		(11,'contingencyTable','This function calculates the contingency Table','CONTINGENCY_TABLE',250),
		(12,'fellegisunter','This function implements the Fellegi Sunter algorithm','FELLEGI_SUNTER',200),
		(13,'resultTables','This function calculates the Matching Table','MATCHING_TABLE',250),
		(14,'is2_validate_confront','This function runs the confront algoritm implemented by Van Der Loo','Confront',300);

-- 
-- PARAMETER
-- 
INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`) 
	VALUES
		('1', 'MATCHING VARIABLES', 'MATCHING VARIABLES', NULL, '{ "data": [], "schema": { "items": { "properties": { "MatchingVariable": { "maxLength": 50, "required": true, "title": "MatchingVariable", "type": "string" }, "MatchingVariableA": { "maxLength": 50, "required": true, "title": "MatchingVariableA", "type": "string" }, "MatchingVariableB": { "maxLength": 50, "required": true, "title": "MatchingVariableB", "type": "string" }, "Method": { "enum": [ "Equality", "Jaro", "Dice", "JaroWinkler", "Levenshtein", "3Grams", "Soundex", "NumericComparison", "NumericEuclideanDistance", "WindowEquality", "Inclusion3Grams" ], "required": true, "title": "Method" }, "Threshold": { "title": "Threshold", "type": "number", "default": 1 }, "Window": { "title": "Window", "type": "integer", "default": 1 } }, "type": "object" }, "type": "array" }, "options": { "type": "table", "showActionsColumn": false, "hideAddItemsBtn": true, "items": { "fields": { "Method": { "type": "select", "noneLabel": "", "removeDefaultNone": false }, "MatchingVariableA": { "type": "select", "noneLabel": "", "dataSource": "matchedVariables" }, "MatchingVariableB": { "type": "select", "noneLabel": "", "dataSource": "matchedVariables" } } }, "form": { "buttons": { "addRow": "addRow", "removeRow": "removeRow" } }, "view": { "templates": { "container-array-toolbar": "#addItemsBtn" } } }}'),
        ('2', 'THRESHOLD MATCHING', 'THRESHOLD MATCHING', 1, '{"data":[],"schema":{"name":"THRESHOLD MATCHING","type":"number", "minimum": 0.01,"maximum": 1}}'),
        ('3', 'THRESHOLD UNMATCHING', 'THRESHOLD UNMATCHING', 1, '{"data":[],"schema":{"name":"THRESHOLD UNMATCHING","type":"number", "minimum": 0.01,"maximum": 1}}');

-- 
-- ROLE
-- 
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

-- 
-- STEP INSTANCE SIGNATURE
-- 
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


-- 
--  MANY TO MANY RELATION -> PROCESS_STEP - PROCESS_STEP_INSTANCE
-- 
INSERT INTO `is2_link_step_instance` (`PROCESS_STEP_INSTANCE_ID`, `PROCESS_STEP_ID`) 
	VALUES (11,70), (12,71), (13,72), (14,4);

-- 
--  MANY TO MANY RELATION -> BUSINESS_SERVICE - APP_ROLE
-- 
INSERT INTO `is2_link_business_service_app_role` (`BUSINESS_SERVICE_ID`, `APP_ROLE_ID`) 
	VALUES (200,1), (200,2), (200,3), (200,4), (200,5), (200,6), (200,7), (200,8), (200,9), (200,10), (200,11), (200,12), (200,13), (200,14), (300,15), (300,16);

-- 
-- 
-- SECTION AUXILIARY
-- 
-- 

-- 
-- USER ROLE
-- 
INSERT INTO `is2_user_roles` (`ID`, `ROLE`) 
	VALUES 
		(1,'ROLE_ADMIN'),
        (2,'ROLE_USER');

-- 
-- USER
-- 
INSERT INTO `is2_users` (`ID`, `EMAIL`, `NAME`, `SURNAME`, `PASSWORD`, `ROLE_ID`) 
	VALUES
		(1,'admin@is2.it','Administrator','Workbench','$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC',1),
        (2,'user@is2.it','User','Workbench','$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82',2);


SET FOREIGN_KEY_CHECKS=1;