# Tomcat default[s of single instance configuration
default["tomcat"]["files_cookbook"] = "alfresco"
default["tomcat"]["deploy_manager_apps"] = false
default["tomcat"]["jvm_memory"] = "-Xmx1500M -XX:MaxPermSize=256M"

# Tomcat default[ settings
default['tomcat']['service_actions'] = [:disable,:stop]
default['tomcat']['restart_action'] = :nothing
default["tomcat"]["deploy_manager_apps"] = false
default["tomcat"]["use_security_manager"] = false

# https://github.com/abrt/abrt/wiki/ABRT-Project
# http://tomcat.apache.org/download-native.cgi
# http://tomcat.apache.org/tomcat-7.0-doc/apr.html
default['tomcat']['additional_tomcat_packages'] = %w{tomcat-native apr abrt}

default['tomcat']['jmxremote.access.file'] = '/etc/tomcat/jmxremote.access'
default['tomcat']['jmxremote.password.file'] = '/etc/tomcat/jmxremote.password'

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

# See templates/default[/tomcat/jmxremote.*
default["tomcat"]["jmxremote_systemsmonitor_password"] = "changeme"
default["tomcat"]["jmxremote_systemscontrol_password"] = "changeme"

# See templates/default[/tomcat/controller-info.xml
default["tomcat"]["application_name"] = "AlfrescoCloud.local"
default["tomcat"]["tier_name"] = "allinone-tier"
default["tomcat"]["node_name"] = "allinone-node"

default['tomcat']['instance_templates'] = [{
  "dest" => "/etc/cron.d",
  "filename" => "cleaner.cron",
  "owner" => "root"
}]

# Tomcat multi-homed settings
default['alfresco']['repo_tomcat_instance']['port'] = 8070
default['alfresco']['repo_tomcat_instance']['shutdown_port'] = 8005
default['alfresco']['repo_tomcat_instance']['jmx_port'] = 40000

alfresco_memory = "#{(node['memory']['total'].to_i * 0.5 ).floor / 1024}m"
default['alfresco']['repo_tomcat_instance']['java_options'] = "-Xmx#{alfresco_memory} -XX:MaxPermSize=512m -XX:+UseCompressedOops -XX:+UseParallelOldGC -XX:+DisableExplicitGC -XX:CodeCacheMinimumFreeSpace=8m -XX:ReservedCodeCacheSize=128m -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -Djava.library.path=/usr/lib64 -Dlogfilename=/var/log/tomcat-alfresco/alfresco.log -Dlog4j.configuration=alfresco/log4j.properties -Dsun.net.inetaddr.ttl=0 -Dsun.net.inetaddr.negative.ttl=0 -Dcom.sun.management.jmxremote=true -Dsun.security.ssl.allowUnsafeRenegotiation=true -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.access.file=/etc/tomcat/jmxremote.access -Dcom.sun.management.jmxremote.password.file=/etc/tomcat/jmxremote.password -Djava.awt.headless=true"
default['alfresco']['share_tomcat_instance']['port'] = 8081
default['alfresco']['share_tomcat_instance']['shutdown_port'] = 8015
default['alfresco']['share_tomcat_instance']['jmx_port'] = 40010

# Single instance has the same configs as alfresco repo
default['tomcat']['java_options'] = node['alfresco']['repo_tomcat_instance']['java_options']

share_memory = "#{(node['memory']['total'].to_i * 0.3 ).floor / 1024}m"
default['alfresco']['share_tomcat_instance']['java_options'] = "-Xmx#{share_memory} -XX:MaxPermSize=128m -XX:+UseCompressedOops -XX:+UseParallelOldGC -XX:+DisableExplicitGC -XX:CodeCacheMinimumFreeSpace=8m -XX:ReservedCodeCacheSize=64m -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -Dlogfilename=/var/log/tomcat-share/share.log -Dlog4j.configuration=alfresco/log4j.properties  -Dsun.net.inetaddr.ttl=0 -Dsun.net.inetaddr.negative.ttl=0 -Dcom.sun.management.jmxremote=true -Dsun.security.ssl.allowUnsafeRenegotiation=true -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.access.file=/etc/tomcat/jmxremote.access -Dcom.sun.management.jmxremote.password.file=/etc/tomcat/jmxremote.password -Djava.awt.headless=true"

default['alfresco']['solr_tomcat_instance']['port'] = 8090
default['alfresco']['solr_tomcat_instance']['shutdown_port'] = 8025
default['alfresco']['solr_tomcat_instance']['jmx_port'] = 40020

solr_memory = "#{(node['memory']['total'].to_i * 0.2 ).floor / 1024}m"
default['alfresco']['solr_tomcat_instance']['java_options'] = "-Xmx#{solr_memory} -XX:MaxPermSize=128m -XX:+UseCompressedOops -XX:+UseParallelOldGC -XX:+DisableExplicitGC -XX:CodeCacheMinimumFreeSpace=8m -XX:ReservedCodeCacheSize=32m -Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true -Dsun.net.inetaddr.ttl=0 -Dsun.net.inetaddr.negative.ttl=0 -Dcom.sun.management.jmxremote=true -Dsun.security.ssl.allowUnsafeRenegotiation=true -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.access.file=/etc/tomcat/jmxremote.access -Dcom.sun.management.jmxremote.password.file=/etc/tomcat/jmxremote.password -Djava.awt.headless=true"

# Tomcat SSL configuration - not needed for now,
# since SSL is offloaded to nginx/haproxy
#
# default['alfresco']['repo_tomcat_instance']['ajp_port'] = 8079
# default['alfresco']['repo_tomcat_instance']['ssl_port'] = 8433
# default['alfresco']['share_tomcat_instance']['ajp_port'] = 8089
# default['alfresco']['share_tomcat_instance']['ssl_port'] = 8443
# default['alfresco']['solr_tomcat_instance']['ajp_port'] = 8099
# default['alfresco']['solr_tomcat_instance']['ssl_port'] = 8453
