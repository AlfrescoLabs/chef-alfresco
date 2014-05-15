directory "web-extension" do
  path        "#{node['alfresco']['shared']}/classes/alfresco/web-extension"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
  subscribes  :create, "directory[alfresco-classes-share]", :immediately
end

template "share-config-custom.xml" do
  path        "#{node['alfresco']['shared']}/classes/alfresco/web-extension/share-config-custom.xml"
  source      "share-config-custom.xml.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0664"
  subscribes  :create, "directory[web-extension]", :immediately
end