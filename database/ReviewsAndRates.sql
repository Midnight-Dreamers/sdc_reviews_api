
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

COPY reviews from '/home/gaoy11/hackreactor/hr-den14-sdc_review/sdc_reviews_api/csv/reviews.csv' DELIMITER ',' CSV HEADER;
COPY reviews_photos from '/home/gaoy11/hackreactor/hr-den14-sdc_review/sdc_reviews_api/csv/reviews_photos.csv' DELIMITER ',' CSV HEADER;
COPY characteristics from '/home/gaoy11/hackreactor/hr-den14-sdc_review/sdc_reviews_api/csv/characteristics.csv' DELIMITER ',' CSV HEADER;
COPY characteristic_reviews from '/home/gaoy11/hackreactor/hr-den14-sdc_review/sdc_reviews_api/csv/characteristic_reviews.csv' DELIMITER ',' CSV HEADER;
