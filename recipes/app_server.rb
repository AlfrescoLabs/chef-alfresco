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

### Setup Variables

release   = "alfresco-community-#{node['alfresco']['version']}"
zip_url   = node['alfresco']['zip_url'] || "http://no-url-set.example.com"
zip_sha   = node['alfresco']['zip_sha256']
zip_file  = "#{release}.zip"

cache_path  = Chef::Config['file_cache_path']
archive_zip = "#{cache_path}/#{zip_file}"

root_dir = node['alfresco']['root_dir']

alfresco_user   = node['tomcat']['user']
alfresco_group  = node['tomcat']['group']

webapp_dir      = node['tomcat']['webapp_dir']
temp_dir        = node['tomcat']['tmp_dir']
tomcat_dir      = node['tomcat']['home']
tomcat_base_dir = node['tomcat']['base']
tomcat_work_dir = node['tomcat']['work_dir']


### Include Recipe Dependencies

include_recipe "java"
include_recipe "mysql::client"
include_recipe "openoffice::headless"
include_recipe "openoffice::apps"
include_recipe "imagemagick"
include_recipe "swftools"
include_recipe "tomcat"


### Install Package Dependencies

Array(node['alfresco']['pkgs']).each do |pkg|
  package pkg
end


### Create Alfresco Data Directory

directory root_dir do
  owner       alfresco_user
  group       alfresco_group
  mode        "0755"
  recursive   true
end


### Download Alfresco Zip

remote_file archive_zip do
  source      zip_url
  checksum    zip_sha
  mode        "0644"
end


### Add mysql-connector-java.jar To Tomcat lib Directory

link "#{tomcat_dir}/lib/mysql-connector-java.jar" do
  to      "/usr/share/java/mysql-connector-java.jar"
  owner   "root"
  group   "root"
end


### Extract Binaries And Shared Assets

execute "Extract bin files to #{tomcat_dir}/bin" do
  user      "root"
  group     "root"
  command   <<-COMMAND.gsub(/^ {2}/, '')

    unzip -jo #{archive_zip} bin/*.jar -d #{tomcat_dir}/bin/ && \\
    unzip -jo #{archive_zip} bin/*.sh -d #{tomcat_dir}/bin/ && \\
    perl -pi -e 's| tomcat/temp| #{temp_dir}|g' \\
      #{tomcat_dir}/bin/clean_tomcat.sh && \\
    perl -pi -e 's| tomcat/work| #{tomcat_work_dir}|g' \\
      #{tomcat_dir}/bin/clean_tomcat.sh && \\
    perl -pi -e 's/\r\n/\n/' \\
      #{tomcat_dir}/bin/clean_tomcat.sh
  COMMAND

  creates   "#{tomcat_dir}/bin/apply_amps.sh"
end

execute "Extract shared files to #{tomcat_base_dir}/shared/classes/alfresco" do
  user      "root"
  group     "root"
  command   <<-COMMAND.gsub(/^ {2}/, '')

    unzip #{archive_zip} web-server/shared/classes/* \\
      -d #{tomcat_base_dir}/shared/classes/ && \\
    mv #{tomcat_base_dir}/shared/classes/web-server/shared/classes/* \\
      #{tomcat_base_dir}/shared/classes/ && \\
    rm -rf #{tomcat_base_dir}/shared/classes/web-server
  COMMAND

  creates   "#{tomcat_base_dir}/shared/classes/alfresco"
end

execute "Extract jar files to #{tomcat_dir}/lib" do
  user      "root"
  group     "root"
  command   <<-COMMAND.gsub(/^ {2}/, '')

    unzip -jo #{archive_zip} web-server/lib/*.jar -d #{tomcat_dir}/lib/
  COMMAND

  creates   "#{tomcat_dir}/lib/postgresql-9.0-801.jdbc4.jar"
  notifies  :restart, "service[tomcat]", :immediately
end


### Configure Alfresco Settings

template "#{tomcat_base_dir}/shared/classes/alfresco-global.properties" do
  source    "alfresco-global.properties.erb"
  owner     alfresco_user
  group     alfresco_group
  mode      "0640"

  notifies  :restart, "service[tomcat]", :immediately
end

template "#{tomcat_base_dir}/shared/classes/log4j.properties" do
  source    "log4j.properties.erb"
  owner     alfresco_user
  group     alfresco_group
  mode      "0644"

  notifies  :restart, "service[tomcat]", :immediately
end

cookbook_file "#{tomcat_base_dir}/shared/classes/alfresco/extension/custom-email-context.xml" do
  source    "custom-email-context.xml"
  owner     alfresco_user
  group     alfresco_group
  mode      "0644"

  if node['alfresco']['mail'] && node['alfresco']['mail']['smtps']
    action  :create
  else
    action  :delete
  end

  notifies  :restart, "service[tomcat]", :immediately
end


### Deploy Alfresco Wars

execute "Clean previous Alfresco Tomcat deployment" do
  command   "sh #{tomcat_dir}/bin/clean_tomcat.sh"

  not_if    %{test -f #{webapp_dir}/alfresco.war}
end

# @TODO - Using Tomcat7 user/group; should be alfresco_user and alfresco_group
%w{alfresco.war share.war}.each do |war|
  execute "Deploy #{war}" do
    user      "tomcat7"
    group     "tomcat7"
    command   <<-COMMAND.gsub(/^ {4}/, '')

      unzip -j #{archive_zip} web-server/webapps/#{war} -d #{temp_dir} && \\
      mkdir -p #{temp_dir}/WEB-INF/classes && \\
      cp #{tomcat_base_dir}/shared/classes/log4j.properties \\
        #{temp_dir}/WEB-INF/classes && \\
      (cd #{temp_dir} && \\
        jar -uf #{temp_dir}/#{war} WEB-INF/classes/log4j.properties) && \\
      rm -rf #{temp_dir}/WEB-INF/classes && \\
      mv #{temp_dir}/#{war} #{webapp_dir}/#{war} && \\
      sleep 10
    COMMAND

    creates   "#{webapp_dir}/#{war}"
  end
end
