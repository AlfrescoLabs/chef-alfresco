template "alfresco-global" do
  path        "#{node['tomcat']['shared']}/classes/alfresco-global.properties"
  source      "alfresco-global.properties.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0660"
end

directory "alfresco-rootdir" do
  path        node['alfresco']['root_dir']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

directory "alfresco-extension" do
  path        "#{node['tomcat']['shared']}/alfresco/extension"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

template "repo-log4j.properties" do
  path        "#{node['tomcat']['shared']}/alfresco/extension/repo-log4j.properties"
  source      "repo-log4j.properties.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0664"
  subscribes  :create, "directory[alfresco-extension]", :immediately
end

# service "tomcat7"  do
#   action      :restart
#   subscribes  :restart, "ruby-block[deploy-repo-warpath]",:immediately
#   subscribes  :restart, "ruby-block[deploy-alfresco]",:immediately
# end

