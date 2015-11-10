db_database   = node['alfresco']['properties']['db.dbname']
db_host       = node['alfresco']['properties']['db.host']
db_port       = node['alfresco']['properties']['db.port']
db_user       = node['alfresco']['properties']['db.username']
db_pass       = node['alfresco']['properties']['db.password']

db_root_user = node['alfresco']['db']['root_user']
db_allowed_host = node['alfresco']['db']['allowed_host']
mysql_root_password = node['alfresco']['db']['server_root_password']
mysql_version = node['alfresco']['mysql_version']
mysql_update_gcc = node['mysql']['update_gcc']

if mysql_update_gcc
  include_recipe 'build-essential::default'
end

# Enforce mode and ownership of /tmp folder
directory "/tmp" do
  owner "root"
  group "root"
  mode 0777
end

mysql2_chef_gem 'default' do
  client_version mysql_version
  action :install
end

mysql_service 'default' do
  port db_port
  version mysql_version
  initial_root_password mysql_root_password
  action [:create, :start]
end

mysql_connection_info = {
    :host     => db_host,
    :username => db_root_user,
    :password => mysql_root_password
}

mysql_database db_database do
  connection mysql_connection_info
  action :create
end

mysql_database_user db_user do
  connection mysql_connection_info
  host db_allowed_host
  password db_pass
  action [:create,:grant]
end
