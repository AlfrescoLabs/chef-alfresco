# Add Repo backend entries to local instance
node.default['haproxy']['backends']['alfresco']['nodes']['localhost'] = node['alfresco']['internal_hostname']
node.default['haproxy']['backends']['aos_vti']['nodes']['localhost'] = node['alfresco']['internal_hostname']
node.default['haproxy']['backends']['aos_root']['nodes']['localhost'] = node['alfresco']['internal_hostname']

node.default['artifacts']['alfresco']['enabled'] = true
node.default['artifacts']['keystore']['enabled'] = true

root_folder       = node['alfresco']['properties']['dir.root']
shared_folder     = node['alfresco']['shared']
config_folder     = node['tomcat']['config_dir']
log_folder        = node['tomcat']['log_dir']

user              = node['alfresco']['user']
group             = node['tomcat']['group']

alfresco_license_source = node['alfresco']['license_source']
alfresco_license_cookbook = node['alfresco']['license_cookbook']

generate_alfresco_global = node['alfresco']['generate.global.properties']

if node['alfresco']['generate.global.properties'] == true
  node.default['artifacts']['sharedclasses']['properties']['alfresco-global.properties'] = node['alfresco']['properties']
end

if node['alfresco']['generate.repo.log4j.properties'] == true
  node.default['artifacts']['sharedclasses']['properties']['alfresco/log4j.properties'] = node['alfresco']['log4j']
end

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
  files_owner user
  files_group group
  files_mode "0777"
  mode "0777"
  ignore_failure true
end

file "#{shared_folder}/classes/alfresco/log4j.properties" do
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
  with        "shared.loader=#{shared_folder}/classes,#{shared_folder}/lib/*.jar"
  only_if     { File.exist?("#{config_folder}/catalina.properties") }
end

directory "tomcat-logs-permissions" do
  path        log_folder
  owner       user
  group       group
  mode        "0775"
  recursive   true
end
