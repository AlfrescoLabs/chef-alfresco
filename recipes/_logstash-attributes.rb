
node.default['logstash-forwarder']['items']['alfresco-repo-catalina']['paths'] = ["#{node['alfresco']['home']}#{"/alfresco" unless node['tomcat']['run_single_instance']}/logs/catalina.out.*"]
node.default['logstash-forwarder']['items']['alfresco-repo']['paths'] = ["#{node['alfresco']['home']}#{"/alfresco" unless node['tomcat']['run_single_instance']}/logs/alfresco.log"]
node.default['logstash-forwarder']['items']['alfresco-share-catalina']['paths'] = ["#{node['alfresco']['home']}#{"/share" unless node['tomcat']['run_single_instance']}/logs/catalina.out.*"]
node.default['logstash-forwarder']['items']['alfresco-share']['paths'] = ["#{node['alfresco']['home']}#{"/share" unless node['tomcat']['run_single_instance']}/logs/share.log"]
node.default['logstash-forwarder']['items']['alfresco-solr-catalina']['paths'] = ["#{node['alfresco']['home']}#{"/solr" unless node['tomcat']['run_single_instance']}/logs/catalina.out.*"]
node.default['logstash-forwarder']['items']['alfresco-solr']['paths'] = ["#{node['alfresco']['home']}#{"/solr" unless node['tomcat']['run_single_instance']}/logs/solr.log"]
