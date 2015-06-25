#JMX host
default['alfresco']['properties']['hostname.public'] = node['alfresco']['default_hostname']
default['alfresco']['properties']['hostname.private'] = node['alfresco']['default_hostname']

default['alfresco']['properties']['dir.root'] = "#{node['alfresco']['home']}/alf_data"
default['alfresco']['properties']['dir.keystore'] = "#{node['alfresco']['properties']['dir.root']}/keystore/alfresco/keystore"

#Cluster
default['alfresco']['properties']['alfresco.cluster.name'] = 'alfrescoboxes'

#Auth - no guest login
default['alfresco']['properties']['alfresco.authentication.allowGuestLogin'] = false

#Transformations
default['alfresco']['properties']['ffmpeg.exe'] = '/usr/bin/ffmpeg'
default['alfresco']['properties']['ooo.enabled'] = false
default['alfresco']['properties']['jodconverter.officeHome'] = '/usr/lib64/libreoffice'
default['alfresco']['properties']['jodconverter.portNumbers'] = '8101,8102'
default['alfresco']['properties']['jodconverter.enabled'] = true
default['alfresco']['properties']['img.root'] = '/usr'
default['alfresco']['properties']['swf.exe'] = '/usr/local/bin/pdf2swf'
default['alfresco']['properties']['img.exe'] = '/usr/bin/convert'
default['alfresco']['properties']['img.dyn'] = '${img.root}/lib64'
default['alfresco']['properties']['img.gslib'] = '${img.dyn}'
default['alfresco']['properties']['img.coders'] = '${img.dyn}/ImageMagick-6.7.8/modules-Q16/coders'
default['alfresco']['properties']['img.config'] = '${img.dyn}/ImageMagick-6.7.8/config'

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
default['alfresco']['properties']['mail.from.default'] = "webmaster@#{node['alfresco']['default_hostname']}"
default['alfresco']['properties']['mail.from.enabled'] = false
default['alfresco']['properties']['mail.smtp.auth'] = false
default['alfresco']['properties']['mail.smtps.starttls.enable'] = false
default['alfresco']['properties']['mail.smtps.auth'] = false

# Repo config
default['alfresco']['properties']['alfresco.context'] = '/alfresco'
default['alfresco']['properties']['alfresco.host'] = node['alfresco']['default_hostname']
default['alfresco']['properties']['alfresco.port'] = node['alfresco']['default_port']
default['alfresco']['properties']['alfresco.port.ssl'] = node['alfresco']['default_portssl']
default['alfresco']['properties']['alfresco.protocol'] = node['alfresco']['default_protocol']

#Search Config
default['alfresco']['properties']['index.subsystem.name'] = 'solr4'
default['alfresco']['properties']['solr.host'] = node['alfresco']['default_hostname']
default['alfresco']['properties']['solr.port'] = node['alfresco']['default_port']
default['alfresco']['properties']['solr.port.ssl'] = node['alfresco']['default_portssl']
default['alfresco']['properties']['solr.secureComms'] = 'none'

#Share URLs
default['alfresco']['properties']['share.context'] = '/share'
default['alfresco']['properties']['share.host'] = node['alfresco']['default_hostname']
default['alfresco']['properties']['share.port'] = node['alfresco']['default_port']
default['alfresco']['properties']['share.protocol'] = node['alfresco']['default_protocol']

#JMX
default['alfresco']['properties']['alfresco.rmi.services.host'] = '0.0.0.0'
default['alfresco']['properties']['monitor.rmi.services.port']  = 50508

#Database
default['alfresco']['mysql_version'] = '5.6'
default['alfresco']['properties']['db.driver'] = 'org.gjt.mm.mysql.Driver'
default['alfresco']['properties']['db.username'] = 'alfresco'
default['alfresco']['properties']['db.password'] = 'alfresco'
default['alfresco']['properties']['db.prefix'] = 'mysql'
default['alfresco']['properties']['db.host'] = '127.0.0.1'
default['alfresco']['properties']['db.port'] = '3306'
default['alfresco']['properties']['db.dbname'] = 'alfresco'
default['alfresco']['properties']['db.params'] = 'useUnicode=yes&characterEncoding=UTF-8'
default['alfresco']['properties']['db.url'] = "jdbc:#{node['alfresco']['properties']['db.prefix']}://#{node['alfresco']['properties']['db.host']}/#{node['alfresco']['properties']['db.dbname']}?#{node['alfresco']['properties']['db.params']}"

# OpenCMIS
default['alfresco']['properties']['opencmis.server.host'] = node['alfresco']['default_hostname']
default['alfresco']['properties']['opencmis.server.protocol'] = node['alfresco']['default_protocol']
default['alfresco']['properties']['opencmis.server.value'] = "${opencmis.server.protocol}://${opencmis.server.host}/alfresco/api"
default['alfresco']['properties']['opencmis.context.override'] = true
default['alfresco']['properties']['opencmis.context.value'] = ''
default['alfresco']['properties']['opencmis.servletpath.override'] = true
default['alfresco']['properties']['opencmis.servletpath.value'] = ''
default['alfresco']['properties']['opencmis.server.override'] = true

# AOS
default['alfresco']['properties']['aos.port'] = "80"
default['alfresco']['properties']['aos.baseProtocol'] = node['alfresco']['default_protocol']
default['alfresco']['properties']['aos.baseHost'] = node['alfresco']['default_hostname']
default['alfresco']['properties']['aos.baseUrlOverwrite'] = "${aos.baseProtocol}://${aos.baseHost}:${aos.port}/alfresco/aos"
