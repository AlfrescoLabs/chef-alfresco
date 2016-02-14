# Tomcat binary attributes

default['tomcat']['tar']['url'] = 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.59/bin/apache-tomcat-7.0.59.tar.gz'
# Note: Checksum is SHA-256, not MD5 or SHA1. Generate using `shasum -a 256 /path/to/tomcat.tar.gz`
default['tomcat']['tar']['checksum'] = 'e0fe43d1fa17013bf7b3b2d3f71105d606a0582c153eb16fb210e7d5164941b0'
default['tomcat']['tar']['version'] = '7.0.59'

# Tomcat attributes for base instance
default['tomcat']['port'] = 8080
default['tomcat']['proxy_port'] = nil
default['tomcat']['ssl_port'] = 8443
default['tomcat']['ssl_proxy_port'] = nil
default['tomcat']['ajp_port'] = 8009
default['tomcat']['jmx_port'] = nil
default['tomcat']['shutdown_port'] = 8005
default['tomcat']['catalina_options'] = ''
default['tomcat']['java_options'] = '-Xmx128M -Djava.awt.headless=true'
default['tomcat']['use_security_manager'] = false
default['tomcat']['authbind'] = 'no'
default['tomcat']['deploy_manager_apps'] = true
default['tomcat']['max_threads'] = nil
default['tomcat']['ssl_max_threads'] = 150
default['tomcat']['ssl_cert_file'] = nil
default['tomcat']['ssl_key_file'] = nil
default['tomcat']['ssl_chain_files'] = []
default['tomcat']['keystore_file'] = 'keystore.jks'
default['tomcat']['keystore_type'] = 'jks'
default['tomcat']['truststore_file'] = nil
default['tomcat']['truststore_type'] = 'jks'
default['tomcat']['certificate_dn'] = 'cn=localhost'
default['tomcat']['loglevel'] = 'INFO'
default['tomcat']['tomcat_auth'] = 'true'
default['tomcat']['instances'] = {}
default['tomcat']['run_base_instance'] = true
default['tomcat']['keytool'] = 'keytool'

default['tomcat']['sysconfig_template_cookbook'] = 'alfresco'
default['tomcat']['sysconfig_template_source'] = 'tomcat/sysconfig.erb'

default["tomcat"]["files_cookbook"] = "alfresco"
default["tomcat"]["deploy_manager_apps"] = false
default["tomcat"]["jvm_memory"] = "-Xmx1500M"

default["tomcat"]["maxHttpHeaderSize"] = "1048576"

default['tomcat']['cleaner.minutes.interval'] = 30
default['tomcat']['cache_root_folder'] = "/var/cache"

# Tomcat default settings
default['tomcat']['service_actions'] = [:disable,:stop]
default['tomcat']['restart_action'] = :nothing
default["tomcat"]["deploy_manager_apps"] = false
default["tomcat"]["use_security_manager"] = false

# https://github.com/abrt/abrt/wiki/ABRT-Project
# http://tomcat.apache.org/download-native.cgi
# http://tomcat.apache.org/tomcat-7.0-doc/apr.html
# default['tomcat']['additional_tomcat_packages'] = %w{tomcat-native apr abrt}
default['tomcat']['additional_tomcat_packages'] = %w{tomcat-native apr}

default['tomcat']['jmxremote.access.file'] = '/usr/share/tomcat/conf/jmxremote.access'
default['tomcat']['jmxremote.password.file'] = '/usr/share/tomcat/conf/jmxremote.password'

# Use multi-homed tomcat installation
default['tomcat']['run_base_instance'] = false

# Context.xml settings
default['tomcat']['swallow_output'] = true
default['tomcat']['use_http_only'] = true

# Fixes keytool file missing, though shouldnt be needed due to java alternatives
default['tomcat']['keytool'] = '/usr/lib/jvm/java/bin/keytool'

default['tomcat']['server_template_cookbook'] = 'alfresco'
default['tomcat']['server_template_source'] = 'tomcat/server.xml.erb'
default['tomcat']['context_template_cookbook'] = 'alfresco'
default['tomcat']['context_template_source'] = 'tomcat/context.xml.erb'

# See templates/default[/tomcat/controller-info.xml
default["tomcat"]["application_name"] = "AlfrescoCloud.local"
default["tomcat"]["tier_name"] = "allinone-tier"
default["tomcat"]["node_name"] = "allinone-node"

default['tomcat']['instance_templates'] = [{
  "dest" => "/etc/cron.d",
  "filename" => "cleaner.cron",
  "owner" => "root"
}]

# TODO - are the following items needed? Coming from cloud prod
# -Dnet.spy.log.LoggerImpl=net.spy.memcached.compat.log.SunLogger
# -Dhazelcast.logging.type=log4j
# -Dhazelcast.jmx=true
# -Dhazelcast.jmx.detailed=true

# TODO Add a flag for enabling heap dump
# Added for now as default
# -XX:ErrorFile=/var/log/tomcat7/alfresco/jvm_crash%p.log"
# -XX:HeapDumpPath=/var/log/tomcat7/alfresco/"
# -XX:+PrintGCDetails"
# -XX:+PrintGCTimeStamps"
# -verbose:gc"

default['tomcat']['java_options_hash']['generic_memory'] = "-XX:+UseCompressedOops"
default['tomcat']['java_options_hash']['gc'] = "-XX:+DisableExplicitGC  -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -verbose:gc"
default['tomcat']['java_options_hash']['network'] = "-Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -Dsun.net.inetaddr.ttl=0 -Dsun.net.inetaddr.negative.ttl=0 -Dsun.security.ssl.allowUnsafeRenegotiation=true"
# -Dhazelcast.jmx=true causes alfresco.war to take 10 minutes to start
default['tomcat']['java_options_hash']['jmx'] = "-Dcom.sun.management.jmxremote=true  -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.access.file=/usr/share/tomcat/conf/jmxremote.access -Dcom.sun.management.jmxremote.password.file=/usr/share/tomcat/conf/jmxremote.password"
default['tomcat']['java_options_hash']['logging'] = " -Dhazelcast.logging.type=log4j"
default['tomcat']['java_options_hash']['others'] = "-Djava.library.path=/usr/lib64 -Djava.awt.headless=true"

# Tomcat multi-homed settings
default['alfresco']['repo_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']
default['alfresco']['share_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']
default['alfresco']['solr_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']
default['alfresco']['activiti_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']

default['alfresco']['repo_tomcat_instance']['port'] = 8070
default['alfresco']['repo_tomcat_instance']['shutdown_port'] = 8005
default['alfresco']['repo_tomcat_instance']['jmx_port'] = 40000
default['alfresco']['repo_tomcat_instance']['xmx_ratio'] = 0.42
alfresco_memory = "#{(node['memory']['total'].to_i * node['alfresco']['repo_tomcat_instance']['xmx_ratio'] ).floor / 1024}m"
default['alfresco']['repo_tomcat_instance']['java_options']['xmx_memory'] = "-Xmx#{alfresco_memory}"

default['alfresco']['share_tomcat_instance']['port'] = 8081
default['alfresco']['share_tomcat_instance']['shutdown_port'] = 8015
default['alfresco']['share_tomcat_instance']['jmx_port'] = 40010
default['alfresco']['share_tomcat_instance']['xmx_ratio'] = 0.28
share_memory = "#{(node['memory']['total'].to_i * node['alfresco']['share_tomcat_instance']['xmx_ratio'] ).floor / 1024}m"
default['alfresco']['share_tomcat_instance']['java_options']['xmx_memory'] = "-Xmx#{share_memory}"

default['alfresco']['solr_tomcat_instance']['port'] = 8090
default['alfresco']['solr_tomcat_instance']['shutdown_port'] = 8025
default['alfresco']['solr_tomcat_instance']['jmx_port'] = 40020
default['alfresco']['solr_tomcat_instance']['xmx_ratio'] = 0.3
solr_memory = "#{(node['memory']['total'].to_i * node['alfresco']['solr_tomcat_instance']['xmx_ratio'] ).floor / 1024}m"
default['alfresco']['solr_tomcat_instance']['java_options']['xmx_memory'] = "-Xmx#{solr_memory}"

default['alfresco']['activiti_tomcat_instance']['port'] = 8060
default['alfresco']['activiti_tomcat_instance']['shutdown_port'] = 8035
default['alfresco']['activiti_tomcat_instance']['jmx_port'] = 40030
default['alfresco']['activiti_tomcat_instance']['xmx_ratio'] = 0.3
activiti_memory = "#{(node['memory']['total'].to_i * node['alfresco']['activiti_tomcat_instance']['xmx_ratio'] ).floor / 1024}m"
default['alfresco']['activiti_tomcat_instance']['java_options']['xmx_memory'] = "-Xmx#{activiti_memory}"
