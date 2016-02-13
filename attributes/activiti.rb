# Database info
default['activiti']['mysql_version'] = '5.6'
default['activiti']['properties']['db.driver'] = 'com.mysql.jdbc.Driver'
default['activiti']['properties']['db.prefix'] = 'mysql'
default['activiti']['properties']['db.host'] = '127.0.0.1'
default['activiti']['properties']['db.port'] = '3306'
default['activiti']['properties']['db.dbname'] = 'activiti_modeler'
default['activiti']['properties']['db.params'] = 'connectTimeout=240000&socketTimeout=240000&autoReconnect=true&characterEncoding=UTF-8'
default['activiti']['properties']['db.url'] = "jdbc:#{node['activiti']['properties']['db.prefix']}://#{node['activiti']['properties']['db.host']}:#{node['activiti']['properties']['db.port']}/#{node['activiti']['properties']['db.dbname']}?#{node['activiti']['properties']['db.params']}"


