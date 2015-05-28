default['haproxy']['enable_ssl'] = false
default['haproxy']['enable_admin'] = false
default['haproxy']['enable_default_http'] = false
default['haproxy']['enable_ssl'] = false

default['haproxy']['conf_cookbook'] = 'alfresco'
default['haproxy']['conf_template_source'] = 'haproxy/haproxy.cfg.erb'

default['haproxy']['hostname'] = node['hostname'] ? node['hostname'] : 'localhost'
default['haproxy']['domain'] = node['domain'] ? node['domain'] : 'localdomain'

# TODO - integrate in default configuration
default['haproxy']['ssl_pem_crt_file'] = "/etc/haproxy/haproxy.pem"
default['haproxy']['ssl_pem_crt_databag'] = "ssl"
default['haproxy']['ssl_pem_crt_databag_item'] = "haproxy"

# TODO - integrate in default configuration
default['haproxy']['error_folder'] = "/var/www/html/errors"
default['haproxy']['error_file_cookbook'] = "alfresco"
default['haproxy']['error_file_source'] = "haproxy/errors"

default['haproxy']['port'] = "9000"

default['haproxy']['config'] = [
  "#",
  "# Global configurations",
  "global",
  "log 127.0.0.1 local2 info",
  "pidfile /var/run/haproxy.pid",
  "stats socket /var/run/haproxy.stat user haproxy group haproxy mode 600 level admin",
  "user haproxy",
  "group haproxy",
  "defaults",
  "mode http",
  "log global",
  "retries 3",
  "#",
  "# Timeouts",
  "timeout http-request 10s",
  "timeout queue 1m",
  "timeout connect 5s",
  "timeout client 2m",
  "timeout server 2m",
  "timeout http-keep-alive 10s",
  "timeout check 5s",
  "#",
  "# Front end for http to https redirect",
  "frontend nginx",
  "bind 0.0.0.0:#{node['haproxy']['port']}",
  "# ACL for backend mapping based on url paths",
  "acl share_path path_beg /share/",
  "acl alfresco_path path_beg /alfresco",
  "acl is_aos_vti path_reg ^/_vti_inf.html$",
  "acl is_aos_vti path_reg ^/_vti_bin/.*",
  "acl is_aos path_reg ^/alfresco/aos/.*",
  "acl is_aos path_reg ^/alfresco/aos$",
  "acl is_aos_root path_reg ^/$ method OPTIONS",
  "acl is_aos_root path_reg ^/$ method PROPFIND",
  "# Redirects",
  "redirect location /share/ if !share_path !alfresco_path !is_aos",
  "# List of backends",
  "use_backend share if share_path",
  "use_backend alfresco if alfresco_path",
  "use_backend alfresco if is_aos",
  "use_backend aos_vti if is_aos_vti",
  "use_backend aos_root if is_aos_root",
  "default_backend share",
  "#",
  "# Share backend",
  "backend share",
  # "rspirep ^Location:\\s*http://.*?\.#{node['hosts']['domain']}(/.*)$ Location:\\ \\1",
  # "rspirep ^Location:(.*\\?\w+=)http(%3a%2f%2f.*?\\.#{node['hosts']['domain']}%2f.*)$ Location:\\ \\1https\\2",
  "option httpchk GET /share",
  "cookie JSESSIONID prefix",
  "server #{node['hosts']['hostname']} 127.0.0.1:8080 cookie share1 check inter 5000",
  "#",
  "# Alfresco backend",
  "backend alfresco",
  "option httpchk GET /alfresco",
  # "balance url_param JSESSIONID check_post",
  "cookie JSESSIONID prefix",
  "server #{node['hosts']['hostname']} 127.0.0.1:8070 cookie alf1 check inter 5000",
  "#",
  "# VTI backend",
  "backend aos_vti",
  "option httpchk GET /_vti_inf.html",
  # "balance url_param JSESSIONID check_post",
  "cookie JSESSIONID prefix",
  "server #{node['hosts']['hostname']} 127.0.0.1:8070 cookie alf1 check inter 5000",
  "#",
  "# ROOT backend",
  "backend aos_root",
  "option httpchk GET /",
  # "balance url_param JSESSIONID check_post",
  "cookie JSESSIONID prefix",
  "server #{node['hosts']['hostname']} 127.0.0.1:8070 cookie alf1 check inter 5000",
  "#"
  ]
