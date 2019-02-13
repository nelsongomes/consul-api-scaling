consul {
    address = "localhost:8500"
    retry {
        enabled = true
        attempts = 12
        backoff = "250ms"
    }
    # token = "some token"
}

reload_signal = "SIGHUP"
kill_signal = "SIGINT"
max_stale = "10m"

log_level = "warn"

# pid_file = "/consul-template/consul-template.pid"

wait {
    min = "5s"
    max = "10s"
}

#vault {
#    address = "http://localhost:8200"
#    token = "some token"
#    renew_token = false
#}

deduplicate {
    enabled = true
    prefix = "consul-template/dedup/"
}

# route definitions for all services
template {
    source      = "./consul-template/nginx-locations.ctmpl"
    destination = "./nginx/conf.d/default.conf"

    perms = 0400
    left_delimiter  = "{{"
    right_delimiter = "}}"
    wait {
          min = "5s"
          max = "15s"
    }

    command = "docker exec load-balancer /etc/init.d/nginx reload"
    command_timeout = "60s"
}

# service instances available
template {
    source      = "./consul-template/nginx-upstreams.ctmpl"
    destination = "./nginx/nginx-upstreams.conf"

    perms = 0400
    left_delimiter  = "{{"
    right_delimiter = "}}"
    wait {
          min = "5s"
          max = "15s"
    }

    command = "docker exec load-balancer /etc/init.d/nginx reload"
    command_timeout = "60s"
}