require 'json'

ssl_folder = '/etc/pki/tls/certs'
filename = 'alfresco'

file = File.read('test/integration/data_bags/ssl/certs.json')
ssl_databag_test = JSON.parse(file)

control 'alfresco-10' do
  impact 0.5
  title 'Certs files creation and value check'

  describe file("#{ssl_folder}/#{filename}.key") do
    it { should exist }
    its('content') { should match ssl_databag_test['key'].to_s }
  end

  describe file("#{ssl_folder}/#{filename}.crt") do
    it { should exist }
    its('content') { should match ssl_databag_test['crt'].to_s }
  end

  describe file("#{ssl_folder}/#{filename}.chain") do
    it { should exist }
    its('content') { should match ssl_databag_test['chain'].to_s }
  end

  describe file("#{ssl_folder}/#{filename}.nginxcrt") do
    it { should exist }
    its('content') { should match ssl_databag_test['nginxcrt'].to_s }
  end

  describe file("#{ssl_folder}/#{filename}.dhparam") do
    it { should exist }
    its('content') { should match ssl_databag_test['dhparam'].to_s }
  end
end
