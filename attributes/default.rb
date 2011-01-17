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

case node.platform
when "debian","ubuntu"
  set[:java][:install_flavor] = "sun"
else
  set[:java][:install_flavor] = "openjdk"
end

set[:mysql][:bind_address] = "0.0.0.0"

default[:alfresco][:java_opts] = "-Xms128m -Xmx1024m -XX:MaxPermSize=128m -Djava.awt.headless=true"
set[:tomcat][:java_options] = node[:alfresco][:java_opts]

set[:tomcat][:restart_timing] = "immediately"

default[:alfresco][:version] = "3.4.c"
default[:alfresco][:zip_url] = "http://dl.alfresco.com/release/community/build-3335/alfresco-community-3.4.c.zip?dl_file=release/community/build-3335/alfresco-community-3.4.c.zip"
default[:alfresco][:zip_sha256] = "90c9181e35e167d89aa212b668d504d2"

default[:alfresco][:db][:user]      = "alfresco"
default[:alfresco][:db][:password]  = "alfresco"
default[:alfresco][:db][:database]  = "alfresco"
default[:alfresco][:db][:jdbc_url]  = "jdbc:mysql://localhost/#{node[:alfresco][:db][:database]}?useUnicode=yes&characterEncoding=UTF-8"

default[:alfresco][:root_dir] = "/srv/alfresco/alf_data"
default[:alfresco][:ooo][:exe]  = "/usr/bin/soffice"
default[:alfresco][:ooo][:enabled]  = "true"
default[:alfresco][:img][:root]  = "/usr"
default[:alfresco][:swf][:exe]  = "/usr/bin/pdf2swf"

default[:alfresco][:mail][:protocol]        = "smtp"
default[:alfresco][:mail][:port]            = "25"
default[:alfresco][:mail][:username]        = "anonymous"
default[:alfresco][:mail][:encoding]        = "UTF-8"
default[:alfresco][:mail][:from][:default]  = "alfresco@alfresco.org"
default[:alfresco][:mail][:smtp][:auth]     = "false"

default[:alfresco][:nginx][:proxy]        = "enable"
default[:alfresco][:nginx][:www_redirect] = "enable"
default[:alfresco][:nginx][:listen_ports] = [ 80 ]
default[:alfresco][:nginx][:host_name]    = "0.0.0.0"
default[:alfresco][:nginx][:host_aliases] = []
