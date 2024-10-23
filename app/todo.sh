#!/bin/bash

touch todo/app/Dockerfile

cat > todo/app/Dockerfile << _EOF_
FROM node:20-alpine
RUN apk add --no-cache python3 g++ make
WORKDIR /app
COPY  . .
RUN yarn install --production
CMD ["node", "/app/src/index.js"]
_EOF_

cd todo/app

docker build -t todo .

function is_port_in_use {
  lsof -i :$1 &> /dev/null
  return $?
}

PORT=2000
while is_port_in_use $PORT; do
  echo "Port $PORT is in use, trying next port..."
  PORT=$((PORT + 1))
done

echo "The used port is $PORT"

docker run -t -d -p $PORT:$PORT --name todo todoapp

docker ps -a
