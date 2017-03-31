if node['tomcat']['run_single_instance']
  node.default['haproxy']['backends']['roles']['share']['port'] = node['tomcat']['port']
  node.default['haproxy']['backends']['roles']['solr']['port'] = node['tomcat']['port']
  node.default['haproxy']['backends']['roles']['alfresco']['port'] = node['tomcat']['port']
  node.default['haproxy']['backends']['roles']['aos_vti']['port'] = node['tomcat']['port']
  node.default['haproxy']['backends']['roles']['aos_root']['port'] = node['tomcat']['port']
end

alfresco_haproxy_config 'haproxy-config' do
  action :run
end
