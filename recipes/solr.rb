node.default['artifacts']['solrhome']['enabled'] = true
node.default['artifacts']['solr4']['enabled'] = true

if node['alfresco']['generate.solr.core.config']
  # TODO - does the template approach work on 5.0? Give it a try!

  # TODO - Create 'archive-properties' and 'workspace-properties', with different setups; should be all attributes
  # TODO - Setup data.dir.root for each core
  # TODO - Setup before JVM param node['alfresco']['solr']['contentstore.path']=/mnt/solrContentStore
  node.default['artifacts']['solrhome']['properties']['archive-SpacesStore/conf/solrcore.properties'] = node['alfresco']['archive-solrproperties']
  node.default['artifacts']['solrhome']['properties']['workspace-SpacesStore/conf/solrcore.properties'] = node['alfresco']['workspace-solrproperties']
  # TODO - remove ['properties']
  node.default['artifacts']['solrhome']['properties']['log4j-solr.properties'] = node['alfresco']['solr-log4j']
end
