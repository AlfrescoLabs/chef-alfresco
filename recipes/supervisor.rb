include_recipe 'supervisor::default'

unless node['supervisor']['systemd_service_enabled']
  r = resources(:service "supervisord")
  r.action(:nothing)
end

tomcat_instances = []
if node['alfresco']['components'].include? "repo"
  tomcat_instances << "alfresco"
end
if node['alfresco']['components'].include? "share"
  tomcat_instances << "share"
end
if node['alfresco']['components'].include? "solr"
  tomcat_instances << "solr"
end
if node['alfresco']['components'].include? "activiti"
  tomcat_instances << "activiti"
end

actions = [:disable , :stop]

if node['supervisor']['start']
  actions = [:enable , :start]
end

tomcat_instances.each do |server_name|
  supervisor_service "tomcat-#{server_name}" do
    action actions
    user node['supervisor']['tomcat']['user']
    autorestart true
    directory node['alfresco']['home']
    command node['supervisor']['tomcat']['command']
  #  stdout_logfile 'syslog'
  #  stderr_logfile 'syslog'
    #TODO experiment with indentation & attributes
    environment "JAVA_HOME" => node['java']['java_home'],
      "CATALINA_HOME" => node['alfresco']['home'],
      "CATALINA_BASE" => "#{node['alfresco']['home']}/#{server_name}"
    end
end

supervisor_service "haproxy" do
  action actions
  user node['supervisor']['haproxy']['user']
  autorestart true
  command node['supervisor']['haproxy']['command']
  only_if { node['alfresco']['components'].include? 'haproxy' }
end

supervisor_service "nginx" do
  action actions
  user node['supervisor']['nginx']['user']
  autorestart true
  command node['supervisor']['nginx']['command']
  only_if { node['alfresco']['components'].include? 'nginx' }
end
