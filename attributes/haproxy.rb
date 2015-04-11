default['haproxy']['listeners']['frontend']['http'] = [
  "maxconn 2000",
  "bind 0.0.0.0:80",
  "default_backend share"
]

default['haproxy']['repo'] = ["server localhost 127.0.0.1:8070 weight 1 maxconn 100 check"]
default['haproxy']['share'] = ["server localhost 127.0.0.1:8080 weight 1 maxconn 100 check"]
default['haproxy']['solr'] = ["server localhost 127.0.0.1:8090 weight 1 maxconn 100 check"]

default['haproxy']['listeners']['frontend']['http'] = [
  "maxconn 2000",
  "bind 0.0.0.0:80",
  "default_backend share"
]

default['haproxy']['enable_default_http'] = false
default['haproxy']['members'] = []
