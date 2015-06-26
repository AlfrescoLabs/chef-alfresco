default['nginx']['conf_template'] = 'nginx/nginx.conf.erb'
default['nginx']['conf_cookbook'] = 'alfresco'

default['nginx']['service_actions'] = [:enable,:start]

default['nginx']['dns_server'] = "localhost"

default['nginx']['resolver'] = "8.8.4.4 8.8.8.8"

default['nginx']['port'] = "80"

default['nginx']['proxy_port'] = node['haproxy']['port']
