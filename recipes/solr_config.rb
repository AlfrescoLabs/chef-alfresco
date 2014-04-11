solr_home = "#{node['alfresco']['solr']['solr_home']}"

#@TODO - Update solrcore templates with latest versions

# Sets solrcore.properties for workspace using a template
template "solr-conf-workspace" do
  path        "#{solr_home}/workspace-SpacesStore/conf/solrcore.properties"
  source      "solrcore.properties.workspace.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0640"
end

# Sets solrcore.properties for archive using a template
template "solr-conf-archive" do
  path        "#{solr_home}/archive-SpacesStore/conf/solrcore.properties"
  source      "solrcore.properties.archive.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0640"
end

# 
#   template "solr-log4j" do
#     path        "#{cache_path}/solr/WEB-INF/classes/log4j.properties"
#     source      "solr-log4j.properties.erb"
#     owner       tomcat_user
#     mode        "0640"
#     subscribes  :create, "ark[solr]", :immediately
#   end
# 
# template "solr.xml" do
#   path        "#{context_dir}/solr.xml"
#   source      "solr.xml.erb"
#   owner       tomcat_user
#   mode        "0640"
#   subscribes  :create, "ruby-block[deploy-solr]", :immediately
#   subscribes  :create, "ruby-block[deploy-solr-warpath]", :immediately
# end
# 
# service "tomcat7"  do
#   action      :restart
#   subscribes  :restart, "template[solr.xml]",:immediately
# end