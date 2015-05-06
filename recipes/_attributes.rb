# NOTE! this file depends on tomcat::_attributes to define all node['tomcat'] attributes

# Java defaults
node.default["java"]["default"]                                 = true
node.default["java"]["accept_license_agreement"]                = true
node.default["java"]["install_flavor"]                          = "oracle"
node.default["java"]["jdk_version"]                             = "7"
node.default["java"]["oracle"]['accept_oracle_download_terms']  = true

##########################
### Default's defaults :-)
##########################

# Additional Alfresco paths
node.default['alfresco']['bin']                = "#{node['tomcat']['home']}/bin"
node.default['alfresco']['shared']             = "#{node['tomcat']['base']}/shared"
node.default['alfresco']['amps_folder']        = "#{node['tomcat']['base']}/amps"
node.default['alfresco']['amps_share_folder']  = "#{node['tomcat']['base']}/amps_share"

#node.default['alfresco']['default_hostname'] = node['fqdn']
node.default['alfresco']['default_hostname'] = "localhost"
node.default['alfresco']['default_port']     = "8080"
node.default['alfresco']['default_portssl']  = "8443"
node.default['alfresco']['default_protocol'] = "http"

node.default['alfresco']['server_info'] = "Alfresco (#{node['alfresco']['default_hostname']})"

# Important Alfresco and Solr global properties
node.default['alfresco']['properties']['dir.root']           = "#{node['tomcat']['base']}/alf_data"
node.default['alfresco']['solrproperties']['data.dir.root']  = "#{node['alfresco']['properties']['dir.root']}/solrhome"
node.default['alfresco']['solr_tomcat_instance']['java_options'] = "#{node['alfresco']['solr_tomcat_instance']['java_options']} -Dsolr.solr.home=#{node['alfresco']['solrproperties']['data.dir.root']}"

# Tomcat defaults of single instance configuration
node.default["tomcat"]["files_cookbook"]      = "alfresco"
node.default["tomcat"]["deploy_manager_apps"] = false
node.default["tomcat"]["jvm_memory"]          = "-Xmx1500M -XX:MaxPermSize=256M"
node.default["tomcat"]["java_options"]        = "#{node['tomcat']['jvm_memory']} -Djava.rmi.server.hostname=#{node['alfresco']['default_hostname']} -Dsolr.solr.home=#{node['alfresco']['solrproperties']['data.dir.root']} -Dcom.sun.management.jmxremote=true -Dsun.security.ssl.allowUnsafeRenegotiation=true"

# Tomcat default settings
node.default['tomcat']['service_actions'] = [:enable,:start]
node.default["tomcat"]["deploy_manager_apps"] = false
node.default["tomcat"]["use_security_manager"] = false

# TODO - Re-enable after checking attribute defaults and integrate
# node.default["alfresco"]["start_service"] = false
# node.default['alfresco']['restart_services'] = "tomcat"
# node.default['alfresco']['restart_action']   = "start"
# if node["alfresco"]["start_service"] == false
#   node.default['alfresco']['restart_services'] = []
#   node.default['alfresco']['restart_action']   = "nothing"
# end

####################################################
### Logging Attributes
# added below in the artifact-deployer configuration
####################################################

node.default['logging']['log4j.rootLogger']                                = "error, Console, File"
node.default['logging']['log4j.appender.Console']                          = "org.apache.log4j.DailyRollingFileAppender"
node.default['logging']['log4j.appender.Console.layout']                   = "org.apache.log4j.PatternLayout"
node.default['logging']['log4j.appender.Console.layout.ConversionPattern'] = "%d{ISO8601} %x %-5p [%c{3}] [%t] %m%n"
node.default['logging']['log4j.appender.File']                             = "org.apache.log4j.DailyRollingFileAppender"
node.default['logging']['log4j.appender.File.Append']                      = "true"
node.default['logging']['log4j.appender.File.DatePattern']                 = "'.'yyyy-MM-dd"
node.default['logging']['log4j.appender.File.layout']                      = "org.apache.log4j.PatternLayout"
node.default['logging']['log4j.appender.File.layout.ConversionPattern']    = "%d{ABSOLUTE} %-5p [%c] %m%n"

node.default['alfresco']['repo-log4j-path'] = "#{node['alfresco']['shared']}/classes/alfresco/extension/repo-log4j.properties"
node.default['alfresco']['repo-log4j'] = node['logging']
node.default['alfresco']['repo-log4j']['log4j.appender.File.File'] = "#{node['tomcat']['log_dir']}/alfresco.log"
node.default['alfresco']['share-log4j-path'] = "#{node['alfresco']['shared']}/classes/alfresco/web-extension/share-log4j.properties"
node.default['alfresco']['share-log4j'] = node['logging']
node.default['alfresco']['share-log4j']['log4j.appender.File.File'] = "#{node['tomcat']['log_dir']}/share.log"

######################################################
### alfresco-global.properties used across all recipes
######################################################

#JMX
node.default['alfresco']['properties']['monitor.rmi.services.port']  = 50508

#Database
node.default['alfresco']['mysql_version'] = '5.7'
node.default['alfresco']['properties']['db.driver']          = 'org.gjt.mm.mysql.Driver'
node.default['alfresco']['properties']['db.username']        = 'alfresco'
node.default['alfresco']['properties']['db.password']        = 'alfresco'

#Additional DB params
node.default['alfresco']['properties']['db.prefix']          = 'mysql'
node.default['alfresco']['properties']['db.host']            = '127.0.0.1'
node.default['alfresco']['properties']['db.port']            = '3306'
node.default['alfresco']['properties']['db.dbname']          = 'alfresco'
node.default['alfresco']['properties']['db.params']          = 'useUnicode=yes&characterEncoding=UTF-8'

#Derived DB param
node.default['alfresco']['properties']['db.url']             = "jdbc:#{node['alfresco']['properties']['db.prefix']}://#{node['alfresco']['properties']['db.host']}/#{node['alfresco']['properties']['db.dbname']}?#{node['alfresco']['properties']['db.params']}"

#Alfresco URL
node.default['alfresco']['properties']['hostname.public']    = node['alfresco']['default_hostname']

node.default['alfresco']['properties']['alfresco.context']   = '/alfresco'
node.default['alfresco']['properties']['alfresco.host']      = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['alfresco.port']      = node['alfresco']['default_port']
node.default['alfresco']['properties']['alfresco.port.ssl']  = node['alfresco']['default_portssl']
node.default['alfresco']['properties']['alfresco.protocol']  = node['alfresco']['default_protocol']
node.default['alfresco']['properties']['opencmis.server.host'] = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['opencmis.server.protocol'] = node['alfresco']['default_protocol']
node.default['alfresco']['properties']['opencmis.server.value'] = "${opencmis.server.protocol}://${opencmis.server.host}/alfresco/api"

#SSL Keystore - disabled by default
node.default['alfresco']['properties']['dir.keystore']     = "#{node['alfresco']['properties']['dir.root']}/keystore/alfresco/keystore"

##############################################
### Tomcat Configuration for Alfresco keystore
##############################################
node.default["alfresco"]["keystore_file"]        = "#{node['alfresco']['properties']['dir.keystore']}/ssl.keystore"
node.default["alfresco"]["keystore_password"]    = "kT9X6oe68t"
node.default["alfresco"]["keystore_type"]        = "JCEKS"
node.default["alfresco"]["truststore_file"]      = "#{node['alfresco']['properties']['dir.keystore']}/ssl.truststore"
node.default["alfresco"]["truststore_password"]  = "kT9X6oe68t"
node.default["alfresco"]["truststore_type"]      = "JCEKS"

#################################
### Default recipe configurations
#################################

# DB params shared between client and server
node.default['alfresco']['db']['server_root_password']   = 'alfresco'
node.default['alfresco']['db']['root_user']              = "root"

##################
# Shared Artifacts
##################

# solrcore.properties placeholders
# Since they depend on alfresco properties, they cannot be defined in _attributes_solr.rb (can be improved)

node.default['alfresco']['properties']['solr.host']          = node['alfresco']['default_hostname']
node.default['alfresco']['properties']['solr.port']          = node['alfresco']['default_port']
node.default['alfresco']['properties']['solr.port.ssl']      = node['alfresco']['default_portssl']
node.default['alfresco']['properties']['solr.secureComms']   = 'none'

node.default['alfresco']['solrproperties']['alfresco.host']            = node['alfresco']['properties']['alfresco.host']
node.default['alfresco']['solrproperties']['alfresco.port']            = node['alfresco']['properties']['alfresco.port']
node.default['alfresco']['solrproperties']['alfresco.port.ssl']        = node['alfresco']['properties']['alfresco.port.ssl']
node.default['alfresco']['solrproperties']['alfresco.baseUrl']         = node['alfresco']['properties']['alfresco.context']
node.default['alfresco']['solrproperties']['alfresco.secureComms']     = node['alfresco']['properties']['solr.secureComms']

node.default['artifacts']['alfresco-spp']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['alfresco-spp']['artifactId'] = "alfresco-spp"
node.default['artifacts']['alfresco-spp']['version'] = node['alfresco']['version']
node.default['artifacts']['alfresco-spp']['type'] = "amp"
node.default['artifacts']['alfresco-spp']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['alfresco-spp']['owner'] = node['tomcat']['user']
node.default['artifacts']['alfresco-spp']['unzip'] = false

node.default['artifacts']['rm']['groupId']       = 'org.alfresco'
node.default['artifacts']['rm']['artifactId']    = 'alfresco-rm'
node.default['artifacts']['rm']['version']       = '2.3'
node.default['artifacts']['rm']['destination']   = node['alfresco']['amps_folder']
node.default['artifacts']['rm']['owner']         = node['tomcat']['user']
node.default['artifacts']['rm']['type']          = "amp"

node.default['artifacts']['rm-share']['groupId']       = 'org.alfresco'
node.default['artifacts']['rm-share']['artifactId']    = 'alfresco-rm-share'
node.default['artifacts']['rm-share']['version']       = '2.3'
node.default['artifacts']['rm-share']['destination']   = node['alfresco']['amps_share_folder']
node.default['artifacts']['rm-share']['owner']         = node['tomcat']['user']
node.default['artifacts']['rm-share']['type']          = "amp"

node.default['artifacts']['googledocs-repo']['groupId']       = 'org.alfresco.integrations'
node.default['artifacts']['googledocs-repo']['artifactId']    = 'alfresco-googledocs-repo'
node.default['artifacts']['googledocs-repo']['version']       = '3.0.2'
node.default['artifacts']['googledocs-repo']['destination']   = node['alfresco']['amps_folder']
node.default['artifacts']['googledocs-repo']['owner']         = node['tomcat']['user']
node.default['artifacts']['googledocs-repo']['type']          = "amp"

node.default['artifacts']['googledocs-share']['groupId']       = 'org.alfresco.integrations'
node.default['artifacts']['googledocs-share']['artifactId']    = 'alfresco-googledocs-share'
node.default['artifacts']['googledocs-share']['version']       = '3.0.2'
node.default['artifacts']['googledocs-share']['destination']   = node['alfresco']['amps_share_folder']
node.default['artifacts']['googledocs-share']['owner']         = node['tomcat']['user']
node.default['artifacts']['googledocs-share']['type']          = "amp"

node.default['artifacts']['alfresco-mmt']['enabled']    = true
node.default['artifacts']['alfresco-mmt']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['alfresco-mmt']['artifactId'] = "alfresco-mmt"
node.default['artifacts']['alfresco-mmt']['version'] = node['alfresco']['version']
node.default['artifacts']['alfresco-mmt']['type'] = "jar"
node.default['artifacts']['alfresco-mmt']['destination'] = node['alfresco']['bin']
node.default['artifacts']['alfresco-mmt']['owner'] = node['tomcat']['user']
node.default['artifacts']['alfresco-mmt']['unzip'] = false

# Filtering properties with placeholders defined in the mentioned files (only if classes zip is part of the artifact list, see recipes)
node.default['artifacts']['sharedclasses']['enabled']   = true
node.default['artifacts']['sharedclasses']['unzip'] = false
node.default['artifacts']['sharedclasses']['filtering_mode'] = "append"
node.default['artifacts']['sharedclasses']['destination'] = node['alfresco']['shared']
node.default['artifacts']['sharedclasses']['destinationName'] = "classes"
node.default['artifacts']['sharedclasses']['owner'] = node['tomcat']['user']

node.default['artifacts']['catalina-jmx']['enabled'] = true
node.default['artifacts']['catalina-jmx']['groupId'] = "org.apache.tomcat"
node.default['artifacts']['catalina-jmx']['artifactId'] = "tomcat-catalina-jmx-remote"
node.default['artifacts']['catalina-jmx']['version'] = "7.0.54"
node.default['artifacts']['catalina-jmx']['type'] = 'jar'
node.default['artifacts']['catalina-jmx']['destination'] = "#{node['tomcat']['base']}/lib"
node.default['artifacts']['catalina-jmx']['owner'] = node['tomcat']['user']
