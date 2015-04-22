template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy/haproxy.cfg.erb'
  notifies :restart, 'service[haproxy]'
end

service 'haproxy' do
  action :nothing
end
