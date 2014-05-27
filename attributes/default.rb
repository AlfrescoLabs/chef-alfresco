# Artifact Deployer attributes - Artifact coordinates defaults used in sub-recipes
default['alfresco']['groupId'] = "org.alfresco"
default['alfresco']['version'] = "4.2.f"
default["alfresco"]["start_service"] = node["tomcat"]["start_service"]

version = node["tomcat"]["base_version"]
start_service = node["alfresco"]["start_service"]
if start_service == false
  default['alfresco']['restart_services'] = []
  default['alfresco']['restart_action']   = "nothing"
elsif platform?("centos") and version == 7
  default['alfresco']['restart_services'] = ["tomcat"]
  default['alfresco']['restart_action']   = "start"
else
  default['alfresco']['restart_services'] = ["tomcat7"]
  default['alfresco']['restart_action']   = "restart"
end

##########################
### Default's defaults :-)
##########################
default['alfresco']['default_hostname'] = "localhost"
#default['alfresco']['default_hostname'] = node['fqdn']
default['alfresco']['default_port']     = "8080"
default['alfresco']['default_portssl']  = "8443"
default['alfresco']['default_protocol'] = "http"

# Logging defaults used by artifact-deployer configurations, see repo_config and solr_config defaults
default['logging']['log4j.rootLogger']                                = "error, Console, File"
default['logging']['log4j.appender.Console']                          = "org.apache.log4j.ConsoleAppender"
default['logging']['log4j.appender.Console.layout']                   = "org.apache.log4j.PatternLayout"
default['logging']['log4j.appender.Console.layout.ConversionPattern'] = "%d{ISO8601} %x %-5p [%c{3}] [%t] %m%n"
default['logging']['log4j.appender.File']                             = "org.apache.log4j.DailyRollingFileAppender"
default['logging']['log4j.appender.File.Append']                      = "true"
default['logging']['log4j.appender.File.DatePattern']                 = "'.'yyyy-MM-dd"
default['logging']['log4j.appender.File.layout']                      = "org.apache.log4j.PatternLayout"
default['logging']['log4j.appender.File.layout.ConversionPattern']    = "%d{ABSOLUTE} %-5p [%c] %m%n"

######################################################
### alfresco-global.properties used across all recipes
######################################################

#Contentstore
default['alfresco']['properties']['dir.root']           = "#{default['tomcat']['base']}/alf_data"

#JMX
default['alfresco']['properties']['monitor.rmi.services.port']  = 50508

#Database
default['alfresco']['properties']['db.driver']          = 'org.gjt.mm.mysql.Driver'
default['alfresco']['properties']['db.username']        = 'alfresco'
default['alfresco']['properties']['db.password']        = 'alfresco'

#Additional DB params
default['alfresco']['properties']['db.prefix']          = 'mysql'
default['alfresco']['properties']['db.host']            = node['alfresco']['default_hostname']
default['alfresco']['properties']['db.port']            = 3306
default['alfresco']['properties']['db.dbname']          = 'alfresco'
default['alfresco']['properties']['db.params']          = 'useUnicode=yes&characterEncoding=UTF-8'

#Derived DB param
default['alfresco']['properties']['db.url']             = "jdbc:#{node['alfresco']['properties']['db.prefix']}://#{node['alfresco']['properties']['db.host']}/#{node['alfresco']['properties']['db.dbname']}?#{node['alfresco']['properties']['db.params']}"

#Alfresco URL
default['alfresco']['properties']['hostname.public']    = node['alfresco']['default_hostname']

default['alfresco']['properties']['alfresco.context']   = '/alfresco'
default['alfresco']['properties']['alfresco.host']      = node['alfresco']['default_hostname']
default['alfresco']['properties']['alfresco.port']      = default['alfresco']['default_port']
default['alfresco']['properties']['alfresco.port.ssl']  = default['alfresco']['default_portssl']
default['alfresco']['properties']['alfresco.protocol']  = default['alfresco']['default_protocol']

#Share URL
default['alfresco']['properties']['share.context']      = '/share'
default['alfresco']['properties']['share.host']         = node['alfresco']['default_hostname']
default['alfresco']['properties']['share.port']         = default['alfresco']['default_port']
default['alfresco']['properties']['share.protocol']     = default['alfresco']['default_protocol']

#Solr URL
default['alfresco']['properties']['solr.host']          = node['alfresco']['default_hostname']
default['alfresco']['properties']['solr.port']          = default['alfresco']['default_port']
default['alfresco']['properties']['solr.port.ssl']      = default['alfresco']['default_portssl']
default['alfresco']['properties']['solr.secureComms']   = 'https'
default['alfresco']['solrproperties']['data.dir.root']  = "#{node['alfresco']['properties']['dir.root']}/solrhome"

# SSL
default['artifacts']['keystore']['groupId']           = "org.alfresco"
default['artifacts']['keystore']['artifactId']        = "alfresco-repository"
default['artifacts']['keystore']['version']           = node['alfresco']['version']
default['artifacts']['keystore']['destination']       = node['alfresco']['properties']['dir.root']
default['artifacts']['keystore']['subfolder']         = "alfresco/keystore/\*"
default['artifacts']['keystore']['owner']             = node['tomcat']['user']
default['artifacts']['keystore']['unzip']             = true
default['artifacts']['keystore']['enabled']           = false

if node['alfresco']['version'].start_with?("4.3")
  default['alfresco']['properties']['dir.keystore']     = "#{node['alfresco']['properties']['dir.root']}/keystore/alfresco/keystore"
else
  default['alfresco']['properties']['dir.keystore']     = "#{node['alfresco']['solrproperties']['data.dir.root']}/alf_data/keystore"
end

##############################################
### Tomcat Configuration for Alfresco keystore
##############################################
default["alfresco"]["keystore_file"]        = "#{node['alfresco']['properties']['dir.keystore']}/ssl.keystore"
default["alfresco"]["keystore_password"]    = "kT9X6oe68t"
default["alfresco"]["keystore_type"]        = "JCEKS"
default["alfresco"]["truststore_file"]      = "#{node['alfresco']['properties']['dir.keystore']}/ssl.truststore"
default["alfresco"]["truststore_password"]  = "kT9X6oe68t"
default["alfresco"]["truststore_type"]      = "JCEKS"

#################################
### Default recipe configurations
#################################

# Additional Tomcat paths
default['alfresco']['bin']                = "#{default['tomcat']['home']}/bin"
default['alfresco']['shared']             = "#{default['tomcat']['base']}/shared"
default['alfresco']['amps_folder']        = "#{default['tomcat']['base']}/amps"
default['alfresco']['amps_share_folder']  = "#{default['tomcat']['base']}/amps_share"

# DB params shared between client and server
default['alfresco']['db']['server_root_password']   = default['mysql']['server_root_password']
default['alfresco']['db']['root_user']              = "root"
default['alfresco']['db']['bind_address']           = default['mysql']['bind_address']
default['alfresco']['db']['repo_hosts']             = [node['alfresco']['default_hostname']]

# Enable iptables alfresco-ports
default['alfresco']['iptables'] = true

# Artifact Deployer attributes - Maven repo configurations
# default['alfresco']['maven']['repo_type']             = "public"
# default['alfresco']['maven']['username']              = "alfresco"
# default['alfresco']['maven']['password']              = "password"

# alfresco_type = node['alfresco']['maven']['repo_type']
# default['maven']['repos'][alfresco_type]['username']  = node['alfresco']['maven']['username']
# default['maven']['repos'][alfresco_type]['password']  = node['alfresco']['maven']['password']
# default['maven']['repos'][alfresco_type]['url']       = "https://artifacts.alfresco.com/nexus/content/groups/#{node['alfresco']['maven']['repo_type']}"