if node['appserver']['run_single_instance']
  node.default['haproxy']['backends']['roles']['share']['port'] = node['appserver']['port']
  node.default['haproxy']['backends']['roles']['solr']['port'] = node['appserver']['port']
  node.default['haproxy']['backends']['roles']['alfresco']['port'] = node['appserver']['port']
  node.default['haproxy']['backends']['roles']['aos_vti']['port'] = node['appserver']['port']
  node.default['haproxy']['backends']['roles']['aos_root']['port'] = node['appserver']['port']
end

alfresco_haproxy_config 'haproxy-config' do
  action :run
end
