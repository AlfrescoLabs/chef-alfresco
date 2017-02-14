# Alfresco Search Service artifact to donwload
default['artifacts']['alfresco-search-services']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-search-services']['artifactId'] = 'alfresco-search-services'
default['artifacts']['alfresco-search-services']['type'] = 'zip'
default['artifacts']['alfresco-search-services']['owner'] = 'root'
default['artifacts']['alfresco-search-services']['destinationName'] = node['solr6']['dir_name']
default['artifacts']['alfresco-search-services']['enabled'] = false
default['artifacts']['alfresco-search-services']['version'] = '1.0.b'
default['artifacts']['alfresco-search-services']['unzip'] = true
default['artifacts']['alfresco-search-services']['destination'] = node['solr6']['installation-path']
