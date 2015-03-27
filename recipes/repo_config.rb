root_folder       = node['alfresco']['properties']['dir.root']
shared_folder     = node['alfresco']['shared']
config_folder     = node['tomcat']['config_dir']
base_folder       = node['tomcat']['base']
log_folder        = node['tomcat']['log_dir']

user              = node['tomcat']['user']
group             = node['tomcat']['group']

generate_alfresco_global = node['alfresco']['generate.global.properties']

directory "alfresco-rootdir" do
  path        root_folder
  owner       user
  group       group
  mode        "0775"
  recursive   true
end

directory "alfresco-extension" do
  path        "#{shared_folder}/classes/alfresco/extension"
  owner       user
  group       group
  mode        "0775"
  recursive   true
end

file "#{shared_folder}/classes/alfresco/extension/repo-log4j.properties" do
  action :create
  content ""
end

file "alfresco-global-empty" do
  path        "#{shared_folder}/classes/alfresco-global.properties"
  content     ""
  owner       user
  group       group
  mode        "0775"
  only_if     { generate_alfresco_global == true }
end

file_replace_line "#{config_folder}/catalina.properties" do
  replace     "shared.loader="
  with        "shared.loader=#{shared_folder}/classes,#{shared_folder}/*.jar"
  only_if     { File.exist?("#{config_folder}/catalina.properties") }
end

directory "tomcat-logs-permissions" do
  path        log_folder
  owner       user
  group       group
  mode        "0775"
  recursive   true
end

directory "tomcat-base-permissions" do
  path        base_folder
  owner       user
  group       group
  mode        "0775"
  recursive   true
end
