# Rsyslog defaults are only used if component includes "rsyslog"
# node.default['rsyslog']['file_inputs']['psql-error']['file'] = '/var/log/postgresql/error.log'
# node.default['rsyslog']['file_inputs']['psql-error']['severity'] = 'error'
# node.default['rsyslog']['file_inputs']['psql-error']['priority'] = 57

node.default['postgresql']['version'] = "9.3"

node.default['postgresql']['users'] = [
    {
      "username": db_user,
      "password": db_pass,
      "superuser": true,
      "replication": false,
      "createdb": true,
      "createrole": false,
      "inherit": true,
      "replication": false,
      "login": true
    }
  ]

node.default['postgresql']['databases'] = [
    {
      "name": db_database,
      "owner": db_user,
      "encoding": "UTF-8",
      "locale": "en_US.UTF-8"
    }
  ]

include_recipe 'postgresql::server'
