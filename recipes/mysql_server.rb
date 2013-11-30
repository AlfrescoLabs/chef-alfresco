include_recipe "mysql::server"
include_recipe "mysql::client"
include_recipe "database::mysql"

db_database = node['alfresco']['db']['database']
db_port     = node['alfresco']['db']['port']
db_user     = node['alfresco']['db']['user']
db_pass     = node['alfresco']['db']['password']

db_info = {
  :host     => node['mysql']['bind_address'],
  :port     => db_port,
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database db_database do
  connection  db_info
end

mysql_database_user "#{node['alfresco']['db']['user']}" do
  connection      db_info
  database_name   db_database
  password        db_pass
  privileges      [ :all ]
  host            node['alfresco']['db']['repo_host']
  action          :grant
  notifies        :restart, "service[mysql]", :immediately
end
