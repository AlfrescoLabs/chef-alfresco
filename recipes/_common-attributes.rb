# If haproxy is configured and not nginx, Tomcat should redirect to internal ports
# see attributes/default.rb
if node['alfresco']['components'].include? 'haproxy'
  unless node['alfresco']['components'].include? 'nginx'
    node.default['alfresco']['public_portssl'] = node.default['alfresco']['internal_portssl']
    node.default['haproxy']['bind_ip'] = '0.0.0.0'
  end

  # Logrotate values; they will be used only if logrotate::global (or a wrapping recipe)
  # is part of the run_list
  node.default['logrotate']['global']['/var/log/haproxy/*.log'] = {
    'daily' => true,
    'weekly' => false,
    'create' => '600 root adm',
    'postrotate' => ['[ -f /var/run/syslogd.pid ] && kill -USR1 `cat /var/run/syslogd.pid`'],
  }
end

if node['alfresco']['components'].include? 'nginx'
  node.default['logrotate']['global']['/var/log/nginx/*.log'] = {
    'daily' => true,
    'weekly' => false,
    'delaycompress' => true,
    'notifempty' => true,
    'sharedscripts' => true,
    'create' => '600 nginx nginx',
    'postrotate' => ['[ -f /var/run/nginx.pid ] && kill -USR1 `cat /var/run/nginx.pid`'],
  }
end
