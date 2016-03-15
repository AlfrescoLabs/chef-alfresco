# include_recipe 'supervisor::default'
#
# unless node['supervisor']['systemd_service_enabled']
#   r = resources(service: "supervisor")
#   r.action(:nothing)
#
#   execute 'start supervisord manually' do
#     command "supervisord -c /etc/supervisord.conf &"
#   end
# end
#
# tomcat_instances = []
# if node['tomcat']['run_single_instance']
#   tomcat_instances << "alfresco"
# else
#   tomcat_instances << "alfresco" if node['alfresco']['components'].include? "repo"
#   tomcat_instances << "share" if node['alfresco']['components'].include? "share"
#   tomcat_instances << "solr" if node['alfresco']['components'].include? "solr"
#   tomcat_instances << "activiti" if node['alfresco']['components'].include? "activiti"
# end
#
# if node['supervisor']['start']
#   actions = [:enable , :start]
# else
#   actions = :enable
# end
#
# autostarting = node['supervisor']['start']
#
# tomcat_instances.each do |server_name|
#   supervisor_service "tomcat-#{server_name}" do
#     action actions
#     user node['supervisor']['tomcat']['user']
#     autorestart autostarting
#     autostart autostarting
#     directory node['alfresco']['home']
#     command node['supervisor']['tomcat']['command']
#   #  stdout_logfile 'syslog'
#   #  stderr_logfile 'syslog'
#     #TODO experiment with indentation & attributes
#     environment "JAVA_HOME" => node['java']['java_home'],
#       "CATALINA_HOME" => node['alfresco']['home'],
#       "CATALINA_BASE" => "#{node['alfresco']['home']}#{"/#{server_name}" unless node['tomcat']['run_single_instance']}"
#   end
# end
#
# node.default['artifacts']['activiti']['destination'] = "#{node['alfresco']['home']}#{"/activiti" unless node['tomcat']['run_single_instance']}/webapps"
# supervisor_service "haproxy" do
#   action actions
#   user node['supervisor']['haproxy']['user']
#   autorestart autostarting
#   autostart autostarting
#   command node['supervisor']['haproxy']['command']
#   only_if { node['alfresco']['components'].include? 'haproxy' }
# end
#
# supervisor_service "nginx" do
#   action actions
#   user node['supervisor']['nginx']['user']
#   autorestart autostarting
#   autostart autostarting
#   command node['supervisor']['nginx']['command']
#   only_if { node['alfresco']['components'].include? 'nginx' }
# end
