# Additional Alfresco paths
node.default['alfresco']['bin'] = "#{node['alfresco']['home']}/bin"
node.default['alfresco']['shared'] = "#{node['alfresco']['home']}/shared"
node.default['alfresco']['shared_lib'] = "#{node['alfresco']['shared']}/lib"
node.default['alfresco']['amps_folder'] = "#{node['alfresco']['home']}/amps"
node.default['alfresco']['amps_share_folder'] = "#{node['alfresco']['home']}/amps_share"

node.default['alfresco']['server_info'] = "Alfresco (#{node['alfresco']['default_hostname']})"

node.default['alfresco']['log4j'] = node['logging']

#JMX host
node.default['alfresco']['properties']['hostname.public'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['hostname.private'] = node['alfresco']['default_hostname']

node.default['alfresco']['properties']['dir.root'] = "#{node['alfresco']['home']}/alf_data"
node.default['alfresco']['properties']['dir.keystore'] = "#{node['alfresco']['properties']['dir.root']}/keystore/alfresco/keystore"

#Cluster
node.default['alfresco']['properties']['alfresco.cluster.name'] = 'alfrescoboxes'

#Auth - no guest login
node.default['alfresco']['properties']['alfresco.authentication.allowGuestLogin'] = false

#Transformations
node.default['alfresco']['properties']['ffmpeg.exe'] = '/usr/bin/ffmpeg'
node.default['alfresco']['properties']['ooo.enabled'] = false
node.default['alfresco']['properties']['jodconverter.officeHome'] = '/usr/lib64/libreoffice'
node.default['alfresco']['properties']['jodconverter.portNumbers'] = '8101,8102'
node.default['alfresco']['properties']['jodconverter.enabled'] = true
node.default['alfresco']['properties']['img.root'] = '/usr'
node.default['alfresco']['properties']['swf.exe'] = '/usr/local/bin/pdf2swf'
node.default['alfresco']['properties']['img.exe'] = '/usr/bin/convert'
node.default['alfresco']['properties']['img.dyn'] = '${img.root}/lib64'
node.default['alfresco']['properties']['img.gslib'] = '${img.dyn}'
node.default['alfresco']['properties']['img.coders'] = '${img.dyn}/ImageMagick-6.7.8/modules-Q16/coders'
node.default['alfresco']['properties']['img.config'] = '${img.dyn}/ImageMagick-6.7.8/config'

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
node.default['alfresco']['properties']['mail.from.default'] = "webmaster@#{node['alfresco']['default_hostname']}"
node.default['alfresco']['properties']['mail.from.enabled'] = false
node.default['alfresco']['properties']['mail.smtp.auth'] = false
node.default['alfresco']['properties']['mail.smtps.starttls.enable'] = false
node.default['alfresco']['properties']['mail.smtps.auth'] = false

# Repo config
node.default['alfresco']['properties']['alfresco.context'] = '/alfresco'
node.default['alfresco']['properties']['alfresco.host'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['alfresco.port'] = node['alfresco']['default_port']
node.default['alfresco']['properties']['alfresco.port.ssl'] = node['alfresco']['default_portssl']
node.default['alfresco']['properties']['alfresco.protocol'] = node['alfresco']['default_protocol']

#Search Config
node.default['alfresco']['properties']['index.subsystem.name'] = 'solr4'
node.default['alfresco']['properties']['solr.host'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['solr.port'] = node['alfresco']['default_port']
node.default['alfresco']['properties']['solr.port.ssl'] = node['alfresco']['default_portssl']
node.default['alfresco']['properties']['solr.secureComms'] = 'none'

#Share URLs
node.default['alfresco']['properties']['share.context'] = '/share'
node.default['alfresco']['properties']['share.host'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['share.port'] = node['alfresco']['default_port']
node.default['alfresco']['properties']['share.protocol'] = node['alfresco']['default_protocol']

#JMX
node.default['alfresco']['properties']['alfresco.rmi.services.host'] = '0.0.0.0'
node.default['alfresco']['properties']['monitor.rmi.services.port']  = 50508

#Database
node.default['alfresco']['mysql_version'] = '5.6'
node.default['alfresco']['properties']['db.driver'] = 'org.gjt.mm.mysql.Driver'
node.default['alfresco']['properties']['db.username'] = 'alfresco'
node.default['alfresco']['properties']['db.password'] = 'alfresco'
node.default['alfresco']['properties']['db.prefix'] = 'mysql'
node.default['alfresco']['properties']['db.host'] = '127.0.0.1'
node.default['alfresco']['properties']['db.port'] = '3306'
node.default['alfresco']['properties']['db.dbname'] = 'alfresco'
node.default['alfresco']['properties']['db.params'] = 'useUnicode=yes&characterEncoding=UTF-8'
node.default['alfresco']['properties']['db.url'] = "jdbc:#{node['alfresco']['properties']['db.prefix']}://#{node['alfresco']['properties']['db.host']}/#{node['alfresco']['properties']['db.dbname']}?#{node['alfresco']['properties']['db.params']}"

# OpenCMIS
node.default['alfresco']['properties']['opencmis.server.host'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['opencmis.server.protocol'] = node['alfresco']['default_protocol']
node.default['alfresco']['properties']['opencmis.server.value'] = "${opencmis.server.protocol}://${opencmis.server.host}/alfresco/api"
node.default['alfresco']['properties']['opencmis.context.override'] = true
node.default['alfresco']['properties']['opencmis.context.value'] = ''
node.default['alfresco']['properties']['opencmis.servletpath.override'] = true
node.default['alfresco']['properties']['opencmis.servletpath.value'] = ''
node.default['alfresco']['properties']['opencmis.server.override'] = true

# AOS
node.default['alfresco']['properties']['aos.port'] = "80"
node.default['alfresco']['properties']['aos.baseProtocol'] = node['alfresco']['default_protocol']
node.default['alfresco']['properties']['aos.baseHost'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['aos.baseUrlOverwrite'] = "${aos.baseProtocol}://${aos.baseHost}:${aos.port}/alfresco/aos"
