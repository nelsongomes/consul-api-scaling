#!/bin/bash

CONTAINER_NAME=microservice1
SERVICE_NAME=hello-service

docker run --name $CONTAINER_NAME -d simple-hello-app

# detect container ip address
IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER_NAME`
echo Assigned $IP

# nginx-static-service /images > /
curl --request PUT --data '[
  {"KV":{"Verb":"set","Key":"dev/services/'$SERVICE_NAME'/publicPath","Value":"L2hlbGxv"}},
  {"KV":{"Verb":"set","Key":"dev/services/'$SERVICE_NAME'/routedPath","Value":"Lw=="}}
]' http://127.0.0.1:8500/v1/txn

curl --request PUT --data '{
  "ID": "'$CONTAINER_NAME'",
  "Name": "'$SERVICE_NAME'",
  "Tags": [
    "public-route",
    "nginx"
  ],
  "Address": "'$IP'",
  "Port": 8080,
  "Meta": {
    "nginx": "1.15.8"
  },
  "EnableTagOverride": true}' http://127.0.0.1:8500/v1/agent/service/register

