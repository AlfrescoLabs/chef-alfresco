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

# Setup /etc/hosts file
include_recipe "commons::hosts"

# Handle certs creation
include_recipe "alfresco::_certs"

restart_tomcat_services = []

if node['alfresco']['components'].include? 'repo'
  restart_tomcat_services << "tomcat-alfresco"
  # alfresco-global.properties updates
  replace_property_map = node['alfresco']['properties']
  # TODO - reuse existing attributes
  file_to_patch = "#{node['alfresco']['home']}/shared/classes/alfresco-global.properties"
  share_config = "#{node['alfresco']['home']}/shared/classes/alfresco/web-extension/share-config-custom.xml"

  if replace_property_map
    replace_property_map.each do |propName, propValue|
      replace_or_add "#{propName}-on-#{file_to_patch}" do
        path file_to_patch
        pattern "#{propName}="
        line "#{propName}=#{propValue}"
      end
    end
  end

  append_property_map = node['alfresco']['append_properties']
  if append_property_map
    append_property_map.each do |propName, propValue|
      file_append "#{propName}-on-#{file_to_patch}" do
        path file_to_patch
        line "#{propName}=#{propValue}"
      end
    end
  end
end

# Patch nginx configurations, making sure the service runs
include_recipe 'alfresco::nginx-conf' if node['alfresco']['components'].include? 'nginx'

if node['alfresco']['components'].include? 'share'
  restart_tomcat_services << "tomcat-share"
  # Update share-config-custom.xml
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
end

if node['alfresco']['components'].include? 'solr'
  restart_tomcat_services << "tomcat-solr"
end

# TODO - why this is here and not into _tomcat-attributes.rb ?
file_append '/etc/tomcat/tomcat.conf' do
  line "JAVA_OPTS=\"$JAVA_OPTS -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}\""
  only_if "ls /etc/tomcat/tomcat.conf"
end

# Patching sysconfig file with XMX values
memory = {}
memory['alfresco'] = ((node['memory']['total'].to_i * node['alfresco']['repo_tomcat_instance']['xmx_ratio'] ).floor / 1024).to_s
memory['share'] = ((node['memory']['total'].to_i * node['alfresco']['share_tomcat_instance']['xmx_ratio'] ).floor / 1024).to_s
memory['solr'] = ((node['memory']['total'].to_i * node['alfresco']['solr_tomcat_instance']['xmx_ratio'] ).floor / 1024).to_s
memory['activiti'] = ((node['memory']['total'].to_i * node['alfresco']['activiti_tomcat_instance']['xmx_ratio'] ).floor / 1024).to_s

memory.each do |instance_name,xmx|
 sed_command = "sed -i -E \"s/(.+Xmx)([0-9]*)(m+)/\\1"+xmx+"\\3/\" /etc/sysconfig/tomcat-#{instance_name}"
 execute "patch-tomcat-sysconfig" do
   command sed_command
   only_if "ls /etc/sysconfig/tomcat-#{instance_name}"
 end
end

restart_tomcat_services.each do |service_name|
  service service_name do
    action :restart
  end
end
