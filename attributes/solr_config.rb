#solrcore.properties placeholders
default['alfresco']['solrproperties']['alfresco.host']            = node['alfresco']['properties']['alfresco.host']
default['alfresco']['solrproperties']['alfresco.port']            = node['alfresco']['properties']['alfresco.port']
default['alfresco']['solrproperties']['alfresco.port.ssl']        = node['alfresco']['properties']['alfresco.port.ssl']
default['alfresco']['solrproperties']['alfresco.baseUrl']         = node['alfresco']['properties']['alfresco.context']
default['alfresco']['solrproperties']['alfresco.secureComms']     = node['alfresco']['properties']['solr.secureComms']

default['alfresco']['solr-log4j']['log4j.appender.File.File']     = "#{node['tomcat']['log_dir']}/solr.log"

# Artifact Deployer attributes
default['artifacts']['solrhome']['groupId']       = node['alfresco']['groupId']
default['artifacts']['solrhome']['artifactId']    = "alfresco-solr"
default['artifacts']['solrhome']['version']       = node['alfresco']['version']
default['artifacts']['solrhome']['destination']   = "#{node['alfresco']['properties']['dir.root']}"
default['artifacts']['solrhome']['owner']         = node['tomcat']['user']
default['artifacts']['solrhome']['unzip']         = true
default['artifacts']['solrhome']['type']        = "zip"

if node['alfresco']['version'].start_with?("4.3") || node['alfresco']['version'].start_with?("5")
  default['artifacts']['solrhome']['classifier']  = "config"

  default['artifacts']['solr']['groupId']         = node['alfresco']['groupId']
  default['artifacts']['solr']['artifactId']      = "alfresco-solr"
  default['artifacts']['solr']['version']         = node['alfresco']['version']
else
  default['artifacts']['solr']['groupId']         = "org.apache.solr"
  default['artifacts']['solr']['artifactId']      = "apache-solr"
  default['artifacts']['solr']['version']         = "1.4.1-alfresco-patched"
end

default['artifacts']['solr']['type']              = "war"
default['artifacts']['solr']['destination']       = node['tomcat']['webapp_dir']
default['artifacts']['solr']['owner']             = node['tomcat']['user']
default['artifacts']['solr']['unzip']             = false

# Filtering properties with attributes defined above
default['artifacts']['solrhome']['properties']['archive-SpacesStore/conf/solrcore.properties']    = node['alfresco']['solrproperties']
default['artifacts']['solrhome']['properties']['workspace-SpacesStore/conf/solrcore.properties']  = node['alfresco']['solrproperties']
default['artifacts']['solrhome']['properties']['log4j-solr.properties']                           = node['alfresco']['solr-log4j']
