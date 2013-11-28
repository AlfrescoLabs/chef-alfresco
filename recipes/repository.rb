#
# Cookbook Name:: alfresco
# Recipe:: app_server
#
# Copyright 2011, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
maven_repos               = node['alfresco']['maven']['repos']
root_dir                  = node['alfresco']['root_dir']
mysql_connector_version   = node['alfresco']['mysqlconnector']['version']

repo_groupId              = node['alfresco']['repository']['groupId']
repo_artifactId           = node['alfresco']['repository']['artifactId']
repo_version              = node['alfresco']['repository']['version']

webapp_dir                = node['tomcat']['webapp_dir']
tomcat_dir                = node['tomcat']['home']
tomcat_base_dir           = node['tomcat']['base']

alfresco_user             = node['tomcat']['user']
alfresco_group            = node['tomcat']['group']
cache_path                = Chef::Config['file_cache_path']

require 'nokogiri'

directory "root-dir" do
  path        root_dir
  owner       alfresco_user
  group       alfresco_group
  mode        "0775"
  recursive   true
end

template "alfresco-global" do
  path        "#{tomcat_base_dir}/shared/classes/alfresco-global.properties"
  source      "alfresco-global.properties.erb"
  owner       alfresco_user
  group       alfresco_group
  mode        "0660"
  subscribes  :create, "directory[root-dir]", :immediately
end

directory "classes-alfresco" do
  path        "#{tomcat_base_dir}/shared/classes/alfresco"
  owner       alfresco_user
  group       alfresco_group
  mode        "0775"
  subscribes  :create, "template[alfresco-global]", :immediately
end

directory "alfresco-extension" do
  path        "#{tomcat_base_dir}/shared/classes/alfresco/extension"
  owner       alfresco_user
  group       alfresco_group
  mode        "0775"
  subscribes  :create, "directory[classes-alfresco]", :immediately
end
 
template "repo-log4j.properties" do
  path        "#{tomcat_base_dir}/shared/classes/alfresco/extension/repo-log4j.properties"
  source      "repo-log4j.properties.erb"
  owner       alfresco_user
  group       alfresco_group
  mode        "0664"
  subscribes  :create, "directory[alfresco-extension]", :immediately
end

maven 'mysql-connector-java' do
  group_id    'mysql'
  version     mysql_connector_version
  dest        "#{tomcat_dir}/lib/"
  subscribes  :install, "template[repo-log4j.properties]", :immediately
end

maven "alfresco" do
  artifact_id   repo_artifactId
  group_id      repo_groupId
  version       repo_version
  action        :put
  dest          cache_path
  owner         alfresco_user
  packaging     'war'
  repositories  maven_repos
  subscribes    :put, "maven[mysql-connector-java]", :immediately
end

ark "alfresco" do
  url "file://#{cache_path}/alfresco.war"
  path              cache_path
  owner             alfresco_user
  action            :put
  strip_leading_dir false
  append_env_path   false
  subscribes        :put, "maven[alfresco]", :immediately
end

ruby_block "patch-repo-webxml" do
  block do
    file = File.open("#{cache_path}/alfresco/WEB-INF/web.xml", "r")
    content = file.read
    file.close

    node = Nokogiri::HTML::DocumentFragment.parse(content)
    node.search(".//web-app").attr('metadata-complete', 'true')
    node.search(".//security-constraint").remove
    content = node.to_html(:encoding => 'UTF-8', :indent => 2)

    file = File.open("#{cache_path}/alfresco/WEB-INF/web.xml", "w")
    file.write(content)
    file.close unless file == nil    
  end
  subscribes :create, "ark[alfresco]", :immediately
end

ruby_block "deploy-alfresco" do
  block do
    require 'fileutils'
    FileUtils.rm_rf "#{cache_path}/alfresco/alfresco"
    FileUtils.cp_r "#{cache_path}/alfresco","#{webapp_dir}/alfresco"
  end
  subscribes  :create, "ruby-block[patch-repo-webxml]", :immediately
  notifies    :restart, "service[tomcat]"
end
