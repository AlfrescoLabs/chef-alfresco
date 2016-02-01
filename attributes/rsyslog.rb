default['rsyslog']['file_inputs']['repo1']['file'] = '/var/log/tomcat-alfresco/alfresco.log'
default['rsyslog']['file_inputs']['repo1']['severity'] = 'info'
default['rsyslog']['file_inputs']['repo1']['priority'] = 50
default['rsyslog']['file_inputs']['repo2']['file'] = '/var/log/tomcat-alfresco/catalina.*.log'
default['rsyslog']['file_inputs']['repo2']['severity'] = 'info'
default['rsyslog']['file_inputs']['repo2']['priority'] = 51

default['rsyslog']['file_inputs']['share1']['file'] = '/var/log/tomcat-share/share.log'
default['rsyslog']['file_inputs']['share1']['severity'] = 'info'
default['rsyslog']['file_inputs']['share1']['priority'] = 52
default['rsyslog']['file_inputs']['share2']['file'] = '/var/log/tomcat-share/catalina.*.log'
default['rsyslog']['file_inputs']['share2']['severity'] = 'info'
default['rsyslog']['file_inputs']['share2']['priority'] = 53

default['rsyslog']['file_inputs']['solr1']['file'] = '/var/log/tomcat-solr/solr.log'
default['rsyslog']['file_inputs']['solr1']['severity'] = 'info'
default['rsyslog']['file_inputs']['solr1']['priority'] = 54
default['rsyslog']['file_inputs']['solr2']['file'] = '/var/log/tomcat-solr/catalina.*.log'
default['rsyslog']['file_inputs']['solr2']['severity'] = 'info'
default['rsyslog']['file_inputs']['solr2']['priority'] = 55

default['rsyslog']['file_inputs']['mysql-error']['file'] = '/var/log/mysql-default/error.log'
default['rsyslog']['file_inputs']['mysql-error']['severity'] = 'error'
default['rsyslog']['file_inputs']['mysql-error']['priority'] = 57

default['rsyslog']['file_inputs']['nginx']['file'] = '/var/log/nginx/*.log'
default['rsyslog']['file_inputs']['nginx']['severity'] = 'error'
default['rsyslog']['file_inputs']['nginx']['priority'] = 56

# default['rsyslog']['file_inputs']['psql-error']['file'] = '/var/log/postgresql/error.log'
# default['rsyslog']['file_inputs']['psql-error']['severity'] = 'error'
# default['rsyslog']['file_inputs']['psql-error']['priority'] = 57
