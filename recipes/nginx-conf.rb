# Override config values, if ssl is disabled
unless node['nginx']['use_nossl_config']
  node.default['nginx']['server']['proxy']['listen'] = "#{node['nginx']['ssl_port']} ssl http2"
  node.default['nginx']['server']['redirect'] = node['nginx']['ssl_server_redirect']
  node.default['nginx']['server']['proxy'] = node['nginx']['server']['proxy'].merge(node['nginx']['ssl_server_proxy'])
end

node.default['nginx']['http']['log_format'] = node['nginx']['json_log_format'] if node['nginx']['json_logging_enabled']

# Patch nginx configurations, making sure the service runs
include_recipe 'nginx::commons_conf'

r = resources(template: 'nginx.conf')
r.notifies(:nothing, 'service[nginx]', :delayed)

r = resources(template: "#{node['nginx']['dir']}/sites-available/default")
r.notifies(:nothing, 'service[nginx]', :delayed)

#service_actions = [:enable, :start]
#service 'nginx' do
  #action service_actions
#end
