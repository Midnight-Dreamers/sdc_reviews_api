const Pool = require('pg').Pool

const pool = new Pool({
  user: 'postgres',
  host: 'sdc-postgres', //the container name inside the postgres.dockerfile
  database: 'sdc', //
  password: 'gaoyf2020',
  port: 5432,
})

module.exports = pool;