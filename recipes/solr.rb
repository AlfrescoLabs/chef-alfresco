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
alfresco_user             = node['tomcat']['user']

solr_groupId              = node['alfresco']['solr']['groupId']
solr_artifactId           = node['alfresco']['solr']['artifactId']
solr_version              = node['alfresco']['solr']['version']

solr_conf_groupId         = node['alfresco']['solrconf']['groupId']
solr_conf_artifactId      = node['alfresco']['solrconf']['artifactId']
solr_conf_version         = node['alfresco']['solrconf']['version']

webapp_dir                = node['tomcat']['webapp_dir']

maven "solr" do
  artifact_id "#{solr_artifactId}"
  group_id "#{solr_groupId}"
  version  "#{solr_version}"
  action :put
  dest     "#{webapp_dir}"
  owner    alfresco_user
  packaging 'war'
  repositories maven_repos
  notifies  :restart, "service[tomcat]"
end

maven "#{solr_conf_artifactId}" do
  group_id "#{solr_conf_groupId}"
  version  "#{solr_conf_version}"
  action :install
  dest     "#{root_dir}"
  owner    alfresco_user
  packaging 'zip'
  repositories maven_repos
  notifies  :restart, "service[tomcat]"
end

ark 'solr_home' do
  url "file://#{root_dir}/#{solr_conf_artifactId}-#{solr_conf_version}.zip"
  path "file://#{root_dir}"
  owner alfresco_user
end