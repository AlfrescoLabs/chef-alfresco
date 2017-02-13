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
node.default['artifacts']['solr4']['owner'] = node['alfresco']['user']
node.default['artifacts']['solr4']['unzip'] = false

# Solr Pointers to Alfresco
node.default['alfresco']['workspace-solrproperties']['alfresco.host'] = node['alfresco']['internal_hostname']
node.default['alfresco']['workspace-solrproperties']['alfresco.port.ssl'] = node['alfresco']['internal_portssl']

node.default['alfresco']['archive-solrproperties']['alfresco.host'] = node['alfresco']['internal_hostname']
node.default['alfresco']['archive-solrproperties']['alfresco.port.ssl'] = node['alfresco']['internal_portssl']

if node['alfresco']['components'].include? 'haproxy'
  node.default['alfresco']['workspace-solrproperties']['alfresco.port'] = node['internal_lb']['port']
  node.default['alfresco']['archive-solrproperties']['alfresco.port'] = node['internal_lb']['port']
else
  node.default['alfresco']['workspace-solrproperties']['alfresco.port'] = node['haproxy']['backends']['roles']['alfresco']['port']
  node.default['alfresco']['archive-solrproperties']['alfresco.port'] = node['haproxy']['backends']['roles']['alfresco']['port']
end

# Solr WAR destination
if node['tomcat']['run_base_instance']
  node.default['artifacts']['solr4']['destination'] = node['tomcat']['webapp_dir']
else
  node.default['artifacts']['solr4']['destination'] = "#{node['alfresco']['home']}-solr/webapps"
end
