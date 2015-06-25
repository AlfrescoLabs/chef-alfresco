default['artifacts']['mysql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'mysql'
default['artifacts']['mysql']['groupId'] = "mysql"
default['artifacts']['mysql']['artifactId'] = "mysql-connector-java"
default['artifacts']['mysql']['version'] = "5.1.30"
default['artifacts']['mysql']['destination'] = node['alfresco']['shared_lib']
default['artifacts']['mysql']['owner'] = node['alfresco']['user']

default['artifacts']['psql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'psql'
default['artifacts']['psql']['groupId'] = "org.postgresql"
default['artifacts']['psql']['artifactId'] = "postgresql"
default['artifacts']['psql']['version'] = "9.2-1002-jdbc4"
default['artifacts']['psql']['destination'] = node['alfresco']['shared_lib']
default['artifacts']['psql']['owner'] = node['alfresco']['user']

default['artifacts']['keystore']['enabled'] = true
default['artifacts']['keystore']['groupId'] = node['alfresco']['groupId']
default['artifacts']['keystore']['artifactId'] = "alfresco-repository"
default['artifacts']['keystore']['version'] = node['alfresco']['version']
default['artifacts']['keystore']['destination'] = node['alfresco']['properties']['dir.root']
default['artifacts']['keystore']['subfolder'] = "alfresco/keystore/\*"
default['artifacts']['keystore']['owner'] = node['alfresco']['user']
default['artifacts']['keystore']['unzip'] = true

default['artifacts']['alfresco']['enabled'] = true
default['artifacts']['alfresco']['groupId'] = node['alfresco']['groupId']
default['artifacts']['alfresco']['artifactId'] = "alfresco"
default['artifacts']['alfresco']['version'] = node['alfresco']['version']
default['artifacts']['alfresco']['type'] = "war"
default['artifacts']['alfresco']['destination'] = node['tomcat']['webapp_dir']
default['artifacts']['alfresco']['owner'] = node['alfresco']['user']
default['artifacts']['alfresco']['unzip'] = false
