# Add Solr backend entry to local instance
node.default['haproxy']['backends']['solr']['nodes']['localhost'] = node['alfresco']['internal_hostname']

node.default['artifacts']['solrhome']['enabled'] = true
node.default['artifacts']['solr4']['enabled'] = true

if node['alfresco']['generate.solr.core.config']
  node.default['artifacts']['solrhome']['properties']['archive-SpacesStore/conf/solrcore.properties'] = node['alfresco']['archive-solrproperties']
  node.default['artifacts']['solrhome']['properties']['workspace-SpacesStore/conf/solrcore.properties'] = node['alfresco']['workspace-solrproperties']
  # TODO - remove ['properties']
  node.default['artifacts']['solrhome']['properties']['log4j-solr.properties'] = node['alfresco']['solr-log4j']
end
