# TODO - Tomcat users should be created by tomcat_instance resource, not via recipe
# include_recipe "tomcat::users"

node.default['artifacts']['alfresco-mmt']['enabled']    = true
node.default['artifacts']['sharedclasses']['enabled']   = true
node.default['artifacts']['catalina-jmx']['enabled'] = true

if node['tomcat']['run_base_instance']
  node.default['alfresco']['restart_services'] = ['tomcat']
end

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
    node.default['tomcat']['instances']['alfresco'] = node['alfresco']['repo_tomcat_instance']
    node.set['artifacts']['alfresco']['destination'] = "#{node['alfresco']['home']}-alfresco/webapps"
    node.set['artifacts']['_vti_bin']['destination'] = "#{node['alfresco']['home']}-alfresco/webapps"
    node.set['artifacts']['ROOT']['destination'] = "#{node['alfresco']['home']}-alfresco/webapps"
    # Point Solr to the right Alfresco instance
    node.set['alfresco']['solrproperties']['alfresco.port']            = node['alfresco']['repo_tomcat_instance']['port']
    # Point Alfresco to the right Solr instance
    node.set['alfresco']['properties']['solr.port']          = node['alfresco']['solr_tomcat_instance']['port']
    if node['alfresco']['solr_tomcat_instance']['ssl_port']
      node.set['alfresco']['properties']['solr.port.ssl']      = node['alfresco']['solr_tomcat_instance']['ssl_port']
    end
    # Point Share to the right Alfresco instance
    node.set['alfresco']['shareproperties']['alfresco.port']            = node['alfresco']['repo_tomcat_instance']['port']
  end
  if alfresco_components.include? 'share'
    node.default['tomcat']['instances']['share'] = node['alfresco']['share_tomcat_instance']
    node.set['artifacts']['share']['destination']  = "#{node['alfresco']['home']}-share/webapps"
  end
  if alfresco_components.include? 'solr'
    node.default['tomcat']['instances']['solr'] = node['alfresco']['solr_tomcat_instance']
    node.set['artifacts']['solr4']['destination']       = "#{node['alfresco']['home']}-solr/webapps"
    node.set['alfresco']['solr-log4j']['log4j.appender.File.File'] = "/var/log/tomcat-solr/solr.log"
  end
end

include_recipe 'tomcat::default'

template "#{node['alfresco']['home']}/conf/context.xml" do
  cookbook context_template_cookbook
  source context_template_source
  owner node['alfresco']['user']
  group node['tomcat']['group']
end

file_replace_line 'share-config-origin' do
  path      '/etc/tomcat/tomcat.conf'
  replace   "JAVA_HOME="
  with      "JAVA_HOME=#{node['java']['java_home']}"
  not_if    "cat /etc/tomcat/tomcat.conf | grep 'JAVA_HOME=#{node['java']['java_home']}'"
end
