#
# Cookbook Name:: alfresco
# attributes:: default
#
# Author:: Fletcher Nichol (<fnichol@nichol.ca>)
#
# Copyright:: 2011, Fletcher Nichol
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
default['alfresco']['solrconf']['groupId']    = "org.alfresco"
default['alfresco']['solrconf']['artifactId'] = "alfresco-solr"
default['alfresco']['solrconf']['version']    = node['alfresco']['version']

default['alfresco']['solr']['alfresco_host']    = node['alfresco']['url']['repo']['host']
default['alfresco']['solr']['alfresco_context'] = "/#{node['alfresco']['url']['repo']['context']}"
default['alfresco']['solr']['alfresco_port']    = node['alfresco']['url']['repo']['port']
default['alfresco']['solr']['alfresco_portssl'] = node['alfresco']['default_portssl']
default['alfresco']['solr']['solr_home']        = "#{node['alfresco']['root_dir']}/solr_home"
default['alfresco']['solr']['war_filename']     = "apache-solr-1.4.1.war"
