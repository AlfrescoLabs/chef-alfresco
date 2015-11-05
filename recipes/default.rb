# Setting Tomcat version
# Needs to be done before invoking "tomcat::_attributes"
# TODO - try using node.default or node.set
node.override["tomcat"]["base_version"] = 7

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

# If there are no components that need artifact deployment,
# don't invoke apply_amps
apply_amps = false

# If there is no media nor analytics, don't install activemq
install_activemq = false

# Install/configure awscli, as it's used by haproxy ec2 discovery
include_recipe "artifact-deployer::awscli"

# [old implementation]
# Change artifactIds for alfresco and share WARs, if
# we're using an Enterprise version (ends with a digit)
# enterprise = true if Float(node['alfresco']['version'].split('').last) or node['alfresco']['version'].end_with?("SNAPSHOT") rescue false
# [New implementation]
if node['alfresco']['edition'] == 'enterprise'
  node.default['artifacts']['alfresco']['artifactId']    = "alfresco-enterprise"
  unless node['alfresco']['version'].start_with?("5.1")
    node.default['artifacts']['share']['artifactId']    = "share-enterprise"
  end
end

unless node['alfresco']['enable.web.xml.nossl.patch'] and node['alfresco']['edition'] == 'enterprise'
  node.default['artifacts']['alfresco']['classifier'] = 'nossl'
end

if node['alfresco']['version'].start_with?("5.1")
  node.default['artifacts']['share-services']['enabled'] = true
  node.default['artifacts']['ROOT']['artifactId'] = "alfresco-server-root"
end

include_recipe "alfresco::package-repositories"

if node['alfresco']['components'].include? 'postgresql'
  include_recipe "alfresco::postgresql-local-server"
elsif node['alfresco']['components'].include? 'mysql'
  include_recipe "alfresco::mysql-local-server"
end

include_recipe 'java::default'

if node['alfresco']['components'].include? 'yourkit'
  include_recipe "alfresco::yourkit"
end

if node['alfresco']['components'].include? 'tomcat'
  include_recipe "alfresco::tomcat"
end

if node['alfresco']['components'].include? 'nginx'
  include_recipe "alfresco::nginx"
end

if node['alfresco']['components'].include? 'transform'
  include_recipe "alfresco::transformations"
end

if node['alfresco']['components'].include? 'aos'
  include_recipe "alfresco::aos"
end

if node['alfresco']['components'].include? 'googledocs'
  include_recipe "alfresco::googledocs"
end

if node['alfresco']['components'].include? 'rm'
  include_recipe "alfresco::rm"
end

if node['media']['install.content.services']
  include_recipe 'alfresco::media-content-services'
  install_activemq = true
end

if node['alfresco']['components'].include? 'media'
  include_recipe 'alfresco::media-alfresco'
end

if node['alfresco']['components'].include? 'repo'
  apply_amps = true
  include_recipe "alfresco::repo"
end

if node['alfresco']['components'].include? 'share'
  apply_amps = true
  include_recipe "alfresco::share"
end

if node['alfresco']['components'].include? 'solr'
  include_recipe "alfresco::solr"
end

if node['alfresco']['components'].include? 'haproxy'
  include_recipe 'alfresco::haproxy'
end

if node['alfresco']['components'].include? 'tomcat'
  include_recipe "alfresco::tomcat-instance-config"
end

if node['alfresco']['components'].include? 'haproxy'
  include_recipe "openssl::default"
  include_recipe "alfresco::haproxy"
end

include_recipe "artifact-deployer::default"

if apply_amps
  include_recipe "alfresco::apply-amps"
end

# This must go after Alfresco installation
if node['alfresco']['components'].include? 'analytics'
  include_recipe "alfresco::analytics"
  install_activemq = true
end

if install_activemq
  include_recipe 'activemq::default'
end

if node['alfresco']['components'].include? 'rsyslog'
  include_recipe "rsyslog::default"
end

if node['alfresco']['components'].include? 'logstash-forwarder'
  include_recipe "alfresco::logstash-forwarder"
end

# TODO - This should go... as soon as Alfresco Community NOSSL war is shipped
# Patching web.xml to configure Alf-Solr comms to none (instead of https)
#
if node['alfresco']['components'].include? 'tomcat' and node['alfresco']['enable.web.xml.nossl.patch']
  cookbook_file "/usr/local/bin/nossl-patch.sh" do
    source "nossl-patch.sh"
    mode "0755"
  end
  execute "run-nossl-patch.sh" do
    command "/usr/local/bin/nossl-patch.sh"
  end
end

# Restarting services, if enabled
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
