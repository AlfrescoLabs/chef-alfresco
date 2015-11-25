###### Temporary tomcat attributes from tomcat cookbook

node.default['tomcat']['base_version'] = 7
node.default['tomcat']['base_instance'] = "tomcat#{node['tomcat']['base_version']}"
node.default['tomcat']['packages'] = ["tomcat#{node['tomcat']['base_version']}"]
node.default['tomcat']['deploy_manager_packages'] = ["tomcat#{node['tomcat']['base_version']}-admin"]

case node['platform_family']

when 'rhel', 'fedora'
  node.default['tomcat']['base_instance'] = "tomcat"
  node.default['tomcat']['user'] = 'tomcat'
  node.default['tomcat']['group'] = 'tomcat'
  node.default['tomcat']['home'] = "/usr/share/tomcat"
  node.default['tomcat']['base'] = "/etc/tomcat"
  node.default['tomcat']['config_dir'] = "/etc/tomcat/conf"
  node.default['tomcat']['log_dir'] = "/etc/tomcat/log"
  node.default['tomcat']['tmp_dir'] = "/etc/tomcat/temp"
  node.default['tomcat']['work_dir'] = "/etc/tomcat/work"
  node.default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  node.default['tomcat']['webapp_dir'] = "/etc/tomcat/webapps"
  node.default['tomcat']['lib_dir'] = "/etc/tomcat/lib"
  node.default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
  node.default['tomcat']['packages'] = ["tomcat"]
  node.default['tomcat']['deploy_manager_packages'] = ["tomcat-admin-webapps"]
when 'debian'
  node.default['tomcat']['user'] = "tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['group'] = "tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['base'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  node.default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  node.default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  node.default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  node.default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
when 'smartos'
  node.default['tomcat']['user'] = 'tomcat'
  node.default['tomcat']['group'] = 'tomcat'
  node.default['tomcat']['home'] = '/opt/local/share/tomcat'
  node.default['tomcat']['base'] = '/opt/local/share/tomcat'
  node.default['tomcat']['config_dir'] = '/opt/local/share/tomcat/conf'
  node.default['tomcat']['log_dir'] = '/opt/local/share/tomcat/logs'
  node.default['tomcat']['tmp_dir'] = '/opt/local/share/tomcat/temp'
  node.default['tomcat']['work_dir'] = '/opt/local/share/tomcat/work'
  node.default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  node.default['tomcat']['webapp_dir'] = '/opt/local/share/tomcat/webapps'
  node.default['tomcat']['keytool'] = '/opt/local/bin/keytool'
  node.default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  node.default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["home"]}/lib/endorsed"
  node.default['tomcat']['packages'] = ["apache-tomcat"]
  node.default['tomcat']['deploy_manager_packages'] = []
else
  node.default['tomcat']['user'] = "tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['group'] = "tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['base'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  node.default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  node.default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  node.default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  node.default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  node.default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
end


#######################################



# Using catalina-jmx
node.default['artifacts']['catalina-jmx']['groupId'] = "org.apache.tomcat"
node.default['artifacts']['catalina-jmx']['artifactId'] = "tomcat-catalina-jmx-remote"
node.default['artifacts']['catalina-jmx']['version'] = "7.0.54"
node.default['artifacts']['catalina-jmx']['type'] = 'jar'
node.default['artifacts']['catalina-jmx']['destination'] = "#{node['alfresco']['home']}/lib"
node.default['artifacts']['catalina-jmx']['owner'] = node['alfresco']['user']

node.default['tomcat']['jvm_route'] = "alfresco-#{node['alfresco']['public_hostname']}"

node.default['tomcat']['global_templates'] = [{
  "dest" => "#{node['alfresco']['home']}/conf",
  "filename" => "jmxremote.access",
  "owner" => "tomcat"
},{
  "dest" => "#{node['alfresco']['home']}/conf",
  "filename" => "jmxremote.password",
  "owner" => "tomcat"
},{
  "dest" => "#{node['alfresco']['home']}/alfresco/lib/org/apache/catalina/util",
  "filename" => "ServerInfo.properties",
  "owner" => "tomcat"
},{
  "dest" => "/etc/security/limits.d",
  "filename" => "tomcat_limits.conf",
  "owner" => "tomcat"
}]

# Setting JAVA_OPTS
alfresco_components = node['alfresco']['components']
if node['tomcat']['run_base_instance']
  node.default['alfresco']['restart_services'] = ['tomcat']
  if alfresco_components.include? 'solr'
    node.default["tomcat"]["java_options"]['rmi_and_solr'] = "-Dalfresco.home=#{node['alfresco']['home']} -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']} -Dsolr.solr.home=#{node['alfresco']['solr']['home']} -Dsolr.solr.model.dir=#{node['alfresco']['solr']['alfresco_models']} -Dsolr.solr.content.dir=#{node['alfresco']['solr']['contentstore.path']}"
  end
else
  if alfresco_components.include? "repo"
    node.default["alfresco"]["repo_tomcat_instance"]['java_options']['rmi_and_alfhome'] = "-Dalfresco.home=#{node['alfresco']['home']}/alfresco -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']['repo_tomcat_instance']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=/etc/tomcat/alfresco/temp,telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=repo,tmpdir=/etc/tomcat/alfresco/temp"
    end
    node.default['tomcat']['instances']['alfresco'] = node['alfresco']['repo_tomcat_instance']
  end
  if alfresco_components.include? 'share'
    node.default["alfresco"]["share_tomcat_instance"]['java_options']['rmi'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']['share_tomcat_instance']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=/etc/tomcat/share/temp,telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=share,tmpdir=/etc/tomcat/share/temp"
    end
    node.default['tomcat']['instances']['share'] = node['alfresco']['share_tomcat_instance']
  end
  if alfresco_components.include? 'solr'
    node.default["alfresco"]["solr_tomcat_instance"]['java_options']['rmi_and_solr'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']} -Dsolr.solr.model.dir=#{node['alfresco']['solr']['alfresco_models']} -Dsolr.solr.home=#{node['alfresco']['solr']['home']}  -Dsolr.solr.content.dir=#{node['alfresco']['solr']['contentstore.path']}"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']['solr_tomcat_instance']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=/etc/tomcat/solr/temp,telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=solr,tmpdir=/etc/tomcat/solr/temp"
    end
    node.default['tomcat']['instances']['solr'] = node['alfresco']['solr_tomcat_instance']
  end
end
