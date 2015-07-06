if node['alfresco']['generate.solr.core.config']
  node.default['artifacts']['solrhome']['properties']['archive-SpacesStore/conf/solrcore.properties'] = node['alfresco']['solrproperties']
  node.default['artifacts']['solrhome']['properties']['workspace-SpacesStore/conf/solrcore.properties'] = node['alfresco']['solrproperties']
  node.default['artifacts']['solrhome']['properties']['log4j-solr.properties'] = node['alfresco']['solr-log4j']
end
