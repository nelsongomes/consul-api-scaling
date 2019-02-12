#!/bin/bash

LOCALPATH=/Users/ngomes/git/consul-api

docker run --name load-balancer -p 8080:80 -v $LOCALPATH/nginx/nginx.conf:/etc/nginx/nginx.conf:ro nginx

curl --request PUT --data '[{
    "KV":{"Verb":"set","Key":"dev/services/nginx-static-service/path","Value":"L3N0YXRpYw=="}
}]' http://127.0.0.1:8500/v1/txn

curl --request PUT --data '{
  "ID": "nginx-demo1",
  "Name": "nginx-static-service",
  "Tags": [
    "public-route",
    "nginx"
  ],
  "Address": "127.0.0.1",
  "Port": 8080,
  "Meta": {
    "nginx": "1.15.8"
  },
  "EnableTagOverride": true}' http://127.0.0.1:8500/v1/agent/service/register

  