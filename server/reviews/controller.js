const pool = require('../db');
const queries = require('./queries');
const getReviews = (req, res) => { //todo get 10 reviews
  pool.query(queries.getReviews, (error, results)=>{
    if (error) throw error;

    res.status(200).json(results.rows); //array of objs
  })
}
const getReviewById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getReviewById, [id], (error, results) => {
    if (error) throw error;
    let resultObj = {product: id, page: 0, count: 5, results: results.rows[0].result}
    res.status(200).json(resultObj);
  })
}
const addReview = (req, res) => {
  //const id = parseInt(req.params.id);
  const {product_id, rating, summary, body, recommend, name, email, photos, characteristics	} = req.body;
  pool.query(queries.addReview, [product_id, rating, new Date().getTime(), summary, body, recommend, false, name, email, null, 0], (error, results)=>{
    if (error) throw error;
    res.status(201).send('Reivew Created')
  })
}
const markHelpful = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.markHelpful, [id], (error, results) => {
    if (error) throw error;
    res.status(204).send();
  })
}
const markReport = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.markReport, [id], (error, results) => {
    if (error) throw error;
    res.status(204).send();
  })
}
const getMeta = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getMeta, [id], (error, results) => {
    if (error) throw error
    let resultobj = {product_id: id, ...results.rows[0].jsonb_build_object}
    res.status(200).send(resultobj);
  })
}
module.exports = {
  getReviews,
  getReviewById,
  addReview,
  markHelpful,
  markReport,
  getMeta
}