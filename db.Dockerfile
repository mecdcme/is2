FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABSE IS2

COPY ./db/is2.sql /docker-entrypoint-initdb.d/
