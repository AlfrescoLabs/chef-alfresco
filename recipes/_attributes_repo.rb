# HAproxy configuration
node.default['haproxy']['backends']['alfresco']['acls']['path_beg'] = ["/alfresco"]
node.default['haproxy']['backends']['alfresco']['acls']['path_reg'] = ["^/alfresco/aos/.*","^/alfresco/aos$"]
node.default['haproxy']['backends']['alfresco']['httpchk'] = "/alfresco"
node.default['haproxy']['backends']['alfresco']['nodes']['localhost'] = "127.0.0.1"
node.default['haproxy']['backends']['alfresco']['port'] = 8070

node.default['haproxy']['backends']['aos_vti']['acls']['path_reg'] = ["^/_vti_inf.html$","^/_vti_bin/.*"]
node.default['haproxy']['backends']['aos_vti']['httpchk'] = "/_vti_inf.html"
node.default['haproxy']['backends']['aos_vti']['port'] = 8070
node.default['haproxy']['backends']['aos_vti']['nodes']['localhost'] = "127.0.0.1"

node.default['haproxy']['backends']['aos_root']['acls']['path_reg'] = ["^/$ method OPTIONS","^/$ method PROPFIND"]
node.default['haproxy']['backends']['aos_root']['httpchk'] = "/"
node.default['haproxy']['backends']['aos_root']['port'] = 8070
node.default['haproxy']['backends']['aos_root']['nodes']['localhost'] = "127.0.0.1"

######################################################
### alfresco-global.properties used only in Alfresco Repository application
######################################################

#JMX host
node.default['alfresco']['properties']['hostname.private'] = node['alfresco']['default_hostname']

#Cluster
node.default['alfresco']['properties']['alfresco.cluster.name'] = 'alfrescoboxes'

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

#Search
node.default['alfresco']['properties']['index.subsystem.name'] = 'solr4'

################################
### Artifact Deployer attributes
################################

node.default['artifacts']['mysql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'mysql'
node.default['artifacts']['mysql']['groupId'] = "mysql"
node.default['artifacts']['mysql']['artifactId'] = "mysql-connector-java"
node.default['artifacts']['mysql']['version'] = "5.1.30"
node.default['artifacts']['mysql']['destination'] = node['alfresco']['shared_lib']
node.default['artifacts']['mysql']['owner'] = node['tomcat']['user']

node.default['artifacts']['psql']['enabled'] = node['alfresco']['properties']['db.prefix'] == 'psql'
node.default['artifacts']['psql']['groupId'] = "org.postgresql"
node.default['artifacts']['psql']['artifactId'] = "postgresql"
node.default['artifacts']['psql']['version'] = "9.2-1002-jdbc4"
node.default['artifacts']['psql']['destination'] = node['alfresco']['shared_lib']
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

node.default['artifacts']['_vti_bin']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['_vti_bin']['artifactId'] = "alfresco-enterprise-vti-bin"
node.default['artifacts']['_vti_bin']['version'] = node['alfresco']['version']
node.default['artifacts']['_vti_bin']['type'] = 'war'
node.default['artifacts']['_vti_bin']['destination'] = node['tomcat']['webapp_dir']
node.default['artifacts']['_vti_bin']['owner'] = node['tomcat']['user']

node.default['artifacts']['ROOT']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['ROOT']['artifactId'] = "alfresco-enterprise-server-root"
node.default['artifacts']['ROOT']['version'] = node['alfresco']['version']
node.default['artifacts']['ROOT']['type'] = 'war'
node.default['artifacts']['ROOT']['destination'] = node['tomcat']['webapp_dir']
node.default['artifacts']['ROOT']['owner'] = node['tomcat']['user']

node.default['rsyslog']['file_inputs']['repo1']['file'] = '/var/log/tomcat-alfresco/alfresco.log'
node.default['rsyslog']['file_inputs']['repo1']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['repo1']['priority'] = 50
node.default['rsyslog']['file_inputs']['repo2']['file'] = '/var/log/tomcat-alfresco/catalina.out.*'
node.default['rsyslog']['file_inputs']['repo2']['severity'] = 'info'
node.default['rsyslog']['file_inputs']['repo2']['priority'] = 51
