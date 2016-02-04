# Chef community cookbook attributes
default['nginx']['upstream_repository'] = "http://nginx.org/packages/mainline/centos/#{node['platform_version'].to_i}/$basearch/"
default['nginx']['disable_nginx_init'] = false
default['nginx']['service_actions'] = [:enable,:start]
default['nginx']['conf_template'] = 'nginx/nginx.conf.erb'
default['nginx']['conf_cookbook'] = 'alfresco'

# Default Nginx parameters, inherited by Alfresco attributes
default['nginx']['port'] = node['alfresco']['public_port']
default['nginx']['proxy_port'] = node['alfresco']['internal_secure_port']
default['nginx']['ssl_port'] = node['alfresco']['public_portssl']
default['nginx']['public_hostname'] = node['alfresco']['public_hostname']
default['nginx']['proxy_hostname'] = node['alfresco']['internal_hostname']
default['nginx']['log_level'] = "info"

# Nginx configurations (used by nginx.cfg.erb)
default['nginx']['general']['user'] = "nobody"
default['nginx']['general']['worker_process'] = 2
default['nginx']['events']['worker_connections'] = 1024

default['nginx']['http']['include'] = "mime.types"
default['nginx']['http']['default_type'] = "application/octet-stream"
default['nginx']['http']['log_format'] = "main  '$remote_addr - $remote_user [$time_local] \"$request\" ' '$status $body_bytes_sent \"$http_referer\" ' '\"$http_user_agent\" \"$http_x_forwarded_for\" \"$gzip_ratio\"'"
default['nginx']['http']['client_body_buffer_size'] = "1000M"
default['nginx']['http']['proxy_read_timeout'] = "600s"
default['nginx']['http']['keepalive_timeout'] = "120"
default['nginx']['http']['ignore_invalid_headers'] = "on"
default['nginx']['http']['keepalive_requests'] = "50"
# Allow all browsers to use keepalive connections
default['nginx']['http']['keepalive_disable'] = "none"
# Disabled to stop range header DoS attacks",
default['nginx']['http']['max_ranges'] = 0
default['nginx']['http']['msie_padding'] = "off"
default['nginx']['http']['output_buffers'] = "1 512"
# Reset timed out connections freeing ram",
default['nginx']['http']['reset_timedout_connection'] = "on"
# on for decent direct disk I/O",
default['nginx']['http']['sendfile'] = "on"
# version number in error pages
default['nginx']['http']['server_tokens'] = "off"
# Nagle buffering algorithm, used for keepalive only
default['nginx']['http']['tcp_nodelay'] = "on"
# Send headers in one piece, its better then sending them one by one
default['nginx']['http']['tcp_nopush'] = "on"
default['nginx']['http']['resolver'] = "8.8.4.4 8.8.8.8 valid=300s"
default['nginx']['http']['resolver_timeout'] = "10s"
default['nginx']['http']['access_log'] = "/var/log/nginx/host.access.log main"
default['nginx']['http']['error_log'] = "/var/log/nginx/error.log #{node['nginx']['log_level']}"
default['nginx']['http']['port_in_redirect'] = "off"
default['nginx']['http']['server_name_in_redirect'] = "off"
default['nginx']['http']['error_pages'] = ["403 /errors/403.http","404 /errors/404.http","405 /errors/405.http","500 /errors/500.http","501 /errors/501.http","502 /errors/502.http","503 /errors/503.http","504 /errors/504.http"]
default['nginx']['http']['gzip'] = "on"
default['nginx']['http']['gzip_http_version'] = "1.1"
default['nginx']['http']['gzip_vary'] = "on"
default['nginx']['http']['gzip_comp_level'] = 6
default['nginx']['http']['gzip_proxied'] = "any"
default['nginx']['http']['gzip_buffers'] = "16 8k"
default['nginx']['http']['gzip_disable'] = "\"MSIE [1-6]\\.(?!.*SV1)\""
# Turn on gzip for all content types that should benefit from it.
default['nginx']['http']['gzip_types'] = "text/plain text/css text/javascript application/x-javascript application/javascript application/ecmascript application/rss+xml application/atomsvc+xml application/atom+xml application/cmisquery+xml application/cmisallowableactions+xml application/cmisatom+xml application/cmistree+xml application/cmisacl+xml application/msword application/vnd.ms-excel application/vnd.ms-powerpoint application/json"

default['nginx']['server']['status']['listen'] = "2100"
default['nginx']['server']['status']['locations']['/nginx_status']['stub_status'] = "on"
default['nginx']['server']['status']['locations']['/nginx_status']['access_log'] = "off"
default['nginx']['server']['status']['locations']['/nginx_status']['allow'] = "127.0.0.1"
default['nginx']['server']['status']['locations']['/nginx_status']['deny'] = "all"

default['nginx']['server']['proxy']['listen'] = node['nginx']['port']
default['nginx']['server']['proxy']['server_name'] = node['nginx']['proxy_hostname']

default['nginx']['server']['error']['locations']['^~ /var/www/html/errors/']['internal'] = true
default['nginx']['server']['error']['locations']['^~ /var/www/html/errors/']['root'] = node['alfresco']['errorpages']['error_folder']

default['nginx']['server']['error']['locations']['~ ^/(alfresco/s/enterprise/admin/admin-supporttools|alfresco/s/enterprise/admin/admin-outboundemail|alfresco/s/enterprise/admin/admin-clustering)']['deny'] = "all"

default['nginx']['server']['error']['locations']['/']['proxy_next_upstream'] = "error timeout invalid_header http_500 http_502 http_503 http_504"
default['nginx']['server']['error']['locations']['/']['proxy_redirect'] = "off"
default['nginx']['server']['error']['locations']['/']['proxy_http_version'] = "1.1"
default['nginx']['server']['error']['locations']['/']['proxy_set_headers'] = [
  "Host $host",
  "X-Real-IP $remote_addr",
  "X-Forwarded-For $proxy_add_x_forwarded_for",
  "X-Forwarded-Proto $scheme"
]
default['nginx']['server']['error']['locations']['/']['proxy_pass'] =  "#{node['alfresco']['internal_protocol']}://#{node['nginx']['proxy_hostname']}:#{node['nginx']['proxy_port']}"
# Set files larger than 1M to stream rather than cache
default['nginx']['server']['error']['locations']['/']['proxy_max_temp_file_size'] = "1M"

# SSL configurations
default['nginx']['ssl_enabled'] = true
default['nginx']['ssl_folder'] = node['alfresco']['certs']['ssl_folder']
default['nginx']['ssl_filename'] = node['alfresco']['certs']['filename']
default['nginx']['ssl_folder_source'] = "nginx_ssl"
default['nginx']['ssl_folder_cookbook'] = "alfresco"

default['nginx']['server']['proxy']['listen'] = "#{node['nginx']['ssl_port']} ssl http2"

default['nginx']['server']['redirect']['listen'] = node['nginx']['port']
default['nginx']['server']['redirect']['server_name'] = node['nginx']['public_hostname']
default['nginx']['server']['redirect']['add_header'] = "Strict-Transport-Security \"max-age=31536000; includeSubdomains;\""
default['nginx']['server']['redirect']['return'] = "301 https://$server_name$request_uri"

default['nginx']['server']['proxy']['add_header'] = "Strict-Transport-Security \"max-age=31536000; includeSubdomains;\""
default['nginx']['server']['proxy']['ssl'] = "on"
default['nginx']['server']['proxy']['ssl_certificate'] = "#{node['nginx']['ssl_folder']}/#{node['nginx']['ssl_filename']}.nginxcrt"
default['nginx']['server']['proxy']['ssl_certificate_key'] = "#{node['nginx']['ssl_folder']}/#{node['nginx']['ssl_filename']}.key"
default['nginx']['server']['proxy']['ssl_trusted_certificate'] = "#{node['nginx']['ssl_folder']}/#{node['nginx']['ssl_filename']}.chain"

# Enable ocsp stapling - http://en.wikipedia.org/wiki/OCSP_stapling
default['nginx']['server']['proxy']['ssl_stapling'] = "on"
default['nginx']['server']['proxy']['ssl_stapling_verify'] = "on"
default['nginx']['server']['proxy']['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2"

default['nginx']['server']['proxy']['ssl_dhparam'] = "#{node['alfresco']['certs']['ssl_folder']}/#{node['alfresco']['certs']['filename']}.dhparam"

# Use Intermediate Cipher Compatibility
# https://wiki.mozilla.org/Security/Server_Side_TLS#Intermediate_compatibility_.28default.29
default['nginx']['server']['proxy']['ssl_prefer_server_ciphers'] = "on"
default['nginx']['server']['proxy']['ssl_ciphers'] = "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA"

# SSL Cache configuration
default['nginx']['server']['proxy']['ssl_session_cache'] = "shared:SSL:25m"
default['nginx']['server']['proxy']['ssl_session_timeout'] = "10m"
default['nginx']['server']['proxy']['ssl_buffer_size'] = "1400"
default['nginx']['server']['proxy']['ssl_session_tickets'] = "off"
