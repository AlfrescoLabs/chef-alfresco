# Tomcat Configuration for Alfresco keystore
# TODO - these should be tomcat parent attribute, not alfresco
node.default["alfresco"]["keystore_file"] = "#{node['alfresco']['properties']['dir.keystore']}/ssl.keystore"
node.default["alfresco"]["keystore_password"] = "kT9X6oe68t"
node.default["alfresco"]["keystore_type"] = "JCEKS"
node.default["alfresco"]["truststore_file"] = "#{node['alfresco']['properties']['dir.keystore']}/ssl.truststore"
node.default["alfresco"]["truststore_password"] = "kT9X6oe68t"
node.default["alfresco"]["truststore_type"] = "JCEKS"

node.default['amps']['repo']['json-logging-amp-repo']['groupId'] = "org.alfresco.devops"
node.default['amps']['repo']['json-logging-amp-repo']['artifactId'] = "alfresco-json-logging-amp"
node.default['amps']['repo']['json-logging-amp-repo']['version'] = "0.5"
node.default['amps']['repo']['json-logging-amp-repo']['type'] = "amp"
node.default['amps']['repo']['json-logging-amp-repo']['owner'] = node['alfresco']['user']

node.default['amps']['share']['json-logging-amp']['groupId'] = "org.alfresco.devops"
node.default['amps']['share']['json-logging-amp']['artifactId'] = "alfresco-json-logging-amp"
node.default['amps']['share']['json-logging-amp']['version'] = "0.5"
node.default['amps']['share']['json-logging-amp']['type'] = "amp"
node.default['amps']['share']['json-logging-amp']['owner'] = node['alfresco']['user']

node.default['artifacts']['mysql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'mysql'
node.default['artifacts']['mysql']['groupId'] = "mysql"
node.default['artifacts']['mysql']['artifactId'] = "mysql-connector-java"
node.default['artifacts']['mysql']['version'] = "5.1.37"
node.default['artifacts']['mysql']['destination'] = node['alfresco']['shared_lib']
node.default['artifacts']['mysql']['owner'] = node['alfresco']['user']

node.default['artifacts']['psql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'psql'
node.default['artifacts']['psql']['groupId'] = "org.postgresql"
node.default['artifacts']['psql']['artifactId'] = "postgresql"
node.default['artifacts']['psql']['version'] = "9.2-1004-jdbc4"
node.default['artifacts']['psql']['destination'] = node['alfresco']['shared_lib']
node.default['artifacts']['psql']['owner'] = node['alfresco']['user']

s3_databag = node['alfresco']['s3_databag']
s3_databag_item = node['alfresco']['s3_databag_item']
hz_share_databag = node['alfresco']['hz_share_databag']
hz_share_databag_item = node['alfresco']['hz_share_databag_item']

begin
  db_item = data_bag_item(s3_databag,s3_databag_item)
  node.default['amps']['repo']['alfresco-s3-connector']['enabled'] = true
  node.default['alfresco']['properties']['s3.accessKey'] = db_item['aws_access_key_id']
  node.default['alfresco']['properties']['s3.secretKey'] = db_item['aws_secret_access_key']
  # S3 default values (if not enabled, alfresco will ignore them)
  node.default['alfresco']['properties']['s3.encryption'] = "AES256"
  node.default['alfresco']['properties']['s3.flatRoot'] = true
  node.default['alfresco']['properties']['s3service.https-only'] = true
  node.default['alfresco']['properties']['s3service.max-thread-count'] = "5"
rescue
  Chef::Log.warn("Error fetching databag #{s3_databag},  item #{s3_databag_item}")
end

begin
  db_item = data_bag_item(hz_share_databag,hz_share_databag_item)
  node.default['alfresco']['shareproperties']['hz_aws_enabled'] = true
  node.default['alfresco']['shareproperties']['hz_aws_access_key'] = db_item['aws_access_key_id']
  node.default['alfresco']['shareproperties']['hz_aws_secret_key'] = db_item['aws_secret_access_key']
rescue
  Chef::Log.warn("Error fetching databag #{hz_share_databag},  item #{hz_share_databag_item}")
end

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

# Alfresco MMT artifact
node.default['artifacts']['alfresco-mmt']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['alfresco-mmt']['artifactId'] = "alfresco-mmt"
node.default['artifacts']['alfresco-mmt']['version'] = node['alfresco']['version']
node.default['artifacts']['alfresco-mmt']['type'] = "jar"
node.default['artifacts']['alfresco-mmt']['destination'] = node['alfresco']['bin']
node.default['artifacts']['alfresco-mmt']['owner'] = node['alfresco']['user']
node.default['artifacts']['alfresco-mmt']['unzip'] = false

node.default['amps']['repo']['share-services']['groupId'] = node['alfresco']['groupId']
node.default['amps']['repo']['share-services']['artifactId'] = "alfresco-share-services"
node.default['amps']['repo']['share-services']['version'] = node['alfresco']['version']
node.default['amps']['repo']['share-services']['type'] = "amp"
node.default['amps']['repo']['share-services']['destination'] = node['alfresco']['amps_folder']
node.default['amps']['repo']['share-services']['owner'] = node['alfresco']['user']

# Filtering properties with placeholders defined in the mentioned files
# (only if classes zip is part of the artifact list, see recipes)
node.default['artifacts']['sharedclasses']['unzip'] = false
node.default['artifacts']['sharedclasses']['filtering_mode'] = "append"
node.default['artifacts']['sharedclasses']['destination'] = node['alfresco']['shared']
node.default['artifacts']['sharedclasses']['destinationName'] = "classes"
node.default['artifacts']['sharedclasses']['owner'] = node['alfresco']['user']

# Repo WAR destination
if node['tomcat']['run_base_instance']
  node.default['artifacts']['alfresco']['destination'] = node['tomcat']['webapp_dir']
else
  node.default['artifacts']['alfresco']['destination'] = "#{node['alfresco']['home']}/alfresco/webapps"
end
