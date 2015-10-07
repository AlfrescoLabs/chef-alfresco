node.default['alfresco']['properties']['db.prefix'] = 'psql'
node.default['alfresco']['properties']['db.port'] = '5432'
node.default['alfresco']['properties']['db.params'] = ''

node.default['postgresql']['users'] = [
    {
      "username"=> db_user,
      "password"=> db_pass,
      "superuser"=> true,
      "replication"=> false,
      "createdb"=> true,
      "createrole"=> false,
      "inherit"=> true,
      "replication"=> false,
      "login"=> true
    }
  ]

node.default['postgresql']['databases'] = [
    {
      "name"=> db_database,
      "owner"=> db_user,
      "encoding"=> "UTF-8",
      "locale"=> "en_US.UTF-8"
    }
  ]

include_recipe 'postgresql::server'
