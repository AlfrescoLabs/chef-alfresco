ssl_folder = '/etc/pki/tls/certs'
filename = 'alfresco'

control 'alfresco-10' do
  impact 0.5
  title 'Certs files creation and value check'

  describe file("#{ssl_folder}/#{filename}.key") do
    it { should exist }
    its('content') { should include '-----BEGIN PRIVATE KEY-----' }
  end

  describe file("#{ssl_folder}/#{filename}.crt") do
    it { should exist }
    its('content') { should include '-----BEGIN CERTIFICATE-----' }
  end

  describe file("#{ssl_folder}/#{filename}.chain") do
    it { should exist }
    its('content') { should include '-----BEGIN PRIVATE KEY-----' }
  end

  describe file("#{ssl_folder}/#{filename}.nginxcrt") do
    it { should exist }
    its('content') { should include '-----BEGIN CERTIFICATE-----' }
  end

  describe file("#{ssl_folder}/#{filename}.dhparam") do
    it { should exist }
    its('content') { should include '-----BEGIN DH PARAMETERS-----' }
  end
end
