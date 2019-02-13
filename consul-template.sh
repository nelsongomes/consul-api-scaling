#!/bin/bash

export ENVIRONMENT=dev

#consul-template -config consul-template/config.hcl -once

# run consul-template in background
consul-template -config consul-template/config.hcl &