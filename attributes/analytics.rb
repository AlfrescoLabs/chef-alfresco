default['analytics']['properties']['# enable.reporting'] = "true"

#TODO - this means that Share must be deployed on port 8081 ?
default['analytics']['pentaho.ba-server.url'] = "http://localhost:8080/pentaho/"

default['artifacts']['alfresco-pentaho']['destination'] = '/tmp'

default['analytics']['analytics_path'] = "#{node['artifacts']['alfresco-pentaho']['destination']}/alfresco-analytics-1.0.2"
default['analytics']['ba_server_path'] = "#{node['analytics']['analytics_path']}/ba-server"
default['analytics']['license_installer_path'] = "#{node['analytics']['analytics_path']}/license-installer"
default['analytics']['license_root_path'] = "/opt/analytics-licenses"

default['analytics']['analytics_license_source'] = 'analytics-license'
default['analytics']['analytics_license_cookbook'] = 'alfresco'

default['analytics']['license_paths'] = "#{node['analytics']['license_root_path']}/license1.lic"

default['analytics']['activemq_local_host'] = "localhost"
default['analytics']['activemq_local_port'] = "61616"
default['analytics']['pentaho_local_host'] = "localhost"
default['analytics']['pentaho_local_port'] = "8070"
default['analytics']['pentaho_public_host'] = "localhost"
default['analytics']['pentaho_public_port'] = "8070"

default['analytics']['alfresco_local_host'] = "localhost"
default['analytics']['alfresco_public_host'] = "localhost"
default['analytics']['alfresco_username'] = "admin"
default['analytics']['alfresco_password'] = "admin"

default['analytics']['alfresco_local_port'] = "8090"
default['analytics']['share_public_port'] = "8081"
