const get10Reviews = "SELECT * FROM reviews LIMIT 10";
const getReviewPhotos = "SELECT * FROM reviews_photos WHERE review_id = $1" ;
const getReviewById =
`SELECT array(
  SELECT jsonb_build_object(
    'review_id', id,
    'rating', rating,
    'summary', summary,
    'recommend', recommend,
    'response', response,
    'body', body,
    'date', TO_CHAR(TO_TIMESTAMP(date/1000) AT TIME ZONE 'utc', 'YYYY-MM-DDFMTHH:MI:SS.MSZ'),
    'reviewer_name', reviewer_name,
    'helpfulness', helpfulness,
    'photos', (SELECT array(
      (SELECT jsonb_build_object(
        'id', id,
        'url', url
      ) FROM reviews_photos WHERE review_id = reviews.id)
    ))
    ) FROM reviews WHERE product_id = $1
) as result`
const addReview = `with updated as
(
  INSERT INTO reviews (product_id, rating, date, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
) SELECT setval('reviews_id_seq', (SELECT MAX(id) from reviews))`;

const markHelpful = `UPDATE reviews SET helpfulness = helpfulness + 1 WHERE id = $1`
const markReport = `UPDATE reviews SET reported = true WHERE id = $1`

const getMeta = `SELECT jsonb_build_object(
  'rating', (SELECT jsonb_build_object(
    '1', (SELECT count(*) FROM reviews where product_id = $1 and rating = 1),
    '2', (SELECT count(*) FROM reviews where product_id = $1 and rating = 2),
    '3', (SELECT count(*) FROM reviews where product_id = $1 and rating = 3),
    '4', (SELECT count(*) FROM reviews where product_id = $1 and rating = 4),
    '5', (SELECT count(*) FROM reviews where product_id = $1 and rating = 5)
  )),
  'recommend', (jsonb_build_object(
    '0', (SELECT count(recommend) FROM reviews where product_id = $1 and recommend = true),
    '1', (SELECT count(recommend) FROM reviews where product_id = $1 and recommend = false)
  )),
  'characteristics', (
    SELECT (
      json_object_agg(
        name, json_build_object(
          'id', id,
          'value', avg
        )
      )
    )
    FROM (select char.name, char.id, avg(charreview.value) from characteristics as char inner join characteristic_reviews as charreview on char.id = charreview.characteristic_id where char.product_id = $1 group by char.id) as ntable
  )
) FROM reviews WHERE product_id = $1`;


module.exports = {
  get10Reviews, getReviewById, getReviewPhotos, addReview, markHelpful, markReport, getMeta
}



/*'rating', (SELECT jsonb_build_object(
    '1', (SELECT count(*) FROM reviews where product_id = $1 and rating = 1),
    '2', (SELECT count(*) FROM reviews where product_id = $1 and rating = 2),
    '3', (SELECT count(*) FROM reviews where product_id = $1 and rating = 3),
    '4', (SELECT count(*) FROM reviews where product_id = $1 and rating = 4),
    '5', (SELECT count(*) FROM reviews where product_id = $1 and rating = 5)
  )),
  'recommend', (jsonb_build_object(
    '0', (SELECT count(recommend) FROM reviews where product_id = $1 and recommend = true),
    '1', (SELECT count(recommend) FROM reviews where product_id = $1 and recommend = false)
  )), */

  //--------------------initial characterisitics-----//
  /* 'characteristics', (
    SELECT (
      json_object_agg(
        name, json_build_object(
          'id', id,
          'value', val
        )
      )
    )
    FROM (select chara.id,  chara.name, char_review.val from (select a.id, a.name from characteristics as a where a.product_id = $1) as chara INNER JOIN (select characteristic_id, ROUND(AVG(value)) as val from characteristic_reviews  group by characteristic_id) as char_review ON chara.id = char_review.characteristic_id) as ntable
  ) */


  //--------------------improved characteristics----//
  /* 'characteristics', (
    SELECT (
      json_object_agg(
        name, json_build_object(
          'id', id,
          'value', avg
        )
      )
    )
    FROM (select char.name, char.id, avg(charreview.value) from characteristics as char inner join characteristic_reviews as charreview on char.id = charreview.characteristic_id where char.product_id = $1 group by char.id) as ntable
  ) */