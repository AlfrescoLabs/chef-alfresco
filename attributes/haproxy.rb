# HAproxy supermarket cookbook attributes
default['haproxy']['enable_ssl'] = false
default['haproxy']['enable_admin'] = false
default['haproxy']['enable_default_http'] = false
default['haproxy']['enable_ssl'] = false

default['haproxy']['enable.ec2.discovery'] = false

# TODO - should be 127.0.0.1, but needs to be overridden in kitchen, for local runs
default['haproxy']['bind_ip'] = "0.0.0.0"
default['haproxy']['port'] = "9000"

default['haproxy']['conf_cookbook'] = 'alfresco'
default['haproxy']['conf_template_source'] = 'haproxy/haproxy.cfg.erb'

default['haproxy']['400_error_page_message'] = "Alfresco received a bad request!"
default['haproxy']['403_error_page_message'] = "Alfresco forbids you from doing that!"
default['haproxy']['404_error_page_message'] = "Alfresco couldnt find your file."
default['haproxy']['408_error_page_message'] = "Alfresco timed out."
default['haproxy']['500_error_page_message'] = "Alfresco is having some issues, sorry."
default['haproxy']['502_error_page_message'] = "Alfresco is having some issues!"
default['haproxy']['503_error_page_message'] = "Alfresco is under heavy load right now!"
default['haproxy']['504_error_page_message'] = "Alfresco is having some issues!"

# TODO - integrate in default configuration
default['haproxy']['ssl_pem_crt_file'] = "/etc/haproxy/haproxy.pem"
default['haproxy']['ssl_pem_crt_databag'] = "ssl"
default['haproxy']['ssl_pem_crt_databag_item'] = "haproxy"

# TODO - integrate in default configuration
default['haproxy']['error_folder'] = "/var/www/html/errors"
default['haproxy']['error_file_cookbook'] = "alfresco"
default['haproxy']['error_file_source'] = "haproxy/errors"

default['haproxy']['default_backend'] = "share"

default['haproxy']['acls'] = ["is_root path_reg ^$|^/$"]

default['haproxy']['redirects'] = [
  "redirect location /share/ if !is_share !is_alfresco !is_solr4 !is_aos_root !is_aos_vti",
  "redirect location /share/ if is_root"
]

default['haproxy']['general_config'] = [
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
  "errorfile 400 /var/www/html/errors/400.http",
  "errorfile 403 /var/www/html/errors/403.http",
  "errorfile 408 /var/www/html/errors/408.http",
  "errorfile 500 /var/www/html/errors/500.http",
  "errorfile 502 /var/www/html/errors/502.http",
  "errorfile 503 /var/www/html/errors/503.http",
  "errorfile 504 /var/www/html/errors/504.http"
]

default['haproxy']['frontends']['http']['entries'] = [
  "bind #{node['haproxy']['bind_ip']}:#{node['haproxy']['port']}"
]

# Share Haproxy configuration
default['haproxy']['backends']['share']['acls']= ['path_beg /share']
default['haproxy']['backends']['share']['entries'] = ["option httpchk GET /share","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
default['haproxy']['backends']['share']['nodes']['localhost'] = "127.0.0.1"
default['haproxy']['backends']['share']['port'] = 8081

# Solr Haproxy configuration
default['haproxy']['backends']['solr4']['acls'] = ['path_beg /solr4']
default['haproxy']['backends']['solr4']['entries'] = ["option httpchk GET /solr4","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
default['haproxy']['backends']['solr4']['nodes']['localhost'] = "127.0.0.1"
default['haproxy']['backends']['solr4']['port'] = 8090

# HAproxy configuration
default['haproxy']['backends']['alfresco']['acls'] = ["path_beg /alfresco", "path_reg ^/alfresco/aos/.*","path_reg ^/alfresco/aos$"]
default['haproxy']['backends']['alfresco']['entries'] = ["option httpchk GET /alfresco","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
default['haproxy']['backends']['alfresco']['nodes']['localhost'] = "127.0.0.1"
default['haproxy']['backends']['alfresco']['port'] = 8070

default['haproxy']['backends']['aos_vti']['acls'] = ["path_reg ^/_vti_inf.html$","path_reg ^/_vti_bin/.*"]
default['haproxy']['backends']['aos_vti']['entries'] = ["option httpchk GET /_vti_inf.html","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
default['haproxy']['backends']['aos_vti']['port'] = 8070
default['haproxy']['backends']['aos_vti']['nodes']['localhost'] = "127.0.0.1"

default['haproxy']['backends']['aos_root']['acls'] = ["path_reg ^/$ method OPTIONS","path_reg ^/$ method PROPFIND"]
default['haproxy']['backends']['aos_root']['entries'] = ["option httpchk GET /","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
default['haproxy']['backends']['aos_root']['port'] = 8070
default['haproxy']['backends']['aos_root']['nodes']['localhost'] = "127.0.0.1"
