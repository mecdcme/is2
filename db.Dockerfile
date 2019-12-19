FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABSE IS2

COPY ./db/is2-create.sql /docker-entrypoint-initdb.d/
