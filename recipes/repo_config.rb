directory "alfresco-rootdir" do
  path        node['alfresco']['properties']['dir.root']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

directory "tomcat-logs-permissions" do
  path        node['tomcat']['log_dir']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

directory "tomcat-base-permissions" do
  path        node['tomcat']['base']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

if node['alfresco']['iptables'] == true
  iptables_rule "alfresco-ports"
end

unless node.attribute?("artifacts") and node['artifacts'].attribute?("classes")
  directory "alfresco-classes" do
    path        "#{node['alfresco']['shared']}/classes"
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0775"
    recursive   true
    subscribes  :create, "directory[alfresco-rootdir]", :immediately
  end

  template "alfresco-global" do
    path        "#{node['alfresco']['shared']}/classes/alfresco-global.properties"
    source      "alfresco-global.properties.erb"
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0660"
    subscribes  :create, "directory[alfresco-classes]", :immediately
  end

  directory "alfresco-extension" do
    path        "#{node['alfresco']['shared']}/classes/alfresco/extension"
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0775"
    recursive   true
    subscribes  :create, "directory[alfresco-global]", :immediately
  end

  template "repo-log4j.properties" do
    path        "#{node['alfresco']['shared']}/classes/alfresco/extension/repo-log4j.properties"
    source      "repo-log4j.properties.erb"
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0664"
    subscribes  :create, "directory[alfresco-extension]", :immediately
  end
else
  # TODO - deprecated, use artifact-deployer filtering instead
  template "alfresco-global-provided" do
    path        "#{node['alfresco']['shared']}/classes/alfresco-global.properties"
    source      "#{node['alfresco']['shared']}/classes/alfresco-global.properties.erb"
    local       true
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0660"
    only_if { File.exist?("#{node['alfresco']['shared']}/classes/alfresco-global.properties.erb") }
    subscribes  :create, "execute[unzipping_package-classes]", :immediately
  end
end