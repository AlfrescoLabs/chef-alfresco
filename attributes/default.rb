#######################################
# Chef Alfresco Components and Features
#######################################
default['alfresco']['components'] = ['tomcat','transform','repo','share','solr','mysql']

#Generates alfresco-global.properties using all node['alfresco']['properties'] key/value attributes
default['alfresco']['generate.global.properties'] = true

#Generates share-config-custom.xml using a pre-defined template (check templates/default) and configuring http endpoint and disabling CSRF
default['alfresco']['generate.share.config.custom'] = true

#Patches an existing share-config-custom.xml using node['alfresco']['properties'] key/value attributes and replacing all @@key@@ occurrencies
default['alfresco']['patch.share.config.custom'] = false

#Generates repo-log4j.properties using all node['alfresco']['repo-log4j'] key/value attributes
default['alfresco']['generate.repo.log4j.properties'] = true

#Generates share-log4j.properties using all node['alfresco']['share-log4j'] key/value attributes
default['alfresco']['generate.share.log4j.properties'] = true

##########################
### Default's defaults :-)
##########################
#default['alfresco']['default_hostname'] = node['fqdn']
default['alfresco']['default_hostname'] = "localhost"
default['alfresco']['default_port']     = "8080"
default['alfresco']['default_portssl']  = "8443"
default['alfresco']['default_protocol'] = "http"

# Artifact Deployer attributes - Artifact coordinates defaults used in sub-recipes
default['alfresco']['groupId'] = "org.alfresco"
default['alfresco']['version'] = "5.0.a"

# Important Alfresco and Solr global properties
default['alfresco']['properties']['dir.root']           = "#{node['tomcat']['base']}/alf_data"
default['alfresco']['solrproperties']['data.dir.root']  = "#{node['alfresco']['properties']['dir.root']}/solrhome"

# Tomcat defaults
node.default["tomcat"]["files_cookbook"]      = "alfresco"
node.default["tomcat"]["deploy_manager_apps"] = false
node.default["tomcat"]["jvm_memory"]          = "-Xmx1500M -XX:MaxPermSize=256M"
node.default["tomcat"]["java_options"]        = "#{node['tomcat']['jvm_memory']} -Djava.rmi.server.hostname=#{node['alfresco']['default_hostname']} -Dsolr.solr.home=#{node['alfresco']['solrproperties']['data.dir.root']} -Dcom.sun.management.jmxremote=true -Dsun.security.ssl.allowUnsafeRenegotiation=true"

# Java defaults
node.default["java"]["default"]                                 = true
node.default["java"]["accept_license_agreement"]                = true
node.default["java"]["install_flavor"]                          = "oracle"
node.default["java"]["jdk_version"]                             = "7"
node.default["java"]["oracle"]['accept_oracle_download_terms']  = true

# Choose whether to start services or not after provisioning (Docker would fail if any service attempts to start)
default["alfresco"]["start_service"] = false
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
default['alfresco']['properties']['alfresco.port']      = node['alfresco']['default_port']
default['alfresco']['properties']['alfresco.port.ssl']  = node['alfresco']['default_portssl']
default['alfresco']['properties']['alfresco.protocol']  = node['alfresco']['default_protocol']

#Share URL
default['alfresco']['properties']['share.context']      = '/share'
default['alfresco']['properties']['share.host']         = node['alfresco']['default_hostname']
default['alfresco']['properties']['share.port']         = node['alfresco']['default_port']
default['alfresco']['properties']['share.protocol']     = node['alfresco']['default_protocol']

#Solr URL
default['alfresco']['properties']['solr.host']          = node['alfresco']['default_hostname']
default['alfresco']['properties']['solr.port']          = node['alfresco']['default_port']
default['alfresco']['properties']['solr.port.ssl']      = node['alfresco']['default_portssl']
default['alfresco']['properties']['solr.secureComms']   = 'https'

#SSL Keystore
default['alfresco']['properties']['dir.keystore']     = "#{node['alfresco']['properties']['dir.root']}/keystore/alfresco/keystore"

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
default['alfresco']['db']['repo_hosts']             = ["%"]


##################
# Shared Artifacts
##################

# Filtering properties with placeholders defined in the mentioned files (only if classes zip is part of the artifact list, see recipes)
default['artifacts']['sharedclasses']['unzip'] = false
default['artifacts']['sharedclasses']['filtering_mode'] = "append"
default['artifacts']['sharedclasses']['destination'] = node['alfresco']['shared']
default['artifacts']['sharedclasses']['destinationName'] = "classes"
default['artifacts']['sharedclasses']['owner'] = node['tomcat']['user']
