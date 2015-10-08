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
