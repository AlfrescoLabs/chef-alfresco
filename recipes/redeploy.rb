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

if replace_property_map
  replace_property_map.each do |propName, propValue|
    file_replace_line "#{propName}-on-#{file_to_patch}" do
      path      file_to_patch
      replace   "#{propName}="
      with      "#{propName}=#{propValue}"
      not_if   "grep '#{propName}=#{propValue}' #{file_to_patch}"
    end
  end
end

append_property_map = node['alfresco']['append_properties']
if append_property_map
  append_property_map.each do |propName, propValue|
    file_append "#{propName}-on-#{file_to_patch}" do
      path      file_to_patch
      line      "#{propName}=#{propValue}"
    end
  end
end

# Patch nginx configurations, making sure the service runs
include_recipe 'alfresco::nginx-conf'

file_replace_line 'share-config-origin' do
  path      share_config
  replace   "<origin>"
  with      "<origin>#{node['alfresco']['shareproperties']['origin']}</origin>"
  not_if    "cat #{share_config} | grep '<origin>#{node['alfresco']['shareproperties']['origin']}</origin>'"
end

file_replace_line 'share-config-referer' do
  path      share_config
  replace   "<referer>"
  with      "<referer>#{node['alfresco']['shareproperties']['referer']}</referer>"
  not_if    "cat #{share_config} | grep '<referer>#{node['alfresco']['shareproperties']['referer']}</referer>'"
end

# TODO - why this is here and not into _tomcat-attributes.rb ?
file_append "#{node['alfresco']['home']}/tomcat.conf" do
  line "JAVA_OPTS=\"$JAVA_OPTS -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}\""
end

node.set['supervisor']['start'] = true
include_recipe 'alfresco::supervisor'
