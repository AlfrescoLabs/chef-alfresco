# Invoke attribute recipes; if defined as attributes/*.rb files,
# The derived values (ie node['artifacts']['share']['version'] = node['alfresco']['version'])
# would not take the right value, if a calling cookbook changes (ie default['alfresco']['version'])
#
# include_recipe "tomcat::_attributes"
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

# Handle certs creation
include_recipe "alfresco::_certs"

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
      # notifies  :restart, "service[#{tomcat_service_name}]", :delayed
    end
  end
end

append_property_map = node['alfresco']['append_properties']
if append_property_map
  append_property_map.each do |propName, propValue|
    file_append "#{propName}-on-#{file_to_patch}" do
      path      file_to_patch
      line      "#{propName}=#{propValue}"
      # notifies  :restart, "service[#{tomcat_service_name}]", :delayed
    end
  end
end

# Patch nginx configurations, making sure the service runs
include_recipe 'alfresco::nginx-conf'

# Update share-config-custom.xml
tomcat_share_service_name = 'tomcat-share'
if node['tomcat']['run_single_instance']
  tomcat_share_service_name = tomcat_service_name
end

file_replace_line 'share-config-origin' do
  path      share_config
  replace   "<origin>"
  with      "<origin>#{node['alfresco']['shareproperties']['origin']}</origin>"
  not_if    "cat #{share_config} | grep '<origin>#{node['alfresco']['shareproperties']['origin']}</origin>'"
  # notifies  :restart, "service[#{tomcat_share_service_name}]", :delayed
end

file_replace_line 'share-config-referer' do
  path      share_config
  replace   "<referer>"
  with      "<referer>#{node['alfresco']['shareproperties']['referer']}</referer>"
  not_if    "cat #{share_config} | grep '<referer>#{node['alfresco']['shareproperties']['referer']}</referer>'"
  # notifies  :restart, "service[#{tomcat_share_service_name}]", :delayed
end

# TODO - why this is here and not into _tomcat-attributes.rb ?
file_append "#{node['alfresco']['home']}/tomcat.conf" do
  line "JAVA_OPTS=\"$JAVA_OPTS -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}\""
end

restart_services = node['alfresco']['restart_services']
if restart_services
  restart_services.each do |service_name|
    service service_name do
      action :nothing
    end
  end
end
