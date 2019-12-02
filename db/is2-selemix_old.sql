-- MySQL dump 10.13  Distrib 8.0.14, for Win64 (x86_64)
--
-- Host: localhost    Database: iss
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
