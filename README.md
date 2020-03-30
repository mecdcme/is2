[![Build Status](https://travis-ci.org/mecdcme/is2.svg?branch=master)](https://travis-ci.org/mecdcme/is2) [![Docker hub](https://img.shields.io/docker/cloud/automated/i3sessnet/is2.svg?label=is2%20docker)](https://cloud.docker.com/u/i3sessnet/repository/docker/i3sessnet/is2) [![Docker hub](https://img.shields.io/docker/cloud/automated/i3sessnet/is2-mysql.svg?label=is2-mysql%20docker)](https://cloud.docker.com/u/i3sessnet/repository/docker/i3sessnet/is2-mysql)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=mecdcme_is2&metric=alert_status)](https://sonarcloud.io/dashboard?id=mecdcme_is2)
# IS2
A runtime environment to execute statistical services. IS2 is a workbench that offers a set of tools for data analysis and processing. 

## What you’ll need
In order to build the IS2 application, your environment should fulfill the following requirements:

* A favorite text editor or IDE;
* JDK 11 or later;
* Maven 3.0+;
* Mysql Server 8.0 or later;

## What you’ll build
Istat has realized a generalized environment (Istat Statistical Service - IS2) that allows to select statistical services from a catalogue and execute them through a web application (IS2 workbench).
The IS2 Workbench has been designed to offer a set of functionalities that allow to:
1.  **Select a business function**: the landing page contains the list of available business functions classified according to GSBPM phases (e.g. ReLais performs GSBPM 5.1 “Data integration”). A business function is a high level goal (What) that can be realized by one or more statistical processes, implemented by one or more services available in the catalogue.
2.  **Select a business process**: the system provides the list of available processes for the selected function (e.g. Probabilistic Record Linkage or Deterministic Record Linkage). A business process is implemented by a set of process steps. Each process step is linked to a statistical service available in the catalogue. Statistical services perform specific statistical method, implemented in an open source language.
The following figure shows the link between the “Record linkage” business function, available in the workbench, the “Probabilistic record linkage” process and the related statistical service (Relais).
![IS2 Core concepts](/doc/img/is2-concepts.png)
3.  **Upload process input data**: in order to launch a process, the system requires the specification of input data to process. The initial set of data may include a list of rules, and/or other parameters used by the statistical method embedded in the process steps.
4.  **Set process metadata**: a statistical service may require further information, depending on the statistical function to perform. This set of metadata is provided by the user and is usually tied to input data structure, or concerns model parameters (e.g. specification of matching variables in the datasets to be linked, setting of matching/unmatching thresholds).
5.  **Execute a business process according to a predetermined workflow**: this function allows to execute the process previously configured.
## How to build
Download and unzip the source code in your workspace `IS2_PATH`.
Before building the application you must create a MySQL database. From the command line go to MySQL installation directory `MYSQL_PATH`:
```
cd MYSQL_PATH\bin;
mysql -u db_username -p
```
Then create the tables needed to run the application, using the script `is2.sql` stored in the [IS2_PATH/db](db/is2.sql) folder:
```
mysql> source is2-create.sql
mysql> source is2-insert.sql
```

The script will populate the `USER/ROLES` tables with the user:
```
Username: admin@is2.it
Password: istat
``` 

After DB installation, you need to increase the `max_allowed_packet` parameter  in the `my.ini` configuration file and restart the MySQL Sever:
```
max_allowed_packet=256M
```

From your IDE select and open the unzipped maven project.
As a first step check the content of the application.properties file, located in the path `Other Sources > src/main/resources`:

```
spring.datasource.url = jdbc:mysql://localhost:3306/IS2?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC
spring.datasource.username = db_username
spring.datasource.password = db_password
```
Now you can perform your first build of the application.
If the build process ends successfully, you are ready to run the application. 
The application is built using the open source framework Spring Boot, which generates an 
executable jar (that can be run from the command line). Spring Boot creates a stand-alone Spring 
based Applications, with an embedded Tomcat, that you can "just run".
```
java –jar is2.jar
```


Dockerize the MySQL database
```
docker build -t i3sessnet/is2-postgres . -f db.Dockerfile
docker run -p 5432:5432 i3sessnet/is2-postgres
```

Dockerize the web application
```
docker build -t i3sessnet/is2 .
docker run -p 8080:8080 i3sessnet/is2 
```

Docker compose
```
docker-compose up
```
The application will be at http://localhost:8080/is2 If you want to inspect the database you can use the 
[Adminer](https://hub.docker.com/_/adminer/) application at http://localhost:8081/ 

## License
IS2 is EUPL-licensed
