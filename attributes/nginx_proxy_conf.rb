#
# Cookbook Name:: alfresco
# attributes:: nginx_proxy_conf
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

default[:alfresco][:nginx][:proxy]                = "enable"
default[:alfresco][:nginx][:www_redirect]         = "enable"
default[:alfresco][:nginx][:listen_ports]         = [ 80 ]
default[:alfresco][:nginx][:host_name]            = "0.0.0.0"
default[:alfresco][:nginx][:host_aliases]         = []
default[:alfresco][:nginx][:client_max_body_size] = "1024m"
