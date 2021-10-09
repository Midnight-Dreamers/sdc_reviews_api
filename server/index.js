const express = require('express')
const app = express();
const port = 3001;
const reviewsRoutes = require('./reviews/routes')

app.use(express.json());
app.get('/', (req, res)=>{
  res.send('Hello World!');
})

app.use("/reviews", reviewsRoutes);

app.listen(port, ()=>{
  console.log(`app is listening on port ${port}`)
})