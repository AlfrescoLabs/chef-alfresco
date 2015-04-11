# https://github.com/abrt/abrt/wiki/ABRT-Project
# http://tomcat.apache.org/download-native.cgi
# http://tomcat.apache.org/tomcat-7.0-doc/apr.html
default['tomcat']['additional_tomcat_packages'] = %w{tomcat-native apr abrt}

default['tomcat']['run_base_instance'] = true

# See templates/default/tomcat/jmxremote.*
default["tomcat"]["jmxremote_systemsmonitor_password"] = "changeme"
default["tomcat"]["jmxremote_systemscontrol_password"] = "changeme"

# See templates/default/tomcat/controller-info.xml
default["tomcat"]["application_name"] = "AlfrescoCloud.local"
default["tomcat"]["tier_name"] = "allinone-tier"
default["tomcat"]["node_name"] = "allinone-node"

default['alfresco']['repo_tomcat_instance']['port'] = 8070
default['alfresco']['repo_tomcat_instance']['shutdown_port'] = 8005
default['alfresco']['repo_tomcat_instance']['ssl_port'] = 8433
alfresco_memory = "#{(node.memory.total.to_i * 0.5 ).floor / 1024}m"
default['alfresco']['repo_tomcat_instance']['java_options'] = "-Xmx#{alfresco_memory} -XX:MaxPermSize=256m"

default['alfresco']['share_tomcat_instance']['port'] = 8080
default['alfresco']['share_tomcat_instance']['shutdown_port'] = 8015
default['alfresco']['share_tomcat_instance']['ssl_port'] = 8443
share_memory = "#{(node.memory.total.to_i * 0.25 ).floor / 1024}m"
default['alfresco']['share_tomcat_instance']['java_options'] = "-Xmx#{share_memory} -XX:MaxPermSize=256m"

default['alfresco']['solr_tomcat_instance']['port'] = 8090
default['alfresco']['solr_tomcat_instance']['shutdown_port'] = 8025
default['alfresco']['solr_tomcat_instance']['ssl_port'] = 8453
solr_memory = "#{(node.memory.total.to_i * 0.25 ).floor / 1024}m"
default['alfresco']['solr_tomcat_instance']['java_options'] = "-Xmx#{solr_memory} -XX:MaxPermSize=200m"

default['tomcat']['global_templates'] = [{
  "dest" => "/usr/share/tomcat-alfresco/conf",
  "filename" => "jmxremote.access",
  "owner" => "tomcat"
},{
  "dest" => "/usr/share/tomcat-alfresco/conf",
  "filename" => "jmxremote.password",
  "owner" => "tomcat"
},{
  "dest" => "/usr/share/tomcat-alfresco/lib/org/apache/catalina/util",
  "filename" => "ServerInfo.properties",
  "owner" => "tomcat"
},{
  "dest" => "/etc/security/limits.d",
  "filename" => "tomcat_limits.conf",
  "owner" => "tomcat"
}]

default['tomcat']['instance_templates'] = [{
  "dest" => "/etc/cron.d",
  "filename" => "jstack.cron",
  "owner" => "root"
},{
  "dest" => "/etc/cron.d",
  "filename" => "lsof_tomcat.cron",
  "owner" => "root"
},{
  "dest" => "/etc/cron.d",
  "filename" => "cleaner.cron",
  "owner" => "root"
},{
  "dest" => "/etc/logrotate.d",
  "filename" => "tomcat.logrotate",
  "owner" => "root"
}]
