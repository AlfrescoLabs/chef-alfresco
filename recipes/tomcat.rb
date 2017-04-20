# TODO: - Tomcat users should be created by tomcat_instance resource, not via recipe
# include_recipe "tomcat::users"

node.default['artifacts']['alfresco-mmt']['enabled'] = true
node.default['artifacts']['sharedclasses']['enabled'] = true
node.default['artifacts']['catalina-jmx']['enabled'] = true

if node['alfresco']['components'].include?('share') && !node['tomcat']['memcached_nodes'].empty?
  libraries = ['memcached-session-manager', 'memcached-session-manager-tc7', 'spymemcached', 'msm-kryo-serializer', 'kryo', 'minlog', 'reflectasm', 'asm']
  libraries.each do |lib|
    node.default['artifacts'][lib]['enabled'] = true
  end
end

context_template_cookbook = node['tomcat']['context_template_cookbook']
context_template_source = node['tomcat']['context_template_source']

additional_tomcat_packages = node['tomcat']['additional_tomcat_packages']
additional_tomcat_packages.each do |pkg|
  package pkg do
    action :install
  end
end

jmxremote_databag = node['alfresco']['jmxremote_databag']
jmxremote_databag_items = node['alfresco']['jmxremote_databag_items']

begin
  jmxremote_databag_items.each do |jmxremote_databag_item|
    db_item = data_bag_item(jmxremote_databag, jmxremote_databag_item)
    node.default['tomcat']["jmxremote_#{jmxremote_databag_item}_role"] = db_item['username']
    node.default['tomcat']["jmxremote_#{jmxremote_databag_item}_password"] = db_item['password']
    node.default['tomcat']["jmxremote_#{jmxremote_databag_item}_access"] = db_item['access']
  end
rescue
  Chef::Log.warn("Error fetching databag #{jmxremote_databag}, item #{jmxremote_databag_items}")
end

include_recipe 'tomcat::default'

# Find openjdk version
ruby_block 'Find openjdk version & jre path' do
  block do
    Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
    command = 'rpm -qa | grep openjdk | grep -v headless'
    command_out = shell_out(command)
    openjdk_version = command_out.stdout.chomp
    node.run_state['alfresco']['openjdk_path'] = "/usr/lib/jvm/#{openjdk_version}/jre"
  end
  action :run
end

# Unset openjdk alternatives for java and javac commands
java_alternatives 'un-set java alternatives for openjdk' do
  java_location lazy { node.run_state['alfresco']['openjdk_path'] }
  bin_cmds %w(java javac keytool)
  action :unset
end

# Reset back to Oracle Java as Apache Tomcat installs OpenJDK via Yum
java_ark 're-set oracle jdk' do
  url node['java']['jdk']['8']['x86_64']['url']
  default node['java']['set_default']
  checksum node['java']['jdk']['8']['x86_64']['checksum']
  app_home node['java']['java_home']
  bin_cmds node['java']['jdk']['8']['bin_cmds']
  alternatives_priority node['java']['alternatives_priority']
  retries node['java']['ark_retries']
  retry_delay node['java']['ark_retry_delay']
  connect_timeout node['java']['ark_timeout']
  use_alt_suffix node['java']['use_alt_suffix']
  reset_alternatives node['java']['reset_alternatives']
  download_timeout node['java']['ark_download_timeout']
  proxy node['java']['ark_proxy']
  action :install
  notifies :write, 'log[jdk-version-changed]', :immediately
end

selinux_commands = {}
selinux_commands['semanage permissive -a tomcat_t'] = 'semanage permissive -l | grep tomcat_t'

# TODO: - make it a custom resource
selinux_commands.each do |command, not_if|
  execute "selinux-command-#{command}" do
    command command
    only_if 'getenforce | grep -i enforcing'
    not_if not_if
  end
end

# This file defines an old log location (catalina.out)
# As such, we disable it
file '/etc/logrotate.d/tomcat' do
  action :delete
end

template "#{node['alfresco']['home']}/conf/context.xml" do
  cookbook context_template_cookbook
  source context_template_source
  owner node['alfresco']['user']
  group node['tomcat']['group']
end

file_replace_line 'patch-tomcat-conf-javahome' do
  path      '/etc/tomcat/tomcat.conf'
  replace   'JAVA_HOME='
  with      "JAVA_HOME=#{node['java']['java_home']}"
  not_if    "cat /etc/tomcat/tomcat.conf | grep 'JAVA_HOME=#{node['java']['java_home']}'"
end

file_replace_line 'patch-tomcat-conf-tmpdir' do
  path      '/etc/tomcat/tomcat.conf'
  replace   'CATALINA_TMPDIR='
  with      '#CATALINA_TMPDIR='
  not_if    "cat /etc/tomcat/tomcat.conf | grep '#CATALINA_TMPDIR="
end
