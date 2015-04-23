# haproxy.cfg updates
haproxy_cfg_source = node['haproxy']['cfg_source']
haproxy_cfg_cookbook = node['haproxy']['cfg_cookbook']
template '/etc/haproxy/haproxy.cfg' do
  source haproxy_cfg_source
  cookbook haproxy_cfg_cookbook
  notifies :restart, 'service[haproxy]'
end

# alfresco-global.properties updates
replace_property_map = node['alfresco']['properties']
# TODO - reuse existing attributes
file_to_patch = '/usr/share/tomcat/shared/classes/alfresco-global.properties'
tomcat_service_name = 'tomcat-alfresco'

if replace_property_map
  replace_property_map.each do |propName, propValue|
    file_replace_line "#{propName}-on-#{file_to_patch}" do
      path      file_to_patch
      replace   "#{propName}="
      with      "#{propName}=#{propValue}"
      not_if   "grep '#{propName}=#{propValue}' #{file_to_patch}"
      notifies :create, 'file[create.alfresco-global-changed.run]', :delayed
    end
  end
end

append_property_map = node['alfresco']['append_properties']
if append_property_map
  append_property_map.each do |propName, propValue|
    file_append "#{propName}-on-#{file_to_patch}" do
      path      file_to_patch
      line      "#{propName}=#{propValue}"
      notifies :create, 'file[create.alfresco-global-changed.run]', :delayed
    end
  end
end

file 'create.alfresco-global-changed.run' do
  action :nothing
  path '/var/run/alfresco-global-changed.run'
  notifies :restart, 'service[tomcat_service]', :immediately
end

file 'delete.alfresco-global-changed.run' do
  action :nothing
  path '/var/run/alfresco-global-changed.run'
end

#nginx.conf updates
nginx_cfg_source = node['nginx']['cfg_source']
nginx_cfg_cookbook = node['nginx']['cfg_cookbook']
template '/etc/nginx/nginx.conf' do
  source nginx_cfg_source
  cookbook nginx_cfg_cookbook
  notifies :restart, 'service[nginx]'
end

# Define services that need (conditional) restart
service 'tomcat_service' do
  service_name tomcat_service_name
  action :nothing
  notifies :delete, 'file[delete.alfresco-global-changed.run]', :immediately
end

service 'nginx' do
  action :nothing
end

service 'haproxy' do
  action :nothing
end
