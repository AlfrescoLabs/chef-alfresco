remote_file '/tmp/rds-combined-ca-bundle.pem' do
  source 'http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem'
  owner 'root'
  group 'root'
  mode '0755'  
  action :create_if_missing
end

script 'split_certs' do
  interpreter "bash"
  code <<-EOH
    csplit -sz rds-combined-ca-bundle.pem '/-BEGIN CERTIFICATE-/' '{*}'
    EOH
  only_if { ::File.exists?('/tmp/rds-combined-ca-bundle.pem') }
end

truststore = node['alfresco']['truststore_file']
truststore_pass = node['alfresco']['truststore_password']
truststore_type = node['alfresco']['truststore_type']

Dir["/tmp/xx*"].each do |cert|
  execute "import #{cert} to RDS keystore" do
    command <<-EOF
      ALIAS=$(openssl x509 -noout -text -in #{cert} | perl -ne 'next unless /Subject:/; s/.*CN=//; print')
      keytool -import -keystore #{truststore} -storepass #{truststore_pass} -storetype #{truststore_type} -noprompt -alias "$ALIAS" -file #{cert}
      EOF
    not_if "keytool -list -keystore #{truststore} -storepass #{truststore_pass} -alias #{cert}" 
  end
end

ssl_db_conf = " -Djavax.net.ssl.keyStore=#{node['alfresco']['keystore_file']} -Djavax.net.ssl.keyStorePassword=#{node['alfresco']['keystore_password']}"
node.default['alfresco']['repo_tomcat_instance']['java_options']['others'] = "#{node['alfresco']['repo_tomcat_instance']['java_options']['others']} #{ssl_db_conf}"
