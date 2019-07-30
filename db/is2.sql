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
INSERT INTO `batch_job_execution` VALUES (1,2,1,'2019-07-22 11:39:49','2019-07-22 11:39:49','2019-07-22 11:39:50','FAILED','FAILED','','2019-07-22 11:39:50',NULL,13,25,70),(2,2,2,'2019-07-24 15:00:32','2019-07-24 15:00:33','2019-07-24 15:03:09','FAILED','FAILED','','2019-07-24 15:03:09',NULL,13,25,70),(3,2,3,'2019-07-24 15:24:03','2019-07-24 15:24:03','2019-07-24 16:14:03','FAILED','FAILED','','2019-07-24 16:14:03',NULL,13,25,70),(4,2,4,'2019-07-24 16:14:24','2019-07-24 16:14:24','2019-07-24 16:15:49','COMPLETED','COMPLETED','','2019-07-24 16:15:49',NULL,13,25,70),(5,2,5,'2019-07-25 12:33:45','2019-07-25 12:33:45','2019-07-25 12:33:46','COMPLETED','COMPLETED','','2019-07-25 12:33:46',NULL,13,25,70),(6,2,6,'2019-07-25 12:34:06','2019-07-25 12:34:07','2019-07-25 12:34:07','FAILED','FAILED','','2019-07-25 12:34:07',NULL,13,25,71),(7,2,7,'2019-07-25 12:34:31','2019-07-25 12:34:32','2019-07-25 12:34:33','FAILED','FAILED','','2019-07-25 12:34:33',NULL,13,25,71),(8,2,8,'2019-07-25 12:35:33','2019-07-25 12:35:33','2019-07-25 12:35:34','FAILED','FAILED','','2019-07-25 12:35:34',NULL,13,25,71),(9,2,9,'2019-07-25 12:39:11','2019-07-25 12:39:11','2019-07-25 12:40:00','FAILED','FAILED','','2019-07-25 12:40:01',NULL,13,25,71),(10,2,10,'2019-07-25 12:40:07','2019-07-25 12:40:08','2019-07-25 12:40:48','FAILED','FAILED','','2019-07-25 12:40:48',NULL,13,25,71),(11,2,11,'2019-07-25 12:41:22','2019-07-25 12:41:22','2019-07-25 12:42:11','FAILED','FAILED','','2019-07-25 12:42:11',NULL,13,25,71),(12,2,12,'2019-07-25 12:42:58','2019-07-25 12:42:58','2019-07-25 12:43:01','COMPLETED','COMPLETED','','2019-07-25 12:43:01',NULL,13,25,71),(13,2,13,'2019-07-25 12:43:29','2019-07-25 12:43:29','2019-07-25 12:43:30','FAILED','FAILED','','2019-07-25 12:43:30',NULL,13,25,72),(14,2,14,'2019-07-25 12:48:44','2019-07-25 12:48:44','2019-07-25 12:48:46','COMPLETED','COMPLETED','','2019-07-25 12:48:46',NULL,13,25,72),(15,2,15,'2019-07-25 16:01:34','2019-07-25 16:01:34','2019-07-26 08:21:09','FAILED','FAILED','','2019-07-26 08:21:09',NULL,13,25,70),(16,2,16,'2019-07-26 08:21:43','2019-07-26 08:21:44','2019-07-26 09:56:32','FAILED','FAILED','','2019-07-26 09:56:32',NULL,13,25,72),(17,2,17,'2019-07-26 10:03:21','2019-07-26 10:03:21','2019-07-26 10:03:58','FAILED','FAILED','','2019-07-26 10:03:59',NULL,13,25,72),(18,2,18,'2019-07-26 10:04:18','2019-07-26 10:04:19','2019-07-26 10:06:14','FAILED','FAILED','','2019-07-26 10:06:14',NULL,13,25,72),(19,2,19,'2019-07-26 10:04:21','2019-07-26 10:04:22','2019-07-26 10:06:09','FAILED','FAILED','','2019-07-26 10:06:09',NULL,13,25,72),(20,2,20,'2019-07-26 10:06:22','2019-07-26 10:06:22','2019-07-26 10:06:33','FAILED','FAILED','','2019-07-26 10:06:33',NULL,13,25,72),(21,2,21,'2019-07-26 10:06:52','2019-07-26 10:06:52','2019-07-26 10:07:06','FAILED','FAILED','','2019-07-26 10:07:06',NULL,13,25,72),(22,2,22,'2019-07-26 10:07:45','2019-07-26 10:07:46','2019-07-26 10:08:15','FAILED','FAILED','','2019-07-26 10:08:16',NULL,13,25,72),(23,2,23,'2019-07-26 10:11:33','2019-07-26 10:11:33','2019-07-26 10:16:58','FAILED','FAILED','','2019-07-26 10:16:58',NULL,13,25,72),(24,2,24,'2019-07-26 10:26:39','2019-07-26 10:26:40','2019-07-26 11:10:28','COMPLETED','COMPLETED','','2019-07-26 11:10:29',NULL,13,25,72),(25,2,25,'2019-07-26 11:10:11','2019-07-26 11:10:11','2019-07-26 11:11:23','COMPLETED','COMPLETED','','2019-07-26 11:11:23',NULL,13,25,70),(26,2,26,'2019-07-26 11:11:53','2019-07-26 11:11:53','2019-07-26 12:21:44','FAILED','FAILED','','2019-07-26 12:21:45',NULL,13,25,70),(27,2,27,'2019-07-26 12:22:20','2019-07-26 12:22:20','2019-07-26 12:30:38','FAILED','FAILED','','2019-07-26 12:30:39',NULL,13,25,72),(28,2,28,'2019-07-26 12:30:57','2019-07-26 12:30:57','2019-07-26 12:31:40','FAILED','FAILED','','2019-07-26 12:31:40',NULL,13,25,72),(29,2,29,'2019-07-26 12:32:00','2019-07-26 12:32:01','2019-07-26 12:33:05','FAILED','FAILED','','2019-07-26 12:33:06',NULL,13,25,72),(30,2,30,'2019-07-26 12:51:28','2019-07-26 12:51:29','2019-07-26 12:51:36','FAILED','FAILED','','2019-07-26 12:51:36',NULL,13,25,70),(31,2,31,'2019-07-26 12:52:52','2019-07-26 12:52:52','2019-07-26 12:53:00','COMPLETED','COMPLETED','','2019-07-26 12:53:00',NULL,13,25,70),(32,2,32,'2019-07-26 13:03:03','2019-07-26 13:03:04','2019-07-26 13:03:08','COMPLETED','COMPLETED','','2019-07-26 13:03:08',NULL,13,25,71),(33,2,33,'2019-07-26 13:03:42','2019-07-26 13:03:43','2019-07-26 13:04:07','COMPLETED','COMPLETED','','2019-07-26 13:04:07',NULL,13,25,72),(34,2,34,'2019-07-26 13:10:20','2019-07-26 13:10:21','2019-07-26 13:10:23','COMPLETED','COMPLETED','','2019-07-26 13:10:23',NULL,13,25,72);
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
INSERT INTO `batch_job_execution_context` VALUES (1,'{}',NULL),(2,'{}',NULL),(3,'{}',NULL),(4,'{}',NULL),(5,'{}',NULL),(6,'{}',NULL),(7,'{}',NULL),(8,'{}',NULL),(9,'{}',NULL),(10,'{}',NULL),(11,'{}',NULL),(12,'{}',NULL),(13,'{}',NULL),(14,'{}',NULL),(15,'{}',NULL),(16,'{}',NULL),(17,'{}',NULL),(18,'{}',NULL),(19,'{}',NULL),(20,'{}',NULL),(21,'{}',NULL),(22,'{}',NULL),(23,'{}',NULL),(24,'{}',NULL),(25,'{}',NULL),(26,'{}',NULL),(27,'{}',NULL),(28,'{}',NULL),(29,'{}',NULL),(30,'{}',NULL),(31,'{}',NULL),(32,'{}',NULL),(33,'{}',NULL),(34,'{}',NULL);
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
INSERT INTO `batch_job_execution_params` VALUES (1,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(1,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(1,'LONG','time','','1970-01-01 00:00:00',1563795588493,0,'Y'),(2,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(2,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(2,'LONG','time','','1970-01-01 00:00:00',1563980432029,0,'Y'),(3,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(3,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(3,'LONG','time','','1970-01-01 00:00:00',1563981842883,0,'Y'),(4,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(4,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(4,'LONG','time','','1970-01-01 00:00:00',1563984863729,0,'Y'),(5,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(5,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(5,'LONG','time','','1970-01-01 00:00:00',1564058024390,0,'Y'),(6,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(6,'LONG','idBProc','','1970-01-01 00:00:00',71,0,'Y'),(6,'LONG','time','','1970-01-01 00:00:00',1564058046260,0,'Y'),(7,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(7,'LONG','idBProc','','1970-01-01 00:00:00',71,0,'Y'),(7,'LONG','time','','1970-01-01 00:00:00',1564058070996,0,'Y'),(8,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(8,'LONG','idBProc','','1970-01-01 00:00:00',71,0,'Y'),(8,'LONG','time','','1970-01-01 00:00:00',1564058132650,0,'Y'),(9,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(9,'LONG','idBProc','','1970-01-01 00:00:00',71,0,'Y'),(9,'LONG','time','','1970-01-01 00:00:00',1564058350583,0,'Y'),(10,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(10,'LONG','idBProc','','1970-01-01 00:00:00',71,0,'Y'),(10,'LONG','time','','1970-01-01 00:00:00',1564058407244,0,'Y'),(11,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(11,'LONG','idBProc','','1970-01-01 00:00:00',71,0,'Y'),(11,'LONG','time','','1970-01-01 00:00:00',1564058482048,0,'Y'),(12,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(12,'LONG','idBProc','','1970-01-01 00:00:00',71,0,'Y'),(12,'LONG','time','','1970-01-01 00:00:00',1564058578136,0,'Y'),(13,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(13,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(13,'LONG','time','','1970-01-01 00:00:00',1564058608863,0,'Y'),(14,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(14,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(14,'LONG','time','','1970-01-01 00:00:00',1564058924090,0,'Y'),(15,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(15,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(15,'LONG','time','','1970-01-01 00:00:00',1564070493431,0,'Y'),(16,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(16,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(16,'LONG','time','','1970-01-01 00:00:00',1564129303373,0,'Y'),(17,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(17,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(17,'LONG','time','','1970-01-01 00:00:00',1564135400430,0,'Y'),(18,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(18,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(18,'LONG','time','','1970-01-01 00:00:00',1564135458348,0,'Y'),(19,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(19,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(19,'LONG','time','','1970-01-01 00:00:00',1564135460865,0,'Y'),(20,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(20,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(20,'LONG','time','','1970-01-01 00:00:00',1564135581831,0,'Y'),(21,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(21,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(21,'LONG','time','','1970-01-01 00:00:00',1564135611570,0,'Y'),(22,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(22,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(22,'LONG','time','','1970-01-01 00:00:00',1564135665162,0,'Y'),(23,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(23,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(23,'LONG','time','','1970-01-01 00:00:00',1564135892468,0,'Y'),(24,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(24,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(24,'LONG','time','','1970-01-01 00:00:00',1564136799253,0,'Y'),(25,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(25,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(25,'LONG','time','','1970-01-01 00:00:00',1564139410579,0,'Y'),(26,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(26,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(26,'LONG','time','','1970-01-01 00:00:00',1564139512503,0,'Y'),(27,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(27,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(27,'LONG','time','','1970-01-01 00:00:00',1564143739756,0,'Y'),(28,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(28,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(28,'LONG','time','','1970-01-01 00:00:00',1564144256482,0,'Y'),(29,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(29,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(29,'LONG','time','','1970-01-01 00:00:00',1564144319985,0,'Y'),(30,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(30,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(30,'LONG','time','','1970-01-01 00:00:00',1564145488195,0,'Y'),(31,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(31,'LONG','idBProc','','1970-01-01 00:00:00',70,0,'Y'),(31,'LONG','time','','1970-01-01 00:00:00',1564145571622,0,'Y'),(32,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(32,'LONG','idBProc','','1970-01-01 00:00:00',71,0,'Y'),(32,'LONG','time','','1970-01-01 00:00:00',1564146183300,0,'Y'),(33,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(33,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(33,'LONG','time','','1970-01-01 00:00:00',1564146222258,0,'Y'),(34,'LONG','idElaborazione','','1970-01-01 00:00:00',25,0,'Y'),(34,'LONG','idBProc','','1970-01-01 00:00:00',72,0,'Y'),(34,'LONG','time','','1970-01-01 00:00:00',1564146620273,0,'Y');
/*!40000 ALTER TABLE `batch_job_execution_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_execution_seq`
--

DROP TABLE IF EXISTS `batch_job_execution_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_job_execution_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_job_execution_seq`
--

LOCK TABLES `batch_job_execution_seq` WRITE;
/*!40000 ALTER TABLE `batch_job_execution_seq` DISABLE KEYS */;
INSERT INTO `batch_job_execution_seq` VALUES (34,'0');
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
INSERT INTO `batch_job_instance` VALUES (1,0,'doBusinessProc','af234e5aeff25510399c1d5c1695bad9'),(2,0,'doBusinessProc','3b5b08c6826345651cd15efd63b118e9'),(3,0,'doBusinessProc','aa0ada7add62c2f40cde87f1ab97b9df'),(4,0,'doBusinessProc','d770fda2d18b3ff8cda0e26a3632c2e0'),(5,0,'doBusinessProc','063d729c575637b4d9ea8a738ac76000'),(6,0,'doBusinessProc','1f403d5f872368f3b19b9447a015d2e5'),(7,0,'doBusinessProc','3b9662b5a0f576c8586cc8aee28a3fca'),(8,0,'doBusinessProc','ae54a33163400018bb71ddffdbaf0922'),(9,0,'doBusinessProc','0e01e0ffc8db26706d2d02a2740c4c74'),(10,0,'doBusinessProc','fa04901da4a4095c0747c7aae0633bc7'),(11,0,'doBusinessProc','8f3dfc0d590f392f6da91a842f077db6'),(12,0,'doBusinessProc','e9220a26e4856930bb1b3a0c8f29a6e8'),(13,0,'doBusinessProc','ee6ce37e4fee047ea3002804e95c3ede'),(14,0,'doBusinessProc','c702809aab5f0161510871a32340f045'),(15,0,'doBusinessProc','002143fa09d64a3f62c67634eccf05ab'),(16,0,'doBusinessProc','0ce9bc5939f239f70cf129f6f8295dd0'),(17,0,'doBusinessProc','ae4bb079ce7406949b100804cc7fa6c4'),(18,0,'doBusinessProc','182ea198c58cc366c764e65e73f743e7'),(19,0,'doBusinessProc','7102b35d44d1220c846deb97a17171e5'),(20,0,'doBusinessProc','7d4a5deecf701b6c94e1aff89bdbe213'),(21,0,'doBusinessProc','b762fd51de3053eb71ed3642f7df63ab'),(22,0,'doBusinessProc','5d3cd487c366cc8c5f485b0e364b49dc'),(23,0,'doBusinessProc','8b44b0dd5b696d94cdcaa6dc76c671ff'),(24,0,'doBusinessProc','5645824a9916ec8702b6fff12194819f'),(25,0,'doBusinessProc','eec7fc964dd7465daa4b8ea03fd4571d'),(26,0,'doBusinessProc','ad9914eaebd0481721bf15951c69605f'),(27,0,'doBusinessProc','f83f0f90b97e96b5f1f7563fa87ca4f5'),(28,0,'doBusinessProc','ce6298e05f621fd6ea337fcf416eea6f'),(29,0,'doBusinessProc','ff8862137b6270d8e22d6e404f6be7f3'),(30,0,'doBusinessProc','d784170d4cafc2e69a7e65b38de2f41e'),(31,0,'doBusinessProc','af6c7339cf5f6efb83b773b7752b4351'),(32,0,'doBusinessProc','034734f85d736d9ad62c84c6cbc08ece'),(33,0,'doBusinessProc','e62b68d5a2f6c2815120b081fcf46002'),(34,0,'doBusinessProc','d248eb97adf23c27ab5f2f1a08622576');
/*!40000 ALTER TABLE `batch_job_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_job_seq`
--

DROP TABLE IF EXISTS `batch_job_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_job_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_job_seq`
--

LOCK TABLES `batch_job_seq` WRITE;
/*!40000 ALTER TABLE `batch_job_seq` DISABLE KEYS */;
INSERT INTO `batch_job_seq` VALUES (34,'0');
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
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_step_execution`
--

LOCK TABLES `batch_step_execution` WRITE;
/*!40000 ALTER TABLE `batch_step_execution` DISABLE KEYS */;
INSERT INTO `batch_step_execution` VALUES (1,2,'doStep',1,'2019-07-22 11:39:50','2019-07-22 11:39:50','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.reflect.InvocationTargetException\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at it.istat.is2.workflow.engine.EngineJava.doAction(EngineJava.java:112)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:65)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$3c80935b.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:','2019-07-22 11:39:50'),(2,2,'doStep',2,'2019-07-24 15:00:33','2019-07-24 15:03:09','FAILED',0,0,0,0,0,0,0,0,'FAILED','','2019-07-24 15:03:09'),(3,2,'doStep',3,'2019-07-24 15:24:04','2019-07-24 16:14:03','FAILED',0,0,0,0,0,0,0,0,'FAILED','','2019-07-24 16:14:03'),(4,3,'doStep',4,'2019-07-24 16:14:24','2019-07-24 16:15:49','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-24 16:15:49'),(5,3,'doStep',5,'2019-07-25 12:33:45','2019-07-25 12:33:46','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-25 12:33:46'),(6,2,'doStep',6,'2019-07-25 12:34:07','2019-07-25 12:34:07','FAILED',0,0,0,0,0,0,0,1,'FAILED','org.rosuda.REngine.Rserve.RserveException: eval failed, request status: R parser: syntax error\r\n	at org.rosuda.REngine.Rserve.RConnection.eval(RConnection.java:261)\r\n	at it.istat.is2.workflow.engine.EngineR.bindInputParams(EngineR.java:347)\r\n	at it.istat.is2.workflow.engine.EngineR.init(EngineR.java:142)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:64)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$a8d6d60c.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:69)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(','2019-07-25 12:34:07'),(7,2,'doStep',7,'2019-07-25 12:34:32','2019-07-25 12:34:33','FAILED',0,0,0,0,0,0,0,1,'FAILED','org.rosuda.REngine.Rserve.RserveException: eval failed, request status: R parser: syntax error\r\n	at org.rosuda.REngine.Rserve.RConnection.eval(RConnection.java:261)\r\n	at it.istat.is2.workflow.engine.EngineR.bindInputParams(EngineR.java:347)\r\n	at it.istat.is2.workflow.engine.EngineR.init(EngineR.java:142)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:64)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$a8d6d60c.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:69)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(','2019-07-25 12:34:33'),(8,2,'doStep',8,'2019-07-25 12:35:33','2019-07-25 12:35:34','FAILED',0,0,0,0,0,0,0,1,'FAILED','org.rosuda.REngine.Rserve.RserveException: eval failed, request status: R parser: syntax error\r\n	at org.rosuda.REngine.Rserve.RConnection.eval(RConnection.java:261)\r\n	at it.istat.is2.workflow.engine.EngineR.bindInputParams(EngineR.java:347)\r\n	at it.istat.is2.workflow.engine.EngineR.init(EngineR.java:142)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:64)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$a8d6d60c.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:69)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(','2019-07-25 12:35:34'),(9,2,'doStep',9,'2019-07-25 12:39:11','2019-07-25 12:40:00','FAILED',0,0,0,0,0,0,0,1,'FAILED','org.rosuda.REngine.Rserve.RserveException: eval failed, request status: R parser: syntax error\r\n	at org.rosuda.REngine.Rserve.RConnection.eval(RConnection.java:261)\r\n	at it.istat.is2.workflow.engine.EngineR.bindInputParams(EngineR.java:347)\r\n	at it.istat.is2.workflow.engine.EngineR.init(EngineR.java:142)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:64)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$b9ee3738.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:69)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(','2019-07-25 12:40:00'),(10,2,'doStep',10,'2019-07-25 12:40:08','2019-07-25 12:40:47','FAILED',0,0,0,0,0,0,0,1,'FAILED','org.rosuda.REngine.Rserve.RserveException: eval failed, request status: R parser: syntax error\r\n	at org.rosuda.REngine.Rserve.RConnection.eval(RConnection.java:261)\r\n	at it.istat.is2.workflow.engine.EngineR.bindInputParams(EngineR.java:347)\r\n	at it.istat.is2.workflow.engine.EngineR.init(EngineR.java:142)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:64)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$b9ee3738.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:69)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(','2019-07-25 12:40:47'),(11,2,'doStep',11,'2019-07-25 12:41:23','2019-07-25 12:42:11','FAILED',0,0,0,0,0,0,0,1,'FAILED','org.rosuda.REngine.Rserve.RserveException: eval failed, request status: R parser: syntax error\r\n	at org.rosuda.REngine.Rserve.RConnection.eval(RConnection.java:261)\r\n	at it.istat.is2.workflow.engine.EngineR.bindInputParams(EngineR.java:347)\r\n	at it.istat.is2.workflow.engine.EngineR.init(EngineR.java:142)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:64)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$b9ee3738.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:69)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(','2019-07-25 12:42:11'),(12,3,'doStep',12,'2019-07-25 12:42:59','2019-07-25 12:43:00','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-25 12:43:00'),(13,2,'doStep',13,'2019-07-25 12:43:29','2019-07-25 12:43:30','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.NullPointerException\r\n	at it.istat.is2.workflow.engine.EngineJava.doAction(EngineJava.java:112)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:65)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$b9ee3738.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:69)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:407)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:331)\r\n	at org.springframework.transaction.support.Transacti','2019-07-25 12:43:30'),(14,3,'doStep',14,'2019-07-25 12:48:45','2019-07-25 12:48:46','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-25 12:48:46'),(15,2,'doStep',15,'2019-07-25 16:01:34','2019-07-26 08:21:09','FAILED',0,0,0,0,0,0,0,0,'FAILED','','2019-07-26 08:21:09'),(16,2,'doStep',16,'2019-07-26 08:21:44','2019-07-26 09:56:32','FAILED',0,0,0,0,0,0,0,0,'FAILED','','2019-07-26 09:56:32'),(17,2,'doStep',17,'2019-07-26 10:03:23','2019-07-26 10:03:58','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.reflect.InvocationTargetException\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at it.istat.is2.workflow.engine.EngineJava.doAction(EngineJava.java:112)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:65)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$a08253b2.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:','2019-07-26 10:03:58'),(18,2,'doStep',18,'2019-07-26 10:04:19','2019-07-26 10:06:14','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.reflect.InvocationTargetException\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at it.istat.is2.workflow.engine.EngineJava.doAction(EngineJava.java:112)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:65)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$a08253b2.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:','2019-07-26 10:06:14'),(19,2,'doStep',19,'2019-07-26 10:04:23','2019-07-26 10:06:09','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.reflect.InvocationTargetException\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at it.istat.is2.workflow.engine.EngineJava.doAction(EngineJava.java:112)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:65)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$a08253b2.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:','2019-07-26 10:06:09'),(20,2,'doStep',20,'2019-07-26 10:06:23','2019-07-26 10:06:33','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.reflect.InvocationTargetException\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at it.istat.is2.workflow.engine.EngineJava.doAction(EngineJava.java:112)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:65)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$a08253b2.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:','2019-07-26 10:06:33'),(21,2,'doStep',21,'2019-07-26 10:06:52','2019-07-26 10:07:06','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.reflect.InvocationTargetException\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at it.istat.is2.workflow.engine.EngineJava.doAction(EngineJava.java:112)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:65)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$a08253b2.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:','2019-07-26 10:07:06'),(22,2,'doStep',22,'2019-07-26 10:07:47','2019-07-26 10:08:15','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.reflect.InvocationTargetException\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at it.istat.is2.workflow.engine.EngineJava.doAction(EngineJava.java:112)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:65)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$a08253b2.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:','2019-07-26 10:08:15'),(23,2,'doStep',23,'2019-07-26 10:11:33','2019-07-26 10:16:58','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.NullPointerException\r\n	at it.istat.is2.app.util.Utility.retrieveSxStepVariable(Utility.java:516)\r\n	at it.istat.is2.workflow.engine.EngineJava.saveOutputDB(EngineJava.java:228)\r\n	at it.istat.is2.workflow.engine.EngineJava.processOutput(EngineJava.java:199)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:66)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$e50647d1.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:69)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:407)\r\n	at org.springfra','2019-07-26 10:16:58'),(24,3,'doStep',24,'2019-07-26 10:26:40','2019-07-26 11:10:28','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-26 11:10:28'),(25,3,'doStep',25,'2019-07-26 11:10:11','2019-07-26 11:11:23','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-26 11:11:23'),(26,2,'doStep',26,'2019-07-26 11:11:53','2019-07-26 12:21:44','FAILED',0,0,0,0,0,0,0,0,'FAILED','','2019-07-26 12:21:44'),(27,2,'doStep',27,'2019-07-26 12:22:21','2019-07-26 12:30:38','FAILED',0,0,0,0,0,0,0,0,'FAILED','','2019-07-26 12:30:38'),(28,2,'doStep',28,'2019-07-26 12:30:58','2019-07-26 12:31:40','FAILED',0,0,0,0,0,0,0,0,'FAILED','','2019-07-26 12:31:40'),(29,2,'doStep',29,'2019-07-26 12:32:01','2019-07-26 12:33:05','FAILED',0,0,0,0,0,0,0,0,'FAILED','','2019-07-26 12:33:05'),(30,2,'doStep',30,'2019-07-26 12:51:30','2019-07-26 12:51:36','FAILED',0,0,0,0,0,0,0,1,'FAILED','java.lang.NullPointerException\r\n	at it.istat.is2.workflow.engine.EngineJava.saveOutputDB(EngineJava.java:247)\r\n	at it.istat.is2.workflow.engine.EngineJava.processOutput(EngineJava.java:200)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.doStep(WorkFlowBatchProcessor.java:66)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:55)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor.read(WorkFlowBatchProcessor.java:1)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$FastClassBySpringCGLIB$$1cbe5f00.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\r\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.doProceed(DelegatingIntroductionInterceptor.java:136)\r\n	at org.springframework.aop.support.DelegatingIntroductionInterceptor.invoke(DelegatingIntroductionInterceptor.java:124)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\r\n	at it.istat.is2.workflow.batch.WorkFlowBatchProcessor$$EnhancerBySpringCGLIB$$ec51fbb4.read(<generated>)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.doRead(SimpleChunkProvider.java:94)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.read(SimpleChunkProvider.java:161)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider$1.doInIteration(SimpleChunkProvider.java:119)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.getNextResult(RepeatTemplate.java:375)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.executeInternal(RepeatTemplate.java:215)\r\n	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)\r\n	at org.springframework.batch.core.step.item.SimpleChunkProvider.provide(SimpleChunkProvider.java:113)\r\n	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:69)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:407)\r\n	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTran','2019-07-26 12:51:36'),(31,3,'doStep',31,'2019-07-26 12:52:53','2019-07-26 12:53:00','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-26 12:53:00'),(32,3,'doStep',32,'2019-07-26 13:03:04','2019-07-26 13:03:07','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-26 13:03:07'),(33,3,'doStep',33,'2019-07-26 13:03:43','2019-07-26 13:04:07','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-26 13:04:07'),(34,3,'doStep',34,'2019-07-26 13:10:22','2019-07-26 13:10:23','COMPLETED',1,0,0,0,0,0,0,0,'COMPLETED','','2019-07-26 13:10:23');
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
INSERT INTO `batch_step_execution_context` VALUES (1,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(2,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(3,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(4,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(5,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(6,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(7,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(8,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(9,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(10,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(11,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(12,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(13,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(14,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(15,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(16,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(17,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(18,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(19,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(20,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(21,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(22,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(23,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(24,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(25,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(26,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(27,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(28,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(29,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(30,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(31,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(32,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(33,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL),(34,'{\"batch.taskletType\":\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\",\"batch.stepType\":\"org.springframework.batch.core.step.tasklet.TaskletStep\"}',NULL);
/*!40000 ALTER TABLE `batch_step_execution_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_step_execution_seq`
--

DROP TABLE IF EXISTS `batch_step_execution_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `batch_step_execution_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_step_execution_seq`
--

LOCK TABLES `batch_step_execution_seq` WRITE;
/*!40000 ALTER TABLE `batch_step_execution_seq` DISABLE KEYS */;
INSERT INTO `batch_step_execution_seq` VALUES (34,'0');
/*!40000 ALTER TABLE `batch_step_execution_seq` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `sx_app_instance` VALUES (11,70),(12,71),(13,72);
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
INSERT INTO `sx_bfunc_bprocess` VALUES (90,70),(90,72),(91,70),(91,71),(91,72);
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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_business_process`
--

LOCK TABLES `sx_business_process` WRITE;
/*!40000 ALTER TABLE `sx_business_process` DISABLE KEYS */;
INSERT INTO `sx_business_process` VALUES (70,'Cont Table','Calcolo tabella di contingenza','Cross Table',NULL),(71,'FellegiSunter','FellegiSunter','FellegiSunter',NULL),(72,'Matching Table','Result Matching table','MATCHING TABLE',NULL);
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

INSERT INTO `is2`.`sx_classification` (`ID`, `NOME`, `DESCRIZIONE`, `NOTE`) VALUES ('1', 'Dominio', 'Definisce i valori o le modalità ammissibili della variabile', 'Può comprendere missing e/o zero; distinguere tra variabile qualitativa e quantitativa');
INSERT INTO `is2`.`sx_classification` (`ID`, `NOME`, `DESCRIZIONE`, `NOTE`) VALUES ('2', 'Coerenza logica', 'Definisce le combinazioni ammissibili di valori e/o modalità tra due o più variabili ', 'Prevalentemente per  variabli qualitative, anche se la regola può riguardare entrambe le tipologie di variabili (es. ETA(0-15) STACIV(coniugato) con ETA fissa)');
INSERT INTO `is2`.`sx_classification` (`ID`, `NOME`, `DESCRIZIONE`, `NOTE`) VALUES ('3', 'Quadratura', 'Definisce l''uguaglianza ammissibile tra la somma di due o più variabili quantitative e il totale corrispondente (che può essere noto a priori o a sua volta ottenuto dalla somma di altre variabili del dataset)', 'Solo variabili quantitative');
INSERT INTO `is2`.`sx_classification` (`ID`, `NOME`, `DESCRIZIONE`, `NOTE`) VALUES ('4', 'Disuguaglianza forma semplice', 'Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due variabili quantitative', 'Solo variabili quantitative');
INSERT INTO `is2`.`sx_classification` (`ID`, `NOME`, `DESCRIZIONE`, `NOTE`) VALUES ('5', 'Disuguaglianza forma composta', 'Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due quantità, dove ciascuna quantità può essere costituita da una sola variabile X o dalla somma/differenza/prodotto tra due o più variabili X', 'Solo variabili quantitative');
INSERT INTO `is2`.`sx_classification` (`ID`, `NOME`, `DESCRIZIONE`, `NOTE`) VALUES ('6', 'Validazione/Completezza', 'Verifica in base alle regole di compilazione del questionario che i dati siano stati immessi correttamente', 'Distinguere tra variabile qualitativa e quantitativa');
--
-- Dumping data for table `sx_classification`
--

LOCK TABLES `sx_classification` WRITE;
/*!40000 ALTER TABLE `sx_classification` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_colonna`
--

LOCK TABLES `sx_dataset_colonna` WRITE;
/*!40000 ALTER TABLE `sx_dataset_colonna` DISABLE KEYS */;
INSERT INTO `sx_dataset_colonna` VALUES (8,'﻿OWNER_NAME',0,NULL,'[\"دائرة المخابرات الفلسطينية العامة\", \"شركة اي بارك لخدمات المواقف \", \"بلال احمد عبد الحليم دار موسى \", \"خالد ومامون محمد وليد نيروخ\", \"ابراهيم عارف محمد خضور\", \"شاهين رباح احمد رياحي \", \"ماهر سليمان علي قطوم\", \"فاتن محمد سلامه حجو \", \"احمد عبد الحكيم طاهر عجاج و نهاد حسن فهد نوح \", \"احمد عبد الحفيظ احمد صلاح الدين \", \"شركة جود لايف للحمية واللياقة \", \"مناضل خالد عطية خوالدة\", \"شادي صبحي حسين حايك\", \"فرح محمد علي شاهين \", \"خالد ومامون محمد وليد نيروخ\", \"فيصل يحيى عبد الغني ابو سمرة\", \"شركة الحمدان الذهبية للدهانات\", \"اياد حامد خضر قرش \", \"يوسف محمد حسن عادي \", \"ادم باسل محمد حوراني\", \"حسام الدين عبد الصمد محمد عاشور\", \"رامي اسحق محمد صالحية\", \"فهد سعد فهد الحلتة\", \"اشرف احمد عبد الرحيم بياتنة\", \"رامي اسحق محمد صالحية\", \"جهاد عبد الله حسين بدر \", \"عمر عبد الغني محمد ثابت \", \"مصعب زياد محمد طالب \", \"خالد وليد مصطفى نيروخ\", \"كريم جميل عواد حميده \", \"رامي سعد فهد الحلته \", \"علي محمود محمد مناصرة\", \"امجد مصباح محمود جبارين\", \"علي اياد محمد حسون ومحمود نبيل محمود جوابرة\", \"مراد نعيم احمد فروخ\", \"شركة الدلو للتجارة العامة\", \"شركة الرفاعي جروب للاستثمار العقاري المساهمة الخصوصية\", \"وليد محمد مصطفى مطير ومحمد وليد محمد مطير\", \"شعبان عابدين عبد الرحمن شعبان\", \"وزارة - - التخطيط\", \"مكتب رئاسة مجلس الوزراء\", \"شركة الرؤية الواضحة للانتاج والخدمات الاعلامية\", \"جاد عبد الله حسين سعد\", \"عبد الله حسين عبد الله عاصي\", \"رزق عامر محمد جرادات\", \"محمد وعدي واحمد ابو عواد\", \"اسامه عبد الرؤوف مصطفى بدر\", \"احمد محمد رمضان بياتنة و ناصر مصطفى عبدالحميد سرحان\", \"نيفين عدنان خليل درويش\"]',2,NULL,NULL,49),(9,'ID_NUMBER',1,NULL,'[\"0000\", \"562541664\", \"944405109\", \"037179926\", \"993365139\", \"852527092\", \"925515546\", \"410558308\", \"853999340\", \"900394677\", \"562574988\", \"905609475\", \"901108639\", \"944815547\", \"037179926\", \"859887978\", \"562557314\", \"066577495\", \"000\", \"854812518\", \"942165887\", \"036031508\", \"081035453\", \"20182831\", \"036031508\", \"907529408\", \"914135108\", \"20182840\", \"0000000000000000\", \"4537683\", \"850873407\", \"985246057\", \"920174141\", \"946592748\", \"946046208\", \"562114611\", \"562531061\", \"914113428\", \"949016760\", \"\", \"\", \"562527911\", \"996281598\", \"942306994\", \"935892414\", \"859266348\", \"953203007\", \"\", \"907415541\"]',2,NULL,NULL,49),(10,'COMMERCIAL_NAME',2,NULL,'[\"المخابرات العامة الفلسطينية\", \"اي بارك لخدمات المواقف \", \"الكرم\", \"Bella Ramallah\", \"------\", \"زينة ستايل \", \"IT Warits Hot Dog\", \"جنة الاطفال \", \" VEER ZARA 2\", \"زنار\", \"Good Life\", \"كراج مناضل خوالدة\", \"شاورما طارق الخليلي \", \"البان البركة \", \"Bella Rmallah\", \"لكزري سنتر \", \"شركة الحمدان الذهبية للدهانات \", \"LA SERA\", \"Snoopy\", \"كنزة \", \"البيك \", \"Black& Gold \", \"------\", \"ماركت رام الله مول \", \"Black & Gold\", \"البدر للتخليص الجمركي\", \"محلات عمر لقطع السيارات \", \"Match\", \"ازياء الوليد \", \"Euro Moda\", \"------\", \"\", \"\", \"E - CAFEE\", \"\", \"محلات الدلو للتجارة العامة\", \"\", \"المعيني هوم سنتر\", \"\", \"\", \"\", \"\", \"جاد عبدالله للتعهدات العامة\", \"تي تي سي\", \"\", \"\", \"فلاش للاثاث المستعمل\", \"مقهى الشام\", \"\"]',2,NULL,NULL,49),(11,'PHONE_1',3,NULL,'[\"654646\", \"0598959686\", \"0599987744\", \"0595339575\", \"00\", \"0568156524\", \"0598713940\", \"2984368\", \"0592299088\", \"0592780240\", \"0599134647\", \"2955284\", \"0597337784\", \"0599584655\", \"0595339575\", \"0598345752\", \"0599313219\", \"297506\", \"0594280210\", \"0598788997\", \"0597509240\", \"0595186444\", \"00\", \"0599777463\", \"0595186444\", \"0592360752\", \"0597168648\", \"0568991111\", \"0595045295\", \"0569398029\", \"00\", \"\", \"\", \"\", \"\", \"00\", \"2961070\", \"\", \"2961525\", \"\", \"\", \"\", \"2972542\", \"\", \"\", \"\", \"\", \"\", \"\"]',2,NULL,NULL,49),(12,'PHONE_2',4,NULL,'[\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"0592360702\", \"\", \"\", \"0599997037\", \"0598858895\", \"0599133744\", \"0599522282\", \"\", \"\", \"0599088077\", \"\", \"0598917560\", \"\", \"0595061180\", \"0599732302\", \"0599000660\", \"\"]',2,NULL,NULL,49),(13,'ADDRESS',5,NULL,'[\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"شارع النهضة - مقابل المدرسة الهاشمية\", \"شارع النهضة - مقابل سنما الجميل\", \"شارع الكلية الاهلية\", \"شارع ميس الريم\", \"شارع المحاكم\", \"شارع الاذاعة\", \"شارع الاذاعة\", \"شارع الاذاعة\", \"الماصيون\", \"\", \"دوار المجلس التشريعي\", \"الشارع الرئيسي\", \"شارع المعاهد\", \"ميدان ياسر عرفات - مقابل الصالون الاخضر\", \"شارع المعاهد - مقابل مجمع درس\", \"شارع عين مصباح\", \"الماصيون\", \"شارع المصايف\"]',2,NULL,NULL,49),(14,'BUILDING_NAME',6,NULL,'[\"\", \"\", \"\", \"رام الله مول\", \"\", \"رام الله مول\", \"\", \"خلدون حجو \", \"رام الله مول\", \"رام الله مول\", \"\", \"\", \"\", \"\", \"رام الله مول\", \"السيزر \", \"\", \"رام الله مول\", \"رام الله مول\", \"رام الله مول\", \"زيدية \", \"رام الله مول\", \"\", \"رام الله مول \", \"رام الله مول\", \"البكري\", \"عبد الغني ثابت \", \"رام الله مول\", \"رام الله مول\", \"رام الله مول\", \"\", \"\", \"\", \"البجة\", \"\", \"مصطفى جاسر\", \"الهندي\", \"ربحي الحجة\", \"الاسراء\", \"\", \"\", \"صابات\", \"النجمة مول\", \"الرموني 1\", \"\", \"\", \"الغزاوي\", \"\", \"مجمع الصفا التجاري\"]',2,NULL,NULL,49),(15,'﻿COMMERCIAL_ID',0,NULL,'[\"562309815\", \"562309773\", \"562198341\", \"562309542\", \"562309674\", \"562199216\", \"562303065\", \"562303156\", \"562309146\", \"562302646\", \"562302877\", \"562308791\", \"562308825\", \"562303073\", \"562309260\", \"562308833\", \"562198663\", \"562198853\", \"562308494\", \"562308528\", \"562307900\", \"562308080\", \"562199984\", \"562302257\", \"562303511\", \"562198788\", \"562199307\", \"562199315\", \"562302349\", \"562302976\", \"562308197\", \"562302562\", \"562302612\", \"562307249\", \"562198556\", \"562198549\", \"562198564\", \"562199935\", \"562307736\", \"562199844\", \"562307504\", \"562302745\", \"562302893\", \"562305615\", \"562305763\", \"562199513\", \"562303164\", \"562305722\", \"562198838\"]',3,NULL,NULL,49),(16,'COMMERCIAL_NAME',1,NULL,'[\"شركة أفنيو ديكور للتجارة والمقاولات\", \"شركة كدابرا ستوديوز  للانتاج الاعلامي والبرمجة\", \"شركة العجمي يافا للنقل الخاص\", \"شركة قمة العناية للمستلزمات الطبية\", \"24 ساعة للتنظيف والخدمات\", \"شركة مشغل الاصدقاء للستانلس ومعدات المطابخ والمطاعم\", \"شركة ثائر مودرن تكنولوجي للاثاث والالكترونيات\", \"شركة اجاده للاستشارات وتكنولوجيا المعلومات\", \"شركة منتجع وحمام شام التركي\", \"شركة الحوت موتورز لزيوت وفلاتر السيارات\", \"شركة زيزو لتصفيف الشعر ومستحضرات التجميل\", \"شركة باب سراي للمطاعم والحلويات\", \"شركة ميريس لاداره المشاريع التجارية\", \"شركة طريق المحمول التكنولوجية\", \"شركة اسامة جبر كحيل وجولدن ستيبس للمقاولات\", \"شركة اوت ستاندنج منجمنت سوليوشين للاستشارات الادارية\", \"شركة حمايل للتوريدات الطبية\", \"شركة ديفيجن للهندسة والاستثمار\", \"شركة النخله والصافي لتجارة الملابس والاحذيه\", \"شركة عمار مول وشركاه للسلع الاستهلاكية\", \"شركة كريستال لتجارة وتوزيع الاراجيل ومستلزماتها\", \"شركة صناع المناسبات لاقامة وتنظيم المعارض والمؤتمرات\", \"شركة اتش ام اس موتورز لتجارة السيارات\", \"شركة  ابو الزق للحفريات والمقاولات\", \"شركة إيليت تامر مناصره وشركاه للسجاد والديكور\", \"شركة الطيبات لكماليات السيارات\", \"شركة وايت سنو للخدمات التجارية\", \"شركة عبير الهوا لتجارة المفرزات والمواد التموينيه\", \"شركة جو كويك ديلفري للخدمات اللوجستيه\", \"شركة كركر موتورز لتجارة السيارات\", \"شركة غسان زيدان واولاده للشحن والتخليص\", \"شركة طباق للنشر والتوزيع\", \"شركة دبوس للمقاولات\", \"شركة باترول موتورز لتجارة السيارات\", \"شركة المركز الفلسطيني الاردني لطب وجراحة العيون\", \"شركة شلطف والصالحي للمواد الغذائيه والاستهلاكيه\", \"شركة كاستم كلاسيك لصيانة ودهان السيارات\", \"شركة حمد الله حمدان وشركاه للخضار والفواكه\", \"شركة شروق و حمايل كلينك للتغذية الصحية\", \"شركة ديجت بروز للدعاية الرقمية\", \"شركة الاخوه الرفاتي لمواد البناء\", \"شركة سعيد قنديل واخوانه للمقاولات\", \"شركة همسات لبيع الاجهزه الخلويه وملحقاتها\", \"شركة عبد الله أبو عين وشريكه للاستيراد وتجارة السيارات\", \"شركة أوربت لأعمال النظافة\", \"شركة كندة لتجارة السلع الاستهلاكيه\", \"شركة الوفيرا لمستحضرات التجميل\", \"شركة مطعم الزيتونة\", \"شركة مطاعم أتويتس\"]',3,NULL,NULL,49),(17,'GOVERNORATE',2,NULL,'[\"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\", \"رام الله والبيرة\"]',3,NULL,NULL,49),(18,'CITY',3,NULL,'[\"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\"]',3,NULL,NULL,49),(19,'ADDRESS',4,NULL,'[\"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله - حي قدورة\", \"رام الله\", \"رام الله / الارسال\", \"رام الله\", \"رام الله شارع القدس رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\", \"عمارة سردا - الطابق الارضي\", \"رام الله/ المصيون/رافات/مقابل محطة الهدى للمحروقات\", \"البيرة\", \"رام الله\", \"رام الله\", \"رام الله\", \"رام الله\"]',3,NULL,NULL,49),(20,'TELEPHONE',5,NULL,'[\"\", \"022403046\", \"0592992299\", \"\", \"\", \"0598397271\", \"0599800266\", \"0598956134\", \"\", \"\", \"0598668012\", \"\", \"\", \"\", \"\", \"\", \"\", \"022950716\", \"0599139148\", \"\", \"\", \"0568560462\", \"\", \"\", \"\", \"0595091179\", \"\", \"0599367893\", \"\", \"2981285\", \"0599509435\", \"\", \"\", \"\", \"0597101029\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"0599595626\", \"\", \"\", \"\", \"0592345456\", \"\", \"059900844\"]',3,NULL,NULL,49),(21,'MOBILE',6,NULL,'[\"\", \"\", \"\", \"\", \"0569644551\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"0599211767\", \"\", \"0598662468\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"0568801149\", \"\", \"\", \"\", \"059972077\", \"\", \"\", \"\", \"\"]',3,NULL,NULL,49);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_dataset_file`
--

LOCK TABLES `sx_dataset_file` WRITE;
/*!40000 ALTER TABLE `sx_dataset_file` DISABLE KEYS */;
INSERT INTO `sx_dataset_file` VALUES (2,NULL,'Munic_Ramallahcsv.txt',NULL,';',49,'2019-07-22 16:48:47',NULL,14,'CSV',1,'DSa'),(3,NULL,'MoNEcsv.csv.txt',NULL,';',49,'2019-07-22 16:50:24',NULL,14,'CSV',1,'DSb');
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
  `BFUNCTION` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SX_ELABORAZIONE_PK` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_elaborazione`
--

LOCK TABLES `sx_elaborazione` WRITE;
/*!40000 ALTER TABLE `sx_elaborazione` DISABLE KEYS */;
INSERT INTO `sx_elaborazione` VALUES (25,'2019-06-20 08:37:17','Relais',NULL,'',13,91);
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
  `json_template` mediumtext,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014050` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_par_pattern`
--

LOCK TABLES `sx_par_pattern` WRITE;
/*!40000 ALTER TABLE `sx_par_pattern` DISABLE KEYS */;
INSERT INTO `sx_par_pattern` VALUES (1,'MATCHING VARAIBLES',11,'MATCHING VARAIBLES','3',166,NULL),(2,'THRESHOLD MATCHING',13,'THRESHOLD MATCHING','1',169,NULL),(3,'THRESHOLD UNMATCHING',13,'THRESHOLD UNMATCHING','1',170,NULL);
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
  `CLASS` varchar(50) DEFAULT NULL,
  `VARIABILE` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014188` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=840 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_rule`
--

LOCK TABLES `sx_rule` WRITE;
/*!40000 ALTER TABLE `sx_rule` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_ruleset`
--

LOCK TABLES `sx_ruleset` WRITE;
/*!40000 ALTER TABLE `sx_ruleset` DISABLE KEYS */;
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
INSERT INTO `sx_ruoli` VALUES (0,'SKIP','N','VARIABILE NON UTILIZZATA',100,1,1),(1,'IDENTIFICATIVO','I','CHIAVE OSSERVAZIONE',100,1,1),(2,'TARGET','Y','VARIABILE DI OGGETTO DI ANALISI',100,3,1),(3,'COVARIATA','X','VARIABILE INDIPENDENTE',100,4,1),(4,'PREDIZIONE','P','VARIABILE DI PREDIZIONE',100,5,1),(5,'OUTLIER','O','FLAG OUTLIER',100,6,1),(6,'PESO','W','PESO CAMPIONARIO',100,7,1),(7,'ERRORE','E','ERRORE INFLUENTE',100,10,1),(8,'RANKING','R','INFLUENCE RANKING',100,11,1),(9,'OUTPUT','T','VARIABILE DI OUTPUT',100,20,1),(10,'STRATO','S','PARTIZIONAMENTO DEL DATASET',100,2,1),(11,'PARAMETRI','Z','PARAMETRI DI INPUT',100,997,2),(12,'MODELLO','M','MODELLO DATI',100,998,2),(13,'SCORE','F','INFLUENCE SCORE',100,12,1),(14,'INFO','G','PARAMETRI OUT - INFO RIEPILOGO',100,999,1),(100,'SKIP','N','VARIABILE NON UTILIZZATA',200,100,1),(102,'CHIAVE A','K1','CHIAVE DATASET A',200,3,1),(103,'CHIAVE B','K2','CHIAVE DATASET B',200,4,1),(104,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',200,5,1),(105,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',200,6,1),(108,'RANKING','M','INFLUENCE RANKING',200,11,2),(110,'STRATO','S','PARTIZIONAMENTO DEL DATASET',200,2,1),(111,'RESULT','R','RISULTATO PRODOTTO CARTESIANO',200,10,2),(115,'BLOCKING','B','SLICING DEL DATASET',200,3,1),(150,'SKIP','N','VARIABILE NON UTILIZZATA',250,100,1),(152,'KEY A','K1','CHIAVE DATASET A',250,3,1),(153,'KEY B','K2','CHIAVE DATASET B',250,4,1),(154,'MATCHING A','X1','VARIABILE DI OGGETTO DI ANALISI A',250,5,1),(155,'MATCHING B','X2','VARIABILE DI OGGETTO DI ANALISI B',250,6,1),(158,'RANKING','M','INFLUENCE RANKING',250,11,2),(160,'STRATA','S','PARTIZIONAMENTO DEL DATASET',250,2,1),(161,'CONTENGENCY TABLE','CT','CONTENGENCY TABLE',250,1,2),(165,'BLOCKING','B','SLICING DEL DATASET',250,3,1),(166,'MATCHING ','X','VARIABLI DI MATCHING',250,1,2),(167,'FELLEGI-SUNTER','FS','FELLEGI-SUNTER',200,2,1),(168,'MATCHING TABLE','MT','MATCHING TABLE',250,3,1),(169,'THRESHOLD','TH','THRESHOLD MATCHING',250,2,2),(170,'THRESHOLD','TU','THRESHOLD UNMATCHING',250,4,2),(171,'POSSIBLE MATCHING TABLE','PM','POSSIBLE MATCHING TABLE',250,5,1),(172,'RESIDUAL A','RA','RESIDUAL DATASET  A',250,6,1),(173,'RESIDUAL B','RB','RESIDUAL DATASET  B',250,7,1);
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
  `DATA_CREAZIONE` datetime DEFAULT NULL,
  `NOME` varchar(255) DEFAULT NULL,
  `DESCRIZIONE` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SX_SESSIONE_LAVORO_PK` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_sessione_lavoro`
--

LOCK TABLES `sx_sessione_lavoro` WRITE;
/*!40000 ALTER TABLE `sx_sessione_lavoro` DISABLE KEYS */;
INSERT INTO `sx_sessione_lavoro` VALUES (13,83,'2019-06-20 08:23:25','pippo',''),(14,83,'2019-07-22 12:53:12','pcsb','');
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
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_pattern`
--

LOCK TABLES `sx_step_pattern` WRITE;
/*!40000 ALTER TABLE `sx_step_pattern` DISABLE KEYS */;
INSERT INTO `sx_step_pattern` VALUES (154,11,154,1),(155,11,155,1),(158,11,158,2),(161,11,161,2),(165,11,165,1),(166,11,166,1),(167,12,161,1),(168,12,167,2),(169,13,154,1),(170,13,155,1),(171,13,167,1),(172,13,161,1),(173,13,168,2),(176,13,169,1),(177,13,170,1);
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
  `ROLE_GROUP` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014744` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_step_variable`
--

LOCK TABLES `sx_step_variable` WRITE;
/*!40000 ALTER TABLE `sx_step_variable` DISABLE KEYS */;
INSERT INTO `sx_step_variable` VALUES (1,1,166,25,NULL,1,NULL,1,NULL,NULL),(2,2,169,25,NULL,2,NULL,1,NULL,NULL),(31,31,170,25,NULL,4,NULL,1,NULL,NULL);
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
  `param_value` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SYS_C0014021` (`ID`),
  KEY `TIPOVAR` (`TIPO_VAR`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sx_workset`
--

LOCK TABLES `sx_workset` WRITE;
/*!40000 ALTER TABLE `sx_workset` DISABLE KEYS */;
INSERT INTO `sx_workset` VALUES (1,'MATCHING VARAIBLES',NULL,'[\"1\"]',2,1,NULL,'{\"MetricMatchingVariables\":[{\"MatchingVariable\":\"SURNAME\",\"MatchingVariableA\":\"DSa_SURNAME\",\"MatchingVariableB\":\"DSb_SURNAME\",\"Method\": \"Jaro\",\"Thresould\": 0.8,\"Window\":0 },{\"MatchingVariable\":\"NAME\",\"MatchingVariableA\":\"DSa_NAME\",\"MatchingVariableB\":\"DSb_NAME\",\"Method\": \"Jaro\",\"Thresould\": 0.8,\"Window\":0 },{\"MatchingVariable\":\"LASTCODE\",\"MatchingVariableA\":\"DSa_LASTCODE\",\"MatchingVariableB\":\"DSb_LASTCODE\",\"Method\": \"Jaro\",\"Thresould\": 0.8,\"Window\":0 }]}'),(2,'THRESHOLD MATCHING',NULL,'[\"1\"]',2,1,NULL,'0.8'),(31,'THRESHOLD UNMATCHING',NULL,'[\"1\"]',2,1,NULL,'0.6');
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

-- Dump completed on 2019-07-26 18:20:28
