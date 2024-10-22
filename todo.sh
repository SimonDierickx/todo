#!/bin/bash

sudo wget https://github.com/docker/getting-started/archive/refs/heads/master.zip

sudo apt-get install unzip
unzip master.zip -d master

cd app

sudo echo "FROM node:20-alpine" > Dockerfile
sudo echo "RUN apk add --no-cache python3 g++ make" >> Dockerfile
sudo echo "WORKDIR /app" >> Dockerfile
sudo echo "COPY . ." >> Dockerfile
sudo echo "RUN yarn install --production" >> Dockerfile
sudo echo 'CMD ["node", "/app/src/index.js"]' >> Dockerfile

docker build -t todo .
docker run -dp 5000:5000 todo
