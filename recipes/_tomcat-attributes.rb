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
  "dest" => "#{node['alfresco']['home']}-alfresco/lib/org/apache/catalina/util",
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
    node.default["alfresco"]["repo_tomcat_instance"]['java_options']['rmi_and_alfhome'] = "-Dalfresco.home=#{node['alfresco']['home']}-alfresco -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']['repo_tomcat_instance']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=#{node['tomcat']['cache_root_folder']}/tomcat-alfresco,telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=repo,tmpdir=/usr/share/tomcat-alfresco/temp"
    end
    node.default['tomcat']['instances']['alfresco'] = node['alfresco']['repo_tomcat_instance']
  end
  if alfresco_components.include? 'share'
    node.default["alfresco"]["share_tomcat_instance"]['java_options']['rmi'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']['share_tomcat_instance']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=#{node['tomcat']['cache_root_folder']}/tomcat-share,telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=share,tmpdir=/usr/share/tomcat-share/temp,disableall"
    end
    node.default['tomcat']['instances']['share'] = node['alfresco']['share_tomcat_instance']
  end
  if alfresco_components.include? 'solr'
    node.default["alfresco"]["solr_tomcat_instance"]['java_options']['rmi_and_solr'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']} -Dsolr.solr.model.dir=#{node['alfresco']['solr']['alfresco_models']} -Dsolr.solr.home=#{node['alfresco']['solr']['home']}  -Dsolr.solr.content.dir=#{node['alfresco']['solr']['contentstore.path']}"
    if alfresco_components.include? 'yourkit'
      node.default['alfresco']['solr_tomcat_instance']['java_options']['yourkit'] = "-agentpath:/usr/local/lib64/libyjpagent.so=dir=#{node['tomcat']['cache_root_folder']}/tomcat-solr,telemetrylimit=1,builtinprobes=none,onexit=snapshot,sessionname=solr,tmpdir=/usr/share/tomcat-solr/temp"
    end
    node.default['tomcat']['instances']['solr'] = node['alfresco']['solr_tomcat_instance']
  end
  if alfresco_components.include? 'activiti'
    node.default['alfresco']['activiti_tomcat_instance']['java_options']['rmi'] = "-Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}"
    node.default['tomcat']['instances']['activiti'] = node['alfresco']['activiti_tomcat_instance']
  end
end
