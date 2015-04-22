default['haproxy']['cfg_source'] = 'haproxy/haproxy.cfg.erb'
default['haproxy']['cfg_cookbook'] = 'alfresco'

default['haproxy']['hostname'] = node['hostname'] ? node['hostname'] : 'localhost'
default['haproxy']['domain'] = node['domain'] ? node['domain'] : 'localdomain'

default['haproxy']['ssl_pem_crt_file'] = "/etc/haproxy/haproxy.pem"
default['haproxy']['ssl_pem_crt_databag'] = "ssl"
default['haproxy']['ssl_pem_crt_databag_item'] = "haproxy"

default['haproxy']['error_folder'] = "/var/www/html/errors"
default['haproxy']['error_file_cookbook'] = "alfresco"
default['haproxy']['error_file_source'] = "haproxy/errors"

default['haproxy']['config'] = [
  "global",
  "log 127.0.0.1 local2 info",
  "pidfile /var/run/haproxy.pid",
  "stats socket /var/run/haproxy.stat user nagios group nagios mode 600 level admin",
  "user haproxy",
  "group haproxy",
  "defaults",
  "mode http",
  "log global",
  "retries 3",
  "# Front end for http to https redirect",
  "frontend http",
  "bind *:80",
  "default_backend share",
  "redirect location https://#{node['haproxy']['hostname']}.#{node['haproxy']['domain']}/share/",
  "frontend https",
  "bind *:8443 ssl crt #{node['haproxy']['ssl_pem_crt_file']}",
  "capture request header X-Forwarded-For len 64",
  "capture request header User-agent len 256",
  "capture request header Cookie len 64",
  "capture request header Accept-Language len 64",
  "frontend nginx",
  "bind 127.0.0.1:81",
  "capture request header X-Forwarded-For len 64",
  "capture request header User-agent len 256",
  "capture request header Cookie len 64",
  "capture request header Accept-Language len 64",
  "server localhost 127.0.0.1:8070 weight 1 maxconn 100 check",
  "server localhost 127.0.0.1:8080 weight 1 maxconn 100 check",
  "server localhost 127.0.0.1:8090 weight 1 maxconn 100 check"]
