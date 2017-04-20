db_database = node['alfresco']['properties']['db.dbname']
db_host = node['alfresco']['properties']['db.host']
db_port = node['alfresco']['properties']['db.port']
db_user = node['alfresco']['properties']['db.username']
db_pass = node['alfresco']['properties']['db.password']

db_root_user = node['alfresco']['db']['root_user']
db_allowed_host = node['alfresco']['db']['allowed_host']
mysql_root_password = node['alfresco']['db']['server_root_password']
mysql_version = node['alfresco']['mysql_version']

# Enforce mode and ownership of /tmp folder
directory '/tmp' do
  owner 'root'
  group 'root'
  mode 0777
end

mysql2_chef_gem 'default' do
  client_version mysql_version
  action :install
end

# if service resource was in a recipe, but it's in a library
# r = resources(service: "provider_mysql_service_systemd :start mysql-default")
# r.action([:create, :stop])
# mysql_service_base 'default' do
#   port db_port
#   version mysql_version
#   action :create
# end

selinux_commands = {}
selinux_commands['mkdir -p /var/lib/mysql-default ; semanage fcontext -a -t mysqld_db_t "/var/lib/mysql-default(/.*)?" ; restorecon -Rv /var/lib/mysql-default;']  = 'ls -lZ /var/lib/mysql-default | grep mysqld_db_t'
selinux_commands['mkdir -p /var/log/mysql-default ; semanage fcontext -a -t mysqld_log_t "/var/log/mysql-default(/.*)?" ; restorecon -Rv /var/log/mysql-default;'] = 'ls -lZ /var/log/mysql-default | grep mysqld_log_t'
# TODO: - add nginx 2100 port rule => into nginx.rb

# TODO: - make it a custom resource
selinux_commands.each do |command, not_if|
  execute "selinux-command-#{command}" do
    command command
    only_if 'getenforce | grep -i enforcing'
    not_if not_if
  end
end

mysql_service 'default' do
  port db_port
  version mysql_version
  initial_root_password mysql_root_password
  action [:create, :start]
end

mysql_connection_info =
  {
    host: db_host,
    username: db_root_user,
    password: mysql_root_password,
  }

mysql_database db_database do
  connection mysql_connection_info
  collation 'utf8_general_ci'
  encoding 'utf8'
  action :create
end

mysql_database_user db_user do
  connection mysql_connection_info
  host db_allowed_host
  password db_pass
  action [:create, :grant]
end
