pem_file = 'rds-combined-ca-bundle.pem'

remote_file "#{Chef::Config[:file_cache_path]}/#{pem_file}" do
  source "http://s3.amazonaws.com/rds-downloads/#{pem_file}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end

truststore = node['alfresco']['truststore_file']
truststore_pass = node['alfresco']['truststore_password']
truststore_type = node['alfresco']['truststore_type']

certstore = node['alfresco']['certstore']['path']
certstore_pass = node['alfresco']['certstore']['pass']

ruby_block 'Import AWS RDS Certs' do
  block do
    Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
    csplit = "cd #{Chef::Config[:file_cache_path]} && csplit -sz #{pem_file} '/-BEGIN CERTIFICATE-/' '{*}'"
    shell_out(csplit)
    Dir.glob("#{Chef::Config[:file_cache_path]}/xx*").each do |cert|
      alias_cmd = "openssl x509 -noout -text -in #{cert} | perl -ne 'next unless /Subject:/; s/.*CN=//; print'"
      crt_alias = shell_out(alias_cmd).stdout.chomp.split.join
      f = Chef::Resource::JavaCertificate.new('java_certificate', run_context)
      f.cert_alias = crt_alias
      f.cert_file = cert
      f.run_action :install
      # Java certificate library don't have option of storetype other than JKS hence passing this way
      tstore_cmd = "keytool -import -keystore #{truststore} -storepass #{truststore_pass} -storetype #{truststore_type} -noprompt -alias #{crt_alias} -file #{cert}"
      shell_out(tstore_cmd)
    end
  end
  action :run
end

ssl_db_conf = " -Djavax.net.ssl.keyStore=#{certstore} -Djavax.net.ssl.keyStorePassword=#{certstore_pass}"
node.default['alfresco']['repo_tomcat_instance']['java_options']['others'] = "#{node['alfresco']['repo_tomcat_instance']['java_options']['others']} #{ssl_db_conf}"
