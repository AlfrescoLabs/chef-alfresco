node.default['haproxy']['frontends']['http']['entries'] = [
  "bind #{node['haproxy']['bind_ip']}:#{node['haproxy']['port']}"
]
