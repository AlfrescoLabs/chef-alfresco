node.default['artifacts']['_vti_bin']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['_vti_bin']['artifactId'] = "alfresco-enterprise-vti-bin"
node.default['artifacts']['_vti_bin']['version'] = node['alfresco']['version']
node.default['artifacts']['_vti_bin']['type'] = 'war'
node.default['artifacts']['_vti_bin']['owner'] = node['alfresco']['user']

node.default['artifacts']['ROOT']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['ROOT']['artifactId'] = "alfresco-enterprise-server-root"
node.default['artifacts']['ROOT']['version'] = node['alfresco']['version']
node.default['artifacts']['ROOT']['type'] = 'war'
node.default['artifacts']['ROOT']['owner'] = node['alfresco']['user']

if node['tomcat']['run_base_instance']
  node.default['artifacts']['_vti_bin']['destination'] = node['tomcat']['webapp_dir']
  node.default['artifacts']['ROOT']['destination'] = node['tomcat']['webapp_dir']
else
  node.default['artifacts']['_vti_bin']['destination'] = "#{node['alfresco']['home']}/alfresco/webapps"
  node.default['artifacts']['ROOT']['destination'] = "#{node['alfresco']['home']}/alfresco/webapps"
end
