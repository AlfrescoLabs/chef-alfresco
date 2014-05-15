directory "alfresco-rootdir" do
  path        node['alfresco']['properties']['dir.root']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

directory "alfresco-extension" do
  path        "#{node['alfresco']['shared']}/classes/alfresco/extension"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

file "alfresco-global-empty" do
  path        "#{node['alfresco']['shared']}/classes/alfresco-global.properties"
  content     ""
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
end

file_replace "#{node['tomcat']['base']}/conf/catalina.properties" do
  replace "shared.loader="
  with    "shared.loader=${catalina.base}/shared/classes,${catalina.base}/shared/*.jar"
  only_if { File.exist?("#{node['tomcat']['base']}/conf/catalina.properties") }
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