if node['alfresco']['components'].include? 'repo'
  node.default['haproxy']['backends']['alfresco']['enabled_local'] = true
  node.default['haproxy']['backends']['aos_vti']['enabled_local'] = true
  node.default['haproxy']['backends']['aos_root']['enabled_local'] = true
end

if node['alfresco']['components'].include? 'share'
  node.default['haproxy']['backends']['share']['enabled_local'] = true
end

if node['alfresco']['components'].include? 'solr'
  node.default['haproxy']['backends']['solr']['enabled_local'] = true
end
