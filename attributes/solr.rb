# Keep it empty and invoke it anyway, since attributes/solr_config.rb must be loaded
default['artifacts']['solrhome']['enabled'] = true
default['artifacts']['solr4']['enabled'] = true

default['alfresco']['solr-log4j']['log4j.appender.File.File'] = "#{node['tomcat']['log_dir']}/solr.log"

# Haproxy configuration
default['haproxy']['backends']['solr4']['acls'] = ['path_beg /solr4']
default['haproxy']['backends']['solr4']['entries'] = ["option httpchk GET /solr4","cookie JSESSIONID prefix","balance url_param JSESSIONID check_post"]
default['haproxy']['backends']['solr4']['nodes']['localhost'] = "127.0.0.1"
default['haproxy']['backends']['solr4']['port'] = 8090

# Artifact deployer attributes
default['artifacts']['solrhome']['groupId'] = node['alfresco']['groupId']
default['artifacts']['solrhome']['artifactId'] = "alfresco-solr4"
default['artifacts']['solrhome']['version'] = node['alfresco']['version']
default['artifacts']['solrhome']['destination'] = node['alfresco']['properties']['dir.root']
default['artifacts']['solrhome']['owner'] = node['alfresco']['user']
default['artifacts']['solrhome']['unzip'] = true
default['artifacts']['solrhome']['type'] = "zip"

default['artifacts']['solrhome']['classifier'] = "config"

default['artifacts']['solr4']['groupId'] = node['alfresco']['groupId']
default['artifacts']['solr4']['artifactId'] = "alfresco-solr4"
default['artifacts']['solr4']['version'] = node['alfresco']['version']
default['artifacts']['solr4']['type'] = "war"
default['artifacts']['solr4']['destination'] = node['tomcat']['webapp_dir']
default['artifacts']['solr4']['owner'] = node['alfresco']['user']
default['artifacts']['solr4']['unzip'] = false

# Solr URLs
default['alfresco']['solrproperties']['data.dir.root'] = "#{node['alfresco']['properties']['dir.root']}/solrhome"
default['alfresco']['solrproperties']['alfresco.host'] = node['alfresco']['properties']['alfresco.host']
default['alfresco']['solrproperties']['alfresco.port'] = node['alfresco']['properties']['alfresco.port']
default['alfresco']['solrproperties']['alfresco.port.ssl'] = node['alfresco']['properties']['alfresco.port.ssl']
default['alfresco']['solrproperties']['alfresco.baseUrl'] = node['alfresco']['properties']['alfresco.context']
default['alfresco']['solrproperties']['alfresco.secureComms'] = node['alfresco']['properties']['solr.secureComms']
