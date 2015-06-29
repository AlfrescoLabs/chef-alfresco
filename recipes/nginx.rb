# Delete Centos default configuration
# Replaced by /etc/nginx/sites-enabled/*
file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

# nginx::repo must be explicitely called, to install nginx yum repos
# and get the latest package versions
include_recipe 'nginx::repo'

include_recipe 'nginx::default'

# Fixing nginx cookbook by overriding service actions and disabling/stopping it
service_actions = node['nginx']['service_actions']
r = resources(service: 'nginx')
r.action(service_actions)
