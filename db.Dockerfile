FROM postgres:11

COPY ./db/is2-postgres-create.sql /docker-entrypoint-initdb.d/
COPY ./db/is2-init.sql /docker-entrypoint-initdb.d/
COPY ./db/is2-relais.sql /docker-entrypoint-initdb.d/