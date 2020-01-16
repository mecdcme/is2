FROM postgres:11

COPY ./db/is2-postgres.sql /docker-entrypoint-initdb.d/
