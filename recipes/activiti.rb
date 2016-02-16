if node['alfresco']['components'].include? 'mysql'
  # create database
  db_database   = node['activiti']['properties']['db.dbname']
  db_host       = node['alfresco']['properties']['db.host']
  db_root_user = node['alfresco']['db']['root_user']
  mysql_root_password = node['alfresco']['db']['server_root_password']

  mysql_connection_info = {
      :host     => db_host,
      :username => db_root_user,
      :password => mysql_root_password
  }

  mysql_database db_database do
    connection mysql_connection_info
    action :create
  end
end

db_properties_path = "#{node['alfresco']['home']}/activiti/webapps/activiti/WEB-INF/classes/db.properties"

if node['tomcat']['run_base_instance']
  db_properties_path = "#{node['alfresco']['home']}/webapps/activiti/WEB-INF/classes/db.properties"
end

template db_properties_path do
  source 'activiti/db.properties.erb'
  owner node['alfresco']['user']
  mode '0644'
end
