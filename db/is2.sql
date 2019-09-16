-- MySQL dump 10.13  Distrib 8.0.14, for Win64 (x86_64)
--
-- Host: localhost    Database: is2
-- ------------------------------------------------------
-- Server version	8.0.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `batch_job_execution`
--

DROP TABLE IF EXISTS `batch_job_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_job_execution` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `START_TIME` datetime DEFAULT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  `JOB_CONFIGURATION_LOCATION` varchar(2500) DEFAULT NULL,
  `WF_SESSION_ID` bigint(20) DEFAULT NULL,
  `WF_ELAB_ID` bigint(20) DEFAULT NULL,
  `WF_PROC_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  KEY `JOB_INST_EXEC_FK` (`JOB_INSTANCE_ID`),
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `batch_job_instance` (`JOB_INSTANCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_job_execution`
--

LOCK TABLES `batch_job_execution` WRITE;
/*!40000 ALTER TABLE `batch_job_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_job_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_execution_context`
--

DROP TABLE IF EXISTS `batch_job_execution_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_job_execution_context` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_job_execution_context`
--

LOCK TABLES `batch_job_execution_context` WRITE;
/*!40000 ALTER TABLE `batch_job_execution_context` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_job_execution_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_execution_params`
--

DROP TABLE IF EXISTS `batch_job_execution_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_job_execution_params` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `TYPE_CD` varchar(6) NOT NULL,
  `KEY_NAME` varchar(100) NOT NULL,
  `STRING_VAL` varchar(250) DEFAULT NULL,
  `DATE_VAL` datetime DEFAULT NULL,
  `LONG_VAL` bigint(20) DEFAULT NULL,
  `DOUBLE_VAL` double DEFAULT NULL,
  `IDENTIFYING` char(1) NOT NULL,
  KEY `JOB_EXEC_PARAMS_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_job_execution_params`
--

LOCK TABLES `batch_job_execution_params` WRITE;
/*!40000 ALTER TABLE `batch_job_execution_params` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_job_execution_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_execution_seq`
--

DROP TABLE IF EXISTS `batch_job_execution_seq`;
CREATE TABLE `batch_job_execution_seq` (ID BIGINT NOT NULL) ENGINE=InnoDB;
INSERT INTO `batch_job_execution_seq` values(0);

--
-- Table structure for table `batch_job_instance`
--

DROP TABLE IF EXISTS `batch_job_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_job_instance` (
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_KEY` varchar(32) NOT NULL,
  PRIMARY KEY (`JOB_INSTANCE_ID`),
  UNIQUE KEY `JOB_INST_UN` (`JOB_NAME`,`JOB_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_job_instance`
--

LOCK TABLES `batch_job_instance` WRITE;
/*!40000 ALTER TABLE `batch_job_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_job_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_seq`
--

DROP TABLE IF EXISTS `batch_job_seq`;
CREATE TABLE `batch_job_seq` (ID BIGINT NOT NULL) ENGINE=InnoDB;
INSERT INTO `batch_job_seq` values(0);

--
-- Table structure for table `batch_step_execution`
--

DROP TABLE IF EXISTS `batch_step_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_step_execution` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) NOT NULL,
  `STEP_NAME` varchar(100) NOT NULL,
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `COMMIT_COUNT` bigint(20) DEFAULT NULL,
  `READ_COUNT` bigint(20) DEFAULT NULL,
  `FILTER_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_COUNT` bigint(20) DEFAULT NULL,
  `READ_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `PROCESS_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `ROLLBACK_COUNT` bigint(20) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  KEY `JOB_EXEC_STEP_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_step_execution`
--

LOCK TABLES `batch_step_execution` WRITE;
/*!40000 ALTER TABLE `batch_step_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_step_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_step_execution_context`
--

DROP TABLE IF EXISTS `batch_step_execution_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_step_execution_context` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `batch_step_execution` (`STEP_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_step_execution_context`
--

LOCK TABLES `batch_step_execution_context` WRITE;
/*!40000 ALTER TABLE `batch_step_execution_context` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_step_execution_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_step_execution_seq`
--

DROP TABLE IF EXISTS `batch_step_execution_seq`;
CREATE TABLE `batch_step_execution_seq` (ID BIGINT NOT NULL) ENGINE=InnoDB;
INSERT INTO `batch_step_execution_seq` values(0);


--
-- Table structure for table `sx_app_role`
--

DROP TABLE IF EXISTS `sx_app_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_app_role` (
  `ID` int(11) NOT NULL,
  `NOME` varchar(50) DEFAULT NULL,
  `COD` varchar(50) DEFAULT NULL,
  `DESCR` varchar(50) DEFAULT NULL,
  `SERVIZIO` int(20) DEFAULT NULL,
  `ORDINE` int(20) DEFAULT NULL,
  `TIPO_VAR` int(20) DEFAULT NULL,
  UNIQUE KEY `SYS_C0013863` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_app_role`
--

LOCK TABLES `sx_app_role` WRITE;
/*!40000 ALTER TABLE `sx_app_role` DISABLE KEYS */;
INSERT INTO `sx_app_role` VALUES (0,'SKIP','N','VARIABILE NON UTILIZZATA',100,1,1),(1,'IDENTIFICATIVO','I','CHIAVE OSSERVAZIONE',100,1,1),(2,'TARGET','Y','VARIABILE DI OGGETTO DI ANALISI',100,3,1),(3,'COVARIATA','X','VARIABILE INDIPENDENTE',100,4,1),(4,'PREDIZIONE','P','VARIABILE DI PREDIZIONE',100,5,1),(5,'OUTLIER','O','FLAG OUTLIER',100,6,1),(6,'PESO','W','PESO CAMPIONARIO',100,7,1),(7,'ERRORE','E','ERRORE INFLUENTE',100,10,1),(8,'RANKING','R','INFLUENCE RANKING',100,11,1),(9,'OUTPUT','T','VARIABILE DI OUTPUT',100,20,1),(10,'STRATO','S','PARTIZIONAMENTO DEL DATASET',100,2,1),(11,'PARAMETRI','Z','PARAMETRI DI INPUT',100,997,2),(12,'MODELLO','M','MODELLO DATI',100,998,2),(13,'SCORE','F','INFLUENCE SCORE',100,12,1),(14,'INFO','G','PARAMETRI OUT - INFO RIEPILOGO',100,999,1),(100,'SKIP','N','VARIABILE NON UTILIZZATA',200,100,1),(102,'CHIAVE A','K1','CHIAVE DATASET A',200,3,1),(103,'CHIAVE B','K2','CHIAVE DATASET B',200,4,1),(104,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',200,5,1),(105,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',200,6,1),(108,'RANKING','M','INFLUENCE RANKING',200,11,2),(110,'STRATO','S','PARTIZIONAMENTO DEL DATASET',200,2,1),(111,'RESULT','R','RISULTATO PRODOTTO CARTESIANO',200,10,2),(115,'BLOCKING','B','SLICING DEL DATASET',200,3,1),(150,'SKIP','N','VARIABILE NON UTILIZZATA',250,100,1),(152,'KEY A','K1','CHIAVE DATASET A',250,3,1),(153,'KEY B','K2','CHIAVE DATASET B',250,4,1),(154,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',250,5,1),(155,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',250,6,1),(158,'RANKING','M','INFLUENCE RANKING',250,11,2),(160,'STRATA','S','PARTIZIONAMENTO DEL DATASET',250,2,1),(161,'CONTENGENCY TABLE','CT','CONTENGENCY TABLE',250,1,1),(165,'BLOCKING','B','SLICING DEL DATASET',250,3,1),(166,'MATCHING VARAIBLES','X','VARIABLI DI MATCHING',250,1,2),(167,'FELLEGI-SUNTER','FS','FELLEGI-SUNTER',200,2,1),(168,'MATCHING TABLE','MT','MATCHING TABLE',250,3,1),(169,'THRESHOLD','TH','THRESHOLD MATCHING',250,2,2),(170,'THRESHOLD','TU','THRESHOLD UNMATCHING',250,4,2),(171,'POSSIBLE MATCHING TABLE','PM','POSSIBLE MATCHING TABLE',250,5,1),(172,'RESIDUAL A','RA','RESIDUAL DATASET  A',250,6,1),(173,'RESIDUAL B','RB','RESIDUAL DATASET  B',250,7,1);
/*!40000 ALTER TABLE `sx_app_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_app_service`
--

DROP TABLE IF EXISTS `sx_app_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_app_service` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `DESCR` varchar(100) DEFAULT NULL,
  `INTERFACCIA` varchar(50) DEFAULT NULL,
  `SCRIPT` varchar(100) DEFAULT NULL,
  `CODICE` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014219` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_app_service`
--

LOCK TABLES `sx_app_service` WRITE;
/*!40000 ALTER TABLE `sx_app_service` DISABLE KEYS */;
INSERT INTO `sx_app_service` VALUES (100,'SeleMix','Individuazione valori anomali tramite misture','R','SS_selemix.r',100),(200,'Relais','Record Linkage','R','relais/relais.R',200),(250,'RelaisJ','Record Linkage Java','JAVA','SS_relais.jar',250),(300,'Validate','Validazione e gestione delle regole','R','SS_validate.r',300);
/*!40000 ALTER TABLE `sx_app_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_app_service_env`
--

DROP TABLE IF EXISTS `sx_app_service_env`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_app_service_env` (
  `ID` int(11) DEFAULT NULL,
  `APP_SERVICE` int(11) DEFAULT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `VALUE` varchar(50) DEFAULT NULL,
  `DESCR` varchar(100) DEFAULT NULL,
  `TYPE` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_app_service_env`
--

LOCK TABLES `sx_app_service_env` WRITE;
/*!40000 ALTER TABLE `sx_app_service_env` DISABLE KEYS */;
INSERT INTO `sx_app_service_env` VALUES (1,100,'RESULTSET','result','Dataset di output','data.frame'),(2,100,'WORKSET','workset','Dataset di input','data.frame'),(3,100,'RUOLI_VAR','role_var','Ruoli di input','data.frame'),(4,100,'RUOLI_OUTPUT','role_out','Ruoli di output','data.frame'),(5,100,'RUOLI_INPUT','role_in','Ruoli di input','data.frame'),(7,100,'PARAMETRI','params','Parametri','data.frame'),(8,100,'MODELLO','model','Modello','data.frame'),(9,100,'RUOLO_SKIP_N','N','Ruolo Skip','data.frame'),(10,100,'RESULT_RUOLI','result$roles','Ruoli out','data.frame'),(11,100,'RESULT_OUTPUT','result$out','Output workset','data.frame'),(12,100,'RESULT_PARAM','result$mod','Modello Statistico','data.frame'),(13,100,'RESULT_REPORT','result$report','Report','data.frame');
/*!40000 ALTER TABLE `sx_app_service_env` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_artifact_bfunction`
--

DROP TABLE IF EXISTS `sx_artifact_bfunction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_artifact_bfunction` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_artifact_bfunction`
--

LOCK TABLES `sx_artifact_bfunction` WRITE;
/*!40000 ALTER TABLE `sx_artifact_bfunction` DISABLE KEYS */;
INSERT INTO `sx_artifact_bfunction` VALUES (1,'dataset'),(2,'ruleset');
/*!40000 ALTER TABLE `sx_artifact_bfunction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_bfunc_bprocess`
--

DROP TABLE IF EXISTS `sx_bfunc_bprocess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_bfunc_bprocess` (
  `BFUNCTION` int(20) DEFAULT NULL,
  `BPROCESS` int(20) DEFAULT NULL,
  UNIQUE KEY `SX_BFUNC_BPROCESS_PK` (`BFUNCTION`,`BPROCESS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_bfunc_bprocess`
--

LOCK TABLES `sx_bfunc_bprocess` WRITE;
/*!40000 ALTER TABLE `sx_bfunc_bprocess` DISABLE KEYS */;
INSERT INTO `sx_bfunc_bprocess` VALUES (1,1),(1,2),(3,3);
/*!40000 ALTER TABLE `sx_bfunc_bprocess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_bfunc_bprocess_old`
--

DROP TABLE IF EXISTS `sx_bfunc_bprocess_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_bfunc_bprocess_old` (
  `BFUNCTION` int(20) DEFAULT NULL,
  `BPROCESS` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_bfunc_bprocess_old`
--

LOCK TABLES `sx_bfunc_bprocess_old` WRITE;
/*!40000 ALTER TABLE `sx_bfunc_bprocess_old` DISABLE KEYS */;
INSERT INTO `sx_bfunc_bprocess_old` VALUES (1,1),(1,2),(90,70),(90,72),(91,70),(91,71),(91,72);
/*!40000 ALTER TABLE `sx_bfunc_bprocess_old` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_bfunction_artifactbfunction`
--

DROP TABLE IF EXISTS `sx_bfunction_artifactbfunction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_bfunction_artifactbfunction` (
  `bfunction` int(11) NOT NULL,
  `artifact` int(11) NOT NULL,
  PRIMARY KEY (`bfunction`,`artifact`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_bfunction_artifactbfunction`
--

LOCK TABLES `sx_bfunction_artifactbfunction` WRITE;
/*!40000 ALTER TABLE `sx_bfunction_artifactbfunction` DISABLE KEYS */;
INSERT INTO `sx_bfunction_artifactbfunction` VALUES (1,1),(2,1),(2,2),(3,1),(3,2);
/*!40000 ALTER TABLE `sx_bfunction_artifactbfunction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_bprocess_bstep`
--

DROP TABLE IF EXISTS `sx_bprocess_bstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_bprocess_bstep` (
  `BPROCESS` int(20) DEFAULT NULL,
  `BSTEP` int(20) DEFAULT NULL,
  UNIQUE KEY `SX_BPROCESS_BSTEP_PK` (`BPROCESS`,`BSTEP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_bprocess_bstep`
--

LOCK TABLES `sx_bprocess_bstep` WRITE;
/*!40000 ALTER TABLE `sx_bprocess_bstep` DISABLE KEYS */;
INSERT INTO `sx_bprocess_bstep` VALUES (70,70),(71,71),(72,72);
/*!40000 ALTER TABLE `sx_bprocess_bstep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_business_function`
--

DROP TABLE IF EXISTS `sx_business_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_business_function` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `DESCR` text,
  `ETICHETTA` varchar(100) DEFAULT NULL,
  `ACTIVE` int(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014019` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_function`
--

LOCK TABLES `sx_business_function` WRITE;
/*!40000 ALTER TABLE `sx_business_function` DISABLE KEYS */;
INSERT INTO `sx_business_function` VALUES (1,'Record Linkage','The purpose of record linkage is to identify the same real world entity that can be differently represented in data sources, even if unique identifiers are not available or are affected by errors.','RL',1),(2,'Data Editing','Data editing is the process of reviewing the data for consistency, detection of errors and outliers and correction of errors, in order to improve the quality, accuracy and adequacy of the data and make it suitable for the purpose for which it was collected.','EDIT',1),(3,'Data Validation','Data validation is the process of ensuring data have undergone data cleansing to ensure they have data quality, that is, that they are both correct and useful. It uses routines, often called \"validation rules\", that check for correctness, meaningfulness, and security of data that are input to the system.','VALIDATE',1);
/*!40000 ALTER TABLE `sx_business_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_business_function_old`
--

DROP TABLE IF EXISTS `sx_business_function_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_business_function_old` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `NOME` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `DESCR` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `ETICHETTA` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `ACTIVE` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_function_old`
--

LOCK TABLES `sx_business_function_old` WRITE;
/*!40000 ALTER TABLE `sx_business_function_old` DISABLE KEYS */;
INSERT INTO `sx_business_function_old` VALUES (1,'Record Linkage',NULL,'RL',1),(2,'Data Editing',NULL,'EDIT',1),(3,'Data Validation',NULL,'VALIDATE',1),(90,'Cross Table','Esegue il prodotto cartesiano di dataset','Cross Table',0),(91,'Relais','Relais Multi-Process','Relais',0);
/*!40000 ALTER TABLE `sx_business_function_old` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_business_process`
--

DROP TABLE IF EXISTS `sx_business_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_business_process` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `DESCR` varchar(100) DEFAULT NULL,
  `ETICHETTA` varchar(100) DEFAULT NULL,
  `REGOLE` int(20) DEFAULT NULL,
  `PARENT` int(11) DEFAULT NULL,
  `ORDER` smallint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014187` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_process`
--

LOCK TABLES `sx_business_process` WRITE;
/*!40000 ALTER TABLE `sx_business_process` DISABLE KEYS */;
INSERT INTO `sx_business_process` VALUES (1,'Record Linkage Probabilistico','Record Linkage Probabilistico','RLP',NULL,NULL,1),(2,'Record Linkage Deterministico','Record Linkage Deterministico','RLD',NULL,NULL,2),(3,'Validate R','Validate R','Validate R',NULL,NULL,1),(4,'Validate R Van de','Validate R Van de','Validate R vdf',NULL,3,2),(70,'Cont Table','Calcolo tabella di contingenza','Cross Table',NULL,1,1),(71,'FellegiSunter','FellegiSunter','FellegiSunter',NULL,1,2),(72,'Matching Table','Result Matching table','MATCHING TABLE',NULL,1,3);
/*!40000 ALTER TABLE `sx_business_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_business_step`
--

DROP TABLE IF EXISTS `sx_business_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_business_step` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `DESCR` varchar(100) DEFAULT NULL,
  `REGOLE` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0013693` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_step`
--

LOCK TABLES `sx_business_step` WRITE;
/*!40000 ALTER TABLE `sx_business_step` DISABLE KEYS */;
INSERT INTO `sx_business_step` VALUES (70,'CONTINGENCY_TABLE','Create contingency table',NULL),(71,'FELLEGI SUNTER','Select matching variables',NULL),(72,'MATCHING TABLE','Create result matching table',NULL);
/*!40000 ALTER TABLE `sx_business_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_classification`
--

DROP TABLE IF EXISTS `sx_classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_classification` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(255) DEFAULT NULL,
  `DESCRIZIONE` varchar(255) DEFAULT NULL,
  `NOTE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=456 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_classification`
--

LOCK TABLES `sx_classification` WRITE;
/*!40000 ALTER TABLE `sx_classification` DISABLE KEYS */;
INSERT INTO `sx_classification` VALUES (1,'Dominio','Definisce i valori o le modalità ammissibili della variabile','Può comprendere missing e/o zero; distinguere tra variabile qualitativa e quantitativa'),(2,'Coerenza logica','Definisce le combinazioni ammissibili di valori e/o modalità tra due o più variabili ','Prevalentemente per  variabli qualitative, anche se la regola può riguardare entrambe le tipologie di variabili (es. ETA(0-15) STACIV(coniugato) con ETA fissa)'),(3,'Quadratura','Definisce l\'uguaglianza ammissibile tra la somma di due o più variabili quantitative e il totale corrispondente (che può essere noto a priori o a sua volta ottenuto dalla somma di altre variabili del dataset)','Solo variabili quantitative'),(4,'Disuguaglianza forma semplice','Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due variabili quantitative','Solo variabili quantitative'),(5,'Disuguaglianza forma composta','Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due quantità, dove ciascuna quantità può essere costituita da una sola variabile X o dalla somma/differenza/prodotto tra due o più variabili X','Solo variabili quantitative'),(6,'Validazione/Completezza','Verifica in base alle regole di compilazione del questionario che i dati siano stati immessi correttamente','Distinguere tra variabile qualitativa e quantitativa'),(7,'Editing',NULL,'Valore di default al caricamento del file');
/*!40000 ALTER TABLE `sx_classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_dataset_colonna`
--

DROP TABLE IF EXISTS `sx_dataset_colonna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_dataset_colonna` (
  `IDCOL` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ORDINE` int(20) DEFAULT NULL,
  `ELABORAZIONE` int(20) DEFAULT NULL,
  `daticolonna` json DEFAULT NULL,
  `DATASET_FILE` int(20) DEFAULT NULL,
  `TIPO_VARIABILE` int(20) DEFAULT NULL,
  `FILTRO` int(20) DEFAULT NULL,
  `VALORI_SIZE` int(20) DEFAULT NULL,
  PRIMARY KEY (`IDCOL`),
  UNIQUE KEY `SX_DATASET_COLONNA_PK` (`IDCOL`),
  KEY `DSC` (`DATASET_FILE`),
  KEY `NOME` (`NOME`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_colonna`
--

LOCK TABLES `sx_dataset_colonna` WRITE;
/*!40000 ALTER TABLE `sx_dataset_colonna` DISABLE KEYS */;
INSERT INTO `sx_dataset_colonna` VALUES (1,'DS',0,NULL,'[\"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\", \"A\"]',1,NULL,NULL,449),(2,'IDENTIFIER',1,NULL,'[\"ID4447124106922810001\", \"ID4447124106922810003\", \"ID4447124106922810004\", \"ID4447124106922810002\", \"ID4447124106881610001\", \"ID4447124106879010001\", \"ID4447124106879010003\", \"ID4447124106879010002\", \"ID4447124106897210001\", \"ID4447124106897210002\", \"ID4447124106897210003\", \"ID4447124106897210004\", \"ID4447124106897210005\", \"ID4447124106923610001\", \"ID4447124106923610002\", \"ID4447124106923610003\", \"ID4447124106894910001\", \"ID4447124106894910002\", \"ID4447124106920210001\", \"ID4447124106920210002\", \"ID4447124106912910004\", \"ID4447124106912910001\", \"ID4447124106912910003\", \"ID4447124106912910002\", \"ID4447124106912910005\", \"ID4447124106899810001\", \"ID4447124106899810002\", \"ID4447124106915210001\", \"ID4447124106909510001\", \"ID4447124106909510002\", \"ID4447124106909510003\", \"ID4447124106877410001\", \"ID4447124106883210001\", \"ID4447124106883210002\", \"ID4447124106874110001\", \"ID4447124106908710003\", \"ID4447124106908710001\", \"ID4447124106908710002\", \"ID4447124106892310001\", \"ID4447124106892310002\", \"ID4447124106913710002\", \"ID4447124106913710003\", \"ID4447124106913710004\", \"ID4447124106913710005\", \"ID4447124106913710001\", \"ID4447124106917810001\", \"ID4447124106917810002\", \"ID4447124106906110001\", \"ID4447124106906110002\", \"ID4447124106916010001\", \"ID4447124106910310001\", \"ID4447124106910310003\", \"ID4447124106910310002\", \"ID4447124106885710001\", \"ID4447124258794710001\", \"ID4447124258795410001\", \"ID4447124106924410001\", \"ID4447124106911110002\", \"ID4447124106911110001\", \"ID4447124106875810001\", \"ID4447124106875810002\", \"ID4447124106876610001\", \"ID4447124106876610002\", \"ID4447124106907910001\", \"ID4447124106887310002\", \"ID4447124106887310003\", \"ID4447124106887310001\", \"ID4447124106905310002\", \"ID4447124106905310001\", \"ID4447124106925120002\", \"ID4447124106890710001\", \"ID4447124106890710004\", \"ID4447124106890710002\", \"ID4447124106890710003\", \"ID4447124106890710005\", \"ID4447124106890710006\", \"ID4447124106891510001\", \"ID4447124106919410002\", \"ID4447124106886510001\", \"ID4447124106886510002\", \"ID4447124106882410001\", \"ID4447124106882410002\", \"ID4447124106896410001\", \"ID4447124106898010001\", \"ID4447124106898010002\", \"ID4447124106889910001\", \"ID4447124106889910002\", \"ID4447124106904610001\", \"ID4447124106904610002\", \"ID4447124106880810001\", \"ID4447124106880810002\", \"ID4447124106880810003\", \"ID4447124106900410001\", \"ID4447124106921010002\", \"ID4447124106921010001\", \"ID4447124106914510001\", \"ID4447124106914510002\", \"ID4448125110715010004\", \"ID4448125110715010005\", \"ID4448125110715010001\", \"ID4448125110715010002\", \"ID4448125110715010003\", \"ID4448125110796010002\", \"ID4448125110796010001\", \"ID4448125110797810002\", \"ID4448125110797810003\", \"ID4448125110797810001\", \"ID4448125110798610004\", \"ID4448125110798610001\", \"ID4448125110798610002\", \"ID4448125110798610003\", \"ID4448125110699610001\", \"ID4448125110699610002\", \"ID4448125110699610003\", \"ID4448125110795210001\", \"ID4448125110801810002\", \"ID4448125110801810001\", \"ID4448125110800010001\", \"ID4448125110811710001\", \"ID4448125110714310002\", \"ID4448125110714310003\", \"ID4448125110714310001\", \"ID4448125110698810002\", \"ID4448125110698810001\", \"ID4448125110818210001\", \"ID4448125110805910001\", \"ID4448125110819010001\", \"ID4448125110819010002\", \"ID4448125110819010003\", \"ID4448125110819010004\", \"ID4448125110705110002\", \"ID4448125110705110001\", \"ID4448125110816610003\", \"ID4448125110816610004\", \"ID4448125110816610005\", \"ID4448125110816610001\", \"ID4448125110816610002\", \"ID4448125110808310002\", \"ID4448125110808310003\", \"ID4448125110808310004\", \"ID4448125110808310001\", \"ID4448125110808310005\", \"ID4448125110822410001\", \"ID4448125110822410002\", \"ID4448125110822410004\", \"ID4448125110822410003\", \"ID4448125110815810005\", \"ID4448125110815810001\", \"ID4448125110815810003\", \"ID4448125110815810004\", \"ID4448125110817410001\", \"ID4448125110702810002\", \"ID4448125110702810003\", \"ID4448125110702810004\", \"ID4448125110702810001\", \"ID4448125110701010004\", \"ID4448125110701010006\", \"ID4448125110701010001\", \"ID4448125110701010002\", \"ID4448125110701010003\", \"ID4448125110701010005\", \"ID4448125110807510001\", \"ID4448125110820810001\", \"ID4448125110803410002\", \"ID4448125110803410003\", \"ID4448125110803410001\", \"ID4448125110803410004\", \"ID4448125110804210001\", \"ID4448125110821610001\", \"ID4448125110821610002\", \"ID4448125110821610003\", \"ID4448125110802610002\", \"ID4448125110802610001\", \"ID4448125110802610003\", \"ID4448125110802610004\", \"ID4450127238368310004\", \"ID4450127238368310001\", \"ID4450127238368310003\", \"ID4450127238368310005\", \"ID4450127238368310002\", \"ID4450127238387310002\", \"ID4450127238387310003\", \"ID4450127238387310001\", \"ID4450127238383210002\", \"ID4450127238383210001\", \"ID4450127238383210004\", \"ID4450127238383210005\", \"ID4450127238376610001\", \"ID4450127238376610003\", \"ID4450127238376610002\", \"ID4450127238404610002\", \"ID4450127238404610001\", \"ID4450127238379010003\", \"ID4450127238379010004\", \"ID4450127238379010001\", \"ID4450127238379010002\", \"ID4450127238398010001\", \"ID4450127238398010002\", \"ID4450127238358410001\", \"ID4450127238350110001\", \"ID4450127238350110002\", \"ID4450127238362610001\", \"ID4450127238362610002\", \"ID4450127238399810001\", \"ID4450127238399810002\", \"ID4450127238399810003\", \"ID4450127238399810004\", \"ID4450127238359210001\", \"ID4450127238359210002\", \"ID4450127238389910001\", \"ID4450127238389910002\", \"ID4450127238389910003\", \"ID4450127238354310001\", \"ID4450127238354310003\", \"ID4450127238354310002\", \"ID4450127238378210004\", \"ID4450127238378210001\", \"ID4450127238378210002\", \"ID4450127238378210003\", \"ID4450127238355010001\", \"ID4450127238355010002\", \"ID4450127238381610002\", \"ID4450127238381610003\", \"ID4450127238381610001\", \"ID4450127238381610004\", \"ID4450127238406110001\", \"ID4450127238360010001\", \"ID4450127238360010002\", \"ID4450127238349310001\", \"ID4450127238349310002\", \"ID4450127238349310003\", \"ID4450127238352710002\", \"ID4450127238352710003\", \"ID4450127238352710001\", \"ID4450127238384010001\", \"ID4450127238384010002\", \"ID4450127238384010003\", \"ID4450127238384010004\", \"ID4450127238384010005\", \"ID4450127238365910002\", \"ID4450127238374110002\", \"ID4450127238374110003\", \"ID4450127238374110001\", \"ID4450127238405310002\", \"ID4450127238405310001\", \"ID4450127238385710001\", \"ID4450127238385710003\", \"ID4450127238385710002\", \"ID4450127238375810001\", \"ID4450127238397210001\", \"ID4450127238397210003\", \"ID4450127238397210002\", \"ID4450127238397210004\", \"ID4450127238372510001\", \"ID4450127238388110002\", \"ID4450127238388110001\", \"ID4450127238394910003\", \"ID4450127238394910004\", \"ID4450127238394910001\", \"ID4450127238394910002\", \"ID4450127238395610001\", \"ID4450127238395610002\", \"ID4450127238391510002\", \"ID4450127238391510001\", \"ID4450127238386510001\", \"ID4450127238386510002\", \"ID4450127238386510003\", \"ID4450127238364210001\", \"ID4450127238364210002\", \"ID4450127238409510001\", \"ID4450127238409510002\", \"ID4450127238409510003\", \"ID4450127238403810002\", \"ID4450127238403810001\", \"ID4450127257775510002\", \"ID4450127257775510001\", \"ID4450127238348510001\", \"ID4450127238367510001\", \"ID4450127238357610001\", \"ID4450127238357610002\", \"ID4450127238396410001\", \"ID4450127238377410001\", \"ID4450127238377410003\", \"ID4450127238377410002\", \"ID4450127238407910002\", \"ID4450127238407910001\", \"ID4450127238401210003\", \"ID4450127238401210001\", \"ID4450127238401210002\", \"ID4450127238361810002\", \"ID4450127238361810004\", \"ID4450127238361810001\", \"ID4450127238361810003\", \"ID4450127238361810005\", \"ID4450127238371710001\", \"ID4450127238371710002\", \"ID4450127238369110001\", \"ID4450127238393110002\", \"ID4450127238393110003\", \"ID4450127238393110001\", \"ID4450127238353510002\", \"ID4450127238353510003\", \"ID4450127238353510001\", \"ID4450127238353510004\", \"ID4450127238366710001\", \"ID4450127238366710002\", \"ID4450127238382410004\", \"ID4450127238382410005\", \"ID4450127238382410001\", \"ID4450127238382410002\", \"ID4450127238382410003\", \"ID4450127238400410001\", \"ID4450127238356810001\", \"ID4450127238356810002\", \"ID4450127238356810003\", \"ID4450127238380810001\", \"ID4450127238380810003\", \"ID4450127238380810004\", \"ID4450127238380810002\", \"ID4450127238370910001\", \"ID4445112314664910001\", \"ID4445112314670610001\", \"ID4445112314670610002\", \"ID4445113314679710001\", \"ID4445113314682110001\", \"ID4445113314682110002\", \"ID4445113314680510001\", \"ID4445113314680510003\", \"ID4445113314680510004\", \"ID4445113314680510002\", \"ID4445113314680510005\", \"ID4445113314680510006\", \"ID4445113314675510001\", \"ID4445113314675510002\", \"ID4445113314675510003\", \"ID4445113314674810001\", \"ID4445113314674810002\", \"ID4445113314674810003\", \"ID4445113314674810005\", \"ID4445113314674810004\", \"ID4445113314681310001\", \"ID4445113314681310003\", \"ID4445113314681310002\", \"ID4445113314681310004\", \"ID4445113314681310005\", \"ID4445113314681310006\", \"ID4445112314672210001\", \"ID4445112314672210003\", \"ID4445112314672210002\", \"ID4445112314666410001\", \"ID4445112314666410002\", \"ID4445113314673010001\", \"ID4445113314673010003\", \"ID4445113314673010004\", \"ID4445113314673010005\", \"ID4445113314673010002\", \"ID4445113314676310001\", \"ID4445113314676310002\", \"ID4445113314676310003\", \"ID4445112314667210001\", \"ID4445112314667210003\", \"ID4445112314667210005\", \"ID4445112314667210006\", \"ID4445112314667210002\", \"ID4445112314667210004\", \"ID4445112314671410001\", \"ID4445112314671410004\", \"ID4445112314671410002\", \"ID4445112314671410003\", \"ID4445113314678910001\", \"ID4445113314678910002\", \"ID4445112314665610001\", \"ID4445112314665610002\", \"ID4445113314677110001\", \"ID4445113314677110002\", \"ID4445113314677110004\", \"ID4445113314677110003\", \"ID4449126128949510001\", \"ID4449126128949510002\", \"ID4449126128933910001\", \"ID4449126128933910003\", \"ID4449126128933910002\", \"ID4449126128936210001\", \"ID4449126128936210004\", \"ID4449126128936210002\", \"ID4449126128936210003\", \"ID4449126128947910001\", \"ID4449126128947910003\", \"ID4449126128947910002\", \"ID4449126128938810001\", \"ID4449126128938810003\", \"ID4449126128938810002\", \"ID4449126128938810004\", \"ID4449126128942010001\", \"ID4449126128942010002\", \"ID4449126128942010003\", \"ID4449126128942010004\", \"ID4449126128948710001\", \"ID4449126128948710003\", \"ID4449126128948710002\", \"ID4449126128939610001\", \"ID4449126128939610002\", \"ID4449126128944610002\", \"ID4449126128944610001\", \"ID4449126128929710001\", \"ID4449126128929710002\", \"ID4449126128929710003\", \"ID4449126128929710004\", \"ID4449126128932110001\", \"ID4449126128932110002\", \"ID4449126128932110003\", \"ID4449126128932110004\", \"ID4449126128932110005\", \"ID4449126128925510001\", \"ID4449126128925510002\", \"ID4449126128943810001\", \"ID4449126128943810002\", \"ID4449126128943810003\", \"ID4449126128926310001\", \"ID4449126128926310002\", \"ID4449126128940410001\", \"ID4449126128940410002\", \"ID4449126128928910001\", \"ID4449126128928910002\", \"ID4449126128935410001\", \"ID4449126128934710001\", \"ID4449126128934710002\", \"ID4449126128934710003\", \"ID4449126128934710004\", \"ID4449126128931310001\", \"ID4449126128931310002\", \"ID4449126128946110001\", \"ID4449126128946110002\", \"ID4449126128930510001\", \"ID4449126128930510005\", \"ID4449126128930510002\", \"ID4449126128930510003\", \"ID4449126128930510004\", \"ID4449126128941210001\", \"ID4449126128941210002\", \"ID4449126128950310001\", \"ID4449126128950310002\", \"ID4449126128927110001\", \"ID4449126128927110003\", \"ID4449126128927110002\", \"ID4449126128937010001\", \"ID4449126128937010002\", \"ID4449126128945310001\", \"ID4449126128945310002\"]',1,NULL,NULL,449),(3,'SURNAME',2,NULL,'[\"ANDERSON\", \"ANDERSON\", \"ANDERSON\", \"ANDERSON\", \"AQUENDO\", \"BENITEZ\", \"BENITEZ\", \"BENITEZ\", \"BODNER\", \"BODNER\", \"BODNER\", \"BODNER\", \"BODNER\", \"CENTURY\", \"CENTURY\", \"CENTURY\", \"CHEESMAN\", \"CHEESMAN\", \"CONYERE\", \"CONYERE\", \"COSGRAVE\", \"COSGRAVE\", \"COSGRAVE\", \"COSGRAVE\", \"COSGRAVE\", \"DANIEL LEIVA\", \"DANIEL LEIVA\", \"DARCOURT\", \"DECANAY\", \"DECANAY\", \"DECANAY\", \"DIVERS\", \"DOMINGUEZ\", \"DOMINGUEZ\", \"FAUST\", \"FISCHGRUND\", \"FISCHGRUND\", \"FISCHGRUND\", \"GENE\", \"GENE\", \"GIERINGER\", \"GIERINGER\", \"GIERINGER\", \"GIERINGER\", \"GIERINGER\", \"GREEN\", \"GREEN\", \"HENNEGGEY\", \"HENNEGGEY\", \"HILL\", \"JIMENCZ\", \"JIMENCZ\", \"JIMENCZ\", \"JIMENEZ\", \"KAY\", \"KELLY\", \"KILLION\", \"LAKATOS\", \"LAKATOS\", \"LASSITER\", \"LASSITER\", \"LASSITER\", \"LASSITER\", \"LETO\", \"MALDONADO\", \"MALDONADO\", \"MALDONADO\", \"MALENDES\", \"MALENDES\", \"MCCLAIN\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"PAIGIE\", \"PARVA\", \"PARVA\", \"RODRIGUEZ\", \"RODRIGUEZ\", \"ROUNSEVELLE\", \"SKANOS\", \"SKANOS\", \"TORRES\", \"TORRES\", \"VALDES\", \"VALDES\", \"VARGAS\", \"VARGAS\", \"VARGAS\", \"VARGAS\", \"WEBSTER\", \"WEBSTER\", \"WICZALKOWSKI\", \"WICZALKOWSKI\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BARNES\", \"BARNES\", \"BURGERSS\", \"BURGERSS\", \"BURGERSS\", \"BURGESS\", \"BURGESS\", \"BURGESS\", \"BURGESS\", \"BURRISS\", \"BURRISS\", \"BURRISS\", \"BUTLER\", \"CHISOLM\", \"CHISOLM\", \"COATES\", \"CONRON\", \"COTTEN\", \"COTTEN\", \"COTTEN\", \"DIGGS\", \"DIGGS\", \"DORSIE\", \"DUNNOCK\", \"GOINS\", \"GOINS\", \"GOINS\", \"GOINS\", \"GOWANS\", \"GOWANS\", \"HOERRLING\", \"HOERRLING\", \"HOERRLING\", \"HOERRLING\", \"HOERRLING\", \"HOLMES\", \"HOLMES\", \"HOLMES\", \"HOLMES\", \"HOLMES\", \"HUGGINCHES\", \"HUGGINCHES\", \"HUGGINCHES\", \"HUGGINCHES\", \"HUTCHINSON\", \"HUTCHINSON\", \"HUTCHINSON\", \"HUTCHINSON\", \"LEVEN\", \"MATKIN\", \"MATKIN\", \"MATKIN\", \"MATKIN\", \"OWENS\", \"OWENS\", \"OWENS\", \"OWENS\", \"OWENS\", \"OWENS\", \"PAIGE\", \"SPRINGGS\", \"SYKES\", \"SYKES\", \"SYKES\", \"SYKES\", \"THOMPSON\", \"TREZEVANT\", \"TREZEVANT\", \"TREZEVANT\", \"WHITAKER\", \"WHITAKER\", \"WHITAKER\", \"WHITAKER\", \"1RUMOR\", \"1RUMOR\", \"1RUMOR\", \"1RUMOR\", \"1RUMOR\", \"ALSTIN\", \"ALSTIN\", \"ALSTIN\", \"CAMPBELL\", \"CAMPBELL\", \"CAMPBELL\", \"CAMPBELL\", \"CARR\", \"CARR\", \"CARR\", \"CARTER\", \"CARTER\", \"CAVAJEL\", \"CAVAJEL\", \"CAVAJEL\", \"CAVAJEL\", \"CHAMBARS\", \"CHAMBARS\", \"COLBY\", \"COUPE\", \"COUPE\", \"CRIDER\", \"CRIDER\", \"DAVIES\", \"DAVIES\", \"DAVIES\", \"DAVIES\", \"DEGRAENED\", \"DEGRAENED\", \"DORMAN\", \"DORMAN\", \"DORMAN\", \"DOWOKAKOKO\", \"DOWOKAKOKO\", \"DOWOKAKOKO\", \"EASLEY\", \"EASLEY\", \"EASLEY\", \"EASLEY\", \"ELLIOTT\", \"ELLIOTT\", \"ERVINE\", \"ERVINE\", \"ERVINE\", \"ERVINE\", \"FREY\", \"GARRETT\", \"GARRETT\", \"GORDON\", \"GORDON\", \"GORDON\", \"GRANER\", \"GRANER\", \"GRANER\", \"GREENE\", \"GREENE\", \"GREENE\", \"GREENE\", \"GREENE\", \"GUIDETI\", \"HAMMONDS\", \"HAMMONDS\", \"HAMMONDS\", \"HANKINS\", \"HANKINS\", \"HEAVENER\", \"HEAVENER\", \"HEAVENER\", \"HETTERICH\", \"HOLLEY\", \"HOLLEY\", \"HOLLEY\", \"HOLLEY\", \"HUDSON\", \"HUSSEINKHEL\", \"HUSSEINKHEL\", \"KEARNS\", \"KEARNS\", \"KEARNS\", \"KEARNS\", \"KEICHENBERG\", \"KEICHENBERG\", \"KLEIMAN\", \"KLEIMAN\", \"LESKO\", \"LESKO\", \"LESKO\", \"MACCIO\", \"MACCIO\", \"MARTINEZ STG\", \"MARTINEZ STG\", \"MARTINEZ STG\", \"MCALLISTER\", \"MCALLISTER\", \"MOHRING\", \"MOHRING\", \"MOSES\", \"OBROCK\", \"PEARL\", \"PEARL\", \"RAGLIN\", \"REAVES\", \"REAVES\", \"REAVES\", \"RODRIGUEZ\", \"RODRIGUEZ\", \"ROTHSHILD\", \"ROTHSHILD\", \"ROTHSHILD\", \"RUDASILL\", \"RUDASILL\", \"RUDASILL\", \"RUDASILL\", \"RUDASILL\", \"RUEHLING\", \"RUEHLING\", \"RUMOR\", \"RUSSALL\", \"RUSSALL\", \"RUSSALL\", \"SANTIAGO\", \"SANTIAGO\", \"SANTIAGO\", \"SANTIAGO\", \"SQUILLANTE\", \"SQUILLANTE\", \"SWAGOI\", \"SWAGOI\", \"SWAGOI\", \"SWAGOI\", \"SWAGOI\", \"SYKS\", \"TONSTALL\", \"TONSTALL\", \"TONSTALL\", \"WASHINGTON\", \"WASHINGTON\", \"WASHINGTON\", \"WASHINGTON\", \"WIESMAN\", \"BELL\", \"BRAWD\", \"BRAWD\", \"CARTER\", \"DUCOTY\", \"DUCOTY\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"EHM\", \"EHM\", \"EHM\", \"GASBARRO\", \"GASBARRO\", \"GASBARRO\", \"GASBARRO\", \"GASBARRO\", \"HELLER\", \"HELLER\", \"HELLER\", \"HELLER\", \"HELLER\", \"HELLER\", \"HOPPER\", \"HOPPER\", \"HOPPER\", \"HUBRIC\", \"HUBRIC\", \"PAINE WELLS\", \"PAINE WELLS\", \"PAINE WELLS\", \"PAINE WELLS\", \"PAINE WELLS\", \"PENSETH\", \"PENSETH\", \"PENSETH\", \"POLLACK\", \"POLLACK\", \"POLLACK\", \"POLLACK\", \"POLLACK\", \"POLLACK\", \"ROWEN\", \"ROWEN\", \"ROWEN\", \"ROWEN\", \"SAUNDERS\", \"SAUNDERS\", \"SCCHWARTZ\", \"SCCHWARTZ\", \"SMALLS\", \"SMALLS\", \"SMALLS\", \"SMALLS\", \"ARCHER\", \"ARCHER\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"CAGER\", \"CAGER\", \"CAGER\", \"COBEZA\", \"COBEZA\", \"COBEZA\", \"COBEZA\", \"DORSEY\", \"DORSEY\", \"DORSEY\", \"DORSEY\", \"DRENMON\", \"DRENMON\", \"DRENMON\", \"FLEEK\", \"FLEEK\", \"FLOWERS\", \"FLOWERS\", \"GALIDEZ\", \"GALIDEZ\", \"GALIDEZ\", \"GALIDEZ\", \"HILLEGAS\", \"HILLEGAS\", \"HILLEGAS\", \"HILLEGAS\", \"HILLEGAS\", \"HOLLOWAY\", \"HOLLOWAY\", \"KEARNEY\", \"KEARNEY\", \"KEARNEY\", \"MANGUM\", \"MANGUM\", \"MITCHELLL\", \"MITCHELLL\", \"RADRIGZ\", \"RADRIGZ\", \"RAMAS\", \"RHODES\", \"RHODES\", \"RHODES\", \"RHODES\", \"RIBERA\", \"RIBERA\", \"RICHARDSON\", \"RICHARDSON\", \"STAPPY\", \"STAPPY\", \"STAPPY\", \"STAPPY\", \"STAPPY\", \"STEWARD\", \"STEWARD\", \"WCIGNT\", \"WCIGNT\", \"WILKES\", \"WILKES\", \"WILKES\", \"WILLIAMS\", \"WILLIAMS\", \"YETES\", \"YETES\"]',1,NULL,NULL,449),(4,'NAME',3,NULL,'[\"\", \"\", \"\", \"\", \"CLARA\", \"LEARONAD\", \"SAMUEL\", \"DELORES\", \"JAMEL\", \"ROSETTA\", \"MADGE\", \"ROSALIND\", \"CAROLYN\", \"IVAN\", \"RAMON\", \"ALICIA\", \"DONYA\", \"DONTE\", \"DOMINIQUE\", \"CONNIE\", \"SEKOV\", \"TIERRA\", \"THERSA\", \"\", \"\", \"SAMMY\", \"THAOLYNN\", \"\", \"MICHEAL\", \"AJASIA\", \"BRIANCE\", \"MILEORD\", \"FRANKLIN\", \"SHAVON\", \"ANNA\", \"WESTLEY\", \"NADESDIA\", \"DANYCE\", \"MICHAEL\", \"CASSANDRA\", \"GHOLOM\", \"JEFFERY\", \"JEFFERY\", \"DOUGLAS\", \"MAIRE\", \"TEMPESTT\", \"\", \"\", \"\", \"RAYMOND\", \"IRVIN\", \"AUNDERE\", \"WILLPAMINA\", \"BARBARA\", \"\", \"\", \"JORGE\", \"TONYA\", \"DANEILLE\", \"\", \"\", \"DOROTHEA\", \"LELIA\", \"JOSEPH\", \"DEWIGHT\", \"MARQUISE\", \"MABLE\", \"\", \"\", \"\", \"AISHA\", \"ANDREA\", \"ROMINE\", \"TANYA\", \"PRINCETTA\", \"LAKESHIA\", \"HERMEN\", \"XANTHE\", \"JEMES\", \"\", \"TOWANDA\", \"GEARLDINE\", \"DEREK\", \"DAVON\", \"LENORA\", \"RANDOLPH\", \"FREEMAN\", \"WAYNE\", \"THRESA\", \"BRANDEN\", \"ALEXANDER\", \"ELIZABETH\", \"THUYKIM\", \"DANNY\", \"SHALLY\", \"ALEXANDER\", \"DOLORES\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"LATISHA\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"REFUS\", \"CHRISTOPHER\", \"ZACHARY\", \"TRAINA\", \"ANA\", \"GERALDO\", \"FRANCISCO\", \"ERICK\", \"LUCILLE\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"ROY\", \"\", \"\", \"\", \"\", \"ROSETTA\", \"JACQUELINE\", \"ANA\", \"\", \"\", \"\", \"\", \"\", \"DIWALDO\", \"BERNADINA\", \"TERRAN\", \"ZAKIYA\", \"\", \"LEO\", \"MICHEAL\", \"ROSE\", \"ANTONINO\", \"JESSICA\", \"MARINELA\", \"\", \"DARRYL\", \"BERRY\", \"ROSELINE\", \"RODRICK\", \"JOANNIE\", \"ADMAN\", \"STEPHEN\", \"MALISSA\", \"SARAH\", \"LAWRENCE\", \"EUGENE\", \"\", \"MARKO\", \"\", \"GUILLERMO\", \"MARCO\", \"W\", \"MICHELE\", \"RENEE\", \"SARAH\", \"GERARDO\", \"ALLAN\", \"\", \"\", \"\", \"GREG\", \"A\", \"\", \"MATTHEW\", \"FLORIPE\", \"KERI\", \"NILSA\", \"CHERYL\", \"FLAINE\", \"ALE JARDRO\", \"JUAN\", \"ZIONARA\", \"\", \"ETHNY\", \"SHAWNETT\", \"HARRIET\", \"KRISTY\", \"DIANE\", \"ROSEMARIE\", \"DANIEL\", \"ROBERT\", \"MARJORIE\", \"EDUARDSO\", \"SONDRA\", \"ANN\", \"MICHELE\", \"ROSETA\", \"\", \"JAMES\", \"LENWOOD\", \"TRACEY\", \"STEPHENE\", \"PAYMM\", \"\", \"\", \"\", \"JOHNNY\", \"MICHEAL\", \"DIMON\", \"KATHERINE\", \"CHARLOTTE\", \"JACQUELINE\", \"ARCHIE\", \"\", \"\", \"\", \"\", \"\", \"SUSAN\", \"JUDY\", \"ANTONIO\", \"JOCELYN\", \"CLEARANCE\", \"BEN\", \"\", \"ORESTE\", \"OLIVIA\", \"ERIKA\", \"\", \"\", \"GEOFFREY\", \"JEANETTE\", \"DOMINIQUE\", \"JANICE\", \"SHIRLEG\", \"\", \"\", \"\", \"REYAN\", \"\", \"\", \"\", \"QUENTIN\", \"STEPHANIE\", \"PHILLIP\", \"J\", \"HILLIARD\", \"DOMINIC\", \"SEPTIMIA\", \"KIMBERLY\", \"ALISA\", \"\", \"TRACIE\", \"MELISSA\", \"\", \"MYRIAM\", \"JORGE\", \"LYNNETTE\", \"PELHAM\", \"GEORGE\", \"ANGELA\", \"JESSEE\", \"LUIS\", \"GERAR\", \"CHARLES\", \"ISRAEL\", \"MARY CAROLE\", \"\", \"\", \"KATHERINE\", \"NICHOLE\", \"MARY\", \"HARRIETT\", \"J\", \"STEPHENS\", \"AMAURY\", \"XIOMARA\", \"\", \"GLORIANNE\", \"ALLEN\", \"ANN0\", \"JEAN\", \"DOUGASS\", \"MICLELLE\", \"L\", \"D\", \"BENJAMIN\", \"ALICIA\", \"GERALDENE\", \"NATSHA\", \"JESUS\", \"ETHEL\", \"\", \"PABLOS\", \"LEANNE\", \"ERIN\", \"JO\", \"\", \"DIXION\", \"DOREN\", \"TEGIRA\", \"AGELEON\", \"\", \"\", \"ARISTIDES\", \"CARLOS\", \"ROSEY\", \"CHARLES\", \"DIANE\", \"SIGFREDO\", \"AGEL\", \"OSWALDO\", \"IGNACIO\", \"BARBARA\", \"JEFFREY\", \"THRESA\", \"ANNE\", \"ANDREW E\", \"JAMAR\", \"DARON\", \"SHAWN\", \"MIRIAM\", \"LEAH\", \"CHRISTOPHER\", \"EARNEST\", \"CATHY\", \"ELFRIEDA\", \"NICOLAS\", \"CATHERINE\", \"JOHN\", \"TRICIA\", \"JEFFREY\", \"INGER\", \"\", \"\", \"MARC\", \"JEAN\", \"LAWRENCE\", \"JEFF\", \"SOUTA\", \"ELMER\", \"WILEY\", \"GISELA\", \"RUTH ANN\", \"EDWIN\", \"EARLE\", \"ROSETTA\", \"RONNIE\", \"KENNETH\", \"SHAWN\", \"\", \"ARY\", \"MELISSA\", \"DEBBIE\", \"ENDA\", \"ISSAC\", \"ERNEST\", \"THERESA\", \"JOANNIE\", \"ANNTIONETTE\", \"STANLY\", \"COVNELIA\", \"KEN\", \"ENZELEE\", \"MICHELLE\", \"CHATERAH\", \"GIANNI\", \"JANICE\", \"HAILLE\", \"ROSA\", \"JAMIE\", \"SCOT\", \"JENIFFER\", \"SHANIKA\", \"ASHELY\", \"SHERMISE\", \"ROB\", \"BAKIA\", \"JEROME\", \"DONETTA\", \"JOSH\", \"RUGY\", \"SONJA\", \"JEFF\", \"HENRIETTE\", \"JANNIE\", \"JOANN\", \"JOHONNY\", \"STUART\", \"EMMETTE\", \"TAMIKA\", \"JEFF\", \"FRANKLIN\", \"ELLA LOUISE\", \"QUAYN\", \"ARLIE\", \"FREDERICK\", \"CHANTEL\", \"BRIAN\", \"MAXICINE\", \"BEN\", \"STEVE\", \"HARRIETTE\", \"CHARLIE\", \"SHERRI\", \"CHANCE\", \"ALFREDRICK\"]',1,NULL,NULL,449),(5,'LASTCODE',4,NULL,'[\"\", \"\", \"\", \"\", \"J\", \"A\", \"R\", \"R\", \"C\", \"L\", \"R\", \"N\", \"L\", \"R\", \"L\", \"B\", \"L\", \"\", \"S\", \"E\", \"L\", \"\", \"G\", \"L\", \"C\", \"J\", \"R\", \"G\", \"A\", \"M\", \"G\", \"J\", \"K\", \"M\", \"N\", \"M\", \"A\", \"L\", \"C\", \"C\", \"W\", \"W\", \"W\", \"D\", \"T\", \"Z\", \"L\", \"L\", \"L\", \"G\", \"V\", \"V\", \"S\", \"M\", \"\", \"\", \"L\", \"M\", \"S\", \"J\", \"\", \"K\", \"\", \"E\", \"B\", \"\", \"\", \"\", \"A\", \"\", \"C\", \"G\", \"O\", \"O\", \"D\", \"O\", \"M\", \"N\", \"V\", \"G\", \"S\", \"\", \"\", \"B\", \"S\", \"E\", \"R\", \"H\", \"\", \"R\", \"R\", \"L\", \"\", \"A\", \"\", \"J\", \"A\", \"D\", \"\", \"A\", \"P\", \"P\", \"B\", \"C\", \"L\", \"D\", \"L\", \"L\", \"E\", \"C\", \"D\", \"A\", \"\", \"\", \"\", \"A\", \"J\", \"\", \"D\", \"C\", \"R\", \"A\", \"A\", \"A\", \"A\", \"M\", \"L\", \"T\", \"R\", \"\", \"D\", \"M\", \"D\", \"D\", \"B\", \"A\", \"C\", \"S\", \"D\", \"D\", \"W\", \"\", \"R\", \"R\", \"A\", \"M\", \"\", \"\", \"\", \"\", \"M\", \"L\", \"L\", \"\", \"\", \"L\", \"G\", \"E\", \"T\", \"N\", \"S\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"M\", \"M\", \"T\", \"F\", \"C\", \"M\", \"T\", \"A\", \"\", \"L\", \"A\", \"A\", \"E\", \"\", \"\", \"E\", \"A\", \"E\", \"D\", \"B\", \"J\", \"D\", \"\", \"\", \"L\", \"D\", \"L\", \"L\", \"\", \"F\", \"J\", \"\", \"P\", \"E\", \"M\", \"U\", \"N\", \"M\", \"N\", \"D\", \"R\", \"W\", \"R\", \"N\", \"S\", \"A\", \"A\", \"\", \"D\", \"D\", \"D\", \"\", \"A\", \"A\", \"E\", \"T\", \"E\", \"B\", \"R\", \"R\", \"L\", \"M\", \"\", \"\", \"R\", \"A\", \"A\", \"C\", \"A\", \"M\", \"A\", \"D\", \"C\", \"M\", \"R\", \"\", \"T\", \"R\", \"R\", \"V\", \"\", \"T\", \"T\", \"A\", \"E\", \"\", \"\", \"\", \"A\", \"\", \"E\", \"M\", \"L\", \"A\", \"B\", \"V\", \"\", \"\", \"\", \"S\", \"E\", \"M\", \"\", \"\", \"M\", \"M\", \"B\", \"M\", \"\", \"G\", \"\", \"C\", \"\", \"B\", \"J\", \"D\", \"R\", \"R\", \"\", \"L\", \"E\", \"A\", \"E\", \"L\", \"M\", \"S\", \"D\", \"A\", \"A\", \"S\", \"L\", \"C\", \"\", \"L\", \"E\", \"T\", \"A\", \"\", \"A\", \"M\", \"T\", \"B\", \"C\", \"M\", \"L\", \"C\", \"J\", \"P\", \"I\", \"P\", \"E\", \"V\", \"M\", \"J\", \"D\", \"B\", \"S\", \"C\", \"A\", \"J\", \"M\", \"\", \"L\", \"M\", \"A\", \"J\", \"M\", \"U\", \"\", \"K\", \"\", \"A\", \"J\", \"J\", \"J\", \"M\", \"J\", \"A\", \"C\", \"C\", \"B\", \"P\", \"\", \"J\", \"J\", \"J\", \"J\", \"C\", \"J\", \"A\", \"A\", \"\", \"F\", \"S\", \"P\", \"J\", \"A\", \"J\", \"A\", \"\", \"C\", \"G\", \"L\", \"F\", \"E\", \"P\", \"B\", \"J\", \"A\", \"C\", \"A\", \"C\", \"J\", \"M\", \"A\", \"A\", \"M\", \"M\", \"M\", \"M\", \"J\", \"\", \"R\", \"E\", \"M\", \"S\", \"J\", \"M\", \"L\", \"F\", \"R\", \"A\", \"\", \"\", \"J\", \"M\", \"E\", \"E\", \"M\", \"M\", \"E\", \"\", \"E\", \"C\", \"E\", \"C\", \"T\", \"E\", \"E\", \"J\", \"J\", \"E\", \"J\", \"M\", \"D\", \"E\", \"K\", \"L\", \"\", \"M\", \"N\", \"U\", \"K\", \"E\", \"R\", \"F\", \"E\", \"F\", \"B\", \"A\", \"A\", \"A\", \"\", \"H\", \"W\", \"M\", \"L\", \"A\", \"V\", \"E\", \"S\"]',1,NULL,NULL,449),(6,'NUMCODE',5,NULL,'[\"4848\", \"4848\", \"4848\", \"4848\", \"666\", \"660\", \"660\", \"660\", \"102\", \"102\", \"102\", \"102\", \"102\", \"4906\", \"4906\", \"4906\", \"690\", \"690\", \"4836\", \"4836\", \"202\", \"202\", \"202\", \"202\", \"202\", \"729\", \"729\", \"4802\", \"112\", \"112\", \"112\", \"658\", \"672\", \"672\", \"652\", \"110\", \"110\", \"110\", \"686\", \"686\", \"200\", \"200\", \"200\", \"200\", \"200\", \"4816\", \"4816\", \"102\", \"102\", \"4810\", \"214\", \"214\", \"214\", \"674\", \"4926\", \"4932\", \"4914\", \"206\", \"206\", \"654\", \"654\", \"656\", \"656\", \"104\", \"678\", \"678\", \"678\", \"705\", \"705\", \"4920\", \"682\", \"682\", \"682\", \"682\", \"682\", \"682\", \"684\", \"4830\", \"676\", \"676\", \"670\", \"670\", \"100\", \"104\", \"104\", \"680\", \"680\", \"723\", \"723\", \"664\", \"664\", \"664\", \"727\", \"4842\", \"4842\", \"210\", \"210\", \"6540\", \"6540\", \"6540\", \"6540\", \"6540\", \"6550\", \"6550\", \"6556\", \"6556\", \"6556\", \"6560\", \"6560\", \"6560\", \"6560\", \"6500\", \"6500\", \"6500\", \"6546\", \"6578\", \"6578\", \"6566\", \"110\", \"6526\", \"6526\", \"6526\", \"4952\", \"4952\", \"117\", \"953\", \"115\", \"115\", \"115\", \"115\", \"6520\", \"6520\", \"114\", \"114\", \"114\", \"114\", \"114\", \"108\", \"108\", \"108\", \"108\", \"108\", \"109\", \"109\", \"109\", \"109\", \"112\", \"112\", \"112\", \"112\", \"957\", \"6514\", \"6514\", \"6514\", \"6514\", \"6508\", \"6508\", \"6508\", \"6508\", \"6508\", \"6508\", \"106\", \"113\", \"4901\", \"4901\", \"4901\", \"4901\", \"6532\", \"111\", \"111\", \"111\", \"4913\", \"4913\", \"4913\", \"4913\", \"3820\", \"3820\", \"3820\", \"3820\", \"3820\", \"612\", \"612\", \"612\", \"604\", \"604\", \"604\", \"604\", \"501\", \"501\", \"501\", \"14135\", \"14135\", \"607\", \"607\", \"607\", \"607\", \"14180\", \"14180\", \"303\", \"104\", \"104\", \"106\", \"106\", \"14220\", \"14220\", \"14220\", \"14220\", \"128\", \"128\", \"616\", \"616\", \"616\", \"103\", \"103\", \"103\", \"613\", \"613\", \"613\", \"613\", \"102\", \"102\", \"601\", \"601\", \"601\", \"601\", \"14225\", \"124\", \"124\", \"303\", \"303\", \"303\", \"100\", \"100\", \"100\", \"606\", \"606\", \"606\", \"606\", \"606\", \"3454\", \"505\", \"505\", \"505\", \"14215\", \"14215\", \"608\", \"608\", \"608\", \"503\", \"14170\", \"14170\", \"14170\", \"14170\", \"3886\", \"614\", \"614\", \"626\", \"626\", \"626\", \"626\", \"14150\", \"14150\", \"622\", \"622\", \"610\", \"610\", \"610\", \"106\", \"106\", \"14255\", \"14255\", \"14255\", \"14270\", \"14270\", \"701\", \"701\", \"305\", \"3732\", \"209\", \"209\", \"14160\", \"625\", \"625\", \"625\", \"14235\", \"14235\", \"14240\", \"14240\", \"14240\", \"122\", \"122\", \"122\", \"122\", \"122\", \"3870\", \"3870\", \"3840\", \"624\", \"624\", \"624\", \"101\", \"101\", \"101\", \"101\", \"3556\", \"3556\", \"600\", \"600\", \"600\", \"600\", \"600\", \"14230\", \"201\", \"201\", \"201\", \"603\", \"603\", \"603\", \"603\", \"3850\", \"7111\", \"7126\", \"7126\", \"410\", \"7134\", \"7134\", \"400\", \"400\", \"400\", \"400\", \"400\", \"400\", \"419\", \"419\", \"419\", \"401\", \"401\", \"401\", \"401\", \"401\", \"318\", \"318\", \"318\", \"318\", \"318\", \"318\", \"7100\", \"7100\", \"7100\", \"7127\", \"7127\", \"231\", \"231\", \"231\", \"231\", \"231\", \"427\", \"427\", \"427\", \"7139\", \"7139\", \"7139\", \"7139\", \"7139\", \"7139\", \"7112\", \"7112\", \"7112\", \"7112\", \"430\", \"430\", \"7121\", \"7121\", \"441\", \"441\", \"441\", \"441\", \"309\", \"309\", \"108\", \"108\", \"108\", \"114\", \"114\", \"114\", \"114\", \"313\", \"313\", \"313\", \"512\", \"512\", \"512\", \"512\", \"503\", \"503\", \"503\", \"503\", \"311\", \"311\", \"311\", \"514\", \"514\", \"405\", \"405\", \"100\", \"100\", \"100\", \"100\", \"106\", \"106\", \"106\", \"106\", \"106\", \"107\", \"107\", \"501\", \"501\", \"501\", \"105\", \"105\", \"509\", \"509\", \"101\", \"101\", \"112\", \"110\", \"110\", \"110\", \"110\", \"104\", \"104\", \"315\", \"315\", \"102\", \"102\", \"102\", \"102\", \"102\", \"505\", \"505\", \"307\", \"307\", \"103\", \"103\", \"103\", \"510\", \"510\", \"403\", \"403\"]',1,NULL,NULL,449),(7,'STREET',6,NULL,'[\"BASSWOOD\", \"BASSWOOD\", \"BASSWOOD\", \"BASSWOOD\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BASSWOOD\", \"BASSWOOD\", \"BASSWOOD\", \"STARKEY \", \"STARKEY \", \"BASSWOOD\", \"BASSWOOD\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"RIDLEY\", \"RIDLEY\", \"BASSWOOD\", \"MITCHELL\", \"MITCHELL\", \"MITCHELL\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"MITCHELL\", \"MITCHELL\", \"MITCHELL\", \"STARKEY \", \"STARKEY \", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BASSWOOD\", \"BASSWOOD\", \"MITCHELL\", \"MITCHELL\", \"BASSWOOD\", \"BANK\", \"BANK\", \"BANK\", \"STARKEY \", \"BASSWOOD\", \"BASSWOOD\", \"BASSWOOD\", \"BANK\", \"BANK\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"MITCHELL\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"RIDLEY\", \"RIDLEY\", \"BASSWOOD\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"BASSWOOD\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"BANK\", \"BANK\", \"BANK\", \"STARKEY \", \"STARKEY \", \"RIDLEY\", \"RIDLEY\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"RIDLEY\", \"BASSWOOD\", \"BASSWOOD\", \"BANK\", \"BANK\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"ELDORADO\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"BASSWOOD\", \"BASSWOOD\", \"ELDORADO\", \"CARL VINSON \", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"MALIBU\", \"MALIBU\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"CARL VINSON \", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"MALIBU\", \"ELDORADO\", \"ELDORADO\", \"MONTEGO \", \"MONTEGO \", \"MONTEGO \", \"MONTEGO \", \"MALIBU\", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"MONTEGO \", \"MONTEGO \", \"MONTEGO \", \"MONTEGO \", \"HWY 54\", \"HWY 54\", \"HWY 54\", \"HWY 54\", \"HWY 54\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"RUBY\", \"RUBY\", \"RUBY\", \"22ND\", \"22ND\", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"22ND\", \"22ND\", \"MAIN\", \"GEORGE\", \"GEORGE\", \"WARE\", \"WARE\", \"22ND\", \"22ND\", \"22ND\", \"22ND\", \"WARE\", \"WARE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"JOHNSON \", \"JOHNSON \", \"JOHNSON \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"CHURCH\", \"CHURCH\", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"22ND\", \"WARE\", \"WARE\", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"GEORGE\", \"GEORGE\", \"GEORGE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"HWY 54\", \"RUBY\", \"RUBY\", \"RUBY\", \"22ND\", \"22ND\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"RUBY\", \"22ND\", \"22ND\", \"22ND\", \"22ND\", \"HWY 54\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"22ND\", \"22ND\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"WARE\", \"WARE\", \"22ND\", \"22ND\", \"22ND\", \"22ND\", \"22ND\", \"31ST\", \"31ST\", \"WOODHAVEN \", \"HWY 54\", \"MAIN\", \"MAIN\", \"22ND\", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"22ND\", \"22ND\", \"22ND\", \"22ND\", \"22ND\", \"WARE\", \"WARE\", \"WARE\", \"WARE\", \"WARE\", \"HWY 54\", \"HWY 54\", \"HWY 54\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"JOHNSON \", \"JOHNSON \", \"JOHNSON \", \"JOHNSON \", \"HWY 54\", \"HWY 54\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"22ND\", \"MAIN\", \"MAIN\", \"MAIN\", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"HWY 54\", \"3RD \", \"2ND \", \"2ND \", \"72ND\", \"3RD \", \"3RD \", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"2ND \", \"2ND \", \"2ND \", \"3RD \", \"3RD \", \"71ST\", \"71ST\", \"71ST\", \"71ST\", \"71ST\", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"3RD \", \"3RD \", \"3RD \", \"3RD \", \"3RD \", \"3RD \", \"2ND \", \"2ND \", \"2ND \", \"2ND \", \"72ND\", \"72ND\", \"3RD \", \"3RD \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"WOODHAVEN \", \"WOODHAVEN \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"ELDORADO\", \"ELDORADO\", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"ELDORADO\", \"ELDORADO\", \"WOODHAVEN \", \"WOODHAVEN \", \"ELDORADO\", \"ELDORADO\", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"WOODHAVEN \", \"WOODHAVEN \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"ELDORADO\", \"ELDORADO\", \"ELDORADO\", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \"]',1,NULL,NULL,449),(8,'DS',0,NULL,'[\"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\", \"B\"]',2,NULL,NULL,392),(9,'IDENTIFIER',1,NULL,'[\"ID444611561\", \"ID444611563\", \"ID4447124106879010001\", \"ID4447124106879010003\", \"ID4447124106879010002\", \"ID4447124106897210001\", \"ID4447124106897210002\", \"ID4447124106897210003\", \"ID4447124106897210004\", \"ID4447124106897210005\", \"ID4447124106907910001\", \"ID4447124106894910001\", \"ID4447124106894910002\", \"ID4447124106920210001\", \"ID4447124106920210002\", \"ID4447124106912910004\", \"ID4447124106912910001\", \"ID4447124106912910003\", \"ID4447124106909510001\", \"ID4447124106909510002\", \"ID4447124106909510003\", \"ID4447124106899810001\", \"ID4447124106899810002\", \"ID4447124106877410001\", \"ID4447124106883210001\", \"ID4447124106883210002\", \"ID4446117397\", \"ID4446117398\", \"ID444712426108480000\", \"ID4447124106908710003\", \"ID4447124106908710001\", \"ID4447124106908710002\", \"ID4446117475\", \"ID4446117479\", \"ID444611554\", \"ID4447124106913710002\", \"ID4447124106913710003\", \"ID4447124106913710004\", \"ID4447124106913710005\", \"ID4447124106913710001\", \"ID444712410690380000\", \"ID4447124106917810001\", \"ID4447124106916010001\", \"ID4447124106924410001\", \"ID444712410689230000\", \"ID4447124106892310001\", \"ID4447124106892310002\", \"ID444712410688570000\", \"ID4447124106885710001\", \"ID4447124106910310001\", \"ID4447124106910310003\", \"ID4447124106910310002\", \"ID444712425879540000\", \"ID4447124106911110002\", \"ID4447124106911110001\", \"ID4447124106876610001\", \"ID4447124106876610002\", \"ID4447124106887310002\", \"ID4447124106887310003\", \"ID4447124106887310001\", \"ID444611482\", \"ID444611486\", \"ID4447124106891510001\", \"ID4447124106890710001\", \"ID4447124106890710004\", \"ID4447124106890710002\", \"ID4447124106890710003\", \"ID4447124106890710005\", \"ID4447124106890710006\", \"ID4447124106881610001\", \"ID4447124106919410002\", \"ID4447124106886510001\", \"ID4447124106874110001\", \"ID4447124106882410001\", \"ID4447124106882410002\", \"ID4447124106896410001\", \"ID4447124106923610001\", \"ID4447124106923610002\", \"ID4447124106923610003\", \"ID4447124106898010001\", \"ID4447124106898010002\", \"ID4447124106889910001\", \"ID4447124106889910002\", \"ID4447124106904610001\", \"ID4447124106904610002\", \"ID4447124106900410001\", \"ID4447124106880810001\", \"ID4447124106880810002\", \"ID4447124106880810003\", \"ID4447124106921010002\", \"ID4447124106921010001\", \"ID4447124106914510001\", \"ID4447124106914510002\", \"ID4448125110811710001\", \"ID4446121011\", \"ID4448125110816610003\", \"ID4448125110816610004\", \"ID4448125110816610005\", \"ID4448125110816610001\", \"ID4448125110816610002\", \"ID4448125110670710003\", \"ID4448125110670710002\", \"ID4448125110808310002\", \"ID4448125110808310003\", \"ID4448125110808310004\", \"ID4448125110808310001\", \"ID4446120210\", \"ID4448125110820810001\", \"ID4448125110821610001\", \"ID4448125110821610002\", \"ID4450127238387310002\", \"ID4450127238387310003\", \"ID4450127238387310001\", \"ID44461220543\", \"ID44461220533\", \"ID4450127238383210002\", \"ID4450127238383210001\", \"ID4450127238383210004\", \"ID4450127238376610001\", \"ID4450127238376610003\", \"ID4450127238376610002\", \"ID4450127238404610002\", \"ID4450127238404610001\", \"ID4450127238379010003\", \"ID4450127238379010004\", \"ID4450127238379010001\", \"ID4450127238379010002\", \"ID4450127238398010001\", \"ID4450127238398010002\", \"ID445012723835840000\", \"ID445012723835840000\", \"ID445012723835840000\", \"ID445012723835840000\", \"ID4450127238362610001\", \"ID4450127238362610002\", \"ID4450127238399810001\", \"ID4450127238399810002\", \"ID4450127238399810003\", \"ID4450127238399810004\", \"ID4450127238359210001\", \"ID4450127238359210002\", \"ID44461221227\", \"ID4450127238378210004\", \"ID4450127238378210001\", \"ID4450127238378210002\", \"ID4450127238378210003\", \"ID4450127238355010001\", \"ID4450127238355010002\", \"ID44461220734\", \"ID4450127238406110001\", \"ID4450127238352710002\", \"ID4450127238352710003\", \"ID4450127238352710001\", \"ID4450127238360010001\", \"ID4450127238360010002\", \"ID4450127238349310001\", \"ID4450127238349310002\", \"ID4450127238349310003\", \"ID4450127238384010001\", \"ID4450127238384010002\", \"ID4450127238384010003\", \"ID4450127238384010004\", \"ID4450127238384010005\", \"ID44461230326\", \"ID44461230328\", \"ID44461230330\", \"ID44461230332\", \"ID4450127238374110002\", \"ID4450127238374110003\", \"ID4450127238374110001\", \"ID4450127238405310002\", \"ID4450127238405310001\", \"ID445012723838570000\", \"ID445012723838570000\", \"ID445012723838570000\", \"ID4450127238390710001\", \"ID4450127238390710002\", \"ID4450127238390710003\", \"ID4450127238390710004\", \"ID4450127238390710005\", \"ID4450127238397210001\", \"ID4450127238397210003\", \"ID4450127238397210002\", \"ID4450127238397210004\", \"ID4450127238380810001\", \"ID4450127238380810003\", \"ID4450127238380810004\", \"ID4450127238380810002\", \"ID44461220129\", \"ID44461220142\", \"ID4450127238388110002\", \"ID4450127238372510001\", \"ID4450127238381610002\", \"ID4450127238381610003\", \"ID4450127238381610001\", \"ID4450127238391510002\", \"ID4450127238391510001\", \"ID4450127238350110001\", \"ID4450127238368310004\", \"ID4450127238368310001\", \"ID4450127238368310003\", \"ID4450127238368310005\", \"ID445012723836910000\", \"ID445012723836910000\", \"ID4450127238386510001\", \"ID4450127238386510002\", \"ID4450127238409510001\", \"ID4450127238353510002\", \"ID4450127238353510003\", \"ID4450127238353510001\", \"ID4450127238353510004\", \"ID4450127238403810002\", \"ID4450127238403810001\", \"ID44461230536\", \"ID4450127257775510002\", \"ID4450127257775510001\", \"ID4450127238348510001\", \"ID4450127238364210001\", \"ID4450127238364210002\", \"ID4450127238354310001\", \"ID4450127238354310003\", \"ID445012723837330000\", \"ID445012723837330000\", \"ID4450127238375810001\", \"ID445012723837740000\", \"ID445012723837740000\", \"ID445012723837740000\", \"ID4450127238395610001\", \"ID4450127238395610002\", \"ID4450127238407910002\", \"ID4450127238407910001\", \"ID4450127238396410001\", \"ID4450127238401210003\", \"ID4450127238401210001\", \"ID4450127238401210002\", \"ID4450127238361810002\", \"ID4450127238361810004\", \"ID4450127238361810001\", \"ID4450127238361810003\", \"ID4450127238371710001\", \"ID4450127238371710002\", \"ID4450127238393110002\", \"ID4450127238393110003\", \"ID4450127238393110001\", \"ID4450127238382410004\", \"ID4450127238382410005\", \"ID4450127238382410001\", \"ID44461220231\", \"ID445012723840870000\", \"ID445012723840870000\", \"ID445012723840870000\", \"ID4450127238366710001\", \"ID4450127238366710002\", \"ID4450127238400410001\", \"ID4450127238356810001\", \"ID4450127238356810002\", \"ID4450127238356810003\", \"ID4445112314670610001\", \"ID4445112314670610002\", \"ID4445113314679710001\", \"ID44461181048\", \"ID44461181049\", \"ID4445113314682110001\", \"ID4445113314682110002\", \"ID4445113314680510001\", \"ID4445113314680510003\", \"ID4445113314680510004\", \"ID4445113314680510002\", \"ID4445113314680510005\", \"ID4445113314680510006\", \"ID4445113314675510001\", \"ID4445113314675510002\", \"ID44461161345\", \"ID4445113314674810001\", \"ID4445113314674810002\", \"ID4445113314674810003\", \"ID4445113314674810005\", \"ID44461160444\", \"ID44461161046\", \"ID44461161047\", \"ID44461160351\", \"ID4445113314681310001\", \"ID4445113314681310003\", \"ID4445113314681310002\", \"ID4445113314681310004\", \"ID4445112314672210001\", \"ID4445112314672210003\", \"ID4445112314672210002\", \"ID4445112314666410001\", \"ID4445112314666410002\", \"ID4445113314673010001\", \"ID4445113314673010003\", \"ID4445113314673010004\", \"ID4445113314673010005\", \"ID4445113314673010002\", \"ID4445113314676310001\", \"ID4445113314676310002\", \"ID4445113314676310003\", \"ID4445112314667210001\", \"ID4445112314667210003\", \"ID4445112314667210005\", \"ID4445112314667210006\", \"ID4445112314667210002\", \"ID4445112314667210004\", \"ID44461160650\", \"ID4445112314671410001\", \"ID4445112314671410004\", \"ID4445112314671410002\", \"ID4445112314671410003\", \"ID4445113314678910001\", \"ID4445113314678910002\", \"ID4445112314665610001\", \"ID4445112314665610002\", \"ID4445113314677110001\", \"ID4445113314677110002\", \"ID4445112314664910001\", \"ID4449126128949510001\", \"ID4449126128949510002\", \"ID4449126128936210001\", \"ID4449126128936210004\", \"ID4449126128936210002\", \"ID4449126128936210003\", \"ID4449126128933910001\", \"ID4449126128933910003\", \"ID4449126128933910002\", \"ID4449126128947910001\", \"ID4449126128947910003\", \"ID4449126128947910002\", \"ID4449126128942010001\", \"ID4449126128942010002\", \"ID4449126128942010003\", \"ID4449126128942010004\", \"ID4449126128948710001\", \"ID4449126128948710003\", \"ID4449126128948710002\", \"ID4449126128939610001\", \"ID4449126128939610002\", \"ID4449126128944610002\", \"ID4449126128944610001\", \"ID4449126128929710001\", \"ID4449126128929710002\", \"ID4449126128929710003\", \"ID4449126128929710004\", \"ID4449126128932110001\", \"ID4449126128932110002\", \"ID4449126128932110003\", \"ID4449126128932110004\", \"ID4449126128932110005\", \"ID4449126128925510001\", \"ID4449126128925510002\", \"ID444611540953\", \"ID444611540954\", \"ID444611540955\", \"ID4449126128938810001\", \"ID4449126128938810003\", \"ID4449126128938810002\", \"ID4449126128943810001\", \"ID4449126128943810002\", \"ID4449126128943810003\", \"ID44461191152\", \"ID4449126128940410001\", \"ID4449126128940410002\", \"ID4449126128926310001\", \"ID4449126128926310002\", \"ID4449126128935410001\", \"ID4449126128934710001\", \"ID4449126128934710002\", \"ID4449126128934710003\", \"ID4449126128934710004\", \"ID4449126128946110001\", \"ID4449126128946110002\", \"ID4449126128931310001\", \"ID4449126128931310002\", \"ID4449126128928910001\", \"ID4449126128928910002\", \"ID444611541056\", \"ID4449126128941210001\", \"ID4449126128941210002\", \"ID4449126128930510001\", \"ID4449126128930510005\", \"ID4449126128930510002\", \"ID4449126128930510003\", \"ID4449126128930510004\", \"ID4449126128927110001\", \"ID4449126128927110003\", \"ID4449126128927110002\", \"ID4449126128937010001\", \"ID4449126128937010002\", \"ID4449126128950310001\", \"ID4449126128950310002\", \"ID4449126128945310001\", \"ID4449126128945310002\"]',2,NULL,NULL,392),(10,'SURNAME',2,NULL,'[\"AHREWS\", \"AHREWS\", \"BENETAS\", \"BENETAS\", \"BENETAS\", \"BODMER\", \"BODMER\", \"BODMER\", \"BODMER\", \"BODMER\", \"CETO\", \"CHEESEMAN\", \"CHEESEMAN\", \"CONNER\", \"CONNER\", \"COSGRAOE\", \"COSGRAOE\", \"COSGRAOE\", \"DACANAY\", \"DACANAY\", \"DACANAY\", \"DANIEL-LEIVA\", \"DANIEL-LEIVA\", \"DIVER\", \"DOMINQUEZ\", \"DOMINQUEZ\", \"ENGELSKIRCH\", \"ENGELSKIRCH\", \"FAIRIE\", \"FISCHARUND\", \"FISCHARUND\", \"FISCHARUND\", \"GECKLE\", \"GECKLE\", \"GERING\", \"GERINGER\", \"GERINGER\", \"GERINGER\", \"GERINGER\", \"GERINGER\", \"GLICK\", \"GREENE\", \"HALL\", \"HILLION\", \"JEANS\", \"JEANS\", \"JEANS\", \"JIMEMEZ\", \"JIMEMEZ\", \"JIMENEZ\", \"JIMENEZ\", \"JIMENEZ\", \"KELLEY\", \"LAKHTOSH\", \"LAKHTOSH\", \"LASITTER\", \"LASITTER\", \"MALDONABO\", \"MALDONABO\", \"MALDONABO\", \"MORGAN\", \"MORGAN\", \"MOSGERA\", \"MOSGUERA\", \"MOSGUERA\", \"MOSGUERA\", \"MOSGUERA\", \"MOSGUERA\", \"MOSGUERA\", \"OQUENDO\", \"PAIGE\", \"PARRA\", \"RAUST\", \"RODREQUE\", \"RODREQUE\", \"ROUNSVELLE\", \"SENTRY\", \"SENTRY\", \"SENTRY\", \"SHANKS\", \"SHANKS\", \"TORRIS\", \"TORRIS\", \"VALDEZ\", \"VALDEZ\", \"VARGAS MUNOZ\", \"VARGAS-HERNAN\", \"VARGAS-HERNAN\", \"VARGAS-HERNAN\", \"WESTERN\", \"WESTERN\", \"WIZALKOWSKI\", \"WIZALKOWSKI\", \"CANNON\", \"DORSER\", \"HOERNING\", \"HOERNING\", \"HOERNING\", \"HOERNING\", \"HOERNING\", \"JOHNS\", \"JOHNS\", \"JOLMES\", \"JOLMES\", \"JOLMES\", \"JOLMES\", \"KENNY\", \"SPRIGGS\", \"TREAEVANT\", \"TREAEVANT\", \"ALSTON\", \"ALSTON\", \"ALSTON\", \"BARRETT\", \"BARRETT\", \"CAMBLE\", \"CAMBLE\", \"CAMBLE\", \"CARL\", \"CARL\", \"CARL\", \"CARTIER\", \"CARTIER\", \"CARVAJAL\", \"CARVAJAL\", \"CARVAJAL\", \"CARVAJAL\", \"CHAMBERS\", \"CHAMBERS\", \"COBY\", \"COBY\", \"COBY\", \"COBY\", \"CRIBER\", \"CRIBER\", \"DAVIS\", \"DAVIS\", \"DAVIS\", \"DAVIS\", \"DEGRAGENRIED\", \"DEGRAGENRIED\", \"DICKERSON\", \"EASELY\", \"EASELY\", \"EASELY\", \"EASELY\", \"ELLICATT-KEAN\", \"ELLICATT-KEAN\", \"FOSTER\", \"FRY\", \"GARNER\", \"GARNER\", \"GARNER\", \"GARRET\", \"GARRET\", \"GORODN\", \"GORODN\", \"GORODN\", \"GREEN\", \"GREEN\", \"GREEN\", \"GREEN\", \"GREEN\", \"HACHETT\", \"HACHETT\", \"HACHETT\", \"HACHETT\", \"HAMMOND\", \"HAMMOND\", \"HAMMOND\", \"HASKINS\", \"HASKINS\", \"HEAVAENER\", \"HEAVAENER\", \"HEAVAENER\", \"HENRIKSON\", \"HENRIKSON\", \"HENRIKSON\", \"HENRIKSON\", \"HENRIKSON\", \"HOLLY\", \"HOLLY\", \"HOLLY\", \"HOLLY\", \"HOSHINGTON\", \"HOSHINGTON\", \"HOSHINGTON\", \"HOSHINGTON\", \"HULLEY\", \"HULLEY\", \"HUSSEINKEL\", \"HUTSON\", \"IRVIN\", \"IRVIN\", \"IRVIN\", \"KLEINMAN\", \"KLEINMAN\", \"KOUPE\", \"KUMOR\", \"KUMOR\", \"KUMOR\", \"KUMOR\", \"KUMOR\", \"KUMOR\", \"LESCO\", \"LESCO\", \"MARTINEZ\", \"MATEO\", \"MATEO\", \"MATEO\", \"MATEO\", \"MCALISTER\", \"MCALISTER\", \"MITCHELL\", \"MOHRINA\", \"MOHRINA\", \"MOSER\", \"MUCCIO\", \"MUCCIO\", \"OLOWOKAKOKO\", \"OLOWOKAKOKO\", \"PARK\", \"PARK\", \"PETTRICH\", \"REEVES\", \"REEVES\", \"REEVES\", \"REICHENBERG\", \"REICHENBERG\", \"RODRIGUES\", \"RODRIGUES\", \"ROGLIN\", \"ROTHCHILD\", \"ROTHCHILD\", \"ROTHCHILD\", \"RUDAGILL\", \"RUDAGILL\", \"RUDAGILL\", \"RUDAGILL\", \"RUIHLING\", \"RUIHLING\", \"RUSSELL\", \"RUSSELL\", \"RUSSELL\", \"SHAWQI\", \"SHAWQI\", \"SHAWQI\", \"SINEFIELD\", \"SOLLIVAN\", \"SOLLIVAN\", \"SOLLIVAN\", \"SQUILLANGE\", \"SQUILLANGE\", \"SYKES\", \"TUNSTALL\", \"TUNSTALL\", \"TUNSTALL\", \"BRAND\", \"BRAND\", \"CARTE\", \"DAVID\", \"DAVID\", \"DOCUTY\", \"DOCUTY\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"ELM\", \"ELM\", \"FENSTER-PENNE\", \"GASBARRD\", \"GASBARRD\", \"GASBARRD\", \"GASBARRD\", \"GEHRING\", \"HACKER\", \"HACKER\", \"HALLORAW\", \"HELER\", \"HELER\", \"HELER\", \"HELER\", \"HOOPER\", \"HOOPER\", \"HOOPER\", \"HUBRICK\", \"HUBRICK\", \"PAINE-WELLS\", \"PAINE-WELLS\", \"PAINE-WELLS\", \"PAINE-WELLS\", \"PAINE-WELLS\", \"PENSMITH\", \"PENSMITH\", \"PENSMITH\", \"POLLOCK\", \"POLLOCK\", \"POLLOCK\", \"POLLOCK\", \"POLLOCK\", \"POLLOCK\", \"REEVER\", \"ROWAN\", \"ROWAN\", \"ROWAN\", \"ROWAN\", \"SANDERS\", \"SANDERS\", \"SCHWARTZ\", \"SCHWARTZ\", \"SMALL\", \"SMALL\", \"VELL\", \"ARCHBR\", \"ARCHBR\", \"BELTAN\", \"BELTAN\", \"BELTAN\", \"BELTAN\", \"BETRAN\", \"BETRAN\", \"BETRAN\", \"COGER\", \"COGER\", \"COGER\", \"DORSLY\", \"DORSLY\", \"DORSLY\", \"DORSLY\", \"DRENNON\", \"DRENNON\", \"DRENNON\", \"FLEET\", \"FLEET\", \"FLOWER\", \"FLOWER\", \"GALINDE\", \"GALINDE\", \"GALINDE\", \"GALINDE\", \"HILLEGASS\", \"HILLEGASS\", \"HILLEGASS\", \"HILLEGASS\", \"HILLEGASS\", \"HULLOWAY\", \"HULLOWAY\", \"JONES\", \"JONES\", \"JONES\", \"KABEZA\", \"KABEZA\", \"KABEZA\", \"KEARNAY\", \"KEARNAY\", \"KEARNAY\", \"MASLIN\", \"MITCHELL\", \"MITCHELL\", \"MONGUM\", \"MONGUM\", \"RAMOS\", \"RHOADS\", \"RHOADS\", \"RHOADS\", \"RHOADS\", \"RICHARDSONIII\", \"RICHARDSONIII\", \"RIVERA\", \"RIVERA\", \"RODRIGUEZ\", \"RODRIGUEZ\", \"SPINWATO\", \"STEWART\", \"STEWART\", \"STOPPY\", \"STOPPY\", \"STOPPY\", \"STOPPY\", \"STOPPY\", \"WILKS\", \"WILKS\", \"WILKS\", \"WILLIAM\", \"WILLIAM\", \"WRIGHT\", \"WRIGHT\", \"YATES\", \"YATES\"]',2,NULL,NULL,392),(11,'NAME',3,NULL,'[\"MARITZA\", \"MARIANNA\", \"LENARD\", \"SAMMY\", \"DOLORES\", \"JAMAR\", \"ROSSITA\", \"MAG\", \"ROZELLIN\", \"CATHERINE\", \"J\", \"DANYA\", \"DANTE\", \"DOMINQUE\", \"COHNIE\", \"SEKOU\", \"TREIRA\", \"THERESA\", \"MICHAEL\", \"A JASIA\", \"BRIANCA\", \"SAM\", \"THAU LYNN\", \"MILFORD\", \"FRANK\", \"SHAVAN\", \"ISAAE\", \"JEANELLE\", \"LOUIS\", \"WESLEY\", \"NADESHIA\", \"DANYELLE\", \"RUNEE\", \"RALPAL\", \"RROBERT\", \"GHOLAN\", \"JEFFREY\", \"JEFFREY\", \"DOUGLASS\", \"MARIE\", \"NATHANIAL\", \"TEMPEST\", \"RAYMON\", \"GEORGE\", \"KEYAN\", \"MICHEAL\", \"CASANDRA\", \"SANDERA\", \"BARBRA\", \"IRWIN\", \"ANDRE\", \"WILHEMENIA\", \"FREDRICK\", \"TONY\", \"DANIELLE\", \"DORATHEA\", \"LELA\", \"DWIGHT\", \"MARQUIS\", \"MABEL\", \"DARYL\", \"KEVEIN\", \"HERMAN\", \"IASHA\", \"ANDRE\", \"ROMAINE\", \"TAWYA\", \"PRINCETTE\", \"KEISHA\", \"CLAIRE\", \"XANTHA\", \"JEMOS\", \"ANN\", \"TAWANA\", \"GERALDINE\", \"DERRICK\", \"IRAN\", \"RAYMOND\", \"ALLICIA\", \"DAVONE\", \"LONORA\", \"RANDOLFF\", \"FREMAN\", \"WYANE\", \"THERESA\", \"THUY KIM\", \"BRANDON\", \"ALEXANDE\", \"ELIZBETH\", \"DONNY\", \"SALLY\", \"ALEXDER\", \"DELORES\", \"LATESHA\", \"KATHY\", \"RUFUS\", \"CHISTOPHER\", \"ZACNARY\", \"TRINA\", \"ANNA\", \"STEPHEN\", \"GLURIA\", \"GERARDO\", \"FRANCISO\", \"ERIK\", \"LUCILE\", \"DANYAE\", \"RAY\", \"JACKIE\", \"ANNA\", \"LED\", \"MICHAEL\", \"ROSEMARY\", \"KENDALL\", \"YUNAISY\", \"ANTOIENO\", \"JESSICIA\", \"MARNELA\", \"DERRYL\", \"BARRY\", \"ROSELIME\", \"RODERICK\", \"JOAN\", \"ADRIAN\", \"STEVEN\", \"MILISSA\", \"SARA\", \"LAURENCE\", \"EUGENIO\", \"MIKE\", \"WILIAMS\", \"ANGELA\", \"LASHIWN\", \"GOILLERMO\", \"MARCOS\", \"WINDY\", \"MICHELLE\", \"RENNE\", \"SARA\", \"JERARDO\", \"ALLEN\", \"MARY LOU\", \"MATHEW\", \"FLORY\", \"KERRY\", \"NILSAIVETTE\", \"SHERYL\", \"ELAINE\", \"MARYANN\", \"EPHNY\", \"DANNY\", \"ROBERTO\", \"MAJORIE\", \"SHARNETT\", \"HARRET\", \"KRISTY LEIGH\", \"DIANE MARIE\", \"ROSE MARIE\", \"EDVARDO\", \"SANDRA\", \"ANNE\", \"MICHELLE\", \"ROSETTE\", \"CORTE\", \"DENARIO\", \"EYVETTE\", \"ALISA\", \"JOAMES\", \"LENWOOD REV\", \"TRACI\", \"STEFAN\", \"PAMELA\", \"FLORRE\", \"JEFFREY\", \"WILSREVO\", \"SAMIAR\", \"SAMANTHA\", \"DOROTHEA\", \"DONNA MARIE\", \"PHYLLIS\", \"MICHAEL\", \"DAMOEN\", \"CATHRINE\", \"CHARCOTTE\", \"JEFFREY\", \"STEVEN\", \"MAURI\", \"XLONARA\", \"ANTHONY\", \"DIANE\", \"ARCHIBALD\", \"JACQUELIN\", \"ALEJANDRO\", \"IVAN\", \"ZIONAIRE\", \"ANTONIA\", \"JOSLYN\", \"MARCO\", \"DINWARDO\", \"BERNADINE\", \"TERRENCE\", \"ZAKAYA\", \"DAGOBERTO\", \"CORRINE\", \"CLARENCE\", \"BAN\", \"ERICA\", \"DELHAM\", \"GEORGE DR\", \"ANGLA\", \"JESSE\", \"GEOFFRY\", \"JANETT\", \"THE IMA\", \"DOMINIC\", \"JANIS\", \"SHIRLEY\", \"ORESTES\", \"LIVIA\", \"GREGORY\", \"AE\", \"VERCONIA\", \"DELORES\", \"JOHNNIE\", \"WILLY\", \"DOUGLASS\", \"NWAMAKA\", \"SUE\", \"TRUDY\", \"QUINTON\", \"STEPHINE\", \"REYANN\", \"PHILIP\", \"JAYANN\", \"HILDRED\", \"DOMINI\", \"SEPTIMIO\", \"KIMBERY\", \"ALASIA\", \"TRACIE LEE\", \"MELLISSA\", \"MIRIAM\", \"JONGE\", \"LYNN\", \"CHARES\", \"ISAREL\", \"MARYCAROLE\", \"SHEILA\", \"EVENS\", \"BRANDIE\", \"ANNE\", \"LOUIS\", \"GERARD\", \"KATHY\", \"NICOLE\", \"MARY ANNE\", \"HARRIET\", \"ALAN\", \"ANN\", \"JEANNE\", \"TRYONE\", \"HOANG\", \"DOUGLAS\", \"MICHELLE\", \"LAWRENCE\", \"DAVID\", \"BEN\", \"ALLICIA\", \"GERALDINE\", \"NATASHA\", \"GISUS\", \"ETHLEW\", \"JEANNE\", \"PABLO\", \"LE ANNE\", \"AFRIN\", \"JO ANNE\", \"BIANCA\", \"ZUNZELL\", \"CORNLIUS\", \"MARIEA\", \"DIXIE\", \"DORIAN\", \"TEAIRA\", \"ANGELEAN\", \"ARISTIDIS\", \"CARLO\", \"ROSETTA\", \"CHARLS\", \"JANICE\", \"SIFRIDO\", \"ABEL\", \"WALDO\", \"IGANACIO\", \"BARBRA\", \"JEFFERY\", \"THRESSA\", \"ANN\", \"ANDREW\", \"JAMAL\", \"DAVON\", \"SHAUN\", \"MIRIAN\", \"LEHA\", \"KENNETH\", \"CRISTOPHER\", \"ERNEST\", \"CATHERINE\", \"ALFREDA\", \"NICHOLAS\", \"KATHY\", \"JOAN\", \"PATRICIA\", \"JEFFERY\", \"ENGER\", \"GLORIANE\", \"MACK\", \"J\", \"ELAM\", \"WYLIE\", \"GISELLA\", \"RUTHANN\", \"LAWRENE\", \"JEFFREY\", \"SOLITA\", \"EDDIE\", \"EARL\", \"ROSSITA\", \"GARY\", \"MELLISA\", \"DEBNA\", \"EDNA\", \"ISAAC\", \"EARNEST\", \"THERSA\", \"JOHNNIE\", \"ANTOINETTE\", \"STANLEY\", \"CORNELIA\", \"KENNETH\", \"ENZNZELLE\", \"LACHELLE\", \"CHATYRA\", \"JOHNNIE\", \"JENIA\", \"HAILIE\", \"ROSE\", \"JONIE\", \"SCOTT\", \"JENNIFER\", \"PRESPEU\", \"NAOMI\", \"LUC\", \"RONNY\", \"KEN\", \"SHAWNA\", \"SHAMIKA\", \"ASHLEY\", \"SHERMICE\", \"ALMA\", \"GEROME\", \"DORETTA\", \"ROBERT\", \"RAKIA\", \"SONYA\", \"JEFFREY\", \"HENRIETTA\", \"JANIE\", \"JEANNE\", \"EMMIT\", \"TOMICA\", \"JOHN\", \"STEWART\", \"JOSHUA\", \"RUBY\", \"SILYIA\", \"FRED\", \"SHANTELL\", \"JEFFREY\", \"FRANK\", \"ELOUISE\", \"QUIYINA\", \"ALIE\", \"BENEDICT\", \"STEVEN\", \"HARRIET\", \"CHARLEY\", \"SHERRY\", \"BRYAN\", \"MAXINE\", \"CHANSE\", \"ALFREDICA\"]',2,NULL,NULL,392),(12,'LASTCODE',4,NULL,'[\"A\", \"B\", \"A\", \"R\", \"R\", \"C\", \"L\", \"R\", \"N\", \"L\", \"E\", \"L\", \"E\", \"S\", \"E\", \"L\", \"\", \"G\", \"A\", \"\", \"G\", \"J\", \"R\", \"J\", \"K\", \"M\", \"\", \"\", \"W\", \"M\", \"A\", \"L\", \"\", \"T\", \"T\", \"W\", \"W\", \"W\", \"D\", \"T\", \"N\", \"Z\", \"\", \"L\", \"D\", \"\", \"C\", \"Y\", \"M\", \"\", \"\", \"\", \"W\", \"M\", \"S\", \"K\", \"M\", \"B\", \"E\", \"\", \"A\", \"\", \"M\", \"C\", \"G\", \"O\", \"O\", \"D\", \"O\", \"J\", \"\", \"V\", \"N\", \"S\", \"A\", \"E\", \"R\", \"L\", \"J\", \"B\", \"S\", \"\", \"R\", \"H\", \"\", \"G\", \"R\", \"R\", \"L\", \"\", \"\", \"J\", \"A\", \"D\", \"\", \"D\", \"D\", \"\", \"\", \"\", \"\", \"\", \"F\", \"D\", \"D\", \"\", \"\", \"\", \"M\", \"M\", \"E\", \"\", \"\", \"\", \"L\", \"E\", \"A\", \"E\", \"B\", \"J\", \"D\", \"C\", \"\", \"L\", \"D\", \"L\", \"L\", \"\", \"E\", \"D\", \"A\", \"\", \"Y\", \"E\", \"M\", \"E\", \"N\", \"M\", \"N\", \"D\", \"R\", \"\", \"\", \"D\", \"D\", \"D\", \"\", \"A\", \"\", \"B\", \"\", \"R\", \"A\", \"R\", \"\", \"L\", \"\", \"\", \"A\", \"C\", \"A\", \"M\", \"A\", \"D\", \"E\", \"D\", \"Y\", \"\", \"\", \"R\", \"\", \"T\", \"\", \"S\", \"\", \"I\", \"H\", \"T\", \"E\", \"L\", \"T\", \"T\", \"A\", \"E\", \"P\", \"I\", \"P\", \"E\", \"B\", \"M\", \"\", \"\", \"A\", \"E\", \"T\", \"B\", \"V\", \"\", \"A\", \"\", \"L\", \"C\", \"\", \"\", \"\", \"\", \"\", \"\", \"L\", \"E\", \"\", \"M\", \"M\", \"V\", \"B\", \"M\", \"\", \"S\", \"E\", \"S\", \"A\", \"\", \"\", \"\", \"L\", \"F\", \"M\", \"L\", \"A\", \"\", \"\", \"J\", \"\", \"L\", \"E\", \"A\", \"E\", \"L\", \"M\", \"D\", \"A\", \"S\", \"L\", \"C\", \"\", \"\", \"\", \"\", \"\", \"D\", \"G\", \"A\", \"A\", \"M\", \"\", \"C\", \"J\", \"J\", \"D\", \"\", \"M\", \"\", \"S\", \"C\", \"A\", \"F\", \"M\", \"\", \"L\", \"\", \"A\", \"J\", \"L\", \"V\", \"G\", \"K\", \"M\", \"A\", \"M\", \"M\", \"A\", \"J\", \"J\", \"J\", \"M\", \"C\", \"C\", \"B\", \"P\", \"\", \"J\", \"\", \"J\", \"J\", \"L\", \"J\", \"A\", \"A\", \"\", \"F\", \"S\", \"P\", \"J\", \"A\", \"A\", \"J\", \"A\", \"\", \"L\", \"G\", \"L\", \"F\", \"E\", \"P\", \"B\", \"M\", \"C\", \"A\", \"A\", \"A\", \"M\", \"M\", \"\", \"\", \"\", \"M\", \"M\", \"J\", \"S\", \"J\", \"M\", \"L\", \"F\", \"R\", \"A\", \"\", \"\", \"J\", \"M\", \"E\", \"E\", \"G\", \"M\", \"E\", \"\", \"E\", \"C\", \"E\", \"C\", \"T\", \"J\", \"K\", \"M\", \"\", \"R\", \"\", \"E\", \"\", \"\", \"C\", \"J\", \"M\", \"J\", \"\", \"K\", \"C\", \"\", \"M\", \"\", \"E\", \"R\", \"U\", \"K\", \"V\", \"E\", \"M\", \"A\", \"A\", \"F\", \"E\", \"F\", \"B\", \"A\", \"W\", \"M\", \"L\", \"A\", \"V\", \"\", \"H\", \"E\", \"S\"]',2,NULL,NULL,392),(13,'NUMCODE',5,NULL,'[\"345\", \"345\", \"660\", \"660\", \"660\", \"102\", \"102\", \"102\", \"102\", \"102\", \"104\", \"690\", \"690\", \"4836\", \"4836\", \"202\", \"202\", \"202\", \"112\", \"112\", \"112\", \"729\", \"729\", \"658\", \"672\", \"672\", \"612\", \"612\", \"4940\", \"110\", \"110\", \"110\", \"614\", \"614\", \"325\", \"200\", \"200\", \"200\", \"200\", \"200\", \"725\", \"4816\", \"4810\", \"4914\", \"686\", \"686\", \"686\", \"674\", \"674\", \"214\", \"214\", \"214\", \"4932\", \"206\", \"206\", \"656\", \"656\", \"678\", \"678\", \"678\", \"7124\", \"7124\", \"684\", \"682\", \"682\", \"682\", \"682\", \"682\", \"682\", \"666\", \"4830\", \"676\", \"652\", \"670\", \"670\", \"100\", \"4906\", \"4906\", \"4906\", \"104\", \"104\", \"680\", \"680\", \"723\", \"723\", \"727\", \"664\", \"664\", \"664\", \"4842\", \"4842\", \"210\", \"210\", \"110\", \"626\", \"114\", \"114\", \"114\", \"114\", \"114\", \"4946\", \"4946\", \"108\", \"108\", \"108\", \"108\", \"624\", \"113\", \"111\", \"111\", \"612\", \"612\", \"612\", \"634\", \"634\", \"\", \"\", \"\", \"501\", \"501\", \"501\", \"14135\", \"14135\", \"607\", \"607\", \"607\", \"607\", \"14180\", \"14180\", \"303\", \"303\", \"303\", \"303\", \"106\", \"106\", \"14220\", \"14220\", \"14220\", \"14220\", \"128\", \"128\", \"638\", \"613\", \"613\", \"613\", \"613\", \"102\", \"102\", \"636\", \"14225\", \"100\", \"100\", \"100\", \"124\", \"124\", \"303\", \"303\", \"303\", \"606\", \"606\", \"606\", \"606\", \"606\", \"640\", \"640\", \"640\", \"640\", \"505\", \"505\", \"505\", \"14215\", \"14215\", \"608\", \"608\", \"608\", \"618\", \"618\", \"618\", \"618\", \"618\", \"14170\", \"14170\", \"14170\", \"14170\", \"603\", \"603\", \"603\", \"603\", \"628\", \"628\", \"614\", \"3886\", \"601\", \"601\", \"601\", \"622\", \"622\", \"104\", \"3820\", \"3820\", \"3820\", \"3820\", \"3840\", \"3840\", \"610\", \"610\", \"14255\", \"101\", \"101\", \"101\", \"101\", \"14270\", \"14270\", \"650\", \"701\", \"701\", \"305\", \"106\", \"106\", \"103\", \"103\", \"3960\", \"3960\", \"503\", \"625\", \"625\", \"625\", \"14150\", \"14150\", \"14235\", \"14235\", \"14160\", \"14240\", \"14240\", \"14240\", \"122\", \"122\", \"122\", \"122\", \"3870\", \"3870\", \"624\", \"624\", \"624\", \"600\", \"600\", \"600\", \"632\", \"14245\", \"14245\", \"14245\", \"3556\", \"3556\", \"14230\", \"201\", \"201\", \"201\", \"7126\", \"7126\", \"410\", \"618\", \"618\", \"7134\", \"7134\", \"400\", \"400\", \"400\", \"400\", \"400\", \"400\", \"419\", \"419\", \"610\", \"401\", \"401\", \"401\", \"401\", \"602\", \"606\", \"606\", \"600\", \"380\", \"380\", \"380\", \"380\", \"7100\", \"7100\", \"7100\", \"7127\", \"7127\", \"231\", \"231\", \"231\", \"231\", \"231\", \"427\", \"427\", \"427\", \"7139\", \"7139\", \"7139\", \"7139\", \"7139\", \"7139\", \"604\", \"7112\", \"7112\", \"7112\", \"7112\", \"430\", \"430\", \"7121\", \"7121\", \"441\", \"441\", \"7111\", \"309\", \"309\", \"114\", \"114\", \"114\", \"114\", \"108\", \"108\", \"108\", \"313\", \"313\", \"313\", \"503\", \"503\", \"503\", \"503\", \"311\", \"311\", \"311\", \"514\", \"514\", \"405\", \"405\", \"100\", \"100\", \"100\", \"100\", \"106\", \"106\", \"106\", \"106\", \"106\", \"107\", \"107\", \"7114\", \"7114\", \"7114\", \"512\", \"512\", \"512\", \"501\", \"501\", \"501\", \"620\", \"509\", \"509\", \"105\", \"105\", \"112\", \"110\", \"110\", \"110\", \"110\", \"315\", \"315\", \"104\", \"104\", \"101\", \"101\", \"301\", \"505\", \"505\", \"102\", \"102\", \"102\", \"102\", \"102\", \"103\", \"103\", \"103\", \"510\", \"510\", \"307\", \"307\", \"403\", \"403\"]',2,NULL,NULL,392),(14,'STREET',6,NULL,'[\"71ST\", \"71ST\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"BANKS \", \"BANKS \", \"BANKS \", \"BANKS \", \"BANKS \", \"MITCHELL\", \"STARKEY \", \"STARKEY \", \"BASSWIDE\", \"BASSWIDE\", \"BANKS \", \"BANKS \", \"BANKS \", \"MITCHELL\", \"MITCHELL\", \"MITCHELL\", \"RIDLEY\", \"RIDLEY\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"BASSWOOD\", \"MITCHELL\", \"MITCHELL\", \"MITCHELL\", \"STARKEY \", \"STARKEY \", \"71ST\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"RIDLEY\", \"BASSWOOD\", \"BASSWOOD\", \"BASSWOOD\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"BANKS \", \"BANKS \", \"BANKS \", \"BASSWOOD\", \"BANKS \", \"BANKS \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"3RD \", \"3RD \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"BASSWOOD\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"BANKS \", \"BASSWOOD\", \"BASSWOOD\", \"BASSWOOD\", \"BANKS \", \"BANKS \", \"STARKEY \", \"STARKEY \", \"RIDLEY\", \"RIDLEY\", \"RIDLEY\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"BASSWOOD\", \"BASSWOOD\", \"BANKS \", \"BANKS \", \"EL DORADO \", \"STARKEY \", \"EL DORADO \", \"EL DORADO \", \"EL DORADO \", \"EL DORADO \", \"EL DORADO \", \"BASSWOOD\", \"BASSWOOD\", \"EL DORADO \", \"EL DORADO \", \"EL DORADO \", \"EL DORADO \", \"STARKEY \", \"EL DORADO \", \"EL DORADO \", \"EL DORADO \", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"STARKEY \", \"STARKEY \", \"6041 / 2 OCONEE \", \"6041 / 2 OCONEE \", \"6041 / 2 OCONEE \", \"RUBY\", \"RUBY\", \"RUBY\", \"22\", \"22\", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"22\", \"22\", \"MAIN\", \"MAIN\", \"MAIN\", \"MAIN\", \"WARE\", \"WARE\", \"22\", \"22\", \"22\", \"22\", \"WARE\", \"WARE\", \"STARKEY \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"CHURCH\", \"CHURCH\", \"STARKEY \", \"22 PC \", \"GEORGE\", \"GEORGE\", \"GEORGE\", \"WARE\", \"WARE\", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"RUBY\", \"RUBY\", \"RUBY\", \"22\", \"22\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"22\", \"22\", \"22\", \"22\", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"STARKEY \", \"STARKEY \", \"OCONEE\", \"HWY 54\", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"OCONEE\", \"OCONEE\", \"GEORGE\", \"HWY 54\", \"HWY 54\", \"HWY 54\", \"HWY 54\", \"HWY 54\", \"HWY 54\", \"OCONEE\", \"OCONEE\", \"22\", \"JOHNSON \", \"JOHNSON \", \"JOHNSON \", \"JOHNSON \", \"22\", \"22\", \"STARKEY \", \"31\", \"31\", \"WOODHAVEN \", \"1/2 WARE\", \"1/2 WARE\", \"JOHNSON \", \"JOHNSON \", \"HWY 54\", \"HWY 54\", \"RUBY\", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"MARTIN LUTHER K \", \"22\", \"22\", \"22\", \"22\", \"22\", \"224 \", \"224 \", \"224 \", \"WARE\", \"WARE\", \"WARE\", \"WARE\", \"HWY 54\", \"HWY 54\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"OCONEE\", \"STARKEY \", \"22\", \"22\", \"22\", \"HWY 54\", \"HWY 54\", \"22\", \"MAIN\", \"MAIN\", \"MAIN\", \"2ND \", \"2ND \", \"72ND\", \"STARKEY \", \"STARKEY \", \"3RD \", \"3RD \", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"VILLAGRANDE \", \"VILLAGRANDE \", \"STARKEY \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"STARKEY \", \"72ND\", \"72ND\", \"72ND\", \"72ND\", \"2ND \", \"2ND \", \"2ND \", \"3RD \", \"3RD \", \"71ST\", \"71ST\", \"71ST\", \"71ST\", \"71ST\", \"VILLAGRANDE \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"3RD \", \"3RD \", \"3RD \", \"3RD \", \"3RD \", \"3RD \", \"STARKEY \", \"2ND \", \"2ND \", \"2ND \", \"2ND \", \"72ND\", \"72ND\", \"3RD \", \"3RD \", \"VILLAGRANDE \", \"VILLAGRANDE \", \"3RD \", \"WOODHAVEN \", \"WOODHAVEN \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"ELDORADA\", \"ELDORADA\", \"3RD \", \"3RD \", \"3RD \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVE\", \"WOODHAVE\", \"WOODHAVE\", \"STARKEY \", \"WOODHAVEN \", \"WOODHAVEN \", \"EL DORADO \", \"EL DORADO \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"WOODHAVEN \", \"WOODHAVEN \", \"BRANTONWOOD \", \"BRANTONWOOD \", \"EL DORADO \", \"EL DORADO \", \"71ST\", \"WOODHAVEN \", \"WOODHAVEN \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"BRANTWOOD \", \"EL DORADO \", \"EL DORADO \", \"EL DORADO \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \", \"WOODHAVEN \"]',2,NULL,NULL,392);
/*!40000 ALTER TABLE `sx_dataset_colonna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_dataset_file`
--

DROP TABLE IF EXISTS `sx_dataset_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_dataset_file` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_UTENTE` int(20) DEFAULT NULL,
  `NOMEFILE` varchar(255) DEFAULT NULL,
  `TIPOFILE` varchar(255) DEFAULT NULL,
  `SEPARATORE` varchar(255) DEFAULT NULL,
  `NUMERO_RIGHE` int(20) DEFAULT NULL,
  `DATACARICAMENTO` datetime DEFAULT NULL,
  `NOTE` varchar(255) DEFAULT NULL,
  `SESSIONE_LAVORO` int(20) DEFAULT NULL,
  `formatofile` varchar(45) DEFAULT NULL,
  `tipodato` int(11) DEFAULT NULL,
  `LABEL_FILE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_file`
--

LOCK TABLES `sx_dataset_file` WRITE;
/*!40000 ALTER TABLE `sx_dataset_file` DISABLE KEYS */;
INSERT INTO `sx_dataset_file` VALUES (1,NULL,'census_a.txt',NULL,';',449,'2019-09-13 10:09:47',NULL,18,'CSV',1,'DSA'),(2,NULL,'census_b.txt',NULL,';',392,'2019-09-13 10:10:03',NULL,18,'CSV',1,'DSB');
/*!40000 ALTER TABLE `sx_dataset_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_elaborazione`
--

DROP TABLE IF EXISTS `sx_elaborazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_elaborazione` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATAELABORAZIONE` datetime DEFAULT NULL,
  `NOME` varchar(255) DEFAULT NULL,
  `PARAMETRI` varchar(255) DEFAULT NULL,
  `DESCRIZIONE` varchar(255) DEFAULT NULL,
  `SES_ELABORAZIONE` int(20) DEFAULT NULL,
  `BPROCESS` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SX_ELABORAZIONE_PK` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_elaborazione`
--

LOCK TABLES `sx_elaborazione` WRITE;
/*!40000 ALTER TABLE `sx_elaborazione` DISABLE KEYS */;
INSERT INTO `sx_elaborazione` VALUES (1,'2019-08-01 16:20:38','Relais',NULL,'prova',15,1),(2,'2019-08-01 16:38:29','relais',NULL,'',16,1),(3,'2019-08-01 16:56:58','relais',NULL,'',17,1),(4,'2019-09-04 13:36:36','nuovo Probabilistico',NULL,'',18,1),(5,'2019-09-09 14:14:25','processo 0909',NULL,'',18,1),(6,'2019-09-10 15:12:48','p2',NULL,'',18,1);
/*!40000 ALTER TABLE `sx_elaborazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_env_pattern`
--

DROP TABLE IF EXISTS `sx_env_pattern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_env_pattern` (
  `INSTANCE` int(11) DEFAULT NULL,
  `ENV` int(11) DEFAULT NULL,
  `TYPE_IO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_env_pattern`
--

LOCK TABLES `sx_env_pattern` WRITE;
/*!40000 ALTER TABLE `sx_env_pattern` DISABLE KEYS */;
INSERT INTO `sx_env_pattern` VALUES (1,1,2),(1,2,1),(1,3,1),(1,4,2),(1,5,1),(1,7,1),(1,8,3),(1,9,1),(1,10,2),(1,11,2),(1,12,2),(1,13,2),(2,1,2),(2,2,1),(2,3,1),(2,4,2),(2,5,1),(2,7,1),(2,8,3),(2,9,1),(2,10,2),(2,11,2),(2,12,2),(2,13,2),(3,1,2),(3,2,1),(3,3,1),(3,4,2),(3,5,1),(3,7,1),(3,8,3),(3,9,1),(3,10,2),(3,11,2),(3,12,2),(3,13,2),(7,1,2),(7,2,1),(7,3,1),(7,4,2),(7,5,1),(7,7,1),(7,8,3),(7,9,1),(7,10,2),(7,11,2),(7,12,2),(7,13,2),(8,1,2),(8,2,1),(8,3,1),(8,4,2),(8,5,1),(8,7,1),(8,8,3),(8,9,1),(8,10,2),(8,11,2),(8,12,2),(8,13,2),(9,1,2),(9,2,1),(9,3,1),(9,4,2),(9,5,1),(9,7,1),(9,8,3),(9,9,1),(9,10,2),(9,11,2),(9,12,2),(9,13,2);
/*!40000 ALTER TABLE `sx_env_pattern` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_log`
--

DROP TABLE IF EXISTS `sx_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` text,
  `msg_time` datetime DEFAULT NULL,
  `id_sessione` int(20) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_log`
--

LOCK TABLES `sx_log` WRITE;
/*!40000 ALTER TABLE `sx_log` DISABLE KEYS */;
INSERT INTO `sx_log` VALUES (1,'File DSA salvato con successo','2019-09-13 10:09:47',18,'OUT'),(2,'File DSB salvato con successo','2019-09-13 10:10:03',18,'OUT'),(3,'Job for elaborazione[6] and  process[70] STARTED','2019-09-13 10:54:18',18,'OUT'),(4,'Job for elaborazione[6] and  processo[70] COMPLETED','2019-09-13 10:54:55',18,'OUT'),(5,'Job for elaborazione[6] and  process[71] STARTED','2019-09-13 10:57:46',18,'OUT'),(6,'Job for elaborazione[6] and  processo[71] FAILED','2019-09-13 10:57:46',18,'OUT');
/*!40000 ALTER TABLE `sx_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_roles`
--

DROP TABLE IF EXISTS `sx_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_roles` (
  `ID` int(20) NOT NULL,
  `ROLE` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_roles`
--

LOCK TABLES `sx_roles` WRITE;
/*!40000 ALTER TABLE `sx_roles` DISABLE KEYS */;
INSERT INTO `sx_roles` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_USER');
/*!40000 ALTER TABLE `sx_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_rule`
--

DROP TABLE IF EXISTS `sx_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_rule` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `DESCR` varchar(50) DEFAULT NULL,
  `BLOCKRULE` int(20) DEFAULT NULL,
  `RTYPE` int(20) DEFAULT NULL,
  `ERRCODE` int(20) DEFAULT NULL,
  `ACTIVE` int(20) DEFAULT NULL,
  `RULE` text,
  `ACTION` varchar(500) DEFAULT NULL,
  `ECCEZIONE` varchar(500) DEFAULT NULL,
  `RULESET` int(20) DEFAULT NULL,
  `CLASS` varchar(50) DEFAULT NULL,
  `VARIABILE` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014188` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=960 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_rule`
--

LOCK TABLES `sx_rule` WRITE;
/*!40000 ALTER TABLE `sx_rule` DISABLE KEYS */;
INSERT INTO `sx_rule` VALUES (841,NULL,'sss',NULL,NULL,0,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,18,'7',NULL),(842,NULL,NULL,NULL,NULL,0,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,18,'7',NULL),(843,NULL,NULL,NULL,NULL,0,1,'sau1 <= sat1',NULL,NULL,18,'7',NULL),(844,NULL,NULL,NULL,NULL,0,1,'sau2 <= sat2',NULL,NULL,18,'7',NULL),(845,NULL,NULL,NULL,NULL,0,1,'sau3 <= sat3',NULL,NULL,18,'7',NULL),(846,NULL,NULL,NULL,NULL,0,1,'sau4 <= sat4',NULL,NULL,18,'7',NULL),(847,NULL,NULL,NULL,NULL,0,1,'sau5 <= sat5',NULL,NULL,18,'7',NULL),(848,NULL,NULL,NULL,NULL,0,1,'sau6 <= sat6',NULL,NULL,18,'7',NULL),(849,NULL,NULL,NULL,NULL,0,1,'sau7 <= sat7',NULL,NULL,18,'7',NULL),(850,NULL,NULL,NULL,NULL,0,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,19,'7',NULL),(851,NULL,NULL,NULL,NULL,0,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,19,'7',NULL),(852,NULL,NULL,NULL,NULL,0,1,'sau1 <= sat1',NULL,NULL,19,'7',NULL),(853,NULL,NULL,NULL,NULL,0,1,'sau2 <= sat2',NULL,NULL,19,'7',NULL),(854,NULL,NULL,NULL,NULL,0,1,'sau3 <= sat3',NULL,NULL,19,'7',NULL),(855,NULL,NULL,NULL,NULL,0,1,'sau4 <= sat4',NULL,NULL,19,'7',NULL),(856,NULL,NULL,NULL,NULL,0,1,'sau5 <= sat5',NULL,NULL,19,'7',NULL),(857,NULL,NULL,NULL,NULL,0,1,'sau6 <= sat6',NULL,NULL,19,'7',NULL),(858,NULL,NULL,NULL,NULL,0,1,'sau7 <= sat7',NULL,NULL,19,'7',NULL),(859,NULL,NULL,NULL,NULL,0,1,'c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55 == c56',NULL,NULL,19,'7',NULL),(860,NULL,NULL,NULL,NULL,0,1,'s57 <= c57',NULL,NULL,19,'7',NULL),(861,NULL,NULL,NULL,NULL,0,1,'s58 <= c58',NULL,NULL,19,'7',NULL),(862,NULL,NULL,NULL,NULL,0,1,'s59 <= c59',NULL,NULL,19,'7',NULL),(863,NULL,NULL,NULL,NULL,0,1,'s61 <= c61',NULL,NULL,19,'7',NULL),(864,NULL,NULL,NULL,NULL,0,1,'s62 <= c62',NULL,NULL,19,'7',NULL),(865,NULL,NULL,NULL,NULL,0,1,'s63 <= c63',NULL,NULL,19,'7',NULL),(866,NULL,NULL,NULL,NULL,0,1,'s64 <= c64',NULL,NULL,19,'7',NULL),(867,NULL,NULL,NULL,NULL,0,1,'s65 <= c65',NULL,NULL,19,'7',NULL),(868,NULL,NULL,NULL,NULL,0,1,'s66 <= c66',NULL,NULL,19,'7',NULL),(869,NULL,NULL,NULL,NULL,0,1,'s67 <= c67',NULL,NULL,19,'7',NULL),(870,NULL,NULL,NULL,NULL,0,1,'s68 <= c68',NULL,NULL,19,'7',NULL),(871,NULL,NULL,NULL,NULL,0,1,'s69 <= c69',NULL,NULL,19,'7',NULL),(872,NULL,NULL,NULL,NULL,0,1,'s70 <= c70',NULL,NULL,19,'7',NULL),(873,NULL,NULL,NULL,NULL,0,1,'s71 <= c71',NULL,NULL,19,'7',NULL),(874,NULL,NULL,NULL,NULL,0,1,'s72 <= c72',NULL,NULL,19,'7',NULL),(875,NULL,NULL,NULL,NULL,0,1,'s73 <= c73',NULL,NULL,19,'7',NULL),(876,NULL,NULL,NULL,NULL,0,1,'s74 <= c74',NULL,NULL,19,'7',NULL),(877,NULL,NULL,NULL,NULL,0,1,'s75 <= c75',NULL,NULL,19,'7',NULL),(878,NULL,NULL,NULL,NULL,0,1,'s76 <= c76',NULL,NULL,19,'7',NULL),(879,NULL,NULL,NULL,NULL,0,1,'s77 <= c77',NULL,NULL,19,'7',NULL),(880,NULL,NULL,NULL,NULL,0,1,'s78 <= c78',NULL,NULL,19,'7',NULL),(881,NULL,NULL,NULL,NULL,0,1,'s79 <= c79',NULL,NULL,19,'7',NULL),(882,NULL,NULL,NULL,NULL,0,1,'s80 <= c80',NULL,NULL,19,'7',NULL),(883,NULL,NULL,NULL,NULL,0,1,'s81 <= c81',NULL,NULL,19,'7',NULL),(884,NULL,NULL,NULL,NULL,0,1,'s82 <= c82',NULL,NULL,19,'7',NULL),(885,NULL,NULL,NULL,NULL,0,1,'s86 <= c86',NULL,NULL,19,'7',NULL),(886,NULL,NULL,NULL,NULL,0,1,'s87 <= c87',NULL,NULL,19,'7',NULL),(887,NULL,NULL,NULL,NULL,0,1,'c57+c58+c59+c60+c61+c62+c63+c64+c65+c66+c67+c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82+c83+c84+c85+c86+c87 == c88',NULL,NULL,19,'7',NULL),(888,NULL,NULL,NULL,NULL,0,1,'s57+s58+s59+s61+s62+s63+s64+s65+s66+s67+s68+s69+s70+s71+s72+s73+s74+s75+s76+s77+s78+s79+s80+s81+s82+s86+s87 == s88',NULL,NULL,19,'7',NULL),(889,NULL,NULL,NULL,NULL,0,1,'c90+c91+c92 == c93',NULL,NULL,19,'7',NULL),(890,NULL,NULL,NULL,NULL,0,1,'c95+c96 == c97',NULL,NULL,19,'7',NULL),(891,NULL,NULL,NULL,NULL,0,1,'c106+c107+c108 == c98',NULL,NULL,19,'7',NULL),(892,NULL,NULL,NULL,NULL,0,1,'c56+c88+c89+c93 == c94',NULL,NULL,19,'7',NULL),(893,NULL,NULL,NULL,NULL,0,1,'c94+c97+c98+c99+c100 == c101',NULL,NULL,19,'7',NULL),(894,NULL,NULL,NULL,NULL,0,1,'sau8 == c94',NULL,NULL,19,'7',NULL),(895,NULL,NULL,NULL,NULL,0,1,'sat8 == c101',NULL,NULL,19,'7',NULL),(896,NULL,NULL,NULL,NULL,0,1,'c110 <= c100*100',NULL,NULL,19,'7',NULL),(897,NULL,NULL,NULL,NULL,0,1,'c111 <= c101*100',NULL,NULL,19,'7',NULL),(898,NULL,NULL,NULL,NULL,0,1,'for1+for2+for3 == for4',NULL,NULL,19,'7',NULL),(899,NULL,NULL,NULL,NULL,0,1,'for4 == c98',NULL,NULL,19,'7',NULL),(900,NULL,NULL,NULL,NULL,0,1,'for5+for8+for11 <= for1',NULL,NULL,19,'7',NULL),(901,NULL,NULL,NULL,NULL,0,1,'for6+for9+for12 <= for2',NULL,NULL,19,'7',NULL),(902,NULL,NULL,NULL,NULL,0,1,'for7+for10+for13 <= for3',NULL,NULL,19,'7',NULL),(903,NULL,NULL,NULL,NULL,0,1,'ir0 <= c94+c97',NULL,NULL,19,'7',NULL),(904,NULL,NULL,NULL,NULL,0,1,'ir16 <= ir0',NULL,NULL,19,'7',NULL),(905,NULL,NULL,NULL,NULL,0,1,'c89 <= 30',NULL,NULL,19,'7',NULL),(906,NULL,NULL,NULL,NULL,0,1,'ir16>= 0.0001*ir20+0.0001*ir21+0.0001*ir22+0.0001*ir23+0.0001*ir24+0.0001*ir25',NULL,NULL,19,'7',NULL),(907,NULL,NULL,NULL,NULL,0,1,'ir20 <= ir16',NULL,NULL,19,'7',NULL),(908,NULL,NULL,NULL,NULL,0,1,'ir21 <= ir16',NULL,NULL,19,'7',NULL),(909,NULL,NULL,NULL,NULL,0,1,'ir22 <= ir16',NULL,NULL,19,'7',NULL),(910,NULL,NULL,NULL,NULL,0,1,'ir23 <= ir16',NULL,NULL,19,'7',NULL),(911,NULL,NULL,NULL,NULL,0,1,'ir25 <= ir16',NULL,NULL,19,'7',NULL),(912,NULL,NULL,NULL,NULL,0,1,'ir24  <=  ir23',NULL,NULL,19,'7',NULL),(913,NULL,NULL,NULL,NULL,0,1,'ir20 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,19,'7',NULL),(914,NULL,NULL,NULL,NULL,0,1,'ir21 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,19,'7',NULL),(915,NULL,NULL,NULL,NULL,0,1,'ir22 <= c94+c97-c38-c40-c41-c43-c44-c89                   ',NULL,NULL,19,'7',NULL),(916,NULL,NULL,NULL,NULL,0,1,'ir23 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,19,'7',NULL),(917,NULL,NULL,NULL,NULL,0,1,'ir25 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,19,'7',NULL),(918,NULL,NULL,NULL,NULL,0,1,'colt1 <= c94',NULL,NULL,19,'7',NULL),(919,NULL,NULL,NULL,NULL,0,1,'colt2 <= c94',NULL,NULL,19,'7',NULL),(920,NULL,NULL,NULL,NULL,0,1,'colt3 <= c94',NULL,NULL,19,'7',NULL),(921,NULL,NULL,NULL,NULL,0,1,'colt4 <= c56+c88',NULL,NULL,19,'7',NULL),(922,NULL,NULL,NULL,NULL,0,1,'colt5 <= c93',NULL,NULL,19,'7',NULL),(923,NULL,NULL,NULL,NULL,0,1,'colt6 <= c97+c98',NULL,NULL,19,'7',NULL),(924,NULL,NULL,NULL,NULL,0,1,'colt7 <= c55',NULL,NULL,19,'7',NULL),(925,NULL,NULL,NULL,NULL,0,1,'colt8 <= c99+c100',NULL,NULL,19,'7',NULL),(926,NULL,NULL,NULL,NULL,0,1,'colt9 <= c101',NULL,NULL,19,'7',NULL),(927,NULL,NULL,NULL,NULL,0,1,'colt9 == colt4+colt5+colt6+colt7+colt8',NULL,NULL,19,'7',NULL),(928,NULL,NULL,NULL,NULL,0,1,'colt10 <= c101',NULL,NULL,19,'7',NULL),(929,NULL,NULL,NULL,NULL,0,1,'sup1 <= c94+c97',NULL,NULL,19,'7',NULL),(930,NULL,NULL,NULL,NULL,0,1,'sup2 <= c94+c97',NULL,NULL,19,'7',NULL),(931,NULL,NULL,NULL,NULL,0,1,'sup3 <= c94+c97',NULL,NULL,19,'7',NULL),(932,NULL,NULL,NULL,NULL,0,1,'sup4 <= c94+c97',NULL,NULL,19,'7',NULL),(933,NULL,NULL,NULL,NULL,0,1,'sup5 <= c94+c97',NULL,NULL,19,'7',NULL),(934,NULL,NULL,NULL,NULL,0,1,'sup6 <= c94+c97',NULL,NULL,19,'7',NULL),(935,NULL,NULL,NULL,NULL,0,1,'sup7 <= c94+c97',NULL,NULL,19,'7',NULL),(936,NULL,NULL,NULL,NULL,0,1,'sup8 <= c94+c97',NULL,NULL,19,'7',NULL),(937,NULL,NULL,NULL,NULL,0,1,'sup9 <= c98',NULL,NULL,19,'7',NULL),(938,NULL,NULL,NULL,NULL,0,1,'sup10 <= c98',NULL,NULL,19,'7',NULL),(939,NULL,NULL,NULL,NULL,0,1,'sup11 <= c98',NULL,NULL,19,'7',NULL),(940,NULL,NULL,NULL,NULL,0,1,'sup12 <= c98',NULL,NULL,19,'7',NULL),(941,NULL,NULL,NULL,NULL,0,1,'sup13 <= c98',NULL,NULL,19,'7',NULL),(942,NULL,NULL,NULL,NULL,0,1,'sup14 <= c98',NULL,NULL,19,'7',NULL),(943,NULL,NULL,NULL,NULL,0,1,'bio1 <= c1+c2+c3+c4+c5+c6+c7+c8+c9+c10',NULL,NULL,19,'7',NULL),(944,NULL,NULL,NULL,NULL,0,1,'bio2 <= c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41',NULL,NULL,19,'7',NULL),(945,NULL,NULL,NULL,NULL,0,1,'bio3 <= c57+c58+c59+c60',NULL,NULL,19,'7',NULL),(946,NULL,NULL,NULL,NULL,0,1,'bio4 <= c61+c62',NULL,NULL,19,'7',NULL),(947,NULL,NULL,NULL,NULL,0,1,'bio5 <= c63+c64+c65+c66+c67',NULL,NULL,19,'7',NULL),(948,NULL,NULL,NULL,NULL,0,1,'bio6 <= c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82',NULL,NULL,19,'7',NULL),(949,NULL,NULL,NULL,NULL,0,1,'bio7 <= c93',NULL,NULL,19,'7',NULL),(950,NULL,NULL,NULL,NULL,0,1,'bio8 <= c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55+c83+c84+c85+c86+c87+c89 ',NULL,NULL,19,'7',NULL),(951,NULL,NULL,NULL,NULL,0,1,'bio9 == bio1+bio2+bio3+bio4+bio5+bio6+bio7+bio8',NULL,NULL,19,'7',NULL),(952,NULL,NULL,NULL,NULL,0,1,'bio10 <= c94',NULL,NULL,19,'7',NULL),(953,NULL,NULL,NULL,NULL,0,1,'pra1 <= c94',NULL,NULL,19,'7',NULL),(954,NULL,NULL,NULL,NULL,0,1,'pra2 <= c94',NULL,NULL,19,'7',NULL),(955,NULL,NULL,NULL,NULL,0,1,'pra3 <= c94',NULL,NULL,19,'7',NULL),(956,NULL,NULL,NULL,NULL,0,1,'pra4 <= c94',NULL,NULL,19,'7',NULL),(957,NULL,NULL,NULL,NULL,0,1,'pra5 <= c94',NULL,NULL,19,'7',NULL),(958,NULL,NULL,NULL,NULL,0,1,'pra6 <= c94 ',NULL,NULL,19,'7',NULL),(959,NULL,'sd',NULL,NULL,0,1,'a+b',NULL,NULL,20,'1',NULL);
/*!40000 ALTER TABLE `sx_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_rule_type`
--

DROP TABLE IF EXISTS `sx_rule_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_rule_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Descrizione` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Nome` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_rule_type`
--

LOCK TABLES `sx_rule_type` WRITE;
/*!40000 ALTER TABLE `sx_rule_type` DISABLE KEYS */;
INSERT INTO `sx_rule_type` VALUES (1,'Regole di editing','EDITING');
/*!40000 ALTER TABLE `sx_rule_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_ruleset`
--

DROP TABLE IF EXISTS `sx_ruleset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_ruleset` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME_FILE` varchar(50) DEFAULT NULL,
  `LABEL_FILE` varchar(50) DEFAULT NULL,
  `DESCR` varchar(50) DEFAULT NULL,
  `NUMERO_RIGHE` int(10) DEFAULT NULL,
  `DATA_CARICAMENTO` datetime DEFAULT NULL,
  `SESSIONE_LAVORO` int(10) DEFAULT NULL,
  `DATASET` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014346` (`ID`),
  KEY `ws_idx` (`SESSIONE_LAVORO`),
  CONSTRAINT `ws` FOREIGN KEY (`SESSIONE_LAVORO`) REFERENCES `sx_sessione_lavoro` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_ruleset`
--

LOCK TABLES `sx_ruleset` WRITE;
/*!40000 ALTER TABLE `sx_ruleset` DISABLE KEYS */;
INSERT INTO `sx_ruleset` VALUES (18,'edits_short.txt','RS_1','r1',9,NULL,17,NULL),(19,'edits_long.txt','RS_2','regola2',109,NULL,17,NULL),(20,NULL,'RS_1','d',NULL,NULL,19,NULL);
/*!40000 ALTER TABLE `sx_ruleset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_sessione_lavoro`
--

DROP TABLE IF EXISTS `sx_sessione_lavoro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_sessione_lavoro` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_UTENTE` int(20) DEFAULT NULL,
  `DATA_CREAZIONE` datetime DEFAULT NULL,
  `NOME` varchar(255) DEFAULT NULL,
  `DESCRIZIONE` varchar(2000) DEFAULT NULL,
  `BFUNCTION` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SX_SESSIONE_LAVORO_PK` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_sessione_lavoro`
--

LOCK TABLES `sx_sessione_lavoro` WRITE;
/*!40000 ALTER TABLE `sx_sessione_lavoro` DISABLE KEYS */;
INSERT INTO `sx_sessione_lavoro` VALUES (15,83,'2019-08-01 16:18:54','Relais census dataset','',1),(16,83,'2019-08-01 16:36:54','Relais altri dataset','',1),(17,83,'2019-08-01 16:54:23','relais ONS','',1),(18,83,'2019-09-04 12:55:20','Relais census dataset','Prova dopo il refactoring',1),(19,83,'2019-09-06 15:39:12','dfd','fdf',3);
/*!40000 ALTER TABLE `sx_sessione_lavoro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_step_instance`
--

DROP TABLE IF EXISTS `sx_step_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_step_instance` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FNAME` varchar(50) DEFAULT NULL,
  `DESCR` varchar(50) DEFAULT NULL,
  `ETICHETTA` varchar(100) DEFAULT NULL,
  `SERVIZIO` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0013718` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_instance`
--

LOCK TABLES `sx_step_instance` WRITE;
/*!40000 ALTER TABLE `sx_step_instance` DISABLE KEYS */;
INSERT INTO `sx_step_instance` VALUES (11,'contengencyTable','contengencyTable','CTable',250),(12,'fellegisunter','Fellegi Sunter','FellegiSunter',200),(13,'resultTables','Matching Table','MTable',250);
/*!40000 ALTER TABLE `sx_step_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_step_stepinstance`
--

DROP TABLE IF EXISTS `sx_step_stepinstance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_step_stepinstance` (
  `ISTANZA` int(11) DEFAULT NULL,
  `STEP` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_stepinstance`
--

LOCK TABLES `sx_step_stepinstance` WRITE;
/*!40000 ALTER TABLE `sx_step_stepinstance` DISABLE KEYS */;
INSERT INTO `sx_step_stepinstance` VALUES (11,70),(12,71),(13,72);
/*!40000 ALTER TABLE `sx_step_stepinstance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_step_variable`
--

DROP TABLE IF EXISTS `sx_step_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_step_variable` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VAR` int(20) DEFAULT NULL,
  `RUOLO` int(20) DEFAULT NULL,
  `ELABORAZIONE` int(20) DEFAULT NULL,
  `PROCESSO` int(20) DEFAULT NULL,
  `ORDINE` int(20) DEFAULT NULL,
  `TIPO_STATO` int(20) DEFAULT NULL,
  `TIPO_CAMPO` int(20) DEFAULT NULL,
  `FLAG_RICERCA` int(20) DEFAULT NULL,
  `ROLE_GROUP` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014744` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_variable`
--

LOCK TABLES `sx_step_variable` WRITE;
/*!40000 ALTER TABLE `sx_step_variable` DISABLE KEYS */;
INSERT INTO `sx_step_variable` VALUES (1,1,169,6,NULL,2,NULL,1,NULL,NULL),(3,3,154,6,NULL,5,NULL,1,NULL,NULL),(4,4,154,6,NULL,5,NULL,1,NULL,NULL),(5,5,154,6,NULL,5,NULL,1,NULL,NULL),(6,6,155,6,NULL,6,NULL,1,NULL,NULL),(7,7,155,6,NULL,6,NULL,1,NULL,NULL),(8,8,155,6,NULL,6,NULL,1,NULL,NULL),(10,10,170,6,NULL,4,NULL,1,NULL,NULL);
/*!40000 ALTER TABLE `sx_step_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_stepinstance_approle`
--

DROP TABLE IF EXISTS `sx_stepinstance_approle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_stepinstance_approle` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ISTANZA` int(20) DEFAULT NULL,
  `RUOLO` int(20) DEFAULT NULL,
  `TIPO_IO` int(20) DEFAULT NULL,
  `REQUIRED` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014189` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_stepinstance_approle`
--

LOCK TABLES `sx_stepinstance_approle` WRITE;
/*!40000 ALTER TABLE `sx_stepinstance_approle` DISABLE KEYS */;
INSERT INTO `sx_stepinstance_approle` VALUES (154,11,154,1,1),(155,11,155,1,1),(158,11,158,2,NULL),(161,11,161,2,NULL),(166,11,166,1,1),(167,12,161,1,1),(168,12,167,2,NULL),(169,13,154,1,1),(170,13,155,1,1),(171,13,167,1,1),(172,13,161,1,1),(173,13,168,2,NULL),(176,13,169,1,1),(177,13,170,1,1);
/*!40000 ALTER TABLE `sx_stepinstance_approle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_stepinstance_parameter`
--

DROP TABLE IF EXISTS `sx_stepinstance_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_stepinstance_parameter` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `ISTANZA` int(20) DEFAULT NULL,
  `DESCR` varchar(500) DEFAULT NULL,
  `DEFLT` varchar(50) DEFAULT NULL,
  `RUOLO` int(20) DEFAULT NULL,
  `json_template_old` mediumtext,
  `json_template` mediumtext,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014050` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_stepinstance_parameter`
--

LOCK TABLES `sx_stepinstance_parameter` WRITE;
/*!40000 ALTER TABLE `sx_stepinstance_parameter` DISABLE KEYS */;
INSERT INTO `sx_stepinstance_parameter` VALUES (1,'MATCHING VARAIBLES',11,'MATCHING VARAIBLES','3',166,'{\"type\": \"object\", \"properties\": {\"MetricMatchingVariables\":{\"title\":\"MetricMatchingVariables\",\"type\":\"array\",\"items\":{\"type\":\"object\",\"title\":\"MetricMatchingVariable\",\"properties\":{\"MatchingVariable\":{\"type\":\"string\",\"title\":\"MatchingVariable\",\"maxLength\":50,\"required\":true},\"MatchingVariableA\":{\"type\":\"string\",\"title\":\"MatchingVariableA\",\"maxLength\":50,\"required\":true},\"MatchingVariableB\":{\"type\":\"string\",\"title\":\"MatchingVariableB\",\"maxLength\":50,\"required\":true},\"Method\":{\"title\":\"Method\",\"enum\":[\"Jaro\",\"jaro1\",\"Jaro2\"],\"required\":true},\"Thresould\":{\"type\":\"number\",\"title\":\"Threshould\"},\"Window\":{\"type\":\"integer\",\"title\":\"Window\"}}}}}}','{\"data\":[],\"schema\":{\"items\":{\"properties\":{\"MatchingVariable\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariable\",\"type\":\"string\"},\"MatchingVariableA\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariableA\",\"type\":\"string\"},\"MatchingVariableB\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariableB\",\"type\":\"string\"},\"Method\":{\"enum\":[\"Equality\",\"Jaro\",\"Dice\",\"JaroWinkler\",\"Levenshtein\",\"3Grams\",\"Soundex\",\"NumericComparison\",\"NumericEuclideanDistance\",\"WindowEquality\",\"Inclusion3Grams\"],\"required\":true,\"title\":\"Method\"},\"Threshold\":{\"title\":\"Threshold\",\"type\":\"number\"},\"Window\":{\"title\":\"Window\",\"type\":\"integer\"}},\"type\":\"object\"},\"type\":\"array\"},\"options\":{\"type\":\"table\",\"toolbarSticky\":true,\"toolbar\":{\"actions\":[{\"action\":\"up\",\"hidden\":true}]},\"items\":{\"fields\":{\"Method\":{\"type\":\"select\",\"noneLabel\":\"\",\"removeDefaultNone\":false}}}}}'),(2,'THRESHOLD MATCHING',13,'THRESHOLD MATCHING','1',169,'{\"name\":\"THRESHOLD MATCHING\",\"type\":\"number\",\"title\":\"THRESHOLD MATCHING\", \"minimum\": 0.01,\"maximum\": 1}','{\"data\":[],\"schema\":{\"name\":\"THRESHOLD MATCHING\",\"type\":\"number\",\"title\":\"THRESHOLD MATCHING\", \"minimum\": 0.01,\"maximum\": 1}}'),(3,'THRESHOLD UNMATCHING',13,'THRESHOLD UNMATCHING','1',170,'{\"name\":\"THRESHOLD UNMATCHING\",\"type\":\"number\",\"title\":\"THRESHOLD UNMATCHING\", \"minimum\": 0.01,\"maximum\": 1}','{\"data\":[],\"schema\":{\"name\":\"THRESHOLD UNMATCHING\",\"type\":\"number\",\"title\":\"THRESHOLD UNMATCHING\", \"minimum\": 0.01,\"maximum\": 1}}');
/*!40000 ALTER TABLE `sx_stepinstance_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_sub_step`
--

DROP TABLE IF EXISTS `sx_sub_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_sub_step` (
  `STEP` int(20) DEFAULT NULL,
  `SUB_STEP` int(20) DEFAULT NULL,
  `LIVELLO` int(20) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ELSE_STEP` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PK_SUB_STEP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_sub_step`
--

LOCK TABLES `sx_sub_step` WRITE;
/*!40000 ALTER TABLE `sx_sub_step` DISABLE KEYS */;
/*!40000 ALTER TABLE `sx_sub_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_tipo_campo`
--

DROP TABLE IF EXISTS `sx_tipo_campo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_tipo_campo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SX_TIPO_CAMPO_PK` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_campo`
--

LOCK TABLES `sx_tipo_campo` WRITE;
/*!40000 ALTER TABLE `sx_tipo_campo` DISABLE KEYS */;
INSERT INTO `sx_tipo_campo` VALUES (1,'INPUT'),(2,'OUTPUT');
/*!40000 ALTER TABLE `sx_tipo_campo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_tipo_dato`
--

DROP TABLE IF EXISTS `sx_tipo_dato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_tipo_dato` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(32) DEFAULT NULL,
  `DESCRIZIONE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_dato`
--

LOCK TABLES `sx_tipo_dato` WRITE;
/*!40000 ALTER TABLE `sx_tipo_dato` DISABLE KEYS */;
INSERT INTO `sx_tipo_dato` VALUES (1,'INPUT',NULL),(2,'RULE',NULL),(3,'PARAMETER',NULL);
/*!40000 ALTER TABLE `sx_tipo_dato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_tipo_io`
--

DROP TABLE IF EXISTS `sx_tipo_io`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_tipo_io` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SX_TIPO_IO_PK` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_io`
--

LOCK TABLES `sx_tipo_io` WRITE;
/*!40000 ALTER TABLE `sx_tipo_io` DISABLE KEYS */;
INSERT INTO `sx_tipo_io` VALUES (1,'INPUT'),(2,'OUTPUT'),(3,'BOTH');
/*!40000 ALTER TABLE `sx_tipo_io` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_tipo_var`
--

DROP TABLE IF EXISTS `sx_tipo_var`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_tipo_var` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(32) DEFAULT NULL,
  `DESCR` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014045` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_var`
--

LOCK TABLES `sx_tipo_var` WRITE;
/*!40000 ALTER TABLE `sx_tipo_var` DISABLE KEYS */;
INSERT INTO `sx_tipo_var` VALUES (1,'VAR','TIPOLOGIA VARIABILE'),(2,'PAR','TIPOLOGIA PARAMETRO'),(3,'MOD','MODELLO DATI');
/*!40000 ALTER TABLE `sx_tipo_var` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_tipo_variabile_sum`
--

DROP TABLE IF EXISTS `sx_tipo_variabile_sum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_tipo_variabile_sum` (
  `NOME_TIPO_VARIABILE_ITA` varchar(765) DEFAULT NULL,
  `NOME_TIPO_VARIABILE_ENG` varchar(765) DEFAULT NULL,
  `TIPO_VARIABILE` int(11) NOT NULL AUTO_INCREMENT,
  `TITOLO` varchar(600) DEFAULT NULL,
  `ORDINE` int(11) DEFAULT NULL,
  PRIMARY KEY (`TIPO_VARIABILE`),
  UNIQUE KEY `TIPO_VARIABILE_SUM_PK` (`TIPO_VARIABILE`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_variabile_sum`
--

LOCK TABLES `sx_tipo_variabile_sum` WRITE;
/*!40000 ALTER TABLE `sx_tipo_variabile_sum` DISABLE KEYS */;
INSERT INTO `sx_tipo_variabile_sum` VALUES ('VARIABILI STATISTICHE DI CLASSIFICAZIONE','CLASSIFICATION',1,'Variabili statistiche di classificazione',2),('VARIABILI STATISTICHE NUMERICHE','NUMERIC',2,'Variabili statistiche numeriche',3),('VARIABILI STATISTICHE TESTUALI','TEXTUAL/OPENED',3,'Variabili statistiche testuali',4),('CONCETTI DI TIPO OPERATIVO','OPERATIONAL',4,'Concetti di tipo operativo',6),('CONCETTI DI TIPO TEMPORALE','TEMPORALE',5,'Concetti di tipo temporale',7),('AGGREGATO','AGGREGATE',6,'Concetti relativi al contenuto dei dati',5),('CONCETTI RELATIVI ALLA FREQUENZA','FREQUENCY',7,'Concetti relativi alla frequenza',8),('VARIABILI IDENTIFICATIVE DELLE UNITÀ','INDENTIFIER',8,'Variabili identificative delle unità',1),('NON DEFINITA','UNDEFINED',9,'Variabili non definite',12),('PESO','PESO',10,'Concetti usati per identificare il peso campionario',9),('CONCETTI IDENTIFICATIVI DEL DATASET','DATASET IDENTIFIER',11,'Variabili statistiche composte',11),('PARADATO','PARADATA',12,'Paradati ..',10);
/*!40000 ALTER TABLE `sx_tipo_variabile_sum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_user_roles`
--

DROP TABLE IF EXISTS `sx_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_user_roles` (
  `id` int(11) NOT NULL,
  `role` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_user_roles`
--

LOCK TABLES `sx_user_roles` WRITE;
/*!40000 ALTER TABLE `sx_user_roles` DISABLE KEYS */;
INSERT INTO `sx_user_roles` VALUES (1,'ADMIN'),(2,'USER');
/*!40000 ALTER TABLE `sx_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_users`
--

DROP TABLE IF EXISTS `sx_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_users` (
  `USERID` int(11) NOT NULL AUTO_INCREMENT,
  `EMAIL` varchar(255) DEFAULT NULL,
  `NAME` varchar(100) DEFAULT NULL,
  `SURNAME` varchar(100) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `ROLEID` int(11) DEFAULT NULL,
  PRIMARY KEY (`USERID`)
) ENGINE=InnoDB AUTO_INCREMENT=456 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_users`
--

LOCK TABLES `sx_users` WRITE;
/*!40000 ALTER TABLE `sx_users` DISABLE KEYS */;
INSERT INTO `sx_users` VALUES (83,'fra@fra.it','Francesco Amato','fra','$2a$10$DIcyvIFwhDkEOT9nBugTleDM73OkZffZUdfmvjMCEXdJr3PZP8Kxm',1),(243,'user@is2.it','user','test','$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82',2),(445,'admin@is2.it','Administrator','admin','$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC',1),(451,'survey@istat.it','francesc8','sada','$2a$10$SBKYfMVUdHl.1mY2BGuG1uGBE.xRcpJsIC.dyJBfS2Cyl6FEYSwg.',1),(452,'pippo@pippo.it','franco','franco','$2a$10$Fc9JXOqpO8Ar.t0eoOS8pew7RejzFDmGatAqff/RME9qAB9FHY4M6',1);
/*!40000 ALTER TABLE `sx_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_workset`
--

DROP TABLE IF EXISTS `sx_workset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_workset` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ORDINE` int(20) DEFAULT NULL,
  `valori` json DEFAULT NULL,
  `TIPO_VAR` int(20) DEFAULT NULL,
  `VALORI_SIZE` int(20) DEFAULT NULL,
  `vjson` json DEFAULT NULL,
  `param_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014021` (`ID`),
  KEY `TIPOVAR` (`TIPO_VAR`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_workset`
--

LOCK TABLES `sx_workset` WRITE;
/*!40000 ALTER TABLE `sx_workset` DISABLE KEYS */;
INSERT INTO `sx_workset` VALUES (1,'THRESHOLD MATCHING',NULL,'[\"1\"]',2,1,NULL,'0.8'),(3,'DSA_SURNAME',NULL,'[\"ANDERSON\", \"ANDERSON\", \"ANDERSON\", \"ANDERSON\", \"AQUENDO\", \"BENITEZ\", \"BENITEZ\", \"BENITEZ\", \"BODNER\", \"BODNER\", \"BODNER\", \"BODNER\", \"BODNER\", \"CENTURY\", \"CENTURY\", \"CENTURY\", \"CHEESMAN\", \"CHEESMAN\", \"CONYERE\", \"CONYERE\", \"COSGRAVE\", \"COSGRAVE\", \"COSGRAVE\", \"COSGRAVE\", \"COSGRAVE\", \"DANIEL LEIVA\", \"DANIEL LEIVA\", \"DARCOURT\", \"DECANAY\", \"DECANAY\", \"DECANAY\", \"DIVERS\", \"DOMINGUEZ\", \"DOMINGUEZ\", \"FAUST\", \"FISCHGRUND\", \"FISCHGRUND\", \"FISCHGRUND\", \"GENE\", \"GENE\", \"GIERINGER\", \"GIERINGER\", \"GIERINGER\", \"GIERINGER\", \"GIERINGER\", \"GREEN\", \"GREEN\", \"HENNEGGEY\", \"HENNEGGEY\", \"HILL\", \"JIMENCZ\", \"JIMENCZ\", \"JIMENCZ\", \"JIMENEZ\", \"KAY\", \"KELLY\", \"KILLION\", \"LAKATOS\", \"LAKATOS\", \"LASSITER\", \"LASSITER\", \"LASSITER\", \"LASSITER\", \"LETO\", \"MALDONADO\", \"MALDONADO\", \"MALDONADO\", \"MALENDES\", \"MALENDES\", \"MCCLAIN\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"MOSQUERA\", \"PAIGIE\", \"PARVA\", \"PARVA\", \"RODRIGUEZ\", \"RODRIGUEZ\", \"ROUNSEVELLE\", \"SKANOS\", \"SKANOS\", \"TORRES\", \"TORRES\", \"VALDES\", \"VALDES\", \"VARGAS\", \"VARGAS\", \"VARGAS\", \"VARGAS\", \"WEBSTER\", \"WEBSTER\", \"WICZALKOWSKI\", \"WICZALKOWSKI\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BANK\", \"BARNES\", \"BARNES\", \"BURGERSS\", \"BURGERSS\", \"BURGERSS\", \"BURGESS\", \"BURGESS\", \"BURGESS\", \"BURGESS\", \"BURRISS\", \"BURRISS\", \"BURRISS\", \"BUTLER\", \"CHISOLM\", \"CHISOLM\", \"COATES\", \"CONRON\", \"COTTEN\", \"COTTEN\", \"COTTEN\", \"DIGGS\", \"DIGGS\", \"DORSIE\", \"DUNNOCK\", \"GOINS\", \"GOINS\", \"GOINS\", \"GOINS\", \"GOWANS\", \"GOWANS\", \"HOERRLING\", \"HOERRLING\", \"HOERRLING\", \"HOERRLING\", \"HOERRLING\", \"HOLMES\", \"HOLMES\", \"HOLMES\", \"HOLMES\", \"HOLMES\", \"HUGGINCHES\", \"HUGGINCHES\", \"HUGGINCHES\", \"HUGGINCHES\", \"HUTCHINSON\", \"HUTCHINSON\", \"HUTCHINSON\", \"HUTCHINSON\", \"LEVEN\", \"MATKIN\", \"MATKIN\", \"MATKIN\", \"MATKIN\", \"OWENS\", \"OWENS\", \"OWENS\", \"OWENS\", \"OWENS\", \"OWENS\", \"PAIGE\", \"SPRINGGS\", \"SYKES\", \"SYKES\", \"SYKES\", \"SYKES\", \"THOMPSON\", \"TREZEVANT\", \"TREZEVANT\", \"TREZEVANT\", \"WHITAKER\", \"WHITAKER\", \"WHITAKER\", \"WHITAKER\", \"1RUMOR\", \"1RUMOR\", \"1RUMOR\", \"1RUMOR\", \"1RUMOR\", \"ALSTIN\", \"ALSTIN\", \"ALSTIN\", \"CAMPBELL\", \"CAMPBELL\", \"CAMPBELL\", \"CAMPBELL\", \"CARR\", \"CARR\", \"CARR\", \"CARTER\", \"CARTER\", \"CAVAJEL\", \"CAVAJEL\", \"CAVAJEL\", \"CAVAJEL\", \"CHAMBARS\", \"CHAMBARS\", \"COLBY\", \"COUPE\", \"COUPE\", \"CRIDER\", \"CRIDER\", \"DAVIES\", \"DAVIES\", \"DAVIES\", \"DAVIES\", \"DEGRAENED\", \"DEGRAENED\", \"DORMAN\", \"DORMAN\", \"DORMAN\", \"DOWOKAKOKO\", \"DOWOKAKOKO\", \"DOWOKAKOKO\", \"EASLEY\", \"EASLEY\", \"EASLEY\", \"EASLEY\", \"ELLIOTT\", \"ELLIOTT\", \"ERVINE\", \"ERVINE\", \"ERVINE\", \"ERVINE\", \"FREY\", \"GARRETT\", \"GARRETT\", \"GORDON\", \"GORDON\", \"GORDON\", \"GRANER\", \"GRANER\", \"GRANER\", \"GREENE\", \"GREENE\", \"GREENE\", \"GREENE\", \"GREENE\", \"GUIDETI\", \"HAMMONDS\", \"HAMMONDS\", \"HAMMONDS\", \"HANKINS\", \"HANKINS\", \"HEAVENER\", \"HEAVENER\", \"HEAVENER\", \"HETTERICH\", \"HOLLEY\", \"HOLLEY\", \"HOLLEY\", \"HOLLEY\", \"HUDSON\", \"HUSSEINKHEL\", \"HUSSEINKHEL\", \"KEARNS\", \"KEARNS\", \"KEARNS\", \"KEARNS\", \"KEICHENBERG\", \"KEICHENBERG\", \"KLEIMAN\", \"KLEIMAN\", \"LESKO\", \"LESKO\", \"LESKO\", \"MACCIO\", \"MACCIO\", \"MARTINEZ STG\", \"MARTINEZ STG\", \"MARTINEZ STG\", \"MCALLISTER\", \"MCALLISTER\", \"MOHRING\", \"MOHRING\", \"MOSES\", \"OBROCK\", \"PEARL\", \"PEARL\", \"RAGLIN\", \"REAVES\", \"REAVES\", \"REAVES\", \"RODRIGUEZ\", \"RODRIGUEZ\", \"ROTHSHILD\", \"ROTHSHILD\", \"ROTHSHILD\", \"RUDASILL\", \"RUDASILL\", \"RUDASILL\", \"RUDASILL\", \"RUDASILL\", \"RUEHLING\", \"RUEHLING\", \"RUMOR\", \"RUSSALL\", \"RUSSALL\", \"RUSSALL\", \"SANTIAGO\", \"SANTIAGO\", \"SANTIAGO\", \"SANTIAGO\", \"SQUILLANTE\", \"SQUILLANTE\", \"SWAGOI\", \"SWAGOI\", \"SWAGOI\", \"SWAGOI\", \"SWAGOI\", \"SYKS\", \"TONSTALL\", \"TONSTALL\", \"TONSTALL\", \"WASHINGTON\", \"WASHINGTON\", \"WASHINGTON\", \"WASHINGTON\", \"WIESMAN\", \"BELL\", \"BRAWD\", \"BRAWD\", \"CARTER\", \"DUCOTY\", \"DUCOTY\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"DUFFY TYLER\", \"EHM\", \"EHM\", \"EHM\", \"GASBARRO\", \"GASBARRO\", \"GASBARRO\", \"GASBARRO\", \"GASBARRO\", \"HELLER\", \"HELLER\", \"HELLER\", \"HELLER\", \"HELLER\", \"HELLER\", \"HOPPER\", \"HOPPER\", \"HOPPER\", \"HUBRIC\", \"HUBRIC\", \"PAINE WELLS\", \"PAINE WELLS\", \"PAINE WELLS\", \"PAINE WELLS\", \"PAINE WELLS\", \"PENSETH\", \"PENSETH\", \"PENSETH\", \"POLLACK\", \"POLLACK\", \"POLLACK\", \"POLLACK\", \"POLLACK\", \"POLLACK\", \"ROWEN\", \"ROWEN\", \"ROWEN\", \"ROWEN\", \"SAUNDERS\", \"SAUNDERS\", \"SCCHWARTZ\", \"SCCHWARTZ\", \"SMALLS\", \"SMALLS\", \"SMALLS\", \"SMALLS\", \"ARCHER\", \"ARCHER\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"BELTRAN\", \"CAGER\", \"CAGER\", \"CAGER\", \"COBEZA\", \"COBEZA\", \"COBEZA\", \"COBEZA\", \"DORSEY\", \"DORSEY\", \"DORSEY\", \"DORSEY\", \"DRENMON\", \"DRENMON\", \"DRENMON\", \"FLEEK\", \"FLEEK\", \"FLOWERS\", \"FLOWERS\", \"GALIDEZ\", \"GALIDEZ\", \"GALIDEZ\", \"GALIDEZ\", \"HILLEGAS\", \"HILLEGAS\", \"HILLEGAS\", \"HILLEGAS\", \"HILLEGAS\", \"HOLLOWAY\", \"HOLLOWAY\", \"KEARNEY\", \"KEARNEY\", \"KEARNEY\", \"MANGUM\", \"MANGUM\", \"MITCHELLL\", \"MITCHELLL\", \"RADRIGZ\", \"RADRIGZ\", \"RAMAS\", \"RHODES\", \"RHODES\", \"RHODES\", \"RHODES\", \"RIBERA\", \"RIBERA\", \"RICHARDSON\", \"RICHARDSON\", \"STAPPY\", \"STAPPY\", \"STAPPY\", \"STAPPY\", \"STAPPY\", \"STEWARD\", \"STEWARD\", \"WCIGNT\", \"WCIGNT\", \"WILKES\", \"WILKES\", \"WILKES\", \"WILLIAMS\", \"WILLIAMS\", \"YETES\", \"YETES\"]',1,449,NULL,NULL),(4,'DSA_NAME',NULL,'[\"\", \"\", \"\", \"\", \"CLARA\", \"LEARONAD\", \"SAMUEL\", \"DELORES\", \"JAMEL\", \"ROSETTA\", \"MADGE\", \"ROSALIND\", \"CAROLYN\", \"IVAN\", \"RAMON\", \"ALICIA\", \"DONYA\", \"DONTE\", \"DOMINIQUE\", \"CONNIE\", \"SEKOV\", \"TIERRA\", \"THERSA\", \"\", \"\", \"SAMMY\", \"THAOLYNN\", \"\", \"MICHEAL\", \"AJASIA\", \"BRIANCE\", \"MILEORD\", \"FRANKLIN\", \"SHAVON\", \"ANNA\", \"WESTLEY\", \"NADESDIA\", \"DANYCE\", \"MICHAEL\", \"CASSANDRA\", \"GHOLOM\", \"JEFFERY\", \"JEFFERY\", \"DOUGLAS\", \"MAIRE\", \"TEMPESTT\", \"\", \"\", \"\", \"RAYMOND\", \"IRVIN\", \"AUNDERE\", \"WILLPAMINA\", \"BARBARA\", \"\", \"\", \"JORGE\", \"TONYA\", \"DANEILLE\", \"\", \"\", \"DOROTHEA\", \"LELIA\", \"JOSEPH\", \"DEWIGHT\", \"MARQUISE\", \"MABLE\", \"\", \"\", \"\", \"AISHA\", \"ANDREA\", \"ROMINE\", \"TANYA\", \"PRINCETTA\", \"LAKESHIA\", \"HERMEN\", \"XANTHE\", \"JEMES\", \"\", \"TOWANDA\", \"GEARLDINE\", \"DEREK\", \"DAVON\", \"LENORA\", \"RANDOLPH\", \"FREEMAN\", \"WAYNE\", \"THRESA\", \"BRANDEN\", \"ALEXANDER\", \"ELIZABETH\", \"THUYKIM\", \"DANNY\", \"SHALLY\", \"ALEXANDER\", \"DOLORES\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"LATISHA\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"REFUS\", \"CHRISTOPHER\", \"ZACHARY\", \"TRAINA\", \"ANA\", \"GERALDO\", \"FRANCISCO\", \"ERICK\", \"LUCILLE\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"ROY\", \"\", \"\", \"\", \"\", \"ROSETTA\", \"JACQUELINE\", \"ANA\", \"\", \"\", \"\", \"\", \"\", \"DIWALDO\", \"BERNADINA\", \"TERRAN\", \"ZAKIYA\", \"\", \"LEO\", \"MICHEAL\", \"ROSE\", \"ANTONINO\", \"JESSICA\", \"MARINELA\", \"\", \"DARRYL\", \"BERRY\", \"ROSELINE\", \"RODRICK\", \"JOANNIE\", \"ADMAN\", \"STEPHEN\", \"MALISSA\", \"SARAH\", \"LAWRENCE\", \"EUGENE\", \"\", \"MARKO\", \"\", \"GUILLERMO\", \"MARCO\", \"W\", \"MICHELE\", \"RENEE\", \"SARAH\", \"GERARDO\", \"ALLAN\", \"\", \"\", \"\", \"GREG\", \"A\", \"\", \"MATTHEW\", \"FLORIPE\", \"KERI\", \"NILSA\", \"CHERYL\", \"FLAINE\", \"ALE JARDRO\", \"JUAN\", \"ZIONARA\", \"\", \"ETHNY\", \"SHAWNETT\", \"HARRIET\", \"KRISTY\", \"DIANE\", \"ROSEMARIE\", \"DANIEL\", \"ROBERT\", \"MARJORIE\", \"EDUARDSO\", \"SONDRA\", \"ANN\", \"MICHELE\", \"ROSETA\", \"\", \"JAMES\", \"LENWOOD\", \"TRACEY\", \"STEPHENE\", \"PAYMM\", \"\", \"\", \"\", \"JOHNNY\", \"MICHEAL\", \"DIMON\", \"KATHERINE\", \"CHARLOTTE\", \"JACQUELINE\", \"ARCHIE\", \"\", \"\", \"\", \"\", \"\", \"SUSAN\", \"JUDY\", \"ANTONIO\", \"JOCELYN\", \"CLEARANCE\", \"BEN\", \"\", \"ORESTE\", \"OLIVIA\", \"ERIKA\", \"\", \"\", \"GEOFFREY\", \"JEANETTE\", \"DOMINIQUE\", \"JANICE\", \"SHIRLEG\", \"\", \"\", \"\", \"REYAN\", \"\", \"\", \"\", \"QUENTIN\", \"STEPHANIE\", \"PHILLIP\", \"J\", \"HILLIARD\", \"DOMINIC\", \"SEPTIMIA\", \"KIMBERLY\", \"ALISA\", \"\", \"TRACIE\", \"MELISSA\", \"\", \"MYRIAM\", \"JORGE\", \"LYNNETTE\", \"PELHAM\", \"GEORGE\", \"ANGELA\", \"JESSEE\", \"LUIS\", \"GERAR\", \"CHARLES\", \"ISRAEL\", \"MARY CAROLE\", \"\", \"\", \"KATHERINE\", \"NICHOLE\", \"MARY\", \"HARRIETT\", \"J\", \"STEPHENS\", \"AMAURY\", \"XIOMARA\", \"\", \"GLORIANNE\", \"ALLEN\", \"ANN0\", \"JEAN\", \"DOUGASS\", \"MICLELLE\", \"L\", \"D\", \"BENJAMIN\", \"ALICIA\", \"GERALDENE\", \"NATSHA\", \"JESUS\", \"ETHEL\", \"\", \"PABLOS\", \"LEANNE\", \"ERIN\", \"JO\", \"\", \"DIXION\", \"DOREN\", \"TEGIRA\", \"AGELEON\", \"\", \"\", \"ARISTIDES\", \"CARLOS\", \"ROSEY\", \"CHARLES\", \"DIANE\", \"SIGFREDO\", \"AGEL\", \"OSWALDO\", \"IGNACIO\", \"BARBARA\", \"JEFFREY\", \"THRESA\", \"ANNE\", \"ANDREW E\", \"JAMAR\", \"DARON\", \"SHAWN\", \"MIRIAM\", \"LEAH\", \"CHRISTOPHER\", \"EARNEST\", \"CATHY\", \"ELFRIEDA\", \"NICOLAS\", \"CATHERINE\", \"JOHN\", \"TRICIA\", \"JEFFREY\", \"INGER\", \"\", \"\", \"MARC\", \"JEAN\", \"LAWRENCE\", \"JEFF\", \"SOUTA\", \"ELMER\", \"WILEY\", \"GISELA\", \"RUTH ANN\", \"EDWIN\", \"EARLE\", \"ROSETTA\", \"RONNIE\", \"KENNETH\", \"SHAWN\", \"\", \"ARY\", \"MELISSA\", \"DEBBIE\", \"ENDA\", \"ISSAC\", \"ERNEST\", \"THERESA\", \"JOANNIE\", \"ANNTIONETTE\", \"STANLY\", \"COVNELIA\", \"KEN\", \"ENZELEE\", \"MICHELLE\", \"CHATERAH\", \"GIANNI\", \"JANICE\", \"HAILLE\", \"ROSA\", \"JAMIE\", \"SCOT\", \"JENIFFER\", \"SHANIKA\", \"ASHELY\", \"SHERMISE\", \"ROB\", \"BAKIA\", \"JEROME\", \"DONETTA\", \"JOSH\", \"RUGY\", \"SONJA\", \"JEFF\", \"HENRIETTE\", \"JANNIE\", \"JOANN\", \"JOHONNY\", \"STUART\", \"EMMETTE\", \"TAMIKA\", \"JEFF\", \"FRANKLIN\", \"ELLA LOUISE\", \"QUAYN\", \"ARLIE\", \"FREDERICK\", \"CHANTEL\", \"BRIAN\", \"MAXICINE\", \"BEN\", \"STEVE\", \"HARRIETTE\", \"CHARLIE\", \"SHERRI\", \"CHANCE\", \"ALFREDRICK\"]',1,449,NULL,NULL),(5,'DSA_LASTCODE',NULL,'[\"\", \"\", \"\", \"\", \"J\", \"A\", \"R\", \"R\", \"C\", \"L\", \"R\", \"N\", \"L\", \"R\", \"L\", \"B\", \"L\", \"\", \"S\", \"E\", \"L\", \"\", \"G\", \"L\", \"C\", \"J\", \"R\", \"G\", \"A\", \"M\", \"G\", \"J\", \"K\", \"M\", \"N\", \"M\", \"A\", \"L\", \"C\", \"C\", \"W\", \"W\", \"W\", \"D\", \"T\", \"Z\", \"L\", \"L\", \"L\", \"G\", \"V\", \"V\", \"S\", \"M\", \"\", \"\", \"L\", \"M\", \"S\", \"J\", \"\", \"K\", \"\", \"E\", \"B\", \"\", \"\", \"\", \"A\", \"\", \"C\", \"G\", \"O\", \"O\", \"D\", \"O\", \"M\", \"N\", \"V\", \"G\", \"S\", \"\", \"\", \"B\", \"S\", \"E\", \"R\", \"H\", \"\", \"R\", \"R\", \"L\", \"\", \"A\", \"\", \"J\", \"A\", \"D\", \"\", \"A\", \"P\", \"P\", \"B\", \"C\", \"L\", \"D\", \"L\", \"L\", \"E\", \"C\", \"D\", \"A\", \"\", \"\", \"\", \"A\", \"J\", \"\", \"D\", \"C\", \"R\", \"A\", \"A\", \"A\", \"A\", \"M\", \"L\", \"T\", \"R\", \"\", \"D\", \"M\", \"D\", \"D\", \"B\", \"A\", \"C\", \"S\", \"D\", \"D\", \"W\", \"\", \"R\", \"R\", \"A\", \"M\", \"\", \"\", \"\", \"\", \"M\", \"L\", \"L\", \"\", \"\", \"L\", \"G\", \"E\", \"T\", \"N\", \"S\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"M\", \"M\", \"T\", \"F\", \"C\", \"M\", \"T\", \"A\", \"\", \"L\", \"A\", \"A\", \"E\", \"\", \"\", \"E\", \"A\", \"E\", \"D\", \"B\", \"J\", \"D\", \"\", \"\", \"L\", \"D\", \"L\", \"L\", \"\", \"F\", \"J\", \"\", \"P\", \"E\", \"M\", \"U\", \"N\", \"M\", \"N\", \"D\", \"R\", \"W\", \"R\", \"N\", \"S\", \"A\", \"A\", \"\", \"D\", \"D\", \"D\", \"\", \"A\", \"A\", \"E\", \"T\", \"E\", \"B\", \"R\", \"R\", \"L\", \"M\", \"\", \"\", \"R\", \"A\", \"A\", \"C\", \"A\", \"M\", \"A\", \"D\", \"C\", \"M\", \"R\", \"\", \"T\", \"R\", \"R\", \"V\", \"\", \"T\", \"T\", \"A\", \"E\", \"\", \"\", \"\", \"A\", \"\", \"E\", \"M\", \"L\", \"A\", \"B\", \"V\", \"\", \"\", \"\", \"S\", \"E\", \"M\", \"\", \"\", \"M\", \"M\", \"B\", \"M\", \"\", \"G\", \"\", \"C\", \"\", \"B\", \"J\", \"D\", \"R\", \"R\", \"\", \"L\", \"E\", \"A\", \"E\", \"L\", \"M\", \"S\", \"D\", \"A\", \"A\", \"S\", \"L\", \"C\", \"\", \"L\", \"E\", \"T\", \"A\", \"\", \"A\", \"M\", \"T\", \"B\", \"C\", \"M\", \"L\", \"C\", \"J\", \"P\", \"I\", \"P\", \"E\", \"V\", \"M\", \"J\", \"D\", \"B\", \"S\", \"C\", \"A\", \"J\", \"M\", \"\", \"L\", \"M\", \"A\", \"J\", \"M\", \"U\", \"\", \"K\", \"\", \"A\", \"J\", \"J\", \"J\", \"M\", \"J\", \"A\", \"C\", \"C\", \"B\", \"P\", \"\", \"J\", \"J\", \"J\", \"J\", \"C\", \"J\", \"A\", \"A\", \"\", \"F\", \"S\", \"P\", \"J\", \"A\", \"J\", \"A\", \"\", \"C\", \"G\", \"L\", \"F\", \"E\", \"P\", \"B\", \"J\", \"A\", \"C\", \"A\", \"C\", \"J\", \"M\", \"A\", \"A\", \"M\", \"M\", \"M\", \"M\", \"J\", \"\", \"R\", \"E\", \"M\", \"S\", \"J\", \"M\", \"L\", \"F\", \"R\", \"A\", \"\", \"\", \"J\", \"M\", \"E\", \"E\", \"M\", \"M\", \"E\", \"\", \"E\", \"C\", \"E\", \"C\", \"T\", \"E\", \"E\", \"J\", \"J\", \"E\", \"J\", \"M\", \"D\", \"E\", \"K\", \"L\", \"\", \"M\", \"N\", \"U\", \"K\", \"E\", \"R\", \"F\", \"E\", \"F\", \"B\", \"A\", \"A\", \"A\", \"\", \"H\", \"W\", \"M\", \"L\", \"A\", \"V\", \"E\", \"S\"]',1,449,NULL,NULL),(6,'DSB_SURNAME',NULL,'[\"AHREWS\", \"AHREWS\", \"BENETAS\", \"BENETAS\", \"BENETAS\", \"BODMER\", \"BODMER\", \"BODMER\", \"BODMER\", \"BODMER\", \"CETO\", \"CHEESEMAN\", \"CHEESEMAN\", \"CONNER\", \"CONNER\", \"COSGRAOE\", \"COSGRAOE\", \"COSGRAOE\", \"DACANAY\", \"DACANAY\", \"DACANAY\", \"DANIEL-LEIVA\", \"DANIEL-LEIVA\", \"DIVER\", \"DOMINQUEZ\", \"DOMINQUEZ\", \"ENGELSKIRCH\", \"ENGELSKIRCH\", \"FAIRIE\", \"FISCHARUND\", \"FISCHARUND\", \"FISCHARUND\", \"GECKLE\", \"GECKLE\", \"GERING\", \"GERINGER\", \"GERINGER\", \"GERINGER\", \"GERINGER\", \"GERINGER\", \"GLICK\", \"GREENE\", \"HALL\", \"HILLION\", \"JEANS\", \"JEANS\", \"JEANS\", \"JIMEMEZ\", \"JIMEMEZ\", \"JIMENEZ\", \"JIMENEZ\", \"JIMENEZ\", \"KELLEY\", \"LAKHTOSH\", \"LAKHTOSH\", \"LASITTER\", \"LASITTER\", \"MALDONABO\", \"MALDONABO\", \"MALDONABO\", \"MORGAN\", \"MORGAN\", \"MOSGERA\", \"MOSGUERA\", \"MOSGUERA\", \"MOSGUERA\", \"MOSGUERA\", \"MOSGUERA\", \"MOSGUERA\", \"OQUENDO\", \"PAIGE\", \"PARRA\", \"RAUST\", \"RODREQUE\", \"RODREQUE\", \"ROUNSVELLE\", \"SENTRY\", \"SENTRY\", \"SENTRY\", \"SHANKS\", \"SHANKS\", \"TORRIS\", \"TORRIS\", \"VALDEZ\", \"VALDEZ\", \"VARGAS MUNOZ\", \"VARGAS-HERNAN\", \"VARGAS-HERNAN\", \"VARGAS-HERNAN\", \"WESTERN\", \"WESTERN\", \"WIZALKOWSKI\", \"WIZALKOWSKI\", \"CANNON\", \"DORSER\", \"HOERNING\", \"HOERNING\", \"HOERNING\", \"HOERNING\", \"HOERNING\", \"JOHNS\", \"JOHNS\", \"JOLMES\", \"JOLMES\", \"JOLMES\", \"JOLMES\", \"KENNY\", \"SPRIGGS\", \"TREAEVANT\", \"TREAEVANT\", \"ALSTON\", \"ALSTON\", \"ALSTON\", \"BARRETT\", \"BARRETT\", \"CAMBLE\", \"CAMBLE\", \"CAMBLE\", \"CARL\", \"CARL\", \"CARL\", \"CARTIER\", \"CARTIER\", \"CARVAJAL\", \"CARVAJAL\", \"CARVAJAL\", \"CARVAJAL\", \"CHAMBERS\", \"CHAMBERS\", \"COBY\", \"COBY\", \"COBY\", \"COBY\", \"CRIBER\", \"CRIBER\", \"DAVIS\", \"DAVIS\", \"DAVIS\", \"DAVIS\", \"DEGRAGENRIED\", \"DEGRAGENRIED\", \"DICKERSON\", \"EASELY\", \"EASELY\", \"EASELY\", \"EASELY\", \"ELLICATT-KEAN\", \"ELLICATT-KEAN\", \"FOSTER\", \"FRY\", \"GARNER\", \"GARNER\", \"GARNER\", \"GARRET\", \"GARRET\", \"GORODN\", \"GORODN\", \"GORODN\", \"GREEN\", \"GREEN\", \"GREEN\", \"GREEN\", \"GREEN\", \"HACHETT\", \"HACHETT\", \"HACHETT\", \"HACHETT\", \"HAMMOND\", \"HAMMOND\", \"HAMMOND\", \"HASKINS\", \"HASKINS\", \"HEAVAENER\", \"HEAVAENER\", \"HEAVAENER\", \"HENRIKSON\", \"HENRIKSON\", \"HENRIKSON\", \"HENRIKSON\", \"HENRIKSON\", \"HOLLY\", \"HOLLY\", \"HOLLY\", \"HOLLY\", \"HOSHINGTON\", \"HOSHINGTON\", \"HOSHINGTON\", \"HOSHINGTON\", \"HULLEY\", \"HULLEY\", \"HUSSEINKEL\", \"HUTSON\", \"IRVIN\", \"IRVIN\", \"IRVIN\", \"KLEINMAN\", \"KLEINMAN\", \"KOUPE\", \"KUMOR\", \"KUMOR\", \"KUMOR\", \"KUMOR\", \"KUMOR\", \"KUMOR\", \"LESCO\", \"LESCO\", \"MARTINEZ\", \"MATEO\", \"MATEO\", \"MATEO\", \"MATEO\", \"MCALISTER\", \"MCALISTER\", \"MITCHELL\", \"MOHRINA\", \"MOHRINA\", \"MOSER\", \"MUCCIO\", \"MUCCIO\", \"OLOWOKAKOKO\", \"OLOWOKAKOKO\", \"PARK\", \"PARK\", \"PETTRICH\", \"REEVES\", \"REEVES\", \"REEVES\", \"REICHENBERG\", \"REICHENBERG\", \"RODRIGUES\", \"RODRIGUES\", \"ROGLIN\", \"ROTHCHILD\", \"ROTHCHILD\", \"ROTHCHILD\", \"RUDAGILL\", \"RUDAGILL\", \"RUDAGILL\", \"RUDAGILL\", \"RUIHLING\", \"RUIHLING\", \"RUSSELL\", \"RUSSELL\", \"RUSSELL\", \"SHAWQI\", \"SHAWQI\", \"SHAWQI\", \"SINEFIELD\", \"SOLLIVAN\", \"SOLLIVAN\", \"SOLLIVAN\", \"SQUILLANGE\", \"SQUILLANGE\", \"SYKES\", \"TUNSTALL\", \"TUNSTALL\", \"TUNSTALL\", \"BRAND\", \"BRAND\", \"CARTE\", \"DAVID\", \"DAVID\", \"DOCUTY\", \"DOCUTY\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"DUFFY-TYLER\", \"ELM\", \"ELM\", \"FENSTER-PENNE\", \"GASBARRD\", \"GASBARRD\", \"GASBARRD\", \"GASBARRD\", \"GEHRING\", \"HACKER\", \"HACKER\", \"HALLORAW\", \"HELER\", \"HELER\", \"HELER\", \"HELER\", \"HOOPER\", \"HOOPER\", \"HOOPER\", \"HUBRICK\", \"HUBRICK\", \"PAINE-WELLS\", \"PAINE-WELLS\", \"PAINE-WELLS\", \"PAINE-WELLS\", \"PAINE-WELLS\", \"PENSMITH\", \"PENSMITH\", \"PENSMITH\", \"POLLOCK\", \"POLLOCK\", \"POLLOCK\", \"POLLOCK\", \"POLLOCK\", \"POLLOCK\", \"REEVER\", \"ROWAN\", \"ROWAN\", \"ROWAN\", \"ROWAN\", \"SANDERS\", \"SANDERS\", \"SCHWARTZ\", \"SCHWARTZ\", \"SMALL\", \"SMALL\", \"VELL\", \"ARCHBR\", \"ARCHBR\", \"BELTAN\", \"BELTAN\", \"BELTAN\", \"BELTAN\", \"BETRAN\", \"BETRAN\", \"BETRAN\", \"COGER\", \"COGER\", \"COGER\", \"DORSLY\", \"DORSLY\", \"DORSLY\", \"DORSLY\", \"DRENNON\", \"DRENNON\", \"DRENNON\", \"FLEET\", \"FLEET\", \"FLOWER\", \"FLOWER\", \"GALINDE\", \"GALINDE\", \"GALINDE\", \"GALINDE\", \"HILLEGASS\", \"HILLEGASS\", \"HILLEGASS\", \"HILLEGASS\", \"HILLEGASS\", \"HULLOWAY\", \"HULLOWAY\", \"JONES\", \"JONES\", \"JONES\", \"KABEZA\", \"KABEZA\", \"KABEZA\", \"KEARNAY\", \"KEARNAY\", \"KEARNAY\", \"MASLIN\", \"MITCHELL\", \"MITCHELL\", \"MONGUM\", \"MONGUM\", \"RAMOS\", \"RHOADS\", \"RHOADS\", \"RHOADS\", \"RHOADS\", \"RICHARDSONIII\", \"RICHARDSONIII\", \"RIVERA\", \"RIVERA\", \"RODRIGUEZ\", \"RODRIGUEZ\", \"SPINWATO\", \"STEWART\", \"STEWART\", \"STOPPY\", \"STOPPY\", \"STOPPY\", \"STOPPY\", \"STOPPY\", \"WILKS\", \"WILKS\", \"WILKS\", \"WILLIAM\", \"WILLIAM\", \"WRIGHT\", \"WRIGHT\", \"YATES\", \"YATES\"]',1,392,NULL,NULL),(7,'DSB_NAME',NULL,'[\"MARITZA\", \"MARIANNA\", \"LENARD\", \"SAMMY\", \"DOLORES\", \"JAMAR\", \"ROSSITA\", \"MAG\", \"ROZELLIN\", \"CATHERINE\", \"J\", \"DANYA\", \"DANTE\", \"DOMINQUE\", \"COHNIE\", \"SEKOU\", \"TREIRA\", \"THERESA\", \"MICHAEL\", \"A JASIA\", \"BRIANCA\", \"SAM\", \"THAU LYNN\", \"MILFORD\", \"FRANK\", \"SHAVAN\", \"ISAAE\", \"JEANELLE\", \"LOUIS\", \"WESLEY\", \"NADESHIA\", \"DANYELLE\", \"RUNEE\", \"RALPAL\", \"RROBERT\", \"GHOLAN\", \"JEFFREY\", \"JEFFREY\", \"DOUGLASS\", \"MARIE\", \"NATHANIAL\", \"TEMPEST\", \"RAYMON\", \"GEORGE\", \"KEYAN\", \"MICHEAL\", \"CASANDRA\", \"SANDERA\", \"BARBRA\", \"IRWIN\", \"ANDRE\", \"WILHEMENIA\", \"FREDRICK\", \"TONY\", \"DANIELLE\", \"DORATHEA\", \"LELA\", \"DWIGHT\", \"MARQUIS\", \"MABEL\", \"DARYL\", \"KEVEIN\", \"HERMAN\", \"IASHA\", \"ANDRE\", \"ROMAINE\", \"TAWYA\", \"PRINCETTE\", \"KEISHA\", \"CLAIRE\", \"XANTHA\", \"JEMOS\", \"ANN\", \"TAWANA\", \"GERALDINE\", \"DERRICK\", \"IRAN\", \"RAYMOND\", \"ALLICIA\", \"DAVONE\", \"LONORA\", \"RANDOLFF\", \"FREMAN\", \"WYANE\", \"THERESA\", \"THUY KIM\", \"BRANDON\", \"ALEXANDE\", \"ELIZBETH\", \"DONNY\", \"SALLY\", \"ALEXDER\", \"DELORES\", \"LATESHA\", \"KATHY\", \"RUFUS\", \"CHISTOPHER\", \"ZACNARY\", \"TRINA\", \"ANNA\", \"STEPHEN\", \"GLURIA\", \"GERARDO\", \"FRANCISO\", \"ERIK\", \"LUCILE\", \"DANYAE\", \"RAY\", \"JACKIE\", \"ANNA\", \"LED\", \"MICHAEL\", \"ROSEMARY\", \"KENDALL\", \"YUNAISY\", \"ANTOIENO\", \"JESSICIA\", \"MARNELA\", \"DERRYL\", \"BARRY\", \"ROSELIME\", \"RODERICK\", \"JOAN\", \"ADRIAN\", \"STEVEN\", \"MILISSA\", \"SARA\", \"LAURENCE\", \"EUGENIO\", \"MIKE\", \"WILIAMS\", \"ANGELA\", \"LASHIWN\", \"GOILLERMO\", \"MARCOS\", \"WINDY\", \"MICHELLE\", \"RENNE\", \"SARA\", \"JERARDO\", \"ALLEN\", \"MARY LOU\", \"MATHEW\", \"FLORY\", \"KERRY\", \"NILSAIVETTE\", \"SHERYL\", \"ELAINE\", \"MARYANN\", \"EPHNY\", \"DANNY\", \"ROBERTO\", \"MAJORIE\", \"SHARNETT\", \"HARRET\", \"KRISTY LEIGH\", \"DIANE MARIE\", \"ROSE MARIE\", \"EDVARDO\", \"SANDRA\", \"ANNE\", \"MICHELLE\", \"ROSETTE\", \"CORTE\", \"DENARIO\", \"EYVETTE\", \"ALISA\", \"JOAMES\", \"LENWOOD REV\", \"TRACI\", \"STEFAN\", \"PAMELA\", \"FLORRE\", \"JEFFREY\", \"WILSREVO\", \"SAMIAR\", \"SAMANTHA\", \"DOROTHEA\", \"DONNA MARIE\", \"PHYLLIS\", \"MICHAEL\", \"DAMOEN\", \"CATHRINE\", \"CHARCOTTE\", \"JEFFREY\", \"STEVEN\", \"MAURI\", \"XLONARA\", \"ANTHONY\", \"DIANE\", \"ARCHIBALD\", \"JACQUELIN\", \"ALEJANDRO\", \"IVAN\", \"ZIONAIRE\", \"ANTONIA\", \"JOSLYN\", \"MARCO\", \"DINWARDO\", \"BERNADINE\", \"TERRENCE\", \"ZAKAYA\", \"DAGOBERTO\", \"CORRINE\", \"CLARENCE\", \"BAN\", \"ERICA\", \"DELHAM\", \"GEORGE DR\", \"ANGLA\", \"JESSE\", \"GEOFFRY\", \"JANETT\", \"THE IMA\", \"DOMINIC\", \"JANIS\", \"SHIRLEY\", \"ORESTES\", \"LIVIA\", \"GREGORY\", \"AE\", \"VERCONIA\", \"DELORES\", \"JOHNNIE\", \"WILLY\", \"DOUGLASS\", \"NWAMAKA\", \"SUE\", \"TRUDY\", \"QUINTON\", \"STEPHINE\", \"REYANN\", \"PHILIP\", \"JAYANN\", \"HILDRED\", \"DOMINI\", \"SEPTIMIO\", \"KIMBERY\", \"ALASIA\", \"TRACIE LEE\", \"MELLISSA\", \"MIRIAM\", \"JONGE\", \"LYNN\", \"CHARES\", \"ISAREL\", \"MARYCAROLE\", \"SHEILA\", \"EVENS\", \"BRANDIE\", \"ANNE\", \"LOUIS\", \"GERARD\", \"KATHY\", \"NICOLE\", \"MARY ANNE\", \"HARRIET\", \"ALAN\", \"ANN\", \"JEANNE\", \"TRYONE\", \"HOANG\", \"DOUGLAS\", \"MICHELLE\", \"LAWRENCE\", \"DAVID\", \"BEN\", \"ALLICIA\", \"GERALDINE\", \"NATASHA\", \"GISUS\", \"ETHLEW\", \"JEANNE\", \"PABLO\", \"LE ANNE\", \"AFRIN\", \"JO ANNE\", \"BIANCA\", \"ZUNZELL\", \"CORNLIUS\", \"MARIEA\", \"DIXIE\", \"DORIAN\", \"TEAIRA\", \"ANGELEAN\", \"ARISTIDIS\", \"CARLO\", \"ROSETTA\", \"CHARLS\", \"JANICE\", \"SIFRIDO\", \"ABEL\", \"WALDO\", \"IGANACIO\", \"BARBRA\", \"JEFFERY\", \"THRESSA\", \"ANN\", \"ANDREW\", \"JAMAL\", \"DAVON\", \"SHAUN\", \"MIRIAN\", \"LEHA\", \"KENNETH\", \"CRISTOPHER\", \"ERNEST\", \"CATHERINE\", \"ALFREDA\", \"NICHOLAS\", \"KATHY\", \"JOAN\", \"PATRICIA\", \"JEFFERY\", \"ENGER\", \"GLORIANE\", \"MACK\", \"J\", \"ELAM\", \"WYLIE\", \"GISELLA\", \"RUTHANN\", \"LAWRENE\", \"JEFFREY\", \"SOLITA\", \"EDDIE\", \"EARL\", \"ROSSITA\", \"GARY\", \"MELLISA\", \"DEBNA\", \"EDNA\", \"ISAAC\", \"EARNEST\", \"THERSA\", \"JOHNNIE\", \"ANTOINETTE\", \"STANLEY\", \"CORNELIA\", \"KENNETH\", \"ENZNZELLE\", \"LACHELLE\", \"CHATYRA\", \"JOHNNIE\", \"JENIA\", \"HAILIE\", \"ROSE\", \"JONIE\", \"SCOTT\", \"JENNIFER\", \"PRESPEU\", \"NAOMI\", \"LUC\", \"RONNY\", \"KEN\", \"SHAWNA\", \"SHAMIKA\", \"ASHLEY\", \"SHERMICE\", \"ALMA\", \"GEROME\", \"DORETTA\", \"ROBERT\", \"RAKIA\", \"SONYA\", \"JEFFREY\", \"HENRIETTA\", \"JANIE\", \"JEANNE\", \"EMMIT\", \"TOMICA\", \"JOHN\", \"STEWART\", \"JOSHUA\", \"RUBY\", \"SILYIA\", \"FRED\", \"SHANTELL\", \"JEFFREY\", \"FRANK\", \"ELOUISE\", \"QUIYINA\", \"ALIE\", \"BENEDICT\", \"STEVEN\", \"HARRIET\", \"CHARLEY\", \"SHERRY\", \"BRYAN\", \"MAXINE\", \"CHANSE\", \"ALFREDICA\"]',1,392,NULL,NULL),(8,'DSB_LASTCODE',NULL,'[\"A\", \"B\", \"A\", \"R\", \"R\", \"C\", \"L\", \"R\", \"N\", \"L\", \"E\", \"L\", \"E\", \"S\", \"E\", \"L\", \"\", \"G\", \"A\", \"\", \"G\", \"J\", \"R\", \"J\", \"K\", \"M\", \"\", \"\", \"W\", \"M\", \"A\", \"L\", \"\", \"T\", \"T\", \"W\", \"W\", \"W\", \"D\", \"T\", \"N\", \"Z\", \"\", \"L\", \"D\", \"\", \"C\", \"Y\", \"M\", \"\", \"\", \"\", \"W\", \"M\", \"S\", \"K\", \"M\", \"B\", \"E\", \"\", \"A\", \"\", \"M\", \"C\", \"G\", \"O\", \"O\", \"D\", \"O\", \"J\", \"\", \"V\", \"N\", \"S\", \"A\", \"E\", \"R\", \"L\", \"J\", \"B\", \"S\", \"\", \"R\", \"H\", \"\", \"G\", \"R\", \"R\", \"L\", \"\", \"\", \"J\", \"A\", \"D\", \"\", \"D\", \"D\", \"\", \"\", \"\", \"\", \"\", \"F\", \"D\", \"D\", \"\", \"\", \"\", \"M\", \"M\", \"E\", \"\", \"\", \"\", \"L\", \"E\", \"A\", \"E\", \"B\", \"J\", \"D\", \"C\", \"\", \"L\", \"D\", \"L\", \"L\", \"\", \"E\", \"D\", \"A\", \"\", \"Y\", \"E\", \"M\", \"E\", \"N\", \"M\", \"N\", \"D\", \"R\", \"\", \"\", \"D\", \"D\", \"D\", \"\", \"A\", \"\", \"B\", \"\", \"R\", \"A\", \"R\", \"\", \"L\", \"\", \"\", \"A\", \"C\", \"A\", \"M\", \"A\", \"D\", \"E\", \"D\", \"Y\", \"\", \"\", \"R\", \"\", \"T\", \"\", \"S\", \"\", \"I\", \"H\", \"T\", \"E\", \"L\", \"T\", \"T\", \"A\", \"E\", \"P\", \"I\", \"P\", \"E\", \"B\", \"M\", \"\", \"\", \"A\", \"E\", \"T\", \"B\", \"V\", \"\", \"A\", \"\", \"L\", \"C\", \"\", \"\", \"\", \"\", \"\", \"\", \"L\", \"E\", \"\", \"M\", \"M\", \"V\", \"B\", \"M\", \"\", \"S\", \"E\", \"S\", \"A\", \"\", \"\", \"\", \"L\", \"F\", \"M\", \"L\", \"A\", \"\", \"\", \"J\", \"\", \"L\", \"E\", \"A\", \"E\", \"L\", \"M\", \"D\", \"A\", \"S\", \"L\", \"C\", \"\", \"\", \"\", \"\", \"\", \"D\", \"G\", \"A\", \"A\", \"M\", \"\", \"C\", \"J\", \"J\", \"D\", \"\", \"M\", \"\", \"S\", \"C\", \"A\", \"F\", \"M\", \"\", \"L\", \"\", \"A\", \"J\", \"L\", \"V\", \"G\", \"K\", \"M\", \"A\", \"M\", \"M\", \"A\", \"J\", \"J\", \"J\", \"M\", \"C\", \"C\", \"B\", \"P\", \"\", \"J\", \"\", \"J\", \"J\", \"L\", \"J\", \"A\", \"A\", \"\", \"F\", \"S\", \"P\", \"J\", \"A\", \"A\", \"J\", \"A\", \"\", \"L\", \"G\", \"L\", \"F\", \"E\", \"P\", \"B\", \"M\", \"C\", \"A\", \"A\", \"A\", \"M\", \"M\", \"\", \"\", \"\", \"M\", \"M\", \"J\", \"S\", \"J\", \"M\", \"L\", \"F\", \"R\", \"A\", \"\", \"\", \"J\", \"M\", \"E\", \"E\", \"G\", \"M\", \"E\", \"\", \"E\", \"C\", \"E\", \"C\", \"T\", \"J\", \"K\", \"M\", \"\", \"R\", \"\", \"E\", \"\", \"\", \"C\", \"J\", \"M\", \"J\", \"\", \"K\", \"C\", \"\", \"M\", \"\", \"E\", \"R\", \"U\", \"K\", \"V\", \"E\", \"M\", \"A\", \"A\", \"F\", \"E\", \"F\", \"B\", \"A\", \"W\", \"M\", \"L\", \"A\", \"V\", \"\", \"H\", \"E\", \"S\"]',1,392,NULL,NULL),(10,'THRESHOLD UNMATCHING',NULL,'[\"1\"]',2,1,NULL,'0.6');
/*!40000 ALTER TABLE `sx_workset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'is2'
--
/*!50003 DROP PROCEDURE IF EXISTS `pippop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pippop`()
BEGIN
 DECLARE l_last_row INT DEFAULT 0;
        DECLARE a  varchar(100);
         DECLARE b  varchar(100);
    DECLARE cur1 CURSOR FOR  
                 SELECT da_SURNAME,da_NAME FROM
  ( SELECT  t.idx, t.v as da_SURNAME  FROM  SX_WORKSET ss, 
  json_table(CONVERT(  ss.valori USING utf8), '$.valori[*]'  columns ( idx FOR ORDINALITY, v varchar(100) path '$.v') ) t
  where ss.id=40    ) subqvn1,
  ( SELECT    t.idx, t.v as da_NAME   FROM  SX_WORKSET ss,  json_table(CONVERT(  ss.valori USING utf8), '$.valori[*]' 
  columns ( idx FOR ORDINALITY, v varchar(100) path '$.v') ) t   where  ss.id=44  ) subqvn2
  where  subqvn1.idx=subqvn2.idx ;
 

    OPEN cur1;
    read_loop: LOOP
      FETCH cur1 INTO a, b;
         select a,b;
 
    END LOOP;

    CLOSE cur1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-16 10:53:56
