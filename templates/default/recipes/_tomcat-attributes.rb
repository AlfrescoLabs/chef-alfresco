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
if node['tomcat']['run_base_instance']
  node.default['alfresco']['restart_services'] = ['tomcat']
  if alfresco_components.include? 'solr'
    node.default["tomcat"]["java_options"] = "#{node["tomcat"]["java_options"]} -Dsolr.solr.home=#{node['alfresco']['solrproperties']['data.dir.root']}"
  end
else
  alfresco_components = node['alfresco']['components']
  if alfresco_components.include? "repo"
    node.default['alfresco']['repo_tomcat_instance']['java_options'] = "#{node['alfresco']['repo_tomcat_instance']['java_options']} -Dalfresco.home=#{node['alfresco']['home']}-alfresco -Djava.rmi.server.hostname=#{node['alfresco']['public_hostname']}"
    node.default['tomcat']['instances']['alfresco'] = node['alfresco']['repo_tomcat_instance']
  end
  if alfresco_components.include? 'share'
    node.default['alfresco']['share_tomcat_instance']['java_options'] = "#{node['alfresco']['share_tomcat_instance']['java_options']} -Djava.rmi.server.hostname=#{node['alfresco']['public_hostname']}"
    node.default['tomcat']['instances']['share'] = node['alfresco']['share_tomcat_instance']
  end
  if alfresco_components.include? 'solr'
    node.default['alfresco']['solr_tomcat_instance']['java_options'] = "#{node['alfresco']['solr_tomcat_instance']['java_options']} -Dsolr.solr.home=#{node['alfresco']['solrproperties']['data.dir.root']} -Djava.rmi.server.hostname=#{node['alfresco']['public_hostname']} -Dsolr.solr.content.dir=#{node['alfresco']['solr']['contentstore.path']}"
    node.default['tomcat']['instances']['solr'] = node['alfresco']['solr_tomcat_instance']
  end
end
