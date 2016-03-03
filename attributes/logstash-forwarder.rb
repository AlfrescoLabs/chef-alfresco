
default['logstash-forwarder']['items']['alfresco-repo-catalina']['type'] = 'catalina'
default['logstash-forwarder']['items']['alfresco-repo']['type'] = 'json'

default['logstash-forwarder']['items']['alfresco-share-catalina']['type'] = 'catalina'
default['logstash-forwarder']['items']['alfresco-share']['type'] = 'json'

default['logstash-forwarder']['items']['alfresco-solr-catalina']['type'] = 'catalina'
default['logstash-forwarder']['items']['alfresco-solr']['type'] = 'json'

# Optional, to be enabled only if needed
# default['logstash-forwarder']['items']['mysqld']['paths'] = ['/var/log/mysqld.log']
# default['logstash-forwarder']['items']['mysqld']['type'] = 'syslog'
#
# default['logstash-forwarder']['items']['mysqlerror']['paths'] = ['/var/log/mysql-default/error.log']
# default['logstash-forwarder']['items']['mysqlerror']['type'] = 'syslog'
#
# default['logstash-forwarder']['items']['nginx']['paths'] = ['/var/log/nginx/error.log']
# default['logstash-forwarder']['items']['nginx']['type'] = 'syslog'
#
# default['logstash-forwarder']['items']['psql-error']['paths'] = ['/var/log/postgresql/error.log']
# default['logstash-forwarder']['items']['psql-error']['type'] = 'syslog'
