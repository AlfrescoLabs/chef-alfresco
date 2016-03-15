node.default['artifacts']['share']['enabled'] = true
node.default['artifacts']['sharedclasses']['enabled'] = true
node.default['artifacts']['hazelcast-cloud']['enabled'] = true

shared_folder     = node['alfresco']['shared']

node.default['artifacts']['sharedclasses']['terms']['alfresco/web-extension/share-config-custom.xml'] = node['alfresco']['properties'] if node['alfresco']['patch.share.config.custom']

#TODO - make it generic using File.dirName(share_log4j_path)
directory "web-extension" do
  path        "#{shared_folder}/classes/alfresco/web-extension"
  owner       node['alfresco']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

template "share-config-custom.xml" do
  path        "#{shared_folder}/classes/alfresco/web-extension/share-config-custom.xml"
  source      "share-config-custom.xml.erb"
  owner       node['alfresco']['user']
  group       node['tomcat']['group']
  # TODO
  # cookbook
  # source
  mode        "0664"
  #TODO - not working; for now, we run it all the time
  only_if     { node['alfresco']['generate.share.config.custom'] == true }
end

template "share-cluster-application-context.xml" do
  path        "#{shared_folder}/classes/alfresco/web-extension/share-cluster-application-context.xml"
  source      "share-cluster-application-context.xml.erb"
  owner       node['alfresco']['user']
  group       node['tomcat']['group']
  mode        "0664"
end

environment = {"JAVA_HOME" => node['java']['java_home'],"CATALINA_HOME" => node['alfresco']['home'],"CATALINA_BASE" => "#{node['alfresco']['home']}#{"/share" unless node['tomcat']['run_single_instance']}"}

alfresco_service "tomcat-share" do
  action :create
  user node['supervisor']['tomcat']['user']
  directory node['alfresco']['home']
  command node['supervisor']['tomcat']['command']
  environment environment
  only_if { node['alfresco']['components'].include? 'share'}
  not_if node['tomcat']['run_single_instance']
end
