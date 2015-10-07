# Rsyslog defaults are only used if component includes "rsyslog"
node.default['rsyslog']['file_inputs']['share1']['file'] = '/var/log/tomcat-share/share.log'
node.default['rsyslog']['file_inputs']['share1']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['share1']['priority'] = 52
node.default['rsyslog']['file_inputs']['share2']['file'] = '/var/log/tomcat-share/catalina.out.*'
node.default['rsyslog']['file_inputs']['share2']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['share2']['priority'] = 53

# Artifact Deployer attributes
node.default['artifacts']['share']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['share']['artifactId'] = "share"
node.default['artifacts']['share']['version'] = node['alfresco']['version']
node.default['artifacts']['share']['type'] = "war"
node.default['artifacts']['share']['owner'] = node['alfresco']['user']
node.default['artifacts']['share']['unzip'] = false

node.default['artifacts']['hazelcast-cloud']['groupId'] = "com.hazelcast"
node.default['artifacts']['hazelcast-cloud']['artifactId'] = "hazelcast-cloud"
node.default['artifacts']['hazelcast-cloud']['version'] = "2.4"
node.default['artifacts']['hazelcast-cloud']['destination'] = node['alfresco']['shared_lib']
node.default['artifacts']['hazelcast-cloud']['owner'] = node['alfresco']['user']

# Share pointers to Alfresco app
node.default['alfresco']['shareproperties']['alfresco.host'] = node['alfresco']['internal_hostname']
node.default['alfresco']['shareproperties']['alfresco.context'] = node['alfresco']['properties']['alfresco.context']
node.default['alfresco']['shareproperties']['alfresco.protocol'] = node['alfresco']['internal_protocol']
node.default['alfresco']['shareproperties']['alfresco.port'] = node['alfresco']['internal_port']

node.default['alfresco']['shareproperties']['referer'] = "https://#{node['alfresco']['public_hostname']}.*"
node.default['alfresco']['shareproperties']['origin'] = "https://#{node['alfresco']['public_hostname']}"

if node['alfresco']['public_portssl'] != 443
  node.default['alfresco']['shareproperties']['referer'] = "https://#{node['alfresco']['public_hostname']}:#{node['alfresco']['public_portssl']}.*"
  node.default['alfresco']['shareproperties']['origin'] = "https://#{node['alfresco']['public_hostname']}:#{node['alfresco']['public_portssl']}"
end

# Share WAR destination
if node['tomcat']['run_base_instance']
  node.default['artifacts']['share']['destination'] = node['tomcat']['webapp_dir']
else
  node.default['artifacts']['share']['destination'] = "#{node['alfresco']['home']}-share/webapps"
end
