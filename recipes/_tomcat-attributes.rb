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
