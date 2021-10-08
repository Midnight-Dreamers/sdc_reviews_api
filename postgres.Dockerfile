FROM postgres:latest

RUN mkdir /seed/
COPY ./csv/*.csv /seed/

RUN chmod a+rx /seed

COPY ./database/*.sql /docker-entrypoint-initdb.d