directory "alfresco-rootdir" do
  path        node['alfresco']['root_dir']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

unless node.attribute?("artifacts") and node['artifacts'].attribute?("classes")
  directory "alfresco-classes" do
    path        "#{node['tomcat']['shared']}/classes"
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0775"
    recursive   true
    subscribes  :create, "directory[alfresco-rootdir]", :immediately
  end

  template "alfresco-global" do
    path        "#{node['tomcat']['shared']}/classes/alfresco-global.properties"
    source      "alfresco-global.properties.erb"
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0660"
    subscribes  :create, "directory[alfresco-classes]", :immediately
  end

  directory "alfresco-extension" do
    path        "#{node['tomcat']['shared']}/classes/alfresco/extension"
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0775"
    recursive   true
    subscribes  :create, "directory[alfresco-global]", :immediately
  end

  template "repo-log4j.properties" do
    path        "#{node['tomcat']['shared']}/classes/alfresco/extension/repo-log4j.properties"
    source      "repo-log4j.properties.erb"
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0664"
    subscribes  :create, "directory[alfresco-extension]", :immediately
  end
else
  template "alfresco-global-provided" do
    path        "#{node['tomcat']['shared']}/classes/alfresco-global.properties"
    source      "#{node['tomcat']['shared']}/classes/alfresco-global.properties.erb"
    local       true
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0660"
    only_if { File.exist?("#{node['tomcat']['shared']}/classes/alfresco-global.properties.erb") }
    subscribes  :create, "execute[unzipping_package-classes]", :immediately
  end
end