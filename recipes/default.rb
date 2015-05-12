# If there are no components that need artifact deployment,
# don't invoke artifact-deployer::default and skip alfresco::apply_amps
deploy = false

# Main Alfresco attributes; based on these many others are calculated/extracted
# For example tomcat version
node.default['alfresco']['groupId'] = "org.alfresco"
node.default['alfresco']['version'] = "5.0.d"

# Setting Java and Tomcat versions
node.override["tomcat"]["base_version"] = 6
node.override['java']['jdk_version'] = '6'
if node['alfresco']['version'].start_with?("4.3") || node['alfresco']['version'].start_with?("5")
  node.override["tomcat"]["base_version"] = 7
  node.override['java']['jdk_version'] = '7'
end

if node['platform_family'] == "rhel"
  include_recipe "yum-epel::default"
end

include_recipe "tomcat::_attributes"
include_recipe "alfresco::_attributes"

if node['alfresco']['components'].include? 'postgresql'
  node.override['alfresco']['properties']['db.prefix'] = 'psql'
  node.override['alfresco']['properties']['db.port'] = '5432'
  node.override['alfresco']['properties']['db.params'] = ''
  include_recipe "alfresco::postgresql_local_server"
else
  include_recipe "alfresco::mysql_local_server"
end

# Any Alfresco node needs java; attributes are set in alfresco::_attributes
include_recipe 'java::default'

if node['alfresco']['components'].include? 'tomcat'
  include_recipe "alfresco::tomcat"
end

if node['alfresco']['components'].include? 'nginx'
  include_recipe "alfresco::nginx_install"
end

if node['alfresco']['components'].include? 'transform'
  include_recipe "alfresco::3rdparty"
end

if node['alfresco']['components'].include? 'spp'
  node.override['artifacts']['alfresco-spp']['enabled'] = true
else
  node.override['artifacts']['alfresco-spp']['enabled'] = false
end

if node['alfresco']['components'].include? 'googledocs'
  node.override['artifacts']['googledocs-repo']['enabled'] = true
  node.override['artifacts']['googledocs-share']['enabled'] = true
end

if node['alfresco']['components'].include? 'rm'
  node.override['artifacts']['rm']['enabled'] = true
  node.override['artifacts']['rm-share']['enabled'] = true
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

  # TODO - update README, as share-log4j.properties is not needed anymore
  # alfresco and share use the same shared/classes/alfresco/log4j.properties
  # if node['alfresco']['generate.share.log4j.properties'] == true
  #   node.override['artifacts']['sharedclasses']['properties']['alfresco/web-extension/share-log4j.properties'] = node['alfresco']['share-log4j']
  # end

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
  include_recipe 'haproxy::install_package'
  include_recipe "openssl::default"
  include_recipe "alfresco::haproxy_install"
end

if deploy == true
  include_recipe "artifact-deployer::default"
  include_recipe "alfresco::apply_amps"
end

if node['alfresco']['components'].include? 'rsyslog'
  include_recipe "rsyslog::client"
end

# TODO - Re-enable after checking attribute defaults and integrate
# with multi-homed tomcat installation
# restart_services  = node['alfresco']['restart_services']
# restart_action    = node['alfresco']['restart_action']
# restart_services.each do |service_name|
#   service service_name  do
#     action    restart_action
#   end
# end
