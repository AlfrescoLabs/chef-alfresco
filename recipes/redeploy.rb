# Invoke attribute recipes; if defined as attributes/*.rb files,
# The derived values (ie node['artifacts']['share']['version'] = node['alfresco']['version'])
# would not take the right value, if a calling cookbook changes (ie default['alfresco']['version'])
#
include_recipe "tomcat::_attributes"
include_recipe "alfresco::_common-attributes"
include_recipe "alfresco::_tomcat-attributes"
include_recipe "alfresco::_alfrescoproperties-attributes"
include_recipe "alfresco::_repo-attributes"
include_recipe "alfresco::_share-attributes"
include_recipe "alfresco::_solr-attributes"
include_recipe "alfresco::_rm-attributes"
include_recipe "alfresco::_googledocs-attributes"
include_recipe "alfresco::_aos-attributes"
include_recipe "alfresco::_media-attributes"
include_recipe "alfresco::_analytics-attributes"

# DEPRECATED in favour of haproxy::default
#
# haproxy_cfg_source = node['haproxy']['cfg_source']
# haproxy_cfg_cookbook = node['haproxy']['cfg_cookbook']
# template '/etc/haproxy/haproxy.cfg' do
#   source haproxy_cfg_source
#   cookbook haproxy_cfg_cookbook
#   notifies :restart, 'service[haproxy]'
# end
include_recipe 'haproxy::default'

# Set haproxy.cfg custom template
# TODO - fix it upstream and send PR
haproxy_cfg_source = node['haproxy']['conf_template_source']
haproxy_cfg_cookbook = node['haproxy']['conf_cookbook']
r = resources(template: "#{node['haproxy']['conf_dir']}/haproxy.cfg")
r.source(haproxy_cfg_source)
r.cookbook(haproxy_cfg_cookbook)

# alfresco-global.properties updates
replace_property_map = node['alfresco']['properties']
# TODO - reuse existing attributes
file_to_patch = "#{node['alfresco']['home']}/shared/classes/alfresco-global.properties"
share_config = "#{node['alfresco']['home']}/shared/classes/alfresco/web-extension/share-config-custom.xml"
tomcat_service_name = 'tomcat-alfresco'

if replace_property_map
  replace_property_map.each do |propName, propValue|
    file_replace_line "#{propName}-on-#{file_to_patch}" do
      path      file_to_patch
      replace   "#{propName}="
      with      "#{propName}=#{propValue}"
      not_if   "grep '#{propName}=#{propValue}' #{file_to_patch}"
      notifies  :restart, "service[#{tomcat_service_name}]", :delayed
    end
  end
end

append_property_map = node['alfresco']['append_properties']
if append_property_map
  append_property_map.each do |propName, propValue|
    file_append "#{propName}-on-#{file_to_patch}" do
      path      file_to_patch
      line      "#{propName}=#{propValue}"
      notifies  :restart, "service[#{tomcat_service_name}]", :delayed
    end
  end
end

# DEPRECATED in favour of nginx::commons_conf
#
# nginx_cfg_source = node['nginx']['cfg_source']
# nginx_cfg_cookbook = node['nginx']['cfg_cookbook']
# template '/etc/nginx/nginx.conf' do
#   source nginx_cfg_source
#   cookbook nginx_cfg_cookbook
#   notifies :restart, 'service[nginx]'
# end
include_recipe 'nginx::commons_conf'

# Update share-config-custom.xml
tomcat_share_service_name = 'tomcat-share'
if node['tomcat']['run_base_instance']
  tomcat_share_service_name = tomcat_service_name
end

file_replace_line 'share-config-origin' do
  path      share_config
  replace   "<origin>"
  with      "<origin>#{node['alfresco']['shareproperties']['origin']}</origin>"
  not_if    "cat #{share_config} | grep '<origin>#{node['alfresco']['shareproperties']['origin']}</origin>'"
  notifies  :restart, "service[#{tomcat_share_service_name}]", :delayed
end

file_replace_line 'share-config-referer' do
  path      share_config
  replace   "<referer>"
  with      "<referer>#{node['alfresco']['shareproperties']['referer']}</referer>"
  not_if    "cat #{share_config} | grep '<referer>#{node['alfresco']['shareproperties']['referer']}</referer>'"
  notifies  :restart, "service[#{tomcat_share_service_name}]", :delayed
end

# TODO - why this is here and not into _tomcat-attributes.rb ?
host = node['alfresco']['public_hostname']
file_append '/etc/tomcat/tomcat.conf' do
  line "JAVA_OPTS=\"$JAVA_OPTS -Djava.rmi.server.hostname=#{host}\""
end

%w( tomcat tomcat-alfresco tomcat-share tomcat-solr ).each do |service_name|
  service service_name do
    action :nothing
  end
end

# Needed by nginx::commons_conf
service 'nginx' do
  action :nothing
end
