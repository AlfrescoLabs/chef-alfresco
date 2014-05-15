# solr_home = "#{node['alfresco']['solrproperties']['data.dir.root']}"
# 
# template "solr-log4j" do
#   path        "#{solr_home}/log4j.properties"
#   source      "solr-log4j.properties.erb"
#   owner       node['tomcat']['user']
#   group       node['tomcat']['group']
#   mode        "0640"
# end