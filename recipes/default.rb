# If there are no components that need artifact deployment,
# don't invoke artifact-deployer::default and (most importantly)
# it skips alfresco::apply_amps
deploy = false

# This is needed *here* due to the derived attributes
# created in tomcat::_attributes recipe
node.override["tomcat"]["base_version"] = 7

if node['platform_family'] == "rhel"
  include_recipe "yum-epel::default"
end

include_recipe "tomcat::_attributes"
include_recipe "alfresco::_attributes"

# Any Alfresco node needs java; attributes are set in alfresco::_attributes
include_recipe 'java::default'

# TODO - Add support for firewalld too or keep it uncommented
# if node['alfresco']['components'].include? 'iptables'
#   include_recipe "alfresco::iptables"
# end

# if node['alfresco']['components'].include? 'lb'
#   include_recipe "apache2::default"
#   include_recipe "alfresco::apachelb"
# end

if node['alfresco']['components'].include? 'tomcat'
  include_recipe "alfresco::tomcat"
end

if node['alfresco']['components'].include? 'transform'
  include_recipe "alfresco::3rdparty"
end

if node['alfresco']['components'].include? 'mysql'
  include_recipe "alfresco::mysql_local_server"
end

if node['alfresco']['components'].include? 'spp'
  node.default['artifacts']['alfresco-spp']['enabled'] = true
end

# JDBC Driver defaults
if node['alfresco']['properties']['db.driver'] == 'org.gjt.mm.mysql.Driver'
  node.default['artifacts']['mysqlconnector']['enabled'] = true
elsif node['alfresco']['properties']['db.driver'] == 'org.postgresql.Driver'
  node.default['artifacts']['postgresconnector']['enabled'] = true
end

if node['alfresco']['components'].include? 'repo'
  deploy = true
  include_recipe "alfresco::_attributes_repo"

  if node['alfresco']['generate.global.properties'] == true
    node.default['artifacts']['sharedclasses']['properties']['alfresco-global.properties'] = node['alfresco']['properties']
  end

  if node['alfresco']['generate.repo.log4j.properties'] == true
    node.default['artifacts']['sharedclasses']['properties']['alfresco/extension/repo-log4j.properties'] = node['alfresco']['repo-log4j']
  end

  include_recipe "alfresco::repo_config"
end

if node['alfresco']['components'].include? 'share'
  deploy = true
  include_recipe "alfresco::_attributes_share"

  if node['alfresco']['patch.share.config.custom'] == true
    node.default['artifacts']['sharedclasses']['terms']['alfresco/web-extension/share-config-custom.xml'] = node['alfresco']['properties']
  end

  if node['alfresco']['generate.share.log4j.properties'] == true
    node.default['artifacts']['sharedclasses']['properties']['alfresco/web-extension/share-log4j.properties'] = node['alfresco']['share-log4j']
  end

  include_recipe "alfresco::share_config"
end

if node['alfresco']['components'].include? 'solr'
  deploy = true
  include_recipe "alfresco::_attributes_solr"
end

if deploy == true
  # https://github.com/abrt/abrt/wiki/ABRT-Project
  # http://tomcat.apache.org/download-native.cgi
  # http://tomcat.apache.org/tomcat-7.0-doc/apr.html
  %w{tomcat-native apr abrt}.each do |pkg|
   package "#{pkg}" do
     action :install
   end
  end

  include_recipe "artifact-deployer::default"
  include_recipe "alfresco::apply_amps"
end
