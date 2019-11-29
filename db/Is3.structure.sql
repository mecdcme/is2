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