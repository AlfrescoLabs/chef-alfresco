default['rsyslog']['file_inputs']['repo1']['file'] = '/var/log/tomcat-alfresco/alfresco.log'
default['rsyslog']['file_inputs']['repo1']['severity'] = 'info'
default['rsyslog']['file_inputs']['repo1']['priority'] = 50
default['rsyslog']['file_inputs']['repo2']['file'] = '/var/log/tomcat-alfresco/catalina.out.*'
default['rsyslog']['file_inputs']['repo2']['severity'] = 'info'
default['rsyslog']['file_inputs']['repo2']['priority'] = 51

# Rsyslog defaults are only used if component includes "rsyslog"
default['rsyslog']['file_inputs']['share1']['file'] = '/var/log/tomcat-share/share.log'
default['rsyslog']['file_inputs']['share1']['severity'] = 'info'
default['rsyslog']['file_inputs']['share1']['priority'] = 52
default['rsyslog']['file_inputs']['share2']['file'] = '/var/log/tomcat-share/catalina.out.*'
default['rsyslog']['file_inputs']['share2']['severity'] = 'info'
default['rsyslog']['file_inputs']['share2']['priority'] = 53

# Rsyslog defaults are only used if component includes "rsyslog"
default['rsyslog']['file_inputs']['solr1']['file'] = '/var/log/tomcat-solr/solr.log'
default['rsyslog']['file_inputs']['solr1']['severity'] = 'info'
default['rsyslog']['file_inputs']['solr1']['priority'] = 54
default['rsyslog']['file_inputs']['solr2']['file'] = '/var/log/tomcat-solr/catalina.out.*'
default['rsyslog']['file_inputs']['solr2']['severity'] = 'info'
default['rsyslog']['file_inputs']['solr2']['priority'] = 55
