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
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `batch_job_instance` (`JOB_INSTANCE_ID`) ON DELETE CASCADE
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
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE CASCADE
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
  CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE CASCADE
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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_job_execution_seq` (
  `ID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_job_execution_seq`
--

LOCK TABLES `batch_job_execution_seq` WRITE;
/*!40000 ALTER TABLE `batch_job_execution_seq` DISABLE KEYS */;
INSERT INTO `batch_job_execution_seq` VALUES (457);
/*!40000 ALTER TABLE `batch_job_execution_seq` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_job_seq` (
  `ID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_job_seq`
--

LOCK TABLES `batch_job_seq` WRITE;
/*!40000 ALTER TABLE `batch_job_seq` DISABLE KEYS */;
INSERT INTO `batch_job_seq` VALUES (457);
/*!40000 ALTER TABLE `batch_job_seq` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE CASCADE
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
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `batch_step_execution` (`STEP_EXECUTION_ID`) ON DELETE CASCADE
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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_step_execution_seq` (
  `ID` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_step_execution_seq`
--

LOCK TABLES `batch_step_execution_seq` WRITE;
/*!40000 ALTER TABLE `batch_step_execution_seq` DISABLE KEYS */;
INSERT INTO `batch_step_execution_seq` VALUES (457);
/*!40000 ALTER TABLE `batch_step_execution_seq` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `sx_app_role` VALUES (0,'SKIP','N','VARIABILE NON UTILIZZATA',100,1,1),(1,'IDENTIFICATIVO','I','CHIAVE OSSERVAZIONE',100,1,1),(2,'TARGET','Y','VARIABILE DI OGGETTO DI ANALISI',100,3,1),(3,'COVARIATA','X','VARIABILE INDIPENDENTE',100,4,1),(4,'PREDIZIONE','P','VARIABILE DI PREDIZIONE',100,5,1),(5,'OUTLIER','O','FLAG OUTLIER',100,6,1),(6,'PESO','W','PESO CAMPIONARIO',100,7,1),(7,'ERRORE','E','ERRORE INFLUENTE',100,10,1),(8,'RANKING','R','INFLUENCE RANKING',100,11,1),(9,'OUTPUT','T','VARIABILE DI OUTPUT',100,20,1),(10,'STRATO','S','PARTIZIONAMENTO DEL DATASET',100,2,1),(11,'PARAMETRI','Z','PARAMETRI DI INPUT',100,997,2),(12,'MODELLO','M','MODELLO DATI',100,998,2),(13,'SCORE','F','INFLUENCE SCORE',100,12,1),(14,'INFO','G','PARAMETRI OUT - INFO RIEPILOGO',100,999,1),(100,'SKIP','N','VARIABILE NON UTILIZZATA',200,100,1),(102,'CHIAVE A','K1','CHIAVE DATASET A',200,3,1),(103,'CHIAVE B','K2','CHIAVE DATASET B',200,4,1),(104,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',200,5,1),(105,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',200,6,1),(108,'RANKING','M','INFLUENCE RANKING',200,11,2),(110,'STRATO','S','PARTIZIONAMENTO DEL DATASET',200,2,1),(111,'RESULT','R','RISULTATO PRODOTTO CARTESIANO',200,10,2),(115,'BLOCKING','B','SLICING DEL DATASET',200,3,1),(150,'SKIP','N','VARIABILE NON UTILIZZATA',250,100,1),(152,'KEY A','K1','CHIAVE DATASET A',250,3,1),(153,'KEY B','K2','CHIAVE DATASET B',250,4,1),(154,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',250,5,1),(155,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',250,6,1),(158,'RANKING','M','INFLUENCE RANKING',250,11,2),(160,'STRATA','S','PARTIZIONAMENTO DEL DATASET',250,2,1),(161,'CONTENGENCY TABLE','CT','CONTENGENCY TABLE',250,1,1),(165,'BLOCKING','B','SLICING DEL DATASET',250,3,1),(166,'MATCHING VARIABLES','X','VARIABLI DI MATCHING',250,1,2),(167,'FELLEGI-SUNTER','FS','FELLEGI-SUNTER',200,2,1),(168,'MATCHING TABLE','MT','MATCHING TABLE',250,3,1),(169,'THRESHOLD MATCHING','TH','THRESHOLD MATCHING',250,2,2),(170,'THRESHOLD UNMATCHING','TU','THRESHOLD UNMATCHING',250,4,2),(171,'POSSIBLE MATCHING TABLE','PM','POSSIBLE MATCHING TABLE',250,5,1),(172,'RESIDUAL A','RA','RESIDUAL DATASET  A',250,6,1),(173,'RESIDUAL B','RB','RESIDUAL DATASET  B',250,7,1),(174,'DATA','MD','DATA',300,1,1),(175,'RULESET','RS','RULESET',300,2,4);
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
INSERT INTO `sx_app_service` VALUES (100,'SeleMix','Individuazione valori anomali tramite misture','R','SS_selemix.r',100),(200,'Relais','Record Linkage','R','relais/relais.R',200),(250,'RelaisJ','Record Linkage Java','JAVA','SS_relais.jar',250),(300,'Validate','Validazione e gestione delle regole','R','validate/validate.R',300);
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
INSERT INTO `sx_bfunc_bprocess` VALUES (1,1),(1,2),(1,5),(3,3);
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
INSERT INTO `sx_bprocess_bstep` VALUES (4,4),(6,70),(6,71),(6,72),(70,70),(71,71),(72,72);
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
  `NOME` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `DESCR` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ETICHETTA` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
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
INSERT INTO `sx_business_process` VALUES (1,'Record Linkage Probabilistico','Record Linkage Probabilistico','RLP',NULL,NULL,1),(2,'Record Linkage Deterministico','Record Linkage Deterministico','RLD',NULL,NULL,2),(3,'Validate R','Validate R','Validate R',NULL,NULL,1),(4,'Validate R Van de','Validate R Van de','Validate R vdf',NULL,3,2),(5,'Record Linkage Probabilistico Multi-step ','Record Linkage Probabilistico multi-step','RLPMS',NULL,NULL,NULL),(6,'Record Linkage Probabilistico Multi-step ','Record Linkage Probabilistico multi-step','RLPMS1',NULL,5,NULL),(70,'Cont Table','Calcolo tabella di contingenza','Cross Table',NULL,1,1),(71,'FellegiSunter','FellegiSunter','FellegiSunter',NULL,1,2),(72,'Matching Table','Result Matching table','MATCHING TABLE',NULL,1,3);
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
INSERT INTO `sx_business_step` VALUES (4,'VALIDATE','Validate dataset with ruleset',NULL),(70,'CONTINGENCY_TABLE','Create contingency table',NULL),(71,'FELLEGI SUNTER','Select matching variables',NULL),(72,'MATCHING TABLE','Create result matching table',NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_colonna`
--

LOCK TABLES `sx_dataset_colonna` WRITE;
/*!40000 ALTER TABLE `sx_dataset_colonna` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_file`
--

LOCK TABLES `sx_dataset_file` WRITE;
/*!40000 ALTER TABLE `sx_dataset_file` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_elaborazione`
--

LOCK TABLES `sx_elaborazione` WRITE;
/*!40000 ALTER TABLE `sx_elaborazione` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_log`
--

LOCK TABLES `sx_log` WRITE;
/*!40000 ALTER TABLE `sx_log` DISABLE KEYS */;
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
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014188` (`ID`),
  UNIQUE KEY `code_UNIQUE` (`code`,`RULESET`)
) ENGINE=InnoDB AUTO_INCREMENT=1173 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_rule`
--

LOCK TABLES `sx_rule` WRITE;
/*!40000 ALTER TABLE `sx_rule` DISABLE KEYS */;
INSERT INTO `sx_rule` VALUES (841,NULL,'sss',NULL,NULL,0,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,18,'7',NULL,NULL),(842,NULL,NULL,NULL,NULL,0,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,18,'7',NULL,NULL),(843,NULL,NULL,NULL,NULL,0,1,'sau1 <= sat1',NULL,NULL,18,'7',NULL,NULL),(844,NULL,NULL,NULL,NULL,0,1,'sau2 <= sat2',NULL,NULL,18,'7',NULL,NULL),(845,NULL,NULL,NULL,NULL,0,1,'sau3 <= sat3',NULL,NULL,18,'7',NULL,NULL),(846,NULL,NULL,NULL,NULL,0,1,'sau4 <= sat4',NULL,NULL,18,'7',NULL,NULL),(847,NULL,NULL,NULL,NULL,0,1,'sau5 <= sat5',NULL,NULL,18,'7',NULL,NULL),(848,NULL,NULL,NULL,NULL,0,1,'sau6 <= sat6',NULL,NULL,18,'7',NULL,NULL),(849,NULL,NULL,NULL,NULL,0,1,'sau7 <= sat7',NULL,NULL,18,'7',NULL,NULL),(850,NULL,NULL,NULL,NULL,0,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,19,'7',NULL,NULL),(851,NULL,NULL,NULL,NULL,0,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,19,'7',NULL,NULL),(852,NULL,NULL,NULL,NULL,0,1,'sau1 <= sat1',NULL,NULL,19,'7',NULL,NULL),(853,NULL,NULL,NULL,NULL,0,1,'sau2 <= sat2',NULL,NULL,19,'7',NULL,NULL),(854,NULL,NULL,NULL,NULL,0,1,'sau3 <= sat3',NULL,NULL,19,'7',NULL,NULL),(855,NULL,NULL,NULL,NULL,0,1,'sau4 <= sat4',NULL,NULL,19,'7',NULL,NULL),(856,NULL,NULL,NULL,NULL,0,1,'sau5 <= sat5',NULL,NULL,19,'7',NULL,NULL),(857,NULL,NULL,NULL,NULL,0,1,'sau6 <= sat6',NULL,NULL,19,'7',NULL,NULL),(858,NULL,NULL,NULL,NULL,0,1,'sau7 <= sat7',NULL,NULL,19,'7',NULL,NULL),(859,NULL,NULL,NULL,NULL,0,1,'c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55 == c56',NULL,NULL,19,'7',NULL,NULL),(860,NULL,NULL,NULL,NULL,0,1,'s57 <= c57',NULL,NULL,19,'7',NULL,NULL),(861,NULL,NULL,NULL,NULL,0,1,'s58 <= c58',NULL,NULL,19,'7',NULL,NULL),(862,NULL,NULL,NULL,NULL,0,1,'s59 <= c59',NULL,NULL,19,'7',NULL,NULL),(863,NULL,NULL,NULL,NULL,0,1,'s61 <= c61',NULL,NULL,19,'7',NULL,NULL),(864,NULL,NULL,NULL,NULL,0,1,'s62 <= c62',NULL,NULL,19,'7',NULL,NULL),(865,NULL,NULL,NULL,NULL,0,1,'s63 <= c63',NULL,NULL,19,'7',NULL,NULL),(866,NULL,NULL,NULL,NULL,0,1,'s64 <= c64',NULL,NULL,19,'7',NULL,NULL),(867,NULL,NULL,NULL,NULL,0,1,'s65 <= c65',NULL,NULL,19,'7',NULL,NULL),(868,NULL,NULL,NULL,NULL,0,1,'s66 <= c66',NULL,NULL,19,'7',NULL,NULL),(869,NULL,NULL,NULL,NULL,0,1,'s67 <= c67',NULL,NULL,19,'7',NULL,NULL),(870,NULL,NULL,NULL,NULL,0,1,'s68 <= c68',NULL,NULL,19,'7',NULL,NULL),(871,NULL,NULL,NULL,NULL,0,1,'s69 <= c69',NULL,NULL,19,'7',NULL,NULL),(872,NULL,NULL,NULL,NULL,0,1,'s70 <= c70',NULL,NULL,19,'7',NULL,NULL),(873,NULL,NULL,NULL,NULL,0,1,'s71 <= c71',NULL,NULL,19,'7',NULL,NULL),(874,NULL,NULL,NULL,NULL,0,1,'s72 <= c72',NULL,NULL,19,'7',NULL,NULL),(875,NULL,NULL,NULL,NULL,0,1,'s73 <= c73',NULL,NULL,19,'7',NULL,NULL),(876,NULL,NULL,NULL,NULL,0,1,'s74 <= c74',NULL,NULL,19,'7',NULL,NULL),(877,NULL,NULL,NULL,NULL,0,1,'s75 <= c75',NULL,NULL,19,'7',NULL,NULL),(878,NULL,NULL,NULL,NULL,0,1,'s76 <= c76',NULL,NULL,19,'7',NULL,NULL),(879,NULL,NULL,NULL,NULL,0,1,'s77 <= c77',NULL,NULL,19,'7',NULL,NULL),(880,NULL,NULL,NULL,NULL,0,1,'s78 <= c78',NULL,NULL,19,'7',NULL,NULL),(881,NULL,NULL,NULL,NULL,0,1,'s79 <= c79',NULL,NULL,19,'7',NULL,NULL),(882,NULL,NULL,NULL,NULL,0,1,'s80 <= c80',NULL,NULL,19,'7',NULL,NULL),(883,NULL,NULL,NULL,NULL,0,1,'s81 <= c81',NULL,NULL,19,'7',NULL,NULL),(884,NULL,NULL,NULL,NULL,0,1,'s82 <= c82',NULL,NULL,19,'7',NULL,NULL),(885,NULL,NULL,NULL,NULL,0,1,'s86 <= c86',NULL,NULL,19,'7',NULL,NULL),(886,NULL,NULL,NULL,NULL,0,1,'s87 <= c87',NULL,NULL,19,'7',NULL,NULL),(887,NULL,NULL,NULL,NULL,0,1,'c57+c58+c59+c60+c61+c62+c63+c64+c65+c66+c67+c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82+c83+c84+c85+c86+c87 == c88',NULL,NULL,19,'7',NULL,NULL),(888,NULL,NULL,NULL,NULL,0,1,'s57+s58+s59+s61+s62+s63+s64+s65+s66+s67+s68+s69+s70+s71+s72+s73+s74+s75+s76+s77+s78+s79+s80+s81+s82+s86+s87 == s88',NULL,NULL,19,'7',NULL,NULL),(889,NULL,NULL,NULL,NULL,0,1,'c90+c91+c92 == c93',NULL,NULL,19,'7',NULL,NULL),(890,NULL,NULL,NULL,NULL,0,1,'c95+c96 == c97',NULL,NULL,19,'7',NULL,NULL),(891,NULL,NULL,NULL,NULL,0,1,'c106+c107+c108 == c98',NULL,NULL,19,'7',NULL,NULL),(892,NULL,NULL,NULL,NULL,0,1,'c56+c88+c89+c93 == c94',NULL,NULL,19,'7',NULL,NULL),(893,NULL,NULL,NULL,NULL,0,1,'c94+c97+c98+c99+c100 == c101',NULL,NULL,19,'7',NULL,NULL),(894,NULL,NULL,NULL,NULL,0,1,'sau8 == c94',NULL,NULL,19,'7',NULL,NULL),(895,NULL,NULL,NULL,NULL,0,1,'sat8 == c101',NULL,NULL,19,'7',NULL,NULL),(896,NULL,NULL,NULL,NULL,0,1,'c110 <= c100*100',NULL,NULL,19,'7',NULL,NULL),(897,NULL,NULL,NULL,NULL,0,1,'c111 <= c101*100',NULL,NULL,19,'7',NULL,NULL),(898,NULL,NULL,NULL,NULL,0,1,'for1+for2+for3 == for4',NULL,NULL,19,'7',NULL,NULL),(899,NULL,NULL,NULL,NULL,0,1,'for4 == c98',NULL,NULL,19,'7',NULL,NULL),(900,NULL,NULL,NULL,NULL,0,1,'for5+for8+for11 <= for1',NULL,NULL,19,'7',NULL,NULL),(901,NULL,NULL,NULL,NULL,0,1,'for6+for9+for12 <= for2',NULL,NULL,19,'7',NULL,NULL),(902,NULL,NULL,NULL,NULL,0,1,'for7+for10+for13 <= for3',NULL,NULL,19,'7',NULL,NULL),(903,NULL,NULL,NULL,NULL,0,1,'ir0 <= c94+c97',NULL,NULL,19,'7',NULL,NULL),(904,NULL,NULL,NULL,NULL,0,1,'ir16 <= ir0',NULL,NULL,19,'7',NULL,NULL),(905,NULL,NULL,NULL,NULL,0,1,'c89 <= 30',NULL,NULL,19,'7',NULL,NULL),(906,NULL,NULL,NULL,NULL,0,1,'ir16>= 0.0001*ir20+0.0001*ir21+0.0001*ir22+0.0001*ir23+0.0001*ir24+0.0001*ir25',NULL,NULL,19,'7',NULL,NULL),(907,NULL,NULL,NULL,NULL,0,1,'ir20 <= ir16',NULL,NULL,19,'7',NULL,NULL),(908,NULL,NULL,NULL,NULL,0,1,'ir21 <= ir16',NULL,NULL,19,'7',NULL,NULL),(909,NULL,NULL,NULL,NULL,0,1,'ir22 <= ir16',NULL,NULL,19,'7',NULL,NULL),(910,NULL,NULL,NULL,NULL,0,1,'ir23 <= ir16',NULL,NULL,19,'7',NULL,NULL),(911,NULL,NULL,NULL,NULL,0,1,'ir25 <= ir16',NULL,NULL,19,'7',NULL,NULL),(912,NULL,NULL,NULL,NULL,0,1,'ir24  <=  ir23',NULL,NULL,19,'7',NULL,NULL),(913,NULL,NULL,NULL,NULL,0,1,'ir20 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,19,'7',NULL,NULL),(914,NULL,NULL,NULL,NULL,0,1,'ir21 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,19,'7',NULL,NULL),(915,NULL,NULL,NULL,NULL,0,1,'ir22 <= c94+c97-c38-c40-c41-c43-c44-c89                   ',NULL,NULL,19,'7',NULL,NULL),(916,NULL,NULL,NULL,NULL,0,1,'ir23 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,19,'7',NULL,NULL),(917,NULL,NULL,NULL,NULL,0,1,'ir25 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,19,'7',NULL,NULL),(918,NULL,NULL,NULL,NULL,0,1,'colt1 <= c94',NULL,NULL,19,'7',NULL,NULL),(919,NULL,NULL,NULL,NULL,0,1,'colt2 <= c94',NULL,NULL,19,'7',NULL,NULL),(920,NULL,NULL,NULL,NULL,0,1,'colt3 <= c94',NULL,NULL,19,'7',NULL,NULL),(921,NULL,NULL,NULL,NULL,0,1,'colt4 <= c56+c88',NULL,NULL,19,'7',NULL,NULL),(922,NULL,NULL,NULL,NULL,0,1,'colt5 <= c93',NULL,NULL,19,'7',NULL,NULL),(923,NULL,NULL,NULL,NULL,0,1,'colt6 <= c97+c98',NULL,NULL,19,'7',NULL,NULL),(924,NULL,NULL,NULL,NULL,0,1,'colt7 <= c55',NULL,NULL,19,'7',NULL,NULL),(925,NULL,NULL,NULL,NULL,0,1,'colt8 <= c99+c100',NULL,NULL,19,'7',NULL,NULL),(926,NULL,NULL,NULL,NULL,0,1,'colt9 <= c101',NULL,NULL,19,'7',NULL,NULL),(927,NULL,NULL,NULL,NULL,0,1,'colt9 == colt4+colt5+colt6+colt7+colt8',NULL,NULL,19,'7',NULL,NULL),(928,NULL,NULL,NULL,NULL,0,1,'colt10 <= c101',NULL,NULL,19,'7',NULL,NULL),(929,NULL,NULL,NULL,NULL,0,1,'sup1 <= c94+c97',NULL,NULL,19,'7',NULL,NULL),(930,NULL,NULL,NULL,NULL,0,1,'sup2 <= c94+c97',NULL,NULL,19,'7',NULL,NULL),(931,NULL,NULL,NULL,NULL,0,1,'sup3 <= c94+c97',NULL,NULL,19,'7',NULL,NULL),(932,NULL,NULL,NULL,NULL,0,1,'sup4 <= c94+c97',NULL,NULL,19,'7',NULL,NULL),(933,NULL,NULL,NULL,NULL,0,1,'sup5 <= c94+c97',NULL,NULL,19,'7',NULL,NULL),(934,NULL,NULL,NULL,NULL,0,1,'sup6 <= c94+c97',NULL,NULL,19,'7',NULL,NULL),(935,NULL,NULL,NULL,NULL,0,1,'sup7 <= c94+c97',NULL,NULL,19,'7',NULL,NULL),(936,NULL,NULL,NULL,NULL,0,1,'sup8 <= c94+c97',NULL,NULL,19,'7',NULL,NULL),(937,NULL,NULL,NULL,NULL,0,1,'sup9 <= c98',NULL,NULL,19,'7',NULL,NULL),(938,NULL,NULL,NULL,NULL,0,1,'sup10 <= c98',NULL,NULL,19,'7',NULL,NULL),(939,NULL,NULL,NULL,NULL,0,1,'sup11 <= c98',NULL,NULL,19,'7',NULL,NULL),(940,NULL,NULL,NULL,NULL,0,1,'sup12 <= c98',NULL,NULL,19,'7',NULL,NULL),(941,NULL,NULL,NULL,NULL,0,1,'sup13 <= c98',NULL,NULL,19,'7',NULL,NULL),(942,NULL,NULL,NULL,NULL,0,1,'sup14 <= c98',NULL,NULL,19,'7',NULL,NULL),(943,NULL,NULL,NULL,NULL,0,1,'bio1 <= c1+c2+c3+c4+c5+c6+c7+c8+c9+c10',NULL,NULL,19,'7',NULL,NULL),(944,NULL,NULL,NULL,NULL,0,1,'bio2 <= c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41',NULL,NULL,19,'7',NULL,NULL),(945,NULL,NULL,NULL,NULL,0,1,'bio3 <= c57+c58+c59+c60',NULL,NULL,19,'7',NULL,NULL),(946,NULL,NULL,NULL,NULL,0,1,'bio4 <= c61+c62',NULL,NULL,19,'7',NULL,NULL),(947,NULL,NULL,NULL,NULL,0,1,'bio5 <= c63+c64+c65+c66+c67',NULL,NULL,19,'7',NULL,NULL),(948,NULL,NULL,NULL,NULL,0,1,'bio6 <= c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82',NULL,NULL,19,'7',NULL,NULL),(949,NULL,NULL,NULL,NULL,0,1,'bio7 <= c93',NULL,NULL,19,'7',NULL,NULL),(950,NULL,NULL,NULL,NULL,0,1,'bio8 <= c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55+c83+c84+c85+c86+c87+c89 ',NULL,NULL,19,'7',NULL,NULL),(951,NULL,NULL,NULL,NULL,0,1,'bio9 == bio1+bio2+bio3+bio4+bio5+bio6+bio7+bio8',NULL,NULL,19,'7',NULL,NULL),(952,NULL,NULL,NULL,NULL,0,1,'bio10 <= c94',NULL,NULL,19,'7',NULL,NULL),(953,NULL,NULL,NULL,NULL,0,1,'pra1 <= c94',NULL,NULL,19,'7',NULL,NULL),(954,NULL,NULL,NULL,NULL,0,1,'pra2 <= c94',NULL,NULL,19,'7',NULL,NULL),(955,NULL,NULL,NULL,NULL,0,1,'pra3 <= c94',NULL,NULL,19,'7',NULL,NULL),(956,NULL,NULL,NULL,NULL,0,1,'pra4 <= c94',NULL,NULL,19,'7',NULL,NULL),(957,NULL,NULL,NULL,NULL,0,1,'pra5 <= c94',NULL,NULL,19,'7',NULL,NULL),(958,NULL,NULL,NULL,NULL,0,1,'pra6 <= c94 ',NULL,NULL,19,'7',NULL,NULL),(978,NULL,NULL,NULL,NULL,1,1,'TFR > 0',NULL,NULL,23,'6',NULL,NULL),(980,NULL,NULL,NULL,NULL,0,1,'contr > 0',NULL,NULL,23,'6',NULL,NULL),(981,NULL,NULL,NULL,NULL,0,1,'infmort > 0',NULL,NULL,23,'6',NULL,NULL),(982,NULL,NULL,NULL,NULL,0,1,'TFR <= 0.048 * GDP',NULL,NULL,23,'6',NULL,NULL),(983,NULL,NULL,NULL,NULL,0,1,'contr <= 0.195 * GDP',NULL,NULL,23,'6',NULL,NULL),(984,NULL,NULL,NULL,NULL,0,1,'infmort <= 0.716 * GDP',NULL,NULL,23,'6',NULL,NULL),(985,NULL,'TFR1',NULL,NULL,0,1,'TFR<0',NULL,NULL,23,'1',NULL,NULL),(996,NULL,NULL,NULL,NULL,0,1,'TFR > 0',NULL,NULL,2,'7',NULL,NULL),(997,NULL,NULL,NULL,NULL,0,1,'GDP > 0',NULL,NULL,2,'7',NULL,NULL),(998,NULL,NULL,NULL,NULL,0,1,'contr > 0',NULL,NULL,2,'7',NULL,NULL),(999,NULL,NULL,NULL,NULL,0,1,'infmort > 0',NULL,NULL,2,'7',NULL,NULL),(1000,NULL,NULL,NULL,NULL,0,1,'TFR <= 0.048 * GDP',NULL,NULL,2,'7',NULL,NULL),(1001,NULL,NULL,NULL,NULL,0,1,'contr <= 0.195 * GDP',NULL,NULL,2,'7',NULL,NULL),(1002,NULL,NULL,NULL,NULL,0,1,'infmort <= 0.716 * GDP',NULL,NULL,2,'7',NULL,NULL),(1039,NULL,NULL,NULL,NULL,NULL,1,'region %in% c(\'Africa\',\'Americas\',\'Asia\',\'Europe\',\'Oceania\')',NULL,NULL,5,'7',NULL,'R1'),(1040,NULL,NULL,NULL,NULL,NULL,1,'TFR > 0',NULL,NULL,5,'7',NULL,'R2'),(1041,NULL,NULL,NULL,NULL,NULL,1,'GDP > 0',NULL,NULL,5,'7',NULL,'R3'),(1042,NULL,NULL,NULL,NULL,NULL,1,'contr > 0',NULL,NULL,5,'7',NULL,'R4'),(1043,NULL,NULL,NULL,NULL,NULL,1,'infmort > 0',NULL,NULL,5,'7',NULL,'R5'),(1044,NULL,NULL,NULL,NULL,NULL,1,'TFR <= 0.048 * GDP',NULL,NULL,5,'7',NULL,'R6'),(1045,NULL,NULL,NULL,NULL,NULL,1,'contr <= 0.195 * GDP',NULL,NULL,5,'7',NULL,'R7'),(1046,NULL,NULL,NULL,NULL,NULL,1,'infmort <= 0.716 * GDP',NULL,NULL,5,'7',NULL,'R8'),(1063,NULL,'sss',NULL,NULL,NULL,1,'pipohd',NULL,NULL,2,'7',NULL,'R8'),(1064,NULL,'',NULL,NULL,NULL,1,'',NULL,NULL,2,'1',NULL,'R9'),(1065,NULL,'',NULL,NULL,NULL,1,'',NULL,NULL,2,'1',NULL,'R10'),(1066,NULL,'',NULL,NULL,NULL,1,'',NULL,NULL,2,'1',NULL,'R11'),(1067,NULL,'',NULL,NULL,NULL,1,'',NULL,NULL,2,'1',NULL,'R12'),(1068,NULL,'',NULL,NULL,NULL,1,'sdfgsd',NULL,NULL,2,'1',NULL,'R13'),(1069,NULL,'',NULL,NULL,NULL,1,'dgdg',NULL,NULL,2,'1',NULL,'R14'),(1070,NULL,'',NULL,NULL,NULL,1,'rty',NULL,NULL,2,'1',NULL,'R15'),(1071,NULL,'',NULL,NULL,0,1,'region %in% c(\'Africa\',\'Americas\',\'Asia\',\'Europe\',\'Oceania\')',NULL,NULL,1,'7',NULL,'R1'),(1072,NULL,'',NULL,NULL,0,1,'TFR > 0',NULL,NULL,1,'7',NULL,'R2'),(1073,NULL,NULL,NULL,NULL,0,1,'GDP > 0',NULL,NULL,1,'7',NULL,'R3'),(1074,NULL,NULL,NULL,NULL,0,1,'contr > 0',NULL,NULL,1,'7',NULL,'R4'),(1075,NULL,NULL,NULL,NULL,0,1,'infmort > 0',NULL,NULL,1,'7',NULL,'R5'),(1076,NULL,NULL,NULL,NULL,0,1,'TFR <= 0.048 * GDP',NULL,NULL,1,'7',NULL,'R6'),(1077,NULL,NULL,NULL,NULL,0,1,'contr <= 0.195 * GDP',NULL,NULL,1,'7',NULL,'R7'),(1078,NULL,NULL,NULL,NULL,0,1,'infmort <= 0.716 * GDP',NULL,NULL,1,'7',NULL,'R8'),(1134,NULL,'',NULL,NULL,0,1,'TFR<0',NULL,NULL,1,'1',NULL,'R9'),(1135,NULL,NULL,NULL,NULL,NULL,1,'rule',NULL,NULL,9,'7',NULL,'R1'),(1136,NULL,NULL,NULL,NULL,NULL,1,'region %in% c(\'Africa\',\'Americas\',\'Asia\',\'Europe\',\'Oceania\')',NULL,NULL,9,'7',NULL,'R2'),(1137,NULL,NULL,NULL,NULL,NULL,1,'TFR > 0',NULL,NULL,9,'7',NULL,'R3'),(1138,NULL,NULL,NULL,NULL,NULL,1,'GDP > 0',NULL,NULL,9,'7',NULL,'R4'),(1139,NULL,NULL,NULL,NULL,NULL,1,'contr > 0',NULL,NULL,9,'7',NULL,'R5'),(1140,NULL,NULL,NULL,NULL,NULL,1,'infmort > 0',NULL,NULL,9,'7',NULL,'R6'),(1141,NULL,NULL,NULL,NULL,NULL,1,'TFR <= 0.048 * GDP',NULL,NULL,9,'7',NULL,'R7'),(1142,NULL,NULL,NULL,NULL,NULL,1,'contr <= 0.195 * GDP',NULL,NULL,9,'7',NULL,'R8'),(1143,NULL,NULL,NULL,NULL,NULL,1,'infmort <= 0.716 * GDP',NULL,NULL,9,'7',NULL,'R9'),(1165,NULL,NULL,NULL,NULL,NULL,1,'region %in% c(\'Africa\',\'Americas\',\'Asia\',\'Europe\',\'Oceania\')',NULL,NULL,12,'7',NULL,'R1'),(1166,NULL,NULL,NULL,NULL,NULL,1,'TFR > 0',NULL,NULL,12,'7',NULL,'R2'),(1167,NULL,NULL,NULL,NULL,NULL,1,'GDP > 0',NULL,NULL,12,'7',NULL,'R3'),(1168,NULL,NULL,NULL,NULL,NULL,1,'contr > 0',NULL,NULL,12,'7',NULL,'R4'),(1169,NULL,NULL,NULL,NULL,NULL,1,'infmort > 0',NULL,NULL,12,'7',NULL,'R5'),(1170,NULL,NULL,NULL,NULL,NULL,1,'TFR <= 0.048 * GDP',NULL,NULL,12,'7',NULL,'R6'),(1171,NULL,NULL,NULL,NULL,NULL,1,'contr <= 0.195 * GDP',NULL,NULL,12,'7',NULL,'R7'),(1172,NULL,NULL,NULL,NULL,NULL,1,'infmort <= 0.716 * GDP',NULL,NULL,12,'7',NULL,'R8');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_ruleset`
--

LOCK TABLES `sx_ruleset` WRITE;
/*!40000 ALTER TABLE `sx_ruleset` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_sessione_lavoro`
--

LOCK TABLES `sx_sessione_lavoro` WRITE;
/*!40000 ALTER TABLE `sx_sessione_lavoro` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_instance`
--

LOCK TABLES `sx_step_instance` WRITE;
/*!40000 ALTER TABLE `sx_step_instance` DISABLE KEYS */;
INSERT INTO `sx_step_instance` VALUES (11,'contengencyTable','contengencyTable','CTable',250),(12,'fellegisunter','Fellegi Sunter','FellegiSunter',200),(13,'resultTables','Matching Table','MTable',250),(14,'is2_validate_confront','validate','VALIDATE',300);
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
INSERT INTO `sx_step_stepinstance` VALUES (11,70),(12,71),(13,72),(14,4);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_variable`
--

LOCK TABLES `sx_step_variable` WRITE;
/*!40000 ALTER TABLE `sx_step_variable` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_stepinstance_approle`
--

LOCK TABLES `sx_stepinstance_approle` WRITE;
/*!40000 ALTER TABLE `sx_stepinstance_approle` DISABLE KEYS */;
INSERT INTO `sx_stepinstance_approle` VALUES (154,11,154,1,1),(155,11,155,1,1),(158,11,158,2,NULL),(161,11,161,2,0),(166,11,166,1,1),(167,12,161,1,1),(168,12,167,2,NULL),(169,13,154,1,1),(170,13,155,1,1),(171,13,167,1,1),(172,13,161,1,0),(173,13,168,2,NULL),(176,13,169,1,1),(177,13,170,1,1),(178,14,174,1,1),(179,14,175,1,1);
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
INSERT INTO `sx_stepinstance_parameter` VALUES (1,'MATCHING VARIABLES',11,'MATCHING VARIABLES','3',166,'{\"type\": \"object\", \"properties\": {\"MetricMatchingVariables\":{\"title\":\"MetricMatchingVariables\",\"type\":\"array\",\"items\":{\"type\":\"object\",\"title\":\"MetricMatchingVariable\",\"properties\":{\"MatchingVariable\":{\"type\":\"string\",\"title\":\"MatchingVariable\",\"maxLength\":50,\"required\":true},\"MatchingVariableA\":{\"type\":\"string\",\"title\":\"MatchingVariableA\",\"maxLength\":50,\"required\":true},\"MatchingVariableB\":{\"type\":\"string\",\"title\":\"MatchingVariableB\",\"maxLength\":50,\"required\":true},\"Method\":{\"title\":\"Method\",\"enum\":[\"Jaro\",\"jaro1\",\"Jaro2\"],\"required\":true},\"Thresould\":{\"type\":\"number\",\"title\":\"Threshould\"},\"Window\":{\"type\":\"integer\",\"title\":\"Window\"}}}}}}','{\"data\":[],\"schema\":{\"items\":{\"properties\":{\"MatchingVariable\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariable\",\"type\":\"string\"},\"MatchingVariableA\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariableA\",\"type\":\"string\"},\"MatchingVariableB\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariableB\",\"type\":\"string\"},\"Method\":{\"enum\":[\"Equality\",\"Jaro\",\"Dice\",\"JaroWinkler\",\"Levenshtein\",\"3Grams\",\"Soundex\",\"NumericComparison\",\"NumericEuclideanDistance\",\"WindowEquality\",\"Inclusion3Grams\"],\"required\":true,\"title\":\"Method\"},\"Threshold\":{\"title\":\"Threshold\",\"type\":\"number\"},\"Window\":{\"title\":\"Window\",\"type\":\"integer\"}},\"type\":\"object\"},\"type\":\"array\"},\"options\":{\"type\":\"table\",\"showActionsColumn\":false,\"hideAddItemsBtn\":true,\"items\":{\"fields\":{\"Method\":{\"type\":\"select\",\"noneLabel\":\"\",\"removeDefaultNone\":false},\"MatchingVariableA\":{\"type\":\"select\",\"noneLabel\":\"\",\"dataSource\":\"matchedVariables\"},\"MatchingVariableB\":{\"type\":\"select\",\"noneLabel\":\"\",\"dataSource\":\"matchedVariables\"}}},\"form\":{\"buttons\":{\"addRow\":\"addRow\",\"removeRow\":\"removeRow\"}},\"view\":{\"templates\":{\"container-array-toolbar\":\"#addItemsBtn\"}}}}'),(2,'THRESHOLD MATCHING',13,'THRESHOLD MATCHING','1',169,'{\"name\":\"THRESHOLD MATCHING\",\"type\":\"number\",\"title\":\"THRESHOLD MATCHING\", \"minimum\": 0.01,\"maximum\": 1}','{\"data\":[],\"schema\":{\"name\":\"THRESHOLD MATCHING\",\"type\":\"number\", \"minimum\": 0.01,\"maximum\": 1}}'),(3,'THRESHOLD UNMATCHING',13,'THRESHOLD UNMATCHING','1',170,'{\"name\":\"THRESHOLD UNMATCHING\",\"type\":\"number\",\"title\":\"THRESHOLD UNMATCHING\", \"minimum\": 0.01,\"maximum\": 1}','{\"data\":[],\"schema\":{\"name\":\"THRESHOLD UNMATCHING\",\"type\":\"number\", \"minimum\": 0.01,\"maximum\": 1}}');
/*!40000 ALTER TABLE `sx_stepinstance_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_stepinstance_parameter_old`
--

DROP TABLE IF EXISTS `sx_stepinstance_parameter_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_stepinstance_parameter_old` (
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
-- Dumping data for table `sx_stepinstance_parameter_old`
--

LOCK TABLES `sx_stepinstance_parameter_old` WRITE;
/*!40000 ALTER TABLE `sx_stepinstance_parameter_old` DISABLE KEYS */;
INSERT INTO `sx_stepinstance_parameter_old` VALUES (1,'MATCHING VARAIBLES',11,'MATCHING VARAIBLES','3',166,'{\"type\": \"object\", \"properties\": {\"MetricMatchingVariables\":{\"title\":\"MetricMatchingVariables\",\"type\":\"array\",\"items\":{\"type\":\"object\",\"title\":\"MetricMatchingVariable\",\"properties\":{\"MatchingVariable\":{\"type\":\"string\",\"title\":\"MatchingVariable\",\"maxLength\":50,\"required\":true},\"MatchingVariableA\":{\"type\":\"string\",\"title\":\"MatchingVariableA\",\"maxLength\":50,\"required\":true},\"MatchingVariableB\":{\"type\":\"string\",\"title\":\"MatchingVariableB\",\"maxLength\":50,\"required\":true},\"Method\":{\"title\":\"Method\",\"enum\":[\"Jaro\",\"jaro1\",\"Jaro2\"],\"required\":true},\"Thresould\":{\"type\":\"number\",\"title\":\"Threshould\"},\"Window\":{\"type\":\"integer\",\"title\":\"Window\"}}}}}}','{\"data\":[],\"schema\":{\"items\":{\"properties\":{\"MatchingVariable\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariable\",\"type\":\"string\"},\"MatchingVariableA\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariableA\",\"type\":\"string\"},\"MatchingVariableB\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariableB\",\"type\":\"string\"},\"Method\":{\"enum\":[\"Equality\",\"Jaro\",\"Dice\",\"JaroWinkler\",\"Levenshtein\",\"3Grams\",\"Soundex\",\"NumericComparison\",\"NumericEuclideanDistance\",\"WindowEquality\",\"Inclusion3Grams\"],\"required\":true,\"title\":\"Method\"},\"Threshold\":{\"title\":\"Threshold\",\"type\":\"number\"},\"Window\":{\"title\":\"Window\",\"type\":\"integer\"}},\"type\":\"object\"},\"type\":\"array\"},\"options\":{\"type\":\"table\",\"toolbarSticky\":true,\"toolbar\":{\"actions\":[{\"action\":\"up\",\"hidden\":true}]},\"items\":{\"fields\":{\"Method\":{\"type\":\"select\",\"noneLabel\":\"\",\"removeDefaultNone\":false}}}}}'),(2,'THRESHOLD MATCHING',13,'THRESHOLD MATCHING','1',169,'{\"name\":\"THRESHOLD MATCHING\",\"type\":\"number\",\"title\":\"THRESHOLD MATCHING\", \"minimum\": 0.01,\"maximum\": 1}','{\"data\":[],\"schema\":{\"name\":\"THRESHOLD MATCHING\",\"type\":\"number\", \"minimum\": 0.01,\"maximum\": 1}}'),(3,'THRESHOLD UNMATCHING',13,'THRESHOLD UNMATCHING','1',170,'{\"name\":\"THRESHOLD UNMATCHING\",\"type\":\"number\",\"title\":\"THRESHOLD UNMATCHING\", \"minimum\": 0.01,\"maximum\": 1}','{\"data\":[],\"schema\":{\"name\":\"THRESHOLD UNMATCHING\",\"type\":\"number\", \"minimum\": 0.01,\"maximum\": 1}}');
/*!40000 ALTER TABLE `sx_stepinstance_parameter_old` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_campo`
--

LOCK TABLES `sx_tipo_campo` WRITE;
/*!40000 ALTER TABLE `sx_tipo_campo` DISABLE KEYS */;
INSERT INTO `sx_tipo_campo` VALUES (1,'INPUT'),(2,'OUTPUT'),(4,'RULESET');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_dato`
--

LOCK TABLES `sx_tipo_dato` WRITE;
/*!40000 ALTER TABLE `sx_tipo_dato` DISABLE KEYS */;
INSERT INTO `sx_tipo_dato` VALUES (1,'INPUT',NULL),(2,'RULE',NULL),(3,'PARAMETER',NULL),(4,'RULESET',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_var`
--

LOCK TABLES `sx_tipo_var` WRITE;
/*!40000 ALTER TABLE `sx_tipo_var` DISABLE KEYS */;
INSERT INTO `sx_tipo_var` VALUES (1,'VAR','TIPOLOGIA VARIABILE'),(2,'PAR','TIPOLOGIA PARAMETRO'),(3,'MOD','MODELLO DATI'),(4,'RULESET','RULESET');
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
) ENGINE=InnoDB AUTO_INCREMENT=457 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_users`
--

LOCK TABLES `sx_users` WRITE;
/*!40000 ALTER TABLE `sx_users` DISABLE KEYS */;
INSERT INTO `sx_users` VALUES (83,'fra@fra.it','Francesco Amato','fra','$2a$10$DIcyvIFwhDkEOT9nBugTleDM73OkZffZUdfmvjMCEXdJr3PZP8Kxm',1),(243,'user@is2.it','user','test','$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82',2),(445,'admin@is2.it','Administrator','admin','$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC',1),(451,'survey@istat.it','francesc8','sada','$2a$10$SBKYfMVUdHl.1mY2BGuG1uGBE.xRcpJsIC.dyJBfS2Cyl6FEYSwg.',1),(452,'pippo@pippo.it','franco','franco','$2a$10$Fc9JXOqpO8Ar.t0eoOS8pew7RejzFDmGatAqff/RME9qAB9FHY4M6',1),(456,'frappo@pi.it','casaa','casa','$2a$10$uCF/u9Cs/akIfua08OUZ/eR5X58SfDaI5Lxc2HPpBpSbDbn9.0iQS',1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_workset`
--

LOCK TABLES `sx_workset` WRITE;
/*!40000 ALTER TABLE `sx_workset` DISABLE KEYS */;
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

-- Dump completed on 2019-10-23 11:43:09
