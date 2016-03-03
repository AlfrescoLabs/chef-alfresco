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
node.default['artifacts']['activiti']['destination'] = "#{node['alfresco']['home']}#{"/activiti" unless node['tomcat']['run_single_instance']}/webapps"
