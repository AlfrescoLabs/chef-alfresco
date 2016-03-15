
enable_rsyslog_server = node['haproxy']['enable_rsyslog_server']
rsyslog_bind = node['haproxy']['rsyslog_bind']

include_recipe 'alfresco::_certs'
include_recipe 'alfresco::_errorpages'

if node['haproxy']['enable_ssl_header']
  node.default['haproxy']['frontends']['external']['headers'] = [node['haproxy']['ssl_header']]
  node.default['haproxy']['backends']['share']['secure_entries'] =  node['haproxy']['secure_entries']
end

# Install haproxy discovery
install_haproxy_discovery = node['haproxy']['ec2']['install_haproxy_discovery']
if install_haproxy_discovery
  # Install/configure awscli, as it's used by haproxy ec2 discovery
  awscli_setup 'install and configure awscli'

  template node['haproxy']['ec2']['discovery_chef_erb'] do
    source 'haproxy/haproxy-discovery.cron.erb'
  end
  template node['haproxy']['ec2']['discovery_chef_json'] do
    source 'haproxy/haproxy-discovery.json.erb'
  end
end

node.default['haproxy']['logformat'] = node['haproxy']['json_logformat'] if node['haproxy']['logging_json_enabled']

include_recipe 'haproxy::default'

r = resources(service: 'haproxy')
r.action([:disable, :stop])

include_recipe 'alfresco::haproxy-config'

# TODO - rsyslog stuff should go somewhere else (not sure where)

# Haproxy rsyslog configuration
directory "/var/log/haproxy" do
  action :create
  owner "haproxy"
  group "haproxy"
end
template "/etc/rsyslog.d/haproxy.conf" do
  source "rsyslog/haproxy.conf.erb"
  only_if { node['haproxy']['enable_local_logging'] }
end

# TODO - this block can be contributed to a lib cookbook, somewhere
# Make sure Rsyslog is configured to receive Haproxy logs
if enable_rsyslog_server and File.exist?('/etc/rsyslog.conf')
  lines_to_append = [
    ["$ModLoad imudp",nil],
    ["$UDPServerAddress #{rsyslog_bind}","$UDPServerAddress"],
    ["$UDPServerRun 514","$UDPServerRun"]
  ]

  lines_to_append.each do |line|
    new_line = line[0]
    line_match = line[1]

    if line_match == nil
      line_match = new_line
    end
    replace_or_add "rsyslog-conf-#{line}" do
      path "/etc/rsyslog.conf"
      pattern line_match
      line new_line
      notifies :restart, 'service[rsyslog]', :delayed
    end
  end

  service 'rsyslog' do
    action :nothing
  end

  alfresco_service "haproxy" do
    action :create
    user node['supervisor']['haproxy']['user']
    command node['supervisor']['haproxy']['command']
  end

end
