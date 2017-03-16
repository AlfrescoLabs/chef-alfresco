default['solr6']['shared-properties']['alfresco.identifier.property'] = {
  0 => '{http://www.alfresco.org/model/content/1.0}creator',
  1 => '{http://www.alfresco.org/model/content/1.0}modifier',
  2 => '{http://www.alfresco.org/model/content/1.0}userName',
  3 => '{http://www.alfresco.org/model/content/1.0}authorityName',
}

default['solr6']['shared-properties']['alfresco.suggestable.property'] = {
  0 => '{http://www.alfresco.org/model/content/1.0}name',
  1 => '{http://www.alfresco.org/model/content/1.0}title',
  2 => '{http://www.alfresco.org/model/content/1.0}description',
  3 => '{http://www.alfresco.org/model/content/1.0}content',
} if node['solr6']['suggestion.enabled']

default['solr6']['shared-properties']['alfresco.cross.locale.property'] = {
  0 => '{http://www.alfresco.org/model/content/1.0}name',
}

default['solr6']['shared-properties']['alfresco.cross.locale.datatype'] = {
  0 => '{http://www.alfresco.org/model/dictionary/1.0}text',
  1 => '{http://www.alfresco.org/model/dictionary/1.0}content',
  2 => '{http://www.alfresco.org/model/dictionary/1.0}mltext',
} if node['solr6']['camelCaseSearch.enabled']
