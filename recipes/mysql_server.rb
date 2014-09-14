include_recipe "mysql::server"

include_recipe "mysql::client"
include_recipe "database::mysql"

db_database   = node['alfresco']['properties']['db.dbname']
db_host       = node['alfresco']['properties']['db.host']
db_port       = node['alfresco']['properties']['db.port']
db_user       = node['alfresco']['properties']['db.username']
db_pass       = node['alfresco']['properties']['db.password']

db_repo_hosts       = node['alfresco']['db']['repo_hosts']
db_root_user        = node['alfresco']['db']['root_user']
mysql_root_password = node['alfresco']['db']['server_root_password']

db_info = {
  :host     => db_host,
  :port     => db_port,
  :username => db_root_user,
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

mysql_database 'alfresco' do
  connection db_info
  action :create
end
