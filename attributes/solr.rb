default['alfresco']['solrconf']['groupId']    = "org.alfresco"
default['alfresco']['solrconf']['artifactId'] = "alfresco-solr"
default['alfresco']['solrconf']['version']    = node['alfresco']['version']

default['alfresco']['solr']['alfresco_host']    = node['alfresco']['url']['repo']['host']
default['alfresco']['solr']['alfresco_context'] = "/#{node['alfresco']['url']['repo']['context']}"
default['alfresco']['solr']['alfresco_port']    = node['alfresco']['url']['repo']['port']
default['alfresco']['solr']['alfresco_portssl'] = node['alfresco']['default_portssl']
default['alfresco']['solr']['solr_home']        = "#{node['alfresco']['root_dir']}/solr_home"
default['alfresco']['solr']['war_filename']     = "apache-solr-1.4.1.war"
