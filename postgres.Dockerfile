FROM postgres:latest

RUN mkdir /seed/
COPY ./csv/*.csv /seed/

RUN chmod a+rx /seed

COPY ./database/ReviewsAndRates.sql /docker-entrypoint-initdb.d