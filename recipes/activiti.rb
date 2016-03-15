
#remove the db.properties file, as it will be used as default if another one is not provided
# done only in the community edition

file "#{node['alfresco']['home']}/activiti/webapps/activiti-app/WEB-INF/classes/db.properties" do
	action :delete
	only_if { node['activiti-app']['edition'] == "community" }
end

environment = {"JAVA_HOME" => node['java']['java_home'],"CATALINA_HOME" => node['alfresco']['home'],"CATALINA_BASE" => "#{node['alfresco']['home']}#{"/activiti" unless node['tomcat']['run_single_instance']}"}

alfresco_service "tomcat-activiti" do
  action :create
  user node['supervisor']['tomcat']['user']
  directory node['alfresco']['home']
  command "node['supervisor']['tomcat']['command']"
  environment environment
  only_if { node['alfresco']['components'].include? 'activiti'}
  not_if node['tomcat']['run_single_instance']
end
