default['logrotate']['rotate'] = 2

default['logrotate']['global']['/var/log/tomcat-*/catalina.out.*'] = {
  'missingok' => true,
  'daily' => true,
  'compress' => true,
  'rotate' => node['logrotate']['rotate']
}

default['logrotate']['global']['/var/log/tomcat-*/localhost.*'] = {
  'missingok' => true,
  'daily' => true,
  'compress' => true,
  'rotate' => node['logrotate']['rotate']
}

# TODO - change log4j config for alfresco.log.<timestamp>, share and solr
default['logrotate']['global']['/var/log/tomcat-*/*.log.*'] = {
  'missingok' => true,
  'daily' => true,
  'compress' => true,
  'rotate' => node['logrotate']['rotate']
}
