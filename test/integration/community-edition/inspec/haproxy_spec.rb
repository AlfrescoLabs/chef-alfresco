control 'alfresco-03' do
  impact 0.5
  title 'HA Proxy Configuration Check'

  describe file('/etc/haproxy/haproxy.cfg') do
    it { should exist }
    it { should be_file }
    its('content') { should match 'http-response set-header Strict-Transport-Security' }
  end
end
