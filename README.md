[![Build Status](https://travis-ci.org/I3S-ESSnet/is2.svg?branch=master)](https://travis-ci.org/I3S-ESSnet/is2) [![Docker hub](https://img.shields.io/docker/cloud/automated/i3sessnet/is2.svg?label=is2%20docker)](https://cloud.docker.com/u/i3sessnet/repository/docker/i3sessnet/is2) [![Docker hub](https://img.shields.io/docker/cloud/automated/i3sessnet/is2-mysql.svg?label=is2-mysql%20docker)](https://cloud.docker.com/u/i3sessnet/repository/docker/i3sessnet/is2-mysql)

# IS2
A runtime environment to execute statistical services. IS2 is a workbench that offers a set of tools for data analysis and processing. 

## What you’ll need
In order to build the IS2 application, your environment should fulfill the following requirements:

* A favorite text editor or IDE
* JDK 1.8 or later
* Maven 3.0+
* Mysql Server 8.0 or later

## What you’ll build
IS2 is a workbench that, regardless of the statistical method executed, provides the following functionalities:

1.	Upload and management of input data and metadata;
2.	Setting of variables and parameters needed by an algorithm, written in Java, R or PL/SQL; 
3.	Algorithm execution;
4.	Analysis of output data and reports.

The main concepts in the context of IS2 are:
1.	Work Session: a work session is a logical environment that allows to upload and preprocess your data. The system provides a set of functionalities to create new variables by transforming the existing ones, or select a subset of records and/or variables.
2.	Processing Session: by mapping initial data with standardized metadata, input data are transformed in working data. In this step, the user can classify and manage the information to process by: i) assigning specific roles to some variables (e.g. identification variable, classification, core variables); ii) selecting auxiliary information (if needed); iii) setting the model parameters. 
3.	Run method: working data, with their standardized data structures, can be processed by one or more iterations of the statistical method. The result of each iteration is stored in standardized data structures (output data).
4.	Analyse output: this process step can be used to perform quality checks and/or to calculate statistical indicators to assess the outcome of each iteration.


## How to build
Download and unzip the source code in your workspace `IS2_PATH`.
Before building the application you must create a MySQL database. From the command line go to MySQL installation directory `MYSQL_PATH`:
```
cd MYSQL_PATH\bin;
mysql -u db_username -p
mysql> create database is2;
```
Then create the tables needed to run the application, using the script `is2.sql` stored in the [IS2_PATH/db](db/is2.sql) folder:
```
mysql> use is2;
mysql> source is2.sql
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
