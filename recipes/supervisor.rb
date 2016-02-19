include_recipe 'supervisor::default'

supervisor_service 'tomcat-alfresco' do
  action [:enable , :start]
  user 'tomcat'
  autorestart true
  directory '/usr/share/tomcat'
  command '/usr/share/tomcat/bin/catalina.sh run'
#  stdout_logfile 'syslog'
#  stderr_logfile 'syslog'
  environment "JAVA_HOME" => node['java']['java_home'],
    "CATALINA_HOME" => "/usr/share/tomcat/alfresco",
    "CATALINA_BASE" => "/usr/share/tomcat/alfresco"

end
