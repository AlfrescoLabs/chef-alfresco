# Additional Alfresco paths
node.default['alfresco']['bin'] = "#{node['alfresco']['home']}/bin"
node.default['alfresco']['shared'] = "#{node['alfresco']['home']}/shared"
node.default['alfresco']['config_dir'] = "#{node['alfresco']['home']}/conf"
node.default['alfresco']['shared_lib'] = "#{node['alfresco']['shared']}/lib"
node.default['alfresco']['amps_folder'] = "#{node['alfresco']['home']}/amps"
node.default['alfresco']['amps_share_folder'] = "#{node['alfresco']['home']}/amps_share"

node.default['alfresco']['server_info'] = "Alfresco (#{node['alfresco']['public_hostname']})"

# Use JSON with log4j, if enabled
if node['alfresco']['log.json.enabled']
  node.default['amps']['repo']['json-logging-amp-repo']['enabled'] = true
  node.default['amps']['share']['json-logging-amp']['enabled'] = true
  node.default['logging']['log4j.appender.File.layout'] = 'net.logstash.log4j.JSONEventLayoutV1'
  node.default['logging']['log4j.appender.File.File'] = '${logfilename}.json'
end

node.default['alfresco']['log4j'] = node['logging'].merge(node['alfresco']['log4j_items'])

mailsmtp_databag = node['alfresco']['mailsmtp_databag']
mailsmtp_databag_item = node['alfresco']['mailsmtp_databag_item']

begin
  db_item = data_bag_item(mailsmtp_databag, mailsmtp_databag_item)
  node.default['alfresco']['properties']['mail.username'] = db_item['username']
  node.default['alfresco']['properties']['mail.password'] = db_item['password']
rescue
  Chef::Log.warn("Error fetching databag #{mailsmtp_databag}, item #{mailsmtp_databag_item}")
end

# S3-connector
# node.default['amps']['repo']['alfresco-s3-connector']['destination'] = node['alfresco']['amps_folder']

# ssl-db-creds
node.default['artifacts']['ssl-db-creds']['url'] = 'http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem'
node.default['artifacts']['ssl-db-creds']['destination'] = '/tmp/rds-combined-ca-bundle.pem'
node.default['artifacts']['ssl-db-creds']['owner'] = 'tomcat'
node.default['artifacts']['ssl-db-creds']['enabled'] = false

# JMX host
node.default['alfresco']['properties']['hostname.public'] = node['alfresco']['public_hostname']
node.default['alfresco']['properties']['hostname.private'] = node['alfresco']['internal_hostname']

# Email
node.default['alfresco']['properties']['mail.from.default'] = "webmaster@#{node['alfresco']['public_hostname']}"

# Search Config
node.default['alfresco']['properties']['solr.host'] = node['alfresco']['internal_hostname']
node.default['alfresco']['properties']['solr.port'] = node['alfresco']['internal_port']
node.default['alfresco']['properties']['solr.port.ssl'] = node['alfresco']['internal_portssl']

# Alfresco params
node.default['alfresco']['properties']['alfresco.host'] = node['alfresco']['public_hostname']
node.default['alfresco']['properties']['alfresco.port.ssl'] = node['alfresco']['public_portssl']
node.default['alfresco']['properties']['alfresco.protocol'] = node['alfresco']['public_protocol']
node.default['alfresco']['properties']['alfresco.port'] = node['alfresco']['public_portssl']

# Contentstore settings
node.default['alfresco']['properties']['dir.contentstore'] = 'c'
node.default['alfresco']['properties']['dir.contentstore.deleted'] = 'd'
node.default['alfresco']['properties']['system.content.caching.maxUsageMB'] = '10000'

# Share Public Endpoint
node.default['alfresco']['properties']['share.host'] = node['alfresco']['public_hostname']
node.default['alfresco']['properties']['share.port'] = node['alfresco']['public_portssl']
node.default['alfresco']['properties']['share.protocol'] = node['alfresco']['public_protocol']

# OpenCMIS
node.default['alfresco']['properties']['opencmis.server.host'] = node['alfresco']['public_hostname']
node.default['alfresco']['properties']['opencmis.server.protocol'] = node['alfresco']['public_protocol']

# AOS
node.default['alfresco']['properties']['aos.baseProtocol'] = node['alfresco']['public_protocol']
node.default['alfresco']['properties']['aos.baseHost'] = node['alfresco']['public_hostname']
node.default['alfresco']['properties']['aos.port'] = node['alfresco']['public_port']
