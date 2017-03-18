# this recipe will run BEFORE the artifact deployer - solr6 still not downloaded

raise 'Trying to install two different Solr versions - exit' if node['alfresco']['components'].include?('solr')
raise "Alfresco version #{node['alfresco']['version']} not compatible with Solr6" if alf_version_lt?('5.2')

node.default['artifacts']['alfresco-search-services']['enabled'] = true

# creating user for Solr6
user node.default['solr6']['user'] do
  comment 'Solr6 user'
  shell '/bin/bash'
  manage_home true
  home "/home/#{node.default['solr6']['user']}"
  action :create
end

# lsof needed by start script
package 'lsof'

# Alfresco settings for Solr
# if node['alfresco']['components'].include?('haproxy')
#  node.default['solr6']['solrcore-properties']['alfresco.port'] = node['alfresco']['internal_port']
# else
#  node.default['solr6']['solrcore-properties']['alfresco.port'] = node['haproxy']['backends']['roles']['alfresco']['port']
# end

node.default['solr6']['solrcore-properties']['alfresco.port'] = if node['alfresco']['components'].include?('haproxy')
                                                                  node['alfresco']['internal_port']
                                                                else
                                                                  node['haproxy']['backends']['roles']['alfresco']['port']
                                                                end
