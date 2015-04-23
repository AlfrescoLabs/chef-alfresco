# Nginx settings
default['nginx']['cfg_source'] = 'nginx/nginx.conf.erb'
default['nginx']['cfg_cookbook'] = 'alfresco'

default['nginx']['service_actions'] = [:enable,:start]
