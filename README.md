# IS2
A runtime environment to execute statistical services

## What you’ll need

In order to build the IS2 application, your environment should fulfill the following requirements:

* A favorite text editor or IDE
* JDK 1.8 or later
* Maven 3.0+
* Mysql Server 8.0 or later

## What you’ll build

You’ll build a template web application that will provide out of the box :
* Authentication & authorization;
* Responsive graphical interface (html, css, js):
  * Tables with enhanced interaction controls (search, export, sorting, etc.);
  * Charts;
* Server side components:
  * CRUD (insert, delete, update);
  * Search filters;
  
## How to build
Download and unzip the source code in your workspace `IS2_PATH`.
Before building the application you must create a MySQL database. From the command line go to MySQL installation directory `MYSQL_PATH`:
```
cd MYSQL_PATH\bin;
mysql -u db_username -p
mysql> create database is2;
```
Then create the tables needed to run the application, using the script `is2.sql` stored in the `IS2_PATH/db` folder:
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
In the docs folder you will find a complete userguide with useful information that will help you to understand is2 project.

Dockerize the MySQL database
```
docker build -t i3s-essnet/is2-mysql .
docker run -p 3306:3306 i3s-essnet/is2-mysql
```

Dockerize the web application
```
docker build -t i3s-essnet/is2 .
docker run --rm  i3s-essnet/is2 
```

## License
IS2 is EUPL-licensed
