######################################################
### alfresco-global.properties used only in Alfresco Repository application
######################################################

#JMX host
default['alfresco']['properties']['hostname.private'] = node['alfresco']['default_hostname']

#Cluster
default['alfresco']['properties']['alfresco.cluster.name'] = 'alfrescoboxes'

#Transformations
default['alfresco']['properties']['ooo.exe'] = '/usr/bin/soffice'
default['alfresco']['properties']['ooo.enabled'] = true
default['alfresco']['properties']['jodconverter.officeHome'] = '/usr/lib/libreoffice'
default['alfresco']['properties']['jodconverter.portNumbers'] = '8100'
default['alfresco']['properties']['jodconverter.enabled'] = true
default['alfresco']['properties']['img.root'] = '/usr'
default['alfresco']['properties']['swf.exe'] = '/usr/bin/pdf2swf'

#FTP
default['alfresco']['properties']['ftp.enabled'] = false

#IMAP
default['alfresco']['properties']['imap.server.enabled'] = false
default['alfresco']['properties']['imap.server.port'] = '1143'
default['alfresco']['properties']['imap.server.host'] = '0.0.0.0'

#CIFS
default['alfresco']['properties']['cifs.enabled'] = false
default['alfresco']['properties']['cifs.serverName'] = 'alfresco'
default['alfresco']['properties']['cifs.ipv6.enabled'] = false
default['alfresco']['properties']['cifs.tcpipSMB.port'] = '1445'
default['alfresco']['properties']['cifs.netBIOSSMB.namePort'] = '1137'
default['alfresco']['properties']['cifs.netBIOSSMB.datagramPort'] = '1138'
default['alfresco']['properties']['cifs.netBIOSSMB.sessionPort'] = '1139'

#Email
default['alfresco']['properties']['mail.protocol'] = 'smtp'
default['alfresco']['properties']['mail.host'] = '0.0.0.0'
default['alfresco']['properties']['mail.port'] = '25'
default['alfresco']['properties']['mail.username'] = 'anonymous'
default['alfresco']['properties']['mail.password'] = ''
default['alfresco']['properties']['mail.encoding'] = 'UTF-8'
default['alfresco']['properties']['mail.from.default'] = 'alfresco@alfresco.org'
default['alfresco']['properties']['mail.smtp.auth'] = false
default['alfresco']['properties']['mail.smtps.starttls.enable'] = false
default['alfresco']['properties']['mail.smtps.auth'] = false

#Search
default['alfresco']['properties']['index.subsystem.name'] = 'solr'

####################################################
### Logging Attributes
# added below in the artifact-deployer configuration
####################################################
default['alfresco']['repo-log4j'] = node['logging']
default['alfresco']['repo-log4j']['log4j.appender.File.File'] = "#{node['tomcat']['log_dir']}/alfresco.log"
default['alfresco']['share-log4j'] = node['logging']
default['alfresco']['share-log4j']['log4j.appender.File.File'] = "#{node['tomcat']['log_dir']}/share.log"

################################
### Artifact Deployer attributes
################################

default['artifacts']['mysqlconnector']['enabled'] = false
default['artifacts']['mysqlconnector']['groupId'] = "mysql"
default['artifacts']['mysqlconnector']['artifactId'] = "mysql-connector-java"
default['artifacts']['mysqlconnector']['version'] = "5.1.30"
default['artifacts']['mysqlconnector']['destination'] = node['alfresco']['shared']
default['artifacts']['mysqlconnector']['owner'] = node['tomcat']['user']
default['artifacts']['mysqlconnector']['unzip'] = false

default['artifacts']['postgresconnector']['enabled'] = false
default['artifacts']['postgresconnector']['groupId'] = "org.postgresql"
default['artifacts']['postgresconnector']['artifactId'] = "postgresql"
default['artifacts']['postgresconnector']['version'] = "9.2-1002-jdbc4"
default['artifacts']['postgresconnector']['destination'] = node['alfresco']['shared']
default['artifacts']['postgresconnector']['owner'] = node['tomcat']['user']
default['artifacts']['postgresconnector']['unzip'] = false

default['artifacts']['keystore']['groupId']           = "org.alfresco"
default['artifacts']['keystore']['artifactId']        = "alfresco-repository"
default['artifacts']['keystore']['version']           = "5.0.a"
default['artifacts']['keystore']['destination']       = node['alfresco']['properties']['dir.root']
default['artifacts']['keystore']['subfolder']         = "alfresco/keystore/\*"
default['artifacts']['keystore']['owner']             = node['tomcat']['user']
default['artifacts']['keystore']['unzip']             = true

default['artifacts']['alfresco']['groupId'] = node['alfresco']['groupId']
default['artifacts']['alfresco']['artifactId'] = "alfresco"
default['artifacts']['alfresco']['version'] = node['alfresco']['version']
default['artifacts']['alfresco']['type'] = "war"
default['artifacts']['alfresco']['destination'] = node['tomcat']['webapp_dir']
default['artifacts']['alfresco']['owner'] = node['tomcat']['user']
default['artifacts']['alfresco']['unzip'] = false

default['artifacts']['alfresco-mmt']['groupId'] = "org.alfresco"
default['artifacts']['alfresco-mmt']['artifactId'] = "alfresco-mmt"
default['artifacts']['alfresco-mmt']['version'] = "5.0.c"
default['artifacts']['alfresco-mmt']['type'] = "jar"
default['artifacts']['alfresco-mmt']['destination'] = node['alfresco']['bin']
default['artifacts']['alfresco-mmt']['owner'] = node['tomcat']['user']
default['artifacts']['alfresco-mmt']['unzip'] = false

default['artifacts']['alfresco-spp']['groupId'] = node['alfresco']['groupId']
default['artifacts']['alfresco-spp']['artifactId'] = "alfresco-spp"
default['artifacts']['alfresco-spp']['version'] = node['alfresco']['version']
default['artifacts']['alfresco-spp']['type'] = "amp"
default['artifacts']['alfresco-spp']['destination'] = node['alfresco']['amps_folder']
default['artifacts']['alfresco-spp']['owner'] = node['tomcat']['user']
default['artifacts']['alfresco-spp']['unzip'] = false
