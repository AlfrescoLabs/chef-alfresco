#
# Cookbook Name:: alfresco
# Recipe:: default
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

include_recipe "java"

package "libxalan2-java"
package "unzip"           # to unzip the alfresco archive

include_recipe "mysql::server"

include_recipe "openoffice::headless"
include_recipe "openoffice::apps"

include_recipe "imagemagick"
include_recipe "swftools"

include_recipe "tomcat"

release       = "alfresco-community-#{node[:alfresco][:version]}"
zip_file      = "#{release}.zip"
archive_cache = "/var/chef/cache/downloads/alfresco"
archive_zip   = "#{archive_cache}/#{zip_file}"
webapp_dir    = node[:tomcat][:webapp_dir]
temp_dir      = node[:tomcat][:tmp_dir]

unless node[:alfresco][:zip_url]
  abort "You must set `alfresco/zip_url' with the URL to download #{zip_file}"
end

directory archive_cache do
  owner     "root"
  group     "root"
  mode      "0755"
  recursive true
end

remote_file archive_zip do
  source    node[:alfresco][:zip_url]
  mode      "0644"
  checksum  node[:alfresco][:zip_sha256]
end

bash "extract_bin" do
  user    "root"
  group   "root"
  creates "#{node[:tomcat][:home]}/bin/apply_amps.sh"
  code    <<-CODE
    unzip -j #{archive_zip} bin/*.jar -d #{temp_dir} && \
    unzip -j #{archive_zip} bin/*.sh -d #{temp_dir}
  CODE
end

execute "mysql-create-alfresco-database" do
  command "/usr/bin/mysqladmin -u root -p#{node[:mysql][:server_root_password]} create #{node[:alfresco][:db][:database]}"
  not_if do
    m = Mysql.new("localhost", "root", node[:mysql][:server_root_password])
    m.list_dbs.include?(node[:alfresco][:db][:database])
  end
end

execute "mysql-install-alfresco-privileges" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} < /etc/mysql/alfresco-grants.sql"
  action :nothing
end

template "/etc/mysql/alfresco-grants.sql" do
  path    "/etc/mysql/alfresco-grants.sql"
  source  "grants.sql.erb"
  owner   "root"
  group   "root"
  mode    "0600"
  variables(
    :user     => node[:alfresco][:db][:user],
    :password => node[:alfresco][:db][:password],
    :database => node[:alfresco][:db][:database]
  )
  notifies :run, "execute[mysql-install-alfresco-privileges]", :immediately
end

bash "deploy_wars" do
  user    "tomcat6"
  group   "tomcat6"
  creates "#{webapp_dir}/alfresco.war"
  code    <<-CODE
    unzip -j #{archive_zip} web-server/webapps/*.war -d #{temp_dir} && \
    mv #{temp_dir}/alfresco.war #{webapp_dir}/alfresco.war && \
    sleep 5 && \
    mv #{temp_dir}/share.war #{webapp_dir}/share.war
  CODE
  action  :nothing
end
