const Pool = require('pg').Pool

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'ratesreviews',
  password: 'gaoyf2020',
  port: 5432,
})

module.exports = pool;