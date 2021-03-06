#!/bin/bash

CONTAINER_NAME=images-server1
SERVICE_NAME=images-static-service

docker run --name $CONTAINER_NAME -d nginx

# detect container ip address
IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER_NAME`
echo Assigned $IP

# nginx-static-service /images > /
curl --request PUT --data '[
  {"KV":{"Verb":"set","Key":"dev/services/'$SERVICE_NAME'/publicPath","Value":"L2ltYWdlcw=="}},
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
  "Port": 80,
  "Meta": {
    "nginx": "1.15.8"
  },
  "EnableTagOverride": true}' http://127.0.0.1:8500/v1/agent/service/register

