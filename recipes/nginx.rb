ssl_folder = node['nginx']['ssl_folder']
ssl_folder_source = node['nginx']['ssl_folder_source']
ssl_folder_cookbook = node['nginx']['ssl_folder_cookbook']

# Override config values, if ssl is disabled
if node['nginx']['use_nossl_config']
  node.set['nginx']['config'] = node['nginx']['nossl_config']
end

# Delete Centos default configuration
# Replaced by /etc/nginx/sites-enabled/*
file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

if node['nginx']['logging_json_enabled']
  node.default['nginx']['logging'] = " log_format main '{ \"@timestamp\": \"$time_iso8601\", '",
  "                        '\"@fields\": { '",
  "                        '\"remote_addr\": \"$remote_addr\", '",
  "                        '\"remote_user\": \"$remote_user\", '",
  "                        '\"request_time\": \"$request_time\", '",
  "                        '\"request\": \"$request\", '",
  "                        '\"status\": \"$status\", '",
  "                        '\"body_bytes_sent\": \"$body_bytes_sent\", '",
  "                        '\"request_method\": \"$request_method\", '",
  "                        '\"http_referrer\": \"$http_referer\", '",
  "                        '\"http_user_agent\": \"$http_user_agent\",",
  "                        '\"$http_x_forwarded_for\" : \"$http_x_forwarded_for\" } }';"
end

include_recipe 'alfresco::_certs'
include_recipe 'alfresco::_errorpages'

directory ssl_folder do
  action :create
  recursive true
end

remote_directory ssl_folder do
  source ssl_folder_source
  cookbook ssl_folder_cookbook
end

# nginx::repo must be explicitely called, to install nginx yum repos
# and get the latest package versions
include_recipe 'nginx::repo'

include_recipe 'nginx::default'

# Fixing nginx cookbook by overriding service actions and disabling/stopping it
if node['nginx']['disable_nginx_init']
  service_actions = [:disable,:stop]
else
  service_actions = node['nginx']['service_actions']
end

r = resources(service: 'nginx')
r.action(service_actions)
