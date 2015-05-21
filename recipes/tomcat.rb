# TODO - Tomcat users should be created by tomcat_instance resource, not via recipe
# include_recipe "tomcat::users"

# TODO - Shouldnt be needed, due to deploy_manager_apps=false
node.override['tomcat']['deploy_manager_packages'] = []

context_template_cookbook = node['tomcat']['context_template_cookbook']
context_template_source = node['tomcat']['context_template_source']

additional_tomcat_packages = node['tomcat']['additional_tomcat_packages']
additional_tomcat_packages.each do |pkg|
  package pkg do
    action :install
  end
end

unless node['tomcat']['run_base_instance']
  alfresco_components = node['alfresco']['components']
  if alfresco_components.include? "repo"
    node.override['tomcat']['instances']['alfresco'] = node['alfresco']['repo_tomcat_instance']
    node.override['artifacts']['alfresco']['destination'] = "#{node['tomcat']['base']}-alfresco/webapps"
    node.override['artifacts']['_vti_bin']['destination'] = "#{node['tomcat']['base']}-alfresco/webapps"
    node.override['artifacts']['ROOT']['destination'] = "#{node['tomcat']['base']}-alfresco/webapps"
    # Point Solr to the right Alfresco instance
    node.override['alfresco']['solrproperties']['alfresco.port']            = node['alfresco']['repo_tomcat_instance']['port']
    # Point Alfresco to the right Solr instance
    node.override['alfresco']['properties']['solr.port']          = node['alfresco']['solr_tomcat_instance']['port']
    node.override['alfresco']['properties']['solr.port.ssl']      = node['alfresco']['solr_tomcat_instance']['ssl_port']
    # Point Share to the right Alfresco instance
    node.override['alfresco']['shareproperties']['alfresco.port']            = node['alfresco']['repo_tomcat_instance']['port']
  end
  if alfresco_components.include? 'share'
    node.override['tomcat']['instances']['share'] = node['alfresco']['share_tomcat_instance']
    node.override['artifacts']['share']['destination']  = "#{node['tomcat']['base']}-share/webapps"
  end
  if alfresco_components.include? 'solr'
    node.override['tomcat']['instances']['solr'] = node['alfresco']['solr_tomcat_instance']
    node.override['artifacts']['solr']['destination']       = "#{node['tomcat']['base']}-solr/webapps"
    node.override['alfresco']['solr-log4j']['log4j.appender.File.File'] = "/var/log/tomcat-solr/solr.log"
  end
end

include_recipe 'java::default'
include_recipe 'tomcat::default'

template '/usr/share/tomcat/conf/context.xml' do
  cookbook context_template_cookbook
  source context_template_source
  owner node['tomcat']['user']
  group node['tomcat']['group']
end

file_replace_line 'share-config-origin' do
  path      '/etc/tomcat/tomcat.conf'
  replace   "JAVA_HOME="
  with      "JAVA_HOME=#{node['java']['java_home']}"
  not_if    "cat /etc/tomcat/tomcat.conf | grep 'JAVA_HOME=#{node['java']['java_home']}'"
end
