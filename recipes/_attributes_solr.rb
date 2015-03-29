# Keep it empty and invoke it anyway, since attributes/solr_config.rb must be loaded
node.default['artifacts']['solrhome']['enabled']       = true
node.default['artifacts']['solr']['enabled']           = true

node.default['alfresco']['solr-log4j']['log4j.appender.File.File']     = "#{node['tomcat']['log_dir']}/solr.log"

# Artifact deployer attributes
node.default['artifacts']['solrhome']['groupId']       = node['alfresco']['groupId']
node.default['artifacts']['solrhome']['artifactId']    = "alfresco-solr"
node.default['artifacts']['solrhome']['version']       = node['alfresco']['version']
node.default['artifacts']['solrhome']['destination']   = node['alfresco']['properties']['dir.root']
node.default['artifacts']['solrhome']['owner']         = node['tomcat']['user']
node.default['artifacts']['solrhome']['unzip']         = true
node.default['artifacts']['solrhome']['type']        = "zip"

if node['alfresco']['version'].start_with?("4.3") || node['alfresco']['version'].start_with?("5")
  node.default['artifacts']['solrhome']['classifier']  = "config"

  node.default['artifacts']['solr']['groupId']         = node['alfresco']['groupId']
  node.default['artifacts']['solr']['artifactId']      = "alfresco-solr"
  node.default['artifacts']['solr']['version']         = node['alfresco']['version']
else
  node.default['artifacts']['solr']['groupId']         = "org.apache.solr"
  node.default['artifacts']['solr']['artifactId']      = "apache-solr"
  node.default['artifacts']['solr']['version']         = "1.4.1-alfresco-patched"
end

node.default['artifacts']['solr']['type']              = "war"
node.default['artifacts']['solr']['destination']       = node['tomcat']['webapp_dir']
node.default['artifacts']['solr']['owner']             = node['tomcat']['user']
node.default['artifacts']['solr']['unzip']             = false

#Solr URL
node.default['alfresco']['properties']['solr.host']          = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['solr.port']          = node['alfresco']['default_port']
node.default['alfresco']['properties']['solr.port.ssl']      = node['alfresco']['default_portssl']
node.default['alfresco']['properties']['solr.secureComms']   = 'https'

#solrcore.properties placeholders
node.default['alfresco']['solrproperties']['alfresco.host']            = node['alfresco']['properties']['alfresco.host']
node.default['alfresco']['solrproperties']['alfresco.port']            = node['alfresco']['properties']['alfresco.port']
node.default['alfresco']['solrproperties']['alfresco.port.ssl']        = node['alfresco']['properties']['alfresco.port.ssl']
node.default['alfresco']['solrproperties']['alfresco.baseUrl']         = node['alfresco']['properties']['alfresco.context']
node.default['alfresco']['solrproperties']['alfresco.secureComms']     = node['alfresco']['properties']['solr.secureComms']

# Filtering properties with attributes defined above
node.default['artifacts']['solrhome']['properties']['archive-SpacesStore/conf/solrcore.properties']    = node['alfresco']['solrproperties']
node.default['artifacts']['solrhome']['properties']['workspace-SpacesStore/conf/solrcore.properties']  = node['alfresco']['solrproperties']
node.default['artifacts']['solrhome']['properties']['log4j-solr.properties']                           = node['alfresco']['solr-log4j']
