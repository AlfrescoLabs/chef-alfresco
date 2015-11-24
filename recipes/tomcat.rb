# TODO: - Tomcat users should be created by tomcat_instance resource, not via recipe
# include_recipe "tomcat::users"
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['tomcat']['keystore_password'] = secure_password
node.set_unless['tomcat']['truststore_password'] = secure_password

node.default['artifacts']['alfresco-mmt']['enabled'] = true
node.default['artifacts']['sharedclasses']['enabled'] = true
node.default['artifacts']['catalina-jmx']['enabled'] = true

context_template_cookbook = node['tomcat']['context_template_cookbook']
context_template_source = node['tomcat']['context_template_source']

#
# additional_tomcat_packages = node['tomcat']['additional_tomcat_packages']
# additional_tomcat_packages.each do |pkg|
#   package pkg do
#     action :install
#   end
# end
#
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
  Chef::Log.warn("Error fetching databag #{jmxremote_databag},  item #{jmxremote_databag_items}")
end

apache_tomcat 'tomcat' do
  url node['tomcat']['tar']['url']
  # Note: Checksum is SHA-256, not MD5 or SHA1. Generate using `shasum -a 256 /path/to/tomcat.tar.gz`
  checksum node['tomcat']['tar']['checksum']
  version node['tomcat']['tar']['version']
  instance_root '/etc/tomcat'
  user node['tomcat']['user']
  group node['tomcat']['group']

  if node['tomcat']['run_base_instance']
    apache_tomcat_instance node['tomcat']['base_instance'] do
      setenv_options do
        config(
          [
            "export JAVA_HOME=\"#{node['java']['java_home']}\"",
            "export JAVA_OPTS=\"#{node['tomcat']['java_options'].map{|k,v| "#{v}"}.join(' ')}\"",
            "export CATALINA_OPTS=\"#{node['tomcat']['catalina_options']}\""
          ]
        )
      end
      apache_tomcat_config 'server' do
        source node['tomcat']['server_template_source']
        cookbook node['tomcat']['server_template_cookbook']
        # Optionally, pass hash key/values to `config_options` if your custom template
        # needs variables
        options do
          port node['tomcat']['port']
          proxy_port node['tomcat']['proxy_port']
          # ssl_port node['tomcat']['ssl_port']
          # ssl_proxy_port node['tomcat']['ssl_proxy_port']
          ajp_port node['tomcat']['ajp_port']
          shutdown_port node['tomcat']['shutdown_port']
        end
      end

      apache_tomcat_config 'context' do
        source node['tomcat']['context_template_source']
        cookbook node['tomcat']['context_template_cookbook']
      end

      apache_tomcat_service node['tomcat']['base_instance'] do
        java_home node['java']['java_home']
      end
    end
  end

  node['tomcat']['instances'].each do |name, attrs|
    apache_tomcat_instance "#{name}" do

      setenv_options do
        config(
          [
            "export JAVA_HOME=\"#{node['java']['java_home']}\"",
            "export JAVA_OPTS=\"#{attrs['java_options'].map{|k, v| "#{v}"}.join(' ')}\"",
            "export CATALINA_OPTS=\"#{attrs['catalina_options']}\""
          ]
        )
      end

      apache_tomcat_config 'server' do
        source node['tomcat']['server_template_source']
        cookbook node['tomcat']['server_template_cookbook']
        # Optionally, pass hash key/values to `config_options` if your custom template
        # needs variables
        options do
          port attrs['port']
          proxy_port attrs['proxy_port']
          ajp_port attrs['ajp_port']
          shutdown_port node['tomcat']['shutdown_port']
          jmx_port attrs['jmx_port']
          max_threads attrs['max_threads']
          tomcat_auth attrs['tomcat_auth']
          # config_dir attrs['config_dir']
          # ssl_port attrs['ssl_port']
          # ssl_proxy_port attrs['ssl_proxy_port']
          # ssl_max_threads attrs['ssl_max_threads']
          # keystore_file attrs['keystore_file']
          # keystore_type attrs['keystore_type']
        end
      end

      apache_tomcat_config 'context' do
        source context_template_source
        cookbook context_template_cookbook
      end

      apache_tomcat_service "#{name}" do
        java_home node['java']['java_home']
      end
    end
  end
end

#
# include_recipe 'tomcat::default'

# if node['tomcat']['run_base_instance']
# tomcat_instance "base" do
#   # port node['tomcat']['port']
#   proxy_port node['tomcat']['proxy_port']
#   # ssl_port node['tomcat']['ssl_port']
#   ssl_proxy_port node['tomcat']['ssl_proxy_port']
#   # ajp_port node['tomcat']['ajp_port']
#   # shutdown_port node['tomcat']['shutdown_port']
# end
# end
#
# node['tomcat']['instances'].each do |name, attrs|
#   tomcat_instance "#{name}" do
# log_dir attrs['log_dir']
# work_dir attrs['work_dir']
# context_dir attrs['context_dir']
# webapp_dir attrs['webapp_dir']
# use_security_manager attrs['use_security_manager']
# authbind attrs['authbind']
# truststore_type attrs['truststore_type']
# truststore_file attrs['truststore_file']
# ssl_key_file attrs['ssl_key_file']
# ssl_chain_files attrs['ssl_chain_files']
# ssl_cert_file attrs['ssl_cert_file']
# certificate_dn attrs['certificate_dn']
# loglevel attrs['loglevel']
# home attrs['home']
# base attrs['base']
# tmp_dir attrs['tmp_dir']
# lib_dir attrs['lib_dir']
# endorsed_dir attrs['endorsed_dir']
#   end
# end
