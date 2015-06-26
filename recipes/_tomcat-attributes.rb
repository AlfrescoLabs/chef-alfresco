# Tomcat node.default[s of single instance configuration
node.default["tomcat"]["files_cookbook"] = "alfresco"
node.default["tomcat"]["deploy_manager_apps"] = false
node.default["tomcat"]["jvm_memory"] = "-Xmx1500M -XX:MaxPermSize=256M"

# Tomcat node.default[ settings
node.default['tomcat']['service_actions'] = [:disable,:stop]
node.default['tomcat']['restart_action'] = :nothing
node.default["tomcat"]["deploy_manager_apps"] = false
node.default["tomcat"]["use_security_manager"] = false

# https://github.com/abrt/abrt/wiki/ABRT-Project
# http://tomcat.apache.org/download-native.cgi
# http://tomcat.apache.org/tomcat-7.0-doc/apr.html
node.default['tomcat']['additional_tomcat_packages'] = %w{tomcat-native apr abrt}

node.default['tomcat']['jmxremote.access.file'] = '/etc/tomcat/jmxremote.access'
node.default['tomcat']['jmxremote.password.file'] = '/etc/tomcat/jmxremote.password'

# Use multi-homed tomcat installation
node.default['tomcat']['run_base_instance'] = false

# Context.xml settings
node.default['tomcat']['swallow_output'] = true
node.default['tomcat']['use_http_only'] = true

# Fixes keytool file missing, though shouldnt be needed due to java alternatives
node.default['tomcat']['keytool'] = '/usr/lib/jvm/java/bin/keytool'

node.default['tomcat']['server_template_cookbook'] = 'alfresco'
node.default['tomcat']['server_template_source'] = 'tomcat/server.xml.erb'
node.default['tomcat']['context_template_cookbook'] = 'alfresco'
node.default['tomcat']['context_template_source'] = 'tomcat/context.xml.erb'

# See templates/node.default[/tomcat/jmxremote.*
node.default["tomcat"]["jmxremote_systemsmonitor_password"] = "changeme"
node.default["tomcat"]["jmxremote_systemscontrol_password"] = "changeme"

# See templates/node.default[/tomcat/controller-info.xml
node.default["tomcat"]["application_name"] = "AlfrescoCloud.local"
node.default["tomcat"]["tier_name"] = "allinone-tier"
node.default["tomcat"]["node_name"] = "allinone-node"

node.default['tomcat']['instance_templates'] = [{
  "dest" => "/etc/cron.d",
  "filename" => "cleaner.cron",
  "owner" => "root"
}]

# Tomcat SSL configuration - not needed for now,
# since SSL is offloaded to nginx/haproxy
#
# node.default['alfresco']['repo_tomcat_instance']['ajp_port'] = 8079
# node.default['alfresco']['repo_tomcat_instance']['ssl_port'] = 8433
# node.default['alfresco']['share_tomcat_instance']['ajp_port'] = 8089
# node.default['alfresco']['share_tomcat_instance']['ssl_port'] = 8443
# node.default['alfresco']['solr_tomcat_instance']['ajp_port'] = 8099
# node.default['alfresco']['solr_tomcat_instance']['ssl_port'] = 8453

# Using catalina-jmx
node.default['artifacts']['catalina-jmx']['groupId'] = "org.apache.tomcat"
node.default['artifacts']['catalina-jmx']['artifactId'] = "tomcat-catalina-jmx-remote"
node.default['artifacts']['catalina-jmx']['version'] = "7.0.54"
node.default['artifacts']['catalina-jmx']['type'] = 'jar'
node.default['artifacts']['catalina-jmx']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['catalina-jmx']['owner'] = node['alfresco']['user']

node.default['tomcat']['jvm_route'] = "alfresco-#{node['alfresco']['default_hostname']}"

node.default["tomcat"]["java_options"] = "#{node['tomcat']['jvm_memory']} -Djava.rmi.server.hostname=#{node['alfresco']['default_hostname']} -Dcom.sun.management.jmxremote=true -Dsun.security.ssl.allowUnsafeRenegotiation=true"
node.default['tomcat']['global_templates'] = [{
  "dest" => "#{node['alfresco']['home']}/conf",
  "filename" => "jmxremote.access",
  "owner" => "tomcat"
},{
  "dest" => "#{node['alfresco']['home']}/conf",
  "filename" => "jmxremote.password",
  "owner" => "tomcat"
},{
  "dest" => "#{node['alfresco']['home']}-alfresco/lib/org/apache/catalina/util",
  "filename" => "ServerInfo.properties",
  "owner" => "tomcat"
},{
  "dest" => "/etc/security/limits.d",
  "filename" => "tomcat_limits.conf",
  "owner" => "tomcat"
}]

# Tomcat multi-homed settings
node.default['alfresco']['repo_tomcat_instance']['port'] = 8070
node.default['alfresco']['repo_tomcat_instance']['shutdown_port'] = 8005
node.default['alfresco']['repo_tomcat_instance']['jmx_port'] = 40000

alfresco_memory = "#{(node['memory']['total'].to_i * 0.5 ).floor / 1024}m"
node.default['alfresco']['repo_tomcat_instance']['java_options'] = "-Xmx#{alfresco_memory} -XX:MaxPermSize=512m -XX:+UseCompressedOops -XX:+UseParallelOldGC -XX:+DisableExplicitGC -XX:CodeCacheMinimumFreeSpace=8m -XX:ReservedCodeCacheSize=128m -Dalfresco.home=#{node['alfresco']['home']}-alfresco -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -Djava.library.path=/usr/lib64 -Dlogfilename=/var/log/tomcat-alfresco/alfresco.log -Dlog4j.configuration=alfresco/log4j.properties -Dsun.net.inetaddr.ttl=0 -Dsun.net.inetaddr.negative.ttl=0 -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.access.file=/etc/tomcat/jmxremote.access -Dcom.sun.management.jmxremote.password.file=/etc/tomcat/jmxremote.password -Djava.awt.headless=true"

node.default['alfresco']['share_tomcat_instance']['port'] = 8081
node.default['alfresco']['share_tomcat_instance']['shutdown_port'] = 8015
node.default['alfresco']['share_tomcat_instance']['jmx_port'] = 40010

share_memory = "#{(node['memory']['total'].to_i * 0.3 ).floor / 1024}m"
node.default['alfresco']['share_tomcat_instance']['java_options'] = "-Xmx#{share_memory} -XX:MaxPermSize=128m -XX:+UseCompressedOops -XX:+UseParallelOldGC -XX:+DisableExplicitGC -XX:CodeCacheMinimumFreeSpace=8m -XX:ReservedCodeCacheSize=64m -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -Dlogfilename=/var/log/tomcat-share/share.log -Dlog4j.configuration=alfresco/log4j.properties  -Dsun.net.inetaddr.ttl=0 -Dsun.net.inetaddr.negative.ttl=0 -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.access.file=/etc/tomcat/jmxremote.access -Dcom.sun.management.jmxremote.password.file=/etc/tomcat/jmxremote.password -Djava.awt.headless=true"

node.default['alfresco']['solr_tomcat_instance']['port'] = 8090
node.default['alfresco']['solr_tomcat_instance']['shutdown_port'] = 8025
node.default['alfresco']['solr_tomcat_instance']['jmx_port'] = 40020

solr_memory = "#{(node['memory']['total'].to_i * 0.2 ).floor / 1024}m"
node.default['alfresco']['solr_tomcat_instance']['java_options'] = "-Xmx#{solr_memory} -XX:MaxPermSize=128m -XX:+UseCompressedOops -XX:+UseParallelOldGC -XX:+DisableExplicitGC -XX:CodeCacheMinimumFreeSpace=8m -XX:ReservedCodeCacheSize=32m -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -Dsun.net.inetaddr.ttl=0 -Dsun.net.inetaddr.negative.ttl=0 -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.access.file=/etc/tomcat/jmxremote.access -Dcom.sun.management.jmxremote.password.file=/etc/tomcat/jmxremote.password -Djava.awt.headless=true"
