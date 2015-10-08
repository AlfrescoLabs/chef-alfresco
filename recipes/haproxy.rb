haproxy_cfg_source = node['haproxy']['conf_template_source']
haproxy_cfg_cookbook = node['haproxy']['conf_cookbook']

include_recipe 'alfresco::_certs'
include_recipe 'alfresco::_errorpages'

include_recipe 'haproxy::default'

# Set haproxy.cfg custom template
# TODO - fix it upstream and send PR
r = resources(template: "#{node['haproxy']['conf_dir']}/haproxy.cfg")
r.source(haproxy_cfg_source)
r.cookbook(haproxy_cfg_cookbook)

# Haproxy logs to local syslog by default
directory "/var/log/haproxy" do
  action :create
  owner "haproxy"
  group "haproxy"
end

template "/etc/rsyslog.d/haproxy.conf" do
  source "rsyslog/haproxy.conf.erb"
end

include_recipe 'rsyslog::server'
