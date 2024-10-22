#!/bin/bash

wget https://github.com/docker/getting-started/archive/refs/heads/master.zip

apt-get install unzip
unzip master.zip -d master

cd app

echo "FROM node:20-alpine" > Dockerfile
echo "RUN apk add --no-cache python3 g++ make" >> Dockerfile
echo "WORKDIR /app" >> Dockerfile
echo "COPY . ." >> Dockerfile
echo "RUN yarn install --production" >> Dockerfile
echo 'CMD ["node", "/app/src/index.js"]' >> Dockerfile

docker build -t todo .
docker run -dp 5000:5000 todo
