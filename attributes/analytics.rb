default['analytics']['properties']['# enable.reporting'] = 'true'

# TODO: - this means that Share must be deployed on port 8081 ?
default['analytics']['pentaho.ba-server.url'] = 'http://localhost:8080/pentaho/'

default['artifacts']['alfresco-pentaho']['destination'] = '/tmp'

default['analytics']['license_root_path'] = '/opt/analytics-licenses'

default['analytics']['analytics_license_source'] = 'analytics-license'
default['analytics']['analytics_license_cookbook'] = 'alfresco'

default['analytics']['activemq_local_host'] = 'localhost'
default['analytics']['activemq_local_port'] = '61616'
default['analytics']['pentaho_local_host'] = 'localhost'
default['analytics']['pentaho_local_port'] = '8070'
default['analytics']['pentaho_public_host'] = 'localhost'
default['analytics']['pentaho_public_port'] = '8070'

default['analytics']['alfresco_local_host'] = 'localhost'
default['analytics']['alfresco_public_host'] = 'localhost'
default['analytics']['alfresco_username'] = 'admin'
default['analytics']['alfresco_password'] = 'admin'

default['analytics']['alfresco_local_port'] = '8090'
default['analytics']['share_public_port'] = '8081'
