#!/bin/bash

# create a 256 IP network
SUBNET=172.16.16.0/24

docker network create --driver=bridge --subnet=$SUBNET br0
