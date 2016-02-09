# Additional Alfresco paths
node.default['alfresco']['bin'] = "#{node['alfresco']['home']}/bin"
node.default['alfresco']['shared'] = "#{node['alfresco']['home']}/shared"
node.default['alfresco']['shared_lib'] = "#{node['alfresco']['shared']}/lib"
node.default['alfresco']['amps_folder'] = "#{node['alfresco']['home']}/amps"
node.default['alfresco']['amps_share_folder'] = "#{node['alfresco']['home']}/amps_share"

node.default['alfresco']['server_info'] = "Alfresco (#{node['alfresco']['default_hostname']})"

node.default['alfresco']['log4j'] = node['logging']

#JMX host
node.default['alfresco']['properties']['hostname.public'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['hostname.private'] = node['alfresco']['default_hostname']

#Email
node.default['alfresco']['properties']['mail.from.default'] = "webmaster@#{node['alfresco']['default_hostname']}"

#Search Config
node.default['alfresco']['properties']['solr.host'] = node['alfresco']['default_hostname']

if node['alfresco']['solr_tomcat_instance']['ssl_port']
  node.default['alfresco']['properties']['solr.port.ssl'] = node['alfresco']['solr_tomcat_instance']['ssl_port']
else
  node.default['alfresco']['properties']['solr.port.ssl'] = node['alfresco']['default_portssl']
end

#Share URLs
node.default['alfresco']['properties']['share.host'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['share.protocol'] = node['alfresco']['default_protocol']

# OpenCMIS
node.default['alfresco']['properties']['opencmis.server.host'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['opencmis.server.protocol'] = node['alfresco']['default_protocol']

# AOS
node.default['alfresco']['properties']['aos.baseProtocol'] = node['alfresco']['default_protocol']
node.default['alfresco']['properties']['aos.baseHost'] = node['alfresco']['default_hostname']

# Alfresco to Solr pointer, alfresco.port and share.port
if node['alfresco']['components'].include? "haproxy"
  node.default['alfresco']['properties']['solr.port'] = node['haproxy']['port']
  node.default['alfresco']['properties']['alfresco.port'] = node['haproxy']['port']
  node.default['alfresco']['properties']['share.port'] = node['haproxy']['port']
elsif node['alfresco']['components'].include? "tomcat" and node['tomcat']['run_base_instance'] == false
  node.default['alfresco']['properties']['solr.port'] = node['alfresco']['solr_tomcat_instance']['port']
  node.default['alfresco']['properties']['alfresco.port'] = node['alfresco']['repo_tomcat_instance']['port']
  node.default['alfresco']['properties']['share.port'] = node['alfresco']['share_tomcat_instance']['port']
  node.default['alfresco']['properties']['activiti.port'] = node['alfresco']['activiti_tomcat_instance']['port']
else
  node.default['alfresco']['properties']['solr.port'] = node['alfresco']['default_port']
  node.default['alfresco']['properties']['alfresco.port'] = node['alfresco']['default_port']
  node.default['alfresco']['properties']['share.port'] = node['alfresco']['default_port']
end
