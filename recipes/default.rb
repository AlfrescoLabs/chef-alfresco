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
package "fastjar"         # to overlay log4j.properties in alfresco.war

include_recipe "mysql::server"
require 'rubygems'
Gem.clear_paths
require 'mysql'

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

directory node[:alfresco][:root_dir] do
  owner     node[:tomcat][:user]
  group     node[:tomcat][:group]
  mode      "0755"
  recursive true
end

bash "extract_bin" do
  user    "root"
  group   "root"
  creates "#{node[:tomcat][:home]}/bin/apply_amps.sh"
  code    <<-CODE
    unzip -jo #{archive_zip} bin/*.jar -d #{node[:tomcat][:home]}/bin/ && \
    unzip -jo #{archive_zip} bin/*.sh -d #{node[:tomcat][:home]}/bin/ && \
    perl -pi -e 's| tomcat/temp| #{node[:tomcat][:tmp_dir]}|g' \
      #{node[:tomcat][:home]}/bin/clean_tomcat.sh && \
    perl -pi -e 's| tomcat/work| #{node[:tomcat][:work_dir]}|g' \
      #{node[:tomcat][:home]}/bin/clean_tomcat.sh && \
    perl -pi -e 's/\r\n/\n/' \
      #{node[:tomcat][:home]}/bin/clean_tomcat.sh
  CODE
end

bash "extract_shared" do
  user    "root"
  group   "root"
  creates "#{node[:tomcat][:base]}/shared/classes/alfresco"
  code    <<-CODE
    unzip #{archive_zip} web-server/shared/classes/* \
      -d #{node[:tomcat][:base]}/shared/classes/ && \
    mv #{node[:tomcat][:base]}/shared/classes/web-server/shared/classes/* \
      #{node[:tomcat][:base]}/shared/classes/ && \
    rm -rf #{node[:tomcat][:base]}/shared/classes/web-server
  CODE
end

bash "extract_mysql_jar" do
  user    "root"
  group   "root"
  creates "#{node[:tomcat][:home]}/lib/mysql-connector-java-5.1.13-bin.jar"
  code    <<-CODE
    unzip -jo #{archive_zip} web-server/lib/*.jar \
      -d #{node[:tomcat][:home]}/lib/
  CODE
  notifies :restart, "service[tomcat]", :immediately
end

template "#{node[:tomcat][:base]}/shared/classes/alfresco-global.properties" do
  source  "alfresco-global.properties.erb"
  owner   node[:tomcat][:user]
  group   node[:tomcat][:group]
  mode    "0640"
  notifies :restart, "service[tomcat]", :immediately
end

template "#{node[:tomcat][:base]}/shared/classes/log4j.properties" do
  source  "log4j.properties.erb"
  owner   node[:tomcat][:user]
  group   node[:tomcat][:group]
  mode    "0644"
  notifies :restart, "service[tomcat]", :immediately
end

cookbook_file "#{node[:tomcat][:base]}/shared/classes/alfresco/extension/custom-email-context.xml" do
  source "custom-email-context.xml"
  owner   node[:tomcat][:user]
  group   node[:tomcat][:group]
  mode    "0644"
  notifies :restart, "service[tomcat]", :immediately

  if node[:alfresco][:mail] && node[:alfresco][:mail][:smtps]
    action :create
  else
    action :delete
  end
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

execute "clean_previous_tomcat_deployment" do
  command "sh #{node[:tomcat][:home]}/bin/clean_tomcat.sh"
  not_if %{test -f #{webapp_dir}/alfresco.war}
end

%w{ alfresco.war share.war}.each do |war|
  bash "deploy_#{war}" do
    user    "tomcat6"
    group   "tomcat6"
    creates "#{webapp_dir}/#{war}"
    code    <<-CODE
      unzip -j #{archive_zip} web-server/webapps/#{war} -d #{temp_dir} && \
      mkdir -p #{temp_dir}/WEB-INF/classes && \
      cp #{node[:tomcat][:base]}/shared/classes/log4j.properties \
        #{temp_dir}/WEB-INF/classes && \
      (cd #{temp_dir} && \
        jar -uf #{temp_dir}/#{war} WEB-INF/classes/log4j.properties) && \
      rm -rf #{temp_dir}/WEB-INF/classes && \
      mv #{temp_dir}/#{war} #{webapp_dir}/#{war} && \
      sleep 10
    CODE
  end
end

if node[:alfresco][:nginx][:proxy] && node[:alfresco][:nginx][:proxy] == "enable"
  include_recipe "nginx::source"

  if node[:alfresco][:nginx][:www_redirect] && 
      node[:alfresco][:nginx][:www_redirect] == "disable"
    www_redirect = false
  else
    www_redirect = true
  end

  template "#{node[:nginx][:dir]}/sites-available/alfresco.conf" do
    source      "nginx_alfresco.conf.erb"
    owner       'root'
    group       'root'
    mode        '0644'
    variables(
      :host_name    => node[:alfresco][:nginx][:host_name],
      :host_aliases => node[:alfresco][:nginx][:host_aliases],
      :listen_ports => node[:alfresco][:nginx][:listen_ports],
      :www_redirect => www_redirect
    )

    if File.exists?("#{node[:nginx][:dir]}/sites-enabled/alfresco.conf")
      notifies  :restart, 'service[nginx]'
    end
  end

  nginx_site "alfresco.conf" do
    if node[:alfresco][:nginx_proxy] && 
        node[:alfresco][:nginx_proxy] == "disable"
      enable false
    else
      enable true
    end
  end
end


