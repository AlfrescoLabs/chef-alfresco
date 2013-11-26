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
default['alfresco']['mavenrepos'] = ["https://artifacts.alfresco.com/nexus/content/groups/public"]

# Used by repository and share recipes
default['alfresco']['default_hostname'] = "localhost"
default['alfresco']['default_port'] = "8080"

# Used by repository, share and solr recipes
default['alfresco']['root_dir'] = "/srv/alfresco/alf_data"
default['alfresco']['log_dir'] = "#{node['tomcat']['log_dir']}"

### Database Settings - used bt mysql_server and repository recipes
default['alfresco']['db']['user']      = "alfresco"
default['alfresco']['db']['password']  = "alfresco"
default['alfresco']['db']['database']  = "alfresco"
default['alfresco']['db']['jdbc_url']  = "jdbc:mysql://localhost/#{node['alfresco']['db']['database']}?useUnicode=yes&characterEncoding=UTF-8"

# @TODO - Should be used by repository and share recipes
default['alfresco']['url']['alfresco']['context']   = "alfresco"
default['alfresco']['url']['alfresco']['host']      = node['alfresco']['default_hostname']
default['alfresco']['url']['alfresco']['port']      = node['alfresco']['default_port']
default['alfresco']['url']['alfresco']['protocol']  = "http"

# @TODO - use it for deployment purposes
default['alfresco']['url']['share']['context']   = "share"
default['alfresco']['url']['share']['host']      = node['alfresco']['default_hostname']
default['alfresco']['url']['share']['port']      = node['alfresco']['default_port']
default['alfresco']['url']['share']['protocol']  = "http"

### Platform Package Settings And Defaults
case platform
when "debian","ubuntu"
  default['alfresco']['pkgs']  = %w{ruby1.9.1-dev libxalan2-java unzip fastjar libmysql-java libxslt-dev libxml2-dev}
else
  node.set['alfresco']['pkgs']  = []
end
