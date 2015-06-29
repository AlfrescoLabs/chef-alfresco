node.default['rsyslog']['file_inputs']['repo1']['file'] = '/var/log/tomcat-alfresco/alfresco.log'
node.default['rsyslog']['file_inputs']['repo1']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['repo1']['priority'] = 50
node.default['rsyslog']['file_inputs']['repo2']['file'] = '/var/log/tomcat-alfresco/catalina.out.*'
node.default['rsyslog']['file_inputs']['repo2']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['repo2']['priority'] = 51

# Tomcat Configuration for Alfresco keystore
# TODO - these should be tomcat parent attribute, not alfresco
node.default["alfresco"]["keystore_file"] = "#{node['alfresco']['properties']['dir.keystore']}/ssl.keystore"
node.default["alfresco"]["keystore_password"] = "kT9X6oe68t"
node.default["alfresco"]["keystore_type"] = "JCEKS"
node.default["alfresco"]["truststore_file"] = "#{node['alfresco']['properties']['dir.keystore']}/ssl.truststore"
node.default["alfresco"]["truststore_password"] = "kT9X6oe68t"
node.default["alfresco"]["truststore_type"] = "JCEKS"

node.default['artifacts']['mysql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'mysql'
node.default['artifacts']['mysql']['groupId'] = "mysql"
node.default['artifacts']['mysql']['artifactId'] = "mysql-connector-java"
node.default['artifacts']['mysql']['version'] = "5.1.30"
node.default['artifacts']['mysql']['destination'] = node['alfresco']['shared_lib']
node.default['artifacts']['mysql']['owner'] = node['alfresco']['user']

node.default['artifacts']['psql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'psql'
node.default['artifacts']['psql']['groupId'] = "org.postgresql"
node.default['artifacts']['psql']['artifactId'] = "postgresql"
node.default['artifacts']['psql']['version'] = "9.2-1004-jdbc4"
node.default['artifacts']['psql']['destination'] = node['alfresco']['shared_lib']
node.default['artifacts']['psql']['owner'] = node['alfresco']['user']

node.default['artifacts']['keystore']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['keystore']['artifactId'] = "alfresco-repository"
node.default['artifacts']['keystore']['version'] = node['alfresco']['version']
node.default['artifacts']['keystore']['destination'] = node['alfresco']['properties']['dir.root']
node.default['artifacts']['keystore']['subfolder'] = "alfresco/keystore/\*"
node.default['artifacts']['keystore']['owner'] = node['alfresco']['user']
node.default['artifacts']['keystore']['unzip'] = true

node.default['artifacts']['alfresco']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['alfresco']['artifactId'] = "alfresco"
node.default['artifacts']['alfresco']['version'] = node['alfresco']['version']
node.default['artifacts']['alfresco']['type'] = "war"

node.default['artifacts']['alfresco']['owner'] = node['alfresco']['user']
node.default['artifacts']['alfresco']['unzip'] = false

if node['tomcat']['run_base_instance']
  node.default['artifacts']['alfresco']['destination'] = node['tomcat']['webapp_dir']
else
  node.default['artifacts']['alfresco']['destination'] = "#{node['alfresco']['home']}-alfresco/webapps"
end

# Alfresco MMT artifact
node.default['artifacts']['alfresco-mmt']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['alfresco-mmt']['artifactId'] = "alfresco-mmt"
node.default['artifacts']['alfresco-mmt']['version'] = node['alfresco']['version']
node.default['artifacts']['alfresco-mmt']['type'] = "jar"
node.default['artifacts']['alfresco-mmt']['destination'] = node['alfresco']['bin']
node.default['artifacts']['alfresco-mmt']['owner'] = node['alfresco']['user']
node.default['artifacts']['alfresco-mmt']['unzip'] = false

# Filtering properties with placeholders defined in the mentioned files
# (only if classes zip is part of the artifact list, see recipes)
node.default['artifacts']['sharedclasses']['unzip'] = false
node.default['artifacts']['sharedclasses']['filtering_mode'] = "append"
node.default['artifacts']['sharedclasses']['destination'] = node['alfresco']['shared']
node.default['artifacts']['sharedclasses']['destinationName'] = "classes"
node.default['artifacts']['sharedclasses']['owner'] = node['alfresco']['user']
