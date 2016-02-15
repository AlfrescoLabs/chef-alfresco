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
  Chef::Log.warn("Error fetching databag #{jmxremote_databag},  item #{jmxremote_databag_items}")
end

directory '/etc/cron.d' do
  action :create
end

apache_tomcat 'tomcat' do
  url node['tomcat']['tar']['url']
  # Note: Checksum is SHA-256, not MD5 or SHA1. Generate using `shasum -a 256 /path/to/tomcat.tar.gz`
  checksum node['tomcat']['tar']['checksum']
  version node['tomcat']['tar']['version']
  instance_root node['alfresco']['home']
  catalina_home node['alfresco']['home']
  user node['tomcat']['user']
  group node['tomcat']['group']

  template "#{node['alfresco']['home']}/conf/logging.properties" do
    source 'tomcat/logging.properties.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end

  if node['tomcat']['run_base_instance']
    apache_tomcat_instance node['tomcat']['base_instance'] do
      setenv_options do
        config(
          [
            "export JAVA_OPTS=\"#{node['tomcat']['java_options'].map { |_k, v| v }.join(' ')}\""
          ]
        )
      end
      apache_tomcat_config 'server' do
        source node['tomcat']['server_template_source']
        cookbook node['tomcat']['server_template_cookbook']
        options do
          port node['tomcat']['port']
          proxy_port node['tomcat']['proxy_port']
          ssl_port node['tomcat']['ssl_port']
          ssl_proxy_port node['tomcat']['ssl_proxy_port']
          ajp_port node['tomcat']['ajp_port']
          shutdown_port node['tomcat']['shutdown_port']
        end
      end

      template "/etc/cron.d/#{node['tomcat']['base_instance']}-cleaner.cron" do
        source 'tomcat/cleaner.cron.erb'
        owner 'root'
        group 'root'
        mode '0755'
        variables(tomcat_log_path: "#{node['tomcat']['base_instance']}/logs",
                  tomcat_cache_path: "#{node['tomcat']['base_instance']}/temp")
      end

      %w(catalina.properties catalina.policy logging.properties tomcat-users.xml).each do |linked_file|
        link "#{node['alfresco']['home']}/conf/#{linked_file}" do
          to "#{node['alfresco']['home']}/#{name}/conf/#{linked_file}"
        end
      end

      apache_tomcat_config 'context' do
        source node['tomcat']['context_template_source']
        cookbook node['tomcat']['context_template_cookbook']
      end

      apache_tomcat_service node['tomcat']['base_instance'] do
        java_home node['java']['java_home']
        restart_on_update false
        action [:enable, :stop]
      end
    end
  end

  node['tomcat']['instances'].each do |name, attrs|
    logs_path = attrs['logs_path'] || "#{node['alfresco']['home']}/#{name}/logs"
    cache_path = attrs['cache_path'] || "#{node['alfresco']['home']}/#{name}/temp"

    apache_tomcat_instance name do
      setenv_options do
        config(
          [
            "export JAVA_OPTS=\"#{attrs['java_options'].map { |_k, v| v }.join(' ')}\""
          ]
        )
      end
      apache_tomcat_config 'server' do
        source node['tomcat']['server_template_source']
        cookbook node['tomcat']['server_template_cookbook']
        options do
          port attrs['port']
          proxy_port attrs['proxy_port']
          ajp_port attrs['ajp_port']
          shutdown_port attrs['shutdown_port']
          # jmx_port attrs['jmx_port']
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

      template "/etc/cron.d/#{name}-cleaner.cron" do
        source 'tomcat/cleaner.cron.erb'
        owner 'root'
        group 'root'
        mode '0755'
        variables(tomcat_log_path: logs_path,
                  tomcat_cache_path: cache_path)
      end

      apache_tomcat_config 'context' do
        source context_template_source
        cookbook context_template_cookbook
      end

      %w(catalina.properties catalina.policy logging.properties tomcat-users.xml).each do |linked_file|
        link "#{node['alfresco']['home']}/#{name}/conf/#{linked_file}" do
          to "#{node['alfresco']['home']}/conf/#{linked_file}"
          owner node['tomcat']['user']
          group node['tomcat']['group']
          mode '0755'
        end
      end

      directory attrs['endorsed_dir'] do
        owner node['tomcat']['user']
        group node['tomcat']['group']
        mode '0755'
        action :create
      end

      apache_tomcat_service name do
        java_home node['java']['java_home']
        restart_on_update false
        action [:enable, :stop]
      end

      # Add LimitNOFILE=16000 into tomcat systemd and restart services
      # TODO - add #{processes_limit} to systemd file
      # TODO - Add it to apache_tomcat cookbook (apache_tomcat_service LWRP)
      open_files_limit = node['tomcat']['open_files_limit']
      processes_limit = node['tomcat']['processes_limit']
      execute "extend-open-files-limit-for-#{name}" do
        command "sed -i '/\\[Service\\]/a LimitNOFILE=#{open_files_limit}' /etc/systemd/system/tomcat-#{name}.service ; systemctl daemon-reload"
        action :run
        not_if "cat /etc/systemd/system/tomcat-#{name}.service | grep LimitNOFILE"
      end
    end
  end
end
