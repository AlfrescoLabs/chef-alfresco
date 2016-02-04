ssl_folder = node['nginx']['ssl_folder']
ssl_folder_source = node['nginx']['ssl_folder_source']
ssl_folder_cookbook = node['nginx']['ssl_folder_cookbook']

# Override config values, if ssl is disabled
unless node['nginx']['use_nossl_config']
  node.default['nginx']['server']['proxy']['listen'] = "#{node['nginx']['ssl_port']} ssl http2"
  node.default['nginx']['server']['redirect'] = node['nginx']['ssl_server_redirect']
  node.default['nginx']['server']['proxy'] = node['nginx']['server']['proxy'].merge(node['nginx']['ssl_server_proxy'])
end

# Delete Centos default configuration
# Replaced by /etc/nginx/sites-enabled/*
file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

if node['nginx']['json_logging_enabled']
  node.default['nginx']['http']['log_format'] = node['nginx']['json_log_format']
end

include_recipe 'alfresco::_certs'
include_recipe 'alfresco::_errorpages'

# Done with cookbooks now, see commons::databags-to-files
#
# directory ssl_folder do
#   action :create
#   recursive true
# end
#
# remote_directory ssl_folder do
#   source ssl_folder_source
#   cookbook ssl_folder_cookbook
# end

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
