
include_recipe 'alfresco-appserver::default'

include_recipe 'alfresco::initialise_libreoffice' if node['libreoffice']['initialise']
include_recipe 'alfresco::_common-attributes'
include_recipe 'alfresco::_alfrescoproperties-attributes'
include_recipe 'alfresco::_repo-attributes'
include_recipe 'alfresco::_share-attributes'
include_recipe 'alfresco::_solr-attributes'
include_recipe 'alfresco::_googledocs-attributes'
include_recipe 'alfresco::_aos-attributes'
include_recipe 'alfresco::_media-attributes'
include_recipe 'alfresco::_analytics-attributes'

# Setup /etc/hosts file
include_recipe 'commons::hosts'

# Handle certs creation
include_recipe 'alfresco::_certs'

# Enabling encrypted communication to the DB (rds as of now)
include_recipe 'alfresco::db-ssl' if node['alfresco']['db_ssl_enabled'] == true

if node['alfresco']['components'].include? 'repo'
  replace_property_map = node['alfresco']['properties']
  # TODO: - reuse existing attributes
  file_to_patch = "#{node['alfresco']['home']}/shared/classes/alfresco-global.properties"
  share_config = "#{node['alfresco']['home']}/shared/classes/alfresco/web-extension/share-config-custom.xml"

  if replace_property_map
    replace_property_map.each do |prop_name, prop_value|
      replace_or_add "#{prop_name}-on-#{file_to_patch}" do
        path file_to_patch
        pattern "#{prop_name}="
        line "#{prop_name}=#{prop_value}"
      end
    end
  end

  append_property_map = node['alfresco']['append_properties']
  if append_property_map
    append_property_map.each do |prop_name, prop_value|
      file_append "#{prop_name}-on-#{file_to_patch}" do
        path file_to_patch
        line "#{prop_name}=#{prop_value}"
      end
    end
  end
end

# Patch nginx configurations, making sure the service runs
include_recipe 'alfresco-webserver::start' if node['alfresco']['components'].include? 'nginx'

if node['alfresco']['components'].include? 'share'
  # Update share-config-custom.xml
  file_replace_line 'share-config-origin' do
    path      share_config
    replace   '<origin>'
    with      "<origin>#{node['alfresco']['shareproperties']['origin']}</origin>"
    not_if    "cat #{share_config} | grep '<origin>#{node['alfresco']['shareproperties']['origin']}</origin>'"
  end

  file_replace_line 'share-config-referer' do
    path      share_config
    replace   '<referer>'
    with      "<referer>#{node['alfresco']['shareproperties']['referer']}</referer>"
    not_if    "cat #{share_config} | grep '<referer>#{node['alfresco']['shareproperties']['referer']}</referer>'"
  end

  template "#{node['alfresco']['home']}-share/conf/Catalina/localhost/share.xml" do
    source 'tomcat/share.xml.erb'
    owner node['alfresco']['user']
    owner node['tomcat']['group']
    only_if { !node['tomcat']['memcached_nodes'].empty? }
  end
end

alfresco_services 'Starting the required services' do
  start_services true
end

if node['alfresco']['components'].include?('solr6')
  solr_memory = "#{(node['memory']['total'].to_i * node['solr6']['xmx_ratio']).floor / 1024}m"
  node.default['solr6']['solr-in-sh']['SOLR_HEAP'] = solr_memory

  solr_home = node['solr6']['solr-in-sh']['SOLR_HOME']

  config_files = ["#{solr_home}/conf/shared.properties", "#{node['solr6']['solr_env_dir']}/solr.in.sh"]

  # replacing configuration files
  config_files.each do |config_file|
    filename = File.basename(config_file)
    template config_file do
      source "solr6/#{filename}.erb"
      action :create
      only_if { Dir.exist?(File.dirname(config_file)) }
    end
  end

  service 'solr' do
    action :restart
  end

end
