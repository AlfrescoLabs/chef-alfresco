unless node.attribute?("artifacts") and node['artifacts'].attribute?("classes")
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
else
  shared_classes = node['artifacts']['classes']['destination']
  template "share-config-custom.xml-provided" do
    path        "#{shared_classes}/alfresco/web-extension/share-config-custom.xml"
    source      "#{shared_classes}/alfresco/web-extension/share-config-custom.xml.erb"
    local       true
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0660"
    only_if { File.exist?("#{shared_classes}/alfresco/web-extension/share-config-custom.xml.erb") }
    subscribes  :create, "execute[unzipping_package-classes]", :immediately
  end
end