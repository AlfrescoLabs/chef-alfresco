# Alfresco dir root (used in _alfrescoproperties-attributes.rb and below)
node.default['alfresco']['properties']['dir.root'] = "#{node['alfresco']['home']}/alf_data"

# Solr Common attributes (used in _tomcat-attributes.rb)
node.default['alfresco']['solr']['alfresco_models'] = "#{node['alfresco']['properties']['dir.root']}/newAlfrescoModels"
node.default['alfresco']['solr']['home'] = "#{node['alfresco']['properties']['dir.root']}/solrhome"
node.default['alfresco']['solr']['index_path'] = "#{node['alfresco']['properties']['dir.root']}/solrhome"
node.default['alfresco']['solr']['contentstore.path'] = "#{node['alfresco']['properties']['dir.root']}/solrContentStore"
node.default['alfresco']['workspace-solrproperties']['data.dir.root'] = node['alfresco']['solr']['index_path']
node.default['alfresco']['workspace-solrproperties']['alfresco.baseUrl'] = "/#{node['alfresco']['properties']['alfresco.context']}"
node.default['alfresco']['workspace-solrproperties']['alfresco.secureComms'] = node['alfresco']['properties']['solr.secureComms']
node.default['alfresco']['archive-solrproperties']['data.dir.root'] = node['alfresco']['solr']['index_path']
node.default['alfresco']['archive-solrproperties']['alfresco.baseUrl'] = "/#{node['alfresco']['properties']['alfresco.context']}"
node.default['alfresco']['archive-solrproperties']['alfresco.secureComms'] = node['alfresco']['properties']['solr.secureComms']

# If haproxy is configured and not nginx, Tomcat should redirect to internal ports
# see attributes/default.rb
if node['alfresco']['components'].include? 'haproxy'
  unless node['alfresco']['components'].include? 'nginx'
    node.default['alfresco']['public_portssl'] = node.default['alfresco']['internal_portssl']
    node.default['haproxy']['bind_ip'] = "0.0.0.0"
  end

  # Logrotate values; they will be used only if logrotate::global (or a wrapping recipe)
  # is part of the run_list
  node.default['logrotate']['global']['/var/log/haproxy/*.log'] = {
    'daily'  => true,
    'weekly'  => false,
    'create' => '600 root adm',
    'postrotate'  => ['[ -f /var/run/syslogd.pid ] && kill -USR1 `cat /var/run/syslogd.pid`']
  }
end

# If enabled, Tomcat SSL Connector will use this redirectPort
node.default['tomcat']['ssl_redirect_port'] = node['alfresco']['public_portssl']

if node['alfresco']['components'].include? 'nginx'
  node.default['logrotate']['global']['/var/log/nginx/*.log'] = {
    'daily'  => true,
    'weekly'  => false,
    'delaycompress'  => true,
    'notifempty' => true,
    'sharedscripts' => true,
    'create' => '600 nginx nginx',
    'postrotate' => ['[ -f /var/run/nginx.pid ] && kill -USR1 `cat /var/run/nginx.pid`']
  }
end
