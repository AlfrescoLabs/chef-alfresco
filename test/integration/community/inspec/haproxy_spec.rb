control "alfresco-04" do
  impact 0.5
  title "HA Proxy Configuration Check"

  describe file('/etc/haproxy/haproxy.cfg') do
    it { should exist }
    it { should be_file }
    its('content') { should include 'http-response set-header Strict-Transport-Security max-age=15768000; includeSubDomains; preload;' }
  end
end
