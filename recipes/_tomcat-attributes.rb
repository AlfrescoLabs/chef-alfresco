# Base instance tomcat attributes

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

node.default['tomcat']['jvm_route'] = "alfresco-#{node['alfresco']['public_hostname']}"

node.default['tomcat']['global_templates'] = [{
  'dest' => "#{node['alfresco']['home']}/conf",
  'filename' => 'jmxremote.access',
  'owner' => 'tomcat'
}, {
  'dest' => "#{node['alfresco']['home']}/conf",
  'filename' => 'jmxremote.password',
  'owner' => 'tomcat'
}, {
  'dest' => "#{node['alfresco']['home']}#{"/alfresco" unless node['tomcat']['run_single_instance']}/lib/org/apache/catalina/util",
  'filename' => 'ServerInfo.properties',
  'owner' => 'tomcat'
}, {
  'dest' => '/etc/security/limits.d',
  'filename' => 'tomcat_limits.conf',
  'owner' => 'tomcat'
}]

# Setting JAVA_OPTS
node.default['tomcat']['java_options_hash']['jmx'] = "-Dcom.sun.management.jmxremote=true  -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.access.file=#{node['alfresco']['home']}/conf/jmxremote.access -Dcom.sun.management.jmxremote.password.file=#{node['alfresco']['home']}/conf/jmxremote.password"

node.default['alfresco']['repo_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']
node.default['alfresco']['share_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']
node.default['alfresco']['solr_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']
node.default['alfresco']['activiti_tomcat_instance']['java_options'] = node['tomcat']['java_options_hash']

alfresco_components = node['alfresco']['components']
if node['tomcat']['run_single_instance']
  logs_path = "#{node['alfresco']['home']}/logs"
  cache_path = "#{node['alfresco']['home']}/temp"
  node.default['tomcat']['java_options']['log_paths'] = "-Djava.util.logging.config.file=#{node['alfresco']['home']}/conf/logging.properties -Dlog4j.configuration=alfresco/log4j.properties -Xloggc:#{logs_path}/gc.log -Dlogfilename=#{logs_path}/alfresco.log -XX:ErrorFile=#{logs_path}/jvm_crash%p.log -XX:HeapDumpPath=#{logs_path}/"
  if alfresco_components.include? 'solr'
    node.default['tomcat']['java_options']['rmi_and_solr'] = "-Dalfresco.home=#{node['alfresco']['home']} -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']} -Dsolr.solr.home=#{node['alfresco']['solr']['home']} -Dsolr.solr.model.dir=#{node['alfresco']['solr']['alfresco_models']} -Dsolr.solr.content.dir=#{node['alfresco']['solr']['contentstore.path']}"
  end
  if alfresco_components.include? 'yourkit'
    node.default['tomcat']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=#{cache_path},telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=repo,tmpdir=#{cache_path},disableall"
  end
else
  if alfresco_components.include? 'repo'
    name = "repo"
    instance_home = "#{node['alfresco']['home']}/alfresco"
    logs_path = node['alfresco']["#{name}_tomcat_instance"]['logs_path'] || "#{node['alfresco']['home']}/alfresco/logs"
    cache_path = node['alfresco']["#{name}_tomcat_instance"]['cache_path'] || "#{node['alfresco']['home']}/alfresco/temp"
    node.default['alfresco']['repo_tomcat_instance']['java_options']['rmi_and_alfhome'] = "-Dalfresco.home=#{instance_home} -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    node.default['alfresco']['repo_tomcat_instance']['java_options']['log_paths'] = "-Djava.util.logging.config.file=#{instance_home}/conf/logging.properties -Dlog4j.configuration=alfresco/log4j.properties -Xloggc:#{logs_path}/gc.log -Dlogfilename=#{logs_path}/alfresco.log -XX:ErrorFile=#{logs_path}/jvm_crash%p.log -XX:HeapDumpPath=#{logs_path}/"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']['repo_tomcat_instance']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=#{cache_path},telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=repo,tmpdir=#{cache_path},disableall"
    end
    node.default['tomcat']['instances']['alfresco'] = node['alfresco']['repo_tomcat_instance']
  end
  if alfresco_components.include? 'share'
    name = "share"
    instance_home = "#{node['alfresco']['home']}/share"
    logs_path = node['alfresco']["#{name}_tomcat_instance"]['logs_path'] || "#{node['alfresco']['home']}/#{name}/logs"
    cache_path = node['alfresco']["#{name}_tomcat_instance"]['cache_path'] || "#{node['alfresco']['home']}/#{name}/temp"
    node.default['alfresco']['share_tomcat_instance']['java_options']['rmi'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    node.default['alfresco']['share_tomcat_instance']['java_options']['log_paths'] = "-Djava.util.logging.config.file=#{instance_home}/conf/logging.properties -Dlog4j.configuration=alfresco/log4j.properties -Xloggc:#{logs_path}/gc.log -Dlogfilename=#{logs_path}/share.log -XX:ErrorFile=#{logs_path}/jvm_crash%p.log -XX:HeapDumpPath=#{logs_path}/"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']['share_tomcat_instance']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=#{cache_path},telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=share,tmpdir=#{cache_path},disableall"
    end
    node.default['tomcat']['instances']['share'] = node['alfresco']['share_tomcat_instance']
  end
  if alfresco_components.include? 'solr'
    name = "solr"
    instance_home = "#{node['alfresco']['home']}/solr"
    logs_path = node['alfresco']["#{name}_tomcat_instance"]['logs_path'] || "#{node['alfresco']['home']}/#{name}/logs"
    cache_path = node['alfresco']["#{name}_tomcat_instance"]['cache_path'] || "#{node['alfresco']['home']}/#{name}/temp"
    node.default['alfresco']['solr_tomcat_instance']['java_options']['rmi_and_solr'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']} -Dsolr.solr.model.dir=#{node['alfresco']['solr']['alfresco_models']} -Dsolr.solr.home=#{node['alfresco']['solr']['home']}  -Dsolr.solr.content.dir=#{node['alfresco']['solr']['contentstore.path']}"
    node.default['alfresco']['solr_tomcat_instance']['java_options']['log_paths'] = "-Djava.util.logging.config.file=#{instance_home}/conf/logging.properties -Dlog4j.configuration=alfresco/log4j.properties -Xloggc:#{instance_home}/gc.log -Dlogfilename=#{logs_path}/solr.log -XX:ErrorFile=#{logs_path}/jvm_crash%p.log -XX:HeapDumpPath=#{logs_path}/"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']['solr_tomcat_instance']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=#{cache_path},telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=solr,tmpdir=#{cache_path},disableall"
    end
    node.default['tomcat']['instances']['solr'] = node['alfresco']['solr_tomcat_instance']
  end
  if alfresco_components.include? 'activiti-app'
    name = "activiti"
    instance_home = "#{node['alfresco']['home']}/activiti"
    logs_path = node['alfresco']["#{name}_tomcat_instance"]['logs_path'] || "#{node['alfresco']['home']}/#{name}/logs"
    cache_path = node['alfresco']["#{name}_tomcat_instance"]['cache_path'] || "#{node['alfresco']['home']}/#{name}/temp"
    node.default['alfresco']["activiti_tomcat_instance"]['java_options']['rmi'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    node.default['alfresco']["activiti_tomcat_instance"]['java_options']['log_paths'] = "-Djava.util.logging.config.file=#{instance_home}/conf/logging.properties -Dlog4j.configuration=#{instance_home}/webapps/activiti-app/WEB-INF/classes/log4j.properties -Xloggc:#{logs_path}/gc.log -Dlogfilename=#{logs_path}/activiti.log -XX:ErrorFile=#{logs_path}/jvm_crash%p.log -XX:HeapDumpPath=#{logs_path}/"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']["activiti_tomcat_instance"]['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=#{cache_path},telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=activiti,tmpdir=#{cache_path},disableall"
    end
    node.default['tomcat']['instances']["activiti"] = node['alfresco']["activiti_tomcat_instance"]
  end
end
