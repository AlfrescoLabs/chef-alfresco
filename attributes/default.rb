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

# Used by all recipes that need to fetch artifacts from Maven
default['alfresco']['maven']['repo_type'] = "public"
default['alfresco']['maven']['repo_id'] = "alfresco-#{node['alfresco']['maven']['repo_type']}"
default['alfresco']['maven']['repo_url'] = "https://artifacts.alfresco.com/nexus/content/groups/#{node['alfresco']['maven']['repo_type']}"
default['alfresco']['maven']['repos'] = ["#{node['alfresco']['maven']['repo_id']}::::#{node['alfresco']['maven']['repo_url']}"]

default['alfresco']['groupId'] = "org.alfresco"
default['alfresco']['version'] = "4.2.e"

# Used by repository and share recipes
default['alfresco']['default_hostname'] = "localhost"
# @TEST default['alfresco']['default_hostname'] = node['fqdn']
default['alfresco']['default_port'] = "8080"
default['alfresco']['default_portssl'] = "8443"
default['alfresco']['default_protocol'] = "http"

# Used by repository, share and solr recipes
default['alfresco']['root_dir'] = "/srv/alfresco/alf_data"
default['alfresco']['log_dir'] = node['tomcat']['log_dir']

### Database Settings - used bt mysql_server and repository recipes
default['alfresco']['db']['user']      = "alfresco"
default['alfresco']['db']['password']  = "alfresco"
default['alfresco']['db']['database']  = "alfresco"
default['alfresco']['db']['host']  = node['alfresco']['default_hostname']

# @TODO - use contexts for deployment purposes

# Used by repository, share and solr recipes (see related .rb attributes files)
default['alfresco']['url']['repo']['context']   = "alfresco"
default['alfresco']['url']['repo']['host']      = node['alfresco']['default_hostname']
default['alfresco']['url']['repo']['port']      = node['alfresco']['default_port']
default['alfresco']['url']['repo']['protocol']  = node['alfresco']['default_protocol']

default['alfresco']['url']['solr']['context']   = "solr" #@TODO - not used right now
default['alfresco']['url']['solr']['host']      = node['alfresco']['default_hostname']
default['alfresco']['url']['solr']['port']      = node['alfresco']['default_port']
default['alfresco']['url']['solr']['protocol']  = node['alfresco']['default_protocol']

default['alfresco']['url']['share']['context']   = "share"
default['alfresco']['url']['share']['host']      = node['alfresco']['default_hostname']
default['alfresco']['url']['share']['port']      = node['alfresco']['default_port']
default['alfresco']['url']['share']['protocol']  = node['alfresco']['default_protocol']

default['alfresco']['url']['repo']['host']      = node['alfresco']['default_hostname']
default['alfresco']['url']['share']['host']      = node['alfresco']['default_hostname']
default['alfresco']['url']['solr']['host']      = node['alfresco']['default_hostname']
