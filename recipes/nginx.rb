# Enable SSL Stapling, if stapling is provided
if node['nginx']['stapling_enabled']
  node.default['nginx']['ssl_stapling_entry'] = "    ssl_stapling on; ssl_stapling_verify on; ssl_stapling_file #{node['nginx']['ssl_stapling_file']};"
end

# Enable SSL Trusted Certificate, if file is provided
if node['nginx']['trusted_certificate_enabled']
  node.default['nginx']['ssl_trusted_certificate_entry'] = "    ssl_trusted_certificate #{node['nginx']['trusted_certificate']};"
end

# Enable SSL Dh param PEM, if file is provided
if node['nginx']['dhparam_enabled']
  node.default['nginx']['dh_param_entry'] = "    ssl_dhparam #{node['nginx']['dhparam_pem']};"
end

ssl_folder = node['nginx']['ssl_folder']
ssl_folder_source = node['nginx']['ssl_folder_source']
ssl_folder_cookbook = node['nginx']['ssl_folder_cookbook']

# Delete Centos default configuration
# Replaced by /etc/nginx/sites-enabled/*
file "/etc/nginx/conf.d/default.conf" do
  action :delete
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
service_actions = node['nginx']['service_actions']
r = resources(service: 'nginx')
r.action(service_actions)
