# If there are no components that need artifact deployment,
# don't invoke artifact-deployer::default and skip alfresco::apply_amps
deploy = false

# Setting Tomcat version
node.override["tomcat"]["base_version"] = 6
if node['alfresco']['version'].start_with?("4.3") || node['alfresco']['version'].start_with?("5")
  node.override["tomcat"]["base_version"] = 7
end

# Change artifactIds for alfresco and share WARs, if
# we're using an Enterprise version (ends with a digit)
enterprise = true if Float(node['alfresco']['version'].split('').last) or node['alfresco']['version'].end_with?("SNAPSHOT") rescue false
if enterprise
  node.set['artifacts']['alfresco']['artifactId']    = "alfresco-enterprise"
  node.set['artifacts']['share']['artifactId']    = "share-enterprise"
end

include_recipe "alfresco::package-repositories"

include_recipe "tomcat::_attributes"
include_recipe "alfresco::_attributes"

if node['alfresco']['components'].include? 'postgresql'
  node.override['alfresco']['properties']['db.prefix'] = 'psql'
  node.override['alfresco']['properties']['db.port'] = '5432'
  node.override['alfresco']['properties']['db.params'] = ''
  include_recipe "alfresco::postgresql_local_server"
elsif node['alfresco']['components'].include? 'mysql'
  include_recipe "alfresco::mysql_local_server"
end

include_recipe 'java::default'

if node['alfresco']['components'].include? 'tomcat'
  include_recipe "alfresco::tomcat"
  node.default['artifacts']['alfresco-mmt']['enabled']    = true
  node.default['artifacts']['sharedclasses']['enabled']   = true
  node.default['artifacts']['catalina-jmx']['enabled'] = true
end

if node['alfresco']['components'].include? 'nginx'
  include_recipe "alfresco::nginx_install"
end

if node['alfresco']['components'].include? 'transform'
  include_recipe "alfresco::transformations"
end

if node['alfresco']['components'].include? 'spp'
  node.override['artifacts']['alfresco-spp']['enabled'] = true
else
  node.override['artifacts']['alfresco-spp']['enabled'] = false
end

if node['alfresco']['components'].include? 'aos'
  node.override['artifacts']['_vti_bin']['enabled'] = true
  node.override['artifacts']['ROOT']['enabled'] = true
else
  node.override['artifacts']['_vti_bin']['enabled'] = false
  node.override['artifacts']['ROOT']['enabled'] = false
end

if node['alfresco']['components'].include? 'googledocs'
  node.override['artifacts']['googledocs-repo']['enabled'] = true
  node.override['artifacts']['googledocs-share']['enabled'] = true
end

if node['alfresco']['components'].include? 'rm'
  node.override['artifacts']['rm']['enabled'] = true
  node.override['artifacts']['rm-share']['enabled'] = true
end

if node['alfresco']['components'].include? 'media'
  if node['media']['install.content.services']
    include_recipe 'alfresco::media-content-services'
    node.default['alfresco']['install.activemq'] = true
  else
    node.default['alfresco']['install.activemq'] = false
  end
  node.default['artifacts']['media']['enabled'] = true
  node.default['artifacts']['media-repo']['enabled'] = true
  node.default['artifacts']['media-repo-messaging']['enabled'] = true
  node.default['artifacts']['media-share']['enabled'] = true
end

if node['alfresco']['components'].include? 'analytics'
  node.default['alfresco']['install.activemq'] = true
  node.override['artifacts']['analytics']['enabled'] = true
  node.override['artifacts']['analytics-repo']['enabled'] = true
  node.override['artifacts']['analytics-share']['enabled'] = true
  node.override['artifacts']['alfresco-pentaho']['enabled'] = true
end

if node.default['alfresco']['install.activemq']
  include_recipe 'activemq::default'
end

if node['alfresco']['components'].include? 'repo'
  deploy = true
  include_recipe "alfresco::_attributes_repo"

  if node['alfresco']['generate.global.properties'] == true
    node.override['artifacts']['sharedclasses']['properties']['alfresco-global.properties'] = node['alfresco']['properties']
  end

  if node['alfresco']['generate.repo.log4j.properties'] == true
    node.override['artifacts']['sharedclasses']['properties']['alfresco/log4j.properties'] = node['alfresco']['log4j']
  end

  include_recipe "alfresco::repo_config"
end

if node['alfresco']['components'].include? 'share'
  deploy = true
  include_recipe "alfresco::_attributes_share"

  if node['alfresco']['patch.share.config.custom'] == true
    node.override['artifacts']['sharedclasses']['terms']['alfresco/web-extension/share-config-custom.xml'] = node['alfresco']['properties']
  end

  include_recipe "alfresco::share_config"
end

if node['alfresco']['components'].include? 'solr'
  deploy = true
  include_recipe "alfresco::_attributes_solr"
end

if node['alfresco']['components'].include? 'tomcat'
  include_recipe "alfresco::tomcat-instance-config"
end

if node['alfresco']['components'].include? 'haproxy'
  include_recipe "openssl::default"
  include_recipe "alfresco::haproxy_install"
end

# Always run artifact-deployer
include_recipe "artifact-deployer::default"

if deploy == true
  include_recipe "alfresco::apply_amps"
end

if node['alfresco']['components'].include? 'analytics'
  include_recipe "alfresco::analytics"
end

if node['alfresco']['components'].include? 'rsyslog'
  include_recipe "rsyslog::default"
end

# TODO - to fix temporary the lack of nossl distro for alfresco war 5.0.d
# needs restart, before patching
#
if node['alfresco']['components'].include? 'tomcat' and node['alfresco']['web_xml_nossl_patch']
  cookbook_file "/usr/local/bin/nossl-patch.sh" do
    source "nossl-patch.sh"
    mode "0755"
  end
  execute "run-nossl-patch.sh" do
    command "/usr/local/bin/nossl-patch.sh"
  end
end


alfresco_start    = node["alfresco"]["start_service"]
restart_services  = node['alfresco']['restart_services']
restart_action    = node['alfresco']['restart_action']
if alfresco_start and node['alfresco']['components'].include? 'tomcat'
  restart_services.each do |service_name|
    service service_name  do
      action    restart_action
    end
  end
end
