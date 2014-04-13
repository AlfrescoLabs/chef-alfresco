directory "alfresco-classes-share" do
  path        "#{node['tomcat']['shared']}/classes"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

directory "web-extension" do
  path        "#{node['tomcat']['shared']}/classes/alfresco/web-extension"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
  subscribes  :create, "directory[alfresco-classes-share]", :immediately
end
 
template "share-config-custom.xml" do
  path        "#{node['tomcat']['shared']}/classes/alfresco/web-extension/share-config-custom.xml"
  source      "share-config-custom.xml.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0664"
  subscribes  :create, "directory[web-extension]", :immediately
end

#   template "share-log4j" do
#     path        "#{cache_path}/share/WEB-INF/classes/log4j.properties"
#     source      "share-log4j.properties.erb"
#     owner       tomcat_user
#     group       tomcat_group
#     mode        "0664"
#     subscribes  :create, "ark[share]", :immediately
#   end