root_folder       = node['alfresco']['properties']['dir.root']
shared_folder     = node['alfresco']['shared']
repo_log4j_path   = node['alfresco']['repo-log4j-path']
config_folder     = node['tomcat']['config_dir']
base_folder       = node['tomcat']['base']
log_folder        = node['tomcat']['log_dir']

user              = node['tomcat']['user']
group             = node['tomcat']['group']

alfresco_license_source = node['alfresco']['license_source']
alfresco_license_cookbook = node['alfresco']['license_cookbook']

generate_alfresco_global = node['alfresco']['generate.global.properties']

directory "alfresco-rootdir" do
  path        root_folder
  owner       user
  group       group
  mode        "0775"
  recursive   true
end

#TODO - make it generic using File.dirName(repo_log4j_path)
directory "alfresco-extension" do
  path        "#{shared_folder}/classes/alfresco/extension"
  owner       user
  group       group
  mode        "0775"
  recursive   true
end

# Install license
remote_directory "#{shared_folder}/classes/alfresco/extension/license" do
  source alfresco_license_source
  cookbook alfresco_license_cookbook
  owner user
  group group
  mode "0644"
  ignore_failure true
end

file repo_log4j_path do
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
