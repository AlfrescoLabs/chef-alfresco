#
# Cookbook Name:: alfresco
# Recipe:: mysql_server
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

mysql_root_pass = node['mysql']['server_root_password']

db_database = node['alfresco']['db']['database']
db_user     = node['alfresco']['db']['user']
db_pass     = node['alfresco']['db']['password']


### Include Recipe Dependencies

include_recipe "mysql::server"

require 'rubygems'
Gem.clear_paths
require 'mysql'


### Create Mysql Database Instance

execute "mysql-create-alfresco-database" do
  command <<-CODE
    /usr/bin/mysqladmin -u root -p#{mysql_root_pass} create #{db_database}
  CODE

  not_if do
    m = Mysql.new("localhost", "root", mysql_root_pass)
    m.list_dbs.include?(db_database)
  end
end

execute "mysql-install-alfresco-privileges" do
  command <<-CODE
    /usr/bin/mysql -u root -p#{mysql_root_pass} < /etc/mysql/alfresco-grants.sql
  CODE

  action  :nothing
end

template "/etc/mysql/alfresco-grants.sql" do
  path    "/etc/mysql/alfresco-grants.sql"
  source  "grants.sql.erb"
  owner   "root"
  group   "root"
  mode    "0600"
  variables(
    :database => db_database,
    :user     => db_user,
    :password => db_pass
  )

  notifies :run, "execute[mysql-install-alfresco-privileges]", :immediately
end
