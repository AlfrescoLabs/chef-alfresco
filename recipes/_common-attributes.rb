# Alfresco dir root (used in _alfrescoproperties-attributes.rb and below)
node.default['alfresco']['properties']['dir.root'] = "#{node['alfresco']['home']}/alf_data"
node.default['alfresco']['properties']['dir.keystore'] = "#{node['alfresco']['properties']['dir.root']}/keystore/alfresco/keystore"

# Solr Common attributes (used in _tomcat-attributes.rb)
node.default['alfresco']['solrproperties']['alfresco_models'] = "#{node['alfresco']['properties']['dir.root']}/newAlfrescoModels"
node.default['alfresco']['solrproperties']['data.dir.root'] = "#{node['alfresco']['properties']['dir.root']}/solrhome"
node.default['alfresco']['solrproperties']['alfresco.baseUrl'] = "/#{node['alfresco']['properties']['alfresco.context']}"
node.default['alfresco']['solrproperties']['alfresco.secureComms'] = node['alfresco']['properties']['solr.secureComms']

# If haproxy is configured and not nginx, Tomcat should redirect to internal ports
# see attributes/default.rb
if node['alfresco']['components'].include? 'haproxy'
  unless node['alfresco']['components'].include? 'nginx'
    node.default['alfresco']['public_portssl'] = node.default['alfresco']['internal_portssl']
    node.default['haproxy']['bind_ip'] = "0.0.0.0"
  end
end

# If enabled, Tomcat SSL Connector will use this redirectPort
node.default['tomcat']['ssl_redirect_port'] = node['alfresco']['public_portssl']
