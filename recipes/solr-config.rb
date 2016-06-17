node.default['artifacts']['solrhome']['enabled'] = true
node.default['artifacts']['solrhome']['destination'] = node['alfresco']['properties']['dir.root']
node.default['artifacts']['solr4']['enabled'] = true

if node['alfresco']['generate.solr.core.config'] == true
  node.default['artifacts']['solrhome']['properties']['archive-SpaceStore/conf/solrcore.properties'] = node['alfresco']['archive-solrproperties']
  node.default['artifacts']['solrhome']['properties']['workspace-SpaceStore/conf/solrcore.properties'] = node['alfresco']['workspace-solrproperties']
  node.default['artifacts']['solrhome']['properties']['log4j-solr.properties'] = node['logging']
end
