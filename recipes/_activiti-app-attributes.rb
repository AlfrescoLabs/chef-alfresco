edition = node['activiti-app']['edition']

node.default['activiti-app'][ edition ]['properties']['jdbc.username'] = node['alfresco']['properties']['db.username']
node.default['activiti-app'][ edition ]['properties']['jdbc.password'] = node['alfresco']['properties']['db.password']


node.default['artifacts']['activiticlasses']['unzip'] = false
node.default['artifacts']['activiticlasses']['filtering_mode'] = "append"
node.default['artifacts']['activiticlasses']['destination'] = "#{node['alfresco']['home']}/activiti"
node.default['artifacts']['activiticlasses']['destinationName'] = "lib"
node.default['artifacts']['activiticlasses']['owner'] = node['alfresco']['user']


node.default['activiti-app']["community"]['groupId'] = "org.activiti"
node.default['activiti-app']["community"]['artifactId'] = "activiti-webapp-explorer2"
node.default['activiti-app']["community"]['version'] = "5.14"
node.default['activiti-app']["community"]['type'] = "war"
node.default['activiti-app']["community"]['owner'] = node['alfresco']['user']
node.default['activiti-app']["community"]['unzip'] = true

node.default['activiti-app']['enterprise']['groupId'] = "com.activiti"
node.default['activiti-app']['enterprise']['artifactId'] = "activiti-engine"
node.default['activiti-app']['enterprise']['version'] = "5.20.0.0-SNAPSHOT"
node.default['activiti-app']['enterprise']['type'] = "war"
node.default['activiti-app']['enterprise']['owner'] = node['alfresco']['user']
node.default['activiti-app']['enterprise']['unzip'] = false

node.default['artifacts']['activiti-app']['groupId'] = node['activiti-app'][ edition ]['groupId']
node.default['artifacts']['activiti-app']['artifactId'] = node['activiti-app'][ edition ]['artifactId']
node.default['artifacts']['activiti-app']['version'] = node['activiti-app'][ edition ]['version']
node.default['artifacts']['activiti-app']['type'] = node['activiti-app'][ edition ]['type']
node.default['artifacts']['activiti-app']['owner'] = node['activiti-app'][ edition ]['owner']
node.default['artifacts']['activiti-app']['unzip'] = node['activiti-app'][ edition ]['unzip']


# Share WAR destination
if node['tomcat']['run_base_instance']
  node.default['artifacts']['activiti-app']['destination'] = node['tomcat']['webapp_dir']
else
  node.default['artifacts']['activiti-app']['destination'] = "#{node['alfresco']['home']}/activiti/webapps"
end
