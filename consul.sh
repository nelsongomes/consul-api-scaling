#!/bin/bash

docker run --rm --name=consul-server -p 8500:8500 -p 8300:8300 -p 53:53 \
	--privileged -e 'CONSUL_ALLOW_PRIVILEGED_PORTS=' consul agent -dev -ui \
	-client=0.0.0.0 -dns-port=53 -recursor=8.8.8.8
