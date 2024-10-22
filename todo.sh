#!/bin/bash

if ! command -v wget &> /dev/null; then
  echo "wget could not be found, installing..."
  apt-get update && apt-get install -y wget
fi
wget https://github.com/docker/getting-started/archive/refs/heads/master.zip

if ! command -v unzip &> /dev/null; then
  echo "unzip could not be found, installing..."
  apt-get update && apt-get install -y unzip
fi

unzip master.zip -d master

if [ ! -d "app" ]; then
  echo "'app' directory does not exist, ensure the unzipped structure is correct"
  exit 1
fi

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

docker run -dp 5000:5000 todo
