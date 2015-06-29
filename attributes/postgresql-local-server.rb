# Rsyslog defaults are only used if component includes "rsyslog"
# default['rsyslog']['file_inputs']['psql-error']['file'] = '/var/log/postgresql/error.log'
# default['rsyslog']['file_inputs']['psql-error']['severity'] = 'error'
# default['rsyslog']['file_inputs']['psql-error']['priority'] = 57

default['alfresco']['properties']['db.port'] = '5432'
default['alfresco']['properties']['db.params'] = ''

default['postgresql']['version'] = "9.3"
