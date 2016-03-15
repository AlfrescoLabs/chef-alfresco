node.default['artifacts']['solrhome']['enabled'] = true
node.default['artifacts']['solr4']['enabled'] = true

if node['alfresco']['generate.solr.core.config']
  node.default['artifacts']['solrhome']['properties']['archive-SpacesStore/conf/solrcore.properties'] = node['alfresco']['archive-solrproperties']
  node.default['artifacts']['solrhome']['properties']['workspace-SpacesStore/conf/solrcore.properties'] = node['alfresco']['workspace-solrproperties']
  node.default['artifacts']['solrhome']['properties']['log4j-solr.properties'] = node['logging']
end

environment = {"JAVA_HOME" => node['java']['java_home'],"CATALINA_HOME" => node['alfresco']['home'],"CATALINA_BASE" => "#{node['alfresco']['home']}#{"/solr" unless node['tomcat']['run_single_instance']}"}

alfresco_service "tomcat-solr" do
  action :create
  user node['tomcat']['user']
  directory node['alfresco']['home']
  command node['supervisor']['tomcat']['command']
  environment environment
  not_if node['tomcat']['run_single_instance']
end
