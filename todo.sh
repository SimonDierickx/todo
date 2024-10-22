#!/bin/bash

unzip master.zip -d master
cd app

echo "FROM node:20-alpine" > Dockerfile
echo "RUN apk add --no-cache python3 g++ make" >> Dockerfile
echo "WORKDIR /app" >> Dockerfile
echo "COPY . ." >> Dockerfile
echo "RUN yarn install --production" >> Dockerfile
echo 'CMD ["node", "/app/src/index.js"]' >> Dockerfile

docker build -t todo .

function is_port_in_use {
  lsof -i :$1 &> /dev/null
  return $?
}

PORT=5000
while is_port_in_use $PORT; do
  echo "Port $PORT is in use, trying next port..."
  PORT=$((PORT + 1))
done

echo "The used port is $PORT"

docker run -dp 5000:5000 todo
