FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABSE IS2
ENV SPRING_DATASOURCE_URL jdbc:mysql://localhost:3306/IS2?allowPublicKeyRetrieval=true&useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC


COPY ./db/is2.sql /docker-entrypoint-initdb.d/
