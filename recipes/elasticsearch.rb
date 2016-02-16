# Installs elasticsearch
es_override_config = node['elasticsearch']['override_config']

# Needed by elasticsearch (why? tried after new es cookbook release 2.0.0?)
package 'ruby' do
  action :install
end

elasticsearch_user 'elasticsearch' do
  shell '/bin/bash'
  comment 'Elasticsearch User'
  action :create
end

directory '/var/log/elasticsearch' do
  owner 'elasticsearch'
  group 'elasticsearch'
  mode '0755'
  recursive true
  action :create
end

elasticsearch_install 'elasticsearch' do
  type :tarball
  version node['elasticsearch']['version']
  download_checksum node['elasticsearch']['checksum']
  action :install
end

elasticsearch_configure 'elasticsearch'
elasticsearch_service 'elasticsearch'

es_override_config.each do |conf_name,conf_value|
  replace_or_add "es-yml-#{conf_name}=#{conf_value}" do
    # TODO - use elasticsearch default attributes to resolve etc folder
    path '/usr/local/etc/elasticsearch/elasticsearch.yml'
    pattern "#{conf_name}:"
    line "#{conf_name}: #{conf_value}"
  end
end

# TODO - use supervisord and define
# action [:disable,:stop]
service 'elasticsearch' do
  action [:enable,:start]
end
