solr_home = "#{node['alfresco']['solrproperties']['data.dir.root']}"

# Sets solrcore.properties for workspace using a template
# template "solr-conf-workspace" do
#   path        "#{solr_home}/workspace-SpacesStore/conf/solrcore.properties"
#   source      "solrcore.properties.workspace.erb"
#   owner       node['tomcat']['user']
#   group       node['tomcat']['group']
#   mode        "0640"
# end

# Sets solrcore.properties for archive using a template
# template "solr-conf-archive" do
#   path        "#{solr_home}/archive-SpacesStore/conf/solrcore.properties"
#   source      "solrcore.properties.archive.erb"
#   owner       node['tomcat']['user']
#   group       node['tomcat']['group']
#   mode        "0640"
# end

template "solr-log4j" do
  path        "#{solr_home}/log4j.properties"
  source      "solr-log4j.properties.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0640"
end