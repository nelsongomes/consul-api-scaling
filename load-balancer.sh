#!/bin/bash

LOCALPATH=/Users/ngomes/git/consul-api-scaling

docker run --name load-balancer -p 80:80     \
    -v $LOCALPATH/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v $LOCALPATH/nginx/conf.d/default.conf:/etc/nginx/conf.d/default.conf:ro \
    -v $LOCALPATH/nginx/nginx-upstreams.conf:/etc/nginx/nginx-upstreams.conf:ro \
    nginx

