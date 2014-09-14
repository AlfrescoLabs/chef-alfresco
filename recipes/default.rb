deploy = false

if node['alfresco']['components'].include? 'iptables'
  include_recipe "alfresco::iptables"
end

if node['alfresco']['components'].include? 'lb'
  include_recipe "apache2::default"
  include_recipe "alfresco::apachelb"
end

if node['alfresco']['components'].include? 'tomcat'
  include_recipe "tomcat::default"
  include_recipe "tomcat::users"
end

if node['alfresco']['components'].include? 'transform'
  include_recipe "alfresco::3rdparty"
end

if node['alfresco']['components'].include? 'mysql'
  include_recipe "alfresco::mysql_server"
end

# JDBC Driver defaults
if node['alfresco']['properties']['db.driver'] == 'org.gjt.mm.mysql.Driver'
  node.default['artifacts']['mysqlconnector']['enabled'] = true
elsif node['alfresco']['properties']['db.driver'] == 'org.postgresql.Driver'
  node.default['artifacts']['postgresconnector']['enabled'] = true
end

if node['alfresco']['components'].include? 'repo'
  deploy = true
  if node['alfresco']['generate.global.properties'] == true
    node.default['artifacts']['sharedclasses']['properties']['alfresco-global.properties'] = node['alfresco']['properties']
  end

  if node['alfresco']['generate.repo.log4j.properties'] == true
    node.default['artifacts']['sharedclasses']['properties']['alfresco/extension/repo-log4j.properties'] = node['alfresco']['repo-log4j']
  end

  # TODO - deprecated in favour of keystore jar unpacking
  # if node['alfresco']['version'].start_with?("4.3") || node['alfresco']['version'].start_with?("5")
  # else
  #   node.default['alfresco']['properties']['dir.keystore']     = "#{node['alfresco']['solrproperties']['data.dir.root']}/alf_data/keystore"
  #   node.default['artifacts']['keystore']['enabled']           = false
  # end

  include_recipe "alfresco::repo_config"
end

if node['alfresco']['components'].include? 'share'
  deploy = true
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
  include_recipe "alfresco::solr_config"
end

if deploy == true
  include_recipe "artifact-deployer::default"
  include_recipe "alfresco::apply_amps"
end
