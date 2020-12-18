FROM postgres

COPY ./db/is2-create-postgres.sql /docker-entrypoint-initdb.d/is2-1-create-postgres.sql 
COPY ./db/is2-init.sql /docker-entrypoint-initdb.d/is2-2-init.sql
COPY ./db/is2-relais.sql /docker-entrypoint-initdb.d/is2-3-relais.sql
COPY ./db/is2-arc.sql /docker-entrypoint-initdb.d/is2-4-arc.sql