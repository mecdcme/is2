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
INSERT INTO `sx_app_instance` VALUES (1,10),(2,20),(3,30),(2,40),(4,50),(8,25),(9,35),(7,15);
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
  `CO01E` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014219` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_app_service`
--

LOCK TABLES `sx_app_service` WRITE;
/*!40000 ALTER TABLE `sx_app_service` DISABLE KEYS */;
INSERT INTO `sx_app_service` VALUES (100,'SeleMix','Individuazione valori anomali tramite misture','R STATISTICAL LANGUAGE','SS_selemix.r',100),(200,'Relais','Record Linkage','R STATISTICAL LANGUAGE','SS_relais.r',200),(300,'Validate','Validazione e gestione delle regole','R STATISTICAL LANGUAGE','SS_validate.r',300);
/*!40000 ALTER TABLE `sx_app_service` ENABLE KEYS */;
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
INSERT INTO `sx_bfunc_bprocess` VALUES (10,10),(15,15),(20,20),(25,25),(30,30),(35,35),(40,40),(50,50),(70,60),(80,10),(80,30);
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
INSERT INTO `sx_bprocess_bstep` VALUES (10,10),(15,15),(20,20),(25,25),(30,30),(35,35),(40,40),(50,50),(60,10),(60,30);
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_function`
--

LOCK TABLES `sx_business_function` WRITE;
/*!40000 ALTER TABLE `sx_business_function` DISABLE KEYS */;
INSERT INTO `sx_business_function` VALUES (10,'Stima e Predizione','Esegue la stima del modello dati e lo applica per produrre una predizione del dato','Stima'),(15,'Stima e Predizione a Strati','Esegue la stima a strati del modello dati e lo applica per produrre una predizione del dato','Stima a Strati'),(20,'Predizione da Modello','Produce una predizione del dato, in base al modello dati che deve essere fornito in input','Predizione'),(25,'Predizione da Modello a Strati','Produce una predizione del dato stratificato, basata sul modello fornito in input','Predizione a Strati'),(30,'Selezione Errori Influenti monostep','Valuta gli errori influenti, in base alla predizione che deve essere fornita in input','Selezione'),(35,'Selezione Errori Influenti monostep a Strati','Valutazione stratificata degli errori influenti, in base alla predizione fornita in input','Selezione a Strati'),(40,'Ricerca Outlier','Ricerca Outlier. Esegue Predizione, perciò necessita di un modello in input','Outlier'),(50,'Stima del modello dati','Esegue la stima per ritornare solamente il modello dei dati','Modello'),(70,'Selezione Errori Influenti multi step','Esegue la stima, predizione e valuta gli errori influenti automaticamente in due step','Selezione2S'),(80,'Selezione Errori Influenti multi process','Esegue la stima, predizione e valuta gli errori influenti in due processi successivi','Selezione2P');
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_process`
--

LOCK TABLES `sx_business_process` WRITE;
/*!40000 ALTER TABLE `sx_business_process` DISABLE KEYS */;
INSERT INTO `sx_business_process` VALUES (10,'Stima e Predizione','Escuzione del processo di stima e predizione','Estimates',1),(15,'Stima e Predizione a strati','Escuzione del processo di stima e predizione su strato','Strata Estimates',1),(20,'Predizione con modello','Esecuzione del processo di stima da modello','Pre01tion',2),(25,'Predizione con modello a Strati','Esecuzione del processo di stima da modello stratificato','Strata Pre01tion',2),(30,'Editing Selettivo','Esecuzione del processo di selezione dei valori influenti','Selection',3),(35,'Editing Selettivo a Strati','Esecuzione del processo di selezione dei valori influenti Stratificato','Strata Selection',3),(40,'Individuazione Outlier','Esecuzione del processo di individuazione degli Outlier','Outlier',2),(50,'Stima modello dati','Stima del modello dati','Model',1),(60,'Stima e selezione','Esecuzione del processo di stima, predizione e selezione automatica','Bistep',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_step`
--

LOCK TABLES `sx_business_step` WRITE;
/*!40000 ALTER TABLE `sx_business_step` DISABLE KEYS */;
INSERT INTO `sx_business_step` VALUES (10,'MLEST','Stima',1),(15,'STMLEST','Stima stratificata',1),(20,'PRED','Predizione',2),(25,'STRPRED','Predizione stratificata',2),(30,'SELED','Editing Seletivo',3),(35,'STRSELED','Editing Seletivo Stratificato',3),(40,'OUTL','Scelta Outlier',2),(50,'MOD','Imposta Modello',1);
/*!40000 ALTER TABLE `sx_business_step` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_dataset_colonna`
--

DROP TABLE IF EXISTS `sx_dataset_colonna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_dataset_colonna` (
  `IDCOL` int(11) NOT NULL,
  `NOME` varchar(255) DEFAULT NULL,
  `ORDINE` int(20) DEFAULT NULL,
  `ELABORAZIONE` int(20) DEFAULT NULL,
  `DATICOLONNA` longblob,
  `DATASET_FILE` int(20) DEFAULT NULL,
  `TIPO_VARIABILE` int(20) DEFAULT NULL,
  `FILTRO` int(20) DEFAULT NULL,
  `VALORI_SIZE` int(20) DEFAULT NULL,
  PRIMARY KEY (`IDCOL`),
  UNIQUE KEY `SX_DATASET_COLONNA_PK` (`IDCOL`),
  KEY `DSC` (`DATASET_FILE`),
  KEY `NOME` (`NOME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_colonna`
--

LOCK TABLES `sx_dataset_colonna` WRITE;
/*!40000 ALTER TABLE `sx_dataset_colonna` DISABLE KEYS */;
INSERT INTO `sx_dataset_colonna` VALUES (1242,'ID',0,NULL,NULL,331,1,NULL,500),(1243,'X1',1,NULL,NULL,331,NULL,NULL,500),(1244,'Y1',2,NULL,NULL,331,NULL,NULL,500),(1245,'MESE',0,NULL,NULL,332,NULL,NULL,400),(1246,'COD_DITT',1,NULL,NULL,332,NULL,NULL,400),(1247,'UNI_FUNZ',2,NULL,NULL,332,NULL,NULL,400),(1248,'FNM_G_2017',3,NULL,NULL,332,NULL,NULL,400),(1249,'FEM_G_2017',4,NULL,NULL,332,NULL,NULL,400),(1250,'FTM_G_2017',5,NULL,NULL,332,NULL,NULL,400),(1251,'ASIA',6,NULL,NULL,332,NULL,NULL,400),(1252,'ATECO',7,NULL,NULL,332,NULL,NULL,400),(1253,'FNB',8,NULL,NULL,332,NULL,NULL,400),(1254,'02',9,NULL,NULL,332,NULL,NULL,400),(1255,'FTB',10,NULL,NULL,332,NULL,NULL,400),(1256,'FNM_P_2016',11,NULL,NULL,332,NULL,NULL,400),(1257,'FEM_P_2016',12,NULL,NULL,332,NULL,NULL,400),(1258,'FTM_P_2016',13,NULL,NULL,332,NULL,NULL,400),(1259,'ATE_LETT',14,NULL,NULL,332,NULL,NULL,400),(1260,'ATE_RID',15,NULL,NULL,332,NULL,NULL,400),(1261,'MESE',0,NULL,NULL,333,NULL,NULL,400),(1262,'COD_DITT',1,NULL,NULL,333,NULL,NULL,400),(1263,'UNI_FUNZ',2,NULL,NULL,333,NULL,NULL,400),(1264,'FNM_G_2017',3,NULL,NULL,333,NULL,NULL,400),(1265,'FEM_G_2017',4,NULL,NULL,333,NULL,NULL,400),(1266,'FTM_G_2017',5,NULL,NULL,333,NULL,NULL,400),(1267,'ASIA',6,NULL,NULL,333,NULL,NULL,400),(1268,'ATECO',7,NULL,NULL,333,NULL,NULL,400),(1269,'FNB',8,NULL,NULL,333,NULL,NULL,400),(1270,'02',9,NULL,NULL,333,NULL,NULL,400),(1271,'FTB',10,NULL,NULL,333,NULL,NULL,400),(1272,'FNM_P_2016',11,NULL,NULL,333,NULL,NULL,400),(1273,'FEM_P_2016',12,NULL,NULL,333,NULL,NULL,400),(1274,'FTM_P_2016',13,NULL,NULL,333,NULL,NULL,400),(1275,'ATE_LETT',14,NULL,NULL,333,NULL,NULL,400),(1276,'ATE_RID',15,NULL,NULL,333,NULL,NULL,400),(1277,'MESE',0,NULL,NULL,334,5,NULL,400),(1278,'COD_DITT',1,NULL,NULL,334,8,NULL,400),(1279,'UNI_FUNZ',2,NULL,NULL,334,NULL,NULL,400),(1280,'FNM_G_2017',3,NULL,NULL,334,2,0,400),(1281,'FEM_G_2017',4,NULL,NULL,334,NULL,NULL,400),(1282,'FTM_G_2017',5,NULL,NULL,334,NULL,NULL,400),(1283,'ASIA',6,NULL,NULL,334,NULL,NULL,400),(1284,'ATECO',7,NULL,NULL,334,1,1,400),(1285,'FNB',8,NULL,NULL,334,NULL,NULL,400),(1286,'02',9,NULL,NULL,334,NULL,NULL,400),(1287,'FTB',10,NULL,NULL,334,NULL,NULL,400),(1288,'FNM_P_2016',11,NULL,NULL,334,NULL,NULL,400),(1289,'FEM_P_2016',12,NULL,NULL,334,NULL,NULL,400),(1290,'FTM_P_2016',13,NULL,NULL,334,NULL,NULL,400),(1291,'ATE_LETT',14,NULL,NULL,334,NULL,NULL,400),(1292,'ATE_RID',15,NULL,NULL,334,NULL,NULL,400),(1293,'ID',0,NULL,NULL,335,NULL,NULL,NULL),(1294,'X1',1,NULL,NULL,335,NULL,NULL,NULL),(1295,'Y1',2,NULL,NULL,335,NULL,NULL,NULL),(1296,'ID',0,NULL,NULL,336,NULL,NULL,NULL),(1297,'X1',1,NULL,NULL,336,NULL,NULL,NULL),(1298,'Y1',2,NULL,NULL,336,NULL,NULL,NULL),(1299,'ID',0,NULL,NULL,337,NULL,NULL,NULL),(1300,'X1',1,NULL,NULL,337,NULL,NULL,NULL),(1301,'Y1',2,NULL,NULL,337,NULL,NULL,NULL),(1302,'ID',0,NULL,NULL,338,NULL,NULL,NULL),(1303,'X1',1,NULL,NULL,338,NULL,NULL,NULL),(1304,'Y1',2,NULL,NULL,338,NULL,NULL,NULL),(1389,'ID',0,NULL,NULL,354,NULL,NULL,500),(1390,'X1',1,NULL,NULL,354,NULL,NULL,500),(1391,'Y1',2,NULL,NULL,354,NULL,NULL,500),(1534,'MESE',0,NULL,NULL,384,NULL,NULL,400),(1535,'COD_DITT',1,NULL,NULL,384,NULL,NULL,400),(1536,'UNI_FUNZ',2,NULL,NULL,384,NULL,NULL,400),(1537,'FNM_G_2017',3,NULL,NULL,384,NULL,NULL,400),(1538,'FEM_G_2017',4,NULL,NULL,384,NULL,NULL,400),(1539,'FTM_G_2017',5,NULL,NULL,384,NULL,NULL,400),(1540,'ASIA',6,NULL,NULL,384,NULL,NULL,400),(1541,'ATECO',7,NULL,NULL,384,NULL,NULL,400),(1542,'FNB',8,NULL,NULL,384,NULL,NULL,400),(1543,'02',9,NULL,NULL,384,NULL,NULL,400),(1544,'FTB',10,NULL,NULL,384,NULL,NULL,400),(1545,'FNM_P_2016',11,NULL,NULL,384,NULL,NULL,400),(1546,'FEM_P_2016',12,NULL,NULL,384,NULL,NULL,400),(1547,'FTM_P_2016',13,NULL,NULL,384,NULL,NULL,400),(1548,'ATE_LETT',14,NULL,NULL,384,NULL,NULL,400),(1549,'ATE_RID',15,NULL,NULL,384,NULL,NULL,400),(1561,'MESE',0,NULL,NULL,401,NULL,NULL,400),(1562,'COD_DITT',1,NULL,NULL,401,NULL,NULL,400),(1563,'UNI_FUNZ',2,NULL,NULL,401,NULL,NULL,400),(1564,'FNM_G_2017',3,NULL,NULL,401,NULL,NULL,400),(1565,'FEM_G_2017',4,NULL,NULL,401,NULL,NULL,400),(1566,'FTM_G_2017',5,NULL,NULL,401,NULL,NULL,400),(1567,'ASIA',6,NULL,NULL,401,NULL,NULL,400),(1568,'ATECO',7,NULL,NULL,401,NULL,NULL,400),(1569,'FNB',8,NULL,NULL,401,NULL,NULL,400),(1570,'02',9,NULL,NULL,401,NULL,NULL,400),(1571,'FTB',10,NULL,NULL,401,NULL,NULL,400),(1572,'FNM_P_2016',11,NULL,NULL,401,NULL,NULL,400),(1573,'FEM_P_2016',12,NULL,NULL,401,NULL,NULL,400),(1574,'FTM_P_2016',13,NULL,NULL,401,NULL,NULL,400),(1575,'ATE_LETT',14,NULL,NULL,401,NULL,NULL,400),(1576,'ATE_RID',15,NULL,NULL,401,NULL,NULL,400),(1581,'ID',0,NULL,NULL,421,NULL,NULL,500),(1582,'X1',1,NULL,NULL,421,NULL,NULL,500),(1583,'Y1',2,NULL,NULL,421,NULL,NULL,500),(1584,'WEIGHTS',3,NULL,NULL,421,NULL,NULL,500),(1585,'Y1.SCORE',4,NULL,NULL,421,NULL,NULL,500),(1586,'GLOBAL.SCORE',5,NULL,NULL,421,NULL,NULL,500),(1587,'Y1.RESERR',6,NULL,NULL,421,NULL,NULL,500),(1588,'Y1.SEL',7,NULL,NULL,421,NULL,NULL,500),(1589,'RANK',8,NULL,NULL,421,NULL,NULL,500),(1590,'SEL',9,NULL,NULL,421,NULL,NULL,500),(1591,'WEIGHTS.1',10,NULL,NULL,421,NULL,NULL,500),(1592,'Y1.SCORE.1',11,NULL,NULL,421,NULL,NULL,500),(1593,'GLOBAL.SCORE.1',12,NULL,NULL,421,NULL,NULL,500),(1594,'Y1.RESERR.1',13,NULL,NULL,421,NULL,NULL,500),(1595,'Y1.SEL.1',14,NULL,NULL,421,NULL,NULL,500),(1596,'RANK.1',15,NULL,NULL,421,NULL,NULL,500),(1597,'SEL.1',16,NULL,NULL,421,NULL,NULL,500),(1601,'MESE',0,NULL,NULL,441,9,1,73544),(1602,'COD_DITT',1,NULL,NULL,441,2,1,73544),(1603,'FEM_G_2017',2,NULL,NULL,441,NULL,NULL,73544),(1604,'FEM_P_2016',3,NULL,NULL,441,NULL,NULL,73544),(1605,'ID',0,NULL,NULL,442,11,NULL,500),(1606,'X1',1,NULL,NULL,442,2,NULL,500),(1607,'X2',2,NULL,NULL,442,2,NULL,500),(1608,'Y1',3,NULL,NULL,442,2,NULL,500),(1609,'Y2',4,NULL,NULL,442,2,NULL,500),(1610,'YPRED',5,NULL,NULL,442,2,NULL,500),(1721,'MESE',0,NULL,NULL,501,5,1,73544),(1722,'COD_DITT',1,NULL,NULL,501,8,0,73544),(1723,'FEM_G_2017',2,NULL,NULL,501,2,0,73544),(1724,'FEM_P_2016',3,NULL,NULL,501,2,0,73544),(1781,'ID',0,NULL,NULL,581,11,1,500),(1782,'X1',1,NULL,NULL,581,10,1,500),(1783,'Y1',2,NULL,NULL,581,NULL,NULL,500),(1784,'S1',3,NULL,NULL,581,1,1,500),(2200,'MESE',0,NULL,NULL,645,NULL,NULL,73544),(2201,'MESE',0,NULL,NULL,661,4,1,73544),(2202,'COD_DITT',1,NULL,NULL,661,NULL,NULL,73544),(2203,'UNI_FUNZ',2,NULL,NULL,661,NULL,NULL,73544),(2204,'FNM_G_2017',3,NULL,NULL,661,NULL,NULL,73544),(2205,'FEM_G_2017',4,NULL,NULL,661,NULL,NULL,73544),(2206,'FTM_G_2017',5,NULL,NULL,661,NULL,NULL,73544),(2207,'ASIA',6,NULL,NULL,661,NULL,NULL,73544),(2208,'ATECO',7,NULL,NULL,661,NULL,NULL,73544),(2209,'FNB',8,NULL,NULL,661,NULL,NULL,73544),(2210,'02',9,NULL,NULL,661,NULL,NULL,73544),(2211,'FTB',10,NULL,NULL,661,NULL,NULL,73544),(2212,'FNM_P_2016',11,NULL,NULL,661,NULL,NULL,73544),(2213,'FEM_P_2016',12,NULL,NULL,661,NULL,NULL,73544),(2214,'FTM_P_2016',13,NULL,NULL,661,NULL,NULL,73544),(2215,'ATE_LETT',14,NULL,NULL,661,NULL,NULL,73544),(2216,'ATE_RID',15,NULL,NULL,661,NULL,NULL,73544),(2217,'MESE1',16,NULL,NULL,661,NULL,NULL,73544),(2218,'COD_DITT1',17,NULL,NULL,661,NULL,NULL,73544),(2219,'UNI_FUNZ1',18,NULL,NULL,661,NULL,NULL,73544),(2220,'FNM_G_20171',19,NULL,NULL,661,NULL,NULL,73544),(2221,'FEM_G_20171',20,NULL,NULL,661,NULL,NULL,73544),(2222,'FTM_G_20171',21,NULL,NULL,661,NULL,NULL,73544),(2223,'ASIA1',22,NULL,NULL,661,NULL,NULL,73544),(2224,'ATECO1',23,NULL,NULL,661,NULL,NULL,73544),(2225,'FNB1',24,NULL,NULL,661,NULL,NULL,73544),(2226,'FTB1',25,NULL,NULL,661,NULL,NULL,73544),(2227,'FNM_P_20161',26,NULL,NULL,661,NULL,NULL,73544),(2228,'FEM_P_20161',27,NULL,NULL,661,NULL,NULL,73544),(2229,'FTM_P_20161',28,NULL,NULL,661,NULL,NULL,73544),(2230,'ATE_LETT1',29,NULL,NULL,661,NULL,NULL,73544),(2231,'ATE_RID1',30,NULL,NULL,661,NULL,NULL,73544),(2241,'COD_DITT',1,NULL,NULL,645,NULL,NULL,73544),(2242,'UNI_FUNZ',2,NULL,NULL,645,NULL,NULL,73544),(2243,'FNM_G_2017',3,NULL,NULL,645,NULL,NULL,73544),(2244,'FEM_G_2017',4,NULL,NULL,645,NULL,NULL,73544),(2245,'FTM_G_2017',5,NULL,NULL,645,NULL,NULL,73544),(2246,'ASIA',6,NULL,NULL,645,NULL,NULL,73544),(2247,'ATECO',7,NULL,NULL,645,NULL,NULL,73544),(2248,'FNB',8,NULL,NULL,645,NULL,NULL,73544),(2249,'02',9,NULL,NULL,645,NULL,NULL,73544),(2250,'FTB',10,NULL,NULL,645,NULL,NULL,73544),(2251,'FNM_P_2016',11,NULL,NULL,645,NULL,NULL,73544),(2252,'FEM_P_2016',12,NULL,NULL,645,NULL,NULL,73544),(2253,'FTM_P_2016',13,NULL,NULL,645,NULL,NULL,73544),(2254,'ATE_LETT',14,NULL,NULL,645,NULL,NULL,73544),(2255,'ATE_RID',15,NULL,NULL,645,NULL,NULL,73544),(2256,'MESE1',16,NULL,NULL,645,NULL,NULL,73544),(2257,'COD_DITT1',17,NULL,NULL,645,NULL,NULL,73544),(2258,'UNI_FUNZ1',18,NULL,NULL,645,NULL,NULL,73544),(2259,'FNM_G_20171',19,NULL,NULL,645,NULL,NULL,73544),(2260,'FEM_G_20171',20,NULL,NULL,645,NULL,NULL,73544),(2261,'FTM_G_20171',21,NULL,NULL,645,NULL,NULL,73544),(2262,'ASIA1',22,NULL,NULL,645,NULL,NULL,73544),(2263,'ATECO1',23,NULL,NULL,645,NULL,NULL,73544),(2264,'FNB1',24,NULL,NULL,645,NULL,NULL,73544),(2265,'FTB1',25,NULL,NULL,645,NULL,NULL,73544),(2266,'FNM_P_20161',26,NULL,NULL,645,NULL,NULL,73544),(2267,'FEM_P_20161',27,NULL,NULL,645,NULL,NULL,73544),(2268,'FTM_P_20161',28,NULL,NULL,645,NULL,NULL,73544),(2269,'ATE_LETT1',29,NULL,NULL,645,NULL,NULL,73544),(2270,'ATE_RID1',30,NULL,NULL,645,NULL,NULL,73544),(2271,'MESE2',31,NULL,NULL,645,NULL,NULL,73544),(2272,'COD_DITT2',32,NULL,NULL,645,NULL,NULL,73544),(2273,'UNI_FUNZ2',33,NULL,NULL,645,NULL,NULL,73544),(2274,'FNM_G_20172',34,NULL,NULL,645,NULL,NULL,73544),(2275,'FEM_G_20172',35,NULL,NULL,645,NULL,NULL,73544),(2276,'FTM_G_20172',36,NULL,NULL,645,NULL,NULL,73544),(2277,'ASIA2',37,NULL,NULL,645,NULL,NULL,73544),(2278,'ATECO2',38,NULL,NULL,645,NULL,NULL,73544),(2279,'FNB2',39,NULL,NULL,645,NULL,NULL,73544),(2280,'FTB2',40,NULL,NULL,645,NULL,NULL,73544),(2281,'FNM_P_20162',41,NULL,NULL,645,NULL,NULL,73544),(2282,'FEM_P_20162',42,NULL,NULL,645,NULL,NULL,73544),(2283,'FTM_P_20162',43,NULL,NULL,645,NULL,NULL,73544),(2284,'ATE_LETT2',44,NULL,NULL,645,NULL,NULL,73544),(2285,'ATE_RID2',45,NULL,NULL,645,NULL,NULL,73544),(2341,'MESE',0,NULL,NULL,681,NULL,NULL,73544),(2342,'COD_DITT',1,NULL,NULL,681,NULL,NULL,73544),(2343,'UNI_FUNZ',2,NULL,NULL,681,NULL,NULL,73544),(2344,'FNM_G_2017',3,NULL,NULL,681,NULL,NULL,73544),(2345,'FEM_G_2017',4,NULL,NULL,681,NULL,NULL,73544),(2346,'FTM_G_2017',5,NULL,NULL,681,NULL,NULL,73544),(2347,'ASIA',6,NULL,NULL,681,NULL,NULL,73544),(2348,'ATECO',7,NULL,NULL,681,NULL,NULL,73544),(2349,'FNB',8,NULL,NULL,681,NULL,NULL,73544),(2350,'02',9,NULL,NULL,681,NULL,NULL,73544),(2351,'FTB',10,NULL,NULL,681,NULL,NULL,73544),(2352,'FNM_P_2016',11,NULL,NULL,681,NULL,NULL,73544),(2353,'FEM_P_2016',12,NULL,NULL,681,NULL,NULL,73544),(2354,'FTM_P_2016',13,NULL,NULL,681,NULL,NULL,73544),(2355,'ATE_LETT',14,NULL,NULL,681,NULL,NULL,73544),(2356,'ATE_RID',15,NULL,NULL,681,NULL,NULL,73544);
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
  `tipodato` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=682 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_file`
--

LOCK TABLES `sx_dataset_file` WRITE;
/*!40000 ALTER TABLE `sx_dataset_file` DISABLE KEYS */;
INSERT INTO `sx_dataset_file` VALUES (331,NULL,'aaa.csv','CSV',',',500,'2010-01-18',NULL,321,NULL,NULL),(332,NULL,'datiFATT_SINTESI_mini.csv','CSV',';',400,'2010-01-18',NULL,323,NULL,NULL),(333,NULL,'datiFATT_SINTESI_mini.csv','CSV',';',400,'2011-01-18',NULL,324,NULL,NULL),(334,NULL,'datiFATT_SINTESI_mini.csv','CSV',';',400,'2011-01-18',NULL,326,NULL,NULL),(354,NULL,'input.file.csv','CSV',',',500,'2018-01-18',NULL,325,NULL,NULL),(384,NULL,'datiFATT_SINTESI_mini.csv','CSV',';',400,'2021-01-18',NULL,364,NULL,NULL),(401,NULL,'datiFATT_SINTESI_mini.csv','CSV',';',400,'2022-01-19',NULL,381,NULL,NULL),(421,NULL,'data.sel.csv','CSV',',',500,'2031-01-19',NULL,401,NULL,NULL),(441,NULL,'DATI_FATT_SINTESI_mini.csv','CSV',';',73544,'2018-02-19',NULL,421,NULL,NULL),(442,NULL,'input.multi.csv','CSV',';',500,'2019-02-19',NULL,422,NULL,NULL),(501,NULL,'DATI_FATT_SINTESI_mini.csv','CSV',';',73544,'2020-03-19',NULL,461,NULL,NULL),(581,NULL,'input.strata.csv','CSV',';',500,'2029-03-19',NULL,541,NULL,NULL),(601,NULL,'input.strata.1.csv','CSV',';',98,'2001-04-19',NULL,581,NULL,NULL),(645,NULL,'datiFATT_SINTESI_2.csv','CSV',';',73544,'2004-04-19',NULL,442,NULL,NULL),(661,NULL,'datiFATT_SINTESI_1.csv','CSV',';',73544,'2004-04-19',NULL,443,NULL,NULL),(681,NULL,'datiFATT_SINTESI.csv','CSV',';',73544,'2010-04-19',NULL,641,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=646 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_elaborazione`
--

LOCK TABLES `sx_elaborazione` WRITE;
/*!40000 ALTER TABLE `sx_elaborazione` DISABLE KEYS */;
INSERT INTO `sx_elaborazione` VALUES (206,NULL,'mlest no covar',NULL,'Covariata opzionale',240,10),(224,NULL,'ypred multivar',NULL,'Lancio pedizione multivariata',240,20),(226,NULL,'Multivar 2',NULL,'Vediamo il modello',240,10),(227,NULL,'aaa',NULL,'cccc',240,80),(228,NULL,'Elaborazione di prova',NULL,'Proviamo ad eseguire una elaborazione',240,20),(229,'2004-01-18','params',NULL,'params',240,30),(236,'2004-01-18','Parametri 2',NULL,'Lancio parametrico',240,30),(246,'2005-01-18','Prova elaborazioone',NULL,'prova',260,20),(248,'2005-01-18','predizione 3',NULL,'Predizione senza covar',240,20),(249,'2005-01-18','Predizione 4',NULL,'Lancio senza covar',240,20),(250,'2005-01-18','ert',NULL,'et',240,70),(251,'2005-01-18','mlest no covar',NULL,'lancio multi senza covar',240,10),(252,'2005-01-18','Monovar no covar',NULL,'Monovariata  senza covariata',240,20),(263,'2010-01-18','Elaborazione di prova',NULL,'Prova',321,20),(278,'2011-01-18','Selezione errori influenti',NULL,'Facciamo una prova',324,30),(279,'2011-01-18','Errori influenti multi step',NULL,'Seconda prova',324,70),(305,'2018-01-18','Stima e predizione monovar',NULL,'Stima outier e modello di regressione monodimensionale',323,10),(306,'2018-01-18','Stima in base ad un modello',NULL,'Stima outlier monovariata in base ad un modello esterno',323,20),(307,'2018-01-18','Errori influenti a step singolo',NULL,'La predizione deve essere fornita in input',323,30),(308,'2018-01-18','Outlier ed Errori Influenti semi automatica',NULL,'Controllo di processo a cura dell\'utente',323,80),(309,'2018-01-18','Outlier ed Errori Influenti full auto',NULL,'Controllo di processo integrato nell\'applicazione',323,70),(311,'2018-01-18','Stima e predizione multivar',NULL,'Stima outlier e modello di regressione multivariata',323,10),(331,'2019-01-18','Stima monovariata',NULL,'Prova di lancio della stima su una variabile',326,10),(332,'2019-01-18','Stima multivariata',NULL,'Prova di lancio della stima su più variabili',326,10),(333,'2019-01-18','Predizione',NULL,'Stima e Impostazione modello',326,20),(334,'2019-01-18','Errori influenti a step singolo',NULL,'E\' necessario impostare una variabile di predizione',326,30),(335,'2019-01-18','Errori Influenti semi-automatica',NULL,'L\'utente decide in merito alla gestione dei passi di processo',326,80),(336,'2019-01-18','Errori influenti full auto',NULL,'Il sistema gestisce interamente il flusso di lavoro',326,70),(343,'2019-01-18','Test',NULL,'errori influenti',323,30),(344,'2020-01-18','d',NULL,'d',326,10),(345,'2021-01-18','Giulio',NULL,'Sempre da Giulio',364,30),(364,'2017-01-19','aa',NULL,'aa',326,10),(366,'2022-01-19','Elaborazione per Mauros',NULL,'Speriamo che funzioni',381,10),(367,'2022-01-19','err monostep',NULL,'err monostep',381,30),(368,'2022-01-19','Errori ingl',NULL,'multiprocess',381,80),(383,'2031-01-19','aa',NULL,'aaaa',401,10),(403,'2011-02-19','aaa',NULL,'aaa',381,80),(404,'2014-02-19','prova 2',NULL,'elaborazione 2',321,40),(423,'2018-02-19','Nuova elaborazione',NULL,'Prova filtri',421,20),(463,'2020-03-19','New Salamino Discovery',NULL,'Elab fichissima dopo Hackathon',461,80),(485,'2025-03-19','Errori influenti di Claudio',NULL,'Ha sopportato Pina per 45 minuti',326,30),(548,'2029-03-19','elab1',NULL,NULL,461,70),(549,'2029-03-19','prova vecchioo strato',NULL,NULL,541,10),(550,'2029-03-19','vcstra2',NULL,NULL,541,10),(565,'2001-04-19','prova',NULL,'strato 1',581,10),(569,'2001-04-19','prova 7',NULL,'uffa',541,15),(587,'2002-04-19','prova 8',NULL,'Prova selezione stratificata (1nd attempt)',541,35),(588,'2002-04-19','prova 9',NULL,'E hallora i RUOLI???',541,35),(589,'2002-04-19','Modello stratificato',NULL,'NB attualmente un modello per tutto il dataset',541,25),(605,'2002-04-19','monostep',NULL,'controllino',541,30),(625,'2004-04-19','prova1',NULL,'controllo outlier',443,40),(626,'2004-04-19','prova2',NULL,'Elaborazione 2',443,10),(627,'2004-04-19','prova 3',NULL,'Elab 3',443,20),(628,'2005-04-19','Prova multi process',NULL,'Prova su più processi diversi',321,80),(645,'2010-04-19','Prova elaborazione',NULL,'Prova',641,70);
/*!40000 ALTER TABLE `sx_elaborazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_mega_join`
--

DROP TABLE IF EXISTS `sx_mega_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_mega_join` (
  `PROCESS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TABLE_NAME` varchar(32) DEFAULT NULL,
  `KEY_NAME` varchar(32) DEFAULT NULL,
  `TABLE_MASTER` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`PROCESS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_mega_join`
--

LOCK TABLES `sx_mega_join` WRITE;
/*!40000 ALTER TABLE `sx_mega_join` DISABLE KEYS */;
INSERT INTO `sx_mega_join` VALUES (1,'SX_BUSINESS_STEP','ID','SX_BUSINESS_PROCESS'),(2,'SX_BUSINESS_PROCESS','ID','SX_BUSINESS_FUNCTION'),(3,'SX_BUSINESS_FUNCTION','ID',NULL);
/*!40000 ALTER TABLE `sx_mega_join` ENABLE KEYS */;
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE` varchar(255) DEFAULT NULL,
  `USERID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16202 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_roles`
--

LOCK TABLES `sx_roles` WRITE;
/*!40000 ALTER TABLE `sx_roles` DISABLE KEYS */;
INSERT INTO `sx_roles` VALUES (1,'ADMIN',1),(4150,'ADMIN',83),(10150,'USER',203),(11150,'ADMIN',223),(12150,'ADMIN',224),(13150,'USER',243),(14150,'USER',283),(15150,'USER',303),(15200,'USER',304),(16200,'USER',344),(16201,'ADMIN',363);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_ruleset`
--

LOCK TABLES `sx_ruleset` WRITE;
/*!40000 ALTER TABLE `sx_ruleset` DISABLE KEYS */;
INSERT INTO `sx_ruleset` VALUES (1,'ml.est.ruleset','Regole per step Stima'),(2,'y.pred.ruleset','Regole per step Predizione'),(3,'sel.edit.ruleset','Regole per step Selezione');
/*!40000 ALTER TABLE `sx_ruleset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_ruoli`
--

DROP TABLE IF EXISTS `sx_ruoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_ruoli` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  `COD` varchar(50) DEFAULT NULL,
  `DESCR` varchar(50) DEFAULT NULL,
  `SERVIZIO` int(20) DEFAULT NULL,
  `ORDINE` int(20) DEFAULT NULL,
  `TIPO_VAR` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0013863` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_ruoli`
--

LOCK TABLES `sx_ruoli` WRITE;
/*!40000 ALTER TABLE `sx_ruoli` DISABLE KEYS */;
INSERT INTO `sx_ruoli` VALUES (1,'SKIP','N','VARIABILE NON UTILIZZATA',100,100,1),(2,'IDENTIFICATIVO','I','CHIAVE OSSERVAZIONE',100,1,1),(3,'TARGET','Y','VARIABILE DI OGGETTO DI ANALISI',100,3,1),(4,'COVARIATA','X','VARIABILE INDIPENDENTE',100,4,1),(5,'PREDIZIONE','P','VARIABILE DI PREDIZIONE',100,5,1),(6,'OUTLIER','O','FLAG OUTLIER',100,6,1),(7,'PESO','W','PESO CAMPIONARIO',100,7,1),(8,'ERRORE','E','ERRORE INFLUENTE',100,10,1),(9,'RANKING','R','INFLUENCE RANKING',100,11,1),(10,'OUTPUT','T','VARIABILE DI OUTPUT',100,20,1),(11,'STRATO','S','PARTIZIONAMENTO DEL DATASET',100,2,1),(12,'PARAMETRI','Z','PARAMETRI DI INPUT',100,997,2),(13,'MODELLO','M','MODELLO DATI',100,998,2),(14,'SCORE','F','INFLUENCE SCORE',100,12,1),(15,'INFO','G','PARAMETRI OUT - INFO RIEPILOGO',100,999,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=642 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_sessione_lavoro`
--

LOCK TABLES `sx_sessione_lavoro` WRITE;
/*!40000 ALTER TABLE `sx_sessione_lavoro` DISABLE KEYS */;
INSERT INTO `sx_sessione_lavoro` VALUES (321,224,'2010-01-18','Sessione di prova','Prova'),(323,344,'2010-01-18','FATT 2018','Elaborazione dati FATT 2018'),(324,303,'2011-01-18','FATT 2018','Lavorazione dati fatt'),(325,303,'2011-01-18','DETT 2018','Lavorazione DETT'),(326,83,'2011-01-18','FATT MINI','Subset delle osservazioni di FATT 2018'),(364,344,'2021-01-18','Test da giulio','Nella stanza di Giulio grazie al proiettore'),(381,344,'2022-01-19','Test con Mauros','Proviamo la box'),(401,344,'2031-01-19','Nuova','Prova'),(421,224,'2018-02-19','Sessione 2','Sessione con file mini'),(422,83,'2019-02-19','fra1','e'),(442,1,'2007-03-19','FATT 2018','Fatturato e ordinativi dell\'industria 2018'),(443,1,'2011-03-19','FATT 2019','Fatturato ordinativi dell\'industria 2019'),(461,83,'2020-03-19','SMUTIS','Prima sessione dopo hackaton (secondi classificati)'),(501,83,'2025-03-19','SERV2 - Relais','Sessione di prova con Claudio'),(541,83,'2029-03-19','Stratificazione','Prova dellastima stratificata (2nd attempt)'),(581,83,'2001-04-19','Strato uno','Prova su uno strato singolo'),(641,224,'2010-04-19','Prova sessione','Prova post pulizia co01e');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_instance`
--

LOCK TABLES `sx_step_instance` WRITE;
/*!40000 ALTER TABLE `sx_step_instance` DISABLE KEYS */;
INSERT INTO `sx_step_instance` VALUES (1,'mlest','Stima e predizione','STIMA',100),(2,'ypred','Predizione da modello','PREDIZIONE',100),(3,'seledit','Selezione Errori Influenti','SELEZIONE',100),(4,'modest','Valutazione del modello','MODEL',100),(5,'selpairs','01erazione Grafico','GRAPH',100),(6,'srf','Set Rule File','SRF',200),(7,'strata.mlest','Stima stratificata','STRATST',100),(8,'strata.ypred','Predizione stratificata','STRATPR',100),(9,'strata.seledit','Selezione stratificata','STRATSE',100);
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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_pattern`
--

LOCK TABLES `sx_step_pattern` WRITE;
/*!40000 ALTER TABLE `sx_step_pattern` DISABLE KEYS */;
INSERT INTO `sx_step_pattern` VALUES (1,1,2,1),(2,1,3,1),(3,1,5,2),(4,1,4,2),(5,1,10,1),(6,1,11,1),(7,1,12,2),(8,2,2,1),(9,2,3,1),(10,2,5,2),(11,2,4,2),(12,2,10,1),(13,2,11,1),(14,2,12,1),(15,3,2,1),(17,3,4,1),(18,3,10,1),(19,3,11,1),(20,3,7,2),(21,3,8,2),(22,3,13,2),(23,4,2,1),(24,4,3,1),(25,4,11,1),(26,4,12,2),(27,1,14,2),(28,2,14,2),(29,3,14,2),(30,4,14,2),(31,7,11,1),(32,7,10,1),(33,7,4,2),(34,7,5,2),(35,7,3,1),(36,7,2,1),(37,7,14,2),(38,9,2,1),(39,9,13,2),(40,9,14,2),(41,9,11,1),(42,9,10,1),(43,9,4,1),(44,9,8,2),(45,9,7,2),(46,8,14,2),(47,8,3,1),(48,8,5,2),(49,8,4,2),(50,8,10,1),(51,8,11,1),(52,8,2,1),(53,8,12,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2126 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_variable`
--

LOCK TABLES `sx_step_variable` WRITE;
/*!40000 ALTER TABLE `sx_step_variable` DISABLE KEYS */;
INSERT INTO `sx_step_variable` VALUES (794,784,2,278,NULL,3,1,1,NULL),(795,785,4,278,NULL,5,1,1,NULL),(796,786,13,278,NULL,12,1,1,NULL),(797,787,0,278,NULL,100,1,1,NULL),(798,788,0,278,NULL,100,1,1,NULL),(799,789,0,278,NULL,100,1,1,NULL),(800,790,8,278,NULL,11,1,1,NULL),(801,791,7,278,NULL,10,1,1,NULL),(802,792,0,278,NULL,100,1,1,NULL),(803,793,0,278,NULL,100,1,1,NULL),(804,794,0,278,NULL,100,1,1,NULL),(812,800,2,263,NULL,3,1,1,0),(959,1338,11,263,NULL,997,1,1,NULL),(1031,1000,2,309,NULL,3,1,1,NULL),(1032,1001,3,309,NULL,4,1,1,NULL),(1033,1002,2,308,NULL,3,1,1,1),(1034,1003,3,308,NULL,4,1,1,NULL),(1035,1004,2,307,NULL,3,1,1,NULL),(1036,1005,2,306,NULL,3,1,1,NULL),(1037,1006,3,306,NULL,4,1,1,NULL),(1045,1014,2,311,NULL,3,1,1,NULL),(1046,1015,2,311,NULL,3,1,1,NULL),(1050,1019,4,307,NULL,5,1,1,NULL),(1051,1020,13,307,NULL,12,1,1,NULL),(1052,1021,0,307,NULL,100,1,1,NULL),(1053,1022,0,307,NULL,100,1,1,NULL),(1054,1023,0,307,NULL,100,1,1,NULL),(1055,1024,8,307,NULL,11,1,1,NULL),(1056,1025,7,307,NULL,10,1,1,NULL),(1057,1026,0,307,NULL,100,1,1,NULL),(1058,1027,0,307,NULL,100,1,1,NULL),(1059,1028,0,307,NULL,100,1,1,NULL),(1061,1342,12,263,NULL,998,1,1,NULL),(1135,1104,13,307,NULL,12,1,1,NULL),(1136,1105,0,307,NULL,100,1,1,NULL),(1137,1106,0,307,NULL,100,1,1,NULL),(1138,1107,0,307,NULL,100,1,1,NULL),(1139,1108,0,307,NULL,100,1,1,NULL),(1150,1119,2,332,NULL,3,1,1,NULL),(1151,1120,2,332,NULL,3,1,1,NULL),(1152,1121,2,333,NULL,3,1,1,1),(1153,1122,3,333,NULL,4,1,1,1),(1154,1123,12,333,NULL,998,1,1,NULL),(1155,1124,12,333,NULL,998,1,1,NULL),(1156,1125,12,333,NULL,998,1,1,NULL),(1157,1126,12,333,NULL,998,1,1,NULL),(1158,1127,2,334,NULL,3,1,1,1),(1159,1128,4,334,NULL,5,1,1,1),(1160,1130,2,343,NULL,3,1,1,NULL),(1161,1131,4,343,NULL,5,1,1,NULL),(1162,1132,13,343,NULL,12,1,1,NULL),(1163,1133,0,343,NULL,100,1,1,NULL),(1164,1134,0,343,NULL,100,1,1,NULL),(1165,1135,0,343,NULL,100,1,1,NULL),(1166,1136,8,343,NULL,11,1,1,NULL),(1167,1137,7,343,NULL,10,1,1,NULL),(1168,1138,0,343,NULL,100,1,1,NULL),(1169,1139,0,343,NULL,100,1,1,NULL),(1170,1140,0,343,NULL,100,1,1,NULL),(1171,1141,2,331,NULL,3,1,1,NULL),(1172,1142,3,331,NULL,4,1,1,NULL),(1173,1143,11,331,NULL,997,1,1,NULL),(1174,1144,5,331,NULL,6,1,2,NULL),(1175,1145,0,331,NULL,100,1,2,NULL),(1176,1146,0,331,NULL,100,1,2,NULL),(1177,1147,4,331,NULL,5,1,2,NULL),(1178,1148,10,263,NULL,2,1,1,1),(1179,1149,11,332,NULL,997,1,1,NULL),(1180,1150,5,332,NULL,6,1,1,NULL),(1181,1151,0,332,NULL,100,1,1,NULL),(1182,1152,0,332,NULL,100,1,1,NULL),(1183,1153,4,332,NULL,5,1,1,NULL),(1184,1154,4,332,NULL,5,1,1,NULL),(1185,1155,12,332,NULL,998,1,1,NULL),(1186,1156,14,332,NULL,999,1,1,NULL),(1187,1157,12,332,NULL,998,1,1,NULL),(1188,1158,12,332,NULL,998,1,1,NULL),(1189,1159,14,332,NULL,999,1,1,NULL),(1190,1160,12,332,NULL,998,1,1,NULL),(1191,1161,14,332,NULL,999,1,1,NULL),(1192,1162,14,332,NULL,999,1,1,NULL),(1193,1163,14,332,NULL,999,1,1,NULL),(1195,1165,4,335,NULL,5,1,1,0),(1201,1168,2,344,NULL,3,1,1,NULL),(1202,1169,3,344,NULL,4,1,1,NULL),(1203,1170,5,344,NULL,6,1,2,NULL),(1204,1171,0,344,NULL,100,1,2,NULL),(1205,1172,0,344,NULL,100,1,2,NULL),(1206,1173,4,344,NULL,5,1,2,NULL),(1207,1174,12,344,NULL,998,1,2,NULL),(1208,1175,14,344,NULL,999,1,2,NULL),(1209,1176,12,344,NULL,998,1,2,NULL),(1210,1177,12,344,NULL,998,1,2,NULL),(1211,1178,14,344,NULL,999,1,2,NULL),(1212,1179,12,344,NULL,998,1,2,NULL),(1213,1180,14,344,NULL,999,1,2,NULL),(1214,1181,14,344,NULL,999,1,2,NULL),(1215,1182,14,344,NULL,999,1,2,NULL),(1216,1183,2,345,NULL,3,1,NULL,NULL),(1217,1184,4,345,NULL,5,1,NULL,NULL),(1218,1185,13,345,NULL,12,1,NULL,NULL),(1219,1186,0,345,NULL,100,1,NULL,NULL),(1220,1187,0,345,NULL,100,1,NULL,NULL),(1221,1188,0,345,NULL,100,1,NULL,NULL),(1222,1189,8,345,NULL,11,1,NULL,NULL),(1223,1190,7,345,NULL,10,1,NULL,NULL),(1224,1191,0,345,NULL,100,1,NULL,NULL),(1225,1192,0,345,NULL,100,1,NULL,NULL),(1226,1193,0,345,NULL,100,1,NULL,NULL),(1236,1203,12,331,NULL,998,1,NULL,NULL),(1237,1204,14,331,NULL,999,1,NULL,NULL),(1238,1205,12,331,NULL,998,1,NULL,NULL),(1239,1206,12,331,NULL,998,1,NULL,NULL),(1240,1207,14,331,NULL,999,1,NULL,NULL),(1241,1208,12,331,NULL,998,1,NULL,NULL),(1242,1209,14,331,NULL,999,1,NULL,NULL),(1243,1210,14,331,NULL,999,1,NULL,NULL),(1244,1211,14,331,NULL,999,1,NULL,NULL),(1245,1212,14,331,NULL,999,1,NULL,NULL),(1246,1213,14,331,NULL,999,1,NULL,NULL),(1247,1214,14,331,NULL,999,1,NULL,NULL),(1248,1215,14,331,NULL,999,1,NULL,NULL),(1249,1216,14,331,NULL,999,1,NULL,NULL),(1250,1217,14,331,NULL,999,1,NULL,NULL),(1251,1218,14,331,NULL,999,1,NULL,NULL),(1252,1219,14,331,NULL,999,1,NULL,NULL),(1253,1220,14,331,NULL,999,1,NULL,NULL),(1254,1221,14,331,NULL,999,1,NULL,NULL),(1255,1222,14,331,NULL,999,1,NULL,NULL),(1256,1223,14,331,NULL,999,1,NULL,NULL),(1257,1224,14,331,NULL,999,1,NULL,NULL),(1258,1225,14,331,NULL,999,1,NULL,NULL),(1259,1226,14,331,NULL,999,1,NULL,NULL),(1260,1227,14,331,NULL,999,1,NULL,NULL),(1261,1228,14,331,NULL,999,1,NULL,NULL),(1262,1229,14,331,NULL,999,1,NULL,NULL),(1263,1230,14,331,NULL,999,1,NULL,NULL),(1264,1231,14,331,NULL,999,1,NULL,NULL),(1265,1232,14,331,NULL,999,1,NULL,NULL),(1266,1233,14,331,NULL,999,1,NULL,NULL),(1267,1234,14,331,NULL,999,1,NULL,NULL),(1268,1235,14,331,NULL,999,1,NULL,NULL),(1269,1236,14,331,NULL,999,1,NULL,NULL),(1270,1237,14,331,NULL,999,1,NULL,NULL),(1271,1238,14,331,NULL,999,1,NULL,NULL),(1272,1239,14,331,NULL,999,1,NULL,NULL),(1273,1240,14,331,NULL,999,1,NULL,NULL),(1274,1241,14,331,NULL,999,1,NULL,NULL),(1275,1242,14,331,NULL,999,1,NULL,NULL),(1276,1243,14,331,NULL,999,1,NULL,NULL),(1277,1244,14,331,NULL,999,1,NULL,NULL),(1280,1250,5,309,NULL,6,1,NULL,NULL),(1281,1251,0,309,NULL,100,1,NULL,NULL),(1282,1252,0,309,NULL,100,1,NULL,NULL),(1283,1253,4,309,NULL,5,1,NULL,NULL),(1284,1254,13,309,NULL,12,1,NULL,NULL),(1285,1255,0,309,NULL,100,1,NULL,NULL),(1286,1256,0,309,NULL,100,1,NULL,NULL),(1287,1257,0,309,NULL,100,1,NULL,NULL),(1288,1258,8,309,NULL,11,1,NULL,NULL),(1289,1259,7,309,NULL,10,1,NULL,NULL),(1290,1260,0,309,NULL,100,1,NULL,NULL),(1291,1261,0,309,NULL,100,1,NULL,NULL),(1292,1262,0,309,NULL,100,1,NULL,NULL),(1302,1269,14,344,NULL,999,1,NULL,NULL),(1303,1270,14,344,NULL,999,1,NULL,NULL),(1304,1271,14,344,NULL,999,1,NULL,NULL),(1305,1272,2,364,NULL,3,1,NULL,NULL),(1306,1273,3,364,NULL,4,1,NULL,NULL),(1307,1274,5,364,NULL,6,1,NULL,NULL),(1308,1275,0,364,NULL,100,1,NULL,NULL),(1309,1276,0,364,NULL,100,1,NULL,NULL),(1310,1277,4,364,NULL,5,1,NULL,NULL),(1311,1278,12,364,NULL,998,1,NULL,NULL),(1312,1279,14,364,NULL,999,1,NULL,NULL),(1313,1280,12,364,NULL,998,1,NULL,NULL),(1314,1281,12,364,NULL,998,1,NULL,NULL),(1315,1282,14,364,NULL,999,1,NULL,NULL),(1316,1283,12,364,NULL,998,1,NULL,NULL),(1317,1284,14,364,NULL,999,1,NULL,NULL),(1318,1285,14,364,NULL,999,1,NULL,NULL),(1319,1286,14,364,NULL,999,1,NULL,NULL),(1320,1287,5,311,NULL,6,1,NULL,NULL),(1321,1288,0,311,NULL,100,1,NULL,NULL),(1322,1289,0,311,NULL,100,1,NULL,NULL),(1323,1290,4,311,NULL,5,1,NULL,NULL),(1324,1291,4,311,NULL,5,1,NULL,NULL),(1325,1292,2,366,NULL,3,1,NULL,NULL),(1326,1293,3,366,NULL,4,1,NULL,NULL),(1327,1294,5,366,NULL,6,1,NULL,NULL),(1328,1295,0,366,NULL,100,1,NULL,NULL),(1329,1296,0,366,NULL,100,1,NULL,NULL),(1330,1297,4,366,NULL,5,1,NULL,NULL),(1331,1298,2,368,NULL,3,1,NULL,NULL),(1332,1299,3,368,NULL,4,1,NULL,NULL),(1333,1300,5,368,NULL,6,1,NULL,NULL),(1334,1301,0,368,NULL,100,1,NULL,NULL),(1335,1302,0,368,NULL,100,1,NULL,NULL),(1336,1303,4,368,NULL,5,1,NULL,NULL),(1337,1304,13,368,NULL,12,1,NULL,NULL),(1338,1305,0,368,NULL,100,1,NULL,NULL),(1339,1306,0,368,NULL,100,1,NULL,NULL),(1340,1307,0,368,NULL,100,1,NULL,NULL),(1341,1308,8,368,NULL,11,1,NULL,NULL),(1342,1309,7,368,NULL,10,1,NULL,NULL),(1343,1310,0,368,NULL,100,1,NULL,NULL),(1344,1311,0,368,NULL,100,1,NULL,NULL),(1345,1312,0,368,NULL,100,1,NULL,NULL),(1360,1330,2,383,NULL,3,1,NULL,NULL),(1361,1331,5,383,NULL,6,1,NULL,NULL),(1362,1332,0,383,NULL,100,1,NULL,NULL),(1363,1333,0,383,NULL,100,1,NULL,NULL),(1364,1334,4,383,NULL,5,1,NULL,NULL),(1366,1336,12,263,NULL,998,1,1,NULL),(1368,1339,11,334,NULL,997,1,1,NULL),(1369,1340,11,334,NULL,997,1,1,NULL),(1370,1344,11,335,NULL,997,1,1,NULL),(1380,1350,2,403,NULL,3,1,NULL,NULL),(1381,1351,3,403,NULL,4,1,NULL,NULL),(1382,1352,5,403,NULL,6,1,NULL,NULL),(1383,1353,0,403,NULL,100,1,NULL,NULL),(1384,1354,0,403,NULL,100,1,NULL,NULL),(1385,1355,4,403,NULL,5,1,NULL,NULL),(1386,1356,13,403,NULL,12,1,NULL,NULL),(1387,1357,0,403,NULL,100,1,NULL,NULL),(1388,1358,0,403,NULL,100,1,NULL,NULL),(1389,1359,0,403,NULL,100,1,NULL,NULL),(1390,1360,8,403,NULL,11,1,NULL,NULL),(1391,1361,7,403,NULL,10,1,NULL,NULL),(1392,1362,0,403,NULL,100,1,NULL,NULL),(1393,1363,0,403,NULL,100,1,NULL,NULL),(1394,1364,0,403,NULL,100,1,NULL,NULL),(1431,1401,10,404,NULL,2,1,1,1),(1487,1436,3,423,NULL,2,1,1,NULL),(1488,1437,2,423,NULL,0,1,1,NULL),(1500,1450,2,463,NULL,3,1,1,1),(1501,1451,3,463,NULL,4,1,1,NULL),(1502,1452,5,463,NULL,6,1,2,NULL),(1503,1453,0,463,NULL,100,1,2,NULL),(1504,1454,0,463,NULL,100,1,2,NULL),(1505,1455,4,463,NULL,5,1,2,NULL),(1506,1456,12,463,NULL,998,1,2,NULL),(1507,1457,14,463,NULL,999,1,2,NULL),(1508,1458,12,463,NULL,998,1,2,NULL),(1509,1465,11,463,NULL,997,1,1,NULL),(1510,1460,14,463,NULL,999,1,2,NULL),(1511,1461,12,463,NULL,998,1,2,NULL),(1512,1462,14,463,NULL,999,1,2,NULL),(1513,1463,14,463,NULL,999,1,2,NULL),(1514,1464,14,463,NULL,999,1,2,NULL),(1562,1512,2,485,NULL,3,1,1,NULL),(1563,1513,4,485,NULL,5,1,1,NULL),(1857,1802,3,549,NULL,4,1,1,NULL),(1858,1803,2,549,NULL,3,1,1,NULL),(1859,1804,5,549,NULL,6,1,2,NULL),(1860,1805,0,549,NULL,100,1,2,NULL),(1861,1806,0,549,NULL,100,1,2,NULL),(1862,1807,4,549,NULL,5,1,2,NULL),(1863,1808,12,549,NULL,998,1,2,NULL),(1864,1809,14,549,NULL,999,1,2,NULL),(1865,1810,12,549,NULL,998,1,2,NULL),(1866,1811,12,549,NULL,998,1,2,NULL),(1867,1812,14,549,NULL,999,1,2,NULL),(1868,1813,12,549,NULL,998,1,2,NULL),(1869,1814,14,549,NULL,999,1,2,NULL),(1870,1815,14,549,NULL,999,1,2,NULL),(1871,1816,14,549,NULL,999,1,2,NULL),(1872,1817,3,550,NULL,4,1,1,NULL),(1873,1818,2,550,NULL,3,1,1,NULL),(1882,1832,5,550,NULL,6,1,2,NULL),(1883,1833,0,550,NULL,100,1,2,NULL),(1884,1834,0,550,NULL,100,1,2,NULL),(1885,1835,4,550,NULL,5,1,2,NULL),(1886,1836,12,550,NULL,998,1,2,NULL),(1887,1837,14,550,NULL,999,1,2,NULL),(1888,1838,12,550,NULL,998,1,2,NULL),(1889,1839,12,550,NULL,998,1,2,NULL),(1890,1840,14,550,NULL,999,1,2,NULL),(1891,1841,12,550,NULL,998,1,2,NULL),(1892,1842,14,550,NULL,999,1,2,NULL),(1893,1843,14,550,NULL,999,1,2,NULL),(1894,1844,14,550,NULL,999,1,2,NULL),(1949,1899,2,565,NULL,3,1,1,NULL),(1950,1900,3,565,NULL,4,1,1,NULL),(1951,1901,5,565,NULL,6,1,2,NULL),(1952,1902,0,565,NULL,100,1,2,NULL),(1953,1903,0,565,NULL,100,1,2,NULL),(1954,1904,4,565,NULL,5,1,2,NULL),(1955,1905,14,565,NULL,999,1,2,NULL),(1956,1906,14,565,NULL,999,1,2,NULL),(1957,1907,14,565,NULL,999,1,2,NULL),(1958,1908,14,565,NULL,999,1,2,NULL),(1959,1909,14,565,NULL,999,1,2,NULL),(2012,1962,3,569,NULL,4,1,2,NULL),(2013,1963,2,569,NULL,3,1,2,NULL),(2014,1964,10,569,NULL,2,1,2,NULL),(2015,1965,5,569,NULL,6,1,2,NULL),(2016,1966,0,569,NULL,100,1,2,NULL),(2017,1967,0,569,NULL,100,1,2,NULL),(2018,1968,4,569,NULL,5,1,2,NULL),(2019,1969,14,569,NULL,999,1,2,NULL),(2020,1970,14,569,NULL,999,1,2,NULL),(2021,1971,14,569,NULL,999,1,2,NULL),(2022,1972,14,569,NULL,999,1,2,NULL),(2023,1973,14,569,NULL,999,1,2,NULL),(2024,1974,14,569,NULL,999,1,2,NULL),(2025,1975,14,569,NULL,999,1,2,NULL),(2026,1976,14,569,NULL,999,1,2,NULL),(2027,1977,14,569,NULL,999,1,2,NULL),(2028,1978,14,569,NULL,999,1,2,NULL),(2029,1979,14,569,NULL,999,1,2,NULL),(2030,1980,14,569,NULL,999,1,2,NULL),(2031,1981,14,569,NULL,999,1,2,NULL),(2032,1982,14,569,NULL,999,1,2,NULL),(2042,1983,0,423,NULL,1,1,1,NULL),(2062,2055,12,423,NULL,998,1,1,NULL),(2063,1993,13,605,NULL,12,1,2,NULL),(2064,1994,0,605,NULL,100,1,2,NULL),(2065,1995,0,605,NULL,100,1,2,NULL),(2066,1996,0,605,NULL,100,1,2,NULL),(2067,1997,8,605,NULL,11,1,2,NULL),(2068,1998,7,605,NULL,10,1,2,NULL),(2069,1999,0,605,NULL,100,1,2,NULL),(2070,2000,0,605,NULL,100,1,2,NULL),(2071,2001,0,605,NULL,100,1,2,NULL),(2072,2002,14,605,NULL,999,1,2,NULL),(2073,2003,2,588,NULL,3,1,2,NULL),(2074,2004,4,588,NULL,5,1,2,NULL),(2075,2005,10,588,NULL,2,1,2,NULL),(2076,2006,13,588,NULL,12,1,2,NULL),(2077,2007,0,588,NULL,100,1,2,NULL),(2078,2008,0,588,NULL,100,1,2,NULL),(2079,2009,0,588,NULL,100,1,2,NULL),(2080,2010,8,588,NULL,11,1,2,NULL),(2081,2011,7,588,NULL,10,1,2,NULL),(2082,1986,2,587,NULL,3,1,1,NULL),(2083,1987,4,587,NULL,5,1,1,NULL),(2084,1988,10,587,NULL,2,1,1,NULL),(2085,1989,2,605,NULL,3,1,1,NULL),(2086,1990,4,605,NULL,5,1,1,NULL),(2087,1991,3,263,NULL,4,1,1,NULL),(2102,2012,0,588,NULL,100,1,2,NULL),(2103,2013,0,588,NULL,100,1,2,NULL),(2104,2014,0,588,NULL,100,1,2,NULL),(2105,2015,0,588,NULL,100,1,2,NULL),(2106,2016,0,588,NULL,100,1,2,NULL),(2107,2017,0,588,NULL,100,1,2,NULL),(2108,2018,13,588,NULL,12,1,2,NULL),(2109,2019,0,588,NULL,100,1,2,NULL),(2110,2020,14,588,NULL,999,1,2,NULL),(2111,2021,2,589,NULL,3,1,2,NULL),(2112,2022,3,589,NULL,4,1,2,NULL),(2113,2023,10,589,NULL,2,1,2,NULL),(2114,2024,5,589,NULL,6,1,2,NULL),(2115,2025,0,589,NULL,100,1,2,NULL),(2116,2026,0,589,NULL,100,1,2,NULL),(2117,2027,4,589,NULL,5,1,2,NULL),(2118,2028,14,589,NULL,999,1,2,NULL),(2119,2029,14,589,NULL,999,1,2,NULL),(2122,2030,2,627,NULL,3,1,1,NULL),(2123,2031,3,627,NULL,4,1,1,NULL),(2124,2032,12,627,NULL,998,1,1,NULL),(2125,2033,12,627,NULL,998,1,1,NULL);
/*!40000 ALTER TABLE `sx_step_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sx_step_variable_copy`
--

DROP TABLE IF EXISTS `sx_step_variable_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sx_step_variable_copy` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VAR` int(20) DEFAULT NULL,
  `RUOLO` int(20) DEFAULT NULL,
  `STEP` int(20) DEFAULT NULL,
  `ELABORAZIONE` int(20) DEFAULT NULL,
  `PROCESSO` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_variable_copy`
--

LOCK TABLES `sx_step_variable_copy` WRITE;
/*!40000 ALTER TABLE `sx_step_variable_copy` DISABLE KEYS */;
INSERT INTO `sx_step_variable_copy` VALUES (35,24,3,10,83,NULL),(36,25,2,10,83,NULL),(37,26,4,10,83,NULL),(38,27,5,10,83,NULL),(39,28,0,10,83,NULL),(40,29,0,10,83,NULL),(41,30,3,81,110,NULL),(42,31,2,81,110,NULL),(43,32,4,81,110,NULL),(44,33,5,81,110,NULL),(45,34,0,81,110,NULL),(46,35,0,81,110,NULL);
/*!40000 ALTER TABLE `sx_step_variable_copy` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_tipo_io`
--

LOCK TABLES `sx_tipo_io` WRITE;
/*!40000 ALTER TABLE `sx_tipo_io` DISABLE KEYS */;
INSERT INTO `sx_tipo_io` VALUES (1,'INPUT'),(2,'OUTPUT');
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
) ENGINE=InnoDB AUTO_INCREMENT=364 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_users`
--

LOCK TABLES `sx_users` WRITE;
/*!40000 ALTER TABLE `sx_users` DISABLE KEYS */;
INSERT INTO `sx_users` VALUES (1,'admin@mecbox.it','Admin','Mecbox','$2a$10$9rKQEP7mbFoCN82iNx16wuoVQ56WqQBGxbwU2HmDWI0G1BSucJqGW',1),(83,'fra@fra.it','Francesco','Amato','$2a$10$01yvIFwhDkEOT9nBugTleDM73OkZffZUdfmvjMCEXdJr3PZP8Kxm',1),(203,'a@b.it','Stefano','Macone','$2a$10$127gmomH1EBkF8rXD0Q.veTp3sXGZzk./Q3cZ5Z9LqflXv7/9dpfO',1),(223,'pag@pag.it','pag','pag','$2a$10$eI8hDiZc2VdfECcj3npNM.2yTKRCmEqAYz3eH/.Jn3KOX1CzPrOcW',1),(224,'ian@ian.it','Renzo','Iannacone','$2a$10$uFLloGyoJToQHa/wNQ/DsuEhRdgJqbm.54EdvXrBJyePS32nVl/aa',2),(243,'user@user.it','user','test','$2a$10$Os2iXaChPX/TjB1NB3DxE.54cmf4WMcGkl3rfPCnr6.A.pSAtFVTS',2),(283,'filiberti@istat.it','Salvatore','Filiberti','$2a$10$/zfiNg9tFvCZr5cSloxP3umYtT/vXOby9Nx9si1FSsIx9y/CE0Oyy',1),(303,'survey@istat.it','Referente di indagine','test','$2a$10$NFjqLfMHpUk5i/z.gOqcu.ADN2jiB/GwFEgZB09b3i/Za3RU2GfE.',1),(304,'gm@istat.it','Grande','Mas','$2a$10$VDYchOLAeteZ/qcvLuC4puzxj1AqClt2/rNvm/ME/8ruUsQXxEveu',1),(323,'a@l.it','Pippo','Franco','$2a$10$QIxJNxWCiG6quwVIFTMW0Oj35tLFhhmkOVnAw/Vse0Ohq7xYuwRDm',2),(344,'sintesi@istat.it','Selemix','Sintesi','$2a$10$NENlbygaMF4vyiIPX1Hvi.wHmFR9vofM7GuFbmtGo1qfwflpkanN.',1),(363,'iannacone@istat.it','Renzo','Iannacone','$2a$10$Doy/0ecZ1ePEyMPsliybbe6ztubWQ4NY92G80P1.ZiEX1KK0ejNLu',1);
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
  `NOME` varchar(255) DEFAULT NULL,
  `ORDINE` int(20) DEFAULT NULL,
  `VALORI` blob,
  `TIPO_VAR` int(20) DEFAULT NULL,
  `VALORI_SIZE` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014021` (`ID`),
  KEY `TIPOVAR` (`TIPO_VAR`)
) ENGINE=InnoDB AUTO_INCREMENT=2056 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_workset`
--

LOCK TABLES `sx_workset` WRITE;
/*!40000 ALTER TABLE `sx_workset` DISABLE KEYS */;
INSERT INTO `sx_workset` VALUES (784,'FNM_G_2017',NULL,NULL,1,400),(785,'FNM_P_2016',NULL,NULL,1,400),(786,'global_score',NULL,NULL,1,400),(787,'y1_reserr',NULL,NULL,1,400),(788,'y1_sel',NULL,NULL,1,400),(789,'y1',NULL,NULL,1,400),(790,'rank',NULL,NULL,1,400),(791,'sel',NULL,NULL,1,400),(792,'weights',NULL,NULL,1,400),(793,'y1_p',NULL,NULL,1,400),(794,'y1_score',NULL,NULL,1,400),(800,'Y1',NULL,NULL,1,500),(944,'model',NULL,NULL,2,1),(1000,'FNM_G_2017',NULL,NULL,1,400),(1001,'FNM_P_2016',NULL,NULL,1,400),(1002,'FNM_G_2017',NULL,NULL,1,400),(1003,'FNM_P_2016',NULL,NULL,1,400),(1004,'FNM_G_2017',NULL,NULL,1,400),(1005,'FNM_G_2017',NULL,NULL,1,400),(1006,'FNM_P_2016',NULL,NULL,1,400),(1014,'FNM_G_2017',NULL,NULL,1,400),(1015,'FEM_G_2017',NULL,NULL,1,400),(1019,'FNM_P_2016',NULL,NULL,1,400),(1020,'global_score',NULL,NULL,1,400),(1021,'y1_reserr',NULL,NULL,1,400),(1022,'y1_sel',NULL,NULL,1,400),(1023,'y1',NULL,NULL,1,400),(1024,'rank',NULL,NULL,1,400),(1025,'sel',NULL,NULL,1,400),(1026,'weights',NULL,NULL,1,400),(1027,'y1_p',NULL,NULL,1,400),(1028,'y1_score',NULL,NULL,1,400),(1030,'w',NULL,NULL,2,1),(1104,'global_score',NULL,NULL,1,400),(1105,'y1_reserr',NULL,NULL,1,400),(1106,'y1_sel',NULL,NULL,1,400),(1107,'y1_p',NULL,NULL,1,400),(1108,'y1_score',NULL,NULL,1,400),(1119,'FNM_G_2017',NULL,NULL,1,400),(1120,'FEM_G_2017',NULL,NULL,1,400),(1121,'FNM_G_2017',NULL,NULL,1,400),(1122,'FNM_P_2016',NULL,NULL,1,400),(1123,'B',NULL,NULL,2,2),(1124,'lambda',NULL,NULL,2,1),(1125,'w',NULL,NULL,2,1),(1126,'sigma',NULL,NULL,2,1),(1127,'FNM_G_2017',NULL,NULL,1,400),(1128,'FNM_P_2016',NULL,NULL,1,400),(1130,'FNM_G_2017',NULL,NULL,1,400),(1131,'FNM_P_2016',NULL,NULL,1,400),(1132,'global_score',NULL,NULL,1,400),(1133,'y1_reserr',NULL,NULL,1,400),(1134,'y1_sel',NULL,NULL,1,400),(1135,'y1',NULL,NULL,1,400),(1136,'rank',NULL,NULL,1,400),(1137,'sel',NULL,NULL,1,400),(1138,'weights',NULL,NULL,1,400),(1139,'y1_p',NULL,NULL,1,400),(1140,'y1_score',NULL,NULL,1,400),(1141,'FNM_G_2017',NULL,NULL,1,400),(1142,'FEM_P_2016',NULL,NULL,1,400),(1143,'t.outl',NULL,NULL,2,1),(1144,'outlier',NULL,NULL,1,400),(1145,'pattern',NULL,NULL,1,400),(1146,'tau',NULL,NULL,1,400),(1147,'YPRED_1',NULL,NULL,1,400),(1148,'ID',NULL,NULL,1,500),(1149,'t.outl',NULL,NULL,2,1),(1150,'outlier',NULL,NULL,1,400),(1151,'pattern',NULL,NULL,1,400),(1152,'tau',NULL,NULL,1,400),(1153,'YPRED_1',NULL,NULL,1,400),(1154,'YPRED_2',NULL,NULL,1,400),(1155,'sigma',NULL,NULL,2,4),(1156,'bic_aic',NULL,NULL,2,4),(1157,'B',NULL,NULL,2,2),(1158,'lambda',NULL,NULL,2,1),(1159,'n_outlier',NULL,NULL,2,1),(1160,'w',NULL,NULL,2,1),(1161,'missing',NULL,NULL,2,1),(1162,'is_conv',NULL,NULL,2,1),(1163,'sing',NULL,NULL,2,1),(1165,'FNM_G_2017',NULL,NULL,1,400),(1168,'FNM_G_2017',NULL,NULL,1,400),(1169,'FNM_P_2016',NULL,NULL,1,400),(1170,'outlier',NULL,NULL,1,400),(1171,'pattern',NULL,NULL,1,400),(1172,'tau',NULL,NULL,1,400),(1173,'YPRED_1',NULL,NULL,1,400),(1174,'sigma',NULL,NULL,2,1),(1175,'bic_aic',NULL,NULL,2,4),(1176,'B',NULL,NULL,2,2),(1177,'lambda',NULL,NULL,2,1),(1178,'n_outlier',NULL,NULL,2,1),(1179,'w',NULL,NULL,2,1),(1180,'missing',NULL,NULL,2,1),(1181,'is_conv',NULL,NULL,2,1),(1182,'sing',NULL,NULL,2,1),(1183,'FNM_G_2017',NULL,NULL,1,400),(1184,'FNM_P_2016',NULL,NULL,1,400),(1185,'global_score',NULL,NULL,1,400),(1186,'y1_reserr',NULL,NULL,1,400),(1187,'y1_sel',NULL,NULL,1,400),(1188,'y1',NULL,NULL,1,400),(1189,'rank',NULL,NULL,1,400),(1190,'sel',NULL,NULL,1,400),(1191,'weights',NULL,NULL,1,400),(1192,'y1_p',NULL,NULL,1,400),(1193,'y1_score',NULL,NULL,1,400),(1203,'sigma',NULL,NULL,2,1),(1204,'bic_aic',NULL,NULL,2,4),(1205,'B',NULL,NULL,2,2),(1206,'lambda',NULL,NULL,2,1),(1207,'n_outlier',NULL,NULL,2,1),(1208,'w',NULL,NULL,2,1),(1209,'missing',NULL,NULL,2,1),(1210,'is_conv',NULL,NULL,2,1),(1211,'sing',NULL,NULL,2,1),(1212,'bic_aic',NULL,NULL,2,4),(1213,'n_outlier',NULL,NULL,2,1),(1214,'is_conv',NULL,NULL,2,1),(1215,'bic_aic',NULL,NULL,2,4),(1216,'n_outlier',NULL,NULL,2,1),(1217,'is_conv',NULL,NULL,2,1),(1218,'bic_aic',NULL,NULL,2,4),(1219,'n_outlier',NULL,NULL,2,1),(1220,'is_conv',NULL,NULL,2,1),(1221,'bic_aic',NULL,NULL,2,4),(1222,'n_outlier',NULL,NULL,2,1),(1223,'is_conv',NULL,NULL,2,1),(1224,'bic_aic',NULL,NULL,2,4),(1225,'n_outlier',NULL,NULL,2,1),(1226,'is_conv',NULL,NULL,2,1),(1227,'bic_aic',NULL,NULL,2,4),(1228,'n_outlier',NULL,NULL,2,1),(1229,'is_conv',NULL,NULL,2,1),(1230,'bic_aic',NULL,NULL,2,4),(1231,'n_outlier',NULL,NULL,2,1),(1232,'is_conv',NULL,NULL,2,1),(1233,'bic_aic',NULL,NULL,2,4),(1234,'n_outlier',NULL,NULL,2,1),(1235,'is_conv',NULL,NULL,2,1),(1236,'bic_aic',NULL,NULL,2,4),(1237,'n_outlier',NULL,NULL,2,1),(1238,'is_conv',NULL,NULL,2,1),(1239,'bic_aic',NULL,NULL,2,4),(1240,'n_outlier',NULL,NULL,2,1),(1241,'is_conv',NULL,NULL,2,1),(1242,'bic_aic',NULL,NULL,2,4),(1243,'n_outlier',NULL,NULL,2,1),(1244,'is_conv',NULL,NULL,2,1),(1250,'outlier',NULL,NULL,1,400),(1251,'pattern',NULL,NULL,1,400),(1252,'tau',NULL,NULL,1,400),(1253,'YPRED_1',NULL,NULL,1,400),(1254,'global_score',NULL,NULL,1,400),(1255,'y1_reserr',NULL,NULL,1,400),(1256,'y1_sel',NULL,NULL,1,400),(1257,'y1',NULL,NULL,1,400),(1258,'rank',NULL,NULL,1,400),(1259,'sel',NULL,NULL,1,400),(1260,'weights',NULL,NULL,1,400),(1261,'y1_p',NULL,NULL,1,400),(1262,'y1_score',NULL,NULL,1,400),(1269,'bic_aic',NULL,NULL,2,4),(1270,'n_outlier',NULL,NULL,2,1),(1271,'is_conv',NULL,NULL,2,1),(1272,'FNM_G_2017',NULL,NULL,1,400),(1273,'FNM_P_2016',NULL,NULL,1,400),(1274,'outlier',NULL,NULL,1,400),(1275,'pattern',NULL,NULL,1,400),(1276,'tau',NULL,NULL,1,400),(1277,'YPRED_1',NULL,NULL,1,400),(1278,'sigma',NULL,NULL,2,1),(1279,'bic_aic',NULL,NULL,2,4),(1280,'B',NULL,NULL,2,2),(1281,'lambda',NULL,NULL,2,1),(1282,'n_outlier',NULL,NULL,2,1),(1283,'w',NULL,NULL,2,1),(1284,'missing',NULL,NULL,2,1),(1285,'is_conv',NULL,NULL,2,1),(1286,'sing',NULL,NULL,2,1),(1287,'outlier',NULL,NULL,1,400),(1288,'pattern',NULL,NULL,1,400),(1289,'tau',NULL,NULL,1,400),(1290,'YPRED_1',NULL,NULL,1,400),(1291,'YPRED_2',NULL,NULL,1,400),(1292,'FNM_G_2017',NULL,NULL,1,400),(1293,'FNM_P_2016',NULL,NULL,1,400),(1294,'outlier',NULL,NULL,1,400),(1295,'pattern',NULL,NULL,1,400),(1296,'tau',NULL,NULL,1,400),(1297,'YPRED_1',NULL,NULL,1,400),(1298,'FNM_G_2017',NULL,NULL,1,400),(1299,'FNM_P_2016',NULL,NULL,1,400),(1300,'outlier',NULL,NULL,1,400),(1301,'pattern',NULL,NULL,1,400),(1302,'tau',NULL,NULL,1,400),(1303,'YPRED_1',NULL,NULL,1,400),(1304,'global_score',NULL,NULL,1,400),(1305,'y1_reserr',NULL,NULL,1,400),(1306,'y1_sel',NULL,NULL,1,400),(1307,'y1',NULL,NULL,1,400),(1308,'rank',NULL,NULL,1,400),(1309,'sel',NULL,NULL,1,400),(1310,'weights',NULL,NULL,1,400),(1311,'y1_p',NULL,NULL,1,400),(1312,'y1_score',NULL,NULL,1,400),(1330,'Y1',NULL,NULL,1,500),(1331,'outlier',NULL,NULL,1,500),(1332,'pattern',NULL,NULL,1,500),(1333,'tau',NULL,NULL,1,500),(1334,'YPRED_1',NULL,NULL,1,500),(1336,'sigma',NULL,NULL,2,1),(1338,'model',NULL,NULL,2,1),(1339,'tot',NULL,NULL,2,1),(1340,'t.sel',NULL,NULL,2,1),(1341,'w',NULL,NULL,2,1),(1342,'w',NULL,NULL,2,1),(1343,'t.sel',NULL,NULL,2,1),(1344,'t.sel',NULL,NULL,2,1),(1350,'FNM_G_2017',NULL,NULL,1,400),(1351,'FNM_P_2016',NULL,NULL,1,400),(1352,'outlier',NULL,NULL,1,400),(1353,'pattern',NULL,NULL,1,400),(1354,'tau',NULL,NULL,1,400),(1355,'YPRED_1',NULL,NULL,1,400),(1356,'global_score',NULL,NULL,1,400),(1357,'y1_reserr',NULL,NULL,1,400),(1358,'y1_sel',NULL,NULL,1,400),(1359,'y1',NULL,NULL,1,400),(1360,'rank',NULL,NULL,1,400),(1361,'sel',NULL,NULL,1,400),(1362,'weights',NULL,NULL,1,400),(1363,'y1_p',NULL,NULL,1,400),(1364,'y1_score',NULL,NULL,1,400),(1401,'ID',NULL,NULL,1,500),(1436,'FEM_P_2016',NULL,NULL,1,73544),(1437,'FEM_G_2017',NULL,NULL,1,73544),(1450,'FEM_G_2017',NULL,NULL,1,73544),(1451,'FEM_P_2016',NULL,NULL,1,73544),(1452,'outlier',NULL,NULL,1,73544),(1453,'pattern',NULL,NULL,1,73544),(1454,'tau',NULL,NULL,1,73544),(1455,'YPRED_1',NULL,NULL,1,73544),(1456,'sigma',NULL,NULL,2,1),(1457,'bic_aic',NULL,NULL,2,4),(1458,'B',NULL,NULL,2,2),(1459,'lambda',NULL,NULL,2,1),(1460,'n_outlier',NULL,NULL,2,1),(1461,'w',NULL,NULL,2,1),(1462,'missing',NULL,NULL,2,1),(1463,'is_conv',NULL,NULL,2,1),(1464,'sing',NULL,NULL,2,1),(1465,'lambda.fix',NULL,NULL,2,1),(1512,'FNM_G_2017',NULL,NULL,1,400),(1513,'FTM_G_2017',NULL,NULL,1,400),(1802,'X1',NULL,NULL,1,500),(1803,'Y1',NULL,NULL,1,500),(1804,'outlier',NULL,NULL,1,500),(1805,'pattern',NULL,NULL,1,500),(1806,'tau',NULL,NULL,1,500),(1807,'YPRED_1',NULL,NULL,1,500),(1808,'sigma',NULL,NULL,2,1),(1809,'bic_aic',NULL,NULL,2,4),(1810,'B',NULL,NULL,2,2),(1811,'lambda',NULL,NULL,2,1),(1812,'n_outlier',NULL,NULL,2,1),(1813,'w',NULL,NULL,2,1),(1814,'missing',NULL,NULL,2,1),(1815,'is_conv',NULL,NULL,2,1),(1816,'sing',NULL,NULL,2,1),(1817,'X1',NULL,NULL,1,500),(1818,'Y1',NULL,NULL,1,500),(1832,'outlier',NULL,NULL,1,500),(1833,'pattern',NULL,NULL,1,500),(1834,'tau',NULL,NULL,1,500),(1835,'YPRED_1',NULL,NULL,1,500),(1836,'sigma',NULL,NULL,2,1),(1837,'bic_aic',NULL,NULL,2,4),(1838,'B',NULL,NULL,2,2),(1839,'lambda',NULL,NULL,2,1),(1840,'n_outlier',NULL,NULL,2,1),(1841,'w',NULL,NULL,2,1),(1842,'missing',NULL,NULL,2,1),(1843,'is_conv',NULL,NULL,2,1),(1844,'sing',NULL,NULL,2,1),(1899,'Y1',NULL,NULL,1,98),(1900,'X1',NULL,NULL,1,98),(1901,'outlier',NULL,NULL,1,98),(1902,'pattern',NULL,NULL,1,98),(1903,'tau',NULL,NULL,1,98),(1904,'YPRED_1',NULL,NULL,1,98),(1905,'bic_aic',NULL,NULL,2,4),(1906,'n_outlier',NULL,NULL,2,1),(1907,'missing',NULL,NULL,2,1),(1908,'is_conv',NULL,NULL,2,1),(1909,'sing',NULL,NULL,2,1),(1962,'X1',NULL,NULL,1,500),(1963,'Y1',NULL,NULL,1,500),(1964,'S1',NULL,NULL,1,500),(1965,'outlier',NULL,NULL,1,500),(1966,'pattern',NULL,NULL,1,500),(1967,'tau',NULL,NULL,1,500),(1968,'YPRED_1',NULL,NULL,1,500),(1969,'bic_aic',NULL,NULL,2,4),(1970,'n_outlier',NULL,NULL,2,1),(1971,'missing',NULL,NULL,2,1),(1972,'is_conv',NULL,NULL,2,1),(1973,'sing',NULL,NULL,2,1),(1974,'bic_aic',NULL,NULL,2,4),(1975,'n_outlier',NULL,NULL,2,1),(1976,'is_conv',NULL,NULL,2,1),(1977,'bic_aic',NULL,NULL,2,4),(1978,'n_outlier',NULL,NULL,2,1),(1979,'is_conv',NULL,NULL,2,1),(1980,'bic_aic',NULL,NULL,2,4),(1981,'n_outlier',NULL,NULL,2,1),(1982,'is_conv',NULL,NULL,2,1),(1983,'COD_DITT',NULL,NULL,1,73544),(1984,'w',NULL,NULL,2,1),(1985,'w',NULL,NULL,2,2),(1986,'Y1',NULL,NULL,1,500),(1987,'X1',NULL,NULL,1,500),(1988,'S1',NULL,NULL,1,500),(1989,'Y1',NULL,NULL,1,500),(1990,'X1',NULL,NULL,1,500),(1991,'X1',NULL,NULL,1,500),(1992,'w',NULL,NULL,2,2),(1993,'global_score',NULL,NULL,1,500),(1994,'y1_reserr',NULL,NULL,1,500),(1995,'y1_sel',NULL,NULL,1,500),(1996,'y1',NULL,NULL,1,500),(1997,'rank',NULL,NULL,1,500),(1998,'sel',NULL,NULL,1,500),(1999,'weights',NULL,NULL,1,500),(2000,'y1_p',NULL,NULL,1,500),(2001,'y1_score',NULL,NULL,1,500),(2002,'n_error',NULL,NULL,2,1),(2003,'Y1',NULL,NULL,1,500),(2004,'X1',NULL,NULL,1,500),(2005,'S1',NULL,NULL,1,500),(2006,'global_score',NULL,NULL,1,500),(2007,'y1_reserr',NULL,NULL,1,500),(2008,'y1_sel',NULL,NULL,1,500),(2009,'y1',NULL,NULL,1,500),(2010,'rank',NULL,NULL,1,500),(2011,'sel',NULL,NULL,1,500),(2012,'weights',NULL,NULL,1,500),(2013,'y1_p',NULL,NULL,1,500),(2014,'y1_score',NULL,NULL,1,500),(2015,'y1_reserr',NULL,NULL,1,500),(2016,'y1_sel',NULL,NULL,1,500),(2017,'y1_p',NULL,NULL,1,500),(2018,'global_score',NULL,NULL,1,500),(2019,'y1_score',NULL,NULL,1,500),(2020,'n_error',NULL,NULL,2,1),(2021,'Y1',NULL,NULL,1,500),(2022,'X1',NULL,NULL,1,500),(2023,'S1',NULL,NULL,1,500),(2024,'outlier',NULL,NULL,1,500),(2025,'pattern',NULL,NULL,1,500),(2026,'tau',NULL,NULL,1,500),(2027,'ypred1',NULL,NULL,1,500),(2028,'n_outlier',NULL,NULL,2,1),(2029,'missing',NULL,NULL,2,1),(2030,'MESE',NULL,NULL,1,73544),(2031,'FEM_G_2017',NULL,NULL,1,73544),(2032,'lambda',NULL,NULL,2,1),(2033,'B',NULL,NULL,2,1),(2055,'w',NULL,NULL,2,2);
/*!40000 ALTER TABLE `sx_workset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_variabile_sum`
--

DROP TABLE IF EXISTS `tipo_variabile_sum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipo_variabile_sum` (
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
-- Dumping data for table `tipo_variabile_sum`
--

LOCK TABLES `tipo_variabile_sum` WRITE;
/*!40000 ALTER TABLE `tipo_variabile_sum` DISABLE KEYS */;
INSERT INTO `tipo_variabile_sum` VALUES ('VARIABILI STATISTICHE DI CLASSIFICAZIONE','CLASSIFICATION',1,'Variabili statistiche di classificazione',2),('VARIABILI STATISTICHE NUMERICHE','NUMERIC',2,'Variabili statistiche numeriche',3),('VARIABILI STATISTICHE TESTUALI','TEXTUAL/OPENED',3,'Variabili statistiche testuali',4),('CONCETTI DI TIPO OPERATIVO','OPERATIONAL',4,'Concetti di tipo operativo',6),('CONCETTI DI TIPO TEMPORALE','TEMPORALE',5,'Concetti di tipo temporale',7),('AGGREGATO','AGGREGATE',6,'Concetti relativi al contenuto dei dati',5),('CONCETTI RELATIVI ALLA FREQUENZA','FREQUENCY',7,'Concetti relativi alla frequenza',8),('VARIABILI IDENTIFICATIVE DELLE UNITÀ','INDENTIFIER',8,'Variabili identificative delle unità',1),('NON DEFINITA','UNDEFINED',9,'Variabili non definite',12),('PESO','PESO',10,'Concetti usati per identificare il peso campionario',9),('CONCETTI IDENTIFICATIVI DEL DATASET','DATASET IDENTIFIER',11,'Variabili statistiche composte',11),('PARADATO','PARADATA',12,'Paradati ..',10);
/*!40000 ALTER TABLE `tipo_variabile_sum` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-19 14:48:18
