import http from 'k6/http';
import { sleep } from 'k6';

/*  export let options = {
  vus: 500,
  duration: '20s',
}; */
export let options = {
  stages: [

    {duration: '20s', target: 100},
    {duration: '50s', target: 100},
    {duration: '20s', target: 200},
    {duration: '50s', target: 200},
    {duration: '20s', target: 300},
    {duration: '50s', target: 300},
    {duration: '20s', target: 400},
    {duration: '50s', target: 400},
    {duration: '100s', target: 0},

  ],
}

export default function() {
  const BASE_URL = 'http://localhost:3000/reviews'
   http.batch([
    ['GET', `${BASE_URL}/meta/4`],
    //['GET', `${BASE_URL}/4`],
  ]);
  //http.get(`${BASE_URL}/meta/4`)
  sleep(1);
}

