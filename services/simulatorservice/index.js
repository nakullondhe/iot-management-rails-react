require('dotenv').config();
const express = require('express');
const app = express();
require('./mqtt')

app.listen(8000, () =>{
  console.log("Server Started");
})