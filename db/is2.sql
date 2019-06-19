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
INSERT INTO `sx_app_instance` VALUES (11,70),(12,71);
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
INSERT INTO `sx_app_service` VALUES (100,'SeleMix','Individuazione valori anomali tramite misture','R','SS_selemix.r',100),(200,'Relais','Record Linkage','R','relais.R',200),(250,'RelaisJ','Record Linkage Java','JAVA','SS_relais.jar',250),(300,'Validate','Validazione e gestione delle regole','R','SS_validate.r',300);
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
INSERT INTO `sx_bfunc_bprocess` VALUES (90,70),(91,70),(91,71);
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
INSERT INTO `sx_bprocess_bstep` VALUES (70,70),(71,71);
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
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_function`
--

LOCK TABLES `sx_business_function` WRITE;
/*!40000 ALTER TABLE `sx_business_function` DISABLE KEYS */;
INSERT INTO `sx_business_function` VALUES (90,'Cross Table','Esegue il prodotto cartesiano di dataset','Cross Table'),(91,'Relais','Relais Multi-Process','Relais');
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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_process`
--

LOCK TABLES `sx_business_process` WRITE;
/*!40000 ALTER TABLE `sx_business_process` DISABLE KEYS */;
INSERT INTO `sx_business_process` VALUES (70,'Cont Table','Calcolo tabella di contingenza','Cross Table',4),(71,'FellegiSunter','FellegiSunter','FellegiSunter',NULL);
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
INSERT INTO `sx_business_step` VALUES (70,'CONTINGENCY_TABLE','Create contingency table',4),(71,'FELLEGI SUNTER','Select matching variables',NULL);
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
  `DATACARICAMENTO` date DEFAULT NULL,
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
  `DATAELABORAZIONE` date DEFAULT NULL,
  `NOME` varchar(255) DEFAULT NULL,
  `PARAMETRI` varchar(255) DEFAULT NULL,
  `DESCRIZIONE` varchar(255) DEFAULT NULL,
  `SES_ELABORAZIONE` int(20) DEFAULT NULL,
  `BFUNCTION` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SX_ELABORAZIONE_PK` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_elaborazione`
--

LOCK TABLES `sx_elaborazione` WRITE;
/*!40000 ALTER TABLE `sx_elaborazione` DISABLE KEYS */;
INSERT INTO `sx_elaborazione` VALUES (6,'2019-05-17','asa',NULL,'',2,90),(22,'2019-06-12','relais',NULL,'',12,91),(23,'2019-06-13','d',NULL,'',11,91),(24,'2019-06-14','contingency_new',NULL,'',11,91);
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
  `msg_time` date DEFAULT NULL,
  `id_sessione` int(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_log`
--

LOCK TABLES `sx_log` WRITE;
/*!40000 ALTER TABLE `sx_log` DISABLE KEYS */;
INSERT INTO `sx_log` VALUES (1,'File DSb salvato con successo','2019-06-19',11);
/*!40000 ALTER TABLE `sx_log` ENABLE KEYS */;
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
INSERT INTO `sx_par_pattern` VALUES (1,'MATCHING VARAIBLES',11,'MATCHING VARAIBLES','3',166);
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
  `RULE` text,
  `ACTION` varchar(500) DEFAULT NULL,
  `ECCEZIONE` varchar(500) DEFAULT NULL,
  `RULESET` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014188` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=723 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_rule`
--

LOCK TABLES `sx_rule` WRITE;
/*!40000 ALTER TABLE `sx_rule` DISABLE KEYS */;
INSERT INTO `sx_rule` VALUES (1,'SEL1','Regole per step Selezione',1,1,-1,1,'TARGET IS NOT NULL','ML.EST','DEFINE_TARGET',1),(2,'PRE1','Regole per step Predizione',1,1,-1,1,'TARGET IS NOT NULL','PRED.Y','DEFINE_TARGET',2),(3,'PRE2','Regole per step Predizione',0,1,-2,1,'MODEL IS NOT NULL','PRED.Y','ML.EST',2),(4,'SEL1','Regole per step Selezione',1,1,-1,1,'TARGET IS NOT NULL','SEL.EDIT','DEFINE_TARGET',3),(5,'SEL2','Regole per step Selezione',0,1,-3,1,'PRE01TION IS NOT NULL','SEL.EDIT','PRED.Y',3),(6,'SEL3','Invalid MODEL Dimension',0,1,-3,1,'SIZE(TARGET)=SIZE(PRED)','SEL.EDIT','PRED.Y',3),(7,'PRE3','Invalid MODEL Dimension',0,1,-3,1,'SIZE(SIGMA)=SIZE(TARGET) AND SIZE(BETA)=1+SIZE(COVAR)','PRED.Y','ML.EST',2),(63,NULL,NULL,NULL,1,NULL,1,'edit',NULL,NULL,9),(64,NULL,NULL,NULL,1,NULL,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,9),(65,NULL,NULL,NULL,1,NULL,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,9),(66,NULL,NULL,NULL,1,NULL,1,'sau1 <= sat1',NULL,NULL,9),(67,NULL,NULL,NULL,1,NULL,1,'sau2 <= sat2',NULL,NULL,9),(68,NULL,NULL,NULL,1,NULL,1,'sau3 <= sat3',NULL,NULL,9),(69,NULL,NULL,NULL,1,NULL,1,'sau4 <= sat4',NULL,NULL,9),(70,NULL,NULL,NULL,1,NULL,1,'sau5 <= sat5',NULL,NULL,9),(71,NULL,NULL,NULL,1,NULL,1,'sau6 <= sat6',NULL,NULL,9),(72,NULL,NULL,NULL,1,NULL,1,'sau7 <= sat7',NULL,NULL,9),(73,NULL,NULL,NULL,1,NULL,1,'c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55 == c56',NULL,NULL,9),(74,NULL,NULL,NULL,1,NULL,1,'s57 <= c57',NULL,NULL,9),(75,NULL,NULL,NULL,1,NULL,1,'s58 <= c58',NULL,NULL,9),(76,NULL,NULL,NULL,1,NULL,1,'s59 <= c59',NULL,NULL,9),(77,NULL,NULL,NULL,1,NULL,1,'s61 <= c61',NULL,NULL,9),(78,NULL,NULL,NULL,1,NULL,1,'s62 <= c62',NULL,NULL,9),(79,NULL,NULL,NULL,1,NULL,1,'s63 <= c63',NULL,NULL,9),(80,NULL,NULL,NULL,1,NULL,1,'s64 <= c64',NULL,NULL,9),(81,NULL,NULL,NULL,1,NULL,1,'s65 <= c65',NULL,NULL,9),(82,NULL,NULL,NULL,1,NULL,1,'s66 <= c66',NULL,NULL,9),(83,NULL,NULL,NULL,1,NULL,1,'s67 <= c67',NULL,NULL,9),(84,NULL,NULL,NULL,1,NULL,1,'s68 <= c68',NULL,NULL,9),(85,NULL,NULL,NULL,1,NULL,1,'s69 <= c69',NULL,NULL,9),(86,NULL,NULL,NULL,1,NULL,1,'s70 <= c70',NULL,NULL,9),(87,NULL,NULL,NULL,1,NULL,1,'s71 <= c71',NULL,NULL,9),(88,NULL,NULL,NULL,1,NULL,1,'s72 <= c72',NULL,NULL,9),(89,NULL,NULL,NULL,1,NULL,1,'s73 <= c73',NULL,NULL,9),(90,NULL,NULL,NULL,1,NULL,1,'s74 <= c74',NULL,NULL,9),(91,NULL,NULL,NULL,1,NULL,1,'s75 <= c75',NULL,NULL,9),(92,NULL,NULL,NULL,1,NULL,1,'s76 <= c76',NULL,NULL,9),(93,NULL,NULL,NULL,1,NULL,1,'s77 <= c77',NULL,NULL,9),(94,NULL,NULL,NULL,1,NULL,1,'s78 <= c78',NULL,NULL,9),(95,NULL,NULL,NULL,1,NULL,1,'s79 <= c79',NULL,NULL,9),(96,NULL,NULL,NULL,1,NULL,1,'s80 <= c80',NULL,NULL,9),(97,NULL,NULL,NULL,1,NULL,1,'s81 <= c81',NULL,NULL,9),(98,NULL,NULL,NULL,1,NULL,1,'s82 <= c82',NULL,NULL,9),(99,NULL,NULL,NULL,1,NULL,1,'s86 <= c86',NULL,NULL,9),(100,NULL,NULL,NULL,1,NULL,1,'s87 <= c87',NULL,NULL,9),(101,NULL,NULL,NULL,1,NULL,1,'c57+c58+c59+c60+c61+c62+c63+c64+c65+c66+c67+c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82+c83+c84+c85+c86+c87 == c88',NULL,NULL,9),(102,NULL,NULL,NULL,1,NULL,1,'s57+s58+s59+s61+s62+s63+s64+s65+s66+s67+s68+s69+s70+s71+s72+s73+s74+s75+s76+s77+s78+s79+s80+s81+s82+s86+s87 == s88',NULL,NULL,9),(103,NULL,NULL,NULL,1,NULL,1,'c90+c91+c92 == c93',NULL,NULL,9),(104,NULL,NULL,NULL,1,NULL,1,'c95+c96 == c97',NULL,NULL,9),(105,NULL,NULL,NULL,1,NULL,1,'c106+c107+c108 == c98',NULL,NULL,9),(106,NULL,NULL,NULL,1,NULL,1,'c56+c88+c89+c93 == c94',NULL,NULL,9),(107,NULL,NULL,NULL,1,NULL,1,'c94+c97+c98+c99+c100 == c101',NULL,NULL,9),(108,NULL,NULL,NULL,1,NULL,1,'sau8 == c94',NULL,NULL,9),(109,NULL,NULL,NULL,1,NULL,1,'sat8 == c101',NULL,NULL,9),(110,NULL,NULL,NULL,1,NULL,1,'c110 <= c100*100',NULL,NULL,9),(111,NULL,NULL,NULL,1,NULL,1,'c111 <= c101*100',NULL,NULL,9),(112,NULL,NULL,NULL,1,NULL,1,'for1+for2+for3 == for4',NULL,NULL,9),(113,NULL,NULL,NULL,1,NULL,1,'for4 == c98',NULL,NULL,9),(114,NULL,NULL,NULL,1,NULL,1,'for5+for8+for11 <= for1',NULL,NULL,9),(115,NULL,NULL,NULL,1,NULL,1,'for6+for9+for12 <= for2',NULL,NULL,9),(116,NULL,NULL,NULL,1,NULL,1,'for7+for10+for13 <= for3',NULL,NULL,9),(117,NULL,NULL,NULL,1,NULL,1,'ir0 <= c94+c97',NULL,NULL,9),(118,NULL,NULL,NULL,1,NULL,1,'ir16 <= ir0',NULL,NULL,9),(119,NULL,NULL,NULL,1,NULL,1,'c89 <= 30',NULL,NULL,9),(120,NULL,NULL,NULL,1,NULL,1,'#ir16>= 0.0001*ir20+0.0001*ir21+0.0001*ir22+0.0001*ir23+0.0001*ir24+0.0001*ir25',NULL,NULL,9),(121,NULL,NULL,NULL,1,NULL,1,'ir20 <= ir16',NULL,NULL,9),(122,NULL,NULL,NULL,1,NULL,1,'ir21 <= ir16',NULL,NULL,9),(123,NULL,NULL,NULL,1,NULL,1,'ir22 <= ir16',NULL,NULL,9),(124,NULL,NULL,NULL,1,NULL,1,'ir23 <= ir16',NULL,NULL,9),(125,NULL,NULL,NULL,1,NULL,1,'ir25 <= ir16',NULL,NULL,9),(126,NULL,NULL,NULL,1,NULL,1,'ir24  <=  ir23',NULL,NULL,9),(127,NULL,NULL,NULL,1,NULL,1,'ir20 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,9),(128,NULL,NULL,NULL,1,NULL,1,'ir21 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,9),(129,NULL,NULL,NULL,1,NULL,1,'ir22 <= c94+c97-c38-c40-c41-c43-c44-c89                   ',NULL,NULL,9),(130,NULL,NULL,NULL,1,NULL,1,'ir23 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,9),(131,NULL,NULL,NULL,1,NULL,1,'ir25 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,9),(132,NULL,NULL,NULL,1,NULL,1,'colt1 <= c94',NULL,NULL,9),(133,NULL,NULL,NULL,1,NULL,1,'colt2 <= c94',NULL,NULL,9),(134,NULL,NULL,NULL,1,NULL,1,'colt3 <= c94',NULL,NULL,9),(135,NULL,NULL,NULL,1,NULL,1,'colt4 <= c56+c88',NULL,NULL,9),(136,NULL,NULL,NULL,1,NULL,1,'colt5 <= c93',NULL,NULL,9),(137,NULL,NULL,NULL,1,NULL,1,'colt6 <= c97+c98',NULL,NULL,9),(138,NULL,NULL,NULL,1,NULL,1,'colt7 <= c55',NULL,NULL,9),(139,NULL,NULL,NULL,1,NULL,1,'colt8 <= c99+c100',NULL,NULL,9),(140,NULL,NULL,NULL,1,NULL,1,'colt9 <= c101',NULL,NULL,9),(141,NULL,NULL,NULL,1,NULL,1,'colt9 == colt4+colt5+colt6+colt7+colt8',NULL,NULL,9),(142,NULL,NULL,NULL,1,NULL,1,'colt10 <= c101',NULL,NULL,9),(143,NULL,NULL,NULL,1,NULL,1,'sup1 <= c94+c97',NULL,NULL,9),(144,NULL,NULL,NULL,1,NULL,1,'sup2 <= c94+c97',NULL,NULL,9),(145,NULL,NULL,NULL,1,NULL,1,'sup3 <= c94+c97',NULL,NULL,9),(146,NULL,NULL,NULL,1,NULL,1,'sup4 <= c94+c97',NULL,NULL,9),(147,NULL,NULL,NULL,1,NULL,1,'sup5 <= c94+c97',NULL,NULL,9),(148,NULL,NULL,NULL,1,NULL,1,'sup6 <= c94+c97',NULL,NULL,9),(149,NULL,NULL,NULL,1,NULL,1,'sup7 <= c94+c97',NULL,NULL,9),(150,NULL,NULL,NULL,1,NULL,1,'sup8 <= c94+c97',NULL,NULL,9),(151,NULL,NULL,NULL,1,NULL,1,'sup9 <= c98',NULL,NULL,9),(152,NULL,NULL,NULL,1,NULL,1,'sup10 <= c98',NULL,NULL,9),(153,NULL,NULL,NULL,1,NULL,1,'sup11 <= c98',NULL,NULL,9),(154,NULL,NULL,NULL,1,NULL,1,'sup12 <= c98',NULL,NULL,9),(155,NULL,NULL,NULL,1,NULL,1,'sup13 <= c98',NULL,NULL,9),(156,NULL,NULL,NULL,1,NULL,1,'sup14 <= c98',NULL,NULL,9),(157,NULL,NULL,NULL,1,NULL,1,'bio1 <= c1+c2+c3+c4+c5+c6+c7+c8+c9+c10',NULL,NULL,9),(158,NULL,NULL,NULL,1,NULL,1,'bio2 <= c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41',NULL,NULL,9),(159,NULL,NULL,NULL,1,NULL,1,'bio3 <= c57+c58+c59+c60',NULL,NULL,9),(160,NULL,NULL,NULL,1,NULL,1,'bio4 <= c61+c62',NULL,NULL,9),(161,NULL,NULL,NULL,1,NULL,1,'bio5 <= c63+c64+c65+c66+c67',NULL,NULL,9),(162,NULL,NULL,NULL,1,NULL,1,'bio6 <= c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82',NULL,NULL,9),(163,NULL,NULL,NULL,1,NULL,1,'bio7 <= c93',NULL,NULL,9),(164,NULL,NULL,NULL,1,NULL,1,'bio8 <= c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55+c83+c84+c85+c86+c87+c89 ',NULL,NULL,9),(165,NULL,NULL,NULL,1,NULL,1,'bio9 == bio1+bio2+bio3+bio4+bio5+bio6+bio7+bio8',NULL,NULL,9),(166,NULL,NULL,NULL,1,NULL,1,'bio10 <= c94',NULL,NULL,9),(167,NULL,NULL,NULL,1,NULL,1,'pra1 <= c94',NULL,NULL,9),(168,NULL,NULL,NULL,1,NULL,1,'pra2 <= c94',NULL,NULL,9),(169,NULL,NULL,NULL,1,NULL,1,'pra3 <= c94',NULL,NULL,9),(170,NULL,NULL,NULL,1,NULL,1,'pra4 <= c94',NULL,NULL,9),(171,NULL,NULL,NULL,1,NULL,1,'pra5 <= c94',NULL,NULL,9),(172,NULL,NULL,NULL,1,NULL,1,'pra6 <= c94 ',NULL,NULL,9),(173,NULL,NULL,NULL,1,NULL,1,'edit',NULL,NULL,10),(174,NULL,NULL,NULL,1,NULL,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,10),(175,NULL,NULL,NULL,1,NULL,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,10),(176,NULL,NULL,NULL,1,NULL,1,'sau1 <= sat1',NULL,NULL,10),(177,NULL,NULL,NULL,1,NULL,1,'sau2 <= sat2',NULL,NULL,10),(178,NULL,NULL,NULL,1,NULL,1,'sau3 <= sat3',NULL,NULL,10),(179,NULL,NULL,NULL,1,NULL,1,'sau4 <= sat4',NULL,NULL,10),(180,NULL,NULL,NULL,1,NULL,1,'sau5 <= sat5',NULL,NULL,10),(181,NULL,NULL,NULL,1,NULL,1,'sau6 <= sat6',NULL,NULL,10),(182,NULL,NULL,NULL,1,NULL,1,'sau7 <= sat7',NULL,NULL,10),(183,NULL,NULL,NULL,1,NULL,1,'c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55 == c56',NULL,NULL,10),(184,NULL,NULL,NULL,1,NULL,1,'s57 <= c57',NULL,NULL,10),(185,NULL,NULL,NULL,1,NULL,1,'s58 <= c58',NULL,NULL,10),(186,NULL,NULL,NULL,1,NULL,1,'s59 <= c59',NULL,NULL,10),(187,NULL,NULL,NULL,1,NULL,1,'s61 <= c61',NULL,NULL,10),(188,NULL,NULL,NULL,1,NULL,1,'s62 <= c62',NULL,NULL,10),(189,NULL,NULL,NULL,1,NULL,1,'s63 <= c63',NULL,NULL,10),(190,NULL,NULL,NULL,1,NULL,1,'s64 <= c64',NULL,NULL,10),(191,NULL,NULL,NULL,1,NULL,1,'s65 <= c65',NULL,NULL,10),(192,NULL,NULL,NULL,1,NULL,1,'s66 <= c66',NULL,NULL,10),(193,NULL,NULL,NULL,1,NULL,1,'s67 <= c67',NULL,NULL,10),(194,NULL,NULL,NULL,1,NULL,1,'s68 <= c68',NULL,NULL,10),(195,NULL,NULL,NULL,1,NULL,1,'s69 <= c69',NULL,NULL,10),(196,NULL,NULL,NULL,1,NULL,1,'s70 <= c70',NULL,NULL,10),(197,NULL,NULL,NULL,1,NULL,1,'s71 <= c71',NULL,NULL,10),(198,NULL,NULL,NULL,1,NULL,1,'s72 <= c72',NULL,NULL,10),(199,NULL,NULL,NULL,1,NULL,1,'s73 <= c73',NULL,NULL,10),(200,NULL,NULL,NULL,1,NULL,1,'s74 <= c74',NULL,NULL,10),(201,NULL,NULL,NULL,1,NULL,1,'s75 <= c75',NULL,NULL,10),(202,NULL,NULL,NULL,1,NULL,1,'s76 <= c76',NULL,NULL,10),(203,NULL,NULL,NULL,1,NULL,1,'s77 <= c77',NULL,NULL,10),(204,NULL,NULL,NULL,1,NULL,1,'s78 <= c78',NULL,NULL,10),(205,NULL,NULL,NULL,1,NULL,1,'s79 <= c79',NULL,NULL,10),(206,NULL,NULL,NULL,1,NULL,1,'s80 <= c80',NULL,NULL,10),(207,NULL,NULL,NULL,1,NULL,1,'s81 <= c81',NULL,NULL,10),(208,NULL,NULL,NULL,1,NULL,1,'s82 <= c82',NULL,NULL,10),(209,NULL,NULL,NULL,1,NULL,1,'s86 <= c86',NULL,NULL,10),(210,NULL,NULL,NULL,1,NULL,1,'s87 <= c87',NULL,NULL,10),(211,NULL,NULL,NULL,1,NULL,1,'c57+c58+c59+c60+c61+c62+c63+c64+c65+c66+c67+c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82+c83+c84+c85+c86+c87 == c88',NULL,NULL,10),(212,NULL,NULL,NULL,1,NULL,1,'s57+s58+s59+s61+s62+s63+s64+s65+s66+s67+s68+s69+s70+s71+s72+s73+s74+s75+s76+s77+s78+s79+s80+s81+s82+s86+s87 == s88',NULL,NULL,10),(213,NULL,NULL,NULL,1,NULL,1,'c90+c91+c92 == c93',NULL,NULL,10),(214,NULL,NULL,NULL,1,NULL,1,'c95+c96 == c97',NULL,NULL,10),(215,NULL,NULL,NULL,1,NULL,1,'c106+c107+c108 == c98',NULL,NULL,10),(216,NULL,NULL,NULL,1,NULL,1,'c56+c88+c89+c93 == c94',NULL,NULL,10),(217,NULL,NULL,NULL,1,NULL,1,'c94+c97+c98+c99+c100 == c101',NULL,NULL,10),(218,NULL,NULL,NULL,1,NULL,1,'sau8 == c94',NULL,NULL,10),(219,NULL,NULL,NULL,1,NULL,1,'sat8 == c101',NULL,NULL,10),(220,NULL,NULL,NULL,1,NULL,1,'c110 <= c100*100',NULL,NULL,10),(221,NULL,NULL,NULL,1,NULL,1,'c111 <= c101*100',NULL,NULL,10),(222,NULL,NULL,NULL,1,NULL,1,'for1+for2+for3 == for4',NULL,NULL,10),(223,NULL,NULL,NULL,1,NULL,1,'for4 == c98',NULL,NULL,10),(224,NULL,NULL,NULL,1,NULL,1,'for5+for8+for11 <= for1',NULL,NULL,10),(225,NULL,NULL,NULL,1,NULL,1,'for6+for9+for12 <= for2',NULL,NULL,10),(226,NULL,NULL,NULL,1,NULL,1,'for7+for10+for13 <= for3',NULL,NULL,10),(227,NULL,NULL,NULL,1,NULL,1,'ir0 <= c94+c97',NULL,NULL,10),(228,NULL,NULL,NULL,1,NULL,1,'ir16 <= ir0',NULL,NULL,10),(229,NULL,NULL,NULL,1,NULL,1,'c89 <= 30',NULL,NULL,10),(230,NULL,NULL,NULL,1,NULL,1,'#ir16>= 0.0001*ir20+0.0001*ir21+0.0001*ir22+0.0001*ir23+0.0001*ir24+0.0001*ir25',NULL,NULL,10),(231,NULL,NULL,NULL,1,NULL,1,'ir20 <= ir16',NULL,NULL,10),(232,NULL,NULL,NULL,1,NULL,1,'ir21 <= ir16',NULL,NULL,10),(233,NULL,NULL,NULL,1,NULL,1,'ir22 <= ir16',NULL,NULL,10),(234,NULL,NULL,NULL,1,NULL,1,'ir23 <= ir16',NULL,NULL,10),(235,NULL,NULL,NULL,1,NULL,1,'ir25 <= ir16',NULL,NULL,10),(236,NULL,NULL,NULL,1,NULL,1,'ir24  <=  ir23',NULL,NULL,10),(237,NULL,NULL,NULL,1,NULL,1,'ir20 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,10),(238,NULL,NULL,NULL,1,NULL,1,'ir21 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,10),(239,NULL,NULL,NULL,1,NULL,1,'ir22 <= c94+c97-c38-c40-c41-c43-c44-c89                   ',NULL,NULL,10),(240,NULL,NULL,NULL,1,NULL,1,'ir23 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,10),(241,NULL,NULL,NULL,1,NULL,1,'ir25 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,10),(242,NULL,NULL,NULL,1,NULL,1,'colt1 <= c94',NULL,NULL,10),(243,NULL,NULL,NULL,1,NULL,1,'colt2 <= c94',NULL,NULL,10),(244,NULL,NULL,NULL,1,NULL,1,'colt3 <= c94',NULL,NULL,10),(245,NULL,NULL,NULL,1,NULL,1,'colt4 <= c56+c88',NULL,NULL,10),(246,NULL,NULL,NULL,1,NULL,1,'colt5 <= c93',NULL,NULL,10),(247,NULL,NULL,NULL,1,NULL,1,'colt6 <= c97+c98',NULL,NULL,10),(248,NULL,NULL,NULL,1,NULL,1,'colt7 <= c55',NULL,NULL,10),(249,NULL,NULL,NULL,1,NULL,1,'colt8 <= c99+c100',NULL,NULL,10),(250,NULL,NULL,NULL,1,NULL,1,'colt9 <= c101',NULL,NULL,10),(251,NULL,NULL,NULL,1,NULL,1,'colt9 == colt4+colt5+colt6+colt7+colt8',NULL,NULL,10),(252,NULL,NULL,NULL,1,NULL,1,'colt10 <= c101',NULL,NULL,10),(253,NULL,NULL,NULL,1,NULL,1,'sup1 <= c94+c97',NULL,NULL,10),(254,NULL,NULL,NULL,1,NULL,1,'sup2 <= c94+c97',NULL,NULL,10),(255,NULL,NULL,NULL,1,NULL,1,'sup3 <= c94+c97',NULL,NULL,10),(256,NULL,NULL,NULL,1,NULL,1,'sup4 <= c94+c97',NULL,NULL,10),(257,NULL,NULL,NULL,1,NULL,1,'sup5 <= c94+c97',NULL,NULL,10),(258,NULL,NULL,NULL,1,NULL,1,'sup6 <= c94+c97',NULL,NULL,10),(259,NULL,NULL,NULL,1,NULL,1,'sup7 <= c94+c97',NULL,NULL,10),(260,NULL,NULL,NULL,1,NULL,1,'sup8 <= c94+c97',NULL,NULL,10),(261,NULL,NULL,NULL,1,NULL,1,'sup9 <= c98',NULL,NULL,10),(262,NULL,NULL,NULL,1,NULL,1,'sup10 <= c98',NULL,NULL,10),(263,NULL,NULL,NULL,1,NULL,1,'sup11 <= c98',NULL,NULL,10),(264,NULL,NULL,NULL,1,NULL,1,'sup12 <= c98',NULL,NULL,10),(265,NULL,NULL,NULL,1,NULL,1,'sup13 <= c98',NULL,NULL,10),(266,NULL,NULL,NULL,1,NULL,1,'sup14 <= c98',NULL,NULL,10),(267,NULL,NULL,NULL,1,NULL,1,'bio1 <= c1+c2+c3+c4+c5+c6+c7+c8+c9+c10',NULL,NULL,10),(268,NULL,NULL,NULL,1,NULL,1,'bio2 <= c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41',NULL,NULL,10),(269,NULL,NULL,NULL,1,NULL,1,'bio3 <= c57+c58+c59+c60',NULL,NULL,10),(270,NULL,NULL,NULL,1,NULL,1,'bio4 <= c61+c62',NULL,NULL,10),(271,NULL,NULL,NULL,1,NULL,1,'bio5 <= c63+c64+c65+c66+c67',NULL,NULL,10),(272,NULL,NULL,NULL,1,NULL,1,'bio6 <= c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82',NULL,NULL,10),(273,NULL,NULL,NULL,1,NULL,1,'bio7 <= c93',NULL,NULL,10),(274,NULL,NULL,NULL,1,NULL,1,'bio8 <= c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55+c83+c84+c85+c86+c87+c89 ',NULL,NULL,10),(275,NULL,NULL,NULL,1,NULL,1,'bio9 == bio1+bio2+bio3+bio4+bio5+bio6+bio7+bio8',NULL,NULL,10),(276,NULL,NULL,NULL,1,NULL,1,'bio10 <= c94',NULL,NULL,10),(277,NULL,NULL,NULL,1,NULL,1,'pra1 <= c94',NULL,NULL,10),(278,NULL,NULL,NULL,1,NULL,1,'pra2 <= c94',NULL,NULL,10),(279,NULL,NULL,NULL,1,NULL,1,'pra3 <= c94',NULL,NULL,10),(280,NULL,NULL,NULL,1,NULL,1,'pra4 <= c94',NULL,NULL,10),(281,NULL,NULL,NULL,1,NULL,1,'pra5 <= c94',NULL,NULL,10),(282,NULL,NULL,NULL,1,NULL,1,'pra6 <= c94 ',NULL,NULL,10),(283,NULL,NULL,NULL,1,NULL,1,'edit',NULL,NULL,11),(284,NULL,NULL,NULL,1,NULL,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,11),(285,NULL,NULL,NULL,1,NULL,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,11),(286,NULL,NULL,NULL,1,NULL,1,'sau1 <= sat1',NULL,NULL,11),(287,NULL,NULL,NULL,1,NULL,1,'sau2 <= sat2',NULL,NULL,11),(288,NULL,NULL,NULL,1,NULL,1,'sau3 <= sat3',NULL,NULL,11),(289,NULL,NULL,NULL,1,NULL,1,'sau4 <= sat4',NULL,NULL,11),(290,NULL,NULL,NULL,1,NULL,1,'sau5 <= sat5',NULL,NULL,11),(291,NULL,NULL,NULL,1,NULL,1,'sau6 <= sat6',NULL,NULL,11),(292,NULL,NULL,NULL,1,NULL,1,'sau7 <= sat7',NULL,NULL,11),(293,NULL,NULL,NULL,1,NULL,1,'c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55 == c56',NULL,NULL,11),(294,NULL,NULL,NULL,1,NULL,1,'s57 <= c57',NULL,NULL,11),(295,NULL,NULL,NULL,1,NULL,1,'s58 <= c58',NULL,NULL,11),(296,NULL,NULL,NULL,1,NULL,1,'s59 <= c59',NULL,NULL,11),(297,NULL,NULL,NULL,1,NULL,1,'s61 <= c61',NULL,NULL,11),(298,NULL,NULL,NULL,1,NULL,1,'s62 <= c62',NULL,NULL,11),(299,NULL,NULL,NULL,1,NULL,1,'s63 <= c63',NULL,NULL,11),(300,NULL,NULL,NULL,1,NULL,1,'s64 <= c64',NULL,NULL,11),(301,NULL,NULL,NULL,1,NULL,1,'s65 <= c65',NULL,NULL,11),(302,NULL,NULL,NULL,1,NULL,1,'s66 <= c66',NULL,NULL,11),(303,NULL,NULL,NULL,1,NULL,1,'s67 <= c67',NULL,NULL,11),(304,NULL,NULL,NULL,1,NULL,1,'s68 <= c68',NULL,NULL,11),(305,NULL,NULL,NULL,1,NULL,1,'s69 <= c69',NULL,NULL,11),(306,NULL,NULL,NULL,1,NULL,1,'s70 <= c70',NULL,NULL,11),(307,NULL,NULL,NULL,1,NULL,1,'s71 <= c71',NULL,NULL,11),(308,NULL,NULL,NULL,1,NULL,1,'s72 <= c72',NULL,NULL,11),(309,NULL,NULL,NULL,1,NULL,1,'s73 <= c73',NULL,NULL,11),(310,NULL,NULL,NULL,1,NULL,1,'s74 <= c74',NULL,NULL,11),(311,NULL,NULL,NULL,1,NULL,1,'s75 <= c75',NULL,NULL,11),(312,NULL,NULL,NULL,1,NULL,1,'s76 <= c76',NULL,NULL,11),(313,NULL,NULL,NULL,1,NULL,1,'s77 <= c77',NULL,NULL,11),(314,NULL,NULL,NULL,1,NULL,1,'s78 <= c78',NULL,NULL,11),(315,NULL,NULL,NULL,1,NULL,1,'s79 <= c79',NULL,NULL,11),(316,NULL,NULL,NULL,1,NULL,1,'s80 <= c80',NULL,NULL,11),(317,NULL,NULL,NULL,1,NULL,1,'s81 <= c81',NULL,NULL,11),(318,NULL,NULL,NULL,1,NULL,1,'s82 <= c82',NULL,NULL,11),(319,NULL,NULL,NULL,1,NULL,1,'s86 <= c86',NULL,NULL,11),(320,NULL,NULL,NULL,1,NULL,1,'s87 <= c87',NULL,NULL,11),(321,NULL,NULL,NULL,1,NULL,1,'c57+c58+c59+c60+c61+c62+c63+c64+c65+c66+c67+c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82+c83+c84+c85+c86+c87 == c88',NULL,NULL,11),(322,NULL,NULL,NULL,1,NULL,1,'s57+s58+s59+s61+s62+s63+s64+s65+s66+s67+s68+s69+s70+s71+s72+s73+s74+s75+s76+s77+s78+s79+s80+s81+s82+s86+s87 == s88',NULL,NULL,11),(323,NULL,NULL,NULL,1,NULL,1,'c90+c91+c92 == c93',NULL,NULL,11),(324,NULL,NULL,NULL,1,NULL,1,'c95+c96 == c97',NULL,NULL,11),(325,NULL,NULL,NULL,1,NULL,1,'c106+c107+c108 == c98',NULL,NULL,11),(326,NULL,NULL,NULL,1,NULL,1,'c56+c88+c89+c93 == c94',NULL,NULL,11),(327,NULL,NULL,NULL,1,NULL,1,'c94+c97+c98+c99+c100 == c101',NULL,NULL,11),(328,NULL,NULL,NULL,1,NULL,1,'sau8 == c94',NULL,NULL,11),(329,NULL,NULL,NULL,1,NULL,1,'sat8 == c101',NULL,NULL,11),(330,NULL,NULL,NULL,1,NULL,1,'c110 <= c100*100',NULL,NULL,11),(331,NULL,NULL,NULL,1,NULL,1,'c111 <= c101*100',NULL,NULL,11),(332,NULL,NULL,NULL,1,NULL,1,'for1+for2+for3 == for4',NULL,NULL,11),(333,NULL,NULL,NULL,1,NULL,1,'for4 == c98',NULL,NULL,11),(334,NULL,NULL,NULL,1,NULL,1,'for5+for8+for11 <= for1',NULL,NULL,11),(335,NULL,NULL,NULL,1,NULL,1,'for6+for9+for12 <= for2',NULL,NULL,11),(336,NULL,NULL,NULL,1,NULL,1,'for7+for10+for13 <= for3',NULL,NULL,11),(337,NULL,NULL,NULL,1,NULL,1,'ir0 <= c94+c97',NULL,NULL,11),(338,NULL,NULL,NULL,1,NULL,1,'ir16 <= ir0',NULL,NULL,11),(339,NULL,NULL,NULL,1,NULL,1,'c89 <= 30',NULL,NULL,11),(340,NULL,NULL,NULL,1,NULL,1,'#ir16>= 0.0001*ir20+0.0001*ir21+0.0001*ir22+0.0001*ir23+0.0001*ir24+0.0001*ir25',NULL,NULL,11),(341,NULL,NULL,NULL,1,NULL,1,'ir20 <= ir16',NULL,NULL,11),(342,NULL,NULL,NULL,1,NULL,1,'ir21 <= ir16',NULL,NULL,11),(343,NULL,NULL,NULL,1,NULL,1,'ir22 <= ir16',NULL,NULL,11),(344,NULL,NULL,NULL,1,NULL,1,'ir23 <= ir16',NULL,NULL,11),(345,NULL,NULL,NULL,1,NULL,1,'ir25 <= ir16',NULL,NULL,11),(346,NULL,NULL,NULL,1,NULL,1,'ir24  <=  ir23',NULL,NULL,11),(347,NULL,NULL,NULL,1,NULL,1,'ir20 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,11),(348,NULL,NULL,NULL,1,NULL,1,'ir21 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,11),(349,NULL,NULL,NULL,1,NULL,1,'ir22 <= c94+c97-c38-c40-c41-c43-c44-c89                   ',NULL,NULL,11),(350,NULL,NULL,NULL,1,NULL,1,'ir23 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,11),(351,NULL,NULL,NULL,1,NULL,1,'ir25 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,11),(352,NULL,NULL,NULL,1,NULL,1,'colt1 <= c94',NULL,NULL,11),(353,NULL,NULL,NULL,1,NULL,1,'colt2 <= c94',NULL,NULL,11),(354,NULL,NULL,NULL,1,NULL,1,'colt3 <= c94',NULL,NULL,11),(355,NULL,NULL,NULL,1,NULL,1,'colt4 <= c56+c88',NULL,NULL,11),(356,NULL,NULL,NULL,1,NULL,1,'colt5 <= c93',NULL,NULL,11),(357,NULL,NULL,NULL,1,NULL,1,'colt6 <= c97+c98',NULL,NULL,11),(358,NULL,NULL,NULL,1,NULL,1,'colt7 <= c55',NULL,NULL,11),(359,NULL,NULL,NULL,1,NULL,1,'colt8 <= c99+c100',NULL,NULL,11),(360,NULL,NULL,NULL,1,NULL,1,'colt9 <= c101',NULL,NULL,11),(361,NULL,NULL,NULL,1,NULL,1,'colt9 == colt4+colt5+colt6+colt7+colt8',NULL,NULL,11),(362,NULL,NULL,NULL,1,NULL,1,'colt10 <= c101',NULL,NULL,11),(363,NULL,NULL,NULL,1,NULL,1,'sup1 <= c94+c97',NULL,NULL,11),(364,NULL,NULL,NULL,1,NULL,1,'sup2 <= c94+c97',NULL,NULL,11),(365,NULL,NULL,NULL,1,NULL,1,'sup3 <= c94+c97',NULL,NULL,11),(366,NULL,NULL,NULL,1,NULL,1,'sup4 <= c94+c97',NULL,NULL,11),(367,NULL,NULL,NULL,1,NULL,1,'sup5 <= c94+c97',NULL,NULL,11),(368,NULL,NULL,NULL,1,NULL,1,'sup6 <= c94+c97',NULL,NULL,11),(369,NULL,NULL,NULL,1,NULL,1,'sup7 <= c94+c97',NULL,NULL,11),(370,NULL,NULL,NULL,1,NULL,1,'sup8 <= c94+c97',NULL,NULL,11),(371,NULL,NULL,NULL,1,NULL,1,'sup9 <= c98',NULL,NULL,11),(372,NULL,NULL,NULL,1,NULL,1,'sup10 <= c98',NULL,NULL,11),(373,NULL,NULL,NULL,1,NULL,1,'sup11 <= c98',NULL,NULL,11),(374,NULL,NULL,NULL,1,NULL,1,'sup12 <= c98',NULL,NULL,11),(375,NULL,NULL,NULL,1,NULL,1,'sup13 <= c98',NULL,NULL,11),(376,NULL,NULL,NULL,1,NULL,1,'sup14 <= c98',NULL,NULL,11),(377,NULL,NULL,NULL,1,NULL,1,'bio1 <= c1+c2+c3+c4+c5+c6+c7+c8+c9+c10',NULL,NULL,11),(378,NULL,NULL,NULL,1,NULL,1,'bio2 <= c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41',NULL,NULL,11),(379,NULL,NULL,NULL,1,NULL,1,'bio3 <= c57+c58+c59+c60',NULL,NULL,11),(380,NULL,NULL,NULL,1,NULL,1,'bio4 <= c61+c62',NULL,NULL,11),(381,NULL,NULL,NULL,1,NULL,1,'bio5 <= c63+c64+c65+c66+c67',NULL,NULL,11),(382,NULL,NULL,NULL,1,NULL,1,'bio6 <= c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82',NULL,NULL,11),(383,NULL,NULL,NULL,1,NULL,1,'bio7 <= c93',NULL,NULL,11),(384,NULL,NULL,NULL,1,NULL,1,'bio8 <= c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55+c83+c84+c85+c86+c87+c89 ',NULL,NULL,11),(385,NULL,NULL,NULL,1,NULL,1,'bio9 == bio1+bio2+bio3+bio4+bio5+bio6+bio7+bio8',NULL,NULL,11),(386,NULL,NULL,NULL,1,NULL,1,'bio10 <= c94',NULL,NULL,11),(387,NULL,NULL,NULL,1,NULL,1,'pra1 <= c94',NULL,NULL,11),(388,NULL,NULL,NULL,1,NULL,1,'pra2 <= c94',NULL,NULL,11),(389,NULL,NULL,NULL,1,NULL,1,'pra3 <= c94',NULL,NULL,11),(390,NULL,NULL,NULL,1,NULL,1,'pra4 <= c94',NULL,NULL,11),(391,NULL,NULL,NULL,1,NULL,1,'pra5 <= c94',NULL,NULL,11),(392,NULL,NULL,NULL,1,NULL,1,'pra6 <= c94 ',NULL,NULL,11),(393,NULL,NULL,NULL,1,NULL,1,'edit',NULL,NULL,12),(394,NULL,NULL,NULL,1,NULL,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,12),(395,NULL,NULL,NULL,1,NULL,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,12),(396,NULL,NULL,NULL,1,NULL,1,'sau1 <= sat1',NULL,NULL,12),(397,NULL,NULL,NULL,1,NULL,1,'sau2 <= sat2',NULL,NULL,12),(398,NULL,NULL,NULL,1,NULL,1,'sau3 <= sat3',NULL,NULL,12),(399,NULL,NULL,NULL,1,NULL,1,'sau4 <= sat4',NULL,NULL,12),(400,NULL,NULL,NULL,1,NULL,1,'sau5 <= sat5',NULL,NULL,12),(401,NULL,NULL,NULL,1,NULL,1,'sau6 <= sat6',NULL,NULL,12),(402,NULL,NULL,NULL,1,NULL,1,'sau7 <= sat7',NULL,NULL,12),(403,NULL,NULL,NULL,1,NULL,1,'c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55 == c56',NULL,NULL,12),(404,NULL,NULL,NULL,1,NULL,1,'s57 <= c57',NULL,NULL,12),(405,NULL,NULL,NULL,1,NULL,1,'s58 <= c58',NULL,NULL,12),(406,NULL,NULL,NULL,1,NULL,1,'s59 <= c59',NULL,NULL,12),(407,NULL,NULL,NULL,1,NULL,1,'s61 <= c61',NULL,NULL,12),(408,NULL,NULL,NULL,1,NULL,1,'s62 <= c62',NULL,NULL,12),(409,NULL,NULL,NULL,1,NULL,1,'s63 <= c63',NULL,NULL,12),(410,NULL,NULL,NULL,1,NULL,1,'s64 <= c64',NULL,NULL,12),(411,NULL,NULL,NULL,1,NULL,1,'s65 <= c65',NULL,NULL,12),(412,NULL,NULL,NULL,1,NULL,1,'s66 <= c66',NULL,NULL,12),(413,NULL,NULL,NULL,1,NULL,1,'s67 <= c67',NULL,NULL,12),(414,NULL,NULL,NULL,1,NULL,1,'s68 <= c68',NULL,NULL,12),(415,NULL,NULL,NULL,1,NULL,1,'s69 <= c69',NULL,NULL,12),(416,NULL,NULL,NULL,1,NULL,1,'s70 <= c70',NULL,NULL,12),(417,NULL,NULL,NULL,1,NULL,1,'s71 <= c71',NULL,NULL,12),(418,NULL,NULL,NULL,1,NULL,1,'s72 <= c72',NULL,NULL,12),(419,NULL,NULL,NULL,1,NULL,1,'s73 <= c73',NULL,NULL,12),(420,NULL,NULL,NULL,1,NULL,1,'s74 <= c74',NULL,NULL,12),(421,NULL,NULL,NULL,1,NULL,1,'s75 <= c75',NULL,NULL,12),(422,NULL,NULL,NULL,1,NULL,1,'s76 <= c76',NULL,NULL,12),(423,NULL,NULL,NULL,1,NULL,1,'s77 <= c77',NULL,NULL,12),(424,NULL,NULL,NULL,1,NULL,1,'s78 <= c78',NULL,NULL,12),(425,NULL,NULL,NULL,1,NULL,1,'s79 <= c79',NULL,NULL,12),(426,NULL,NULL,NULL,1,NULL,1,'s80 <= c80',NULL,NULL,12),(427,NULL,NULL,NULL,1,NULL,1,'s81 <= c81',NULL,NULL,12),(428,NULL,NULL,NULL,1,NULL,1,'s82 <= c82',NULL,NULL,12),(429,NULL,NULL,NULL,1,NULL,1,'s86 <= c86',NULL,NULL,12),(430,NULL,NULL,NULL,1,NULL,1,'s87 <= c87',NULL,NULL,12),(431,NULL,NULL,NULL,1,NULL,1,'c57+c58+c59+c60+c61+c62+c63+c64+c65+c66+c67+c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82+c83+c84+c85+c86+c87 == c88',NULL,NULL,12),(432,NULL,NULL,NULL,1,NULL,1,'s57+s58+s59+s61+s62+s63+s64+s65+s66+s67+s68+s69+s70+s71+s72+s73+s74+s75+s76+s77+s78+s79+s80+s81+s82+s86+s87 == s88',NULL,NULL,12),(433,NULL,NULL,NULL,1,NULL,1,'c90+c91+c92 == c93',NULL,NULL,12),(434,NULL,NULL,NULL,1,NULL,1,'c95+c96 == c97',NULL,NULL,12),(435,NULL,NULL,NULL,1,NULL,1,'c106+c107+c108 == c98',NULL,NULL,12),(436,NULL,NULL,NULL,1,NULL,1,'c56+c88+c89+c93 == c94',NULL,NULL,12),(437,NULL,NULL,NULL,1,NULL,1,'c94+c97+c98+c99+c100 == c101',NULL,NULL,12),(438,NULL,NULL,NULL,1,NULL,1,'sau8 == c94',NULL,NULL,12),(439,NULL,NULL,NULL,1,NULL,1,'sat8 == c101',NULL,NULL,12),(440,NULL,NULL,NULL,1,NULL,1,'c110 <= c100*100',NULL,NULL,12),(441,NULL,NULL,NULL,1,NULL,1,'c111 <= c101*100',NULL,NULL,12),(442,NULL,NULL,NULL,1,NULL,1,'for1+for2+for3 == for4',NULL,NULL,12),(443,NULL,NULL,NULL,1,NULL,1,'for4 == c98',NULL,NULL,12),(444,NULL,NULL,NULL,1,NULL,1,'for5+for8+for11 <= for1',NULL,NULL,12),(445,NULL,NULL,NULL,1,NULL,1,'for6+for9+for12 <= for2',NULL,NULL,12),(446,NULL,NULL,NULL,1,NULL,1,'for7+for10+for13 <= for3',NULL,NULL,12),(447,NULL,NULL,NULL,1,NULL,1,'ir0 <= c94+c97',NULL,NULL,12),(448,NULL,NULL,NULL,1,NULL,1,'ir16 <= ir0',NULL,NULL,12),(449,NULL,NULL,NULL,1,NULL,1,'c89 <= 30',NULL,NULL,12),(450,NULL,NULL,NULL,1,NULL,1,'#ir16>= 0.0001*ir20+0.0001*ir21+0.0001*ir22+0.0001*ir23+0.0001*ir24+0.0001*ir25',NULL,NULL,12),(451,NULL,NULL,NULL,1,NULL,1,'ir20 <= ir16',NULL,NULL,12),(452,NULL,NULL,NULL,1,NULL,1,'ir21 <= ir16',NULL,NULL,12),(453,NULL,NULL,NULL,1,NULL,1,'ir22 <= ir16',NULL,NULL,12),(454,NULL,NULL,NULL,1,NULL,1,'ir23 <= ir16',NULL,NULL,12),(455,NULL,NULL,NULL,1,NULL,1,'ir25 <= ir16',NULL,NULL,12),(456,NULL,NULL,NULL,1,NULL,1,'ir24  <=  ir23',NULL,NULL,12),(457,NULL,NULL,NULL,1,NULL,1,'ir20 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,12),(458,NULL,NULL,NULL,1,NULL,1,'ir21 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,12),(459,NULL,NULL,NULL,1,NULL,1,'ir22 <= c94+c97-c38-c40-c41-c43-c44-c89                   ',NULL,NULL,12),(460,NULL,NULL,NULL,1,NULL,1,'ir23 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,12),(461,NULL,NULL,NULL,1,NULL,1,'ir25 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,12),(462,NULL,NULL,NULL,1,NULL,1,'colt1 <= c94',NULL,NULL,12),(463,NULL,NULL,NULL,1,NULL,1,'colt2 <= c94',NULL,NULL,12),(464,NULL,NULL,NULL,1,NULL,1,'colt3 <= c94',NULL,NULL,12),(465,NULL,NULL,NULL,1,NULL,1,'colt4 <= c56+c88',NULL,NULL,12),(466,NULL,NULL,NULL,1,NULL,1,'colt5 <= c93',NULL,NULL,12),(467,NULL,NULL,NULL,1,NULL,1,'colt6 <= c97+c98',NULL,NULL,12),(468,NULL,NULL,NULL,1,NULL,1,'colt7 <= c55',NULL,NULL,12),(469,NULL,NULL,NULL,1,NULL,1,'colt8 <= c99+c100',NULL,NULL,12),(470,NULL,NULL,NULL,1,NULL,1,'colt9 <= c101',NULL,NULL,12),(471,NULL,NULL,NULL,1,NULL,1,'colt9 == colt4+colt5+colt6+colt7+colt8',NULL,NULL,12),(472,NULL,NULL,NULL,1,NULL,1,'colt10 <= c101',NULL,NULL,12),(473,NULL,NULL,NULL,1,NULL,1,'sup1 <= c94+c97',NULL,NULL,12),(474,NULL,NULL,NULL,1,NULL,1,'sup2 <= c94+c97',NULL,NULL,12),(475,NULL,NULL,NULL,1,NULL,1,'sup3 <= c94+c97',NULL,NULL,12),(476,NULL,NULL,NULL,1,NULL,1,'sup4 <= c94+c97',NULL,NULL,12),(477,NULL,NULL,NULL,1,NULL,1,'sup5 <= c94+c97',NULL,NULL,12),(478,NULL,NULL,NULL,1,NULL,1,'sup6 <= c94+c97',NULL,NULL,12),(479,NULL,NULL,NULL,1,NULL,1,'sup7 <= c94+c97',NULL,NULL,12),(480,NULL,NULL,NULL,1,NULL,1,'sup8 <= c94+c97',NULL,NULL,12),(481,NULL,NULL,NULL,1,NULL,1,'sup9 <= c98',NULL,NULL,12),(482,NULL,NULL,NULL,1,NULL,1,'sup10 <= c98',NULL,NULL,12),(483,NULL,NULL,NULL,1,NULL,1,'sup11 <= c98',NULL,NULL,12),(484,NULL,NULL,NULL,1,NULL,1,'sup12 <= c98',NULL,NULL,12),(485,NULL,NULL,NULL,1,NULL,1,'sup13 <= c98',NULL,NULL,12),(486,NULL,NULL,NULL,1,NULL,1,'sup14 <= c98',NULL,NULL,12),(487,NULL,NULL,NULL,1,NULL,1,'bio1 <= c1+c2+c3+c4+c5+c6+c7+c8+c9+c10',NULL,NULL,12),(488,NULL,NULL,NULL,1,NULL,1,'bio2 <= c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41',NULL,NULL,12),(489,NULL,NULL,NULL,1,NULL,1,'bio3 <= c57+c58+c59+c60',NULL,NULL,12),(490,NULL,NULL,NULL,1,NULL,1,'bio4 <= c61+c62',NULL,NULL,12),(491,NULL,NULL,NULL,1,NULL,1,'bio5 <= c63+c64+c65+c66+c67',NULL,NULL,12),(492,NULL,NULL,NULL,1,NULL,1,'bio6 <= c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82',NULL,NULL,12),(493,NULL,NULL,NULL,1,NULL,1,'bio7 <= c93',NULL,NULL,12),(494,NULL,NULL,NULL,1,NULL,1,'bio8 <= c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55+c83+c84+c85+c86+c87+c89 ',NULL,NULL,12),(495,NULL,NULL,NULL,1,NULL,1,'bio9 == bio1+bio2+bio3+bio4+bio5+bio6+bio7+bio8',NULL,NULL,12),(496,NULL,NULL,NULL,1,NULL,1,'bio10 <= c94',NULL,NULL,12),(497,NULL,NULL,NULL,1,NULL,1,'pra1 <= c94',NULL,NULL,12),(498,NULL,NULL,NULL,1,NULL,1,'pra2 <= c94',NULL,NULL,12),(499,NULL,NULL,NULL,1,NULL,1,'pra3 <= c94',NULL,NULL,12),(500,NULL,NULL,NULL,1,NULL,1,'pra4 <= c94',NULL,NULL,12),(501,NULL,NULL,NULL,1,NULL,1,'pra5 <= c94',NULL,NULL,12),(502,NULL,NULL,NULL,1,NULL,1,'pra6 <= c94 ',NULL,NULL,12),(503,NULL,NULL,NULL,1,NULL,1,'edit',NULL,NULL,13),(504,NULL,NULL,NULL,1,NULL,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,13),(505,NULL,NULL,NULL,1,NULL,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,13),(506,NULL,NULL,NULL,1,NULL,1,'sau1 <= sat1',NULL,NULL,13),(507,NULL,NULL,NULL,1,NULL,1,'sau2 <= sat2',NULL,NULL,13),(508,NULL,NULL,NULL,1,NULL,1,'sau3 <= sat3',NULL,NULL,13),(509,NULL,NULL,NULL,1,NULL,1,'sau4 <= sat4',NULL,NULL,13),(510,NULL,NULL,NULL,1,NULL,1,'sau5 <= sat5',NULL,NULL,13),(511,NULL,NULL,NULL,1,NULL,1,'sau6 <= sat6',NULL,NULL,13),(512,NULL,NULL,NULL,1,NULL,1,'sau7 <= sat7',NULL,NULL,13),(513,NULL,NULL,NULL,1,NULL,1,'c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55 == c56',NULL,NULL,13),(514,NULL,NULL,NULL,1,NULL,1,'s57 <= c57',NULL,NULL,13),(515,NULL,NULL,NULL,1,NULL,1,'s58 <= c58',NULL,NULL,13),(516,NULL,NULL,NULL,1,NULL,1,'s59 <= c59',NULL,NULL,13),(517,NULL,NULL,NULL,1,NULL,1,'s61 <= c61',NULL,NULL,13),(518,NULL,NULL,NULL,1,NULL,1,'s62 <= c62',NULL,NULL,13),(519,NULL,NULL,NULL,1,NULL,1,'s63 <= c63',NULL,NULL,13),(520,NULL,NULL,NULL,1,NULL,1,'s64 <= c64',NULL,NULL,13),(521,NULL,NULL,NULL,1,NULL,1,'s65 <= c65',NULL,NULL,13),(522,NULL,NULL,NULL,1,NULL,1,'s66 <= c66',NULL,NULL,13),(523,NULL,NULL,NULL,1,NULL,1,'s67 <= c67',NULL,NULL,13),(524,NULL,NULL,NULL,1,NULL,1,'s68 <= c68',NULL,NULL,13),(525,NULL,NULL,NULL,1,NULL,1,'s69 <= c69',NULL,NULL,13),(526,NULL,NULL,NULL,1,NULL,1,'s70 <= c70',NULL,NULL,13),(527,NULL,NULL,NULL,1,NULL,1,'s71 <= c71',NULL,NULL,13),(528,NULL,NULL,NULL,1,NULL,1,'s72 <= c72',NULL,NULL,13),(529,NULL,NULL,NULL,1,NULL,1,'s73 <= c73',NULL,NULL,13),(530,NULL,NULL,NULL,1,NULL,1,'s74 <= c74',NULL,NULL,13),(531,NULL,NULL,NULL,1,NULL,1,'s75 <= c75',NULL,NULL,13),(532,NULL,NULL,NULL,1,NULL,1,'s76 <= c76',NULL,NULL,13),(533,NULL,NULL,NULL,1,NULL,1,'s77 <= c77',NULL,NULL,13),(534,NULL,NULL,NULL,1,NULL,1,'s78 <= c78',NULL,NULL,13),(535,NULL,NULL,NULL,1,NULL,1,'s79 <= c79',NULL,NULL,13),(536,NULL,NULL,NULL,1,NULL,1,'s80 <= c80',NULL,NULL,13),(537,NULL,NULL,NULL,1,NULL,1,'s81 <= c81',NULL,NULL,13),(538,NULL,NULL,NULL,1,NULL,1,'s82 <= c82',NULL,NULL,13),(539,NULL,NULL,NULL,1,NULL,1,'s86 <= c86',NULL,NULL,13),(540,NULL,NULL,NULL,1,NULL,1,'s87 <= c87',NULL,NULL,13),(541,NULL,NULL,NULL,1,NULL,1,'c57+c58+c59+c60+c61+c62+c63+c64+c65+c66+c67+c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82+c83+c84+c85+c86+c87 == c88',NULL,NULL,13),(542,NULL,NULL,NULL,1,NULL,1,'s57+s58+s59+s61+s62+s63+s64+s65+s66+s67+s68+s69+s70+s71+s72+s73+s74+s75+s76+s77+s78+s79+s80+s81+s82+s86+s87 == s88',NULL,NULL,13),(543,NULL,NULL,NULL,1,NULL,1,'c90+c91+c92 == c93',NULL,NULL,13),(544,NULL,NULL,NULL,1,NULL,1,'c95+c96 == c97',NULL,NULL,13),(545,NULL,NULL,NULL,1,NULL,1,'c106+c107+c108 == c98',NULL,NULL,13),(546,NULL,NULL,NULL,1,NULL,1,'c56+c88+c89+c93 == c94',NULL,NULL,13),(547,NULL,NULL,NULL,1,NULL,1,'c94+c97+c98+c99+c100 == c101',NULL,NULL,13),(548,NULL,NULL,NULL,1,NULL,1,'sau8 == c94',NULL,NULL,13),(549,NULL,NULL,NULL,1,NULL,1,'sat8 == c101',NULL,NULL,13),(550,NULL,NULL,NULL,1,NULL,1,'c110 <= c100*100',NULL,NULL,13),(551,NULL,NULL,NULL,1,NULL,1,'c111 <= c101*100',NULL,NULL,13),(552,NULL,NULL,NULL,1,NULL,1,'for1+for2+for3 == for4',NULL,NULL,13),(553,NULL,NULL,NULL,1,NULL,1,'for4 == c98',NULL,NULL,13),(554,NULL,NULL,NULL,1,NULL,1,'for5+for8+for11 <= for1',NULL,NULL,13),(555,NULL,NULL,NULL,1,NULL,1,'for6+for9+for12 <= for2',NULL,NULL,13),(556,NULL,NULL,NULL,1,NULL,1,'for7+for10+for13 <= for3',NULL,NULL,13),(557,NULL,NULL,NULL,1,NULL,1,'ir0 <= c94+c97',NULL,NULL,13),(558,NULL,NULL,NULL,1,NULL,1,'ir16 <= ir0',NULL,NULL,13),(559,NULL,NULL,NULL,1,NULL,1,'c89 <= 30',NULL,NULL,13),(560,NULL,NULL,NULL,1,NULL,1,'#ir16>= 0.0001*ir20+0.0001*ir21+0.0001*ir22+0.0001*ir23+0.0001*ir24+0.0001*ir25',NULL,NULL,13),(561,NULL,NULL,NULL,1,NULL,1,'ir20 <= ir16',NULL,NULL,13),(562,NULL,NULL,NULL,1,NULL,1,'ir21 <= ir16',NULL,NULL,13),(563,NULL,NULL,NULL,1,NULL,1,'ir22 <= ir16',NULL,NULL,13),(564,NULL,NULL,NULL,1,NULL,1,'ir23 <= ir16',NULL,NULL,13),(565,NULL,NULL,NULL,1,NULL,1,'ir25 <= ir16',NULL,NULL,13),(566,NULL,NULL,NULL,1,NULL,1,'ir24  <=  ir23',NULL,NULL,13),(567,NULL,NULL,NULL,1,NULL,1,'ir20 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,13),(568,NULL,NULL,NULL,1,NULL,1,'ir21 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,13),(569,NULL,NULL,NULL,1,NULL,1,'ir22 <= c94+c97-c38-c40-c41-c43-c44-c89                   ',NULL,NULL,13),(570,NULL,NULL,NULL,1,NULL,1,'ir23 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,13),(571,NULL,NULL,NULL,1,NULL,1,'ir25 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,13),(572,NULL,NULL,NULL,1,NULL,1,'colt1 <= c94',NULL,NULL,13),(573,NULL,NULL,NULL,1,NULL,1,'colt2 <= c94',NULL,NULL,13),(574,NULL,NULL,NULL,1,NULL,1,'colt3 <= c94',NULL,NULL,13),(575,NULL,NULL,NULL,1,NULL,1,'colt4 <= c56+c88',NULL,NULL,13),(576,NULL,NULL,NULL,1,NULL,1,'colt5 <= c93',NULL,NULL,13),(577,NULL,NULL,NULL,1,NULL,1,'colt6 <= c97+c98',NULL,NULL,13),(578,NULL,NULL,NULL,1,NULL,1,'colt7 <= c55',NULL,NULL,13),(579,NULL,NULL,NULL,1,NULL,1,'colt8 <= c99+c100',NULL,NULL,13),(580,NULL,NULL,NULL,1,NULL,1,'colt9 <= c101',NULL,NULL,13),(581,NULL,NULL,NULL,1,NULL,1,'colt9 == colt4+colt5+colt6+colt7+colt8',NULL,NULL,13),(582,NULL,NULL,NULL,1,NULL,1,'colt10 <= c101',NULL,NULL,13),(583,NULL,NULL,NULL,1,NULL,1,'sup1 <= c94+c97',NULL,NULL,13),(584,NULL,NULL,NULL,1,NULL,1,'sup2 <= c94+c97',NULL,NULL,13),(585,NULL,NULL,NULL,1,NULL,1,'sup3 <= c94+c97',NULL,NULL,13),(586,NULL,NULL,NULL,1,NULL,1,'sup4 <= c94+c97',NULL,NULL,13),(587,NULL,NULL,NULL,1,NULL,1,'sup5 <= c94+c97',NULL,NULL,13),(588,NULL,NULL,NULL,1,NULL,1,'sup6 <= c94+c97',NULL,NULL,13),(589,NULL,NULL,NULL,1,NULL,1,'sup7 <= c94+c97',NULL,NULL,13),(590,NULL,NULL,NULL,1,NULL,1,'sup8 <= c94+c97',NULL,NULL,13),(591,NULL,NULL,NULL,1,NULL,1,'sup9 <= c98',NULL,NULL,13),(592,NULL,NULL,NULL,1,NULL,1,'sup10 <= c98',NULL,NULL,13),(593,NULL,NULL,NULL,1,NULL,1,'sup11 <= c98',NULL,NULL,13),(594,NULL,NULL,NULL,1,NULL,1,'sup12 <= c98',NULL,NULL,13),(595,NULL,NULL,NULL,1,NULL,1,'sup13 <= c98',NULL,NULL,13),(596,NULL,NULL,NULL,1,NULL,1,'sup14 <= c98',NULL,NULL,13),(597,NULL,NULL,NULL,1,NULL,1,'bio1 <= c1+c2+c3+c4+c5+c6+c7+c8+c9+c10',NULL,NULL,13),(598,NULL,NULL,NULL,1,NULL,1,'bio2 <= c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41',NULL,NULL,13),(599,NULL,NULL,NULL,1,NULL,1,'bio3 <= c57+c58+c59+c60',NULL,NULL,13),(600,NULL,NULL,NULL,1,NULL,1,'bio4 <= c61+c62',NULL,NULL,13),(601,NULL,NULL,NULL,1,NULL,1,'bio5 <= c63+c64+c65+c66+c67',NULL,NULL,13),(602,NULL,NULL,NULL,1,NULL,1,'bio6 <= c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82',NULL,NULL,13),(603,NULL,NULL,NULL,1,NULL,1,'bio7 <= c93',NULL,NULL,13),(604,NULL,NULL,NULL,1,NULL,1,'bio8 <= c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55+c83+c84+c85+c86+c87+c89 ',NULL,NULL,13),(605,NULL,NULL,NULL,1,NULL,1,'bio9 == bio1+bio2+bio3+bio4+bio5+bio6+bio7+bio8',NULL,NULL,13),(606,NULL,NULL,NULL,1,NULL,1,'bio10 <= c94',NULL,NULL,13),(607,NULL,NULL,NULL,1,NULL,1,'pra1 <= c94',NULL,NULL,13),(608,NULL,NULL,NULL,1,NULL,1,'pra2 <= c94',NULL,NULL,13),(609,NULL,NULL,NULL,1,NULL,1,'pra3 <= c94',NULL,NULL,13),(610,NULL,NULL,NULL,1,NULL,1,'pra4 <= c94',NULL,NULL,13),(611,NULL,NULL,NULL,1,NULL,1,'pra5 <= c94',NULL,NULL,13),(612,NULL,NULL,NULL,1,NULL,1,'pra6 <= c94 ',NULL,NULL,13),(613,NULL,NULL,NULL,1,NULL,1,'edit',NULL,NULL,14),(614,NULL,NULL,NULL,1,NULL,1,'sat1+sat2+sat3+sat4+sat5+sat6+sat7 == sat8 ',NULL,NULL,14),(615,NULL,NULL,NULL,1,NULL,1,'sau1+sau2+sau3+sau4+sau5+sau6+sau7 == sau8 ',NULL,NULL,14),(616,NULL,NULL,NULL,1,NULL,1,'sau1 <= sat1',NULL,NULL,14),(617,NULL,NULL,NULL,1,NULL,1,'sau2 <= sat2',NULL,NULL,14),(618,NULL,NULL,NULL,1,NULL,1,'sau3 <= sat3',NULL,NULL,14),(619,NULL,NULL,NULL,1,NULL,1,'sau4 <= sat4',NULL,NULL,14),(620,NULL,NULL,NULL,1,NULL,1,'sau5 <= sat5',NULL,NULL,14),(621,NULL,NULL,NULL,1,NULL,1,'sau6 <= sat6',NULL,NULL,14),(622,NULL,NULL,NULL,1,NULL,1,'sau7 <= sat7',NULL,NULL,14),(623,NULL,NULL,NULL,1,NULL,1,'c1+c2+c3+c4+c5+c6+c7+c8+c9+c10+c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55 == c56',NULL,NULL,14),(624,NULL,NULL,NULL,1,NULL,1,'s57 <= c57',NULL,NULL,14),(625,NULL,NULL,NULL,1,NULL,1,'s58 <= c58',NULL,NULL,14),(626,NULL,NULL,NULL,1,NULL,1,'s59 <= c59',NULL,NULL,14),(627,NULL,NULL,NULL,1,NULL,1,'s61 <= c61',NULL,NULL,14),(628,NULL,NULL,NULL,1,NULL,1,'s62 <= c62',NULL,NULL,14),(629,NULL,NULL,NULL,1,NULL,1,'s63 <= c63',NULL,NULL,14),(630,NULL,NULL,NULL,1,NULL,1,'s64 <= c64',NULL,NULL,14),(631,NULL,NULL,NULL,1,NULL,1,'s65 <= c65',NULL,NULL,14),(632,NULL,NULL,NULL,1,NULL,1,'s66 <= c66',NULL,NULL,14),(633,NULL,NULL,NULL,1,NULL,1,'s67 <= c67',NULL,NULL,14),(634,NULL,NULL,NULL,1,NULL,1,'s68 <= c68',NULL,NULL,14),(635,NULL,NULL,NULL,1,NULL,1,'s69 <= c69',NULL,NULL,14),(636,NULL,NULL,NULL,1,NULL,1,'s70 <= c70',NULL,NULL,14),(637,NULL,NULL,NULL,1,NULL,1,'s71 <= c71',NULL,NULL,14),(638,NULL,NULL,NULL,1,NULL,1,'s72 <= c72',NULL,NULL,14),(639,NULL,NULL,NULL,1,NULL,1,'s73 <= c73',NULL,NULL,14),(640,NULL,NULL,NULL,1,NULL,1,'s74 <= c74',NULL,NULL,14),(641,NULL,NULL,NULL,1,NULL,1,'s75 <= c75',NULL,NULL,14),(642,NULL,NULL,NULL,1,NULL,1,'s76 <= c76',NULL,NULL,14),(643,NULL,NULL,NULL,1,NULL,1,'s77 <= c77',NULL,NULL,14),(644,NULL,NULL,NULL,1,NULL,1,'s78 <= c78',NULL,NULL,14),(645,NULL,NULL,NULL,1,NULL,1,'s79 <= c79',NULL,NULL,14),(646,NULL,NULL,NULL,1,NULL,1,'s80 <= c80',NULL,NULL,14),(647,NULL,NULL,NULL,1,NULL,1,'s81 <= c81',NULL,NULL,14),(648,NULL,NULL,NULL,1,NULL,1,'s82 <= c82',NULL,NULL,14),(649,NULL,NULL,NULL,1,NULL,1,'s86 <= c86',NULL,NULL,14),(650,NULL,NULL,NULL,1,NULL,1,'s87 <= c87',NULL,NULL,14),(651,NULL,NULL,NULL,1,NULL,1,'c57+c58+c59+c60+c61+c62+c63+c64+c65+c66+c67+c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82+c83+c84+c85+c86+c87 == c88',NULL,NULL,14),(652,NULL,NULL,NULL,1,NULL,1,'s57+s58+s59+s61+s62+s63+s64+s65+s66+s67+s68+s69+s70+s71+s72+s73+s74+s75+s76+s77+s78+s79+s80+s81+s82+s86+s87 == s88',NULL,NULL,14),(653,NULL,NULL,NULL,1,NULL,1,'c90+c91+c92 == c93',NULL,NULL,14),(654,NULL,NULL,NULL,1,NULL,1,'c95+c96 == c97',NULL,NULL,14),(655,NULL,NULL,NULL,1,NULL,1,'c106+c107+c108 == c98',NULL,NULL,14),(656,NULL,NULL,NULL,1,NULL,1,'c56+c88+c89+c93 == c94',NULL,NULL,14),(657,NULL,NULL,NULL,1,NULL,1,'c94+c97+c98+c99+c100 == c101',NULL,NULL,14),(658,NULL,NULL,NULL,1,NULL,1,'sau8 == c94',NULL,NULL,14),(659,NULL,NULL,NULL,1,NULL,1,'sat8 == c101',NULL,NULL,14),(660,NULL,NULL,NULL,1,NULL,1,'c110 <= c100*100',NULL,NULL,14),(661,NULL,NULL,NULL,1,NULL,1,'c111 <= c101*100',NULL,NULL,14),(662,NULL,NULL,NULL,1,NULL,1,'for1+for2+for3 == for4',NULL,NULL,14),(663,NULL,NULL,NULL,1,NULL,1,'for4 == c98',NULL,NULL,14),(664,NULL,NULL,NULL,1,NULL,1,'for5+for8+for11 <= for1',NULL,NULL,14),(665,NULL,NULL,NULL,1,NULL,1,'for6+for9+for12 <= for2',NULL,NULL,14),(666,NULL,NULL,NULL,1,NULL,1,'for7+for10+for13 <= for3',NULL,NULL,14),(667,NULL,NULL,NULL,1,NULL,1,'ir0 <= c94+c97',NULL,NULL,14),(668,NULL,NULL,NULL,1,NULL,1,'ir16 <= ir0',NULL,NULL,14),(669,NULL,NULL,NULL,1,NULL,1,'c89 <= 30',NULL,NULL,14),(670,NULL,NULL,NULL,1,NULL,1,'#ir16>= 0.0001*ir20+0.0001*ir21+0.0001*ir22+0.0001*ir23+0.0001*ir24+0.0001*ir25',NULL,NULL,14),(671,NULL,NULL,NULL,1,NULL,1,'ir20 <= ir16',NULL,NULL,14),(672,NULL,NULL,NULL,1,NULL,1,'ir21 <= ir16',NULL,NULL,14),(673,NULL,NULL,NULL,1,NULL,1,'ir22 <= ir16',NULL,NULL,14),(674,NULL,NULL,NULL,1,NULL,1,'ir23 <= ir16',NULL,NULL,14),(675,NULL,NULL,NULL,1,NULL,1,'ir25 <= ir16',NULL,NULL,14),(676,NULL,NULL,NULL,1,NULL,1,'ir24  <=  ir23',NULL,NULL,14),(677,NULL,NULL,NULL,1,NULL,1,'ir20 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,14),(678,NULL,NULL,NULL,1,NULL,1,'ir21 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,14),(679,NULL,NULL,NULL,1,NULL,1,'ir22 <= c94+c97-c38-c40-c41-c43-c44-c89                   ',NULL,NULL,14),(680,NULL,NULL,NULL,1,NULL,1,'ir23 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,14),(681,NULL,NULL,NULL,1,NULL,1,'ir25 <= c94+c97-c38-c104-c40-c105-c41-c43-c44-c89',NULL,NULL,14),(682,NULL,NULL,NULL,1,NULL,1,'colt1 <= c94',NULL,NULL,14),(683,NULL,NULL,NULL,1,NULL,1,'colt2 <= c94',NULL,NULL,14),(684,NULL,NULL,NULL,1,NULL,1,'colt3 <= c94',NULL,NULL,14),(685,NULL,NULL,NULL,1,NULL,1,'colt4 <= c56+c88',NULL,NULL,14),(686,NULL,NULL,NULL,1,NULL,1,'colt5 <= c93',NULL,NULL,14),(687,NULL,NULL,NULL,1,NULL,1,'colt6 <= c97+c98',NULL,NULL,14),(688,NULL,NULL,NULL,1,NULL,1,'colt7 <= c55',NULL,NULL,14),(689,NULL,NULL,NULL,1,NULL,1,'colt8 <= c99+c100',NULL,NULL,14),(690,NULL,NULL,NULL,1,NULL,1,'colt9 <= c101',NULL,NULL,14),(691,NULL,NULL,NULL,1,NULL,1,'colt9 == colt4+colt5+colt6+colt7+colt8',NULL,NULL,14),(692,NULL,NULL,NULL,1,NULL,1,'colt10 <= c101',NULL,NULL,14),(693,NULL,NULL,NULL,1,NULL,1,'sup1 <= c94+c97',NULL,NULL,14),(694,NULL,NULL,NULL,1,NULL,1,'sup2 <= c94+c97',NULL,NULL,14),(695,NULL,NULL,NULL,1,NULL,1,'sup3 <= c94+c97',NULL,NULL,14),(696,NULL,NULL,NULL,1,NULL,1,'sup4 <= c94+c97',NULL,NULL,14),(697,NULL,NULL,NULL,1,NULL,1,'sup5 <= c94+c97',NULL,NULL,14),(698,NULL,NULL,NULL,1,NULL,1,'sup6 <= c94+c97',NULL,NULL,14),(699,NULL,NULL,NULL,1,NULL,1,'sup7 <= c94+c97',NULL,NULL,14),(700,NULL,NULL,NULL,1,NULL,1,'sup8 <= c94+c97',NULL,NULL,14),(701,NULL,NULL,NULL,1,NULL,1,'sup9 <= c98',NULL,NULL,14),(702,NULL,NULL,NULL,1,NULL,1,'sup10 <= c98',NULL,NULL,14),(703,NULL,NULL,NULL,1,NULL,1,'sup11 <= c98',NULL,NULL,14),(704,NULL,NULL,NULL,1,NULL,1,'sup12 <= c98',NULL,NULL,14),(705,NULL,NULL,NULL,1,NULL,1,'sup13 <= c98',NULL,NULL,14),(706,NULL,NULL,NULL,1,NULL,1,'sup14 <= c98',NULL,NULL,14),(707,NULL,NULL,NULL,1,NULL,1,'bio1 <= c1+c2+c3+c4+c5+c6+c7+c8+c9+c10',NULL,NULL,14),(708,NULL,NULL,NULL,1,NULL,1,'bio2 <= c32+c33+c102+c34+c35+c103+c37+c38+c104+c40+c105+c41',NULL,NULL,14),(709,NULL,NULL,NULL,1,NULL,1,'bio3 <= c57+c58+c59+c60',NULL,NULL,14),(710,NULL,NULL,NULL,1,NULL,1,'bio4 <= c61+c62',NULL,NULL,14),(711,NULL,NULL,NULL,1,NULL,1,'bio5 <= c63+c64+c65+c66+c67',NULL,NULL,14),(712,NULL,NULL,NULL,1,NULL,1,'bio6 <= c68+c69+c70+c71+c72+c73+c74+c75+c76+c77+c78+c79+c80+c81+c82',NULL,NULL,14),(713,NULL,NULL,NULL,1,NULL,1,'bio7 <= c93',NULL,NULL,14),(714,NULL,NULL,NULL,1,NULL,1,'bio8 <= c11+c13+c14+c16+c17+c18+c19+c20+c21+c22+c23+c24+c25+c26+c27+c28+c29+c30+c31+c42+c43+c44+c45+c46+c47+c48+c50+c52+c53+c54+c55+c83+c84+c85+c86+c87+c89 ',NULL,NULL,14),(715,NULL,NULL,NULL,1,NULL,1,'bio9 == bio1+bio2+bio3+bio4+bio5+bio6+bio7+bio8',NULL,NULL,14),(716,NULL,NULL,NULL,1,NULL,1,'bio10 <= c94',NULL,NULL,14),(717,NULL,NULL,NULL,1,NULL,1,'pra1 <= c94',NULL,NULL,14),(718,NULL,NULL,NULL,1,NULL,1,'pra2 <= c94',NULL,NULL,14),(719,NULL,NULL,NULL,1,NULL,1,'pra3 <= c94',NULL,NULL,14),(720,NULL,NULL,NULL,1,NULL,1,'pra4 <= c94',NULL,NULL,14),(721,NULL,NULL,NULL,1,NULL,1,'pra5 <= c94',NULL,NULL,14),(722,NULL,NULL,NULL,1,NULL,1,'pra6 <= c94 ',NULL,NULL,14);
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
  `Descrizione` text COLLATE utf8mb4_unicode_ci,
  `Nome` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_rule_type`
--

LOCK TABLES `sx_rule_type` WRITE;
/*!40000 ALTER TABLE `sx_rule_type` DISABLE KEYS */;
INSERT INTO `sx_rule_type` VALUES (1,'regoole','r1');
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
  `NOME` varchar(50) DEFAULT NULL,
  `DESCR` varchar(50) DEFAULT NULL,
  `SESSIONE_LAVORO` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014346` (`ID`),
  KEY `ws_idx` (`SESSIONE_LAVORO`),
  CONSTRAINT `ws` FOREIGN KEY (`SESSIONE_LAVORO`) REFERENCES `sx_sessione_lavoro` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_ruleset`
--

LOCK TABLES `sx_ruleset` WRITE;
/*!40000 ALTER TABLE `sx_ruleset` DISABLE KEYS */;
INSERT INTO `sx_ruleset` VALUES (4,'cross.prod.ruleset','Regole per il prodotto cartesiano',NULL),(9,NULL,'edits.txt,',NULL),(10,NULL,'edits.txt,',NULL),(11,NULL,'edits.txt,',NULL),(12,NULL,'edits.txt,',12),(13,NULL,'edits.txt,',11),(14,NULL,'edits.txt,',11);
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
INSERT INTO `sx_ruoli` VALUES (0,'SKIP','N','VARIABILE NON UTILIZZATA',100,1,1),(1,'IDENTIFICATIVO','I','CHIAVE OSSERVAZIONE',100,1,1),(2,'TARGET','Y','VARIABILE DI OGGETTO DI ANALISI',100,3,1),(3,'COVARIATA','X','VARIABILE INDIPENDENTE',100,4,1),(4,'PREDIZIONE','P','VARIABILE DI PREDIZIONE',100,5,1),(5,'OUTLIER','O','FLAG OUTLIER',100,6,1),(6,'PESO','W','PESO CAMPIONARIO',100,7,1),(7,'ERRORE','E','ERRORE INFLUENTE',100,10,1),(8,'RANKING','R','INFLUENCE RANKING',100,11,1),(9,'OUTPUT','T','VARIABILE DI OUTPUT',100,20,1),(10,'STRATO','S','PARTIZIONAMENTO DEL DATASET',100,2,1),(11,'PARAMETRI','Z','PARAMETRI DI INPUT',100,997,2),(12,'MODELLO','M','MODELLO DATI',100,998,2),(13,'SCORE','F','INFLUENCE SCORE',100,12,1),(14,'INFO','G','PARAMETRI OUT - INFO RIEPILOGO',100,999,1),(100,'SKIP','N','VARIABILE NON UTILIZZATA',200,100,1),(102,'CHIAVE A','K1','CHIAVE DATASET A',200,3,1),(103,'CHIAVE B','K2','CHIAVE DATASET B',200,4,1),(104,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',200,5,1),(105,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',200,6,1),(108,'RANKING','M','INFLUENCE RANKING',200,11,2),(110,'STRATO','S','PARTIZIONAMENTO DEL DATASET',200,2,1),(111,'RESULT','R','RISULTATO PRODOTTO CARTESIANO',200,10,2),(115,'BLOCKING','B','SLICING DEL DATASET',200,3,1),(150,'SKIP','N','VARIABILE NON UTILIZZATA',250,100,1),(152,'KEY A','K1','CHIAVE DATASET A',250,3,1),(153,'KEY B','K2','CHIAVE DATASET B',250,4,1),(154,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',250,5,1),(155,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',250,6,1),(158,'RANKING','M','INFLUENCE RANKING',250,11,2),(160,'STRATA','S','PARTIZIONAMENTO DEL DATASET',250,2,1),(161,'CONTENGENCY TABLE','CT','CONTENGENCY TABLE',250,10,2),(165,'BLOCKING','B','SLICING DEL DATASET',250,3,1),(166,'MATCHING ','X','VARIABLI DI MATCHING',250,1,2),(167,'FELLEGI-SUNTER','FS','FELLEGI-SUNTER',200,2,1),(168,'MATCHING TABLE','MT','MATCHING TABLE',200,3,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_sessione_lavoro`
--

LOCK TABLES `sx_sessione_lavoro` WRITE;
/*!40000 ALTER TABLE `sx_sessione_lavoro` DISABLE KEYS */;
INSERT INTO `sx_sessione_lavoro` VALUES (2,445,'2019-05-17','nuovaSessione',''),(11,83,'2019-06-12','medi',''),(12,83,'2019-06-12','altridataset','');
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
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_pattern`
--

LOCK TABLES `sx_step_pattern` WRITE;
/*!40000 ALTER TABLE `sx_step_pattern` DISABLE KEYS */;
INSERT INTO `sx_step_pattern` VALUES (154,11,154,1),(155,11,155,1),(158,11,158,2),(161,11,161,2),(165,11,165,1),(166,11,166,1),(167,12,161,1),(168,12,167,2),(169,13,154,1),(170,13,155,1),(171,13,167,1),(172,13,161,1),(173,13,168,2);
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
INSERT INTO `sx_tipo_stato` VALUES (1,'INPUT'),(2,'OUTPUT');
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
) ENGINE=InnoDB AUTO_INCREMENT=452 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_users`
--

LOCK TABLES `sx_users` WRITE;
/*!40000 ALTER TABLE `sx_users` DISABLE KEYS */;
INSERT INTO `sx_users` VALUES (83,'fra@fra.it','Francesco Amato','fra','$2a$10$DIcyvIFwhDkEOT9nBugTleDM73OkZffZUdfmvjMCEXdJr3PZP8Kxm',1),(243,'user@is2.it','user','test','$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82',2),(445,'admin@is2.it','Administrator','admin','$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC',1),(451,'survey@istat.it','francesci','sada','$2a$10$SBKYfMVUdHl.1mY2BGuG1uGBE.xRcpJsIC.dyJBfS2Cyl6FEYSwg.',1);
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

-- Dump completed on 2019-06-19 16:28:08
