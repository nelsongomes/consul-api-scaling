#!/bin/bash

LOCALPATH=/Users/ngomes/git/consul-api-scaling

docker run --name load-balancer -p 8080:80 -v $LOCALPATH/nginx/nginx.conf:/etc/nginx/nginx.conf:ro nginx

