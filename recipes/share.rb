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

share_groupId             = node['alfresco']['share']['groupId']
share_artifactId          = node['alfresco']['share']['artifactId']
share_version             = node['alfresco']['share']['version']

webapp_dir                = node['tomcat']['webapp_dir']
alfresco_user             = node['tomcat']['user']

maven "share" do
  artifact_id "#{share_artifactId}"
  group_id "#{share_groupId}"
  version  "#{share_version}"
  action :put
  dest     "#{webapp_dir}"
  owner    alfresco_user
  packaging 'war'
  repositories maven_repos
  notifies  :restart, "service[tomcat]"
end