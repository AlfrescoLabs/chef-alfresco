default['haproxy']['ec2']['discover_cron'] = '*/5 * * * *'
default['haproxy']['ec2']['install_haproxy_discovery'] = false

# Force rsyslog to use UDP on localhost
default['haproxy']['enable_rsyslog_server'] = false
default['haproxy']['enable_local_logging'] = false
default['haproxy']['rsyslog_bind'] = '127.0.0.1'
default['haproxy']['domain'] = 'localhost'

# HAproxy cookbook attributes
default['haproxy']['enable_ssl'] = false
default['haproxy']['enable_admin'] = false
default['haproxy']['enable_default_http'] = false

default['haproxy']['conf_cookbook'] = 'alfresco'
default['haproxy']['conf_template_source'] = 'haproxy/haproxy.cfg.erb'

default['haproxy']['bind_ip'] = '127.0.0.1'
default['haproxy']['default_backend'] = 'share'
default['haproxy']['stats_port'] = '1936'
default['haproxy']['stats_auth'] = 'admin'
default['haproxy']['stats_pwd'] = 'changeme'

default['haproxy']['log_level'] = 'info'
default['haproxy']['enable_ssl_header'] = true
default['haproxy']['ssl_header'] = 'http-response set-header Strict-Transport-Security max-age=15768000;\\ includeSubDomains;\\ preload;'

# default['haproxy']['logging'] = "option httplog"
default['haproxy']['logging_json_enabled'] = false
default['haproxy']['logformat'] = '#- wibble'
default['haproxy']['json_logformat'] = 'log-format  {\"type\":\"haproxy\",\"timestamp\":%t,\"actconn\":%ac,\"feconn\":%fc,\"beconn\":%bc,\"backend_queue\":%bq,\"srv_conn\":%sc,\"retry\":%rc,\"tq\":%Tq,\"tw\":%Tw,\"tc\":%Tc,\"tr\":%Tr,\"tt\":%Tt,\"tsc\":\"%tsc\",\"client_addr\":\"%ci:%cp\",\"front_addr\":\"%fi:%fp\",\"front_transport\":\"%ft\",\"ssl_version\":\"%sslv\",\"ssl_cipher\":\"%sslc\",\"http_status\":%ST,\"http_req\":\"%r\",\"back_name\":\"%b\",\"back_server\":\"%s\",\"req_header_cap\":\"%hr\",\"resp_header_cap\":\"%hs\",\"bytes_uploaded\":%U,\"bytes_read\":%B,\"unique_id\":\"%ID\"} '

default['haproxy']['ssl_chain_file'] = "#{node['alfresco']['certs']['ssl_folder']}/#{node['alfresco']['certs']['filename']}.chain"

haproxy_logging = node['haproxy']['logging_json_enabled'] ? node['haproxy']['json_logformat'] : node['haproxy']['logformat']
hsts_header = node['haproxy']['ssl_header'] if node['haproxy']['enable_ssl_header']

# when adding new error codes make sure there is an error page file in templates/default/errors
default['haproxy']['error_codes'] = %w( 400 403 404 408 500 502 503 504 )

default['haproxy']['general_config'] = [
  'tune.ssl.default-dh-param 2048',
  # Logging should be handled with logstash-forwarder
  "log 127.0.0.1 local2 #{node['haproxy']['log_level']}",
  'pidfile /var/run/haproxy.pid',
  'stats socket /var/run/haproxy.stat user haproxy group haproxy mode 600 level admin',
  'user haproxy',
  'group haproxy',
  'tune.ssl.maxrecord 1419',
  'spread-checks 5',
]

default['haproxy']['default_config'] = [
  'mode http',
  'log global',
  'retries 3',
  '',
  '# Options',
  'option httplog',
  haproxy_logging,
  'option dontlognull',
  'option forwardfor',
  'option http-server-close',
  'option redispatch',
  '',
  '# Optimisations',
  'option tcp-smart-accept',
  'option tcp-smart-connect',
  'option contstats',
  '',
  '# Timeouts',
  'timeout http-request 10s',
  'timeout queue 1m',
  'timeout connect 5s',
  'timeout client 2m',
  'timeout server 2m',
  'timeout http-keep-alive 10s',
  'timeout check 5s',
  'timeout tarpit 60s',
  'compression algo gzip',
  'compression type text/html text/html;charset=utf-8 text/plain text/css text/javascript application/x-javascript application/javascript application/ecmascript application/rss+xml application/atomsvc+xml application/atom+xml application/atom+xml;type=entry application/atom+xml;type=feed application/cmisquery+xml application/cmisallowableactions+xml application/cmisatom+xml application/cmistree+xml application/cmisacl+xml application/msword application/vnd.ms-excel application/vnd.ms-powerpoint application/json',
]

default['haproxy']['frontends']['internal']['entries'] = [
  "bind #{node['haproxy']['bind_ip']}:#{node['alfresco']['internal_port']}",
  'mode http',
  'capture request header X-Forwarded-For len 64',
  'capture request header User-agent len 128',
  'capture request header Cookie len 64',
  'capture request header Accept-Language len 64',
]

default['haproxy']['frontends']['external']['redirects'] = [
  'redirect location /share/ if !is_share !is_alfresco !is_aos_root !is_aos_vti',
  'redirect location /share/ if is_root',
]

default['haproxy']['frontends']['external']['acl_lines'] = [
  'is_root path_reg ^$|^/$',
  'alfresco_path path_reg ^/alfresco/.*',
  'activiti_path path_reg ^/activiti/.*',
  'robots path_reg ^/robots.txt$',
  'solr_path path_reg ^/share/.*/proxy/alfresco/api/solr/.*',
  'activity_path path_reg ^/share/-default-/proxy/alfresco/api/.*',
  'webinf path_reg ^/share/res/WEB-INF/.*',
]

default['haproxy']['frontends']['external']['other_config'] = [
  # Use it to avoid accessing the /alfresco path (careful with api calls)
  # "http-request deny if alfresco_path",
  'http-request deny if robots',
  'http-request deny if solr_path',
  'http-request deny if activiti_path',
  'http-request deny if activity_path',
  'http-request deny if webinf',
]

default['haproxy']['frontends']['external']['entries'] = [
  "bind #{node['haproxy']['bind_ip']}:#{node['alfresco']['internal_secure_port']}",
  'mode http',
  'capture request header X-Forwarded-For len 64',
  'capture request header User-agent len 128',
  'capture request header Cookie len 64',
  'capture request header Accept-Language len 64',
  'unique-id-format %{+X}o\\ %ci:%cp_%fi:%fp_%Ts_%rt:%pid',
  'unique-id-header X-Unique-ID',
  '',
  '#---- ddos protection -----',
  'tcp-request inspect-delay 5s',
  'acl HAS_X_FORWARDED_FOR hdr_cnt(X-Forwarded-For) eq 1',
  'acl HAS_JSESSIONID hdr_sub(cookie) JSESSIONID',
  '',
  "# Don't track if the request has a JSESSIONID cookie",
  'tcp-request content track-sc0 hdr_ip(X-Forwarded-For,-1) if HTTP HAS_X_FORWARDED_FOR !HAS_JSESSIONID',
  '',
  '# Stick Table Definitions',
  '#  - conn_cur: count active connections',
  '#  - conn_rate(3s): average incoming connection rate over 3 seconds',
  '#  - http_err_rate(10s): Monitors the number of errors generated by an IP over a period of 10 seconds',
  '#  - http_req_rate(10s): Monitors the number of request sent by an IP over a period of 10 seconds',
  'stick-table type ip size 500k expire 30s store conn_cur,conn_rate(3s),http_req_rate(10s),http_err_rate(10s)',
  '# Tarpit Definitions',
  '# TARPIT the new connection if the client already has 10 opened',
  '# http-request tarpit if { src_conn_cur ge 10 }',
  '# TARPIT the new connection if the client has opened more than 20 connections in 3s',
  '# http-request tarpit if { src_conn_rate ge 20 }',
  '# TARPIT the connection if the client has passed the HTTP error rate (5 in 10s)',
  '# http-request tarpit if { sc0_http_err_rate() gt 5 }',
  '# TARPIT the connection if the client has passed the HTTP request rate (20 in 10s)',
  '# http-request tarpit if { sc0_http_req_rate() gt 20 }',
  '',
  'acl FORBIDDEN_HDR hdr_cnt(host) gt 1',
  'acl FORBIDDEN_HDR hdr_cnt(content-length) gt 1',
  'acl FORBIDDEN_HDR hdr_val(content-length) lt 0',
  'acl FORBIDDEN_HDR hdr_cnt(proxy-authorization) gt 0',
  'acl FORBIDDEN_HDR hdr_cnt(x-xsrf-token) gt 1',
  'acl FORBIDDEN_HDR hdr_len(x-xsrf-token) gt 36',
  'acl FORBIDDEN_HDR hdr_cnt(X-Forwarded-For) gt 3',
  'http-request tarpit if FORBIDDEN_HDR',
  'acl WEIRD_RANGE_HEADERS hdr_cnt(Range) gt 10',
  'http-request tarpit if WEIRD_RANGE_HEADERS',
  '#---- end ddos protection -----',
  hsts_header,
]

default['haproxy']['frontends']['external']['headers'] = []

default['haproxy']['frontends']['stats']['entries'] = [
  "bind #{node['haproxy']['bind_ip']}:#{node['haproxy']['stats_port']}",
  'http-request set-log-level silent',
  'stats enable',
  'stats hide-version',
  'stats realm Haproxy\ Statistics',
  'stats uri /',
  "stats auth #{node['haproxy']['stats_auth']}:#{node['haproxy']['stats_pwd']}",
  'stats refresh   2s',
]

# Share Haproxy configuration
# Note: the haproxy backend items are configured on each sub recipe: repo.rb, share.rb and solr.rb
default['haproxy']['share_stats_auth'] = 'admin:password'
default['haproxy']['frontends']['external']['acls']['share'] = ['path_beg /share']
default['haproxy']['backends']['roles']['share']['entries'] = [
  "rspirep ^Location:\\s*http://.*?\.#{node['haproxy']['domain']}(/.*)$ Location:\\ \\1",
  "rspirep ^Location:(.*\\?\w+=)http(%3a%2f%2f.*?\\.#{node['haproxy']['domain']}%2f.*)$ Location:\\ \\1https\\2",
  "rspdel Expires\\=Thu\\,\\ 01\-Jan\\-1970\\ 00\\:00\\:10\\ GMT",
  "reqdel Expires\\=Thu\\,\\ 01\-Jan\\-1970\\ 00\\:00\\:10\\ GMT",
  'option httpchk GET /share',
]

default['haproxy']['backends']['roles']['share']['secure_entries'] = []

default['haproxy']['secure_entries'] = [
  'acl secured_cookie res.hdr(Set-Cookie),lower -m sub secure',
  'rspirep ^(set-cookie:.*) \\1;\\ Secure if !secured_cookie',
]

default['haproxy']['backends']['roles']['share']['port'] = 8081

# Solr Haproxy configuration
default['haproxy']['frontends']['internal']['acls']['solr'] = ['path_beg /solr4']
default['haproxy']['backends']['roles']['solr']['entries'] = ['option httpchk GET /solr4', 'cookie JSESSIONID prefix', 'balance url_param JSESSIONID check_post']
default['haproxy']['backends']['roles']['solr']['port'] = 8090

# Solr6 Haproxy configuration
default['haproxy']['frontends']['internal']['acls']['solr6'] = ['path_beg /solr']
default['haproxy']['backends']['roles']['solr6']['entries'] = ['option httpchk GET /solr', 'cookie JSESSIONID prefix', 'balance url_param JSESSIONID check_post']
default['haproxy']['backends']['roles']['solr6']['port'] = 8090

# Activiti Haproxy configuration
if node['alfresco']['components'].include?('activiti')
  default['haproxy']['frontends']['internal']['acls']['activiti'] = ['path_beg /activiti']
  default['haproxy']['backends']['roles']['activiti']['entries'] = ['option httpchk GET /activiti', 'cookie JSESSIONID prefix', 'balance url_param JSESSIONID check_post']
  default['haproxy']['backends']['roles']['activiti']['port'] = 8060
end

# HAproxy configuration
default['haproxy']['frontends']['internal']['acls']['alfresco'] = ['path_beg /alfresco']
default['haproxy']['frontends']['external']['acls']['alfresco'] = ['path_beg /alfresco', 'path_reg ^/alfresco/aos/.*', 'path_reg ^/alfresco/aos$']
default['haproxy']['frontends']['external']['acls']['aos_vti'] = ['path_reg ^/_vti_inf.html$', 'path_reg ^/_vti_bin/.*']
default['haproxy']['frontends']['external']['acls']['aos_root'] = ['path_reg ^/$ method OPTIONS', 'path_reg ^/$ method PROPFIND']

default['haproxy']['backends']['roles']['alfresco']['entries'] = ['option httpchk GET /alfresco', 'cookie JSESSIONID prefix', 'balance url_param JSESSIONID check_post']
default['haproxy']['backends']['roles']['alfresco']['port'] = 8070

default['haproxy']['backends']['roles']['aos']['entries'] = ['option httpchk GET /alfresco', 'cookie JSESSIONID prefix', 'balance url_param JSESSIONID check_post']
default['haproxy']['backends']['roles']['aos']['port'] = 8070

default['haproxy']['backends']['roles']['aos_vti']['entries'] = ['option httpchk GET /_vti_inf.html', 'cookie JSESSIONID prefix', 'balance url_param JSESSIONID check_post']
default['haproxy']['backends']['roles']['aos_vti']['port'] = 8070

default['haproxy']['backends']['roles']['aos_root']['entries'] = ['option httpchk GET /']
default['haproxy']['backends']['roles']['aos_root']['port'] = 8070

# TODO: - WIP
# default['haproxy']['frontends']['external']['acls']['alfresco_api'] = ["path_beg /alfresco/api"]
# default['haproxy']['backends']['roles']['alfresco_api']['entries'] = ["option httpchk GET /alfresco/api"]
# default['haproxy']['backends']['roles']['alfresco_api']['port'] = 8070
#
# default['haproxy']['frontends']['external']['acls']['webdav'] = ["path_beg /alfresco/webdav"]
# default['haproxy']['backends']['roles']['webdav']['entries'] = ["option httpchk GET /alfresco/webdav"]
# default['haproxy']['backends']['roles']['webdav']['port'] = 8070
