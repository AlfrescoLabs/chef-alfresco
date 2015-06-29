# TODO - Tomcat users should be created by tomcat_instance resource, not via recipe
# include_recipe "tomcat::users"

node.default['artifacts']['alfresco-mmt']['enabled']    = true
node.default['artifacts']['sharedclasses']['enabled']   = true
node.default['artifacts']['catalina-jmx']['enabled'] = true

context_template_cookbook = node['tomcat']['context_template_cookbook']
context_template_source = node['tomcat']['context_template_source']

additional_tomcat_packages = node['tomcat']['additional_tomcat_packages']
additional_tomcat_packages.each do |pkg|
  package pkg do
    action :install
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
