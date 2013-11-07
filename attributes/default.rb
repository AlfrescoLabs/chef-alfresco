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

### Alfresco Package And Version Info

default['alfresco']['version'] = "4.0.b"
default['alfresco']['zip_url'] =
  "http://dl.alfresco.com/release/community/build-3835/alfresco-community-4.0.b.zip"
default['alfresco']['zip_sha256'] =
  "2ea7671e9f9217c91eb0e37a32bd8bcc3a71ac6893c29c2cb80b9cb744f0b799"


### Default Stack-wide Host And Port Defaults

default['alfresco']['default_hostname'] = node['fqdn']
default['alfresco']['default_port']     = "8080"

default['alfresco']['java_opts'] =
  "-Xms128m -Xmx1024m -XX:MaxPermSize=128m -Djava.awt.headless=true"
node.set['tomcat']['java_options'] = node['alfresco']['java_opts']

node.set['tomcat']['restart_timing'] = "immediately"


### Database Settings

default['alfresco']['db']['user']      = "alfresco"
default['alfresco']['db']['password']  = "alfresco"
default['alfresco']['db']['database']  = "alfresco"
default['alfresco']['db']['jdbc_url']  =
  "jdbc:mysql://localhost/#{node['alfresco']['db']['database']}?useUnicode=yes&characterEncoding=UTF-8"

default['alfresco']['root_dir'] = "/srv/alfresco/alf_data"

default['alfresco']['img']['root'] = "/usr"
default['alfresco']['swf']['exe']  = "/usr/bin/pdf2swf"

default['alfresco']['ooo']['exe']      = "/usr/lib/openoffice/program/soffice"
default['alfresco']['ooo']['enabled']  = "true"

default['alfresco']['jodconverter']['enabled']       = "true"
default['alfresco']['jodconverter']['office_home']   = "/usr/lib/openoffice"
default['alfresco']['jodconverter']['port_numbers']  = "8100"


### Mail Defaults

default['alfresco']['mail']['protocol']         = "smtp"
default['alfresco']['mail']['port']             = "25"
default['alfresco']['mail']['username']         = "anonymous"
default['alfresco']['mail']['encoding']         = "UTF-8"
default['alfresco']['mail']['from']['default']  = "alfresco@alfresco.org"

default['alfresco']['mail']['smtp']['auth']                 = "false"
default['alfresco']['mail']['smtps']['auth']                = "false"
default['alfresco']['mail']['smtps']['starttls']['enable']  = "false"


### Alfresco URL Construction Defaults

default['alfresco']['url']['alfresco']['context']   = "alfresco"
default['alfresco']['url']['alfresco']['host']      = node['alfresco']['default_hostname']
default['alfresco']['url']['alfresco']['port']      = node['alfresco']['default_port']
default['alfresco']['url']['alfresco']['protocol']  = "http"

default['alfresco']['url']['share']['context']   = "share"
default['alfresco']['url']['share']['host']      = node['alfresco']['default_hostname']
default['alfresco']['url']['share']['port']      = node['alfresco']['default_port']
default['alfresco']['url']['share']['protocol']  = "http"


### IMAP Server Defaults

default['alfresco']['imap']['server']['enabled']  = "false"
default['alfresco']['imap']['server']['port']     = "1143"
default['alfresco']['imap']['server']['host']     = "0.0.0.0"


### CIFS Server Defaults

default['alfresco']['cifs']['enabled']                      = "false"
default['alfresco']['cifs']['server_name']                  = "alfresco"
default['alfresco']['cifs']['ipv6']['enabled']              = "false"
default['alfresco']['cifs']['tcpip_smb']['port']            = "1445"
default['alfresco']['cifs']['netbios_smb']['name_port']     = "1137"
default['alfresco']['cifs']['netbios_smb']['datagram_port'] = "1138"
default['alfresco']['cifs']['netbios_smb']['session_port']  = "1139"


### Platform Package Settings And Defaults

# @TODO - pull request: java flavor should be handled outside (cannot override it from Vagrantfile)
case platform
when "debian","ubuntu"
#  node.set['java']['install_flavor'] = "sun"
  node.set['alfresco']['pkgs']  = %w{libxalan2-java unzip fastjar libmysql-java}
else
#  node.set['java']['install_flavor'] = "openjdk"
  node.set['alfresco']['pkgs']  = []
end
