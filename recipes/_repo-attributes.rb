if node['artifacts']['keystore']['enabled'] == true
  node.default['alfresco']['properties']['dir.keystore'] = "#{node['alfresco']['properties']['dir.root']}/keystore/alfresco/keystore"
end

# Tomcat Configuration for Alfresco keystore
# TODO - these should be tomcat parent attribute, not alfresco
node.default['alfresco']['keystore_file'] = "#{node['alfresco']['properties']['dir.keystore']}/ssl.keystore"
node.default['alfresco']['keystore_password'] = 'kT9X6oe68t'
node.default['alfresco']['keystore_type'] = 'JCEKS'
node.default['alfresco']['truststore_file'] = "#{node['alfresco']['properties']['dir.keystore']}/ssl.truststore"
node.default['alfresco']['truststore_password'] = 'kT9X6oe68t'
node.default['alfresco']['truststore_type'] = 'JCEKS'

node.default['alfresco']['properties']['db.ssl_params'] = node['alfresco']['db_ssl_enabled'] == true ? "&useSSL=true&requireSSL=true&verifyServerCertificate=true&trustCertificateKeyStoreUrl=file://#{node['alfresco']['truststore_file']}&trustCertificateKeyStoreType=#{node['alfresco']['truststore_type']}&trustCertificateKeyStorePassword=#{node['alfresco']['truststore_password']}" : ''
node.default['alfresco']['properties']['db.url'] = 'jdbc:${db.prefix}://${db.host}/${db.dbname}?${db.params}${db.ssl_params}'

node.default['artifacts']['json-logging-repo-amp']['groupId'] = 'org.alfresco.devops'
node.default['artifacts']['json-logging-repo-amp']['artifactId'] = 'alfresco-json-logging-amp'
node.default['artifacts']['json-logging-repo-amp']['version'] = '0.5'
node.default['artifacts']['json-logging-repo-amp']['type'] = 'amp'
node.default['artifacts']['json-logging-repo-amp']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['json-logging-repo-amp']['owner'] = node['alfresco']['user']

node.default['artifacts']['json-logging-share-amp']['groupId'] = 'org.alfresco.devops'
node.default['artifacts']['json-logging-share-amp']['artifactId'] = 'alfresco-json-logging-amp'
node.default['artifacts']['json-logging-share-amp']['version'] = '0.5'
node.default['artifacts']['json-logging-share-amp']['type'] = 'amp'
node.default['artifacts']['json-logging-share-amp']['destination'] = node['alfresco']['amps_share_folder']
node.default['artifacts']['json-logging-share-amp']['owner'] = node['alfresco']['user']

if node['alfresco']['components'].include? 'repo'
  node.default['artifacts']['mysql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'mysql'
  node.default['artifacts']['mysql']['groupId'] = 'mysql'
  node.default['artifacts']['mysql']['artifactId'] = 'mysql-connector-java'
  node.default['artifacts']['mysql']['version'] = '5.1.37'
  node.default['artifacts']['mysql']['destination'] = node['alfresco']['shared_lib']
  node.default['artifacts']['mysql']['owner'] = node['alfresco']['user']
end

node.default['artifacts']['psql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'psql' && node['alfresco']['components'].include?('repo')
node.default['artifacts']['psql']['groupId'] = 'org.postgresql'
node.default['artifacts']['psql']['artifactId'] = 'postgresql'
node.default['artifacts']['psql']['version'] = '9.2-1004-jdbc4'
node.default['artifacts']['psql']['destination'] = node['alfresco']['shared_lib']
node.default['artifacts']['psql']['owner'] = node['alfresco']['user']

s3_databag = node['alfresco']['s3_databag']
s3_databag_item = node['alfresco']['s3_databag_item']
hz_share_databag = node['alfresco']['hz_share_databag']
hz_share_databag_item = node['alfresco']['hz_share_databag_item']

begin
  db_item = data_bag_item(s3_databag, s3_databag_item)
  node.default['artifacts']['alfresco-s3-connector']['enabled'] = true
  node.default['alfresco']['properties']['s3.accessKey'] = db_item['aws_access_key_id']
  node.default['alfresco']['properties']['s3.secretKey'] = db_item['aws_secret_access_key']
  # S3 default values (if not enabled, alfresco will ignore them)
  node.default['alfresco']['properties']['s3.encryption'] = 'AES256'
  node.default['alfresco']['properties']['s3.flatRoot'] = true
  node.default['alfresco']['properties']['s3service.https-only'] = true
  node.default['alfresco']['properties']['s3service.max-thread-count'] = '5'
  # defaulto to N.Virginia. Overridable at config time
  node.default['alfresco']['properties']['s3service.s3-endpoint'] = 's3-external-1.amazonaws.com'
  # Only relevant for s3
  node.default['alfresco']['properties']['httpclient.max-connections'] = '20'
rescue
  Chef::Log.warn("Error fetching databag #{s3_databag}, item #{s3_databag_item}")
end

begin
  db_item = data_bag_item(hz_share_databag, hz_share_databag_item)
  node.default['alfresco']['shareproperties']['hz_aws_enabled'] = true
  node.default['alfresco']['shareproperties']['hz_aws_access_key'] = db_item['aws_access_key_id']
  node.default['alfresco']['shareproperties']['hz_aws_secret_key'] = db_item['aws_secret_access_key']
rescue
  Chef::Log.warn("Error fetching databag #{hz_share_databag}, item #{hz_share_databag_item}")
end

node.default['artifacts']['keystore']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['keystore']['artifactId'] = 'alfresco-repository'
node.default['artifacts']['keystore']['version'] = node['alfresco']['version']
node.default['artifacts']['keystore']['destination'] = node['alfresco']['properties']['dir.root']
node.default['artifacts']['keystore']['subfolder'] = 'alfresco/keystore/\*'
node.default['artifacts']['keystore']['owner'] = node['alfresco']['user']
node.default['artifacts']['keystore']['unzip'] = true

node.default['artifacts']['alfresco']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['alfresco']['artifactId'] = 'alfresco'
node.default['artifacts']['alfresco']['version'] = node['alfresco']['version']
node.default['artifacts']['alfresco']['type'] = 'war'

node.default['artifacts']['alfresco']['owner'] = node['alfresco']['user']
node.default['artifacts']['alfresco']['unzip'] = false
node.default['artifacts']['alfresco']['destination'] = node['tomcat']['run_base_instance'] ? node['tomcat']['webapp_dir'] : "#{node['alfresco']['home']}-alfresco/webapps"

# Alfresco MMT artifact
node.default['artifacts']['alfresco-mmt']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['alfresco-mmt']['artifactId'] = 'alfresco-mmt'
node.default['artifacts']['alfresco-mmt']['version'] = node['alfresco']['version']
node.default['artifacts']['alfresco-mmt']['type'] = 'jar'
node.default['artifacts']['alfresco-mmt']['destination'] = node['alfresco']['bin']
node.default['artifacts']['alfresco-mmt']['owner'] = node['alfresco']['user']
node.default['artifacts']['alfresco-mmt']['unzip'] = false

node.default['artifacts']['share-services']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['share-services']['artifactId'] = 'alfresco-share-services'
node.default['artifacts']['share-services']['version'] = node['alfresco']['version']
node.default['artifacts']['share-services']['type'] = 'amp'
node.default['artifacts']['share-services']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['share-services']['owner'] = node['alfresco']['user']

# Filtering properties with placeholders defined in the mentioned files
# (only if classes zip is part of the artifact list, see recipes)
node.default['artifacts']['sharedclasses']['unzip'] = false
node.default['artifacts']['sharedclasses']['filtering_mode'] = 'append'
node.default['artifacts']['sharedclasses']['destination'] = node['alfresco']['shared']
node.default['artifacts']['sharedclasses']['destinationName'] = 'classes'
node.default['artifacts']['sharedclasses']['owner'] = node['alfresco']['user']
