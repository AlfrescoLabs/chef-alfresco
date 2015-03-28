solr_sysconfig = "/etc/sysconfig/tomcat-solr"
solr_home_entry = "SOLR_SOLR_HOME=#{node['alfresco']['solrproperties']['data.dir.root']}"

execute "add-solr-home" do
  command "echo '#{solr_home_entry}' >> #{solr_sysconfig}"
  not_if "cat #{solr_sysconfig} | grep SOLR_SOLR_HOME"
end
