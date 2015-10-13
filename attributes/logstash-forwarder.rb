default['logstash-forwarder']['items']['alfresco-repo-catalina']['paths'] = ['/var/log/tomcat-alfresco/catalina.out.*']
default['logstash-forwarder']['items']['alfresco-repo-catalina']['type'] = 'catalina'
default['logstash-forwarder']['items']['alfresco-repo']['paths'] = ['/var/log/tomcat-alfresco/alfresco.log']
default['logstash-forwarder']['items']['alfresco-repo']['type'] = 'java'

default['logstash-forwarder']['items']['alfresco-share-catalina']['paths'] = ['/var/log/tomcat-share/catalina.out.*']
default['logstash-forwarder']['items']['alfresco-share-catalina']['type'] = 'catalina'
default['logstash-forwarder']['items']['alfresco-share']['paths'] = ['/var/log/tomcat-share/share.log']
default['logstash-forwarder']['items']['alfresco-share']['type'] = 'java'

default['logstash-forwarder']['items']['alfresco-solr-catalina']['paths'] = ['/var/log/tomcat-solr/catalina.out.*']
default['logstash-forwarder']['items']['alfresco-solr-catalina']['type'] = 'catalina'
default['logstash-forwarder']['items']['alfresco-solr']['paths'] = ['/var/log/tomcat-solr/solr.log']
default['logstash-forwarder']['items']['alfresco-solr']['type'] = 'java'

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
