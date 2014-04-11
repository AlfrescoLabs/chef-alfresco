include_recipe "mysql::client"
include_recipe "database::mysql"

db_database   = node['alfresco']['db']['database']
db_port       = node['alfresco']['db']['port']
db_user       = node['alfresco']['db']['user']
db_pass       = node['alfresco']['db']['password']
db_repo_hosts = node['alfresco']['db']['repo_hosts']

mysql_bind_address  = node['alfresco']['mysql']['bind_address']
mysql_root_password = node['alfresco']['mysql']['server_root_password']

db_info = {
  :host     => mysql_bind_address,
  :port     => db_port,
  :username => 'root',
  :password => mysql_root_password
}

db_repo_hosts.each do |repo_host|
    mysql_database_user db_user do
    connection          db_info
    database_name       db_database
    password            db_pass
    privileges          [ :all ]
    host                repo_host
    action              :grant
  end
end

mysql_database db_database do
  connection  db_info
end

service "mysql"  do
  action  :restart
end