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






/* ALTER Table reviews ADD INDEX in_reviews(id);
ALTER Table reviews_photos ADD INDEX in_reviews_photos(id);
ALTER Table characteristics ADD INDEX in_characteristics(id);
ALTER Table characteristic_reviews ADD INDEX in_characteristics_reviews(id); */