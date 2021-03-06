CREATE DATABASE sdc;

\c sdc;


DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS reviews_photos CASCADE;
DROP TABLE IF EXISTS characteristics CASCADE;
DROP TABLE IF EXISTS characteristic_reviews CASCADE;

/* create table product (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  slogan VARCHAR(100) NOT NULL,
  description VARCHAR(200) NOT NULL,
  category VARCHAR(50) NOT NULL,
  price NUMERIC(15,2) NOT NULL
) */

create table reviews (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  product_id BIGINT NOT NULL,/*
  FOREIGN KEY(product_id) REFERENCES product(id), */
  rating SMALLINT NOT NULL,
  date BIGINT NOT NULL,
  summary VARCHAR(200) NOT NULL,
  body VARCHAR(1000) NOT NULL,
  recommend BOOLEAN NOT NULL,
  reported BOOLEAN DEFAULT FALSE,
  reviewer_name VARCHAR(60) NOT NULL,
  reviewer_email VARCHAR(80) NOT NULL,
  response VARCHAR(200),
  helpfulness SMALLINT DEFAULT 0
);

create table reviews_photos (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  review_id BIGINT NOT NULL,
  FOREIGN KEY(review_id) REFERENCES reviews(id),
  url VARCHAR(2083)
);

create table characteristics (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  product_id BIGINT NOT NULL,/*
  FOREIGN KEY(product_id) REFERENCES product(id), */
  name VARCHAR(10)

);

create table characteristic_reviews (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  characteristic_id BIGINT NOT NULL,
  FOREIGN KEY(characteristic_id) REFERENCES characteristics(id),
  review_id BIGINT NOT NULL,
  FOREIGN KEY(review_id) REFERENCES reviews(id),
  value SMALLINT

);

COPY reviews from '/seed/reviews.csv' DELIMITER ',' CSV HEADER;
COPY reviews_photos from '/seed/reviews_photos.csv' DELIMITER ',' CSV HEADER;
COPY characteristics from '/seed/characteristics.csv' DELIMITER ',' CSV HEADER;
COPY characteristic_reviews from '/seed/characteristic_reviews.csv' DELIMITER ',' CSV HEADER;


DROP INDEX IF EXISTS in_reviews ;
DROP INDEX IF EXISTS in_reviews_photos ;
DROP INDEX IF EXISTS in_reviews_id ;
DROP INDEX IF EXISTS in_characteristics ;
DROP INDEX IF EXISTS in_characteristics_reviews ;/*
DROP INDEX IF EXISTS in_characteristics_reviews_id ; */
DROP INDEX IF EXISTS in_characteristics_reviews_rid ;



CREATE INDEX in_reviews ON reviews (product_id);
CREATE INDEX in_reviews_id ON reviews (id);
CREATE INDEX in_reviews_photos ON reviews_photos (review_id);
CREATE INDEX in_characteristics ON characteristics (product_id);

CREATE INDEX in_characteristics_reviews ON characteristic_reviews (characteristic_id);

/* CREATE INDEX in_characteristics_reviews_id ON characteristic_reviews (id); */

CREATE INDEX in_characteristics_reviews_rid ON characteristic_reviews (review_id);