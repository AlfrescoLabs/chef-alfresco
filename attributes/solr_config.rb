default['artifacts']['solrhome']['groupId'] = "org.alfresco"
default['artifacts']['solrhome']['artifactId'] = "alfresco-solr"
default['artifacts']['solrhome']['type'] = "zip"
default['artifacts']['solrhome']['version'] = node['alfresco']['version']
default['artifacts']['solrhome']['destination'] = "#{node['alfresco']['root_dir']}"
default['artifacts']['solrhome']['owner'] = node['tomcat']['user']
default['artifacts']['solrhome']['unzip'] = true

default['artifacts']['solr']['groupId'] = "org.apache.solr"
default['artifacts']['solr']['artifactId'] = "apache-solr"
default['artifacts']['solr']['version'] = "1.4.1-alfresco-patched"
default['artifacts']['solr']['type'] = "war"
default['artifacts']['solr']['destination'] = node['tomcat']['webapps']
default['artifacts']['solr']['owner'] = node['tomcat']['user']
default['artifacts']['solr']['unzip'] = false


#@TODO - Still to be validated
default['alfresco']['solr']['alfresco_host']    = node['alfresco']['url']['repo']['host']
default['alfresco']['solr']['alfresco_context'] = "/#{node['alfresco']['url']['repo']['context']}"
default['alfresco']['solr']['alfresco_port']    = node['alfresco']['url']['repo']['port']
default['alfresco']['solr']['alfresco_portssl'] = node['alfresco']['default_portssl']

default['alfresco']['solr']['solr_home']                = "#{node['artifacts']['solrhome']['destination']}/solrhome"
default['alfresco']['solr']['solr_secureComms']         = "https"
default['alfresco']['solr']['alfresco_secureComms']     = "https"