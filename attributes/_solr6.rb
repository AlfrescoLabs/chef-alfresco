default['solr6']['user'] = 'solr'
default['solr6']['installation-path'] = '/opt'
default['solr6']['suggestion.enabled'] = false
default['solr6']['camelCaseSearch.enabled'] = false
default['solr6']['solr_env_dir'] = '/etc/default'
default['solr6']['solr.baseurl'] = '/solr'

# Alfresco Search Service artifact to donwload
default['artifacts']['alfresco-search-services']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-search-services']['type'] = 'zip'
default['artifacts']['alfresco-search-services']['owner'] = 'root'
default['artifacts']['alfresco-search-services']['enabled'] = false
if node['alfresco']['edition'] == 'community'
  default['artifacts']['alfresco-search-services']['version'] = '1.0.b'
else
  default['artifacts']['alfresco-search-services']['version'] = '1.0.0-SNAPSHOT'
end
default['artifacts']['alfresco-search-services']['unzip'] = true
default['artifacts']['alfresco-search-services']['destination'] = node['solr6']['installation-path']
default['artifacts']['alfresco-search-services']['artifactId'] = 'alfresco-search-services'
