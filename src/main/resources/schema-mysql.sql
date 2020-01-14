-- -----------------------------------------------------
-- Schema is2
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `is2`;
CREATE SCHEMA `is2` DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
USE `is2`;

-- -----------------------------------------------------
-- USER ROLE
-- -----------------------------------------------------
CREATE TABLE `is2_user_roles` (
  `ID` 	 	INT NOT NULL AUTO_INCREMENT,
  `ROLE` 	VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- USER
-- -----------------------------------------------------
CREATE TABLE `is2_users` (
  `ID` 			INT NOT NULL AUTO_INCREMENT,
  `EMAIL` 		VARCHAR(255) NULL,
  `NAME` 		VARCHAR(100) NULL,
  `SURNAME` 	VARCHAR(100) NULL,
  `PASSWORD` 	VARCHAR(500) NULL,
  `ROLE_ID` 	INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_is2_users_is2_user_roles` FOREIGN KEY (`ROLE_ID`)
        REFERENCES `is2_user_roles` (`ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- 
-- CLASSIFICATION TABLES - BEGIN
--
-- -----------------------------------------------------

-- -----------------------------------------------------
-- DATA TYPE CLASSIFICATION
-- -----------------------------------------------------
CREATE TABLE `is2_cls_data_type` (
  `ID` 	  INT NOT NULL AUTO_INCREMENT,
  `NAME`  VARCHAR(100) NULL,
  `DESCR` TEXT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- INPUT/OUTPUT CLASSIFICATION
-- -----------------------------------------------------
CREATE TABLE `is2_cls_type_io` (
  `ID` 	 INT NOT NULL AUTO_INCREMENT,
  `NAME` VARCHAR(100) NULL,
  PRIMARY KEY (`ID`)
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- RULE TYPE CLASSIFICATION
-- -----------------------------------------------------
CREATE TABLE `is2_cls_rule` (
  `ID`    INT NOT NULL AUTO_INCREMENT,
  `NAME`  VARCHAR(100) NULL,
  `DESCR` TEXT NULL,
  `NOTE`  TEXT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- VARIABLE CLASSIFICATION (FROM ISTAT CORPORATE METADATA SYSTEM)
-- -----------------------------------------------------
CREATE TABLE `is2_cls_statistical_variable` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `NAME` VARCHAR(100) NULL,
    `DESCR` TEXT NULL,
    `TYPE` INT NULL,
    `ORDER` INT NULL,
    `VARIABLE_NAME_ITA` VARCHAR(500) NULL,
    `VARIABLE_NAME_ENG` VARCHAR(500) NULL,
    PRIMARY KEY (`ID`)
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- VIEW_DATA_TYPE
-- -----------------------------------------------------
CREATE TABLE `is2_view_data_type` (
  `ID`	  INT NOT NULL AUTO_INCREMENT,
  `NAME`  VARCHAR(50) NULL,
  `DESCR` TEXT NULL,
  PRIMARY KEY (`ID`)
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- 
-- CLASSIFICATION TABLES - END
--
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- PROCESS DESIGN SECTION - BEGIN
--
-- The following tables allow to define a statistical process at business level (WHAT).
-- We want to answer to the following question: WHAT are the business processes and process steps needed to implement a business function?
-- We used the GSIM information model to define all the concepts needed to design a statistical process.
-- More precisely the connection between the main concepts is:
-- BUSINESS_FUNCTION -> BUSINESS_PROCESS -> PROCESS_STEP
-- A process step will use a service available in the BUSINESS_SERVICE catalogue
--
-- -----------------------------------------------------

-- -----------------------------------------------------
-- BUSINESS_FUNCTION
-- -----------------------------------------------------
CREATE TABLE `is2_business_function` (
  `ID`	   INT NOT NULL AUTO_INCREMENT,
  `NAME`   VARCHAR(100) NULL,
  `DESCR`  TEXT NULL,
  `LABEL`  VARCHAR(50) NULL,
  `ACTIVE` INT,
  PRIMARY KEY (`ID`)
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- BUSINESS_PROCESS
-- -----------------------------------------------------
CREATE TABLE `is2_business_process` (
  `ID` 	   INT NOT NULL AUTO_INCREMENT,
  `NAME`   VARCHAR(100) NULL,
  `DESCR`  TEXT NULL,
  `LABEL`  VARCHAR(50) NULL,
  `ORDER`  INT NULL,
  `PARENT` INT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_is2_business_process_is2_business_process` FOREIGN KEY (`PARENT`)
	REFERENCES `is2`.`is2_business_process` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- CATALOGUE OF BUSINESS SERVICES
-- -----------------------------------------------------
CREATE TABLE `is2_business_service` (
  `ID` 	  INT NOT NULL AUTO_INCREMENT,
  `NAME`  VARCHAR(100) NULL,
  `DESCR` TEXT NULL,
  PRIMARY KEY (`ID`)
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- PROCESS_STEP
-- -----------------------------------------------------
CREATE TABLE `is2_process_step` (
  `ID` 	  				INT NOT NULL AUTO_INCREMENT,
  `NAME`  				VARCHAR(100) NULL,
  `DESCR` 				TEXT NULL,
  `BUSINESS_SERVICE_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_is2_process_step_business_service` FOREIGN KEY (`BUSINESS_SERVICE_ID`)
	REFERENCES `is2`.`is2_business_service` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- WORK SESSION
-- -----------------------------------------------------
CREATE TABLE `is2_work_session` (
  `ID` 						INT NOT NULL AUTO_INCREMENT,
  `NAME` 					VARCHAR(100) NULL,
  `DESCR` 					TEXT NULL,
  `LAST_UPDATE` 			DATETIME NULL,
  `USER_ID` 				INT NOT NULL,
  `BUSINESS_FUNCTION_ID` 	INT NOT NULL,
   PRIMARY KEY (`ID`),
   CONSTRAINT `fk_is2_worksession_user` FOREIGN KEY (`USER_ID`)
	REFERENCES `is2_users` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_is2_worksession_business_function` FOREIGN KEY (`BUSINESS_FUNCTION_ID`)
	REFERENCES `is2_business_function` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - LINK TABLES
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_FUNCTION - BUSINESS_PROCESS
-- -----------------------------------------------------
CREATE TABLE `is2_link_function_process` (
  `BUSINESS_FUNCTION_ID` INT NOT NULL,
  `BUSINESS_PROCESS_ID`  INT NOT NULL,
  PRIMARY KEY (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`),
  CONSTRAINT `fk_is2_bfunc_bprocess_is2_business_function` FOREIGN KEY (`BUSINESS_FUNCTION_ID`)
	REFERENCES `is2`.`is2_business_function` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_is2_bfunc_bprocess_is2_business_process` FOREIGN KEY (`BUSINESS_PROCESS_ID`)
	REFERENCES `is2`.`is2_business_process` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_PROCESS - PROCESS_STEP
-- -----------------------------------------------------
CREATE TABLE `is2_link_process_step` (
  `BUSINESS_PROCESS_ID` INT NOT NULL,
  `PROCESS_STEP_ID` 	INT NOT NULL,
  PRIMARY KEY (`BUSINESS_PROCESS_ID`, `PROCESS_STEP_ID`),
  CONSTRAINT `fk_is2_bprocess_bstep_is2_business_process` FOREIGN KEY (`BUSINESS_PROCESS_ID`)
	REFERENCES `is2_business_process` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_is2_bprocess_bstep_is2_process_step` FOREIGN KEY (`PROCESS_STEP_ID`)
	REFERENCES `is2_process_step` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_FUNCTION - VIEW_DATA_TYPE
-- -----------------------------------------------------
CREATE TABLE `is2_link_function_view_data_type` (
  `BUSINESS_FUNCTION_ID` INT NOT NULL,
  `VIEW_DATA_TYPE_ID`    INT NOT NULL,
  PRIMARY KEY (`BUSINESS_FUNCTION_ID`, `VIEW_DATA_TYPE_ID`),
  CONSTRAINT `fk_is2_view_data_type_is2_business_function` FOREIGN KEY (`BUSINESS_FUNCTION_ID`)
	REFERENCES `is2_business_function` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_is2_view_data_type_is2_view_data_type` FOREIGN KEY (`VIEW_DATA_TYPE_ID`)
	REFERENCES `is2_view_data_type` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION DATA REPOSITORY - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- WORKSET
--
-- Description: 
-- 
-- -----------------------------------------------------
CREATE TABLE `is2_workset` (
  `ID` 				     INT NOT NULL AUTO_INCREMENT,
  `NAME` 			     VARCHAR(100) NULL,
  `DATASET_COLUMN`	    INT NULL,
  `ORDER_CODE` 			 INT NULL,
  `CONTENT` 			 JSON NULL,
  `CONTENT_SIZE` 		 INT NULL,
  `VALUE_PARAMETER`      LONGTEXT NULL,
  `CLS_DATA_TYPE_ID`     INT NOT NULL,
   PRIMARY KEY (`ID`),
   CONSTRAINT `fk_is2_workset_data_type` FOREIGN KEY (`CLS_DATA_TYPE_ID`)
	REFERENCES `is2_cls_data_type` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- DATASET FILE
--
-- Description: a reference the file containing data (the data itself is stored in dataset_column)
-- 
-- -----------------------------------------------------
CREATE TABLE `is2_dataset_file` (
  `ID` 				 INT NOT NULL AUTO_INCREMENT,
  `FILE_NAME` 		 VARCHAR(100) NULL,
  `FILE_LABEL` 		 VARCHAR(50) NULL,
  `FILE_FORMAT` 	 VARCHAR(50) NULL,
  `FIELD_SEPARATOR`  VARCHAR(50) NULL,
  `TOTAL_ROWS` 		 INT NULL,
  `LAST_UPDATE` 	 DATETIME NULL,
  `CLS_DATA_TYPE_ID` INT NULL,
  `WORK_SESSION_ID`  INT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_is2_datakset_file_data_type` FOREIGN KEY (`CLS_DATA_TYPE_ID`)
	REFERENCES `is2_cls_data_type` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_is2_datakset_file_worksession` FOREIGN KEY (`WORK_SESSION_ID`)
	REFERENCES `is2_work_session` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- DATASET COLUMN
--
-- Description:
-- 

-- -----------------------------------------------------
CREATE TABLE `is2_dataset_column` (
  `ID` 							 INT NOT NULL AUTO_INCREMENT,
  `NAME` 						 VARCHAR(100) NULL,
  `ORDER_CODE` 						 INT NULL,
  `CONTENT` 						 JSON NULL,
  `CONTENT_SIZE` 					 INT NULL,
  `DATASET_FILE_ID` 			 INT NULL,
  `STATISTICAL_VARIABLE_ID` INT NULL,
   PRIMARY KEY (`ID`),
   CONSTRAINT `fk_is2_dataset_column_dataset_id` FOREIGN KEY (`DATASET_FILE_ID`)
	REFERENCES `is2_dataset_file` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_is2_dataset_column_statistical_variable` FOREIGN KEY (`STATISTICAL_VARIABLE_ID`)
	REFERENCES `is2_cls_statistical_variable` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- 
-- SECTION DATA REPOSITORY - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION RULES - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- RULESET
-- -----------------------------------------------------
CREATE TABLE `is2_ruleset` (
  `ID` 			    INT NOT NULL AUTO_INCREMENT,
  `FILE_NAME` 	    VARCHAR(100) NULL,
  `FILE_LABEL` 	    VARCHAR(50) NULL,
  `DESCR` 		    TEXT NULL,
  `RULES_TOTAL`     INT NULL,
  `LAST_UPDATE`     DATETIME NULL,
  `WORK_SESSION_ID` INT NOT NULL,
  `DATASET_ID` 	    INT NULL,
   PRIMARY KEY (`ID`),
   CONSTRAINT `fk_ruleset_work_session` FOREIGN KEY (`WORK_SESSION_ID`)
		REFERENCES `is2_work_session` (`ID`)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_ruleset_dataset` FOREIGN KEY (`DATASET_ID`)
		REFERENCES `is2_dataset_file` (`ID`)
		ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- RULE
-- -----------------------------------------------------
CREATE TABLE `is2_rule` (
  `ID` 			 INT NOT NULL AUTO_INCREMENT,
  `NAME` 		 VARCHAR(100) DEFAULT NULL,
  `CODE` 		 VARCHAR(50) DEFAULT NULL,
  `DESCR` 		 TEXT NULL,
  `BLOCKING` 	 INT NULL,
  `ERROR_CODE` 	 INT NULL,
  `ACTIVE` 		 INT NULL,
  `RULE` 		 TEXT NULL,
  `VARIABLE_ID`  INT NULL,
  `CLS_RULE_ID`  INT NOT NULL,
  `RULESET_ID`   INT NOT NULL,
   PRIMARY KEY (`ID`),
   CONSTRAINT `fk_rule_cls_rule` FOREIGN KEY (`CLS_RULE_ID`)
		REFERENCES `is2_cls_rule` (`ID`)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_rule_ruleset` FOREIGN KEY (`RULESET_ID`)
	  REFERENCES `is2_ruleset` (`ID`)
	  ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- 
-- SECTION DATA RULES - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- CATALOGUE OF APPLICATION SERVICES
-- -----------------------------------------------------
CREATE TABLE `is2_app_service` (
  `ID` 						INT NOT NULL AUTO_INCREMENT,
  `NAME` 					VARCHAR(100) NULL,
  `DESCR` 					TEXT NULL,
  `IMPLEMENTATION_LANGUAGE` VARCHAR(100) NULL ,
  `SOURCE` 					VARCHAR(100) NULL,
  `BUSINESS_SERVICE_ID` 	INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_is2_app_service_is2_business_service` FOREIGN KEY (`BUSINESS_SERVICE_ID`)
	REFERENCES `is2_business_service` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- STEP INSTANCE
-- 
-- Description: each service in the application service catalogue provides a set of functionalities
-- each function is described in the following table
-- -----------------------------------------------------
CREATE TABLE `is2_step_instance` (
  `ID`	 			INT NOT NULL AUTO_INCREMENT,
  `METHOD` 			VARCHAR(100) NULL,
  `DESCR` 			TEXT NULL,
  `LABEL` 			VARCHAR(50) NULL,
  `APP_SERVICE_ID` 	INT NOT NULL,
   PRIMARY KEY (`ID`),
   CONSTRAINT `fk_is2_step_instance_is2_app_service` FOREIGN KEY (`APP_SERVICE_ID`)
	REFERENCES `is2_app_service` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- PARAMETER
-- -----------------------------------------------------
CREATE TABLE `is2_parameter` (
  `ID` 			  INT NOT NULL AUTO_INCREMENT,
  `NAME` 		  VARCHAR(100) NULL,
  `DESCR` 		  TEXT NULL,
  `DEFAULT_VAL`   VARCHAR(50) NULL,
  `JSON_TEMPLATE` LONGTEXT NULL,PRIMARY KEY (`ID`)
)  ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- ROLE
--
-- Description: this is a central concept in our model. 
-- -----------------------------------------------------
CREATE TABLE `is2_app_role` (
  `ID` 					INT NOT NULL AUTO_INCREMENT,
  `CODE` 				VARCHAR(50) NULL,
  `NAME` 				VARCHAR(100) NULL,
  `DESCR` 				TEXT NULL,
  `ORDER` 				INT NULL,
  `CLS_DATA_TYPE_ID` 	INT NULL,
  `PARAMETER_ID` 		INT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_is2_app_role_is2_data_type` FOREIGN KEY (`CLS_DATA_TYPE_ID`)
	REFERENCES `is2_cls_data_type` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_is2_app_role_is2_paramter` FOREIGN KEY (`PARAMETER_ID`)
	REFERENCES `is2_parameter` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- STEP INSTANCE SIGNATURE
--
-- Description: this table describes the signature of each function contained in the application service catalogue.
-- In our model a signature is a set of application roles. Each role has a defined type (INPUT/OUTPUT). 
-- -----------------------------------------------------
CREATE TABLE `is2_step_instance_signature` (
  `ID` 				 INT NOT NULL AUTO_INCREMENT,	
  `REQUIRED` 		 TINYINT NULL,
  `APP_ROLE_ID` 	 INT NOT NULL,
  `STEP_INSTANCE_ID` INT NOT NULL,
  `CLS_TYPE_IO_ID` 	 INT NOT NULL,
   PRIMARY KEY (`ID`),
   CONSTRAINT `fk_is2_step_instance_signature_is2_app_role` FOREIGN KEY (`APP_ROLE_ID`)
	REFERENCES `is2_app_role` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_is2_step_instance_signature_is2_step_instance` FOREIGN KEY (`STEP_INSTANCE_ID`)
	REFERENCES `is2_step_instance` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_is2_step_instance_signature_is2_type_io` FOREIGN KEY (`CLS_TYPE_IO_ID`)
	REFERENCES `is2_cls_type_io` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- DATA PROCESSING
--
-- Description: 
-- 
-- ----------------------------------------------------
CREATE TABLE `is2_data_processing` (
  `ID` 					INT NOT NULL AUTO_INCREMENT,
  `NAME` 				VARCHAR(100) NULL,
  `DESCR` 				TEXT NULL,
  `LAST_UPDATE` 		DATETIME NULL, 
  `BUSINESS_PROCESS_ID` INT NOT NULL,
  `WORK_SESSION_ID` 	INT NOT NULL,
  PRIMARY KEY (`ID`),
   CONSTRAINT `fk_is2_data_processing_business_process` FOREIGN KEY (`BUSINESS_PROCESS_ID`)
	REFERENCES `is2_business_process` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_is2_data_processing_worksession` FOREIGN KEY (`WORK_SESSION_ID`)
	REFERENCES `is2_work_session` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- STEP RUNTIME
--
-- Description: 
-- 
-- -----------------------------------------------------
CREATE TABLE `is2_step_runtime` (
  `ID` 						   INT NOT NULL AUTO_INCREMENT,
  `ORDER_CODE` 					   INT NULL,
  `ROLE_GROUP` 				   INT NULL,
  `DATA_PROCESSING_ID`		   INT NOT NULL,
  `WORKSET_ID` 				   INT NOT NULL,
  `APP_ROLE_ID` 			   INT NOT NULL,
  `CLS_DATA_TYPE_ID` 		   INT NOT NULL,
  `CLS_TYPE_IO_ID` 		   	   INT NOT NULL,
  `STEP_INSTANCE_SIGNATURE_ID` INT NULL,
   PRIMARY KEY (`ID`),
   CONSTRAINT `fk_is2_step_runtime_is2_data_processing` FOREIGN KEY (`DATA_PROCESSING_ID`)
	REFERENCES `is2_data_processing` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_is2_step_runtime_is2_workset` FOREIGN KEY (`WORKSET_ID`)
	REFERENCES `is2_workset` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_is2_step_runtime_is2_app_role` FOREIGN KEY (`APP_ROLE_ID`)
	REFERENCES `is2_app_role` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_is2_step_runtime_is2_data_type` FOREIGN KEY (`CLS_DATA_TYPE_ID`)
	REFERENCES `is2_cls_data_type` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_is2_step_runtime_is2_type_io` FOREIGN KEY (`CLS_TYPE_IO_ID`)
	REFERENCES `is2_cls_type_io` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_is2_step_runtime_is2_signature` FOREIGN KEY (`STEP_INSTANCE_SIGNATURE_ID`)
	REFERENCES `is2_step_instance_signature` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - LINK
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
--  MANY TO MANY RELATION -> PROCESS_STEP - PROCESS_STEP_INSTANCE
-- -----------------------------------------------------
CREATE TABLE `is2_link_step_instance` (
  `PROCESS_STEP_ID` 		 INT NOT NULL,
  `PROCESS_STEP_INSTANCE_ID` INT NOT NULL,
  PRIMARY KEY (`PROCESS_STEP_ID`, `PROCESS_STEP_INSTANCE_ID`),
  CONSTRAINT `fk_is2_step_instance_process_step` FOREIGN KEY (`PROCESS_STEP_ID`)
	REFERENCES `is2_process_step` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_is2_step_instance_step_instance` FOREIGN KEY (`PROCESS_STEP_INSTANCE_ID`)
	REFERENCES `is2_step_instance` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
--  MANY TO MANY RELATION -> BUSINESS_SERVICE - APP_ROLE
-- -----------------------------------------------------
CREATE TABLE `is2_link_business_service_app_role` (
  `BUSINESS_SERVICE_ID` INT NOT NULL,
  `APP_ROLE_ID` 		INT NOT NULL,
  PRIMARY KEY (`BUSINESS_SERVICE_ID`, `APP_ROLE_ID`),
   CONSTRAINT `fk_is2_business_service_app_role_business_service` FOREIGN KEY (`BUSINESS_SERVICE_ID`)
	REFERENCES `is2_business_service` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_is2_business_service_app_role_app_role` FOREIGN KEY (`APP_ROLE_ID`)
	REFERENCES `is2_app_role` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - END
-- 
-- -----------------------------------------------------





-- -----------------------------------------------------
-- 
-- SECTION AUXILIARY - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- LOG
-- -----------------------------------------------------
CREATE TABLE `is2_log` (
  `ID` 				INT NOT NULL AUTO_INCREMENT,
  `MSG` 			TEXT NULL,
  `MSG_TIME` 		DATETIME NULL,
  `TYPE` 			VARCHAR(50) NULL,
  `WORK_SESSION_ID` INT NOT NULL REFERENCES `is2`.`is2_work_session` (`ID`),
   PRIMARY KEY (`ID`),
   CONSTRAINT `fk_is2_log_worksession` FOREIGN KEY (`WORK_SESSION_ID`)
	REFERENCES `is2_work_session` (`ID`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- 
-- SECTION ADMINISTRATION - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION WHAT'S NEXT - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- WORKFLOW
-- The workflow will be implemented in a future release of the software
-- -----------------------------------------------------
CREATE TABLE `is2_workflow` (
  `ID` 			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `RULE_ID` 	INT NOT NULL,
  `STEP` 		INT NOT NULL REFERENCES `is2`.`is2_process_step` (`ID`),
  `SUB_STEP` 	INT NOT NULL REFERENCES `is2`.`is2_process_step` (`ID`),
  `ELSE_STEP` 	INT NOT NULL REFERENCES `is2`.`is2_process_step` (`ID`)
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- DATA BRIDGE
-- The data bridge will be implemented in a future release of the software
-- -----------------------------------------------------

CREATE TABLE `is2_data_bridge` (
  `ID` 			INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `NAME` 		VARCHAR(50) NULL,
  `DESCR` 		VARCHAR(100) NULL,
  `VALUE` 		VARCHAR(50) NULL,
  `TYPE` 		VARCHAR(50) NULL,
  `bridge_name` VARCHAR(50) NULL
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARACTER SET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- 
-- SECTION WHAT'S NEXT - END
-- 
-- -----------------------------------------------------



-- -----------------------------------------------------
-- 
-- SECTION BATCH  - BEGIN
-- 
-- -----------------------------------------------------

-- DROP TABLES --
DROP TABLE IF EXISTS BATCH_STEP_EXECUTION_CONTEXT ;
DROP TABLE IF EXISTS BATCH_JOB_EXECUTION_CONTEXT ;
DROP TABLE IF EXISTS BATCH_STEP_EXECUTION ;
DROP TABLE IF EXISTS BATCH_JOB_EXECUTION_PARAMS ;
DROP TABLE IF EXISTS BATCH_JOB_EXECUTION ;
DROP TABLE IF EXISTS BATCH_JOB_INSTANCE ;

-- DROP SEQUENCES --
DROP TABLE IF EXISTS BATCH_STEP_EXECUTION_SEQ ;
DROP TABLE IF EXISTS BATCH_JOB_EXECUTION_SEQ ;
DROP TABLE IF EXISTS BATCH_JOB_SEQ ;

-- CREATE TABLES AND SEQUENCES --
CREATE TABLE BATCH_JOB_INSTANCE  (
	JOB_INSTANCE_ID BIGINT  NOT NULL PRIMARY KEY ,
	VERSION BIGINT ,
	JOB_NAME VARCHAR(100) NOT NULL,
	JOB_KEY VARCHAR(32) NOT NULL,
	constraint JOB_INST_UN unique (JOB_NAME, JOB_KEY)
) ENGINE=InnoDB;

CREATE TABLE BATCH_JOB_EXECUTION  (
	JOB_EXECUTION_ID BIGINT  NOT NULL PRIMARY KEY ,
	VERSION BIGINT  ,
	JOB_INSTANCE_ID BIGINT NOT NULL,
	CREATE_TIME DATETIME NOT NULL,
	START_TIME DATETIME DEFAULT NULL ,
	END_TIME DATETIME DEFAULT NULL ,
	STATUS VARCHAR(10) ,
	EXIT_CODE VARCHAR(2500) ,
	EXIT_MESSAGE VARCHAR(2500) ,
	LAST_UPDATED DATETIME,
	JOB_CONFIGURATION_LOCATION VARCHAR(2500) NULL,
	WF_SESSION_ID BIGINT NULL,
  	WF_ELAB_ID BIGINT NULL,
  	WF_PROC_ID BIGINT NULL,
	constraint JOB_INST_EXEC_FK foreign key (JOB_INSTANCE_ID)
	references BATCH_JOB_INSTANCE(JOB_INSTANCE_ID)
	ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE BATCH_JOB_EXECUTION_PARAMS  (
	JOB_EXECUTION_ID BIGINT NOT NULL ,
	TYPE_CD VARCHAR(6) NOT NULL ,
	KEY_NAME VARCHAR(100) NOT NULL ,
	STRING_VAL VARCHAR(250) ,
	DATE_VAL DATETIME DEFAULT NULL ,
	LONG_VAL BIGINT ,
	DOUBLE_VAL DOUBLE PRECISION ,
	IDENTIFYING CHAR(1) NOT NULL ,
	constraint JOB_EXEC_PARAMS_FK foreign key (JOB_EXECUTION_ID)
	references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
	ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE BATCH_STEP_EXECUTION  (
	STEP_EXECUTION_ID BIGINT  NOT NULL PRIMARY KEY ,
	VERSION BIGINT NOT NULL,
	STEP_NAME VARCHAR(100) NOT NULL,
	JOB_EXECUTION_ID BIGINT NOT NULL,
	START_TIME DATETIME NOT NULL ,
	END_TIME DATETIME DEFAULT NULL ,
	STATUS VARCHAR(10) ,
	COMMIT_COUNT BIGINT ,
	READ_COUNT BIGINT ,
	FILTER_COUNT BIGINT ,
	WRITE_COUNT BIGINT ,
	READ_SKIP_COUNT BIGINT ,
	WRITE_SKIP_COUNT BIGINT ,
	PROCESS_SKIP_COUNT BIGINT ,
	ROLLBACK_COUNT BIGINT ,
	EXIT_CODE VARCHAR(2500) ,
	EXIT_MESSAGE VARCHAR(2500) ,
	LAST_UPDATED DATETIME,
	constraint JOB_EXEC_STEP_FK foreign key (JOB_EXECUTION_ID)
	references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
	ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE BATCH_STEP_EXECUTION_CONTEXT  (
	STEP_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
	SHORT_CONTEXT VARCHAR(2500) NOT NULL,
	SERIALIZED_CONTEXT TEXT ,
	constraint STEP_EXEC_CTX_FK foreign key (STEP_EXECUTION_ID)
	references BATCH_STEP_EXECUTION(STEP_EXECUTION_ID)
	ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE BATCH_JOB_EXECUTION_CONTEXT  (
	JOB_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
	SHORT_CONTEXT VARCHAR(2500) NOT NULL,
	SERIALIZED_CONTEXT TEXT ,
	constraint JOB_EXEC_CTX_FK foreign key (JOB_EXECUTION_ID)
	references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
	ON DELETE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS BATCH_STEP_EXECUTION_SEQ;
CREATE TABLE BATCH_STEP_EXECUTION_SEQ (
	ID BIGINT NOT NULL,
	UNIQUE_KEY CHAR(1) NOT NULL,
	constraint UNIQUE_KEY_UN unique (UNIQUE_KEY)
) ENGINE=InnoDB;

INSERT INTO BATCH_STEP_EXECUTION_SEQ (ID, UNIQUE_KEY) select * from (select 0 as ID, '0' as UNIQUE_KEY) as tmp where not exists(select * from BATCH_STEP_EXECUTION_SEQ);

CREATE TABLE BATCH_JOB_EXECUTION_SEQ (
	ID BIGINT NOT NULL,
	UNIQUE_KEY CHAR(1) NOT NULL,
	constraint UNIQUE_KEY_UN unique (UNIQUE_KEY)
) ENGINE=InnoDB;

INSERT INTO BATCH_JOB_EXECUTION_SEQ (ID, UNIQUE_KEY) select * from (select 0 as ID, '0' as UNIQUE_KEY) as tmp where not exists(select * from BATCH_JOB_EXECUTION_SEQ);

CREATE TABLE BATCH_JOB_SEQ (
	ID BIGINT NOT NULL,
	UNIQUE_KEY CHAR(1) NOT NULL,
	constraint UNIQUE_KEY_UN unique (UNIQUE_KEY)
) ENGINE=InnoDB;

INSERT INTO BATCH_JOB_SEQ (ID, UNIQUE_KEY) select * from (select 0 as ID, '0' as UNIQUE_KEY) as tmp where not exists(select * from BATCH_JOB_SEQ);


-- -----------------------------------------------------
-- 
-- SECTION BATCH  - END
-- 
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Populate is2
-- -----------------------------------------------------
USE `is2`;
SET FOREIGN_KEY_CHECKS=0;
-- -----------------------------------------------------
-- 
-- CLASSIFICATION TABLES - BEGIN
--
-- -----------------------------------------------------

-- -----------------------------------------------------
-- DATA TYPE CLASSIFICATION
-- -----------------------------------------------------
INSERT INTO `is2_cls_data_type` (`ID`, `NAME`) 
	VALUES 
		(1,'VARIABLE'),
		(2,'PARAMETER'),
		(3,'DATASET'),
		(4,'RULESET'),
		(5,'RULE'),
		(6,'MODEL');
        
-- -----------------------------------------------------
-- INPUT/OUTPUT CLASSIFICATION
-- -----------------------------------------------------
INSERT INTO `is2_cls_type_io` (`ID`, `NAME`) 
	VALUES 
		(1,'INPUT'),
		(2,'OUTPUT'),
		(3,'INPUT_OUTPUT');

-- -----------------------------------------------------
-- VARIABLE CLASSIFICATION (FROM ISTAT CORPORATE METADATA SYSTEM)
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- RULE TYPE CLASSIFICATION
-- -----------------------------------------------------
INSERT INTO `is2_cls_rule` (`ID`, `NAME`, `DESCR`, `NOTE`) 
	VALUES 
		(1,'Dominio','Definisce i valori o le modalità ammissibili della variabile','Può comprendere missing e/o zero; distinguere tra variabile qualitativa e quantitativa'),
		(2,'Coerenza logica','Definisce le combinazioni ammissibili di valori e/o modalità tra due o più variabili ','Prevalentemente per  variabli qualitative, anche se la regola può riguardare entrambe le tipologie di variabili (es. ETA(0-15) STACIV(coniugato) con ETA fissa)'),
		(3,'Quadratura','Definisce l\'uguaglianza ammissibile tra la somma di due o più variabili quantitative e il totale corrispondente (che può essere noto a priori o a sua volta ottenuto dalla somma di altre variabili del dataset)','Solo variabili quantitative'),
		(4,'Disuguaglianza forma semplice','Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due variabili quantitative','Solo variabili quantitative'),
		(5,'Disuguaglianza forma composta','Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due quantità, dove ciascuna quantità può essere costituita da una sola variabile X o dalla somma/differenza/prodotto tra due o più variabili X','Solo variabili quantitative'),
		(6,'Validazione/Completezza','Verifica in base alle regole di compilazione del questionario che i dati siano stati immessi correttamente','Distinguere tra variabile qualitativa e quantitativa'),
		(7,'Editing',NULL,'Valore di default al caricamento del file');

-- -----------------------------------------------------
-- VIEW_DATA_TYPE
-- -----------------------------------------------------
INSERT INTO `is2_view_data_type` (`ID`, `NAME`) 
	VALUES 
		(1,'DATASET'),
		(2,'RULESET');

-- -----------------------------------------------------
-- 
-- CLASSIFICATION TABLES - END
--
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- PROCESS DESIGN SECTION - BEGIN
--
-- -----------------------------------------------------

-- -----------------------------------------------------
-- BUSINESS_FUNCTION
-- -----------------------------------------------------
INSERT INTO `is2_business_function` (`ID`, `NAME`, `DESCR`, `LABEL`, `ACTIVE`) 
	VALUES 
		(1,'Record Linkage','The purpose of record linkage is to identify the same real world entity that can be differently represented in data sources, even if unique identifiers are not available or are affected by errors.','RL',1),
		(2,'Data Editing','Data editing is the process of reviewing the data for consistency, detection of errors and outliers and correction of errors, in order to improve the quality, accuracy and adequacy of the data and make it suitable for the purpose for which it was collected.','EDIT',1),
		(3,'Data Validation','Data validation is the process of ensuring data have undergone data cleansing to ensure they have data quality, that is, that they are both correct and useful. It uses routines, often called \"validation rules\", that check for correctness, meaningfulness, and security of data that are input to the system.','VALIDATE',1);


-- -----------------------------------------------------
-- BUSINESS_PROCESS
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- CATALOGUE OF BUSINESS SERVICES
-- -----------------------------------------------------
INSERT INTO `is2_business_service` (`ID`, `NAME`, `DESCR`) 
	VALUES  
		(200,'Relais','Record Linkage at Istat'),
		(300,'Validate','R Data Validation');

-- -----------------------------------------------------
-- PROCESS_STEP
-- -----------------------------------------------------
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`) 
	VALUES 
		(4,'VALIDATE','Validate dataset with ruleset',300),
		(70,'CONTINGENCY_TABLE','Create contingency table',200),
		(71,'FELLEGI SUNTER','Select matching variables',200),
		(72,'MATCHING TABLE','Create result matching table',200);

- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - LINK TABLES
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_FUNCTION - BUSINESS_PROCESS
-- -----------------------------------------------------
INSERT INTO `is2_link_function_process` (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`)
	VALUES (1,1),(1,2),(3,3);
    
-- add multi-step process
INSERT INTO `is2_link_function_process` (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`) VALUES ('1', '5');

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_PROCESS - PROCESS_STEP
-- -----------------------------------------------------
INSERT INTO `is2_link_process_step` (`BUSINESS_PROCESS_ID`, `PROCESS_STEP_ID`) 
	VALUES (4,4),(6,70),(6,71),(6,72),(70,70),(71,71),(72,72);

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_FUNCTION - VIEW_DATA_TYPE
-- -----------------------------------------------------
INSERT INTO `is2_link_function_view_data_type` (`BUSINESS_FUNCTION_ID`, `VIEW_DATA_TYPE_ID`) 
	VALUES (1,1), (2,1), (2,2), (3,1), (3,2);

-- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- CATALOGUE OF APPLICATION SERVICES
-- -----------------------------------------------------
INSERT INTO `is2_app_service` (`ID`, `NAME`, `DESCR`, `IMPLEMENTATION_LANGUAGE`, `SOURCE`, `BUSINESS_SERVICE_ID`) 
	VALUES  
		(200,'Relais R','R package implementing record linkage methods','R','relais/relais.R',200),
		(250,'Relais Java','Java package implementing record linkage methods','JAVA','it.istat.is2.catalogue.relais.service.RelaisService',200),
		(300,'Validate','R package implementing a set of data validation functions','R','validate/validate.r',300);

-- -----------------------------------------------------
-- STEP INSTANCE
-- -----------------------------------------------------
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) 
	VALUES
		(11,'contingencyTable','This function calculates the contingency Table','ContingencyTable',250),
		(12,'fellegisunter','This function implements the Fellegi Sunter algorithm','FellegiSunter',200),
		(13,'resultTables','This function calculates the Matching Table','MatchingTable',250),
		(14,'is2_validate_confront','This function runs the confront algoritm implemented by Van Der Loo','Confront',300);

-- -----------------------------------------------------
-- PARAMETER
-- -----------------------------------------------------
INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`) 
	VALUES
		('1', 'MATCHING VARIABLES', 'MATCHING VARIABLES', NULL, '{"data":[],"schema":{"items":{"properties":{"MatchingVariable":{"maxLength":50,"required":true,"title":"MatchingVariable","type":"string"},"MatchingVariableA":{"maxLength":50,"required":true,"title":"MatchingVariableA","type":"string"},"MatchingVariableB":{"maxLength":50,"required":true,"title":"MatchingVariableB","type":"string"},"Method":{"enum":["Equality","Jaro","Dice","JaroWinkler","Levenshtein","3Grams","Soundex","NumericComparison","NumericEuclideanDistance","WindowEquality","Inclusion3Grams"],"required":true,"title":"Method"},"Threshold":{"title":"Threshold","type":"number"}},"type":"object"},"type":"array"},"options":{"type":"table","showActionsColumn":false,"hideAddItemsBtn":true,"items":{"fields":{"Method":{"type":"select","noneLabel":"","removeDefaultNone":false},"MatchingVariableA":{"type":"select","noneLabel":"","dataSource":"matchedVariables"},"MatchingVariableB":{"type":"select","noneLabel":"","dataSource":"matchedVariables"}}},"form":{"buttons":{"addRow":"addRow","removeRow":"removeRow"}},"view":{"templates":{"container-array-toolbar":"#addItemsBtn"}}}}'),
        ('2', 'THRESHOLD MATCHING', 'THRESHOLD MATCHING', 1, '{"data":[],"schema":{"name":"THRESHOLD MATCHING","type":"number", "minimum": 0.01,"maximum": 1}}'),
        ('3', 'THRESHOLD UNMATCHING', 'THRESHOLD UNMATCHING', 1, '{"data":[],"schema":{"name":"THRESHOLD UNMATCHING","type":"number", "minimum": 0.01,"maximum": 1}}');

-- -----------------------------------------------------
-- ROLE
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- STEP INSTANCE SIGNATURE
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - LINK
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
--  MANY TO MANY RELATION -> PROCESS_STEP - PROCESS_STEP_INSTANCE
-- -----------------------------------------------------
INSERT INTO `is2_link_step_instance` (`PROCESS_STEP_INSTANCE_ID`, `PROCESS_STEP_ID`) 
	VALUES (11,70), (12,71), (13,72), (14,4);

-- -----------------------------------------------------
--  MANY TO MANY RELATION -> BUSINESS_SERVICE - APP_ROLE
-- -----------------------------------------------------
INSERT INTO `is2_link_business_service_app_role` (`BUSINESS_SERVICE_ID`, `APP_ROLE_ID`) 
	VALUES (200,1), (200,2), (200,3), (200,4), (200,5), (200,6), (200,7), (200,8), (200,9), (200,10), (200,11), (200,12), (200,13), (200,14), (300,15), (300,16);

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION AUXILIARY - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- USER ROLE
-- -----------------------------------------------------
INSERT INTO `is2_user_roles` (`ID`, `ROLE`) 
	VALUES 
		(1,'ROLE_ADMIN'),
        (2,'ROLE_USER');

-- -----------------------------------------------------
-- USER
-- -----------------------------------------------------
INSERT INTO `is2_users` (`ID`, `EMAIL`, `NAME`, `SURNAME`, `PASSWORD`, `ROLE_ID`) 
	VALUES
		(1,'admin@is2.it','Administrator','Workbench','$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC',1),
        (2,'user@is2.it','User','Workbench','$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82',2);

-- -----------------------------------------------------
-- 
-- SECTION AUXILIARY - END
-- 
-- -----------------------------------------------------

SET FOREIGN_KEY_CHECKS=1;

-- -----------------------------------------------------
-- Populate is2
-- -----------------------------------------------------
USE `is2`;
SET FOREIGN_KEY_CHECKS=0;


-- -----------------------------------------------------
-- BUSINESS_PROCESS
-- -----------------------------------------------------
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (80,'Selezione Errori Influenti multi process','Esegue la stima, predizione e valuta gli errori influenti in due processi successivi','Selezione2P',NULL,1);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (110,'Stima e Predizione','Escuzione del processo di stima e predizione','Estimates',80,1);
INSERT INTO `is2_business_process` (`ID`, `NAME`, `DESCR`, `LABEL`, `PARENT`, `ORDER`) VALUES (130,'Editing Selettivo','Esecuzione del processo di selezione dei valori influenti','Selection',80,2);
-- -----------------------------------------------------
-- CATALOGUE OF BUSINESS SERVICES
-- -----------------------------------------------------
INSERT INTO `is2_business_service` (`ID`, `NAME`, `DESCR`) 	VALUES	(100,'SeleMix','Selective editing via Mixture models') ;

-- -----------------------------------------------------
-- PROCESS_STEP
-- -----------------------------------------------------

INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (10,'MLEST','Stima',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (15,'STMLEST','Stima stratificata',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (20,'PRED','Predizione',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (25,'STRPRED','Predizione stratificata',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (30,'SELED','Editing Seletivo',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (35,'STRSELED','Editing Seletivo Stratificato',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (40,'OUTL','Scelta Outlier',100);
INSERT INTO `is2_process_step` (`ID`, `NAME`, `DESCR`, `BUSINESS_SERVICE_ID`)  VALUES (50,'MOD','Imposta Modello',100);

- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - LINK TABLES
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_FUNCTION - BUSINESS_PROCESS
-- -----------------------------------------------------
INSERT INTO `is2_link_function_process` (`BUSINESS_FUNCTION_ID`, `BUSINESS_PROCESS_ID`)
	VALUES (2,80);

-- -----------------------------------------------------
-- MANY TO MANY RELATION -> BUSINESS_PROCESS - PROCESS_STEP
-- -----------------------------------------------------
INSERT INTO `is2_link_process_step` (`BUSINESS_PROCESS_ID`, `PROCESS_STEP_ID`) 
	VALUES (110,10),(130,30);
-- -----------------------------------------------------
-- 
-- SECTION PROCESS DESIGN - END
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - BEGIN
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- CATALOGUE OF APPLICATION SERVICES
-- -----------------------------------------------------
INSERT INTO `is2_app_service` (`ID`, `NAME`, `DESCR`, `IMPLEMENTATION_LANGUAGE`, `SOURCE`, `BUSINESS_SERVICE_ID`) 
	VALUES  
		(100,'SeleMix','R package implementing selective editing algorithms','R','selemix/IS2_selemix.r',100);

-- -----------------------------------------------------
-- STEP INSTANCE
-- -----------------------------------------------------
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (1,'is2_mlest','Stima e predizione','STIMA',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (2,'is2_ypred','Predizione da modello','PREDIZIONE',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (3,'is2_seledit','Selezione Errori Influenti','SELEZIONE',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (4,'is2_modest','Valutazione del modello','MODEL',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (5,'is2_selpairs','Generazione Grafico','GRAPH',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (7,'is2_strata_mlest','Stima stratificata','STRATST',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (8,'is2_strata_ypred','Predizione stratificata','STRATPR',100);
INSERT INTO `is2_step_instance` (`ID`, `METHOD`, `DESCR`, `LABEL`, `APP_SERVICE_ID`) VALUES (9,'is2_strata_seledit','Selezione stratificata','STRATSE',100);

-- -----------------------------------------------------
-- PARAMETER
-- -----------------------------------------------------
INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`)  VALUES (101,'MODEL','DATA MODEL',NULL,'{ "data": [], "schema": {"items": {"properties": { "lambda": {"required": true,"title": "Lambda","description":"Estimated value for the variance inflation factor","type": "number", "default":3,"minimum": 0.01,"maximum": 10 },"w": {"required": true,"title": "W","description":"Estimated value for the proportion of contaminated data","type": "number","default":0.05,"minimum": 0.01,"maximum": 1 }, "B": {"required": true,"title": "B","description":"Matrix of estimated regression coefficients","type": "number"}, "sigma": {"required": true,"title": "sigma","description":"Estimated covariance matrix","type": "number"} },"type": "object"},"type": "array" }, "options": {"type": "array","showActionsColumn": false,"hideAddItemsBtn": true }}');
INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`)  VALUES (102,'INPUT_PARAMETERS','INPUT PARAMETERS',NULL,'{"data": [],"schema": { "properties": {"graph": {"required": true,"title": "Graph","description": "Activates graphic output","type": "number","default": 0,"minimum": 0.01,"maximum": 10},"model": {"required": true,"title": "Model","description": "Data Distribution: LN lognormal / N Normal","default": "LN"},"tot": {"title": "Tot","description": "Estimates of originals vector for the target variables"},"t.sel": {"title": "t.sel","description": "Optional vector of threshold values for selective edinting on the target variables"},"t.outl": {"required": true,"title": "t.outl","description": "Threshold value for posterior probabilities of identifying outliers","type": "number","default": 0.05,"minimum": 0.01,"maximum": 10},"eps": {"required": true,"title": "eps","description": "Tolerance for the log-likelihood convergence","type": "number","default": 0.0000001,"minimum": 0.0000001,"maximum": 1},"lambda.fix": {"required": true,"title": "lambda.fix","description": "TRUE if w is known","type": "number","default": 0,"maximum": 1 },"w.fix": {"required": true,"title": "w.fix","description": "TRUE if w is known","type": "number","default": 0,"minimum": 0.01,"maximum": 1}},"type": "object" }}');
INSERT INTO `is2_parameter` (`ID`, `NAME`, `DESCR`, `DEFAULT_VAL`, `JSON_TEMPLATE`)  VALUES (103,'OUTPUT_PARAMETERS','OUTPUT PARAMETERS - INFO REPORT',NULL,NULL);
 
-- -----------------------------------------------------
-- ROLE
-- -----------------------------------------------------
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

-- -----------------------------------------------------
-- STEP INSTANCE SIGNATURE
-- -----------------------------------------------------

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



-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - LINK
-- 
-- -----------------------------------------------------

-- -----------------------------------------------------
--  MANY TO MANY RELATION -> PROCESS_STEP - PROCESS_STEP_INSTANCE
-- -----------------------------------------------------
INSERT INTO `is2_link_step_instance` (`PROCESS_STEP_ID`,`PROCESS_STEP_INSTANCE_ID`) 
	VALUES (10,1),(20,2),(30,3),(40,2),(50,4),(25,8),(35,9),(15,7);

-- -----------------------------------------------------
--  MANY TO MANY RELATION -> BUSINESS_SERVICE - APP_ROLE
-- -----------------------------------------------------
INSERT INTO `is2_link_business_service_app_role` (`BUSINESS_SERVICE_ID`, `APP_ROLE_ID`) 
	VALUES (100,100),(100,101),(100,102),(100,103),(100,104),(100,105),(100,106),(100,107),(100,108),(100,109),(100,110),(100,111),(100,112),(100,113),(100,114);

-- -----------------------------------------------------
-- 
-- SECTION PROCESS IMPLEMENTATION - END
-- 
-- -----------------------------------------------------


SET FOREIGN_KEY_CHECKS=1;
