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
maven_repos               = node['alfresco']['mavenrepos']
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

Array(node['alfresco']['pkgs']).each do |pkg|
  package pkg
end

# execute "clean-tomcat" do
#   command   "sh #{tomcat_dir}/bin/clean_tomcat.sh"
#   not_if    %{test -f #{webapp_dir}/alfresco.war}
# end

directory root_dir do
  owner       alfresco_user
  group       alfresco_group
  mode        "0755"
  recursive   true
end

template "#{tomcat_base_dir}/shared/classes/alfresco-global.properties" do
  source    "alfresco-global.properties.erb"
  owner     alfresco_user
  group     alfresco_group
  mode      "0640"
  notifies  :restart, "service[tomcat]"
end
 
template "#{tomcat_base_dir}/shared/classes/log4j.properties" do
  source    "log4j.properties.erb"
  owner     alfresco_user
  group     alfresco_group
  mode      "0644"
  notifies  :restart, "service[tomcat]"
end

maven 'mysql-connector-java' do
  group_id  'mysql'
  version   "#{mysql_connector_version}"
  dest      "#{tomcat_dir}/lib/"
  notifies  :restart, "service[tomcat]"
end

maven "alfresco" do
  artifact_id "#{repo_artifactId}"
  group_id "#{repo_groupId}"
  version  "#{repo_version}"
  action :put
  dest     "#{webapp_dir}"
  owner    alfresco_user
  packaging 'war'
  repositories maven_repos
  notifies  :restart, "service[tomcat]"
end