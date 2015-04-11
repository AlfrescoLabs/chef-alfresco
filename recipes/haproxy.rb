alfresco_components = node['alfresco']['components']

repo_member = node['haproxy']['repo']
share_member = node['haproxy']['share']
solr_member = node['haproxy']['solr']

if alfresco_components.include? "repo"
  node.override['haproxy']['listeners']['backend']['repo'] = node['haproxy']['repo']
end
if alfresco_components.include? 'share'
  node.override['haproxy']['listeners']['backend']['share'] = node['haproxy']['share']
end
if alfresco_components.include? 'solr'
  node.override['haproxy']['listeners']['backend']['solr'] = node['haproxy']['solr']
end

include_recipe 'haproxy::default'
