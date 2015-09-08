# Alfresco dir root (used in _alfrescoproperties-attributes.rb and below)
node.default['alfresco']['properties']['dir.root'] = "#{node['alfresco']['home']}/alf_data"
node.default['alfresco']['properties']['dir.keystore'] = "#{node['alfresco']['properties']['dir.root']}/keystore/alfresco/keystore"

# Repo config
node.default['alfresco']['properties']['alfresco.host'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['alfresco.port.ssl'] = node['alfresco']['default_portssl']
node.default['alfresco']['properties']['alfresco.protocol'] = node['alfresco']['default_protocol']

# Solr Common attributes (used in _tomcat-attributes.rb)
node.default['alfresco']['solrproperties']['data.dir.root'] = "#{node['alfresco']['properties']['dir.root']}/solrhome"
node.default['alfresco']['solrproperties']['alfresco.host'] = node['alfresco']['properties']['alfresco.host']
node.default['alfresco']['solrproperties']['alfresco.port.ssl'] = node['alfresco']['properties']['alfresco.port.ssl']
node.default['alfresco']['solrproperties']['alfresco.baseUrl'] = "/#{node['alfresco']['properties']['alfresco.context']}"
node.default['alfresco']['solrproperties']['alfresco.secureComms'] = node['alfresco']['properties']['solr.secureComms']
