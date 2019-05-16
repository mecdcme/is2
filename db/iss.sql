-- MySQL dump 10.13  Distrib 8.0.14, for Win64 (x86_64)
--
-- Host: localhost    Database: iss
-- ------------------------------------------------------
-- Server version	8.0.14

DROP DATABASE IF EXISTS iss;
CREATE DATABASE iss;

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
-- Table structure for table `sx_app_instance`
--

DROP TABLE IF EXISTS `sx_app_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_app_instance` (
  `ISTANZA` int(11) DEFAULT NULL,
  `STEP` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_app_instance`
--

LOCK TABLES `sx_app_instance` WRITE;
/*!40000 ALTER TABLE `sx_app_instance` DISABLE KEYS */;
INSERT INTO `sx_app_instance` VALUES (1,10),(2,20),(3,30),(2,40),(4,50),(11,70),(8,25),(9,35),(7,15);
/*!40000 ALTER TABLE `sx_app_instance` ENABLE KEYS */;
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
INSERT INTO `sx_app_service` VALUES (100,'SeleMix','Individuazione valori anomali tramite misture','R','SS_selemix.r',100),(200,'Relais','Record Linkage','R','SS_relais.r',200),(250,'RelaisJ','Record Linkage Java','JAVA','SS_relais.jar',250),(300,'Validate','Validazione e gestione delle regole','R','SS_validate.r',300);
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
INSERT INTO `sx_bfunc_bprocess` VALUES (10,10),(15,15),(20,20),(25,25),(30,30),(35,35),(40,40),(50,50),(70,60),(80,10),(80,30),(90,70);
/*!40000 ALTER TABLE `sx_bfunc_bprocess` ENABLE KEYS */;
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
INSERT INTO `sx_bprocess_bstep` VALUES (10,10),(15,15),(20,20),(25,25),(30,30),(35,35),(40,40),(50,50),(60,10),(60,30),(70,70);
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
  `DESCR` varchar(100) DEFAULT NULL,
  `ETICHETTA` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014019` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_function`
--

LOCK TABLES `sx_business_function` WRITE;
/*!40000 ALTER TABLE `sx_business_function` DISABLE KEYS */;
INSERT INTO `sx_business_function` VALUES (10,'Stima e Predizione','Esegue la stima del modello dati e lo applica per produrre una predizione del dato','Stima'),(15,'Stima e Predizione a Strati','Esegue la stima a strati del modello dati e lo applica per produrre una predizione del dato','Stima a Strati'),(20,'Predizione da Modello','Produce una predizione del dato, in base al modello dati che deve essere fornito in input','Predizione'),(25,'Predizione da Modello a Strati','Produce una predizione del dato stratificato, basata sul modello fornito in input','Predizione a Strati'),(30,'Selezione Errori Influenti monostep','Valuta gli errori influenti, in base alla predizione che deve essere fornita in input','Selezione'),(35,'Selezione Errori Influenti monostep a Strati','Valutazione stratificata degli errori influenti, in base alla predizione fornita in input','Selezione a Strati'),(40,'Ricerca Outlier','Ricerca Outlier. Esegue Predizione, perciò necessita di un modello in input','Outlier'),(50,'Stima del modello dati','Esegue la stima per ritornare solamente il modello dei dati','Modello'),(70,'Selezione Errori Influenti multi step','Esegue la stima, predizione e valuta gli errori influenti automaticamente in due step','Selezione2S'),(80,'Selezione Errori Influenti multi process','Esegue la stima, predizione e valuta gli errori influenti in due processi successivi','Selezione2P'),(90,'Cross Table','Esegue il prodotto cartesiano di dataset','Cross Table');
/*!40000 ALTER TABLE `sx_business_function` ENABLE KEYS */;
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
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014187` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_process`
--

LOCK TABLES `sx_business_process` WRITE;
/*!40000 ALTER TABLE `sx_business_process` DISABLE KEYS */;
INSERT INTO `sx_business_process` VALUES (10,'Stima e Predizione','Escuzione del processo di stima e predizione','Estimates',1),(15,'Stima e Predizione a strati','Escuzione del processo di stima e predizione su strato','Strata Estimates',1),(20,'Predizione con modello','Esecuzione del processo di stima da modello','Prediction',2),(25,'Predizione con modello a Strati','Esecuzione del processo di stima da modello stratificato','Strata Prediction',2),(30,'Editing Selettivo','Esecuzione del processo di selezione dei valori influenti','Selection',3),(35,'Editing Selettivo a Strati','Esecuzione del processo di selezione dei valori influenti Stratificato','Strata Selection',3),(40,'Individuazione Outlier','Esecuzione del processo di individuazione degli Outlier','Outlier',2),(50,'Stima modello dati','Stima del modello dati','Model',1),(60,'Stima e selezione','Esecuzione del processo di stima, predizione e selezione automatica','Bistep',1),(70,'Cross Table','Esegue il prodotto cartesiano di dataset','Cross Table',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_step`
--

LOCK TABLES `sx_business_step` WRITE;
/*!40000 ALTER TABLE `sx_business_step` DISABLE KEYS */;
INSERT INTO `sx_business_step` VALUES (10,'MLEST','Stima',1),(15,'STMLEST','Stima stratificata',1),(20,'PRED','Predizione',2),(25,'STRPRED','Predizione stratificata',2),(30,'SELED','Editing Seletivo',3),(35,'STRSELED','Editing Seletivo Stratificato',3),(40,'OUTL','Scelta Outlier',2),(50,'MOD','Imposta Modello',1),(70,'CROSSTABLE','Merge cartesiano',4);
/*!40000 ALTER TABLE `sx_business_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_dataset_colonna`
--

DROP TABLE IF EXISTS `sx_dataset_colonna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_dataset_colonna` (
  `IDCOL` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `DATACARICAMENTO` date DEFAULT NULL,
  `NOTE` varchar(255) DEFAULT NULL,
  `SESSIONE_LAVORO` int(20) DEFAULT NULL,
  `formatofile` varchar(45) DEFAULT NULL,
  `tipodato` int(11) DEFAULT NULL,
  `LABEL_FILE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_file`
--

LOCK TABLES `sx_dataset_file` WRITE;
/*!40000 ALTER TABLE `sx_dataset_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `sx_dataset_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_dataset_tipo_struttura`
--

DROP TABLE IF EXISTS `sx_dataset_tipo_struttura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_dataset_tipo_struttura` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `DESCR` varchar(500) DEFAULT NULL,
  `STRUTTURA` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_tipo_struttura`
--

LOCK TABLES `sx_dataset_tipo_struttura` WRITE;
/*!40000 ALTER TABLE `sx_dataset_tipo_struttura` DISABLE KEYS */;
INSERT INTO `sx_dataset_tipo_struttura` VALUES (1,'Micro',NULL,'ID CLS MESE ANNO VAR1,VAR2,... VARn'),(2,'Tendenziale',NULL,'ID CLS MESE VAR1_anno1,VAR1_anno2,... VAR1_annoN'),(3,'Congiunturale',NULL,'ID CLS ANNO VAR1_mese1,VAR1_mese2,... VAR1_meseN'),(4,'Serie storica',NULL,'ID CLS VAR1_anno1mese1,VAR1_anno1mese2,... VAR1_annoMmeseN');
/*!40000 ALTER TABLE `sx_dataset_tipo_struttura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_elaborazione`
--

DROP TABLE IF EXISTS `sx_elaborazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_elaborazione` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DATAELABORAZIONE` date DEFAULT NULL,
  `NOME` varchar(255) DEFAULT NULL,
  `PARAMETRI` varchar(255) DEFAULT NULL,
  `DESCRIZIONE` varchar(255) DEFAULT NULL,
  `SES_ELABORAZIONE` int(20) DEFAULT NULL,
  `BFUNCTION` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SX_ELABORAZIONE_PK` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
-- Table structure for table `sx_par_pattern`
--

DROP TABLE IF EXISTS `sx_par_pattern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_par_pattern` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `ISTANZA` int(20) DEFAULT NULL,
  `DESCR` varchar(500) DEFAULT NULL,
  `DEFLT` varchar(50) DEFAULT NULL,
  `RUOLO` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014050` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_par_pattern`
--

LOCK TABLES `sx_par_pattern` WRITE;
/*!40000 ALTER TABLE `sx_par_pattern` DISABLE KEYS */;
INSERT INTO `sx_par_pattern` VALUES (1,'model',1,'Data Distribution: LN lognormal / N Normal','LN',11),(2,'lambda',1,'Estimated value for the variance inflation factor','3',12),(3,'w',1,'Estimated value for the proportion of contaminated data','0.05',12),(4,'lambda.fix',1,'TRUE if lambda is known','0',11),(5,'w.fix',1,'TRUE if w is known','0',11),(6,'eps',1,'Tolerance for the log-likelihood conver01ce','0.0000001',11),(7,'max.iter',1,'Max int(20) of EM iterations','500',14),(8,'t.outl',1,'Threshold value for posterior probabilities of identifying outliers','0.05',11),(9,'graph',1,'Activates graphic output','0',11),(10,'B',1,'Matrix of estimated regression coefficients',NULL,12),(11,'sigma',1,'Estimated covariance matrix',NULL,12),(12,'n.outlier',1,'Total of outlying observations',NULL,14),(13,'model',2,'Data Distribution: LN lognormal / N Normal','LN',11),(14,'lambda',2,'Estimated value for the variance inflation factor','3',12),(15,'w',2,'Estimated value for the proportion of contaminated data','0.05',12),(16,'t.outl',2,'Threshold value for posterior probabilities of identifying outliers','0.05',11),(17,'B',2,'Matrix of estimated regression coefficients',NULL,12),(18,'sigma',2,'Estimated covariance matrix',NULL,12),(19,'tot',3,'Estimates of 03ginals vector for the target variables',NULL,11),(20,'t.sel',3,'Optional vector of threshold values for selective edinting on the target variables',NULL,11),(21,'n.outlier',2,'Total of outlying observations',NULL,14),(22,'n.error',3,'Total of influential errors',NULL,14),(23,'model',7,'Data Distribution: LN lognormal / N Normal','LN',11),(24,'lambda',7,'Estimated value for the variance inflation factor','3',12),(25,'n.outlier',7,'Total of outlying observations',NULL,14),(26,'1sigma',7,'Estimated covariance matrix',NULL,12),(27,'B',7,'Matrix of estimated regression coefficients',NULL,12),(28,'graph',7,'Activates graphic output','0',11),(29,'t.outl',7,'Threshold value for posterior probabilities of identifying outliers','0.05',11),(30,'max.iter',7,'Max int(20) of EM iterations','500',14),(31,'eps',7,'Tolerance for the log-likelihood conver01ce','0.0000001',11),(32,'w.fix',7,'TRUE if w is known','0',11),(33,'lambda.fix',7,'TRUE if lambda is known','0',11),(34,'w',7,'Estimated value for the proportion of contaminated data','0.05',12),(35,'t.outl',8,'Threshold value for posterior probabilities of identifying outliers','0.05',11),(36,'n.outlier',8,'Total of outlying observations',NULL,14),(37,'model',8,'Data Distribution: LN lognormal / N Normal','LN',11),(38,'sigma',8,'Estimated covariance matrix',NULL,12),(39,'B',8,'Matrix of estimated regression coefficients',NULL,12),(40,'w',8,'Estimated value for the proportion of contaminated data','0.05',12),(41,'lambda',8,'Estimated value for the variance inflation factor','3',12),(42,'n.error',9,'Total of influential errors',NULL,14),(43,'tot',9,'Estimates of 03ginals vector for the target variables',NULL,11),(44,'t.sel',9,'Optional vector of threshold values for selective edinting on the target variables',NULL,11);
/*!40000 ALTER TABLE `sx_par_pattern` ENABLE KEYS */;
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
  `REGOLA` varchar(500) DEFAULT NULL,
  `ACTION` varchar(500) DEFAULT NULL,
  `ECCEZIONE` varchar(500) DEFAULT NULL,
  `RULESET` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014188` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_rule`
--

LOCK TABLES `sx_rule` WRITE;
/*!40000 ALTER TABLE `sx_rule` DISABLE KEYS */;
INSERT INTO `sx_rule` VALUES (1,'SEL1','Regole per step Selezione',1,1,-1,1,'TARGET IS NOT NULL','ML.EST','DEFINE_TARGET',1),(2,'PRE1','Regole per step Predizione',1,1,-1,1,'TARGET IS NOT NULL','PRED.Y','DEFINE_TARGET',2),(3,'PRE2','Regole per step Predizione',0,1,-2,1,'MODEL IS NOT NULL','PRED.Y','ML.EST',2),(4,'SEL1','Regole per step Selezione',1,1,-1,1,'TARGET IS NOT NULL','SEL.EDIT','DEFINE_TARGET',3),(5,'SEL2','Regole per step Selezione',0,1,-3,1,'PRE01TION IS NOT NULL','SEL.EDIT','PRED.Y',3),(6,'SEL3','Invalid MODEL Dimension',0,1,-3,1,'SIZE(TARGET)=SIZE(PRED)','SEL.EDIT','PRED.Y',3),(7,'PRE3','Invalid MODEL Dimension',0,1,-3,1,'SIZE(SIGMA)=SIZE(TARGET) AND SIZE(BETA)=1+SIZE(COVAR)','PRED.Y','ML.EST',2);
/*!40000 ALTER TABLE `sx_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_ruleset`
--

DROP TABLE IF EXISTS `sx_ruleset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_ruleset` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `DESCR` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014346` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_ruleset`
--

LOCK TABLES `sx_ruleset` WRITE;
/*!40000 ALTER TABLE `sx_ruleset` DISABLE KEYS */;
INSERT INTO `sx_ruleset` VALUES (1,'ml.est.ruleset','Regole per step Stima'),(2,'y.pred.ruleset','Regole per step Predizione'),(3,'sel.edit.ruleset','Regole per step Selezione'),(4,'cross.prod.ruleset','Regole per il prodotto cartesiano');
/*!40000 ALTER TABLE `sx_ruleset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_ruoli`
--

DROP TABLE IF EXISTS `sx_ruoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_ruoli` (
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
-- Dumping data for table `sx_ruoli`
--

LOCK TABLES `sx_ruoli` WRITE;
/*!40000 ALTER TABLE `sx_ruoli` DISABLE KEYS */;
INSERT INTO `sx_ruoli` VALUES (0,'SKIP','N','VARIABILE NON UTILIZZATA',100,100,1),(1,'IDENTIFICATIVO','I','CHIAVE OSSERVAZIONE',100,1,1),(2,'TARGET','Y','VARIABILE DI OGGETTO DI ANALISI',100,3,1),(3,'COVARIATA','X','VARIABILE INDIPENDENTE',100,4,1),(4,'PREDIZIONE','P','VARIABILE DI PREDIZIONE',100,5,1),(5,'OUTLIER','O','FLAG OUTLIER',100,6,1),(6,'PESO','W','PESO CAMPIONARIO',100,7,1),(7,'ERRORE','E','ERRORE INFLUENTE',100,10,1),(8,'RANKING','R','INFLUENCE RANKING',100,11,1),(9,'OUTPUT','T','VARIABILE DI OUTPUT',100,20,1),(10,'STRATO','S','PARTIZIONAMENTO DEL DATASET',100,2,1),(11,'PARAMETRI','Z','PARAMETRI DI INPUT',100,997,2),(12,'MODELLO','M','MODELLO DATI',100,998,2),(13,'SCORE','F','INFLUENCE SCORE',100,12,1),(14,'INFO','G','PARAMETRI OUT - INFO RIEPILOGO',100,999,1),(100,'SKIP','N','VARIABILE NON UTILIZZATA',200,100,1),(102,'CHIAVE A','K1','CHIAVE DATASET A',200,3,1),(103,'CHIAVE B','K2','CHIAVE DATASET B',200,4,1),(104,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',200,5,1),(105,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',200,6,1),(108,'RANKING','M','INFLUENCE RANKING',200,11,2),(110,'STRATO','S','PARTIZIONAMENTO DEL DATASET',200,2,1),(111,'RESULT','R','RISULTATO PRODOTTO CARTESIANO',200,10,2),(115,'BLOCKING','B','SLICING DEL DATASET',200,3,1),(150,'SKIP','N','VARIABILE NON UTILIZZATA',250,100,1),(152,'CHIAVE A','K1','CHIAVE DATASET A',250,3,1),(153,'CHIAVE B','K2','CHIAVE DATASET B',250,4,1),(154,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',250,5,1),(155,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',250,6,1),(158,'RANKING','M','INFLUENCE RANKING',250,11,2),(160,'STRATO','S','PARTIZIONAMENTO DEL DATASET',250,2,1),(161,'RESULT','R','RISULTATO PRODOTTO CARTESIANO',250,10,2),(165,'BLOCKING','B','SLICING DEL DATASET',250,3,1);
/*!40000 ALTER TABLE `sx_ruoli` ENABLE KEYS */;
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
  `DATA_CREAZIONE` date DEFAULT NULL,
  `NOME` varchar(255) DEFAULT NULL,
  `DESCRIZIONE` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SX_SESSIONE_LAVORO_PK` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_sessione_lavoro`
--

LOCK TABLES `sx_sessione_lavoro` WRITE;
/*!40000 ALTER TABLE `sx_sessione_lavoro` DISABLE KEYS */;
INSERT INTO `sx_sessione_lavoro` VALUES (1,1,'2019-04-19','mysqlSession','');
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_instance`
--

LOCK TABLES `sx_step_instance` WRITE;
/*!40000 ALTER TABLE `sx_step_instance` DISABLE KEYS */;
INSERT INTO `sx_step_instance` VALUES (1,'mlest','Stima e predizione','STIMA',100),(2,'ypred','Predizione da modello','PREDIZIONE',100),(3,'seledit','Selezione Errori Influenti','SELEZIONE',100),(4,'modest','Valutazione del modello','MODEL',100),(5,'selpairs','Generazione Grafico','GRAPH',100),(6,'srf','Set Rule File','SRF',300),(7,'strata.mlest','Stima stratificata','STRATST',100),(8,'strata.ypred','Predizione stratificata','STRATPR',100),(9,'strata.seledit','Selezione stratificata','STRATSE',100),(10,'cross_table','Merge cartesiano R','CROSSP',200),(11,'crossTable','Merge Cartesiano Java','CROSSJ',250);
/*!40000 ALTER TABLE `sx_step_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_step_pattern`
--

DROP TABLE IF EXISTS `sx_step_pattern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_step_pattern` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ISTANZA` int(20) DEFAULT NULL,
  `RUOLO` int(20) DEFAULT NULL,
  `TIPO_IO` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014189` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_pattern`
--

LOCK TABLES `sx_step_pattern` WRITE;
/*!40000 ALTER TABLE `sx_step_pattern` DISABLE KEYS */;
INSERT INTO `sx_step_pattern` VALUES (1,1,2,1),(2,1,3,1),(3,1,5,2),(4,1,4,2),(5,1,10,1),(6,1,11,1),(7,1,12,2),(8,2,2,1),(9,2,3,1),(10,2,5,2),(11,2,4,2),(12,2,10,1),(13,2,11,1),(14,2,12,1),(15,3,2,1),(17,3,4,1),(18,3,10,1),(19,3,11,1),(20,3,7,2),(21,3,8,2),(22,3,13,2),(23,4,2,1),(24,4,3,1),(25,4,11,1),(26,4,12,2),(27,1,14,2),(28,2,14,2),(29,3,14,2),(30,4,14,2),(31,7,11,1),(32,7,10,1),(33,7,4,2),(34,7,5,2),(35,7,3,1),(36,7,2,1),(37,7,14,2),(38,9,2,1),(39,9,13,2),(40,9,14,2),(41,9,11,1),(42,9,10,1),(43,9,4,1),(44,9,8,2),(45,9,7,2),(46,8,14,2),(47,8,3,1),(48,8,5,2),(49,8,4,2),(50,8,10,1),(51,8,11,1),(52,8,2,1),(53,8,12,1),(100,10,100,1),(102,10,102,1),(103,10,103,1),(104,10,104,1),(105,10,105,1),(108,10,108,2),(110,10,110,1),(115,10,115,1),(150,11,150,1),(152,11,152,1),(153,11,153,1),(154,11,154,1),(155,11,155,1),(158,11,158,2),(160,11,160,1),(165,11,165,1);
/*!40000 ALTER TABLE `sx_step_pattern` ENABLE KEYS */;
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
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014744` (`ID`),
  KEY `SSVAR` (`VAR`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_variable`
--

LOCK TABLES `sx_step_variable` WRITE;
/*!40000 ALTER TABLE `sx_step_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `sx_step_variable` ENABLE KEYS */;
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
INSERT INTO `sx_tipo_campo` VALUES (1,'INPUT'),(2,'CALCOLATO');
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
-- Table structure for table `sx_tipo_stato`
--

DROP TABLE IF EXISTS `sx_tipo_stato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_tipo_stato` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_stato`
--

LOCK TABLES `sx_tipo_stato` WRITE;
/*!40000 ALTER TABLE `sx_tipo_stato` DISABLE KEYS */;
INSERT INTO `sx_tipo_stato` VALUES (1,'INPUT'),(2,'CALCOLATO');
/*!40000 ALTER TABLE `sx_tipo_stato` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=450 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_users`
--

LOCK TABLES `sx_users` WRITE;
/*!40000 ALTER TABLE `sx_users` DISABLE KEYS */;
INSERT INTO `sx_users` VALUES (83,'fra@fra.it','Francesco Amato','Evangelist','$2a$10$DIcyvIFwhDkEOT9nBugTleDM73OkZffZUdfmvjMCEXdJr3PZP8Kxm',1),(224,'ian@ian.it','Renzo','Iannacone','$2a$10$uFLloGyoJToQHa/wNQ/DsuEhRdgJqbm.54EdvXrBJyePS32nVl/aa',2),(243,'user@user.it','user','test','$2a$10$Os2iXaChPX/TjB1NB3DxE.54cmf4WMcGkl3rfPCnr6.A.pSAtFVTS',2),(344,'sintesi@istat.it','Selemix','Sintesi','$2a$10$NENlbygaMF4vyiIPX1Hvi.wHmFR9vofM7GuFbmtGo1qfwflpkanN.',1),(363,'iannacone@istat.it','Renzo','Iannacone','$2a$10$Doy/0ecZ1ePEyMPsliybbe6ztubWQ4NY92G80P1.ZiEX1KK0ejNLu',1),(403,'claudio.santoro@istat.it','Claudio','Santoro','$2a$10$fwLfUC8dt2GVqpFRB0sp6OzQuFH5eeFKZD8lRMnHkG2s4NNCdDA.q',1),(445,'admin@mecbox.it','admin','admin','$2a$10$qJfcrNUOsyjx.oz4JMns.OOA3/Dtmi6csrc5wqANBOLUNZQgbXNYG',1),(449,'mbruno@istat.it','Mauro','Bruno','$2a$10$OsUG5qjKkrEP/nsaUoXsgewvT9PV7Rb6fjQQUtLrUa/JAtrmj1Kue',1);
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
  `NOME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ORDINE` int(20) DEFAULT NULL,
  `valori` longblob,
  `TIPO_VAR` int(20) DEFAULT NULL,
  `VALORI_SIZE` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014021` (`ID`),
  KEY `TIPOVAR` (`TIPO_VAR`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_workset`
--

LOCK TABLES `sx_workset` WRITE;
/*!40000 ALTER TABLE `sx_workset` DISABLE KEYS */;
/*!40000 ALTER TABLE `sx_workset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_workset2`
--

DROP TABLE IF EXISTS `sx_workset2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_workset2` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `NOME` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `ORDINE` int(20) DEFAULT NULL,
  `TIPO_VAR` int(20) DEFAULT NULL,
  `VALORI_SIZE` int(20) DEFAULT NULL,
  `valori` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_workset2`
--

LOCK TABLES `sx_workset2` WRITE;
/*!40000 ALTER TABLE `sx_workset2` DISABLE KEYS */;
INSERT INTO `sx_workset2` VALUES (27,'da_SURNAME',NULL,1,449,'{\"valori\": [{\"r\": 0, \"v\": \"ANDERSON\"}, {\"r\": 1, \"v\": \"ANDERSON\"}, {\"r\": 2, \"v\": \"ANDERSON\"}, {\"r\": 3, \"v\": \"ANDERSON\"}, {\"r\": 4, \"v\": \"AQUENDO\"}, {\"r\": 5, \"v\": \"BENITEZ\"}, {\"r\": 6, \"v\": \"BENITEZ\"}, {\"r\": 7, \"v\": \"BENITEZ\"}, {\"r\": 8, \"v\": \"BODNER\"}, {\"r\": 9, \"v\": \"BODNER\"}, {\"r\": 10, \"v\": \"BODNER\"}, {\"r\": 11, \"v\": \"BODNER\"}, {\"r\": 12, \"v\": \"BODNER\"}, {\"r\": 13, \"v\": \"CENTURY\"}, {\"r\": 14, \"v\": \"CENTURY\"}, {\"r\": 15, \"v\": \"CENTURY\"}, {\"r\": 16, \"v\": \"CHEESMAN\"}, {\"r\": 17, \"v\": \"CHEESMAN\"}, {\"r\": 18, \"v\": \"CONYERE\"}, {\"r\": 19, \"v\": \"CONYERE\"}, {\"r\": 20, \"v\": \"COSGRAVE\"}, {\"r\": 21, \"v\": \"COSGRAVE\"}, {\"r\": 22, \"v\": \"COSGRAVE\"}, {\"r\": 23, \"v\": \"COSGRAVE\"}, {\"r\": 24, \"v\": \"COSGRAVE\"}, {\"r\": 25, \"v\": \"DANIEL LEIVA\"}, {\"r\": 26, \"v\": \"DANIEL LEIVA\"}, {\"r\": 27, \"v\": \"DARCOURT\"}, {\"r\": 28, \"v\": \"DECANAY\"}, {\"r\": 29, \"v\": \"DECANAY\"}, {\"r\": 30, \"v\": \"DECANAY\"}, {\"r\": 31, \"v\": \"DIVERS\"}, {\"r\": 32, \"v\": \"DOMINGUEZ\"}, {\"r\": 33, \"v\": \"DOMINGUEZ\"}, {\"r\": 34, \"v\": \"FAUST\"}, {\"r\": 35, \"v\": \"FISCHGRUND\"}, {\"r\": 36, \"v\": \"FISCHGRUND\"}, {\"r\": 37, \"v\": \"FISCHGRUND\"}, {\"r\": 38, \"v\": \"GENE\"}, {\"r\": 39, \"v\": \"GENE\"}, {\"r\": 40, \"v\": \"GIERINGER\"}, {\"r\": 41, \"v\": \"GIERINGER\"}, {\"r\": 42, \"v\": \"GIERINGER\"}, {\"r\": 43, \"v\": \"GIERINGER\"}, {\"r\": 44, \"v\": \"GIERINGER\"}, {\"r\": 45, \"v\": \"GREEN\"}, {\"r\": 46, \"v\": \"GREEN\"}, {\"r\": 47, \"v\": \"HENNEGGEY\"}, {\"r\": 48, \"v\": \"HENNEGGEY\"}, {\"r\": 49, \"v\": \"HILL\"}, {\"r\": 50, \"v\": \"JIMENCZ\"}, {\"r\": 51, \"v\": \"JIMENCZ\"}, {\"r\": 52, \"v\": \"JIMENCZ\"}, {\"r\": 53, \"v\": \"JIMENEZ\"}, {\"r\": 54, \"v\": \"KAY\"}, {\"r\": 55, \"v\": \"KELLY\"}, {\"r\": 56, \"v\": \"KILLION\"}, {\"r\": 57, \"v\": \"LAKATOS\"}, {\"r\": 58, \"v\": \"LAKATOS\"}, {\"r\": 59, \"v\": \"LASSITER\"}, {\"r\": 60, \"v\": \"LASSITER\"}, {\"r\": 61, \"v\": \"LASSITER\"}, {\"r\": 62, \"v\": \"LASSITER\"}, {\"r\": 63, \"v\": \"LETO\"}, {\"r\": 64, \"v\": \"MALDONADO\"}, {\"r\": 65, \"v\": \"MALDONADO\"}, {\"r\": 66, \"v\": \"MALDONADO\"}, {\"r\": 67, \"v\": \"MALENDES\"}, {\"r\": 68, \"v\": \"MALENDES\"}, {\"r\": 69, \"v\": \"MCCLAIN\"}, {\"r\": 70, \"v\": \"MOSQUERA\"}, {\"r\": 71, \"v\": \"MOSQUERA\"}, {\"r\": 72, \"v\": \"MOSQUERA\"}, {\"r\": 73, \"v\": \"MOSQUERA\"}, {\"r\": 74, \"v\": \"MOSQUERA\"}, {\"r\": 75, \"v\": \"MOSQUERA\"}, {\"r\": 76, \"v\": \"MOSQUERA\"}, {\"r\": 77, \"v\": \"PAIGIE\"}, {\"r\": 78, \"v\": \"PARVA\"}, {\"r\": 79, \"v\": \"PARVA\"}, {\"r\": 80, \"v\": \"RODRIGUEZ\"}, {\"r\": 81, \"v\": \"RODRIGUEZ\"}, {\"r\": 82, \"v\": \"ROUNSEVELLE\"}, {\"r\": 83, \"v\": \"SKANOS\"}, {\"r\": 84, \"v\": \"SKANOS\"}, {\"r\": 85, \"v\": \"TORRES\"}, {\"r\": 86, \"v\": \"TORRES\"}, {\"r\": 87, \"v\": \"VALDES\"}, {\"r\": 88, \"v\": \"VALDES\"}, {\"r\": 89, \"v\": \"VARGAS\"}, {\"r\": 90, \"v\": \"VARGAS\"}, {\"r\": 91, \"v\": \"VARGAS\"}, {\"r\": 92, \"v\": \"VARGAS\"}, {\"r\": 93, \"v\": \"WEBSTER\"}, {\"r\": 94, \"v\": \"WEBSTER\"}, {\"r\": 95, \"v\": \"WICZALKOWSKI\"}, {\"r\": 96, \"v\": \"WICZALKOWSKI\"}, {\"r\": 97, \"v\": \"BANK\"}, {\"r\": 98, \"v\": \"BANK\"}, {\"r\": 99, \"v\": \"BANK\"}, {\"r\": 100, \"v\": \"BANK\"}, {\"r\": 101, \"v\": \"BANK\"}, {\"r\": 102, \"v\": \"BARNES\"}, {\"r\": 103, \"v\": \"BARNES\"}, {\"r\": 104, \"v\": \"BURGERSS\"}, {\"r\": 105, \"v\": \"BURGERSS\"}, {\"r\": 106, \"v\": \"BURGERSS\"}, {\"r\": 107, \"v\": \"BURGESS\"}, {\"r\": 108, \"v\": \"BURGESS\"}, {\"r\": 109, \"v\": \"BURGESS\"}, {\"r\": 110, \"v\": \"BURGESS\"}, {\"r\": 111, \"v\": \"BURRISS\"}, {\"r\": 112, \"v\": \"BURRISS\"}, {\"r\": 113, \"v\": \"BURRISS\"}, {\"r\": 114, \"v\": \"BUTLER\"}, {\"r\": 115, \"v\": \"CHISOLM\"}, {\"r\": 116, \"v\": \"CHISOLM\"}, {\"r\": 117, \"v\": \"COATES\"}, {\"r\": 118, \"v\": \"CONRON\"}, {\"r\": 119, \"v\": \"COTTEN\"}, {\"r\": 120, \"v\": \"COTTEN\"}, {\"r\": 121, \"v\": \"COTTEN\"}, {\"r\": 122, \"v\": \"DIGGS\"}, {\"r\": 123, \"v\": \"DIGGS\"}, {\"r\": 124, \"v\": \"DORSIE\"}, {\"r\": 125, \"v\": \"DUNNOCK\"}, {\"r\": 126, \"v\": \"GOINS\"}, {\"r\": 127, \"v\": \"GOINS\"}, {\"r\": 128, \"v\": \"GOINS\"}, {\"r\": 129, \"v\": \"GOINS\"}, {\"r\": 130, \"v\": \"GOWANS\"}, {\"r\": 131, \"v\": \"GOWANS\"}, {\"r\": 132, \"v\": \"HOERRLING\"}, {\"r\": 133, \"v\": \"HOERRLING\"}, {\"r\": 134, \"v\": \"HOERRLING\"}, {\"r\": 135, \"v\": \"HOERRLING\"}, {\"r\": 136, \"v\": \"HOERRLING\"}, {\"r\": 137, \"v\": \"HOLMES\"}, {\"r\": 138, \"v\": \"HOLMES\"}, {\"r\": 139, \"v\": \"HOLMES\"}, {\"r\": 140, \"v\": \"HOLMES\"}, {\"r\": 141, \"v\": \"HOLMES\"}, {\"r\": 142, \"v\": \"HUGGINCHES\"}, {\"r\": 143, \"v\": \"HUGGINCHES\"}, {\"r\": 144, \"v\": \"HUGGINCHES\"}, {\"r\": 145, \"v\": \"HUGGINCHES\"}, {\"r\": 146, \"v\": \"HUTCHINSON\"}, {\"r\": 147, \"v\": \"HUTCHINSON\"}, {\"r\": 148, \"v\": \"HUTCHINSON\"}, {\"r\": 149, \"v\": \"HUTCHINSON\"}, {\"r\": 150, \"v\": \"LEVEN\"}, {\"r\": 151, \"v\": \"MATKIN\"}, {\"r\": 152, \"v\": \"MATKIN\"}, {\"r\": 153, \"v\": \"MATKIN\"}, {\"r\": 154, \"v\": \"MATKIN\"}, {\"r\": 155, \"v\": \"OWENS\"}, {\"r\": 156, \"v\": \"OWENS\"}, {\"r\": 157, \"v\": \"OWENS\"}, {\"r\": 158, \"v\": \"OWENS\"}, {\"r\": 159, \"v\": \"OWENS\"}, {\"r\": 160, \"v\": \"OWENS\"}, {\"r\": 161, \"v\": \"PAIGE\"}, {\"r\": 162, \"v\": \"SPRINGGS\"}, {\"r\": 163, \"v\": \"SYKES\"}, {\"r\": 164, \"v\": \"SYKES\"}, {\"r\": 165, \"v\": \"SYKES\"}, {\"r\": 166, \"v\": \"SYKES\"}, {\"r\": 167, \"v\": \"THOMPSON\"}, {\"r\": 168, \"v\": \"TREZEVANT\"}, {\"r\": 169, \"v\": \"TREZEVANT\"}, {\"r\": 170, \"v\": \"TREZEVANT\"}, {\"r\": 171, \"v\": \"WHITAKER\"}, {\"r\": 172, \"v\": \"WHITAKER\"}, {\"r\": 173, \"v\": \"WHITAKER\"}, {\"r\": 174, \"v\": \"WHITAKER\"}, {\"r\": 175, \"v\": \"1RUMOR\"}, {\"r\": 176, \"v\": \"1RUMOR\"}, {\"r\": 177, \"v\": \"1RUMOR\"}, {\"r\": 178, \"v\": \"1RUMOR\"}, {\"r\": 179, \"v\": \"1RUMOR\"}, {\"r\": 180, \"v\": \"ALSTIN\"}, {\"r\": 181, \"v\": \"ALSTIN\"}, {\"r\": 182, \"v\": \"ALSTIN\"}, {\"r\": 183, \"v\": \"CAMPBELL\"}, {\"r\": 184, \"v\": \"CAMPBELL\"}, {\"r\": 185, \"v\": \"CAMPBELL\"}, {\"r\": 186, \"v\": \"CAMPBELL\"}, {\"r\": 187, \"v\": \"CARR\"}, {\"r\": 188, \"v\": \"CARR\"}, {\"r\": 189, \"v\": \"CARR\"}, {\"r\": 190, \"v\": \"CARTER\"}, {\"r\": 191, \"v\": \"CARTER\"}, {\"r\": 192, \"v\": \"CAVAJEL\"}, {\"r\": 193, \"v\": \"CAVAJEL\"}, {\"r\": 194, \"v\": \"CAVAJEL\"}, {\"r\": 195, \"v\": \"CAVAJEL\"}, {\"r\": 196, \"v\": \"CHAMBARS\"}, {\"r\": 197, \"v\": \"CHAMBARS\"}, {\"r\": 198, \"v\": \"COLBY\"}, {\"r\": 199, \"v\": \"COUPE\"}, {\"r\": 200, \"v\": \"COUPE\"}, {\"r\": 201, \"v\": \"CRIDER\"}, {\"r\": 202, \"v\": \"CRIDER\"}, {\"r\": 203, \"v\": \"DAVIES\"}, {\"r\": 204, \"v\": \"DAVIES\"}, {\"r\": 205, \"v\": \"DAVIES\"}, {\"r\": 206, \"v\": \"DAVIES\"}, {\"r\": 207, \"v\": \"DEGRAENED\"}, {\"r\": 208, \"v\": \"DEGRAENED\"}, {\"r\": 209, \"v\": \"DORMAN\"}, {\"r\": 210, \"v\": \"DORMAN\"}, {\"r\": 211, \"v\": \"DORMAN\"}, {\"r\": 212, \"v\": \"DOWOKAKOKO\"}, {\"r\": 213, \"v\": \"DOWOKAKOKO\"}, {\"r\": 214, \"v\": \"DOWOKAKOKO\"}, {\"r\": 215, \"v\": \"EASLEY\"}, {\"r\": 216, \"v\": \"EASLEY\"}, {\"r\": 217, \"v\": \"EASLEY\"}, {\"r\": 218, \"v\": \"EASLEY\"}, {\"r\": 219, \"v\": \"ELLIOTT\"}, {\"r\": 220, \"v\": \"ELLIOTT\"}, {\"r\": 221, \"v\": \"ERVINE\"}, {\"r\": 222, \"v\": \"ERVINE\"}, {\"r\": 223, \"v\": \"ERVINE\"}, {\"r\": 224, \"v\": \"ERVINE\"}, {\"r\": 225, \"v\": \"FREY\"}, {\"r\": 226, \"v\": \"GARRETT\"}, {\"r\": 227, \"v\": \"GARRETT\"}, {\"r\": 228, \"v\": \"GORDON\"}, {\"r\": 229, \"v\": \"GORDON\"}, {\"r\": 230, \"v\": \"GORDON\"}, {\"r\": 231, \"v\": \"GRANER\"}, {\"r\": 232, \"v\": \"GRANER\"}, {\"r\": 233, \"v\": \"GRANER\"}, {\"r\": 234, \"v\": \"GREENE\"}, {\"r\": 235, \"v\": \"GREENE\"}, {\"r\": 236, \"v\": \"GREENE\"}, {\"r\": 237, \"v\": \"GREENE\"}, {\"r\": 238, \"v\": \"GREENE\"}, {\"r\": 239, \"v\": \"GUIDETI\"}, {\"r\": 240, \"v\": \"HAMMONDS\"}, {\"r\": 241, \"v\": \"HAMMONDS\"}, {\"r\": 242, \"v\": \"HAMMONDS\"}, {\"r\": 243, \"v\": \"HANKINS\"}, {\"r\": 244, \"v\": \"HANKINS\"}, {\"r\": 245, \"v\": \"HEAVENER\"}, {\"r\": 246, \"v\": \"HEAVENER\"}, {\"r\": 247, \"v\": \"HEAVENER\"}, {\"r\": 248, \"v\": \"HETTERICH\"}, {\"r\": 249, \"v\": \"HOLLEY\"}, {\"r\": 250, \"v\": \"HOLLEY\"}, {\"r\": 251, \"v\": \"HOLLEY\"}, {\"r\": 252, \"v\": \"HOLLEY\"}, {\"r\": 253, \"v\": \"HUDSON\"}, {\"r\": 254, \"v\": \"HUSSEINKHEL\"}, {\"r\": 255, \"v\": \"HUSSEINKHEL\"}, {\"r\": 256, \"v\": \"KEARNS\"}, {\"r\": 257, \"v\": \"KEARNS\"}, {\"r\": 258, \"v\": \"KEARNS\"}, {\"r\": 259, \"v\": \"KEARNS\"}, {\"r\": 260, \"v\": \"KEICHENBERG\"}, {\"r\": 261, \"v\": \"KEICHENBERG\"}, {\"r\": 262, \"v\": \"KLEIMAN\"}, {\"r\": 263, \"v\": \"KLEIMAN\"}, {\"r\": 264, \"v\": \"LESKO\"}, {\"r\": 265, \"v\": \"LESKO\"}, {\"r\": 266, \"v\": \"LESKO\"}, {\"r\": 267, \"v\": \"MACCIO\"}, {\"r\": 268, \"v\": \"MACCIO\"}, {\"r\": 269, \"v\": \"MARTINEZ STG\"}, {\"r\": 270, \"v\": \"MARTINEZ STG\"}, {\"r\": 271, \"v\": \"MARTINEZ STG\"}, {\"r\": 272, \"v\": \"MCALLISTER\"}, {\"r\": 273, \"v\": \"MCALLISTER\"}, {\"r\": 274, \"v\": \"MOHRING\"}, {\"r\": 275, \"v\": \"MOHRING\"}, {\"r\": 276, \"v\": \"MOSES\"}, {\"r\": 277, \"v\": \"OBROCK\"}, {\"r\": 278, \"v\": \"PEARL\"}, {\"r\": 279, \"v\": \"PEARL\"}, {\"r\": 280, \"v\": \"RAGLIN\"}, {\"r\": 281, \"v\": \"REAVES\"}, {\"r\": 282, \"v\": \"REAVES\"}, {\"r\": 283, \"v\": \"REAVES\"}, {\"r\": 284, \"v\": \"RODRIGUEZ\"}, {\"r\": 285, \"v\": \"RODRIGUEZ\"}, {\"r\": 286, \"v\": \"ROTHSHILD\"}, {\"r\": 287, \"v\": \"ROTHSHILD\"}, {\"r\": 288, \"v\": \"ROTHSHILD\"}, {\"r\": 289, \"v\": \"RUDASILL\"}, {\"r\": 290, \"v\": \"RUDASILL\"}, {\"r\": 291, \"v\": \"RUDASILL\"}, {\"r\": 292, \"v\": \"RUDASILL\"}, {\"r\": 293, \"v\": \"RUDASILL\"}, {\"r\": 294, \"v\": \"RUEHLING\"}, {\"r\": 295, \"v\": \"RUEHLING\"}, {\"r\": 296, \"v\": \"RUMOR\"}, {\"r\": 297, \"v\": \"RUSSALL\"}, {\"r\": 298, \"v\": \"RUSSALL\"}, {\"r\": 299, \"v\": \"RUSSALL\"}, {\"r\": 300, \"v\": \"SANTIAGO\"}, {\"r\": 301, \"v\": \"SANTIAGO\"}, {\"r\": 302, \"v\": \"SANTIAGO\"}, {\"r\": 303, \"v\": \"SANTIAGO\"}, {\"r\": 304, \"v\": \"SQUILLANTE\"}, {\"r\": 305, \"v\": \"SQUILLANTE\"}, {\"r\": 306, \"v\": \"SWAGOI\"}, {\"r\": 307, \"v\": \"SWAGOI\"}, {\"r\": 308, \"v\": \"SWAGOI\"}, {\"r\": 309, \"v\": \"SWAGOI\"}, {\"r\": 310, \"v\": \"SWAGOI\"}, {\"r\": 311, \"v\": \"SYKS\"}, {\"r\": 312, \"v\": \"TONSTALL\"}, {\"r\": 313, \"v\": \"TONSTALL\"}, {\"r\": 314, \"v\": \"TONSTALL\"}, {\"r\": 315, \"v\": \"WASHINGTON\"}, {\"r\": 316, \"v\": \"WASHINGTON\"}, {\"r\": 317, \"v\": \"WASHINGTON\"}, {\"r\": 318, \"v\": \"WASHINGTON\"}, {\"r\": 319, \"v\": \"WIESMAN\"}, {\"r\": 320, \"v\": \"BELL\"}, {\"r\": 321, \"v\": \"BRAWD\"}, {\"r\": 322, \"v\": \"BRAWD\"}, {\"r\": 323, \"v\": \"CARTER\"}, {\"r\": 324, \"v\": \"DUCOTY\"}, {\"r\": 325, \"v\": \"DUCOTY\"}, {\"r\": 326, \"v\": \"DUFFY TYLER\"}, {\"r\": 327, \"v\": \"DUFFY TYLER\"}, {\"r\": 328, \"v\": \"DUFFY TYLER\"}, {\"r\": 329, \"v\": \"DUFFY TYLER\"}, {\"r\": 330, \"v\": \"DUFFY TYLER\"}, {\"r\": 331, \"v\": \"DUFFY TYLER\"}, {\"r\": 332, \"v\": \"EHM\"}, {\"r\": 333, \"v\": \"EHM\"}, {\"r\": 334, \"v\": \"EHM\"}, {\"r\": 335, \"v\": \"GASBARRO\"}, {\"r\": 336, \"v\": \"GASBARRO\"}, {\"r\": 337, \"v\": \"GASBARRO\"}, {\"r\": 338, \"v\": \"GASBARRO\"}, {\"r\": 339, \"v\": \"GASBARRO\"}, {\"r\": 340, \"v\": \"HELLER\"}, {\"r\": 341, \"v\": \"HELLER\"}, {\"r\": 342, \"v\": \"HELLER\"}, {\"r\": 343, \"v\": \"HELLER\"}, {\"r\": 344, \"v\": \"HELLER\"}, {\"r\": 345, \"v\": \"HELLER\"}, {\"r\": 346, \"v\": \"HOPPER\"}, {\"r\": 347, \"v\": \"HOPPER\"}, {\"r\": 348, \"v\": \"HOPPER\"}, {\"r\": 349, \"v\": \"HUBRIC\"}, {\"r\": 350, \"v\": \"HUBRIC\"}, {\"r\": 351, \"v\": \"PAINE WELLS\"}, {\"r\": 352, \"v\": \"PAINE WELLS\"}, {\"r\": 353, \"v\": \"PAINE WELLS\"}, {\"r\": 354, \"v\": \"PAINE WELLS\"}, {\"r\": 355, \"v\": \"PAINE WELLS\"}, {\"r\": 356, \"v\": \"PENSETH\"}, {\"r\": 357, \"v\": \"PENSETH\"}, {\"r\": 358, \"v\": \"PENSETH\"}, {\"r\": 359, \"v\": \"POLLACK\"}, {\"r\": 360, \"v\": \"POLLACK\"}, {\"r\": 361, \"v\": \"POLLACK\"}, {\"r\": 362, \"v\": \"POLLACK\"}, {\"r\": 363, \"v\": \"POLLACK\"}, {\"r\": 364, \"v\": \"POLLACK\"}, {\"r\": 365, \"v\": \"ROWEN\"}, {\"r\": 366, \"v\": \"ROWEN\"}, {\"r\": 367, \"v\": \"ROWEN\"}, {\"r\": 368, \"v\": \"ROWEN\"}, {\"r\": 369, \"v\": \"SAUNDERS\"}, {\"r\": 370, \"v\": \"SAUNDERS\"}, {\"r\": 371, \"v\": \"SCCHWARTZ\"}, {\"r\": 372, \"v\": \"SCCHWARTZ\"}, {\"r\": 373, \"v\": \"SMALLS\"}, {\"r\": 374, \"v\": \"SMALLS\"}, {\"r\": 375, \"v\": \"SMALLS\"}, {\"r\": 376, \"v\": \"SMALLS\"}, {\"r\": 377, \"v\": \"ARCHER\"}, {\"r\": 378, \"v\": \"ARCHER\"}, {\"r\": 379, \"v\": \"BELTRAN\"}, {\"r\": 380, \"v\": \"BELTRAN\"}, {\"r\": 381, \"v\": \"BELTRAN\"}, {\"r\": 382, \"v\": \"BELTRAN\"}, {\"r\": 383, \"v\": \"BELTRAN\"}, {\"r\": 384, \"v\": \"BELTRAN\"}, {\"r\": 385, \"v\": \"BELTRAN\"}, {\"r\": 386, \"v\": \"CAGER\"}, {\"r\": 387, \"v\": \"CAGER\"}, {\"r\": 388, \"v\": \"CAGER\"}, {\"r\": 389, \"v\": \"COBEZA\"}, {\"r\": 390, \"v\": \"COBEZA\"}, {\"r\": 391, \"v\": \"COBEZA\"}, {\"r\": 392, \"v\": \"COBEZA\"}, {\"r\": 393, \"v\": \"DORSEY\"}, {\"r\": 394, \"v\": \"DORSEY\"}, {\"r\": 395, \"v\": \"DORSEY\"}, {\"r\": 396, \"v\": \"DORSEY\"}, {\"r\": 397, \"v\": \"DRENMON\"}, {\"r\": 398, \"v\": \"DRENMON\"}, {\"r\": 399, \"v\": \"DRENMON\"}, {\"r\": 400, \"v\": \"FLEEK\"}, {\"r\": 401, \"v\": \"FLEEK\"}, {\"r\": 402, \"v\": \"FLOWERS\"}, {\"r\": 403, \"v\": \"FLOWERS\"}, {\"r\": 404, \"v\": \"GALIDEZ\"}, {\"r\": 405, \"v\": \"GALIDEZ\"}, {\"r\": 406, \"v\": \"GALIDEZ\"}, {\"r\": 407, \"v\": \"GALIDEZ\"}, {\"r\": 408, \"v\": \"HILLEGAS\"}, {\"r\": 409, \"v\": \"HILLEGAS\"}, {\"r\": 410, \"v\": \"HILLEGAS\"}, {\"r\": 411, \"v\": \"HILLEGAS\"}, {\"r\": 412, \"v\": \"HILLEGAS\"}, {\"r\": 413, \"v\": \"HOLLOWAY\"}, {\"r\": 414, \"v\": \"HOLLOWAY\"}, {\"r\": 415, \"v\": \"KEARNEY\"}, {\"r\": 416, \"v\": \"KEARNEY\"}, {\"r\": 417, \"v\": \"KEARNEY\"}, {\"r\": 418, \"v\": \"MANGUM\"}, {\"r\": 419, \"v\": \"MANGUM\"}, {\"r\": 420, \"v\": \"MITCHELLL\"}, {\"r\": 421, \"v\": \"MITCHELLL\"}, {\"r\": 422, \"v\": \"RADRIGZ\"}, {\"r\": 423, \"v\": \"RADRIGZ\"}, {\"r\": 424, \"v\": \"RAMAS\"}, {\"r\": 425, \"v\": \"RHODES\"}, {\"r\": 426, \"v\": \"RHODES\"}, {\"r\": 427, \"v\": \"RHODES\"}, {\"r\": 428, \"v\": \"RHODES\"}, {\"r\": 429, \"v\": \"RIBERA\"}, {\"r\": 430, \"v\": \"RIBERA\"}, {\"r\": 431, \"v\": \"RICHARDSON\"}, {\"r\": 432, \"v\": \"RICHARDSON\"}, {\"r\": 433, \"v\": \"STAPPY\"}, {\"r\": 434, \"v\": \"STAPPY\"}, {\"r\": 435, \"v\": \"STAPPY\"}, {\"r\": 436, \"v\": \"STAPPY\"}, {\"r\": 437, \"v\": \"STAPPY\"}, {\"r\": 438, \"v\": \"STEWARD\"}, {\"r\": 439, \"v\": \"STEWARD\"}, {\"r\": 440, \"v\": \"WCIGNT\"}, {\"r\": 441, \"v\": \"WCIGNT\"}, {\"r\": 442, \"v\": \"WILKES\"}, {\"r\": 443, \"v\": \"WILKES\"}, {\"r\": 444, \"v\": \"WILKES\"}, {\"r\": 445, \"v\": \"WILLIAMS\"}, {\"r\": 446, \"v\": \"WILLIAMS\"}, {\"r\": 447, \"v\": \"YETES\"}, {\"r\": 448, \"v\": \"YETES\"}]}'),(28,'da_NAME',NULL,1,449,'{\"valori\": [{\"r\": 0, \"v\": \"\"}, {\"r\": 1, \"v\": \"\"}, {\"r\": 2, \"v\": \"\"}, {\"r\": 3, \"v\": \"\"}, {\"r\": 4, \"v\": \"CLARA\"}, {\"r\": 5, \"v\": \"LEARONAD\"}, {\"r\": 6, \"v\": \"SAMUEL\"}, {\"r\": 7, \"v\": \"DELORES\"}, {\"r\": 8, \"v\": \"JAMEL\"}, {\"r\": 9, \"v\": \"ROSETTA\"}, {\"r\": 10, \"v\": \"MADGE\"}, {\"r\": 11, \"v\": \"ROSALIND\"}, {\"r\": 12, \"v\": \"CAROLYN\"}, {\"r\": 13, \"v\": \"IVAN\"}, {\"r\": 14, \"v\": \"RAMON\"}, {\"r\": 15, \"v\": \"ALICIA\"}, {\"r\": 16, \"v\": \"DONYA\"}, {\"r\": 17, \"v\": \"DONTE\"}, {\"r\": 18, \"v\": \"DOMINIQUE\"}, {\"r\": 19, \"v\": \"CONNIE\"}, {\"r\": 20, \"v\": \"SEKOV\"}, {\"r\": 21, \"v\": \"TIERRA\"}, {\"r\": 22, \"v\": \"THERSA\"}, {\"r\": 23, \"v\": \"\"}, {\"r\": 24, \"v\": \"\"}, {\"r\": 25, \"v\": \"SAMMY\"}, {\"r\": 26, \"v\": \"THAOLYNN\"}, {\"r\": 27, \"v\": \"\"}, {\"r\": 28, \"v\": \"MICHEAL\"}, {\"r\": 29, \"v\": \"AJASIA\"}, {\"r\": 30, \"v\": \"BRIANCE\"}, {\"r\": 31, \"v\": \"MILEORD\"}, {\"r\": 32, \"v\": \"FRANKLIN\"}, {\"r\": 33, \"v\": \"SHAVON\"}, {\"r\": 34, \"v\": \"ANNA\"}, {\"r\": 35, \"v\": \"WESTLEY\"}, {\"r\": 36, \"v\": \"NADESDIA\"}, {\"r\": 37, \"v\": \"DANYCE\"}, {\"r\": 38, \"v\": \"MICHAEL\"}, {\"r\": 39, \"v\": \"CASSANDRA\"}, {\"r\": 40, \"v\": \"GHOLOM\"}, {\"r\": 41, \"v\": \"JEFFERY\"}, {\"r\": 42, \"v\": \"JEFFERY\"}, {\"r\": 43, \"v\": \"DOUGLAS\"}, {\"r\": 44, \"v\": \"MAIRE\"}, {\"r\": 45, \"v\": \"TEMPESTT\"}, {\"r\": 46, \"v\": \"\"}, {\"r\": 47, \"v\": \"\"}, {\"r\": 48, \"v\": \"\"}, {\"r\": 49, \"v\": \"RAYMOND\"}, {\"r\": 50, \"v\": \"IRVIN\"}, {\"r\": 51, \"v\": \"AUNDERE\"}, {\"r\": 52, \"v\": \"WILLPAMINA\"}, {\"r\": 53, \"v\": \"BARBARA\"}, {\"r\": 54, \"v\": \"\"}, {\"r\": 55, \"v\": \"\"}, {\"r\": 56, \"v\": \"JORGE\"}, {\"r\": 57, \"v\": \"TONYA\"}, {\"r\": 58, \"v\": \"DANEILLE\"}, {\"r\": 59, \"v\": \"\"}, {\"r\": 60, \"v\": \"\"}, {\"r\": 61, \"v\": \"DOROTHEA\"}, {\"r\": 62, \"v\": \"LELIA\"}, {\"r\": 63, \"v\": \"JOSEPH\"}, {\"r\": 64, \"v\": \"DEWIGHT\"}, {\"r\": 65, \"v\": \"MARQUISE\"}, {\"r\": 66, \"v\": \"MABLE\"}, {\"r\": 67, \"v\": \"\"}, {\"r\": 68, \"v\": \"\"}, {\"r\": 69, \"v\": \"\"}, {\"r\": 70, \"v\": \"AISHA\"}, {\"r\": 71, \"v\": \"ANDREA\"}, {\"r\": 72, \"v\": \"ROMINE\"}, {\"r\": 73, \"v\": \"TANYA\"}, {\"r\": 74, \"v\": \"PRINCETTA\"}, {\"r\": 75, \"v\": \"LAKESHIA\"}, {\"r\": 76, \"v\": \"HERMEN\"}, {\"r\": 77, \"v\": \"XANTHE\"}, {\"r\": 78, \"v\": \"JEMES\"}, {\"r\": 79, \"v\": \"\"}, {\"r\": 80, \"v\": \"TOWANDA\"}, {\"r\": 81, \"v\": \"GEARLDINE\"}, {\"r\": 82, \"v\": \"DEREK\"}, {\"r\": 83, \"v\": \"DAVON\"}, {\"r\": 84, \"v\": \"LENORA\"}, {\"r\": 85, \"v\": \"RANDOLPH\"}, {\"r\": 86, \"v\": \"FREEMAN\"}, {\"r\": 87, \"v\": \"WAYNE\"}, {\"r\": 88, \"v\": \"THRESA\"}, {\"r\": 89, \"v\": \"BRANDEN\"}, {\"r\": 90, \"v\": \"ALEXANDER\"}, {\"r\": 91, \"v\": \"ELIZABETH\"}, {\"r\": 92, \"v\": \"THUYKIM\"}, {\"r\": 93, \"v\": \"DANNY\"}, {\"r\": 94, \"v\": \"SHALLY\"}, {\"r\": 95, \"v\": \"ALEXANDER\"}, {\"r\": 96, \"v\": \"DOLORES\"}, {\"r\": 97, \"v\": \"\"}, {\"r\": 98, \"v\": \"\"}, {\"r\": 99, \"v\": \"\"}, {\"r\": 100, \"v\": \"\"}, {\"r\": 101, \"v\": \"\"}, {\"r\": 102, \"v\": \"\"}, {\"r\": 103, \"v\": \"\"}, {\"r\": 104, \"v\": \"\"}, {\"r\": 105, \"v\": \"\"}, {\"r\": 106, \"v\": \"\"}, {\"r\": 107, \"v\": \"\"}, {\"r\": 108, \"v\": \"\"}, {\"r\": 109, \"v\": \"\"}, {\"r\": 110, \"v\": \"\"}, {\"r\": 111, \"v\": \"\"}, {\"r\": 112, \"v\": \"\"}, {\"r\": 113, \"v\": \"\"}, {\"r\": 114, \"v\": \"\"}, {\"r\": 115, \"v\": \"\"}, {\"r\": 116, \"v\": \"\"}, {\"r\": 117, \"v\": \"\"}, {\"r\": 118, \"v\": \"LATISHA\"}, {\"r\": 119, \"v\": \"\"}, {\"r\": 120, \"v\": \"\"}, {\"r\": 121, \"v\": \"\"}, {\"r\": 122, \"v\": \"\"}, {\"r\": 123, \"v\": \"\"}, {\"r\": 124, \"v\": \"\"}, {\"r\": 125, \"v\": \"\"}, {\"r\": 126, \"v\": \"\"}, {\"r\": 127, \"v\": \"\"}, {\"r\": 128, \"v\": \"\"}, {\"r\": 129, \"v\": \"\"}, {\"r\": 130, \"v\": \"\"}, {\"r\": 131, \"v\": \"\"}, {\"r\": 132, \"v\": \"REFUS\"}, {\"r\": 133, \"v\": \"CHRISTOPHER\"}, {\"r\": 134, \"v\": \"ZACHARY\"}, {\"r\": 135, \"v\": \"TRAINA\"}, {\"r\": 136, \"v\": \"ANA\"}, {\"r\": 137, \"v\": \"GERALDO\"}, {\"r\": 138, \"v\": \"FRANCISCO\"}, {\"r\": 139, \"v\": \"ERICK\"}, {\"r\": 140, \"v\": \"LUCILLE\"}, {\"r\": 141, \"v\": \"\"}, {\"r\": 142, \"v\": \"\"}, {\"r\": 143, \"v\": \"\"}, {\"r\": 144, \"v\": \"\"}, {\"r\": 145, \"v\": \"\"}, {\"r\": 146, \"v\": \"\"}, {\"r\": 147, \"v\": \"\"}, {\"r\": 148, \"v\": \"\"}, {\"r\": 149, \"v\": \"\"}, {\"r\": 150, \"v\": \"\"}, {\"r\": 151, \"v\": \"\"}, {\"r\": 152, \"v\": \"\"}, {\"r\": 153, \"v\": \"\"}, {\"r\": 154, \"v\": \"\"}, {\"r\": 155, \"v\": \"\"}, {\"r\": 156, \"v\": \"\"}, {\"r\": 157, \"v\": \"\"}, {\"r\": 158, \"v\": \"\"}, {\"r\": 159, \"v\": \"\"}, {\"r\": 160, \"v\": \"\"}, {\"r\": 161, \"v\": \"\"}, {\"r\": 162, \"v\": \"ROY\"}, {\"r\": 163, \"v\": \"\"}, {\"r\": 164, \"v\": \"\"}, {\"r\": 165, \"v\": \"\"}, {\"r\": 166, \"v\": \"\"}, {\"r\": 167, \"v\": \"ROSETTA\"}, {\"r\": 168, \"v\": \"JACQUELINE\"}, {\"r\": 169, \"v\": \"ANA\"}, {\"r\": 170, \"v\": \"\"}, {\"r\": 171, \"v\": \"\"}, {\"r\": 172, \"v\": \"\"}, {\"r\": 173, \"v\": \"\"}, {\"r\": 174, \"v\": \"\"}, {\"r\": 175, \"v\": \"DIWALDO\"}, {\"r\": 176, \"v\": \"BERNADINA\"}, {\"r\": 177, \"v\": \"TERRAN\"}, {\"r\": 178, \"v\": \"ZAKIYA\"}, {\"r\": 179, \"v\": \"\"}, {\"r\": 180, \"v\": \"LEO\"}, {\"r\": 181, \"v\": \"MICHEAL\"}, {\"r\": 182, \"v\": \"ROSE\"}, {\"r\": 183, \"v\": \"ANTONINO\"}, {\"r\": 184, \"v\": \"JESSICA\"}, {\"r\": 185, \"v\": \"MARINELA\"}, {\"r\": 186, \"v\": \"\"}, {\"r\": 187, \"v\": \"DARRYL\"}, {\"r\": 188, \"v\": \"BERRY\"}, {\"r\": 189, \"v\": \"ROSELINE\"}, {\"r\": 190, \"v\": \"RODRICK\"}, {\"r\": 191, \"v\": \"JOANNIE\"}, {\"r\": 192, \"v\": \"ADMAN\"}, {\"r\": 193, \"v\": \"STEPHEN\"}, {\"r\": 194, \"v\": \"MALISSA\"}, {\"r\": 195, \"v\": \"SARAH\"}, {\"r\": 196, \"v\": \"LAWRENCE\"}, {\"r\": 197, \"v\": \"EUGENE\"}, {\"r\": 198, \"v\": \"\"}, {\"r\": 199, \"v\": \"MARKO\"}, {\"r\": 200, \"v\": \"\"}, {\"r\": 201, \"v\": \"GUILLERMO\"}, {\"r\": 202, \"v\": \"MARCO\"}, {\"r\": 203, \"v\": \"W\"}, {\"r\": 204, \"v\": \"MICHELE\"}, {\"r\": 205, \"v\": \"RENEE\"}, {\"r\": 206, \"v\": \"SARAH\"}, {\"r\": 207, \"v\": \"GERARDO\"}, {\"r\": 208, \"v\": \"ALLAN\"}, {\"r\": 209, \"v\": \"\"}, {\"r\": 210, \"v\": \"\"}, {\"r\": 211, \"v\": \"\"}, {\"r\": 212, \"v\": \"GREG\"}, {\"r\": 213, \"v\": \"A\"}, {\"r\": 214, \"v\": \"\"}, {\"r\": 215, \"v\": \"MATTHEW\"}, {\"r\": 216, \"v\": \"FLORIPE\"}, {\"r\": 217, \"v\": \"KERI\"}, {\"r\": 218, \"v\": \"NILSA\"}, {\"r\": 219, \"v\": \"CHERYL\"}, {\"r\": 220, \"v\": \"FLAINE\"}, {\"r\": 221, \"v\": \"ALE JARDRO\"}, {\"r\": 222, \"v\": \"JUAN\"}, {\"r\": 223, \"v\": \"ZIONARA\"}, {\"r\": 224, \"v\": \"\"}, {\"r\": 225, \"v\": \"ETHNY\"}, {\"r\": 226, \"v\": \"SHAWNETT\"}, {\"r\": 227, \"v\": \"HARRIET\"}, {\"r\": 228, \"v\": \"KRISTY\"}, {\"r\": 229, \"v\": \"DIANE\"}, {\"r\": 230, \"v\": \"ROSEMARIE\"}, {\"r\": 231, \"v\": \"DANIEL\"}, {\"r\": 232, \"v\": \"ROBERT\"}, {\"r\": 233, \"v\": \"MARJORIE\"}, {\"r\": 234, \"v\": \"EDUARDSO\"}, {\"r\": 235, \"v\": \"SONDRA\"}, {\"r\": 236, \"v\": \"ANN\"}, {\"r\": 237, \"v\": \"MICHELE\"}, {\"r\": 238, \"v\": \"ROSETA\"}, {\"r\": 239, \"v\": \"\"}, {\"r\": 240, \"v\": \"JAMES\"}, {\"r\": 241, \"v\": \"LENWOOD\"}, {\"r\": 242, \"v\": \"TRACEY\"}, {\"r\": 243, \"v\": \"STEPHENE\"}, {\"r\": 244, \"v\": \"PAYMM\"}, {\"r\": 245, \"v\": \"\"}, {\"r\": 246, \"v\": \"\"}, {\"r\": 247, \"v\": \"\"}, {\"r\": 248, \"v\": \"JOHNNY\"}, {\"r\": 249, \"v\": \"MICHEAL\"}, {\"r\": 250, \"v\": \"DIMON\"}, {\"r\": 251, \"v\": \"KATHERINE\"}, {\"r\": 252, \"v\": \"CHARLOTTE\"}, {\"r\": 253, \"v\": \"JACQUELINE\"}, {\"r\": 254, \"v\": \"ARCHIE\"}, {\"r\": 255, \"v\": \"\"}, {\"r\": 256, \"v\": \"\"}, {\"r\": 257, \"v\": \"\"}, {\"r\": 258, \"v\": \"\"}, {\"r\": 259, \"v\": \"\"}, {\"r\": 260, \"v\": \"SUSAN\"}, {\"r\": 261, \"v\": \"JUDY\"}, {\"r\": 262, \"v\": \"ANTONIO\"}, {\"r\": 263, \"v\": \"JOCELYN\"}, {\"r\": 264, \"v\": \"CLEARANCE\"}, {\"r\": 265, \"v\": \"BEN\"}, {\"r\": 266, \"v\": \"\"}, {\"r\": 267, \"v\": \"ORESTE\"}, {\"r\": 268, \"v\": \"OLIVIA\"}, {\"r\": 269, \"v\": \"ERIKA\"}, {\"r\": 270, \"v\": \"\"}, {\"r\": 271, \"v\": \"\"}, {\"r\": 272, \"v\": \"GEOFFREY\"}, {\"r\": 273, \"v\": \"JEANETTE\"}, {\"r\": 274, \"v\": \"DOMINIQUE\"}, {\"r\": 275, \"v\": \"JANICE\"}, {\"r\": 276, \"v\": \"SHIRLEG\"}, {\"r\": 277, \"v\": \"\"}, {\"r\": 278, \"v\": \"\"}, {\"r\": 279, \"v\": \"\"}, {\"r\": 280, \"v\": \"REYAN\"}, {\"r\": 281, \"v\": \"\"}, {\"r\": 282, \"v\": \"\"}, {\"r\": 283, \"v\": \"\"}, {\"r\": 284, \"v\": \"QUENTIN\"}, {\"r\": 285, \"v\": \"STEPHANIE\"}, {\"r\": 286, \"v\": \"PHILLIP\"}, {\"r\": 287, \"v\": \"J\"}, {\"r\": 288, \"v\": \"HILLIARD\"}, {\"r\": 289, \"v\": \"DOMINIC\"}, {\"r\": 290, \"v\": \"SEPTIMIA\"}, {\"r\": 291, \"v\": \"KIMBERLY\"}, {\"r\": 292, \"v\": \"ALISA\"}, {\"r\": 293, \"v\": \"\"}, {\"r\": 294, \"v\": \"TRACIE\"}, {\"r\": 295, \"v\": \"MELISSA\"}, {\"r\": 296, \"v\": \"\"}, {\"r\": 297, \"v\": \"MYRIAM\"}, {\"r\": 298, \"v\": \"JORGE\"}, {\"r\": 299, \"v\": \"LYNNETTE\"}, {\"r\": 300, \"v\": \"PELHAM\"}, {\"r\": 301, \"v\": \"GEORGE\"}, {\"r\": 302, \"v\": \"ANGELA\"}, {\"r\": 303, \"v\": \"JESSEE\"}, {\"r\": 304, \"v\": \"LUIS\"}, {\"r\": 305, \"v\": \"GERAR\"}, {\"r\": 306, \"v\": \"CHARLES\"}, {\"r\": 307, \"v\": \"ISRAEL\"}, {\"r\": 308, \"v\": \"MARY CAROLE\"}, {\"r\": 309, \"v\": \"\"}, {\"r\": 310, \"v\": \"\"}, {\"r\": 311, \"v\": \"KATHERINE\"}, {\"r\": 312, \"v\": \"NICHOLE\"}, {\"r\": 313, \"v\": \"MARY\"}, {\"r\": 314, \"v\": \"HARRIETT\"}, {\"r\": 315, \"v\": \"J\"}, {\"r\": 316, \"v\": \"STEPHENS\"}, {\"r\": 317, \"v\": \"AMAURY\"}, {\"r\": 318, \"v\": \"XIOMARA\"}, {\"r\": 319, \"v\": \"\"}, {\"r\": 320, \"v\": \"GLORIANNE\"}, {\"r\": 321, \"v\": \"ALLEN\"}, {\"r\": 322, \"v\": \"ANN0\"}, {\"r\": 323, \"v\": \"JEAN\"}, {\"r\": 324, \"v\": \"DOUGASS\"}, {\"r\": 325, \"v\": \"MICLELLE\"}, {\"r\": 326, \"v\": \"L\"}, {\"r\": 327, \"v\": \"D\"}, {\"r\": 328, \"v\": \"BENJAMIN\"}, {\"r\": 329, \"v\": \"ALICIA\"}, {\"r\": 330, \"v\": \"GERALDENE\"}, {\"r\": 331, \"v\": \"NATSHA\"}, {\"r\": 332, \"v\": \"JESUS\"}, {\"r\": 333, \"v\": \"ETHEL\"}, {\"r\": 334, \"v\": \"\"}, {\"r\": 335, \"v\": \"PABLOS\"}, {\"r\": 336, \"v\": \"LEANNE\"}, {\"r\": 337, \"v\": \"ERIN\"}, {\"r\": 338, \"v\": \"JO\"}, {\"r\": 339, \"v\": \"\"}, {\"r\": 340, \"v\": \"DIXION\"}, {\"r\": 341, \"v\": \"DOREN\"}, {\"r\": 342, \"v\": \"TEGIRA\"}, {\"r\": 343, \"v\": \"AGELEON\"}, {\"r\": 344, \"v\": \"\"}, {\"r\": 345, \"v\": \"\"}, {\"r\": 346, \"v\": \"ARISTIDES\"}, {\"r\": 347, \"v\": \"CARLOS\"}, {\"r\": 348, \"v\": \"ROSEY\"}, {\"r\": 349, \"v\": \"CHARLES\"}, {\"r\": 350, \"v\": \"DIANE\"}, {\"r\": 351, \"v\": \"SIGFREDO\"}, {\"r\": 352, \"v\": \"AGEL\"}, {\"r\": 353, \"v\": \"OSWALDO\"}, {\"r\": 354, \"v\": \"IGNACIO\"}, {\"r\": 355, \"v\": \"BARBARA\"}, {\"r\": 356, \"v\": \"JEFFREY\"}, {\"r\": 357, \"v\": \"THRESA\"}, {\"r\": 358, \"v\": \"ANNE\"}, {\"r\": 359, \"v\": \"ANDREW E\"}, {\"r\": 360, \"v\": \"JAMAR\"}, {\"r\": 361, \"v\": \"DARON\"}, {\"r\": 362, \"v\": \"SHAWN\"}, {\"r\": 363, \"v\": \"MIRIAM\"}, {\"r\": 364, \"v\": \"LEAH\"}, {\"r\": 365, \"v\": \"CHRISTOPHER\"}, {\"r\": 366, \"v\": \"EARNEST\"}, {\"r\": 367, \"v\": \"CATHY\"}, {\"r\": 368, \"v\": \"ELFRIEDA\"}, {\"r\": 369, \"v\": \"NICOLAS\"}, {\"r\": 370, \"v\": \"CATHERINE\"}, {\"r\": 371, \"v\": \"JOHN\"}, {\"r\": 372, \"v\": \"TRICIA\"}, {\"r\": 373, \"v\": \"JEFFREY\"}, {\"r\": 374, \"v\": \"INGER\"}, {\"r\": 375, \"v\": \"\"}, {\"r\": 376, \"v\": \"\"}, {\"r\": 377, \"v\": \"MARC\"}, {\"r\": 378, \"v\": \"JEAN\"}, {\"r\": 379, \"v\": \"LAWRENCE\"}, {\"r\": 380, \"v\": \"JEFF\"}, {\"r\": 381, \"v\": \"SOUTA\"}, {\"r\": 382, \"v\": \"ELMER\"}, {\"r\": 383, \"v\": \"WILEY\"}, {\"r\": 384, \"v\": \"GISELA\"}, {\"r\": 385, \"v\": \"RUTH ANN\"}, {\"r\": 386, \"v\": \"EDWIN\"}, {\"r\": 387, \"v\": \"EARLE\"}, {\"r\": 388, \"v\": \"ROSETTA\"}, {\"r\": 389, \"v\": \"RONNIE\"}, {\"r\": 390, \"v\": \"KENNETH\"}, {\"r\": 391, \"v\": \"SHAWN\"}, {\"r\": 392, \"v\": \"\"}, {\"r\": 393, \"v\": \"ARY\"}, {\"r\": 394, \"v\": \"MELISSA\"}, {\"r\": 395, \"v\": \"DEBBIE\"}, {\"r\": 396, \"v\": \"ENDA\"}, {\"r\": 397, \"v\": \"ISSAC\"}, {\"r\": 398, \"v\": \"ERNEST\"}, {\"r\": 399, \"v\": \"THERESA\"}, {\"r\": 400, \"v\": \"JOANNIE\"}, {\"r\": 401, \"v\": \"ANNTIONETTE\"}, {\"r\": 402, \"v\": \"STANLY\"}, {\"r\": 403, \"v\": \"COVNELIA\"}, {\"r\": 404, \"v\": \"KEN\"}, {\"r\": 405, \"v\": \"ENZELEE\"}, {\"r\": 406, \"v\": \"MICHELLE\"}, {\"r\": 407, \"v\": \"CHATERAH\"}, {\"r\": 408, \"v\": \"GIANNI\"}, {\"r\": 409, \"v\": \"JANICE\"}, {\"r\": 410, \"v\": \"HAILLE\"}, {\"r\": 411, \"v\": \"ROSA\"}, {\"r\": 412, \"v\": \"JAMIE\"}, {\"r\": 413, \"v\": \"SCOT\"}, {\"r\": 414, \"v\": \"JENIFFER\"}, {\"r\": 415, \"v\": \"SHANIKA\"}, {\"r\": 416, \"v\": \"ASHELY\"}, {\"r\": 417, \"v\": \"SHERMISE\"}, {\"r\": 418, \"v\": \"ROB\"}, {\"r\": 419, \"v\": \"BAKIA\"}, {\"r\": 420, \"v\": \"JEROME\"}, {\"r\": 421, \"v\": \"DONETTA\"}, {\"r\": 422, \"v\": \"JOSH\"}, {\"r\": 423, \"v\": \"RUGY\"}, {\"r\": 424, \"v\": \"SONJA\"}, {\"r\": 425, \"v\": \"JEFF\"}, {\"r\": 426, \"v\": \"HENRIETTE\"}, {\"r\": 427, \"v\": \"JANNIE\"}, {\"r\": 428, \"v\": \"JOANN\"}, {\"r\": 429, \"v\": \"JOHONNY\"}, {\"r\": 430, \"v\": \"STUART\"}, {\"r\": 431, \"v\": \"EMMETTE\"}, {\"r\": 432, \"v\": \"TAMIKA\"}, {\"r\": 433, \"v\": \"JEFF\"}, {\"r\": 434, \"v\": \"FRANKLIN\"}, {\"r\": 435, \"v\": \"ELLA LOUISE\"}, {\"r\": 436, \"v\": \"QUAYN\"}, {\"r\": 437, \"v\": \"ARLIE\"}, {\"r\": 438, \"v\": \"FREDERICK\"}, {\"r\": 439, \"v\": \"CHANTEL\"}, {\"r\": 440, \"v\": \"BRIAN\"}, {\"r\": 441, \"v\": \"MAXICINE\"}, {\"r\": 442, \"v\": \"BEN\"}, {\"r\": 443, \"v\": \"STEVE\"}, {\"r\": 444, \"v\": \"HARRIETTE\"}, {\"r\": 445, \"v\": \"CHARLIE\"}, {\"r\": 446, \"v\": \"SHERRI\"}, {\"r\": 447, \"v\": \"CHANCE\"}, {\"r\": 448, \"v\": \"ALFREDRICK\"}]}'),(29,'db_SURNAME',NULL,1,392,'{\"valori\": [{\"r\": 0, \"v\": \"AHREWS\"}, {\"r\": 1, \"v\": \"AHREWS\"}, {\"r\": 2, \"v\": \"BENETAS\"}, {\"r\": 3, \"v\": \"BENETAS\"}, {\"r\": 4, \"v\": \"BENETAS\"}, {\"r\": 5, \"v\": \"BODMER\"}, {\"r\": 6, \"v\": \"BODMER\"}, {\"r\": 7, \"v\": \"BODMER\"}, {\"r\": 8, \"v\": \"BODMER\"}, {\"r\": 9, \"v\": \"BODMER\"}, {\"r\": 10, \"v\": \"CETO\"}, {\"r\": 11, \"v\": \"CHEESEMAN\"}, {\"r\": 12, \"v\": \"CHEESEMAN\"}, {\"r\": 13, \"v\": \"CONNER\"}, {\"r\": 14, \"v\": \"CONNER\"}, {\"r\": 15, \"v\": \"COSGRAOE\"}, {\"r\": 16, \"v\": \"COSGRAOE\"}, {\"r\": 17, \"v\": \"COSGRAOE\"}, {\"r\": 18, \"v\": \"DACANAY\"}, {\"r\": 19, \"v\": \"DACANAY\"}, {\"r\": 20, \"v\": \"DACANAY\"}, {\"r\": 21, \"v\": \"DANIEL-LEIVA\"}, {\"r\": 22, \"v\": \"DANIEL-LEIVA\"}, {\"r\": 23, \"v\": \"DIVER\"}, {\"r\": 24, \"v\": \"DOMINQUEZ\"}, {\"r\": 25, \"v\": \"DOMINQUEZ\"}, {\"r\": 26, \"v\": \"ENGELSKIRCH\"}, {\"r\": 27, \"v\": \"ENGELSKIRCH\"}, {\"r\": 28, \"v\": \"FAIRIE\"}, {\"r\": 29, \"v\": \"FISCHARUND\"}, {\"r\": 30, \"v\": \"FISCHARUND\"}, {\"r\": 31, \"v\": \"FISCHARUND\"}, {\"r\": 32, \"v\": \"GECKLE\"}, {\"r\": 33, \"v\": \"GECKLE\"}, {\"r\": 34, \"v\": \"GERING\"}, {\"r\": 35, \"v\": \"GERINGER\"}, {\"r\": 36, \"v\": \"GERINGER\"}, {\"r\": 37, \"v\": \"GERINGER\"}, {\"r\": 38, \"v\": \"GERINGER\"}, {\"r\": 39, \"v\": \"GERINGER\"}, {\"r\": 40, \"v\": \"GLICK\"}, {\"r\": 41, \"v\": \"GREENE\"}, {\"r\": 42, \"v\": \"HALL\"}, {\"r\": 43, \"v\": \"HILLION\"}, {\"r\": 44, \"v\": \"JEANS\"}, {\"r\": 45, \"v\": \"JEANS\"}, {\"r\": 46, \"v\": \"JEANS\"}, {\"r\": 47, \"v\": \"JIMEMEZ\"}, {\"r\": 48, \"v\": \"JIMEMEZ\"}, {\"r\": 49, \"v\": \"JIMENEZ\"}, {\"r\": 50, \"v\": \"JIMENEZ\"}, {\"r\": 51, \"v\": \"JIMENEZ\"}, {\"r\": 52, \"v\": \"KELLEY\"}, {\"r\": 53, \"v\": \"LAKHTOSH\"}, {\"r\": 54, \"v\": \"LAKHTOSH\"}, {\"r\": 55, \"v\": \"LASITTER\"}, {\"r\": 56, \"v\": \"LASITTER\"}, {\"r\": 57, \"v\": \"MALDONABO\"}, {\"r\": 58, \"v\": \"MALDONABO\"}, {\"r\": 59, \"v\": \"MALDONABO\"}, {\"r\": 60, \"v\": \"MORGAN\"}, {\"r\": 61, \"v\": \"MORGAN\"}, {\"r\": 62, \"v\": \"MOSGERA\"}, {\"r\": 63, \"v\": \"MOSGUERA\"}, {\"r\": 64, \"v\": \"MOSGUERA\"}, {\"r\": 65, \"v\": \"MOSGUERA\"}, {\"r\": 66, \"v\": \"MOSGUERA\"}, {\"r\": 67, \"v\": \"MOSGUERA\"}, {\"r\": 68, \"v\": \"MOSGUERA\"}, {\"r\": 69, \"v\": \"OQUENDO\"}, {\"r\": 70, \"v\": \"PAIGE\"}, {\"r\": 71, \"v\": \"PARRA\"}, {\"r\": 72, \"v\": \"RAUST\"}, {\"r\": 73, \"v\": \"RODREQUE\"}, {\"r\": 74, \"v\": \"RODREQUE\"}, {\"r\": 75, \"v\": \"ROUNSVELLE\"}, {\"r\": 76, \"v\": \"SENTRY\"}, {\"r\": 77, \"v\": \"SENTRY\"}, {\"r\": 78, \"v\": \"SENTRY\"}, {\"r\": 79, \"v\": \"SHANKS\"}, {\"r\": 80, \"v\": \"SHANKS\"}, {\"r\": 81, \"v\": \"TORRIS\"}, {\"r\": 82, \"v\": \"TORRIS\"}, {\"r\": 83, \"v\": \"VALDEZ\"}, {\"r\": 84, \"v\": \"VALDEZ\"}, {\"r\": 85, \"v\": \"VARGAS MUNOZ\"}, {\"r\": 86, \"v\": \"VARGAS-HERNAN\"}, {\"r\": 87, \"v\": \"VARGAS-HERNAN\"}, {\"r\": 88, \"v\": \"VARGAS-HERNAN\"}, {\"r\": 89, \"v\": \"WESTERN\"}, {\"r\": 90, \"v\": \"WESTERN\"}, {\"r\": 91, \"v\": \"WIZALKOWSKI\"}, {\"r\": 92, \"v\": \"WIZALKOWSKI\"}, {\"r\": 93, \"v\": \"CANNON\"}, {\"r\": 94, \"v\": \"DORSER\"}, {\"r\": 95, \"v\": \"HOERNING\"}, {\"r\": 96, \"v\": \"HOERNING\"}, {\"r\": 97, \"v\": \"HOERNING\"}, {\"r\": 98, \"v\": \"HOERNING\"}, {\"r\": 99, \"v\": \"HOERNING\"}, {\"r\": 100, \"v\": \"JOHNS\"}, {\"r\": 101, \"v\": \"JOHNS\"}, {\"r\": 102, \"v\": \"JOLMES\"}, {\"r\": 103, \"v\": \"JOLMES\"}, {\"r\": 104, \"v\": \"JOLMES\"}, {\"r\": 105, \"v\": \"JOLMES\"}, {\"r\": 106, \"v\": \"KENNY\"}, {\"r\": 107, \"v\": \"SPRIGGS\"}, {\"r\": 108, \"v\": \"TREAEVANT\"}, {\"r\": 109, \"v\": \"TREAEVANT\"}, {\"r\": 110, \"v\": \"ALSTON\"}, {\"r\": 111, \"v\": \"ALSTON\"}, {\"r\": 112, \"v\": \"ALSTON\"}, {\"r\": 113, \"v\": \"BARRETT\"}, {\"r\": 114, \"v\": \"BARRETT\"}, {\"r\": 115, \"v\": \"CAMBLE\"}, {\"r\": 116, \"v\": \"CAMBLE\"}, {\"r\": 117, \"v\": \"CAMBLE\"}, {\"r\": 118, \"v\": \"CARL\"}, {\"r\": 119, \"v\": \"CARL\"}, {\"r\": 120, \"v\": \"CARL\"}, {\"r\": 121, \"v\": \"CARTIER\"}, {\"r\": 122, \"v\": \"CARTIER\"}, {\"r\": 123, \"v\": \"CARVAJAL\"}, {\"r\": 124, \"v\": \"CARVAJAL\"}, {\"r\": 125, \"v\": \"CARVAJAL\"}, {\"r\": 126, \"v\": \"CARVAJAL\"}, {\"r\": 127, \"v\": \"CHAMBERS\"}, {\"r\": 128, \"v\": \"CHAMBERS\"}, {\"r\": 129, \"v\": \"COBY\"}, {\"r\": 130, \"v\": \"COBY\"}, {\"r\": 131, \"v\": \"COBY\"}, {\"r\": 132, \"v\": \"COBY\"}, {\"r\": 133, \"v\": \"CRIBER\"}, {\"r\": 134, \"v\": \"CRIBER\"}, {\"r\": 135, \"v\": \"DAVIS\"}, {\"r\": 136, \"v\": \"DAVIS\"}, {\"r\": 137, \"v\": \"DAVIS\"}, {\"r\": 138, \"v\": \"DAVIS\"}, {\"r\": 139, \"v\": \"DEGRAGENRIED\"}, {\"r\": 140, \"v\": \"DEGRAGENRIED\"}, {\"r\": 141, \"v\": \"DICKERSON\"}, {\"r\": 142, \"v\": \"EASELY\"}, {\"r\": 143, \"v\": \"EASELY\"}, {\"r\": 144, \"v\": \"EASELY\"}, {\"r\": 145, \"v\": \"EASELY\"}, {\"r\": 146, \"v\": \"ELLICATT-KEAN\"}, {\"r\": 147, \"v\": \"ELLICATT-KEAN\"}, {\"r\": 148, \"v\": \"FOSTER\"}, {\"r\": 149, \"v\": \"FRY\"}, {\"r\": 150, \"v\": \"GARNER\"}, {\"r\": 151, \"v\": \"GARNER\"}, {\"r\": 152, \"v\": \"GARNER\"}, {\"r\": 153, \"v\": \"GARRET\"}, {\"r\": 154, \"v\": \"GARRET\"}, {\"r\": 155, \"v\": \"GORODN\"}, {\"r\": 156, \"v\": \"GORODN\"}, {\"r\": 157, \"v\": \"GORODN\"}, {\"r\": 158, \"v\": \"GREEN\"}, {\"r\": 159, \"v\": \"GREEN\"}, {\"r\": 160, \"v\": \"GREEN\"}, {\"r\": 161, \"v\": \"GREEN\"}, {\"r\": 162, \"v\": \"GREEN\"}, {\"r\": 163, \"v\": \"HACHETT\"}, {\"r\": 164, \"v\": \"HACHETT\"}, {\"r\": 165, \"v\": \"HACHETT\"}, {\"r\": 166, \"v\": \"HACHETT\"}, {\"r\": 167, \"v\": \"HAMMOND\"}, {\"r\": 168, \"v\": \"HAMMOND\"}, {\"r\": 169, \"v\": \"HAMMOND\"}, {\"r\": 170, \"v\": \"HASKINS\"}, {\"r\": 171, \"v\": \"HASKINS\"}, {\"r\": 172, \"v\": \"HEAVAENER\"}, {\"r\": 173, \"v\": \"HEAVAENER\"}, {\"r\": 174, \"v\": \"HEAVAENER\"}, {\"r\": 175, \"v\": \"HENRIKSON\"}, {\"r\": 176, \"v\": \"HENRIKSON\"}, {\"r\": 177, \"v\": \"HENRIKSON\"}, {\"r\": 178, \"v\": \"HENRIKSON\"}, {\"r\": 179, \"v\": \"HENRIKSON\"}, {\"r\": 180, \"v\": \"HOLLY\"}, {\"r\": 181, \"v\": \"HOLLY\"}, {\"r\": 182, \"v\": \"HOLLY\"}, {\"r\": 183, \"v\": \"HOLLY\"}, {\"r\": 184, \"v\": \"HOSHINGTON\"}, {\"r\": 185, \"v\": \"HOSHINGTON\"}, {\"r\": 186, \"v\": \"HOSHINGTON\"}, {\"r\": 187, \"v\": \"HOSHINGTON\"}, {\"r\": 188, \"v\": \"HULLEY\"}, {\"r\": 189, \"v\": \"HULLEY\"}, {\"r\": 190, \"v\": \"HUSSEINKEL\"}, {\"r\": 191, \"v\": \"HUTSON\"}, {\"r\": 192, \"v\": \"IRVIN\"}, {\"r\": 193, \"v\": \"IRVIN\"}, {\"r\": 194, \"v\": \"IRVIN\"}, {\"r\": 195, \"v\": \"KLEINMAN\"}, {\"r\": 196, \"v\": \"KLEINMAN\"}, {\"r\": 197, \"v\": \"KOUPE\"}, {\"r\": 198, \"v\": \"KUMOR\"}, {\"r\": 199, \"v\": \"KUMOR\"}, {\"r\": 200, \"v\": \"KUMOR\"}, {\"r\": 201, \"v\": \"KUMOR\"}, {\"r\": 202, \"v\": \"KUMOR\"}, {\"r\": 203, \"v\": \"KUMOR\"}, {\"r\": 204, \"v\": \"LESCO\"}, {\"r\": 205, \"v\": \"LESCO\"}, {\"r\": 206, \"v\": \"MARTINEZ\"}, {\"r\": 207, \"v\": \"MATEO\"}, {\"r\": 208, \"v\": \"MATEO\"}, {\"r\": 209, \"v\": \"MATEO\"}, {\"r\": 210, \"v\": \"MATEO\"}, {\"r\": 211, \"v\": \"MCALISTER\"}, {\"r\": 212, \"v\": \"MCALISTER\"}, {\"r\": 213, \"v\": \"MITCHELL\"}, {\"r\": 214, \"v\": \"MOHRINA\"}, {\"r\": 215, \"v\": \"MOHRINA\"}, {\"r\": 216, \"v\": \"MOSER\"}, {\"r\": 217, \"v\": \"MUCCIO\"}, {\"r\": 218, \"v\": \"MUCCIO\"}, {\"r\": 219, \"v\": \"OLOWOKAKOKO\"}, {\"r\": 220, \"v\": \"OLOWOKAKOKO\"}, {\"r\": 221, \"v\": \"PARK\"}, {\"r\": 222, \"v\": \"PARK\"}, {\"r\": 223, \"v\": \"PETTRICH\"}, {\"r\": 224, \"v\": \"REEVES\"}, {\"r\": 225, \"v\": \"REEVES\"}, {\"r\": 226, \"v\": \"REEVES\"}, {\"r\": 227, \"v\": \"REICHENBERG\"}, {\"r\": 228, \"v\": \"REICHENBERG\"}, {\"r\": 229, \"v\": \"RODRIGUES\"}, {\"r\": 230, \"v\": \"RODRIGUES\"}, {\"r\": 231, \"v\": \"ROGLIN\"}, {\"r\": 232, \"v\": \"ROTHCHILD\"}, {\"r\": 233, \"v\": \"ROTHCHILD\"}, {\"r\": 234, \"v\": \"ROTHCHILD\"}, {\"r\": 235, \"v\": \"RUDAGILL\"}, {\"r\": 236, \"v\": \"RUDAGILL\"}, {\"r\": 237, \"v\": \"RUDAGILL\"}, {\"r\": 238, \"v\": \"RUDAGILL\"}, {\"r\": 239, \"v\": \"RUIHLING\"}, {\"r\": 240, \"v\": \"RUIHLING\"}, {\"r\": 241, \"v\": \"RUSSELL\"}, {\"r\": 242, \"v\": \"RUSSELL\"}, {\"r\": 243, \"v\": \"RUSSELL\"}, {\"r\": 244, \"v\": \"SHAWQI\"}, {\"r\": 245, \"v\": \"SHAWQI\"}, {\"r\": 246, \"v\": \"SHAWQI\"}, {\"r\": 247, \"v\": \"SINEFIELD\"}, {\"r\": 248, \"v\": \"SOLLIVAN\"}, {\"r\": 249, \"v\": \"SOLLIVAN\"}, {\"r\": 250, \"v\": \"SOLLIVAN\"}, {\"r\": 251, \"v\": \"SQUILLANGE\"}, {\"r\": 252, \"v\": \"SQUILLANGE\"}, {\"r\": 253, \"v\": \"SYKES\"}, {\"r\": 254, \"v\": \"TUNSTALL\"}, {\"r\": 255, \"v\": \"TUNSTALL\"}, {\"r\": 256, \"v\": \"TUNSTALL\"}, {\"r\": 257, \"v\": \"BRAND\"}, {\"r\": 258, \"v\": \"BRAND\"}, {\"r\": 259, \"v\": \"CARTE\"}, {\"r\": 260, \"v\": \"DAVID\"}, {\"r\": 261, \"v\": \"DAVID\"}, {\"r\": 262, \"v\": \"DOCUTY\"}, {\"r\": 263, \"v\": \"DOCUTY\"}, {\"r\": 264, \"v\": \"DUFFY-TYLER\"}, {\"r\": 265, \"v\": \"DUFFY-TYLER\"}, {\"r\": 266, \"v\": \"DUFFY-TYLER\"}, {\"r\": 267, \"v\": \"DUFFY-TYLER\"}, {\"r\": 268, \"v\": \"DUFFY-TYLER\"}, {\"r\": 269, \"v\": \"DUFFY-TYLER\"}, {\"r\": 270, \"v\": \"ELM\"}, {\"r\": 271, \"v\": \"ELM\"}, {\"r\": 272, \"v\": \"FENSTER-PENNE\"}, {\"r\": 273, \"v\": \"GASBARRD\"}, {\"r\": 274, \"v\": \"GASBARRD\"}, {\"r\": 275, \"v\": \"GASBARRD\"}, {\"r\": 276, \"v\": \"GASBARRD\"}, {\"r\": 277, \"v\": \"GEHRING\"}, {\"r\": 278, \"v\": \"HACKER\"}, {\"r\": 279, \"v\": \"HACKER\"}, {\"r\": 280, \"v\": \"HALLORAW\"}, {\"r\": 281, \"v\": \"HELER\"}, {\"r\": 282, \"v\": \"HELER\"}, {\"r\": 283, \"v\": \"HELER\"}, {\"r\": 284, \"v\": \"HELER\"}, {\"r\": 285, \"v\": \"HOOPER\"}, {\"r\": 286, \"v\": \"HOOPER\"}, {\"r\": 287, \"v\": \"HOOPER\"}, {\"r\": 288, \"v\": \"HUBRICK\"}, {\"r\": 289, \"v\": \"HUBRICK\"}, {\"r\": 290, \"v\": \"PAINE-WELLS\"}, {\"r\": 291, \"v\": \"PAINE-WELLS\"}, {\"r\": 292, \"v\": \"PAINE-WELLS\"}, {\"r\": 293, \"v\": \"PAINE-WELLS\"}, {\"r\": 294, \"v\": \"PAINE-WELLS\"}, {\"r\": 295, \"v\": \"PENSMITH\"}, {\"r\": 296, \"v\": \"PENSMITH\"}, {\"r\": 297, \"v\": \"PENSMITH\"}, {\"r\": 298, \"v\": \"POLLOCK\"}, {\"r\": 299, \"v\": \"POLLOCK\"}, {\"r\": 300, \"v\": \"POLLOCK\"}, {\"r\": 301, \"v\": \"POLLOCK\"}, {\"r\": 302, \"v\": \"POLLOCK\"}, {\"r\": 303, \"v\": \"POLLOCK\"}, {\"r\": 304, \"v\": \"REEVER\"}, {\"r\": 305, \"v\": \"ROWAN\"}, {\"r\": 306, \"v\": \"ROWAN\"}, {\"r\": 307, \"v\": \"ROWAN\"}, {\"r\": 308, \"v\": \"ROWAN\"}, {\"r\": 309, \"v\": \"SANDERS\"}, {\"r\": 310, \"v\": \"SANDERS\"}, {\"r\": 311, \"v\": \"SCHWARTZ\"}, {\"r\": 312, \"v\": \"SCHWARTZ\"}, {\"r\": 313, \"v\": \"SMALL\"}, {\"r\": 314, \"v\": \"SMALL\"}, {\"r\": 315, \"v\": \"VELL\"}, {\"r\": 316, \"v\": \"ARCHBR\"}, {\"r\": 317, \"v\": \"ARCHBR\"}, {\"r\": 318, \"v\": \"BELTAN\"}, {\"r\": 319, \"v\": \"BELTAN\"}, {\"r\": 320, \"v\": \"BELTAN\"}, {\"r\": 321, \"v\": \"BELTAN\"}, {\"r\": 322, \"v\": \"BETRAN\"}, {\"r\": 323, \"v\": \"BETRAN\"}, {\"r\": 324, \"v\": \"BETRAN\"}, {\"r\": 325, \"v\": \"COGER\"}, {\"r\": 326, \"v\": \"COGER\"}, {\"r\": 327, \"v\": \"COGER\"}, {\"r\": 328, \"v\": \"DORSLY\"}, {\"r\": 329, \"v\": \"DORSLY\"}, {\"r\": 330, \"v\": \"DORSLY\"}, {\"r\": 331, \"v\": \"DORSLY\"}, {\"r\": 332, \"v\": \"DRENNON\"}, {\"r\": 333, \"v\": \"DRENNON\"}, {\"r\": 334, \"v\": \"DRENNON\"}, {\"r\": 335, \"v\": \"FLEET\"}, {\"r\": 336, \"v\": \"FLEET\"}, {\"r\": 337, \"v\": \"FLOWER\"}, {\"r\": 338, \"v\": \"FLOWER\"}, {\"r\": 339, \"v\": \"GALINDE\"}, {\"r\": 340, \"v\": \"GALINDE\"}, {\"r\": 341, \"v\": \"GALINDE\"}, {\"r\": 342, \"v\": \"GALINDE\"}, {\"r\": 343, \"v\": \"HILLEGASS\"}, {\"r\": 344, \"v\": \"HILLEGASS\"}, {\"r\": 345, \"v\": \"HILLEGASS\"}, {\"r\": 346, \"v\": \"HILLEGASS\"}, {\"r\": 347, \"v\": \"HILLEGASS\"}, {\"r\": 348, \"v\": \"HULLOWAY\"}, {\"r\": 349, \"v\": \"HULLOWAY\"}, {\"r\": 350, \"v\": \"JONES\"}, {\"r\": 351, \"v\": \"JONES\"}, {\"r\": 352, \"v\": \"JONES\"}, {\"r\": 353, \"v\": \"KABEZA\"}, {\"r\": 354, \"v\": \"KABEZA\"}, {\"r\": 355, \"v\": \"KABEZA\"}, {\"r\": 356, \"v\": \"KEARNAY\"}, {\"r\": 357, \"v\": \"KEARNAY\"}, {\"r\": 358, \"v\": \"KEARNAY\"}, {\"r\": 359, \"v\": \"MASLIN\"}, {\"r\": 360, \"v\": \"MITCHELL\"}, {\"r\": 361, \"v\": \"MITCHELL\"}, {\"r\": 362, \"v\": \"MONGUM\"}, {\"r\": 363, \"v\": \"MONGUM\"}, {\"r\": 364, \"v\": \"RAMOS\"}, {\"r\": 365, \"v\": \"RHOADS\"}, {\"r\": 366, \"v\": \"RHOADS\"}, {\"r\": 367, \"v\": \"RHOADS\"}, {\"r\": 368, \"v\": \"RHOADS\"}, {\"r\": 369, \"v\": \"RICHARDSONIII\"}, {\"r\": 370, \"v\": \"RICHARDSONIII\"}, {\"r\": 371, \"v\": \"RIVERA\"}, {\"r\": 372, \"v\": \"RIVERA\"}, {\"r\": 373, \"v\": \"RODRIGUEZ\"}, {\"r\": 374, \"v\": \"RODRIGUEZ\"}, {\"r\": 375, \"v\": \"SPINWATO\"}, {\"r\": 376, \"v\": \"STEWART\"}, {\"r\": 377, \"v\": \"STEWART\"}, {\"r\": 378, \"v\": \"STOPPY\"}, {\"r\": 379, \"v\": \"STOPPY\"}, {\"r\": 380, \"v\": \"STOPPY\"}, {\"r\": 381, \"v\": \"STOPPY\"}, {\"r\": 382, \"v\": \"STOPPY\"}, {\"r\": 383, \"v\": \"WILKS\"}, {\"r\": 384, \"v\": \"WILKS\"}, {\"r\": 385, \"v\": \"WILKS\"}, {\"r\": 386, \"v\": \"WILLIAM\"}, {\"r\": 387, \"v\": \"WILLIAM\"}, {\"r\": 388, \"v\": \"WRIGHT\"}, {\"r\": 389, \"v\": \"WRIGHT\"}, {\"r\": 390, \"v\": \"YATES\"}, {\"r\": 391, \"v\": \"YATES\"}]}'),(30,'db_NAME',NULL,1,392,'{\"valori\": [{\"r\": 0, \"v\": \"MARITZA\"}, {\"r\": 1, \"v\": \"MARIANNA\"}, {\"r\": 2, \"v\": \"LENARD\"}, {\"r\": 3, \"v\": \"SAMMY\"}, {\"r\": 4, \"v\": \"DOLORES\"}, {\"r\": 5, \"v\": \"JAMAR\"}, {\"r\": 6, \"v\": \"ROSSITA\"}, {\"r\": 7, \"v\": \"MAG\"}, {\"r\": 8, \"v\": \"ROZELLIN\"}, {\"r\": 9, \"v\": \"CATHERINE\"}, {\"r\": 10, \"v\": \"J\"}, {\"r\": 11, \"v\": \"DANYA\"}, {\"r\": 12, \"v\": \"DANTE\"}, {\"r\": 13, \"v\": \"DOMINQUE\"}, {\"r\": 14, \"v\": \"COHNIE\"}, {\"r\": 15, \"v\": \"SEKOU\"}, {\"r\": 16, \"v\": \"TREIRA\"}, {\"r\": 17, \"v\": \"THERESA\"}, {\"r\": 18, \"v\": \"MICHAEL\"}, {\"r\": 19, \"v\": \"A JASIA\"}, {\"r\": 20, \"v\": \"BRIANCA\"}, {\"r\": 21, \"v\": \"SAM\"}, {\"r\": 22, \"v\": \"THAU LYNN\"}, {\"r\": 23, \"v\": \"MILFORD\"}, {\"r\": 24, \"v\": \"FRANK\"}, {\"r\": 25, \"v\": \"SHAVAN\"}, {\"r\": 26, \"v\": \"ISAAE\"}, {\"r\": 27, \"v\": \"JEANELLE\"}, {\"r\": 28, \"v\": \"LOUIS\"}, {\"r\": 29, \"v\": \"WESLEY\"}, {\"r\": 30, \"v\": \"NADESHIA\"}, {\"r\": 31, \"v\": \"DANYELLE\"}, {\"r\": 32, \"v\": \"RUNEE\"}, {\"r\": 33, \"v\": \"RALPAL\"}, {\"r\": 34, \"v\": \"RROBERT\"}, {\"r\": 35, \"v\": \"GHOLAN\"}, {\"r\": 36, \"v\": \"JEFFREY\"}, {\"r\": 37, \"v\": \"JEFFREY\"}, {\"r\": 38, \"v\": \"DOUGLASS\"}, {\"r\": 39, \"v\": \"MARIE\"}, {\"r\": 40, \"v\": \"NATHANIAL\"}, {\"r\": 41, \"v\": \"TEMPEST\"}, {\"r\": 42, \"v\": \"RAYMON\"}, {\"r\": 43, \"v\": \"GEORGE\"}, {\"r\": 44, \"v\": \"KEYAN\"}, {\"r\": 45, \"v\": \"MICHEAL\"}, {\"r\": 46, \"v\": \"CASANDRA\"}, {\"r\": 47, \"v\": \"SANDERA\"}, {\"r\": 48, \"v\": \"BARBRA\"}, {\"r\": 49, \"v\": \"IRWIN\"}, {\"r\": 50, \"v\": \"ANDRE\"}, {\"r\": 51, \"v\": \"WILHEMENIA\"}, {\"r\": 52, \"v\": \"FREDRICK\"}, {\"r\": 53, \"v\": \"TONY\"}, {\"r\": 54, \"v\": \"DANIELLE\"}, {\"r\": 55, \"v\": \"DORATHEA\"}, {\"r\": 56, \"v\": \"LELA\"}, {\"r\": 57, \"v\": \"DWIGHT\"}, {\"r\": 58, \"v\": \"MARQUIS\"}, {\"r\": 59, \"v\": \"MABEL\"}, {\"r\": 60, \"v\": \"DARYL\"}, {\"r\": 61, \"v\": \"KEVEIN\"}, {\"r\": 62, \"v\": \"HERMAN\"}, {\"r\": 63, \"v\": \"IASHA\"}, {\"r\": 64, \"v\": \"ANDRE\"}, {\"r\": 65, \"v\": \"ROMAINE\"}, {\"r\": 66, \"v\": \"TAWYA\"}, {\"r\": 67, \"v\": \"PRINCETTE\"}, {\"r\": 68, \"v\": \"KEISHA\"}, {\"r\": 69, \"v\": \"CLAIRE\"}, {\"r\": 70, \"v\": \"XANTHA\"}, {\"r\": 71, \"v\": \"JEMOS\"}, {\"r\": 72, \"v\": \"ANN\"}, {\"r\": 73, \"v\": \"TAWANA\"}, {\"r\": 74, \"v\": \"GERALDINE\"}, {\"r\": 75, \"v\": \"DERRICK\"}, {\"r\": 76, \"v\": \"IRAN\"}, {\"r\": 77, \"v\": \"RAYMOND\"}, {\"r\": 78, \"v\": \"ALLICIA\"}, {\"r\": 79, \"v\": \"DAVONE\"}, {\"r\": 80, \"v\": \"LONORA\"}, {\"r\": 81, \"v\": \"RANDOLFF\"}, {\"r\": 82, \"v\": \"FREMAN\"}, {\"r\": 83, \"v\": \"WYANE\"}, {\"r\": 84, \"v\": \"THERESA\"}, {\"r\": 85, \"v\": \"THUY KIM\"}, {\"r\": 86, \"v\": \"BRANDON\"}, {\"r\": 87, \"v\": \"ALEXANDE\"}, {\"r\": 88, \"v\": \"ELIZBETH\"}, {\"r\": 89, \"v\": \"DONNY\"}, {\"r\": 90, \"v\": \"SALLY\"}, {\"r\": 91, \"v\": \"ALEXDER\"}, {\"r\": 92, \"v\": \"DELORES\"}, {\"r\": 93, \"v\": \"LATESHA\"}, {\"r\": 94, \"v\": \"KATHY\"}, {\"r\": 95, \"v\": \"RUFUS\"}, {\"r\": 96, \"v\": \"CHISTOPHER\"}, {\"r\": 97, \"v\": \"ZACNARY\"}, {\"r\": 98, \"v\": \"TRINA\"}, {\"r\": 99, \"v\": \"ANNA\"}, {\"r\": 100, \"v\": \"STEPHEN\"}, {\"r\": 101, \"v\": \"GLURIA\"}, {\"r\": 102, \"v\": \"GERARDO\"}, {\"r\": 103, \"v\": \"FRANCISO\"}, {\"r\": 104, \"v\": \"ERIK\"}, {\"r\": 105, \"v\": \"LUCILE\"}, {\"r\": 106, \"v\": \"DANYAE\"}, {\"r\": 107, \"v\": \"RAY\"}, {\"r\": 108, \"v\": \"JACKIE\"}, {\"r\": 109, \"v\": \"ANNA\"}, {\"r\": 110, \"v\": \"LED\"}, {\"r\": 111, \"v\": \"MICHAEL\"}, {\"r\": 112, \"v\": \"ROSEMARY\"}, {\"r\": 113, \"v\": \"KENDALL\"}, {\"r\": 114, \"v\": \"YUNAISY\"}, {\"r\": 115, \"v\": \"ANTOIENO\"}, {\"r\": 116, \"v\": \"JESSICIA\"}, {\"r\": 117, \"v\": \"MARNELA\"}, {\"r\": 118, \"v\": \"DERRYL\"}, {\"r\": 119, \"v\": \"BARRY\"}, {\"r\": 120, \"v\": \"ROSELIME\"}, {\"r\": 121, \"v\": \"RODERICK\"}, {\"r\": 122, \"v\": \"JOAN\"}, {\"r\": 123, \"v\": \"ADRIAN\"}, {\"r\": 124, \"v\": \"STEVEN\"}, {\"r\": 125, \"v\": \"MILISSA\"}, {\"r\": 126, \"v\": \"SARA\"}, {\"r\": 127, \"v\": \"LAURENCE\"}, {\"r\": 128, \"v\": \"EUGENIO\"}, {\"r\": 129, \"v\": \"MIKE\"}, {\"r\": 130, \"v\": \"WILIAMS\"}, {\"r\": 131, \"v\": \"ANGELA\"}, {\"r\": 132, \"v\": \"LASHIWN\"}, {\"r\": 133, \"v\": \"GOILLERMO\"}, {\"r\": 134, \"v\": \"MARCOS\"}, {\"r\": 135, \"v\": \"WINDY\"}, {\"r\": 136, \"v\": \"MICHELLE\"}, {\"r\": 137, \"v\": \"RENNE\"}, {\"r\": 138, \"v\": \"SARA\"}, {\"r\": 139, \"v\": \"JERARDO\"}, {\"r\": 140, \"v\": \"ALLEN\"}, {\"r\": 141, \"v\": \"MARY LOU\"}, {\"r\": 142, \"v\": \"MATHEW\"}, {\"r\": 143, \"v\": \"FLORY\"}, {\"r\": 144, \"v\": \"KERRY\"}, {\"r\": 145, \"v\": \"NILSAIVETTE\"}, {\"r\": 146, \"v\": \"SHERYL\"}, {\"r\": 147, \"v\": \"ELAINE\"}, {\"r\": 148, \"v\": \"MARYANN\"}, {\"r\": 149, \"v\": \"EPHNY\"}, {\"r\": 150, \"v\": \"DANNY\"}, {\"r\": 151, \"v\": \"ROBERTO\"}, {\"r\": 152, \"v\": \"MAJORIE\"}, {\"r\": 153, \"v\": \"SHARNETT\"}, {\"r\": 154, \"v\": \"HARRET\"}, {\"r\": 155, \"v\": \"KRISTY LEIGH\"}, {\"r\": 156, \"v\": \"DIANE MARIE\"}, {\"r\": 157, \"v\": \"ROSE MARIE\"}, {\"r\": 158, \"v\": \"EDVARDO\"}, {\"r\": 159, \"v\": \"SANDRA\"}, {\"r\": 160, \"v\": \"ANNE\"}, {\"r\": 161, \"v\": \"MICHELLE\"}, {\"r\": 162, \"v\": \"ROSETTE\"}, {\"r\": 163, \"v\": \"CORTE\"}, {\"r\": 164, \"v\": \"DENARIO\"}, {\"r\": 165, \"v\": \"EYVETTE\"}, {\"r\": 166, \"v\": \"ALISA\"}, {\"r\": 167, \"v\": \"JOAMES\"}, {\"r\": 168, \"v\": \"LENWOOD REV\"}, {\"r\": 169, \"v\": \"TRACI\"}, {\"r\": 170, \"v\": \"STEFAN\"}, {\"r\": 171, \"v\": \"PAMELA\"}, {\"r\": 172, \"v\": \"FLORRE\"}, {\"r\": 173, \"v\": \"JEFFREY\"}, {\"r\": 174, \"v\": \"WILSREVO\"}, {\"r\": 175, \"v\": \"SAMIAR\"}, {\"r\": 176, \"v\": \"SAMANTHA\"}, {\"r\": 177, \"v\": \"DOROTHEA\"}, {\"r\": 178, \"v\": \"DONNA MARIE\"}, {\"r\": 179, \"v\": \"PHYLLIS\"}, {\"r\": 180, \"v\": \"MICHAEL\"}, {\"r\": 181, \"v\": \"DAMOEN\"}, {\"r\": 182, \"v\": \"CATHRINE\"}, {\"r\": 183, \"v\": \"CHARCOTTE\"}, {\"r\": 184, \"v\": \"JEFFREY\"}, {\"r\": 185, \"v\": \"STEVEN\"}, {\"r\": 186, \"v\": \"MAURI\"}, {\"r\": 187, \"v\": \"XLONARA\"}, {\"r\": 188, \"v\": \"ANTHONY\"}, {\"r\": 189, \"v\": \"DIANE\"}, {\"r\": 190, \"v\": \"ARCHIBALD\"}, {\"r\": 191, \"v\": \"JACQUELIN\"}, {\"r\": 192, \"v\": \"ALEJANDRO\"}, {\"r\": 193, \"v\": \"IVAN\"}, {\"r\": 194, \"v\": \"ZIONAIRE\"}, {\"r\": 195, \"v\": \"ANTONIA\"}, {\"r\": 196, \"v\": \"JOSLYN\"}, {\"r\": 197, \"v\": \"MARCO\"}, {\"r\": 198, \"v\": \"DINWARDO\"}, {\"r\": 199, \"v\": \"BERNADINE\"}, {\"r\": 200, \"v\": \"TERRENCE\"}, {\"r\": 201, \"v\": \"ZAKAYA\"}, {\"r\": 202, \"v\": \"DAGOBERTO\"}, {\"r\": 203, \"v\": \"CORRINE\"}, {\"r\": 204, \"v\": \"CLARENCE\"}, {\"r\": 205, \"v\": \"BAN\"}, {\"r\": 206, \"v\": \"ERICA\"}, {\"r\": 207, \"v\": \"DELHAM\"}, {\"r\": 208, \"v\": \"GEORGE DR\"}, {\"r\": 209, \"v\": \"ANGLA\"}, {\"r\": 210, \"v\": \"JESSE\"}, {\"r\": 211, \"v\": \"GEOFFRY\"}, {\"r\": 212, \"v\": \"JANETT\"}, {\"r\": 213, \"v\": \"THE IMA\"}, {\"r\": 214, \"v\": \"DOMINIC\"}, {\"r\": 215, \"v\": \"JANIS\"}, {\"r\": 216, \"v\": \"SHIRLEY\"}, {\"r\": 217, \"v\": \"ORESTES\"}, {\"r\": 218, \"v\": \"LIVIA\"}, {\"r\": 219, \"v\": \"GREGORY\"}, {\"r\": 220, \"v\": \"AE\"}, {\"r\": 221, \"v\": \"VERCONIA\"}, {\"r\": 222, \"v\": \"DELORES\"}, {\"r\": 223, \"v\": \"JOHNNIE\"}, {\"r\": 224, \"v\": \"WILLY\"}, {\"r\": 225, \"v\": \"DOUGLASS\"}, {\"r\": 226, \"v\": \"NWAMAKA\"}, {\"r\": 227, \"v\": \"SUE\"}, {\"r\": 228, \"v\": \"TRUDY\"}, {\"r\": 229, \"v\": \"QUINTON\"}, {\"r\": 230, \"v\": \"STEPHINE\"}, {\"r\": 231, \"v\": \"REYANN\"}, {\"r\": 232, \"v\": \"PHILIP\"}, {\"r\": 233, \"v\": \"JAYANN\"}, {\"r\": 234, \"v\": \"HILDRED\"}, {\"r\": 235, \"v\": \"DOMINI\"}, {\"r\": 236, \"v\": \"SEPTIMIO\"}, {\"r\": 237, \"v\": \"KIMBERY\"}, {\"r\": 238, \"v\": \"ALASIA\"}, {\"r\": 239, \"v\": \"TRACIE LEE\"}, {\"r\": 240, \"v\": \"MELLISSA\"}, {\"r\": 241, \"v\": \"MIRIAM\"}, {\"r\": 242, \"v\": \"JONGE\"}, {\"r\": 243, \"v\": \"LYNN\"}, {\"r\": 244, \"v\": \"CHARES\"}, {\"r\": 245, \"v\": \"ISAREL\"}, {\"r\": 246, \"v\": \"MARYCAROLE\"}, {\"r\": 247, \"v\": \"SHEILA\"}, {\"r\": 248, \"v\": \"EVENS\"}, {\"r\": 249, \"v\": \"BRANDIE\"}, {\"r\": 250, \"v\": \"ANNE\"}, {\"r\": 251, \"v\": \"LOUIS\"}, {\"r\": 252, \"v\": \"GERARD\"}, {\"r\": 253, \"v\": \"KATHY\"}, {\"r\": 254, \"v\": \"NICOLE\"}, {\"r\": 255, \"v\": \"MARY ANNE\"}, {\"r\": 256, \"v\": \"HARRIET\"}, {\"r\": 257, \"v\": \"ALAN\"}, {\"r\": 258, \"v\": \"ANN\"}, {\"r\": 259, \"v\": \"JEANNE\"}, {\"r\": 260, \"v\": \"TRYONE\"}, {\"r\": 261, \"v\": \"HOANG\"}, {\"r\": 262, \"v\": \"DOUGLAS\"}, {\"r\": 263, \"v\": \"MICHELLE\"}, {\"r\": 264, \"v\": \"LAWRENCE\"}, {\"r\": 265, \"v\": \"DAVID\"}, {\"r\": 266, \"v\": \"BEN\"}, {\"r\": 267, \"v\": \"ALLICIA\"}, {\"r\": 268, \"v\": \"GERALDINE\"}, {\"r\": 269, \"v\": \"NATASHA\"}, {\"r\": 270, \"v\": \"GISUS\"}, {\"r\": 271, \"v\": \"ETHLEW\"}, {\"r\": 272, \"v\": \"JEANNE\"}, {\"r\": 273, \"v\": \"PABLO\"}, {\"r\": 274, \"v\": \"LE ANNE\"}, {\"r\": 275, \"v\": \"AFRIN\"}, {\"r\": 276, \"v\": \"JO ANNE\"}, {\"r\": 277, \"v\": \"BIANCA\"}, {\"r\": 278, \"v\": \"ZUNZELL\"}, {\"r\": 279, \"v\": \"CORNLIUS\"}, {\"r\": 280, \"v\": \"MARIEA\"}, {\"r\": 281, \"v\": \"DIXIE\"}, {\"r\": 282, \"v\": \"DORIAN\"}, {\"r\": 283, \"v\": \"TEAIRA\"}, {\"r\": 284, \"v\": \"ANGELEAN\"}, {\"r\": 285, \"v\": \"ARISTIDIS\"}, {\"r\": 286, \"v\": \"CARLO\"}, {\"r\": 287, \"v\": \"ROSETTA\"}, {\"r\": 288, \"v\": \"CHARLS\"}, {\"r\": 289, \"v\": \"JANICE\"}, {\"r\": 290, \"v\": \"SIFRIDO\"}, {\"r\": 291, \"v\": \"ABEL\"}, {\"r\": 292, \"v\": \"WALDO\"}, {\"r\": 293, \"v\": \"IGANACIO\"}, {\"r\": 294, \"v\": \"BARBRA\"}, {\"r\": 295, \"v\": \"JEFFERY\"}, {\"r\": 296, \"v\": \"THRESSA\"}, {\"r\": 297, \"v\": \"ANN\"}, {\"r\": 298, \"v\": \"ANDREW\"}, {\"r\": 299, \"v\": \"JAMAL\"}, {\"r\": 300, \"v\": \"DAVON\"}, {\"r\": 301, \"v\": \"SHAUN\"}, {\"r\": 302, \"v\": \"MIRIAN\"}, {\"r\": 303, \"v\": \"LEHA\"}, {\"r\": 304, \"v\": \"KENNETH\"}, {\"r\": 305, \"v\": \"CRISTOPHER\"}, {\"r\": 306, \"v\": \"ERNEST\"}, {\"r\": 307, \"v\": \"CATHERINE\"}, {\"r\": 308, \"v\": \"ALFREDA\"}, {\"r\": 309, \"v\": \"NICHOLAS\"}, {\"r\": 310, \"v\": \"KATHY\"}, {\"r\": 311, \"v\": \"JOAN\"}, {\"r\": 312, \"v\": \"PATRICIA\"}, {\"r\": 313, \"v\": \"JEFFERY\"}, {\"r\": 314, \"v\": \"ENGER\"}, {\"r\": 315, \"v\": \"GLORIANE\"}, {\"r\": 316, \"v\": \"MACK\"}, {\"r\": 317, \"v\": \"J\"}, {\"r\": 318, \"v\": \"ELAM\"}, {\"r\": 319, \"v\": \"WYLIE\"}, {\"r\": 320, \"v\": \"GISELLA\"}, {\"r\": 321, \"v\": \"RUTHANN\"}, {\"r\": 322, \"v\": \"LAWRENE\"}, {\"r\": 323, \"v\": \"JEFFREY\"}, {\"r\": 324, \"v\": \"SOLITA\"}, {\"r\": 325, \"v\": \"EDDIE\"}, {\"r\": 326, \"v\": \"EARL\"}, {\"r\": 327, \"v\": \"ROSSITA\"}, {\"r\": 328, \"v\": \"GARY\"}, {\"r\": 329, \"v\": \"MELLISA\"}, {\"r\": 330, \"v\": \"DEBNA\"}, {\"r\": 331, \"v\": \"EDNA\"}, {\"r\": 332, \"v\": \"ISAAC\"}, {\"r\": 333, \"v\": \"EARNEST\"}, {\"r\": 334, \"v\": \"THERSA\"}, {\"r\": 335, \"v\": \"JOHNNIE\"}, {\"r\": 336, \"v\": \"ANTOINETTE\"}, {\"r\": 337, \"v\": \"STANLEY\"}, {\"r\": 338, \"v\": \"CORNELIA\"}, {\"r\": 339, \"v\": \"KENNETH\"}, {\"r\": 340, \"v\": \"ENZNZELLE\"}, {\"r\": 341, \"v\": \"LACHELLE\"}, {\"r\": 342, \"v\": \"CHATYRA\"}, {\"r\": 343, \"v\": \"JOHNNIE\"}, {\"r\": 344, \"v\": \"JENIA\"}, {\"r\": 345, \"v\": \"HAILIE\"}, {\"r\": 346, \"v\": \"ROSE\"}, {\"r\": 347, \"v\": \"JONIE\"}, {\"r\": 348, \"v\": \"SCOTT\"}, {\"r\": 349, \"v\": \"JENNIFER\"}, {\"r\": 350, \"v\": \"PRESPEU\"}, {\"r\": 351, \"v\": \"NAOMI\"}, {\"r\": 352, \"v\": \"LUC\"}, {\"r\": 353, \"v\": \"RONNY\"}, {\"r\": 354, \"v\": \"KEN\"}, {\"r\": 355, \"v\": \"SHAWNA\"}, {\"r\": 356, \"v\": \"SHAMIKA\"}, {\"r\": 357, \"v\": \"ASHLEY\"}, {\"r\": 358, \"v\": \"SHERMICE\"}, {\"r\": 359, \"v\": \"ALMA\"}, {\"r\": 360, \"v\": \"GEROME\"}, {\"r\": 361, \"v\": \"DORETTA\"}, {\"r\": 362, \"v\": \"ROBERT\"}, {\"r\": 363, \"v\": \"RAKIA\"}, {\"r\": 364, \"v\": \"SONYA\"}, {\"r\": 365, \"v\": \"JEFFREY\"}, {\"r\": 366, \"v\": \"HENRIETTA\"}, {\"r\": 367, \"v\": \"JANIE\"}, {\"r\": 368, \"v\": \"JEANNE\"}, {\"r\": 369, \"v\": \"EMMIT\"}, {\"r\": 370, \"v\": \"TOMICA\"}, {\"r\": 371, \"v\": \"JOHN\"}, {\"r\": 372, \"v\": \"STEWART\"}, {\"r\": 373, \"v\": \"JOSHUA\"}, {\"r\": 374, \"v\": \"RUBY\"}, {\"r\": 375, \"v\": \"SILYIA\"}, {\"r\": 376, \"v\": \"FRED\"}, {\"r\": 377, \"v\": \"SHANTELL\"}, {\"r\": 378, \"v\": \"JEFFREY\"}, {\"r\": 379, \"v\": \"FRANK\"}, {\"r\": 380, \"v\": \"ELOUISE\"}, {\"r\": 381, \"v\": \"QUIYINA\"}, {\"r\": 382, \"v\": \"ALIE\"}, {\"r\": 383, \"v\": \"BENEDICT\"}, {\"r\": 384, \"v\": \"STEVEN\"}, {\"r\": 385, \"v\": \"HARRIET\"}, {\"r\": 386, \"v\": \"CHARLEY\"}, {\"r\": 387, \"v\": \"SHERRY\"}, {\"r\": 388, \"v\": \"BRYAN\"}, {\"r\": 389, \"v\": \"MAXINE\"}, {\"r\": 390, \"v\": \"CHANSE\"}, {\"r\": 391, \"v\": \"ALFREDICA\"}]}');
/*!40000 ALTER TABLE `sx_workset2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'iss'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-16 13:08:51
