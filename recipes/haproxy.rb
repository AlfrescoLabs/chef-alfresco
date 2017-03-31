# haproxy_cfg_source = node['haproxy']['conf_template_source']
# haproxy_cfg_cookbook = node['haproxy']['conf_cookbook']
include_recipe 'alfresco::_certs'
include_recipe 'alfresco::_errorpages'

if node['haproxy']['enable_ssl_header']
  node.default['haproxy']['frontends']['external']['headers'] = [node['haproxy']['ssl_header']]
  node.default['haproxy']['backends']['share']['secure_entries'] = node['haproxy']['secure_entries']
end

# Install haproxy discovery
install_haproxy_discovery = node['haproxy']['ec2']['install_haproxy_discovery']
if install_haproxy_discovery
  template node['haproxy']['ec2']['discovery_chef_erb']['dest'] do
    source node['haproxy']['ec2']['discovery_chef_erb']['source']
  end
  template node['haproxy']['ec2']['discovery_chef_json']['dest'] do
    source node['haproxy']['ec2']['discovery_chef_json']['source']
  end
end

node.default['haproxy']['logformat'] = node['haproxy']['json_logformat'] if node['haproxy']['logging_json_enabled']

include_recipe 'haproxy::default'

selinux_commands = {}
# selinux_commands["mkdir -p /var/www/html/errors ; semanage fcontext -a -t haproxy_var_run_t \"/var/www/html/errors(/.*)\?\" ; restorecon -Rv /var/www/html/errors;"]  = "ls -lZ /var/www/html/errors | grep haproxy_var_run_t"
# selinux_commands["touch /var/run/haproxy.stat ; semanage fcontext -a -t haproxy_var_run_t \"/var/run/haproxy\\.stat.*\" ; restorecon -Rv /var/run/haproxy.stat;"] = "ls -lZ /var/run/haproxy.stat | grep haproxy_var_run_t"
# selinux_commands["semanage port -m -t http_port_t -p tcp 9001"] = "semanage port -l | grep http_port_t | grep 9001"
# selinux_commands["semanage port -m -t http_port_t -p tcp 1936"] = "semanage port -l | grep http_port_t | grep 1936"
selinux_commands['semanage permissive -a haproxy_t'] = 'semanage permissive -l | grep haproxy_t'

# TODO: - make it a custom resource
selinux_commands.each do |command, already_permissive|
  execute "selinux-command-#{command}" do
    command command
    only_if 'getenforce | grep -i enforcing'
    only_if 'which semanage'
    not_if already_permissive
  end
end

log 'Stopping default haproxy service' do
  message 'Stopping default haproxy service'
  level :warn
  notifies :stop, 'service[haproxy]', :immediately
  notifies :disable, 'service[haproxy]', :immediately
end

include_recipe 'alfresco::haproxy-config'

directory '/var/log/haproxy' do
  action :create
  owner 'haproxy'
  group 'haproxy'
end
