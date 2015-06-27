# Rsyslog defaults are only used if component includes "rsyslog"
node.default['rsyslog']['file_inputs']['solr1']['file'] = '/var/log/tomcat-solr/solr.log'
node.default['rsyslog']['file_inputs']['solr1']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['solr1']['priority'] = 54
node.default['rsyslog']['file_inputs']['solr2']['file'] = '/var/log/tomcat-solr/catalina.out.*'
node.default['rsyslog']['file_inputs']['solr2']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['solr2']['priority'] = 55

# Keep it empty and invoke it anyway, since attributes/solr_config.rb must be loaded
node.default['artifacts']['solrhome']['enabled'] = true
node.default['artifacts']['solr4']['enabled'] = true

node.default['alfresco']['solr-log4j']['log4j.appender.File.File'] = "#{node['tomcat']['log_dir']}/solr.log"

# Artifact deployer attributes
node.default['artifacts']['solrhome']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['solrhome']['artifactId'] = "alfresco-solr4"
node.default['artifacts']['solrhome']['version'] = node['alfresco']['version']
node.default['artifacts']['solrhome']['destination'] = node['alfresco']['properties']['dir.root']
node.default['artifacts']['solrhome']['owner'] = node['alfresco']['user']
node.default['artifacts']['solrhome']['unzip'] = true
node.default['artifacts']['solrhome']['type'] = "zip"

node.default['artifacts']['solrhome']['classifier'] = "config"

node.default['artifacts']['solr4']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['solr4']['artifactId'] = "alfresco-solr4"
node.default['artifacts']['solr4']['version'] = node['alfresco']['version']
node.default['artifacts']['solr4']['type'] = "war"
node.default['artifacts']['solr4']['destination'] = node['tomcat']['webapp_dir']
node.default['artifacts']['solr4']['owner'] = node['alfresco']['user']
node.default['artifacts']['solr4']['unzip'] = false

# Solr URLs
node.default['alfresco']['solrproperties']['data.dir.root'] = "#{node['alfresco']['properties']['dir.root']}/solrhome"
node.default['alfresco']['solrproperties']['alfresco.host'] = node['alfresco']['properties']['alfresco.host']
node.default['alfresco']['solrproperties']['alfresco.port'] = node['alfresco']['properties']['alfresco.port']
node.default['alfresco']['solrproperties']['alfresco.port.ssl'] = node['alfresco']['properties']['alfresco.port.ssl']
node.default['alfresco']['solrproperties']['alfresco.baseUrl'] = node['alfresco']['properties']['alfresco.context']
node.default['alfresco']['solrproperties']['alfresco.secureComms'] = node['alfresco']['properties']['solr.secureComms']

# Overriding tomcat properties -  tomcat single instance
node.set["tomcat"]["java_options"] = "#{node['tomcat']['java_options']} -Dsolr.solr.home=#{node['alfresco']['solrproperties']['data.dir.root']}"

# Overriding tomcat properties -  tomcat multi-homed instance
node.set['alfresco']['solr_tomcat_instance']['java_options'] = "#{node['alfresco']['solr_tomcat_instance']['java_options']} -Dsolr.solr.home=#{node['alfresco']['solrproperties']['data.dir.root']}"
