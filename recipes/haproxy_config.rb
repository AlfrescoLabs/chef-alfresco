haproxy_cfg_source = node['haproxy']['cfg_source']
haproxy_cfg_cookbook = node['haproxy']['cfg_cookbook']

template '/etc/haproxy/haproxy.cfg' do
  source haproxy_cfg_source
  cookbook haproxy_cfg_cookbook
  notifies :restart, 'service[haproxy]'
end

service 'haproxy' do
  action :nothing
end
