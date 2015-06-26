node.default['haproxy']['enable.ec2.discovery'] = false

# TODO - should be 127.0.0.1, but needs to be overridden in kitchen, for local runs
node.default['haproxy']['bind_ip'] = "0.0.0.0"
node.default['haproxy']['port'] = "9000"

node.default['haproxy']['enable_ssl'] = false
node.default['haproxy']['enable_admin'] = false
node.default['haproxy']['enable_default_http'] = false
node.default['haproxy']['enable_ssl'] = false

node.default['haproxy']['conf_cookbook'] = 'alfresco'
node.default['haproxy']['conf_template_source'] = 'haproxy/haproxy.cfg.erb'

node.default['haproxy']['400_error_page_message'] = "Alfresco received a bad request!"
node.default['haproxy']['403_error_page_message'] = "Alfresco forbids you from doing that!"
node.default['haproxy']['404_error_page_message'] = "Alfresco couldnt find your file."
node.default['haproxy']['408_error_page_message'] = "Alfresco timed out."
node.default['haproxy']['500_error_page_message'] = "Alfresco is having some issues, sorry."
node.default['haproxy']['502_error_page_message'] = "Alfresco is having some issues!"
node.default['haproxy']['503_error_page_message'] = "Alfresco is under heavy load right now!"
node.default['haproxy']['504_error_page_message'] = "Alfresco is having some issues!"

# TODO - integrate in default configuration
node.default['haproxy']['ssl_pem_crt_file'] = "/etc/haproxy/haproxy.pem"
node.default['haproxy']['ssl_pem_crt_databag'] = "ssl"
node.default['haproxy']['ssl_pem_crt_databag_item'] = "haproxy"

# TODO - integrate in default configuration
node.default['haproxy']['error_folder'] = "/var/www/html/errors"
node.default['haproxy']['error_file_cookbook'] = "alfresco"
node.default['haproxy']['error_file_source'] = "haproxy/errors"

node.default['haproxy']['frontends']['http']['entries'] = [
  "bind #{node['haproxy']['bind_ip']}:#{node['haproxy']['port']}"
]

node.default['haproxy']['default_backend'] = "share"

node.default['haproxy']['general_config'] = [
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

# HAproxy configuration
node.default['haproxy']['backends']['alfresco']['acls'] = ["path_beg /alfresco", "path_reg ^/alfresco/aos/.*","path_reg ^/alfresco/aos$"]
node.default['haproxy']['backends']['alfresco']['entries'] = ["option httpchk GET /alfresco","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
node.default['haproxy']['backends']['alfresco']['nodes']['localhost'] = "127.0.0.1"
node.default['haproxy']['backends']['alfresco']['port'] = 8070

node.default['haproxy']['backends']['aos_vti']['acls'] = ["path_reg ^/_vti_inf.html$","path_reg ^/_vti_bin/.*"]
node.default['haproxy']['backends']['aos_vti']['entries'] = ["option httpchk GET /_vti_inf.html","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
node.default['haproxy']['backends']['aos_vti']['port'] = 8070
node.default['haproxy']['backends']['aos_vti']['nodes']['localhost'] = "127.0.0.1"

node.default['haproxy']['backends']['aos_root']['acls'] = ["path_reg ^/$ method OPTIONS","path_reg ^/$ method PROPFIND"]
node.default['haproxy']['backends']['aos_root']['entries'] = ["option httpchk GET /","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
node.default['haproxy']['backends']['aos_root']['port'] = 8070
node.default['haproxy']['backends']['aos_root']['nodes']['localhost'] = "127.0.0.1"
