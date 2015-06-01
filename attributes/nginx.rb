# Nginx settings
default['nginx']['conf_template'] = 'nginx/nginx.conf.erb'
default['nginx']['conf_cookbook'] = 'alfresco'

default['nginx']['service_actions'] = [:enable,:start]

default['nginx']['dns_server'] = "localhost"

default['nginx']['resolver'] = "8.8.4.4 8.8.8.8"

default['nginx']['port'] = "80"

#TODO - take it from haproxy conf
default['nginx']['proxy_port'] = "9000"

#TODO - add SSL conf if databag is found

default['nginx']['proxy_set_header_port'] = node['nginx']['port']

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
  "        server_name #{node['hosts']['hostname']}.#{node['hosts']['domain']};",
  "        location / {",
  "            proxy_set_header Host $host:#{node['nginx']['proxy_set_header_port']};",
  "            proxy_pass http://localhost:#{node['nginx']['proxy_port']};",
  "        }",
  "    }",
  "}"]
