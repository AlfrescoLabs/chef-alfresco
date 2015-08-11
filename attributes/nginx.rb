# Using 1.9 version
default['nginx']['upstream_repository'] = "http://nginx.org/packages/mainline/centos/#{node['platform_version'].to_i}/$basearch/"
# default['nginx']['upstream_repository'] = "http://nginx.org/packages/centos/#{node['platform_version'].to_i}/$basearch/"

default['nginx']['conf_template'] = 'nginx/nginx.conf.erb'
default['nginx']['conf_cookbook'] = 'alfresco'

default['nginx']['service_actions'] = [:enable,:start]

default['nginx']['dns_server'] = "localhost"

default['nginx']['resolver'] = "8.8.4.4 8.8.8.8"

default['nginx']['port'] = "80"

default['nginx']['proxy_port'] = "9000"

default['nginx']['proxy_set_header_port'] = "80"

# TODO - this needs to be fixed, as node[''] items in this entry cannot be
# overridden by default[] wrapping cookbooks (see CHEF-ATTRIBUTES.md, rule 3)
#
# As a workaround, you must override the entire default['nginx']['config'] attribute
#
default['nginx']['config'] = [
  "user  nobody;",
  "worker_processes  2;",
  "events {",
  "    worker_connections  1024;",
  "}",
  "http {",
  "    sendfile on;",
  "    tcp_nopush on;",
  "    tcp_nodelay on;",
  "    keepalive_timeout 65;",
  "    types_hash_max_size 2048;",
  "    include /etc/nginx/mime.types;",
  "    default_type application/octet-stream;",
  "    access_log /var/log/nginx/access.log;",
  "    error_log /var/log/nginx/error.log;",
  "    gzip on;",
  "    gzip_disable \"msie6\";",
  "    server {",
  "        listen #{node['nginx']['port']} default_server;",
  "        listen [::]:80 default_server;",
  "        server_name #{node['alfresco']['default_hostname']};",
  "        location / {",
  "            proxy_set_header Host $host:#{node['nginx']['proxy_set_header_port']};",
  "            proxy_pass http://localhost:#{node['nginx']['proxy_port']};",
  "        }",
  "    }",
  "}"]

# Rsyslog defaults are only used if component includes "rsyslog"
default['rsyslog']['file_inputs']['nginx']['file'] = '/var/log/nginx/error.log'
default['rsyslog']['file_inputs']['nginx']['severity'] = 'error'
default['rsyslog']['file_inputs']['nginx']['priority'] = 56
