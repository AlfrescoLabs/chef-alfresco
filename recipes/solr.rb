node.default['artifacts']['solrhome']['enabled'] = true
node.default['artifacts']['solr4']['enabled'] = true


if alf_version_ge?('5.2')
  node.default['alfresco']['workspace-solrproperties']['alfresco.postfilter'] = true
  node.default['alfresco']['archive-solrproperties']['alfresco.postfilter'] = true
end

if node['alfresco']['generate.solr.core.config'] == true
  node.default['artifacts']['solrhome']['properties']['archive-SpacesStore/conf/solrcore.properties'] = node['alfresco']['archive-solrproperties']
  node.default['artifacts']['solrhome']['properties']['workspace-SpacesStore/conf/solrcore.properties'] = node['alfresco']['workspace-solrproperties']
  node.default['artifacts']['solrhome']['properties']['log4j-solr.properties'] = node['logging']
end
