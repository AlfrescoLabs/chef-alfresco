default['hosts']['hostname'] = node['hostname'] ? node['hostname'] : 'localhost'
default['hosts']['domain'] = node['domain'] ? node['domain'] : 'localdomain'

# Nginx settings
default['nginx']['cfg_source'] = 'nginx/nginx.conf.erb'
default['nginx']['cfg_cookbook'] = 'alfresco'

default['nginx']['service_actions'] = [:enable,:start]

default['nginx']['dns_server'] = "localhost"

default['nginx']['resolver'] = "8.8.4.4 8.8.8.8"

default['nginx']['port'] = "80"

#TODO - take it from haproxy conf
default['nginx']['proxy_port'] = "9000"

#TODO - add SSL conf if databag is found

default['nginx']['config'] = [
"user  nobody;",
"worker_processes  2;",
"events {",
"    worker_connections  1024;",
"}",
"http {",
"    include       mime.types;",
"    default_type  application/octet-stream;",
"    log_format  main  '$remote_addr - $remote_user [$time_local] \"$request\" '",
"                      '$status $body_bytes_sent \"$http_referer\" '",
"                      '\"$http_user_agent\" \"$http_x_forwarded_for\"';",
"    client_max_body_size      0; # Allow upload of unlimited size",
"    proxy_read_timeout        600s;",
"    keepalive_timeout         120;",
"    ignore_invalid_headers    on;",
"    keepalive_requests        50;  # number of requests per connection, does not affect SPDY",
"    keepalive_disable         none; # allow all browsers to use keepalive connections",
"    max_ranges                0;   # disabled to stop range header DoS attacks",
"    msie_padding              off;",
"    output_buffers            1 512;",
"    reset_timedout_connection on;  # reset timed out connections freeing ram",
"    sendfile                  on;  # on for decent direct disk I/O",
"    server_tokens             off; # version number in error pages",
"    server_name_in_redirect   off; # if off, nginx will use the requested Host header",
"    tcp_nodelay               on; # Nagle buffering algorithm, used for keepalive only",
"    tcp_nopush                on; # send headers in one peace, its better then sending them one by one",
"    resolver #{node['nginx']['dns_server']}; # use our dns server for any dns resolution.",
"    resolver_timeout 5s;",
"    gzip  on;",
"    gzip_http_version 1.1;",
"    gzip_vary on;",
"    gzip_comp_level 6;",
"    gzip_proxied any;",
"    gzip_buffers 16 8k;",
"    gzip_disable \"MSIE [1-6]\\.(?!.*SV1)\";",
"    # Turn on gzip for all content types that should benefit from it.",
"    gzip_types text/plain text/css text/javascript application/x-javascript application/javascript application/ecmascript application/rss+xml application/atomsvc+xml application/atom+xml application/cmisquery+xml application/cmisallowableactions+xml application/cmisatom+xml application/cmistree+xml application/cmisacl+xml application/msword application/vnd.ms-excel application/vnd.ms-powerpoint application/json;",
"server {",
"    listen #{node['nginx']['port']} spdy;",
"    server_name #{node['hosts']['hostname']}.#{node['hosts']['domain']};",
"    resolver #{node['nginx']['resolver']} valid=300s; # Configures name servers used to resolve names of upstream servers into addresses",
"    resolver_timeout 10s;",
"    # Tell the browser we do SPDY",
"    add_header Alternate-Protocol #{node['nginx']['port']}:npn-spdy/3;",
"    spdy_keepalive_timeout 128s; # inactivity timeout after which the SPDY connection is closed",
"    spdy_recv_timeout        5s; # timeout if nginx is currently expecting data from the client but nothing arrives",
"    access_log  /var/log/nginx/host.access.log main buffer=32k;",
"    port_in_redirect off;",
"    server_name_in_redirect off;",
"    error_page  403  http://#{node['hosts']['hostname']}.#{node['hosts']['domain']}/share/;",
"    #error_page 403 /errors/403.html;",
"    error_page 404 /errors/404.html;",
"    error_page 405 /errors/405.html;",
"    error_page 500 /errors/500.html;",
"    error_page 501 /errors/501.html;",
"    error_page 502 /errors/502.html;",
"    error_page 503 /errors/503.html;",
"    error_page 504 /errors/504.html;",
"    location ^~ /errors/ {",
"        internal;",
"        root /var/www/html;",
"    }",
"    # mitigation for nginx security advisory (CVE-2013-4547)",
"    if ($request_uri ~ \" \") {",
"        return 444;",
"    }",
"    location / {",
"        #limit_req   zone=gulag burst=1000; # nodelay; - nodelay to give 503 error straight away",
"        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;",
"        #proxy_redirect off;",
"        #proxy_buffering on;",
"        proxy_set_header        Host            $host;",
"        proxy_set_header        X-Real-IP       $remote_addr;",
"        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;",
"        proxy_set_header        X-Forwarded-Proto $scheme;",
"        proxy_pass  http://localhost:#{node['nginx']['proxy_port']};",
"        proxy_max_temp_file_size 1M; # Set files larger than 1M to stream rather than cache",
"        }",
"    }",
"}"]
