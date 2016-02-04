# Override config values, if ssl is disabled
unless node['nginx']['use_nossl_config']
  node.default['nginx']['server']['proxy']['listen'] = "#{node['nginx']['ssl_port']} ssl http2"
  node.default['nginx']['server']['redirect'] = node['nginx']['ssl_server_redirect']
  node.default['nginx']['server']['proxy'] = node['nginx']['server']['proxy'].merge(node['nginx']['ssl_server_proxy'])
end

if node['nginx']['json_logging_enabled']
  node.default['nginx']['http']['log_format'] = node['nginx']['json_log_format']
end

# Patch nginx configurations, making sure the service runs
include_recipe 'nginx::commons_conf'

service_actions = [:enable, :start]
service 'nginx' do
  action service_actions
end
