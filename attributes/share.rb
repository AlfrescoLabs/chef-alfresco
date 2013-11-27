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
default['alfresco']['share']['groupId'] = node['alfresco']['repository']['groupId']
default['alfresco']['share']['artifactId'] = "share"
default['alfresco']['share']['version'] = node['alfresco']['repository']['version']

default['alfresco']['share']['alfresco_protocol'] = node['alfresco']['url']['repo']['protocol']
default['alfresco']['share']['alfresco_host'] = node['alfresco']['url']['repo']['host']
default['alfresco']['share']['alfresco_port'] = node['alfresco']['url']['repo']['port']
default['alfresco']['share']['alfresco_context'] = node['alfresco']['url']['repo']['context']