# Rsyslog defaults are only used if component includes "rsyslog"
default['rsyslog']['file_inputs']['mysql-error']['file'] = '/var/log/mysql-default/error.log'
default['rsyslog']['file_inputs']['mysql-error']['severity'] = 'error'
default['rsyslog']['file_inputs']['mysql-error']['priority'] = 57

default['rsyslog']['file_inputs']['mysqld']['file'] = '/var/log/mysqld.log'
default['rsyslog']['file_inputs']['mysqld']['severity'] = 'info'
default['rsyslog']['file_inputs']['mysqld']['priority'] = 58
