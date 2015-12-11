if node['alfresco']['log.json.enabled']
  node.default['logstash-forwarder']['items']['alfresco-repo']['paths'] = ['/usr/share/tomcat-instances/alfresco/logs/alfresco.log.json']
  node.default['logstash-forwarder']['items']['alfresco-repo']['type'] = 'json'
  node.default['logstash-forwarder']['items']['alfresco-share']['paths'] = ['/usr/share/tomcat-instances/alfresco/logs/alfresco.log.json']
  node.default['logstash-forwarder']['items']['alfresco-share']['type'] = 'json'
  node.default['logstash-forwarder']['items']['solr-catalina']['paths'] = ['/usr/share/tomcat-instances/solr/logs/solr.log.json']
  node.default['logstash-forwarder']['items']['solr-catalina']['type'] = 'json'
end

log_foward_items = node['logstash-forwarder']['items']

if log_foward_items
  include_recipe 'logstash-forwarder'

  log_foward_items.each do |itemName,itemProps|
    log_forward itemName do
      paths itemProps['paths']
      fields types: itemProps['type']
    end
  end
end
