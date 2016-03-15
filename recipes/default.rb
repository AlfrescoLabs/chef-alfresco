# Setting Tomcat version
# Needs to be done before invoking "tomcat::_attributes"
# TODO - try using node.default or node.set
# node.override["tomcat"]["base_version"] = 7

# Invoke attribute recipes; if defined as attributes/*.rb files,
# The derived values (ie node['artifacts']['share']['version'] = node['alfresco']['version'])
# would not take the right value, if a calling cookbook changes (ie default['alfresco']['version'])
#
include_recipe "alfresco::_common-attributes"
include_recipe "alfresco::_tomcat-attributes"
include_recipe "alfresco::_activiti-attributes"
include_recipe "alfresco::_alfrescoproperties-attributes"
include_recipe "alfresco::_repo-attributes"
include_recipe "alfresco::_share-attributes"
include_recipe "alfresco::_solr-attributes"
include_recipe "alfresco::_rm-attributes"
include_recipe "alfresco::_googledocs-attributes"
include_recipe "alfresco::_aos-attributes"
include_recipe "alfresco::_media-attributes"
include_recipe "alfresco::_analytics-attributes"
include_recipe "alfresco::_logstash-attributes"
include_recipe "alfresco::_supervisor-attributes"

# If there are no components that need artifact deployment,
# don't invoke apply_amps
apply_amps = true

# If there is no media nor analytics, don't install activemq
install_activemq = false

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

#Chef::Log.warn("this is my condition2 #{node['alfresco']['enable.web.xml.nossl.patch'] or node['alfresco']['edition'] == 'enterprise'}")
unless node['alfresco']['enable.web.xml.nossl.patch'] or node['alfresco']['edition'] == 'enterprise'
  node.default['artifacts']['alfresco']['classifier'] = 'nossl'
end

if node['alfresco']['version'].start_with?("5.1")
  node.default['amps']['repo']['share-services']['enabled'] = true
  node.default['artifacts']['ROOT']['artifactId'] = "alfresco-server-root"
end

include_recipe "alfresco::package-repositories"
include_recipe 'java::default'

if node['alfresco']['components'].include? 'postgresql'
  include_recipe "alfresco::postgresql-local-server"
elsif node['alfresco']['components'].include? 'mysql'
  include_recipe "alfresco::mysql-local-server"
end

include_recipe "alfresco::yourkit" if node['alfresco']['components'].include? 'yourkit'
include_recipe "alfresco::tomcat" if node['alfresco']['components'].include? 'tomcat'

##############

include_recipe "alfresco::nginx" if node['alfresco']['components'].include? 'nginx'
include_recipe "alfresco::transformations" if node['alfresco']['components'].include? 'transform'
include_recipe "alfresco::aos" if node['alfresco']['components'].include? 'aos'
include_recipe "alfresco::googledocs" if node['alfresco']['components'].include? 'googledocs'
include_recipe "alfresco::rm" if node['alfresco']['components'].include? 'rm'

if node['media']['install.content.services']
  include_recipe 'alfresco::media-content-services'
  install_activemq = true
end

include_recipe 'alfresco::media-alfresco' if node['alfresco']['components'].include? 'media'

if node['alfresco']['components'].include? 'repo'
  apply_amps = true
  include_recipe "alfresco::repo"
end

if node['alfresco']['components'].include? 'share'
  apply_amps = true
  include_recipe "alfresco::share"
end

include_recipe "alfresco::solr" if node['alfresco']['components'].include? 'solr'
include_recipe "alfresco::tomcat-instance-config" if node['alfresco']['components'].include? 'tomcat'

if node['alfresco']['components'].include? 'haproxy'
  include_recipe "openssl::default"
  include_recipe "alfresco::haproxy"
end

maven_setup 'setup maven' do
  maven_home node['maven']['m2_home']
  only_if {node['alfresco']['install_maven']}
end

artifact 'deploy artifacts'

apply_amps 'apply alfresco and share amps' do
  alfresco_root "#{node['alfresco']['home']}#{"/alfresco" unless node['tomcat']['run_single_instance']}"
  share_root "#{node['alfresco']['home']}#{"/share" unless node['tomcat']['run_single_instance']}"
  unixUser node['alfresco']['user']
  unixGroup node['tomcat']['group']
  only_if { apply_amps }
  only_if { node['amps'] }
end

# This must go after Alfresco installation
if node['alfresco']['components'].include? 'analytics'
  include_recipe "alfresco::analytics"
  install_activemq = true
end

include_recipe 'activemq::default' if install_activemq
include_recipe "rsyslog::default" if node['alfresco']['components'].include? 'rsyslog'
include_recipe "alfresco::logstash-forwarder" if node['alfresco']['components'].include? 'logstash-forwarder'
include_recipe "alfresco::activiti" if node['alfresco']['components'].include? 'activiti'

# TODO - This should go... as soon as Alfresco Community NOSSL war is shipped
# Patching web.xml to configure Alf-Solr comms to none (instead of https)
#

if node['alfresco']['components'].include? 'tomcat' and node['alfresco']['enable.web.xml.nossl.patch']
  template "/usr/local/bin/nossl-patch.sh" do
    source "nossl-patch.erb"
    mode "0755"
  end
  execute "run-nossl-patch.sh" do
    command "/usr/local/bin/nossl-patch.sh"
  end
end

#node.set['supervisor']['start'] = false
#include_recipe 'alfresco::supervisor'
