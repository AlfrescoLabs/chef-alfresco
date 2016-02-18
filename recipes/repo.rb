node.default['artifacts']['alfresco']['enabled'] = true

# Not needed on standard a installation, unless Solr SSL is enabled
# node.default['artifacts']['keystore']['enabled'] = true

if node['artifacts']['keystore']['enabled']
  node.default['alfresco']['properties']['dir.keystore'] = "#{node['alfresco']['properties']['dir.root']}/keystore/alfresco/keystore"
end

root_folder = node['alfresco']['properties']['dir.root']
shared_folder = node['alfresco']['shared']
config_folder = node['alfresco']['config_dir']

user = node['alfresco']['user']
group = node['tomcat']['group']

alfresco_license_source = node['alfresco']['license_source']
alfresco_license_cookbook = node['alfresco']['license_cookbook']

generate_alfresco_global = node['alfresco']['generate.global.properties']

if node['alfresco']['generate.global.properties'] == true
  node.default['artifacts']['sharedclasses']['properties']['alfresco-global.properties'] = node['alfresco']['properties']
end

if node['alfresco']['generate.repo.log4j.properties'] == true
  node.default['artifacts']['sharedclasses']['properties']['alfresco/log4j.properties'] = node['alfresco']['log4j']
end

if node['activiti-app']['generate.properties'] == true
  if node['activiti-app']['edition'] == "community"
    node.default['artifacts']['sharedclasses']['properties']['db.properties'] = node['activiti-app']["community"]['properties']
  else
    node.default['artifacts']['activiticlasses']['properties']['activiti-app.properties'] = node['activiti-app']["enterprise"]['properties']
  end
end

directory "alfresco-rootdir" do
  path root_folder
  owner user
  group group
  mode "0775"
  recursive true
end

#TODO - make it generic using File.dirName(repo_log4j_path)
directory "alfresco-extension" do
  path "#{shared_folder}/classes/alfresco/extension"
  owner user
  group group
  mode "0775"
  recursive true
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
  path "#{shared_folder}/classes/alfresco-global.properties"
  content ""
  owner user
  group group
  mode "0775"
  only_if { generate_alfresco_global == true }
end

file "#{shared_folder}/classes/db.properties" do
  content ""
  owner user
  group group
  mode '0644'
  only_if { node['activiti-app']['edition'] == "community" }
end


file "#{node['alfresco']['home']}/activiti/lib/activiti-app.properties" do
  content ""
  owner user
  group group
  mode '0644'
  only_if { node['activiti-app']['edition'] == "enterprise" }
end

file_replace_line "#{config_folder}/catalina.properties" do
  replace "shared.loader="
  with "shared.loader=#{shared_folder}/classes,#{shared_folder}/lib/*.jar"
  only_if { File.exist?("#{config_folder}/catalina.properties") }
end


