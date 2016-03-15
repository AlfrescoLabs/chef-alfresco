# Delete Centos default configuration
# Replaced by /etc/nginx/sites-enabled/*
file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

include_recipe 'alfresco::_errorpages'

# nginx::repo must be explicitely called, to install nginx yum repos
# and get the latest package versions
include_recipe 'nginx::repo'
include_recipe 'nginx::default'

r = resources(service: 'nginx')
r.action([:disable, :stop])

alfresco_service "nginx" do
  action :create
  user node['supervisor']['nginx']['user']
  command node['supervisor']['nginx']['command']
end
