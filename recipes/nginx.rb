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

execute "selinux-command-nginx" do
    command "semanage port -a -t http_port_t -p tcp 2100"
    not_if "semanage port -l | grep 2100"
    only_if "getenforce | grep -i enforcing"
end

r = resources(service: 'nginx')
r.action([:disable, :stop])
