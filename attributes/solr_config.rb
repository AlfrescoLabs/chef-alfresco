#solrcore.properties placeholders
default['alfresco']['solrproperties']['alfresco.host']            = node['alfresco']['properties']['alfresco.host']
default['alfresco']['solrproperties']['alfresco.port']            = node['alfresco']['properties']['alfresco.port']
default['alfresco']['solrproperties']['alfresco.port.ssl']        = node['alfresco']['properties']['alfresco.port.ssl']
default['alfresco']['solrproperties']['alfresco.baseUrl']         = node['alfresco']['properties']['alfresco.context']

default['alfresco']['solrproperties']['data.dir.root']            = "#{node['alfresco']['properties']['dir.root']}/solrhome"
default['alfresco']['solrproperties']['alfresco.secureComms']     = "https"

# Artifact Deployer attributes
default['artifacts']['solrhome']['groupId'] = "org.alfresco"
default['artifacts']['solrhome']['artifactId'] = "alfresco-solr"
default['artifacts']['solrhome']['type'] = "zip"
default['artifacts']['solrhome']['version'] = node['alfresco']['version']
default['artifacts']['solrhome']['destination'] = "#{node['alfresco']['properties']['dir.root']}"
default['artifacts']['solrhome']['owner'] = node['tomcat']['user']
default['artifacts']['solrhome']['unzip'] = true
default['artifacts']['solrhome']['enabled'] = false

# Filtering properties with attributes defined above
default['artifacts']['solrhome']['properties']['archive-SpacesStore/conf/solrcore.properties'] = node['alfresco']['solrproperties']
default['artifacts']['solrhome']['properties']['workspace-SpacesStore/conf/solrcore.properties'] = node['alfresco']['solrproperties']

default['artifacts']['solr']['groupId'] = "org.apache.solr"
default['artifacts']['solr']['artifactId'] = "apache-solr"
default['artifacts']['solr']['version'] = "1.4.1-alfresco-patched"
default['artifacts']['solr']['type'] = "war"
default['artifacts']['solr']['destination'] = node['tomcat']['webapp_dir']
default['artifacts']['solr']['owner'] = node['tomcat']['user']
default['artifacts']['solr']['unzip'] = false
default['artifacts']['solr']['enabled'] = false