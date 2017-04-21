remote_file "#{Chef::Config[:file_cache_path]}/rds-combined-ca-bundle.pem" do
  source 'http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem'
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end

execute 'split_certs' do
  command <<-EOF
    cd #{Chef::Config[:file_cache_path]}
    csplit -sz rds-combined-ca-bundle.pem '/-BEGIN CERTIFICATE-/' '{*}'
    EOF
  only_if { ::File.exist?("#{Chef::Config[:file_cache_path]}/rds-combined-ca-bundle.pem") }
end

truststore = "#{node['java']['java_home']}/jre/lib/security/cacerts"
truststore_pass = 'changeit'

ruby_block 'Import AWS RDS Certs' do
  block do
    Dir.glob("#{Chef::Config[:file_cache_path]}/xx*").each do |cert|
      Mixlib::ShellOut.new(
        %[ keytool -import -keystore #{truststore} -storepass #{truststore_pass} -noprompt \
        -alias \"$(openssl x509 -noout -text -in #{cert} | perl -ne 'next unless /Subject:/; s/.*CN=//; print')\" -file #{cert} ]
      ).run_command
    end
  end
  action :run
end

ssl_db_conf = " -Djavax.net.ssl.trustStore=#{truststore} -Djavax.net.ssl.trustStorePassword=#{truststore_pass}"
node.default['alfresco']['repo_tomcat_instance']['java_options']['others'] = "#{node['alfresco']['repo_tomcat_instance']['java_options']['others']} #{ssl_db_conf}"
