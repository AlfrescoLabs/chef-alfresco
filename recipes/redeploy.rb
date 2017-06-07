# Invoke attribute recipes; if defined as attributes/*.rb files,
# The derived values (ie node['artifacts']['share']['version'] = node['alfresco']['version'])
# would not take the right value, if a calling cookbook changes (ie default['alfresco']['version'])
#
include_recipe 'alfresco::initialise_libreoffice' if node['libreoffice']['initialise']
include_recipe 'tomcat::_attributes'
include_recipe 'alfresco::_common-attributes'
include_recipe 'alfresco::_tomcat-attributes'
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

restart_tomcat_services = []

if node['alfresco']['components'].include? 'repo'
  restart_tomcat_services << 'tomcat-alfresco'
  # alfresco-global.properties updates
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
  restart_tomcat_services << 'tomcat-share'
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

if node['alfresco']['components'].include? 'solr'
  restart_tomcat_services << 'tomcat-solr'
end

# TODO: - why this is here and not into _tomcat-attributes.rb ?
file_append '/etc/tomcat/tomcat.conf' do
  line "JAVA_OPTS=\"$JAVA_OPTS -Djava.rmi.server.hostname=#{node['alfresco']['rmi_server_hostname']}\""
  only_if 'ls /etc/tomcat/tomcat.conf'
end

restart_tomcat_services.each do |service|
  component = service.gsub('tomcat-', '')
  component = component == 'alfresco' ? 'repo' : component
  template "/etc/sysconfig/#{service}" do
    source 'tomcat/sysconfig.erb'
    variables(
      user: 'tomcat',
      home: "/usr/share/#{service}",
      base: "/usr/share/#{service}",
      java_options: node['alfresco']["#{component}_tomcat_instance"]['java_options'],
      use_security_manager: false,
      tmp_dir: "/var/cache/#{service}/temp",
      catalina_options: '',
      endorsed_dir: '/usr/share/tomcat/lib/endorsed'
    )
    owner 'root'
    group 'root'
    mode '0644'
  end
end

# Patching sysconfig file with XMX values
memory = {}
memory['alfresco'] = ((node['memory']['total'].to_i * node['alfresco']['repo_tomcat_instance']['xmx_ratio']).floor / 1024).to_s
memory['share'] = ((node['memory']['total'].to_i * node['alfresco']['share_tomcat_instance']['xmx_ratio']).floor / 1024).to_s
memory['solr'] = ((node['memory']['total'].to_i * node['alfresco']['solr_tomcat_instance']['xmx_ratio']).floor / 1024).to_s
memory['activiti'] = ((node['memory']['total'].to_i * node['alfresco']['activiti_tomcat_instance']['xmx_ratio']).floor / 1024).to_s

memory.each do |instance_name, xmx|
  sed_command = "sed -i -E \"s/(.+Xmx)([0-9]*)(m+)/\\1#{xmx}\\3/\" /etc/sysconfig/tomcat-#{instance_name}"
  execute 'patch-tomcat-sysconfig' do
    command sed_command
    only_if "ls /etc/sysconfig/tomcat-#{instance_name}"
  end
end

restart_tomcat_services.each do |service_name|
  service service_name do
    action :restart
  end
end

if node['alfresco']['components'].include?('solr6')
  solr_memory = "#{(node['memory']['total'].to_i * node['solr6']['xmx_ratio']).floor / 1024}m"
  node.default['solr6']['solr-in-sh']['SOLR_HEAP'] = solr_memory

  solr_home = node['solr6']['solr-in-sh']['SOLR_HOME']

  ["#{solr_home}/alfresco","#{solr_home}/archive"].each do | dir_to_delete |
    directory dir_to_delete do
      recursive true
      action :delete
      only_if { Dir.exist?(dir_to_delete) }
    end
  end

  config_files = ["#{solr_home}/conf/shared.properties", "#{node['solr6']['solr_env_dir']}/solr.in.sh","#{solr_home}/templates/rerank/conf/solrcore.properties"]

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
    action [:enable, :restart]
  end

end
