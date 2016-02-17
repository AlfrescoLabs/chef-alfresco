include_recipe 'supervisor::default'

supervisor_service 'tomcat' do
  action [:enable , :stop]
  user 'tomcat'
  autorestart true
  directory '/usr/share/tomcat'
  command '/usr/share/tomcat/bin/catalina.sh run'
#  stdout_logfile 'syslog'
#  stderr_logfile 'syslog'
#  environment {'JAVA_HOME' : 'changeme', 'CATALINA_HOME' : 'changeme'}
end
