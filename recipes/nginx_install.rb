# Rsyslog defaults are only used if component includes "rsyslog"
node.default['rsyslog']['file_inputs']['nginx']['file'] = '/var/log/nginx/error.log'
node.default['rsyslog']['file_inputs']['nginx']['severity'] = 'error'
node.default['rsyslog']['file_inputs']['nginx']['priority'] = 56

include_recipe 'nginx::repo'
include_recipe 'nginx::commons'
include_recipe 'nginx::package'

# Delete Centos default configuration
# Replaced by /etc/nginx/sites-enabled/*
file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

template '/etc/nginx/nginx.conf' do
  source node['nginx']['cfg_source']
  cookbook node['nginx']['cfg_cookbook']
end

include_recipe 'nginx::default'

# Fixing nginx cookbook by overriding service actions and disabling/stopping it
service_actions = node['nginx']['service_actions']
r = resources(service: 'nginx')
r.action(service_actions)
