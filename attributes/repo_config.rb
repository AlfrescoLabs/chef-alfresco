######################################################
### alfresco-global.properties used only in Alfresco Repository application
######################################################

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
default['alfresco']['properties']['index.subsystem.name'] = 'lucene'

################################
### Artifact Deployer attributes
################################

default['artifacts']['mysqlconnector']['groupId'] = "mysql"
default['artifacts']['mysqlconnector']['artifactId'] = "mysql-connector-java"
default['artifacts']['mysqlconnector']['version'] = "5.1.30"
default['artifacts']['mysqlconnector']['destination'] = "#{node['alfresco']['shared']}"
default['artifacts']['mysqlconnector']['owner'] = node['tomcat']['user']
default['artifacts']['mysqlconnector']['unzip'] = false
default['artifacts']['mysqlconnector']['enabled'] = false

default['artifacts']['alfresco']['groupId'] = node['alfresco']['groupId']
default['artifacts']['alfresco']['artifactId'] = "alfresco"
default['artifacts']['alfresco']['version'] = node['alfresco']['version']
default['artifacts']['alfresco']['type'] = "war"
default['artifacts']['alfresco']['destination'] = node['tomcat']['webapp_dir']
default['artifacts']['alfresco']['owner'] = node['tomcat']['user']
default['artifacts']['alfresco']['unzip'] = false
default['artifacts']['alfresco']['enabled'] = false

default['artifacts']['alfresco-mmt']['groupId'] = "it.session.alfresco"
default['artifacts']['alfresco-mmt']['artifactId'] = "alfresco-mmt"
default['artifacts']['alfresco-mmt']['version'] = "4.2.1.4"
default['artifacts']['alfresco-mmt']['type'] = "jar"
default['artifacts']['alfresco-mmt']['classifier'] = "fatjar"
default['artifacts']['alfresco-mmt']['destination'] = "#{node['alfresco']['bin']}"
default['artifacts']['alfresco-mmt']['owner'] = node['tomcat']['user']
default['artifacts']['alfresco-mmt']['unzip'] = false
default['artifacts']['alfresco-mmt']['enabled'] = false

default['artifacts']['alfresco-spp']['groupId'] = node['alfresco']['groupId']
default['artifacts']['alfresco-spp']['artifactId'] = "alfresco-spp"
default['artifacts']['alfresco-spp']['version'] = node['alfresco']['version']
default['artifacts']['alfresco-spp']['type'] = "amp"
default['artifacts']['alfresco-spp']['destination'] = node['alfresco']['amps_folder']
default['artifacts']['alfresco-spp']['owner'] = node['tomcat']['user']
default['artifacts']['alfresco-spp']['unzip'] = false
default['artifacts']['alfresco-spp']['enabled'] = false

# Filtering properties with placeholders defined in the mentioned files (only if classes zip is part of the artifact list, see recipes)
default['artifacts']['classes']['enabled'] = false
default['artifacts']['classes']['unzip'] = true
default['artifacts']['classes']['destination'] = node['alfresco']['shared']
default['artifacts']['classes']['owner'] = node['tomcat']['user']
default['artifacts']['classes']['properties']['alfresco-global.properties'] = node['alfresco']['properties']
default['artifacts']['classes']['properties']['alfresco/extension/repo-log4j.properties'] = node['alfresco']['properties']
default['artifacts']['classes']['properties']['alfresco/web-extension/share-log4j.properties'] = node['alfresco']['properties']