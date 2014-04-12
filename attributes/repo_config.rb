# Alfresco Global Properties
default['alfresco']['db']['jdbc_url']  = "jdbc:mysql://#{node['alfresco']['db']['host']}/#{node['alfresco']['db']['database']}?useUnicode=yes&characterEncoding=UTF-8"

default['alfresco']['img']['root'] = "/usr"
default['alfresco']['swf']['exe']  = "/usr/bin/pdf2swf"
default['alfresco']['ooo']['exe']      = "/usr/bin/soffice"
default['alfresco']['ooo']['enabled']  = "true"
default['alfresco']['jodconverter']['enabled']       = "true"
default['alfresco']['jodconverter']['office_home']   = "/usr/lib/libreoffice"
default['alfresco']['jodconverter']['port_numbers']  = "8100"

default['alfresco']['ftp']['enabled'] = false
default['alfresco']['search'] = "solr"
default['alfresco']['cluster']['name'] = "alfrescovagrant"

### Mail Defaults
default['alfresco']['mail']['protocol']         = "smtp"
default['alfresco']['mail']['port']             = "25"
default['alfresco']['mail']['username']         = "anonymous"
default['alfresco']['mail']['encoding']         = "UTF-8"
default['alfresco']['mail']['from']['default']  = "alfresco@alfresco.org"
default['alfresco']['mail']['smtp']['auth']                 = "false"
default['alfresco']['mail']['smtps']['auth']                = "false"
default['alfresco']['mail']['smtps']['starttls']['enable']  = "false"

### IMAP Server Defaults
default['alfresco']['imap']['server']['enabled']  = "false"
default['alfresco']['imap']['server']['port']     = "1143"
default['alfresco']['imap']['server']['host']     = "0.0.0.0"

### Solr Defaults
default['alfresco']['solr']['solr_host']    = node['alfresco']['url']['solr']['host']
default['alfresco']['solr']['solr_port']    = node['alfresco']['url']['solr']['port']
default['alfresco']['solr']['solr_portssl'] = node['alfresco']['default_portssl']

### CIFS Server Defaults
default['alfresco']['cifs']['enabled']                      = "false"
default['alfresco']['cifs']['server_name']                  = "alfresco"
default['alfresco']['cifs']['ipv6']['enabled']              = "false"
default['alfresco']['cifs']['tcpip_smb']['port']            = "1445"
default['alfresco']['cifs']['netbios_smb']['name_port']     = "1137"
default['alfresco']['cifs']['netbios_smb']['datagram_port'] = "1138"
default['alfresco']['cifs']['netbios_smb']['session_port']  = "1139"

# Artifact Deployer attributes
default['artifacts']['mysqlconnector']['groupId'] = "mysql"
default['artifacts']['mysqlconnector']['artifactId'] = "mysql-connector-java"
default['artifacts']['mysqlconnector']['version'] = "5.1.30"
default['artifacts']['mysqlconnector']['destination'] = "#{node['tomcat']['shared']}"
default['artifacts']['mysqlconnector']['owner'] = node['tomcat']['user']
default['artifacts']['mysqlconnector']['unzip'] = false

default['artifacts']['alfresco']['groupId'] = node['alfresco']['groupId']
default['artifacts']['alfresco']['artifactId'] = node['alfresco']['artifactId']
default['artifacts']['alfresco']['version'] = node['alfresco']['version']
default['artifacts']['alfresco']['type'] = "war"
default['artifacts']['alfresco']['destination'] = node['tomcat']['webapps']
default['artifacts']['alfresco']['owner'] = node['tomcat']['user']
default['artifacts']['alfresco']['unzip'] = false
