#General
default['alfresco']['system.serverMode'] = 'PRODUCTION'

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
default['alfresco']['properties']['db.ssl_params'] = node['alfresco']['db_ssl_enabled'] == true ? "&useSSL=true&requireSSL=true&verifyServerCertificate=true&trustCertificateKeyStoreUrl=file://#{node['alfresco']['truststore_file']}&trustCertificateKeyStoreType=#{node['alfresco']['truststore_type']}&trustCertificateKeyStorePassword=#{node['alfresco']['truststore_password']}" : ''
default['alfresco']['properties']['db.url'] = "jdbc:${db.prefix}://${db.host}/${db.dbname}?${db.params}${db.ssl_params}"
node.set['alfresco']['properties']['db.pool.initial'] = 30
node.set['alfresco']['properties']['db.pool.max'] = 500
node.set['alfresco']['properties']['db.pool.min'] = 0
node.set['alfresco']['properties']['db.pool.evict.interval'] = 900000
node.set['alfresco']['properties']['db.pool.evict.idle.min'] = 1800000
node.set['alfresco']['properties']['db.pool.evict.num.tests'] = -2
node.set['alfresco']['properties']['db.pool.evict.validate'] = true

default['alfresco']['apply_amps'] = false

#JMX
default['alfresco']['properties']['alfresco.rmi.services.host'] = '0.0.0.0'
default['alfresco']['properties']['monitor.rmi.services.port']  = 50508

# OpenCMIS
default['alfresco']['properties']['opencmis.server.value'] = "${opencmis.server.protocol}://${opencmis.server.host}/alfresco/api"
default['alfresco']['properties']['opencmis.context.override'] = true
default['alfresco']['properties']['opencmis.context.value'] = ''
default['alfresco']['properties']['opencmis.servletpath.override'] = true
default['alfresco']['properties']['opencmis.servletpath.value'] = ''
default['alfresco']['properties']['opencmis.server.override'] = true

# Paths
default['alfresco']['properties']['share.context'] = 'share'
default['alfresco']['properties']['alfresco.context'] = 'alfresco'

#Search Config
default['alfresco']['properties']['index.subsystem.name'] = 'solr4'
default['alfresco']['properties']['solr.secureComms'] = 'none'

#Email
default['alfresco']['properties']['mail.protocol'] = 'smtp'
default['alfresco']['properties']['mail.host'] = '0.0.0.0'
default['alfresco']['properties']['mail.port'] = '25'
default['alfresco']['properties']['mail.encoding'] = 'UTF-8'
default['alfresco']['properties']['mail.from.enabled'] = false
default['alfresco']['properties']['mail.smtp.auth'] = false
default['alfresco']['properties']['mail.smtps.starttls.enable'] = false
default['alfresco']['properties']['mail.smtps.auth'] = false

# AOS
default['alfresco']['properties']['aos.baseUrlOverwrite'] = "${aos.baseProtocol}://${aos.baseHost}:${aos.port}/alfresco/aos"

#Cluster
default['alfresco']['properties']['alfresco.cluster.name'] = 'alfrescocluster'

#Auth - no guest login
default['alfresco']['properties']['alfresco.authentication.allowGuestLogin'] = false

#Transformations
default['alfresco']['properties']['ffmpeg.exe'] = '/usr/bin/ffmpeg'
default['alfresco']['properties']['ooo.enabled'] = false
default['alfresco']['properties']['jodconverter.officeHome'] = '/opt/libreoffice5.2/'
default['alfresco']['properties']['jodconverter.portNumbers'] = '8101'
default['alfresco']['properties']['jodconverter.enabled'] = true
default['alfresco']['properties']['jodconverter.connectTimeout'] = 50000
default['alfresco']['properties']['img.root'] = '/usr'
default['alfresco']['properties']['swf.exe'] = '/usr/local/bin/pdf2swf'
default['alfresco']['properties']['img.exe'] = '/usr/bin/convert'
default['alfresco']['properties']['img.dyn'] = '${img.root}/lib64'
default['alfresco']['properties']['img.gslib'] = '${img.dyn}'
default['alfresco']['properties']['img.coders'] = '${img.dyn}/ImageMagick-6.7.8/modules-Q16/coders'
default['alfresco']['properties']['img.config'] = '${img.dyn}/ImageMagick-6.7.8/config'

# Enable smart folders
default['alfresco']['properties']['smart.folders.enabled'] = true

#FTP
default['alfresco']['properties']['ftp.enabled'] = false

#IMAP
default['alfresco']['properties']['imap.server.enabled'] = false
default['alfresco']['properties']['imap.server.imap.enabled'] = false
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

# Replication
default['alfresco']['properties']['replication.enabled'] = true
