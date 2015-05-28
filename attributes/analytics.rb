default['reporting']['properties']['# enable.reporting'] = "true"

#TODO - this means that Share must be deployed on port 8081 ?
default['reporting']['pentaho.ba-server.url'] = "http://localhost:8080/pentaho/"

default['reporting']['analytics_path'] = "#{node['artifacts']['alfresco-pentaho']['destination']}/alfresco-analytics-1.0.2"
default['reporting']['ba_server_path'] = "#{node['reporting']['analytics_path']}/ba-server"

default['reporting']['activemq_local_host'] = "localhost"
default['reporting']['activemq_local_port'] = "61616"
default['reporting']['pentaho_local_host'] = "localhost"
default['reporting']['pentaho_local_port'] = "8070"
default['reporting']['pentaho_public_host'] = "localhost"
default['reporting']['pentaho_public_port'] = "8070"

default['reporting']['alfresco_local_host'] = "localhost"
default['reporting']['alfresco_public_host'] = "localhost"
default['reporting']['alfresco_username'] = "admin"
default['reporting']['alfresco_password'] = "admin"

default['reporting']['alfresco_local_port'] = "8090"
default['reporting']['share_public_port'] = "8080"
