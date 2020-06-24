
--
-- TOC entry 4915 (class 0 OID 25182)
-- Dependencies: 236
-- Data for Name: is2_cls_data_type; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_data_type VALUES (1, 'VARIABLE', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (2, 'PARAMETER', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (3, 'DATASET', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (4, 'RULESET', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (5, 'RULE', NULL);
INSERT INTO is2.is2_cls_data_type VALUES (6, 'MODEL', NULL);


--
-- TOC entry 4917 (class 0 OID 25190)
-- Dependencies: 238
-- Data for Name: is2_cls_rule; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_rule VALUES (1, 'Dominio', 'Definisce i valori o le modalità ammissibili della variabile', 'Può comprendere missing e/o zero; distinguere tra variabile qualitativa e quantitativa');
INSERT INTO is2.is2_cls_rule VALUES (2, 'Coerenza logica', 'Definisce le combinazioni ammissibili di valori e/o modalità tra due o più variabili ', 'Prevalentemente per  variabli qualitative, anche se la regola può riguardare entrambe le tipologie di variabili (es. ETA(0-15) STACIV(coniugato) con ETA fissa)');
INSERT INTO is2.is2_cls_rule VALUES (3, 'Quadratura', 'Definisce l''uguaglianza ammissibile tra la somma di due o più variabili quantitative e il totale corrispondente (che può essere noto a priori o a sua volta ottenuto dalla somma di altre variabili del dataset)', 'Solo variabili quantitative');
INSERT INTO is2.is2_cls_rule VALUES (4, 'Disuguaglianza forma semplice', 'Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due variabili quantitative', 'Solo variabili quantitative');
INSERT INTO is2.is2_cls_rule VALUES (5, 'Disuguaglianza forma composta', 'Definisce la relazione matematica ammissibile (>, >=, <, <=) tra due quantità, dove ciascuna quantità può essere costituita da una sola variabile X o dalla somma/differenza/prodotto tra due o più variabili X', 'Solo variabili quantitative');
INSERT INTO is2.is2_cls_rule VALUES (6, 'Validazione/Completezza', 'Verifica in base alle regole di compilazione del questionario che i dati siano stati immessi correttamente', 'Distinguere tra variabile qualitativa e quantitativa');
INSERT INTO is2.is2_cls_rule VALUES (7, 'Editing', NULL, 'Valore di default al caricamento del file');


--
-- TOC entry 4919 (class 0 OID 25198)
-- Dependencies: 240
-- Data for Name: is2_cls_statistical_variable; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_statistical_variable VALUES (1, NULL, 'Variabili identificative delle unità', 8, 1, 'VARIABILI IDENTIFICATIVE DELLE UNITÀ', 'UNIT INDENTIFIER');
INSERT INTO is2.is2_cls_statistical_variable VALUES (2, NULL, 'Variabili statistiche di classificazione', 1, 2, 'VARIABILI STATISTICHE DI CLASSIFICAZIONE', 'CLASSIFICATION');
INSERT INTO is2.is2_cls_statistical_variable VALUES (3, NULL, 'Variabili statistiche numeriche', 2, 3, 'VARIABILI STATISTICHE NUMERICHE', 'NUMERIC');
INSERT INTO is2.is2_cls_statistical_variable VALUES (4, NULL, 'Variabili statistiche testuali', 3, 4, 'VARIABILI STATISTICHE TESTUALI', 'TEXTUAL/OPENED');
INSERT INTO is2.is2_cls_statistical_variable VALUES (5, NULL, 'Concetti relativi al contenuto dei dati', 6, 5, 'AGGREGATO', 'AGGREGATE');
INSERT INTO is2.is2_cls_statistical_variable VALUES (6, NULL, 'Concetti di tipo operativo', 4, 6, 'CONCETTI DI TIPO OPERATIVO', 'OPERATIONAL');
INSERT INTO is2.is2_cls_statistical_variable VALUES (7, NULL, 'Concetti di tipo temporale', 5, 7, 'CONCETTI DI TIPO TEMPORALE', 'TEMPORAL');
INSERT INTO is2.is2_cls_statistical_variable VALUES (8, NULL, 'Concetti relativi alla frequenza', 7, 8, 'CONCETTI RELATIVI ALLA FREQUENZA', 'FREQUENCY');
INSERT INTO is2.is2_cls_statistical_variable VALUES (9, NULL, 'Concetti usati per identificare il peso campionario', 10, 9, 'PESO', 'PESO');
INSERT INTO is2.is2_cls_statistical_variable VALUES (10, NULL, 'Paradati ..', 12, 10, 'PARADATO', 'PARADATA');
INSERT INTO is2.is2_cls_statistical_variable VALUES (11, NULL, 'Variabili statistiche composte', 11, 11, 'CONCETTI IDENTIFICATIVI DEL DATASET', 'DATASET IDENTIFIER');
INSERT INTO is2.is2_cls_statistical_variable VALUES (12, NULL, 'Variabili non definite', 9, 12, 'NON DEFINITA', 'UNDEFINED');


--
-- TOC entry 4921 (class 0 OID 25206)
-- Dependencies: 242
-- Data for Name: is2_cls_type_io; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_cls_type_io VALUES (1, 'INPUT');
INSERT INTO is2.is2_cls_type_io VALUES (2, 'OUTPUT');
INSERT INTO is2.is2_cls_type_io VALUES (3, 'INPUT_OUTPUT');




-- 
-- GSBPM_PROCESS
-- 
INSERT INTO is2.is2_gsbpm_process (ID, NAME, PARENT, ORDER_CODE, ACTIVE) 
	VALUES 
		(1,'Specify needs',NULL,1,0),
		(2,'Design',NULL,2,1),
		(3,'Build',NULL,3,1),
		(4,'Collect',NULL,4,1),
		(5,'Process',NULL,5,1),
		(6,'Analyse',NULL,6,1),
		(7,'Disseminate',NULL,7,1),
		(8,'Evaluate',NULL,8,0),
		(11,'1.1 Identify needs',1,1,0),
		(12,'1.2 Consult and confirm needs',1,2,0),
		(13,'1.3 Establish output objectives',1,3,0),
		(14,'1.4 Identify concepts',1,4,0),
		(15,'1.5 Check data availability',1,5,0),
		(16,'1.6 Prepare and submit business case',1,6,0),
		(21,'2.1 Design outputs',2,1,1),
		(22,'2.2 Design variable descriptions',2,2,1),
		(23,'2.3 Design collection',2,3,1),
		(24,'2.4 Design frame & sample',2,4,1),
		(25,'2.5 Design processing & analysis',2,5,1),
		(26,'2.6 Design production systems & workflow',2,6,1),
		(31,'3.1 Reuse or build collection instruments',3,1,1),
		(32,'3.2 Reuse or build processing and analysis components',3,2,1),
		(33,'3.3 Reuse or build dissemination components',3,3,1),
		(34,'3.4 Configure workflows',3,4,1),
		(35,'3.5 Test production system',3,5,1),
		(36,'3.6 Test statistical business process',3,6,1),
		(37,'3.7 Finalise production system',3,7,1),
		(41,'4.1 Create frame and select sample',4,1,1),
		(42,'4.2 Set up collection',4,2,1),
		(43,'4.3 Run collection',4,3,1),
		(44,'4.4 Finalize collection',4,4,1),
		(51,'5.1 Integrate data',5,1,1),
		(52,'5.2 Classify & code',5,2,1),
		(53,'5.3 Review & validate',5,3,1),
		(54,'5.4 Edit & impute',5,4,1),
		(55,'5.5 Derive new variables & units',5,5,1),
		(56,'5.6 Calculate weights',5,6,1),
		(57,'5.7 Calculate aggregates',5,7,1),
		(58,'5.8 Finalise data files',5,8,1),
		(61,'6.1 Prepare draft outputs',6,1,1),
		(62,'6.2 Validate outputs',6,2,1),
		(63,'6.3 Interpret & explain outputs',6,3,1),
		(64,'6.4 Apply disclosure control',6,4,1),
		(65,'6.5 Finalise outputs',6,5,1),
		(71,'7.1 Update output systems',7,1,1),
		(72,'7.2 Produce dissemination products',7,2,1),
		(73,'7.3 Manage release of dissemination products',7,3,1),
		(74,'7.4 Promote dissemination products',7,4,1),
		(75,'7.5 Manage user support',7,5,1),
		(81,'8.1 Update output systems',8,1,0),
		(82,'8.2 Produce dissemination products',8,2,0),
		(83,'8.3 Manage release of dissemination products',8,3,0);
        

-- TOC entry 4952 (class 0 OID 25312)
-- Dependencies: 273
-- Data for Name: is2_user_roles; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_user_roles VALUES (1, 'ROLE_ADMIN');
INSERT INTO is2.is2_user_roles VALUES (2, 'ROLE_USER');


--
-- TOC entry 4954 (class 0 OID 25318)
-- Dependencies: 275
-- Data for Name: is2_users; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_users VALUES (1, 'admin@is2.it', 'Administrator', 'Workbench', '$2a$10$VB7y/I.oD16QBVaExgH1K.VEuBUKRyXcCUVweUGhs1vDl0waTQPmC', 1);
INSERT INTO is2.is2_users VALUES (2, 'user@is2.it', 'User', 'Workbench', '$2a$10$yK1pW21E8nlZd/YcOt6uB.n8l36a33RP3/hehbWFAcBsFJhVKlZ82', 2);
INSERT INTO is2.is2_users VALUES (3, 'fra@fra.it', 'Francesco Amato', 'fra', '$2a$10$DIcyvIFwhDkEOT9nBugTleDM73OkZffZUdfmvjMCEXdJr3PZP8Kxm', 1);


--
-- TOC entry 4956 (class 0 OID 25323)
-- Dependencies: 277
-- Data for Name: is2_view_data_type; Type: TABLE DATA; Schema: is2; Owner: -
--

INSERT INTO is2.is2_view_data_type VALUES (1, 'DATASET', NULL);
INSERT INTO is2.is2_view_data_type VALUES (2, 'RULESET', NULL);

