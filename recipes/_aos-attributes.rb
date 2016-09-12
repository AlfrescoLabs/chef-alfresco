if node['tomcat']['run_base_instance']
  node.default['artifacts']['_vti_bin']['destination'] = node['tomcat']['webapp_dir']
  node.default['artifacts']['ROOT']['destination'] = node['tomcat']['webapp_dir']
else
  node.default['artifacts']['_vti_bin']['destination'] = "#{node['alfresco']['home']}-alfresco/webapps"
  node.default['artifacts']['ROOT']['destination'] = "#{node['alfresco']['home']}-alfresco/webapps"
end
