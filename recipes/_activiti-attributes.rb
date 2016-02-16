node.default['activiti']['properties']['jdbc.username'] = node['alfresco']['properties']['db.username']
node.default['activiti']['properties']['jdbc.password'] = node['alfresco']['properties']['db.password']


node.default['activiti']['groupId'] = 'org.activiti'
node.default['activiti']['artifactId'] = "activiti-webapp-explorer2"
node.default['activiti']['version'] = '5.14'

node.default['artifacts']['activiti']['groupId'] = node['activiti']['groupId']
node.default['artifacts']['activiti']['artifactId'] = node['activiti']['artifactId']
node.default['artifacts']['activiti']['version'] = node['activiti']['version']
node.default['artifacts']['activiti']['type'] = "war"
node.default['artifacts']['activiti']['owner'] = node['alfresco']['user']
node.default['artifacts']['activiti']['unzip'] = true

# Share WAR destination
if node['tomcat']['run_base_instance']
  node.default['artifacts']['activiti']['destination'] = node['tomcat']['webapp_dir']
else
  node.default['artifacts']['activiti']['destination'] = "#{node['alfresco']['home']}/activiti/webapps"
end
