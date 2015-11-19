# TODO - Tomcat users should be created by tomcat_instance resource, not via recipe
# include_recipe "tomcat::users"

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
jmxremote_databag = node["alfresco"]["jmxremote_databag"]
jmxremote_databag_items = node["alfresco"]["jmxremote_databag_items"]

begin
  jmxremote_databag_items.each do |jmxremote_databag_item|
    db_item = data_bag_item(jmxremote_databag,jmxremote_databag_item)
    node.default["tomcat"]["jmxremote_#{jmxremote_databag_item}_role"] = db_item['username']
    node.default["tomcat"]["jmxremote_#{jmxremote_databag_item}_password"] = db_item['password']
    node.default["tomcat"]["jmxremote_#{jmxremote_databag_item}_access"] = db_item['access']
  end
rescue
  Chef::Log.warn("Error fetching databag #{jmxremote_databag},  item #{jmxremote_databag_items}")
end

# if node['tomcat']['run_base_instance']
apache_tomcat "base" do
  url 'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.59/bin/apache-tomcat-7.0.59.tar.gz'
  # Note: Checksum is SHA-256, not MD5 or SHA1. Generate using `shasum -a 256 /path/to/tomcat.tar.gz`
  checksum 'e0fe43d1fa17013bf7b3b2d3f71105d606a0582c153eb16fb210e7d5164941b0'
  version '7.0.59'
  # prefix_root '/usr/share'
  # instance_root '/etc'
  user node['tomcat']['user']
  group node['tomcat']['group']
  # catalina_home node['tomcat']['home']

  apache_tomcat_instance "base" do
    apache_tomcat_config 'server' do
      options do
        include_defaults false
        server_port node['tomcat']['shutdown_port']
        listeners(
          [
            {
              'class_name'  => 'org.apache.catalina.mbeans.JmxRemoteLifecycleListener',
              'params'      => {
                                  'rmiRegistryPortPlatform' => '40000',
                                  'rmiServerPortPlatform' => '40000'
                                }
            },
            {
              'class_name'  => 'org.apache.catalina.core.AprLifecycleListener',
              'params'      => {
                                  'SSLEngine' => 'on'
                                }
            },
            'org.apache.catalina.core.JasperListener',
            'org.apache.catalina.core.JreMemoryLeakPreventionListener',
            'org.apache.catalina.mbeans.GlobalResourcesLifecycleListener',
            'org.apache.catalina.core.JasperListener'
          ]
        )
        include_default_user_database true
        include_default_connectors false
        apache_tomcat_entity 'default_connector' do
          content(<<-EOS
          <Connector port="#{node['tomcat']['port']}"
            executor="tomcatThreadPool"
            protocol="org.apache.coyote.http11.Http11AprProtocol"
            URIEncoding="UTF-8"
            enableLookups="false"
            acceptCount="100"
            maxKeepAliveRequests="1"
            connectionTimeout="60000"
            disableUploadTimeout="true"
            server=" "
            maxHttpHeaderSize="1048576"
            secure="true"
          />
          EOS
            )
        end
        apache_tomcat_entity 'ssl_connector' do
          content(<<-EOS
          <Connector port="#{node['tomcat']['ssl_port']}" SSLEnabled="true"
         protocol="org.apache.coyote.http11.Http11AprProtocol"
         keystoreFile="/usr/share/tomcat/alf_data/keystore/alfresco/keystore/ssl.keystore"
         keystorePass="kT9X6oe68t"
         keystoreType="JCEKS"
         truststoreFile="/usr/share/tomcat/alf_data/keystore/alfresco/keystore/ssl.truststore"
         truststoreType="JCEKS"
         truststorePass="kT9X6oe68t"
         maxThreads="150" scheme="https" secure="true"
         clientAuth="" sslProtocol="TLS" />
         EOS
            )
        end
        include_default_engine false
      end
    end
    apache_tomcat_service "alfresco"
  end

end
# end

#
# include_recipe 'tomcat::default'


# if node['tomcat']['run_base_instance']
  # tomcat_instance "base" do
  #   # port node['tomcat']['port']
  #   proxy_port node['tomcat']['proxy_port']
  #   ssl_port node['tomcat']['ssl_port']
  #   ssl_proxy_port node['tomcat']['ssl_proxy_port']
  #   ajp_port node['tomcat']['ajp_port']
  #   # shutdown_port node['tomcat']['shutdown_port']
  # end
# end
#
# node['tomcat']['instances'].each do |name, attrs|
#   tomcat_instance "#{name}" do
#     port attrs['port']
#     proxy_port attrs['proxy_port']
#     ssl_port attrs['ssl_port']
#     ssl_proxy_port attrs['ssl_proxy_port']
#     ajp_port attrs['ajp_port']
#     jmx_port attrs['jmx_port']
#     shutdown_port attrs['shutdown_port']
#     config_dir attrs['config_dir']
#     log_dir attrs['log_dir']
#     work_dir attrs['work_dir']
#     context_dir attrs['context_dir']
#     webapp_dir attrs['webapp_dir']
#     catalina_options attrs['catalina_options']
#     java_options attrs['java_options']
#     use_security_manager attrs['use_security_manager']
#     authbind attrs['authbind']
#     max_threads attrs['max_threads']
#     ssl_max_threads attrs['ssl_max_threads']
#     ssl_cert_file attrs['ssl_cert_file']
#     ssl_key_file attrs['ssl_key_file']
#     ssl_chain_files attrs['ssl_chain_files']
#     keystore_file attrs['keystore_file']
#     keystore_type attrs['keystore_type']
#     truststore_file attrs['truststore_file']
#     truststore_type attrs['truststore_type']
#     certificate_dn attrs['certificate_dn']
#     loglevel attrs['loglevel']
#     tomcat_auth attrs['tomcat_auth']
#     user attrs['user']
#     group attrs['group']
#     home attrs['home']
#     base attrs['base']
#     tmp_dir attrs['tmp_dir']
#     lib_dir attrs['lib_dir']
#     endorsed_dir attrs['endorsed_dir']
#   end
# end

#
# template "#{node['alfresco']['home']}/conf/context.xml" do
#   cookbook context_template_cookbook
#   source context_template_source
#   owner node['alfresco']['user']
#   group node['tomcat']['group']
# end
#
# file_replace_line 'patch-tomcat-conf-javahome' do
#   path      '/etc/tomcat/tomcat.conf'
#   replace   "JAVA_HOME="
#   with      "JAVA_HOME=#{node['java']['java_home']}"
#   not_if    "cat /etc/tomcat/tomcat.conf | grep 'JAVA_HOME=#{node['java']['java_home']}'"
# end
#
# file_replace_line 'patch-tomcat-conf-tmpdir' do
#   path      '/etc/tomcat/tomcat.conf'
#   replace   "CATALINA_TMPDIR="
#   with      "#CATALINA_TMPDIR="
#   not_if    "cat /etc/tomcat/tomcat.conf | grep '#CATALINA_TMPDIR="
# end
