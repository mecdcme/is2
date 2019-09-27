-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: is2
-- ------------------------------------------------------
-- Server version	8.0.16

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
  `STATUS` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EXIT_CODE` varchar(2500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  `JOB_CONFIGURATION_LOCATION` varchar(2500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `WF_SESSION_ID` bigint(20) DEFAULT NULL,
  `WF_ELAB_ID` bigint(20) DEFAULT NULL,
  `WF_PROC_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  KEY `JOB_INST_EXEC_FK` (`JOB_INSTANCE_ID`),
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `batch_job_instance` (`JOB_INSTANCE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `SHORT_CONTEXT` varchar(2500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SERIALIZED_CONTEXT` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `TYPE_CD` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `KEY_NAME` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `STRING_VAL` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DATE_VAL` datetime DEFAULT NULL,
  `LONG_VAL` bigint(20) DEFAULT NULL,
  `DOUBLE_VAL` double DEFAULT NULL,
  `IDENTIFYING` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  KEY `JOB_EXEC_PARAMS_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
INSERT INTO `batch_job_execution_seq` VALUES (99);
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
  `JOB_NAME` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `JOB_KEY` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`JOB_INSTANCE_ID`),
  UNIQUE KEY `JOB_INST_UN` (`JOB_NAME`,`JOB_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
INSERT INTO `batch_job_seq` VALUES (99);
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
  `STEP_NAME` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `COMMIT_COUNT` bigint(20) DEFAULT NULL,
  `READ_COUNT` bigint(20) DEFAULT NULL,
  `FILTER_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_COUNT` bigint(20) DEFAULT NULL,
  `READ_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `PROCESS_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `ROLLBACK_COUNT` bigint(20) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  KEY `JOB_EXEC_STEP_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `SHORT_CONTEXT` varchar(2500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `SERIALIZED_CONTEXT` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `batch_step_execution` (`STEP_EXECUTION_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
INSERT INTO `batch_step_execution_seq` VALUES (99);
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
INSERT INTO `sx_app_role` VALUES (0,'SKIP','N','VARIABILE NON UTILIZZATA',100,1,1),(1,'IDENTIFICATIVO','I','CHIAVE OSSERVAZIONE',100,1,1),(2,'TARGET','Y','VARIABILE DI OGGETTO DI ANALISI',100,3,1),(3,'COVARIATA','X','VARIABILE INDIPENDENTE',100,4,1),(4,'PREDIZIONE','P','VARIABILE DI PREDIZIONE',100,5,1),(5,'OUTLIER','O','FLAG OUTLIER',100,6,1),(6,'PESO','W','PESO CAMPIONARIO',100,7,1),(7,'ERRORE','E','ERRORE INFLUENTE',100,10,1),(8,'RANKING','R','INFLUENCE RANKING',100,11,1),(9,'OUTPUT','T','VARIABILE DI OUTPUT',100,20,1),(10,'STRATO','S','PARTIZIONAMENTO DEL DATASET',100,2,1),(11,'PARAMETRI','Z','PARAMETRI DI INPUT',100,997,2),(12,'MODELLO','M','MODELLO DATI',100,998,2),(13,'SCORE','F','INFLUENCE SCORE',100,12,1),(14,'INFO','G','PARAMETRI OUT - INFO RIEPILOGO',100,999,1),(100,'SKIP','N','VARIABILE NON UTILIZZATA',200,100,1),(102,'CHIAVE A','K1','CHIAVE DATASET A',200,3,1),(103,'CHIAVE B','K2','CHIAVE DATASET B',200,4,1),(104,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',200,5,1),(105,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',200,6,1),(108,'RANKING','M','INFLUENCE RANKING',200,11,2),(110,'STRATO','S','PARTIZIONAMENTO DEL DATASET',200,2,1),(111,'RESULT','R','RISULTATO PRODOTTO CARTESIANO',200,10,2),(115,'BLOCKING','B','SLICING DEL DATASET',200,3,1),(150,'SKIP','N','VARIABILE NON UTILIZZATA',250,100,1),(152,'KEY A','K1','CHIAVE DATASET A',250,3,1),(153,'KEY B','K2','CHIAVE DATASET B',250,4,1),(154,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',250,5,1),(155,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',250,6,1),(158,'RANKING','M','INFLUENCE RANKING',250,11,2),(160,'STRATA','S','PARTIZIONAMENTO DEL DATASET',250,2,1),(161,'CONTENGENCY TABLE','CT','CONTENGENCY TABLE',250,1,1),(165,'BLOCKING','B','SLICING DEL DATASET',250,3,1),(166,'MATCHING VARIABLES','X','VARIABLI DI MATCHING',250,1,2),(167,'FELLEGI-SUNTER','FS','FELLEGI-SUNTER',200,2,1),(168,'MATCHING TABLE','MT','MATCHING TABLE',250,3,1),(169,'THRESHOLD MATCHING','TH','THRESHOLD MATCHING',250,2,2),(170,'THRESHOLD UNMATCHING','TU','THRESHOLD UNMATCHING',250,4,2),(171,'POSSIBLE MATCHING TABLE','PM','POSSIBLE MATCHING TABLE',250,5,1),(172,'RESIDUAL A','RA','RESIDUAL DATASET  A',250,6,1),(173,'RESIDUAL B','RB','RESIDUAL DATASET  B',250,7,1);
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
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
INSERT INTO `sx_bprocess_bstep` VALUES (6,70),(6,71),(6,72),(70,70),(71,71),(72,72);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_elaborazione`
--

LOCK TABLES `sx_elaborazione` WRITE;
/*!40000 ALTER TABLE `sx_elaborazione` DISABLE KEYS */;
INSERT INTO `sx_elaborazione` VALUES (9,'2019-09-27 14:30:35','Process RLP',NULL,'',21,1);
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
  `msg` text COLLATE utf8mb4_unicode_ci,
  `msg_time` datetime DEFAULT NULL,
  `id_sessione` int(20) NOT NULL,
  `tipo` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_log`
--

LOCK TABLES `sx_log` WRITE;
/*!40000 ALTER TABLE `sx_log` DISABLE KEYS */;
INSERT INTO `sx_log` VALUES (1,'File DSA salvato con successo','2019-09-27 04:41:46',20,'OUT'),(2,'File DSB salvato con successo','2019-09-27 04:42:07',20,'OUT'),(3,'Elaborazione rlp creata con successo','2019-09-27 04:42:28',20,'OUT'),(4,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 04:46:29',20,'OUT'),(5,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 04:46:32',20,'OUT'),(6,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 04:47:07',20,'OUT'),(7,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 04:47:09',20,'OUT'),(8,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 04:48:35',20,'OUT'),(9,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 04:48:36',20,'OUT'),(10,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 04:49:17',20,'OUT'),(11,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 04:49:18',20,'OUT'),(12,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 04:53:36',20,'OUT'),(13,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 04:53:37',20,'OUT'),(14,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 04:55:35',20,'OUT'),(15,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 04:55:36',20,'OUT'),(16,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 04:57:38',20,'OUT'),(17,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 04:57:40',20,'OUT'),(18,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 04:59:01',20,'OUT'),(19,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 04:59:02',20,'OUT'),(20,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:00:37',20,'OUT'),(21,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:00:38',20,'OUT'),(22,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:01:04',20,'OUT'),(23,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:01:06',20,'OUT'),(24,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:02:52',20,'OUT'),(25,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:02:54',20,'OUT'),(26,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:06:12',20,'OUT'),(27,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:06:13',20,'OUT'),(28,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:07:09',20,'OUT'),(29,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:07:11',20,'OUT'),(30,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:10:00',20,'OUT'),(31,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:10:02',20,'OUT'),(32,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:11:21',20,'OUT'),(33,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:11:22',20,'OUT'),(34,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:12:07',20,'OUT'),(35,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:12:08',20,'OUT'),(36,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:12:24',20,'OUT'),(37,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:12:25',20,'OUT'),(38,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:12:49',20,'OUT'),(39,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:12:49',20,'OUT'),(40,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:13:32',20,'OUT'),(41,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:13:33',20,'OUT'),(42,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:16:34',20,'OUT'),(43,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:16:35',20,'OUT'),(44,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:21:43',20,'OUT'),(45,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:22:31',20,'OUT'),(46,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:24:28',20,'OUT'),(47,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:24:55',20,'OUT'),(48,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:28:26',20,'OUT'),(49,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:28:45',20,'OUT'),(50,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:29:08',20,'OUT'),(51,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:29:27',20,'OUT'),(52,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 05:31:15',20,'OUT'),(53,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 05:31:17',20,'OUT'),(54,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 05:31:29',20,'OUT'),(55,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 05:31:47',20,'OUT'),(56,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 07:54:46',20,'OUT'),(57,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 07:55:07',20,'OUT'),(58,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 08:03:30',20,'OUT'),(59,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 08:03:49',20,'OUT'),(60,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 08:06:50',20,'OUT'),(61,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 08:07:09',20,'OUT'),(62,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:05:38',20,'OUT'),(63,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 09:05:40',20,'OUT'),(64,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 09:06:10',20,'OUT'),(65,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 09:06:13',20,'OUT'),(66,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:07:22',20,'OUT'),(67,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 09:07:22',20,'OUT'),(68,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:07:30',20,'OUT'),(69,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 09:07:31',20,'OUT'),(70,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:08:18',20,'OUT'),(71,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 09:08:19',20,'OUT'),(72,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:08:33',20,'OUT'),(73,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 09:08:34',20,'OUT'),(74,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:12:08',20,'OUT'),(75,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 09:12:09',20,'OUT'),(76,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:15:52',20,'OUT'),(77,'stdout','2019-09-27 09:15:56',20,'R'),(78,'Script completed!','2019-09-27 09:15:56',20,'OUT'),(79,'Job for elaborazione[8] and  processo[71] COMPLETED','2019-09-27 09:15:56',20,'OUT'),(80,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:17:24',20,'OUT'),(81,'stdout','2019-09-27 09:17:28',20,'R'),(82,'Script completed!','2019-09-27 09:17:28',20,'OUT'),(83,'Job for elaborazione[8] and  processo[71] COMPLETED','2019-09-27 09:17:28',20,'OUT'),(84,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 09:21:13',20,'OUT'),(85,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 09:21:15',20,'OUT'),(86,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:21:20',20,'OUT'),(87,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 09:21:42',20,'OUT'),(88,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:23:36',20,'OUT'),(89,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 09:23:38',20,'OUT'),(90,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 09:24:37',20,'OUT'),(91,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 09:24:59',20,'OUT'),(92,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 10:54:50',20,'OUT'),(93,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 10:54:52',20,'OUT'),(94,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 10:54:55',20,'OUT'),(95,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 10:54:57',20,'OUT'),(96,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 10:55:02',20,'OUT'),(97,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 10:55:03',20,'OUT'),(98,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 10:57:11',20,'OUT'),(99,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 10:57:12',20,'OUT'),(100,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 10:57:26',20,'OUT'),(101,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 10:57:26',20,'OUT'),(102,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 10:57:44',20,'OUT'),(103,'stdout','2019-09-27 10:57:47',20,'R'),(104,'Script completed!','2019-09-27 10:57:47',20,'OUT'),(105,'Job for elaborazione[8] and  processo[71] COMPLETED','2019-09-27 10:57:47',20,'OUT'),(106,'Job for elaborazione[8] and  process[72] STARTED','2019-09-27 11:40:17',20,'OUT'),(107,'Job for elaborazione[8] and  processo[72] COMPLETED','2019-09-27 11:40:19',20,'OUT'),(108,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 12:32:28',20,'OUT'),(109,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 12:32:30',20,'OUT'),(110,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 12:38:58',20,'OUT'),(111,'[1] \"Freq~V3+V2+V1\"','2019-09-27 12:39:01',20,'R'),(112,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 12:39:02',20,'R'),(113,'[1] 3','2019-09-27 12:39:02',20,'R'),(114,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 12:39:02',20,'R'),(115,'Script completed!','2019-09-27 12:39:02',20,'OUT'),(116,'Job for elaborazione[8] and  processo[71] COMPLETED','2019-09-27 12:39:02',20,'OUT'),(117,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 12:44:57',20,'OUT'),(118,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 12:45:00',20,'OUT'),(119,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 12:45:11',20,'OUT'),(120,'Job for elaborazione[8] and  processo[71] FAILED','2019-09-27 12:45:11',20,'OUT'),(121,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 12:45:35',20,'OUT'),(122,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 12:45:37',20,'OUT'),(123,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 12:46:58',20,'OUT'),(124,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 12:47:00',20,'OUT'),(125,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 12:47:15',20,'OUT'),(126,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 12:56:24',20,'OUT'),(127,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 12:56:33',20,'OUT'),(128,'Job for elaborazione[8] and  process[70] STARTED','2019-09-27 12:57:17',20,'OUT'),(129,'Job for elaborazione[8] and  processo[70] COMPLETED','2019-09-27 12:57:19',20,'OUT'),(130,'Job for elaborazione[8] and  process[71] STARTED','2019-09-27 12:57:22',20,'OUT'),(131,NULL,'2019-09-27 12:57:53',20,'OUT'),(137,NULL,'2019-09-27 12:57:59',20,'OUT'),(143,NULL,'2019-09-27 12:58:01',20,'OUT'),(144,'[1] \"Freq~V3+V2+V1\"','2019-09-27 12:58:03',20,'R'),(145,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 12:58:03',20,'R'),(146,'[1] 3','2019-09-27 12:58:03',20,'R'),(147,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 12:58:03',20,'R'),(148,'Script completed!','2019-09-27 12:58:03',20,'OUT'),(149,'Job for elaborazione[8] and  processo[71] COMPLETED','2019-09-27 12:58:03',20,'OUT'),(158,'[1] \"Freq~V3+V2+V1\"','2019-09-27 14:43:27',21,'R'),(159,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 14:43:27',21,'R'),(160,'[1] 3','2019-09-27 14:43:27',21,'R'),(161,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 14:43:27',21,'R'),(169,'[1] \"Freq~V3+V2+V1\"','2019-09-27 14:55:00',21,'R'),(170,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 14:55:00',21,'R'),(171,'[1] 3','2019-09-27 14:55:00',21,'R'),(172,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 14:55:00',21,'R'),(182,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 15:06:57',21,'R'),(183,'[1] 3','2019-09-27 15:06:57',21,'R'),(184,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 15:06:57',21,'R'),(192,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 15:07:55',21,'R'),(193,'[1] 3','2019-09-27 15:07:55',21,'R'),(194,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 15:07:55',21,'R'),(204,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 15:12:05',21,'R'),(205,'[1] 3','2019-09-27 15:12:05',21,'R'),(206,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 15:12:05',21,'R'),(238,'  SURNAME NAME LASTCODE FREQUENCY','2019-09-27 16:08:17',21,'R'),(239,'1       0    0        0    165810','2019-09-27 16:08:17',21,'R'),(240,'2       0    0        1      8133','2019-09-27 16:08:17',21,'R'),(241,'3       0    1        0       700','2019-09-27 16:08:17',21,'R'),(242,'4       0    1        1        52','2019-09-27 16:08:17',21,'R'),(243,'5       1    0        0       917','2019-09-27 16:08:17',21,'R'),(244,'6       1    0        1       146','2019-09-27 16:08:17',21,'R'),(245,'7       1    1        0        76','2019-09-27 16:08:17',21,'R'),(246,'8       1    1        1       174','2019-09-27 16:08:17',21,'R'),(247,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 16:08:17',21,'R'),(248,'[1] 3','2019-09-27 16:08:17',21,'R'),(249,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 16:08:17',21,'R'),(255,'  SURNAME NAME LASTCODE FREQUENCY','2019-09-27 16:20:40',21,'R'),(256,'1       0    0        0    165810','2019-09-27 16:20:40',21,'R'),(257,'2       0    0        1      8133','2019-09-27 16:20:40',21,'R'),(258,'3       0    1        0       700','2019-09-27 16:20:40',21,'R'),(259,'4       0    1        1        52','2019-09-27 16:20:40',21,'R'),(260,'5       1    0        0       917','2019-09-27 16:20:40',21,'R'),(261,'6       1    0        1       146','2019-09-27 16:20:40',21,'R'),(262,'7       1    1        0        76','2019-09-27 16:20:40',21,'R'),(263,'8       1    1        1       174','2019-09-27 16:20:40',21,'R'),(264,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 16:20:40',21,'R'),(265,'[1] 3','2019-09-27 16:20:40',21,'R'),(266,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 16:20:40',21,'R'),(271,'Job for elaborazione[9] and  process[70] STARTED','2019-09-27 16:24:43',21,'OUT'),(272,'Job for elaborazione[9] and  processo[70] COMPLETED','2019-09-27 16:24:45',21,'OUT'),(273,'Job for elaborazione[9] and  process[71] STARTED','2019-09-27 16:26:39',21,'OUT'),(274,'[1] \"SURNAME\"   \"NAME\"      \"LASTCODE\"  \"FREQUENCY\"','2019-09-27 16:26:41',21,'R'),(275,'[1] 3','2019-09-27 16:26:41',21,'R'),(276,'[1] \"The match frequency estimated from EM algorithm is p =  0.002461\"','2019-09-27 16:26:41',21,'R'),(277,'Script completed!','2019-09-27 16:26:41',21,'OUT'),(278,'Job for elaborazione[9] and  processo[71] COMPLETED','2019-09-27 16:26:42',21,'OUT'),(279,'Job for elaborazione[9] and  process[72] STARTED','2019-09-27 16:26:47',21,'OUT'),(280,'Job for elaborazione[9] and  processo[72] COMPLETED','2019-09-27 16:26:49',21,'OUT');
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
INSERT INTO `sx_rule` VALUES (959,NULL,'sd',NULL,NULL,0,1,'a+b',NULL,NULL,20,'1',NULL);
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
INSERT INTO `sx_ruleset` VALUES (20,NULL,'RS_1','d',NULL,NULL,19,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_sessione_lavoro`
--

LOCK TABLES `sx_sessione_lavoro` WRITE;
/*!40000 ALTER TABLE `sx_sessione_lavoro` DISABLE KEYS */;
INSERT INTO `sx_sessione_lavoro` VALUES (19,83,'2019-09-06 15:39:12','dfd','fdf',3),(21,83,'2019-09-27 14:29:36','Census RLP','',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=355 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_stepinstance_approle`
--

LOCK TABLES `sx_stepinstance_approle` WRITE;
/*!40000 ALTER TABLE `sx_stepinstance_approle` DISABLE KEYS */;
INSERT INTO `sx_stepinstance_approle` VALUES (154,11,154,1,1),(155,11,155,1,1),(158,11,158,2,NULL),(161,11,161,2,1),(166,11,166,1,1),(167,12,161,1,1),(168,12,167,2,NULL),(169,13,154,1,1),(170,13,155,1,1),(171,13,167,1,1),(172,13,161,1,1),(173,13,168,2,NULL),(176,13,169,1,1),(177,13,170,1,1);
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
INSERT INTO `sx_stepinstance_parameter` VALUES (1,'MATCHING VARIABLES',11,'MATCHING VARIABLES','3',166,'{\"data\":[],\"schema\":{\"items\":{\"properties\":{\"MatchingVariable\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariable\",\"type\":\"string\"},\"MatchingVariableA\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariableA\",\"type\":\"string\"},\"MatchingVariableB\":{\"maxLength\":50,\"required\":true,\"title\":\"MatchingVariableB\",\"type\":\"string\"},\"Method\":{\"enum\":[\"Equality\",\"Jaro\",\"Dice\",\"JaroWinkler\",\"Levenshtein\",\"3Grams\",\"Soundex\",\"NumericComparison\",\"NumericEuclideanDistance\",\"WindowEquality\",\"Inclusion3Grams\"],\"required\":true,\"title\":\"Method\"},\"Threshold\":{\"title\":\"Threshold\",\"type\":\"number\"},\"Window\":{\"title\":\"Window\",\"type\":\"integer\"}},\"type\":\"object\"},\"type\":\"array\"},\"options\":{\"type\":\"table\",\"showActionsColumn\":false,\"hideAddItemsBtn\":true,\"items\":{\"fields\":{\"Method\":{\"type\":\"select\",\"noneLabel\":\"\",\"removeDefaultNone\":false},\"MatchingVariableA\":{\"type\":\"select\",\"noneLabel\":\"\",\"dataSource\":\"matchedVariables\"},\"MatchingVariableB\":{\"type\":\"select\",\"noneLabel\":\"\",\"dataSource\":\"matchedVariables\"}}},\"form\":{\"buttons\":{\"addRow\":\"addRow\",\"removeRow\":\"removeRow\"}},\"view\":{\"templates\":{\"container-array-toolbar\":\"#addItemsBtn\"}}}}'),(2,'THRESHOLD MATCHING',13,'THRESHOLD MATCHING','1',169,'{\"data\":[],\"schema\":{\"name\":\"THRESHOLD MATCHING\",\"type\":\"number\", \"minimum\": 0.01,\"maximum\": 1}}'),(3,'THRESHOLD UNMATCHING',13,'THRESHOLD UNMATCHING','1',170,'{\"data\":[],\"schema\":{\"name\":\"THRESHOLD UNMATCHING\",\"type\":\"number\", \"minimum\": 0.01,\"maximum\": 1}}');
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
) ENGINE=InnoDB AUTO_INCREMENT=457 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_users`
--

LOCK TABLES `sx_users` WRITE;
/*!40000 ALTER TABLE `sx_users` DISABLE KEYS */;
INSERT INTO `sx_users` VALUES (83,'fra@fra.it','Francesco Amato','fra','$2a$10$DIcyvIFwhDkEOT9nBugTleDM73OkZffZUdfmvjMCEXdJr3PZP8Kxm',1),(243,'user@is2.it','user','test','$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82',2),(445,'admin@is2.it','Administrator','admin','$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC',1),(451,'survey@istat.it','francesc8','sada','$2a$10$SBKYfMVUdHl.1mY2BGuG1uGBE.xRcpJsIC.dyJBfS2Cyl6FEYSwg.',1),(452,'pippo@pippo.it','franco','franco','$2a$10$Fc9JXOqpO8Ar.t0eoOS8pew7RejzFDmGatAqff/RME9qAB9FHY4M6',1),(456,'iannacone@istat.it','Renzo','Iannacone','$2a$10$OAKPs3K7HLoqRBvAKUAC5.aYFecfylCGAXpWM0qPXCI0gXwi8DQb.',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=355 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
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

-- Dump completed on 2019-09-27 18:33:38
