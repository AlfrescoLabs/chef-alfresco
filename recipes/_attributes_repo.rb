######################################################
### alfresco-global.properties used only in Alfresco Repository application
######################################################

#JMX host
node.default['alfresco']['properties']['hostname.private'] = node['alfresco']['default_hostname']

#Cluster
node.default['alfresco']['properties']['alfresco.cluster.name'] = 'alfrescoboxes'

#Transformations

# SWF is not needed as of alfresco 5 onwards
# node.default['alfresco']['properties']['swf.exe'] = '/usr/bin/pdf2swf'

# OooDirect disabled
node.default['alfresco']['properties']['ooo.exe'] = '/usr/bin/soffice'
node.default['alfresco']['properties']['ooo.enabled'] = false
node.default['alfresco']['properties']['jodconverter.officeHome'] = '/usr/lib/libreoffice'
node.default['alfresco']['properties']['jodconverter.portNumbers'] = '8100'
node.default['alfresco']['properties']['jodconverter.enabled'] = true
node.default['alfresco']['properties']['img.root'] = '/usr'

#FTP
node.default['alfresco']['properties']['ftp.enabled'] = false

#IMAP
node.default['alfresco']['properties']['imap.server.enabled'] = false
node.default['alfresco']['properties']['imap.server.port'] = '1143'
node.default['alfresco']['properties']['imap.server.host'] = '0.0.0.0'

#CIFS
node.default['alfresco']['properties']['cifs.enabled'] = false
node.default['alfresco']['properties']['cifs.serverName'] = 'alfresco'
node.default['alfresco']['properties']['cifs.ipv6.enabled'] = false
node.default['alfresco']['properties']['cifs.tcpipSMB.port'] = '1445'
node.default['alfresco']['properties']['cifs.netBIOSSMB.namePort'] = '1137'
node.default['alfresco']['properties']['cifs.netBIOSSMB.datagramPort'] = '1138'
node.default['alfresco']['properties']['cifs.netBIOSSMB.sessionPort'] = '1139'

#Email
node.default['alfresco']['properties']['mail.protocol'] = 'smtp'
node.default['alfresco']['properties']['mail.host'] = '0.0.0.0'
node.default['alfresco']['properties']['mail.port'] = '25'
node.default['alfresco']['properties']['mail.username'] = 'anonymous'
node.default['alfresco']['properties']['mail.password'] = ''
node.default['alfresco']['properties']['mail.encoding'] = 'UTF-8'
node.default['alfresco']['properties']['mail.from.default'] = 'alfresco@alfresco.org'
node.default['alfresco']['properties']['mail.smtp.auth'] = false
node.default['alfresco']['properties']['mail.smtps.starttls.enable'] = false
node.default['alfresco']['properties']['mail.smtps.auth'] = false

#Search
node.default['alfresco']['properties']['index.subsystem.name'] = 'solr'

################################
### Artifact Deployer attributes
################################

node.default['artifacts']['mysql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'mysql'
node.default['artifacts']['mysql']['groupId'] = "mysql"
node.default['artifacts']['mysql']['artifactId'] = "mysql-connector-java"
node.default['artifacts']['mysql']['version'] = "5.1.30"
node.default['artifacts']['mysql']['destination'] = node['alfresco']['shared']
# TODO - still needs to be fixed
# node.default['artifacts']['mysql']['destinationName'] = "mysql-connector-java-#{node['artifacts']['mysql']['version']}"
node.default['artifacts']['mysql']['owner'] = node['tomcat']['user']

node.default['artifacts']['psql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'psql'
node.default['artifacts']['psql']['groupId'] = "org.postgresql"
node.default['artifacts']['psql']['artifactId'] = "postgresql"
node.default['artifacts']['psql']['version'] = "9.2-1002-jdbc4"
node.default['artifacts']['psql']['destination'] = node['alfresco']['shared']
node.default['artifacts']['psql']['owner'] = node['tomcat']['user']

node.default['artifacts']['keystore']['enabled']           = true
node.default['artifacts']['keystore']['groupId']           = node['alfresco']['groupId']
node.default['artifacts']['keystore']['artifactId']        = "alfresco-repository"
node.default['artifacts']['keystore']['version']           = node['alfresco']['version']
node.default['artifacts']['keystore']['destination']       = node['alfresco']['properties']['dir.root']
node.default['artifacts']['keystore']['subfolder']         = "alfresco/keystore/\*"
node.default['artifacts']['keystore']['owner']             = node['tomcat']['user']
node.default['artifacts']['keystore']['unzip']             = true

node.default['artifacts']['alfresco']['enabled']        = true
node.default['artifacts']['alfresco']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['alfresco']['artifactId'] = "alfresco"
node.default['artifacts']['alfresco']['version'] = node['alfresco']['version']
node.default['artifacts']['alfresco']['type'] = "war"
node.default['artifacts']['alfresco']['destination'] = node['tomcat']['webapp_dir']
node.default['artifacts']['alfresco']['owner'] = node['tomcat']['user']
node.default['artifacts']['alfresco']['unzip'] = false
