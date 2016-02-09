# create database

db_database   = node['activiti']['properties']['db.dbname']
db_host       = node['alfresco']['properties']['db.host']
db_port       = node['alfresco']['properties']['db.port']
db_user       = node['alfresco']['properties']['db.username']
db_pass       = node['alfresco']['properties']['db.password']


mysql_connection_info = {
    :host     => db_host,
    :username => db_root_user,
    :password => mysql_root_password
}


mysql_database db_database do
  connection mysql_connection_info
  action :create
end


template '/lib/db.properties' do
  source 'activiti/db.properties.erb'
  owner node['alfresco']['user']
  mode '0644'
end
