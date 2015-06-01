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

  node.default['artifacts']['solr4']['groupId']         = node['alfresco']['groupId']
  node.default['artifacts']['solr4']['artifactId']      = "alfresco-solr4"
  node.default['artifacts']['solr4']['version']         = node['alfresco']['version']
else
  node.default['artifacts']['solr']['groupId']         = "org.apache.solr"
  node.default['artifacts']['solr']['artifactId']      = "apache-solr"
  node.default['artifacts']['solr']['version']         = "1.4.1-alfresco-patched"
end

node.default['artifacts']['solr']['type']              = "war"
node.default['artifacts']['solr']['destination']       = node['tomcat']['webapp_dir']
node.default['artifacts']['solr']['owner']             = node['tomcat']['user']
node.default['artifacts']['solr']['unzip']             = false

# Filtering properties with attributes defined above
node.default['artifacts']['solrhome']['properties']['archive-SpacesStore/conf/solrcore.properties']    = node['alfresco']['solrproperties']
node.default['artifacts']['solrhome']['properties']['workspace-SpacesStore/conf/solrcore.properties']  = node['alfresco']['solrproperties']
node.default['artifacts']['solrhome']['properties']['log4j-solr.properties']                           = node['alfresco']['solr-log4j']

# Rsyslog defaults are only used if component includes "rsyslog"
node.default['rsyslog']['file_inputs']['solr1']['file'] = '/var/log/tomcat-solr/solr.log'
node.default['rsyslog']['file_inputs']['solr1']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['solr1']['priority'] = 54
node.default['rsyslog']['file_inputs']['solr2']['file'] = '/var/log/tomcat-solr/catalina.out.*'
node.default['rsyslog']['file_inputs']['solr2']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['solr2']['priority'] = 55
