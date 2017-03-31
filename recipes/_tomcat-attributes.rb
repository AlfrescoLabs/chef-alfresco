node.default['tomcat']['base_version'] = 7
# node.default['tomcat']['packages'] = ["tomcat#{node['tomcat']['base_version']}"]
# node.default['tomcat']['deploy_manager_packages'] = ["tomcat#{node['tomcat']['base_version']}-admin"]

# case node['platform_family']
#
# when 'rhel', 'fedora'
node.default['tomcat']['single_instance'] = 'alfresco'
node.default['tomcat']['user'] = 'tomcat'
node.default['tomcat']['group'] = 'tomcat'
node.default['tomcat']['home'] = '/usr/share/tomcat-single'
node.default['tomcat']['config_dir'] = "#{node['tomcat']['home']}/conf"
node.default['tomcat']['webapp_dir'] = "#{node['tomcat']['home']}/webapps"
# when 'debian'
#   node.default['tomcat']['user'] = "tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['group'] = "tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['home'] = "/usr/share/tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['base'] = "/var/lib/tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['config_dir'] = "/usr/share/tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node['tomcat']['base_version']}/webapps"
# when 'smartos'
#   node.default['tomcat']['user'] = 'tomcat'
#   node.default['tomcat']['group'] = 'tomcat'
#   node.default['tomcat']['home'] = '/opt/local/share/tomcat'
#   node.default['tomcat']['base'] = '/opt/local/share/tomcat'
#   node.default['tomcat']['config_dir'] = '/opt/local/share/tomcat/conf'
#   node.default['tomcat']['webapp_dir'] = '/opt/local/share/tomcat/webapps'
#   node.default['tomcat']['keytool'] = '/opt/local/bin/keytool'
#   node.default['tomcat']['packages'] = ['apache-tomcat']
#   node.default['tomcat']['deploy_manager_packages'] = []
# else
#   node.default['tomcat']['user'] = "tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['group'] = "tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['home'] = "/usr/share/tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['base'] = "/var/lib/tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['config_dir'] = "/usr/share/tomcat#{node['tomcat']['base_version']}"
#   node.default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node['tomcat']['base_version']}/webapps"
#   node.default['tomcat']['lib_dir'] = "#{node['tomcat']['home']}/lib"
#   node.default['tomcat']['endorsed_dir'] = "#{node['tomcat']['lib_dir']}/endorsed"
# end

# Using catalina-jmx
node.default['tomcat']['jmxremote.access.file'] = "#{node['alfresco']['home']}/conf/jmxremote.access"
node.default['tomcat']['jmxremote.password.file'] = "#{node['alfresco']['home']}/conf/jmxremote.password"

node.default['artifacts']['catalina-jmx']['groupId'] = 'org.apache.tomcat'
node.default['artifacts']['catalina-jmx']['artifactId'] = 'tomcat-catalina-jmx-remote'
node.default['artifacts']['catalina-jmx']['version'] = '7.0.54'
node.default['artifacts']['catalina-jmx']['type'] = 'jar'
node.default['artifacts']['catalina-jmx']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['catalina-jmx']['owner'] = node['alfresco']['user']

node.default['artifacts']['memcached-session-manager']['groupId'] = 'de.javakaffee.msm'
node.default['artifacts']['memcached-session-manager']['artifactId'] = 'memcached-session-manager'
node.default['artifacts']['memcached-session-manager']['version'] = '1.9.3'
node.default['artifacts']['memcached-session-manager']['type'] = 'jar'
node.default['artifacts']['memcached-session-manager']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['memcached-session-manager']['owner'] = node['alfresco']['user']

node.default['artifacts']['memcached-session-manager-tc7']['groupId'] = 'de.javakaffee.msm'
node.default['artifacts']['memcached-session-manager-tc7']['artifactId'] = 'memcached-session-manager-tc7'
node.default['artifacts']['memcached-session-manager-tc7']['version'] = '1.9.3'
node.default['artifacts']['memcached-session-manager-tc7']['type'] = 'jar'
node.default['artifacts']['memcached-session-manager-tc7']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['memcached-session-manager-tc7']['owner'] = node['alfresco']['user']

node.default['artifacts']['spymemcached']['groupId'] = 'net.spy'
node.default['artifacts']['spymemcached']['artifactId'] = 'spymemcached'
node.default['artifacts']['spymemcached']['version'] = '2.11.1'
node.default['artifacts']['spymemcached']['type'] = 'jar'
node.default['artifacts']['spymemcached']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['spymemcached']['owner'] = node['alfresco']['user']

node.default['artifacts']['msm-kryo-serializer']['groupId'] = 'de.javakaffee.msm'
node.default['artifacts']['msm-kryo-serializer']['artifactId'] = 'msm-kryo-serializer'
node.default['artifacts']['msm-kryo-serializer']['version'] = '1.9.3'
node.default['artifacts']['msm-kryo-serializer']['type'] = 'jar'
node.default['artifacts']['msm-kryo-serializer']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['msm-kryo-serializer']['owner'] = node['alfresco']['user']

node.default['artifacts']['kryo-serializers']['groupId'] = 'de.javakaffee'
node.default['artifacts']['kryo-serializers']['artifactId'] = 'kryo-serializers'
node.default['artifacts']['kryo-serializers']['version'] = '0.34'
node.default['artifacts']['kryo-serializers']['type'] = 'jar'
node.default['artifacts']['kryo-serializers']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['kryo-serializers']['owner'] = node['alfresco']['user']

node.default['artifacts']['kryo']['groupId'] = 'com.esotericsoftware'
node.default['artifacts']['kryo']['artifactId'] = 'kryo'
node.default['artifacts']['kryo']['version'] = '3.0.3'
node.default['artifacts']['kryo']['type'] = 'jar'
node.default['artifacts']['kryo']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['kryo']['owner'] = node['alfresco']['user']

node.default['artifacts']['minlog']['groupId'] = 'com.esotericsoftware'
node.default['artifacts']['minlog']['artifactId'] = 'minlog'
node.default['artifacts']['minlog']['version'] = '1.3.0'
node.default['artifacts']['minlog']['type'] = 'jar'
node.default['artifacts']['minlog']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['minlog']['owner'] = node['alfresco']['user']

node.default['artifacts']['reflectasm']['groupId'] = 'com.esotericsoftware'
node.default['artifacts']['reflectasm']['artifactId'] = 'reflectasm'
node.default['artifacts']['reflectasm']['version'] = '1.11.3'
node.default['artifacts']['reflectasm']['type'] = 'jar'
node.default['artifacts']['reflectasm']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['reflectasm']['owner'] = node['alfresco']['user']

node.default['artifacts']['asm']['groupId'] = 'org.ow2.asm'
node.default['artifacts']['asm']['artifactId'] = 'asm'
node.default['artifacts']['asm']['version'] = '5.1'
node.default['artifacts']['asm']['type'] = 'jar'
node.default['artifacts']['asm']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['asm']['owner'] = node['alfresco']['user']

node.default['artifacts']['objenesis']['groupId'] = 'org.objenesis'
node.default['artifacts']['objenesis']['artifactId'] = 'objenesis'
node.default['artifacts']['objenesis']['version'] = '2.4'
node.default['artifacts']['objenesis']['type'] = 'jar'
node.default['artifacts']['objenesis']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['objenesis']['owner'] = node['alfresco']['user']

# attributes for share.xml.erb
node.default['tomcat']['memcached']['sticky'] = true
node.default['tomcat']['memcached']['sessionBackupAsync'] = true
node.default['tomcat']['memcached']['copyCollectionsForSerialization'] = false

node.default['tomcat']['jvm_route'] = node['alfresco']['public_hostname']

node.default['tomcat']['global_templates'] = [{
  'dest' => "#{node['alfresco']['home']}/conf",
  'filename' => 'jmxremote.access',
  'owner' => 'tomcat',
}, {
  'dest' => "#{node['alfresco']['home']}/conf",
  'filename' => 'jmxremote.password',
  'owner' => 'tomcat',
}, {
  'dest' => "#{node['alfresco']['home']}#{'/alfresco' unless node['tomcat']['run_single_instance']}/lib/org/apache/catalina/util",
  'filename' => 'ServerInfo.properties',
  'owner' => 'tomcat',
}, {
  'dest' => '/etc/security/limits.d',
  'filename' => 'tomcat_limits.conf',
  'owner' => 'tomcat',
}]

# Setting JAVA_OPTS
node.default['tomcat']['java_options_hash']['jmx'] = "-Dcom.sun.management.jmxremote=true  -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.access.file=#{node['alfresco']['home']}/conf/jmxremote.access -Dcom.sun.management.jmxremote.password.file=#{node['alfresco']['home']}/conf/jmxremote.password"

node.default['alfresco']['repo_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']
node.default['alfresco']['share_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']
node.default['alfresco']['solr_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']

alfresco_components = node['alfresco']['components']
if node['tomcat']['run_single_instance']
  logs_path = "#{node['alfresco']['home']}/logs"
  node.default['tomcat']['java_options']['log_paths'] = "-Djava.util.logging.config.file=#{node['alfresco']['home']}/conf/logging.properties -Dlog4j.configuration=alfresco/log4j.properties -Xloggc:#{logs_path}/gc.log -Dlogfilename=#{logs_path}/alfresco.log -XX:ErrorFile=#{logs_path}/jvm_crash%p.log -XX:HeapDumpPath=#{logs_path}/"
  if alfresco_components.include? 'solr'
    node.default['tomcat']['java_options']['rmi_and_solr'] = "-Dalfresco.home=#{node['alfresco']['home']} -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']} -Dsolr.solr.home=#{node['alfresco']['solr']['home']} -Dsolr.solr.model.dir=#{node['alfresco']['solr']['alfresco_models']} -Dsolr.solr.content.dir=#{node['alfresco']['solr']['contentstore.path']}"
  end
else
  if alfresco_components.include? 'repo'
    name = 'repo'
    instance_home = "#{node['alfresco']['home']}/alfresco"
    logs_path = node['alfresco']["#{name}_tomcat_instance"]['logs_path'] || "#{node['alfresco']['home']}/alfresco/logs"
    node.default['alfresco']['repo_tomcat_instance']['java_options']['rmi_and_alfhome'] = "-Dalfresco.home=#{instance_home} -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    node.default['alfresco']['repo_tomcat_instance']['java_options']['log_paths'] = "-Djava.util.logging.config.file=#{instance_home}/conf/logging.properties -Dlog4j.configuration=alfresco/log4j.properties -Xloggc:#{logs_path}/gc.log -Dlogfilename=#{logs_path}/alfresco.log -XX:ErrorFile=#{logs_path}/jvm_crash%p.log -XX:HeapDumpPath=#{logs_path}/"
    node.default['tomcat']['instances']['alfresco'] = node['alfresco']['repo_tomcat_instance']
  end
  if alfresco_components.include? 'share'
    name = 'share'
    instance_home = "#{node['alfresco']['home']}/share"
    logs_path = node['alfresco']["#{name}_tomcat_instance"]['logs_path'] || "#{node['alfresco']['home']}/#{name}/logs"
    node.default['alfresco']['share_tomcat_instance']['java_options']['rmi'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    node.default['alfresco']['share_tomcat_instance']['java_options']['log_paths'] = "-Djava.util.logging.config.file=#{instance_home}/conf/logging.properties -Dlog4j.configuration=alfresco/log4j.properties -Xloggc:#{logs_path}/gc.log -Dlogfilename=#{logs_path}/share.log -XX:ErrorFile=#{logs_path}/jvm_crash%p.log -XX:HeapDumpPath=#{logs_path}/"
    node.default['tomcat']['instances']['share'] = node['alfresco']['share_tomcat_instance']
  end
  if alfresco_components.include? 'solr'
    name = 'solr'
    instance_home = "#{node['alfresco']['home']}/solr"
    logs_path = node['alfresco']["#{name}_tomcat_instance"]['logs_path'] || "#{node['alfresco']['home']}/#{name}/logs"
    node.default['alfresco']['solr_tomcat_instance']['java_options']['rmi_and_solr'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']} -Dsolr.solr.model.dir=#{node['alfresco']['solr']['alfresco_models']} -Dsolr.solr.home=#{node['alfresco']['solr']['home']}  -Dsolr.solr.content.dir=#{node['alfresco']['solr']['contentstore.path']}"
    node.default['alfresco']['solr_tomcat_instance']['java_options']['log_paths'] = "-Djava.util.logging.config.file=#{instance_home}/conf/logging.properties -Dlog4j.configuration=alfresco/log4j.properties -Xloggc:#{instance_home}/gc.log -Dlogfilename=#{logs_path}/solr.log -XX:ErrorFile=#{logs_path}/jvm_crash%p.log -XX:HeapDumpPath=#{logs_path}/"
    node.default['tomcat']['instances']['solr'] = node['alfresco']['solr_tomcat_instance']
  end
end
