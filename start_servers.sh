#!/bin/bash

cd server
rails server &

cd ../client
npm run start &

cd ../services/simulatorservice
npm run start
