# Using 1.9 version
default['nginx']['upstream_repository'] = "http://nginx.org/packages/mainline/centos/#{node['platform_version'].to_i}/$basearch/"
# default['nginx']['upstream_repository'] = "http://nginx.org/packages/centos/#{node['platform_version'].to_i}/$basearch/"

default['nginx']['use_nossl_config'] = false

default['nginx']['conf_template'] = 'nginx/nginx.conf.erb'
default['nginx']['conf_cookbook'] = 'alfresco'

default['nginx']['disable_nginx_init'] = false
default['nginx']['service_actions'] = [:enable,:start]

default['nginx']['dns_server'] = "localhost"

default['nginx']['resolver'] = "8.8.4.4 8.8.8.8"

default['nginx']['port'] = node['alfresco']['public_port']
default['nginx']['portssl'] = node['alfresco']['public_portssl']
default['nginx']['status_port'] = 2100

default['nginx']['proxy_port'] = node['alfresco']['internal_port']

# Overridden by kitchen to $host:8800
default['nginx']['proxy_host_header'] = "$host"

# Used to add ssl or any other file related with nginx configuration
default['nginx']['ssl_folder'] = "/etc/pki/tls/certs"
default['nginx']['ssl_folder_source'] = "nginx_ssl"
default['nginx']['ssl_folder_cookbook'] = "alfresco"

default['nginx']['ssl_certificate'] = "#{node['alfresco']['certs']['ssl_folder']}/#{node['alfresco']['certs']['filename']}.nginxcrt"
default['nginx']['ssl_certificate_key'] = "#{node['alfresco']['certs']['ssl_folder']}/#{node['alfresco']['certs']['filename']}.key"
default['nginx']['dhparam_pem'] = "#{node['alfresco']['certs']['ssl_folder']}/#{node['alfresco']['certs']['filename']}.dhparam"
default['nginx']['trusted_certificate'] = "#{node['alfresco']['certs']['ssl_folder']}/#{node['alfresco']['certs']['filename']}.chain"

default['nginx']['ssl_trusted_certificate_entry'] = "    ssl_trusted_certificate #{node['nginx']['trusted_certificate']};"
default['nginx']['dh_param_entry'] = "    ssl_dhparam #{node['nginx']['dhparam_pem']};"

# default['nginx']['status_url_ip_allows'] = "      allow 127.0.0.1"

default['nginx']['logging'] =   "    log_format  main  '$remote_addr - $remote_user [$time_local] \"$request\" ' '$status $body_bytes_sent \"$http_referer\" ' '\"$http_user_agent\" \"$http_x_forwarded_for\" \"$gzip_ratio\"';"
default['nginx']['logging_json'] =   " log_format main '{ \"@timestamp\": \"$time_iso8601\", \"@fields\": { \"remote_addr\": \"$remote_addr\", \"remote_user\": \"$remote_user\", \"x_forwarded_for\": \"$http_x_forwarded_for\", \"proxy_protocol_addr\": \"$proxy_protocol_addr\", \"body_bytes_sent\": \"$body_bytes_sent\", \"request_time\": \"$request_time\", \"body_bytes_sent\":\"$body_bytes_sent\", \"bytes_sent\":\"$bytes_sent\", \"status\": \"$status\", \"request\": \"$request\", \"request_method\": \"$request_method\", \"http_cookie\": \"$http_cookie\", \"http_referrer\": \"$http_referer\", \"http_user_agent\": \"$http_user_agent\" } }'; "


default['nginx']['logging_json_enabled'] = false

default['nginx']['config'] = [
  "user  nobody;",
  "worker_processes  2;",
  "events {",
  "    worker_connections  1024;",
  "}",
  "http {",
  "    include       mime.types;",
  "    default_type  application/octet-stream;",
  node['nginx']['logging_json'],
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
  "    tcp_nodelay               on; # Nagle buffering algorithm, used for keepalive only",
  "    tcp_nopush                on; # send headers in one peace, its better then sending them one by one",
  "    resolver #{node['nginx']['dns_server']} valid=300s;",
  "    resolver_timeout 10s;",
  "    access_log  /var/log/nginx/host.access.log main buffer=32k;",
  "    error_log  /var/log/nginx/error.log info;",
  "    port_in_redirect off;",
  "    server_name_in_redirect off;",
  "    error_page 403 /errors/403.html;",
  "    error_page 404 /errors/404.html;",
  "    error_page 405 /errors/405.html;",
  "    error_page 500 /errors/500.html;",
  "    error_page 501 /errors/501.html;",
  "    error_page 502 /errors/502.html;",
  "    error_page 503 /errors/503.html;",
  "    error_page 504 /errors/504.html;",
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
  "   listen          #{node['nginx']['status_port']};",
  "   location /nginx_status {",
  "      stub_status on;",
  "      access_log   off;",
  "        # Allow IP addresses",
  "        #{node['nginx']['status_url_ip_allows']}",
  "      deny all;",
  "   }",
  "}",
  "server {",
  "    listen          #{node['nginx']['port']};",
  "    server_name #{node['alfresco']['public_hostname']};",
  "    return         301 https://$server_name$request_uri;",
  "}",
  "server {",
  "    listen #{node['nginx']['portssl']} ssl http2;",
  "    server_name #{node['alfresco']['public_hostname']};",
  "    # SSL Configuration",
  "    ssl on;",
  "    ssl_certificate #{node['nginx']['ssl_certificate']};",
  "    ssl_certificate_key #{node['nginx']['ssl_certificate_key']};",
  node['nginx']['ssl_trusted_certificate_entry'],
  "    # enable ocsp stapling - http://en.wikipedia.org/wiki/OCSP_stapling",
  "    ssl_stapling on;",
  "    ssl_stapling_verify on;",
  "    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;",
  "    ssl_prefer_server_ciphers on;",
  "    # Use Intermediate Cipher Compatability from https://wiki.mozilla.org/Security/Server_Side_TLS#Intermediate_compatibility_.28default.29 ",
  "    ssl_ciphers  ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA;",
  node['nginx']['dh_param_entry'],
  "    # ssl cache:",
  "    ssl_session_cache shared:SSL:25m;",
  "    ssl_session_timeout 10m;",
  "    ssl_buffer_size 1400;",
  "    ssl_session_tickets off;",
  "    location ^~ /errors/ {",
  "        internal;",
  "        root #{node['alfresco']['errorpages']['error_folder']};",
  "    }",
  "    # mitigation for nginx security advisory (CVE-2013-4547)",
  "    if ($request_uri ~ \" \") {",
  "        return 444;",
  "    }",
  "    location / {",
  "        add_header Strict-Transport-Security \"max-age=31536000; includeSubdomains;\";",
  "        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;",
  "        proxy_redirect off;",
  "        proxy_set_header        Host            #{node['nginx']['proxy_host_header']};",
  "        proxy_set_header        X-Real-IP       $remote_addr;",
  "        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;",
  "        proxy_set_header        X-Forwarded-Proto $scheme;",
  "        proxy_pass  #{node['alfresco']['internal_protocol']}://#{node['alfresco']['internal_hostname']}:#{node['nginx']['proxy_port']};",
  "        proxy_max_temp_file_size 1M; # Set files larger than 1M to stream rather than cache",
  "    }",
  "}",
  "}"]

default['nginx']['nossl_config'] = [
  "user  nobody;",
  "worker_processes  2;",
  "events {",
  "    worker_connections  1024;",
  "}",
  "http {",
  "    include       mime.types;",
  "    default_type  application/octet-stream;",
  node['nginx']['logging'],
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
  "    tcp_nodelay               on; # Nagle buffering algorithm, used for keepalive only",
  "    tcp_nopush                on; # send headers in one peace, its better then sending them one by one",
  "    resolver #{node['nginx']['dns_server']} valid=300s;",
  "    resolver_timeout 10s;",
  "    access_log  /var/log/nginx/host.access.log main buffer=32k;",
  "    error_log  /var/log/nginx/error.log info;",
  "    port_in_redirect off;",
  "    server_name_in_redirect off;",
  "    error_page 403 /errors/403.html;",
  "    error_page 404 /errors/404.html;",
  "    error_page 405 /errors/405.html;",
  "    error_page 500 /errors/500.html;",
  "    error_page 501 /errors/501.html;",
  "    error_page 502 /errors/502.html;",
  "    error_page 503 /errors/503.html;",
  "    error_page 504 /errors/504.html;",
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
  "   listen          #{node['nginx']['status_port']};",
  "   location /nginx_status {",
  "      stub_status on;",
  "      access_log   off;",
  "        # Allow IP addresses",
  "        #{node['nginx']['status_url_ip_allows']}",
  "      deny all;",
  "   }",
  "}",
  "server {",
  "    listen          #{node['nginx']['port']};",
  "    server_name #{node['alfresco']['public_hostname']};",
  "    location ^~ /errors/ {",
  "        internal;",
  "        root #{node['alfresco']['errorpages']['error_folder']};",
  "    }",
  "    # mitigation for nginx security advisory (CVE-2013-4547)",
  "    if ($request_uri ~ \" \") {",
  "        return 444;",
  "    }",
  "    location / {",
  "        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;",
  "        proxy_redirect off;",
  "        proxy_set_header        Host            #{node['nginx']['proxy_host_header']};",
  "        proxy_set_header        X-Real-IP       $remote_addr;",
  "        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;",
  "        proxy_set_header        X-Forwarded-Proto $scheme;",
  "        proxy_pass  #{node['alfresco']['internal_protocol']}://#{node['alfresco']['internal_hostname']}:#{node['nginx']['proxy_port']};",
  "        proxy_max_temp_file_size 1M; # Set files larger than 1M to stream rather than cache",
  "    }",
  "}",
  "}"]
