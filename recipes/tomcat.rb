# TODO - Tomcat users should be created by tomcat_instance resource, not via recipe
# include_recipe "tomcat::users"

# TODO - Shouldnt be needed, due to deploy_manager_apps=false
node.override['tomcat']['deploy_manager_packages'] = []

additional_tomcat_packages = node['tomcat']['additional_tomcat_packages']
additional_tomcat_packages.each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

unless node['tomcat']['run_base_instance']
  # TODO - apply_amps.sh.erb must be parametric with location of WARs to use
  alfresco_components = node['alfresco']['components']
  if alfresco_components.include? "repo"
    node.override['tomcat']['instances']['alfresco'] = node['alfresco']['repo_tomcat_instance']
    node.override['artifacts']['alfresco']['destination'] = "#{node['tomcat']['base']}-alfresco/webapps"
    node.override['alfresco']['solrproperties']['alfresco.port']            = node['alfresco']['repo_tomcat_instance']['port']
    node.override['alfresco']['shareproperties']['alfresco.port']            = node['alfresco']['repo_tomcat_instance']['port']
  end
  if alfresco_components.include? 'share'
    node.override['tomcat']['instances']['share'] = node['alfresco']['share_tomcat_instance']
    node.override['artifacts']['share']['destination']  = "#{node['tomcat']['base']}-share/webapps"
  end
  if alfresco_components.include? 'solr'
    node.override['tomcat']['instances']['solr'] = node['alfresco']['solr_tomcat_instance']
    node.override['artifacts']['solr']['destination']       = "#{node['tomcat']['base']}-solr/webapps"
  end
end

include_recipe 'java::default'
include_recipe 'tomcat::default'

global_templates = node['tomcat']['instance_templates']
global_templates.each do |global_template|
  directory global_template['dest'] do
    action :create
    recursive true
  end

  template "#{global_template['dest']}/#{global_template['filename']}" do
    source "tomcat/#{global_template['filename']}.erb"
    owner global_template['owner']
    group global_template['owner']
  end
end

node.default['tomcat']['instances'].each do |tomcat_instance_name,tomcat_instance|
  instance_templates = node['tomcat']['instance_templates']

  instance_templates.each do |instance_template|
    directory instance_template['dest'] do
      action :create
      recursive true
    end

    template "#{instance_template['dest']}/#{tomcat_instance_name}-#{tomcat_template['filename']}" do
      source "tomcat/#{tomcat_template['filename']}.erb"
      owner tomcat_template['owner']
      group tomcat_template['owner']
      variables({
        "tomcat_log_path" => "/var/log/tomcat-#{tomcat_instance_name}",
        "tomcat_cache_path" => "/var/cache/tomcat-#{tomcat_instance_name}"
      })
    end
  end
end
