control "alfresco-04" do
  impact 0.5
  title "HA Proxy Configuration Check"

  describe file('/etc/haproxy/haproxy.cfg') do
    it { should exist }
    it { should be_file }
    its('content') { should match 'http-response set-header Strict-Transport-Security' }
    its('content') { should match 'email_systeminfo path_reg' }
    its('content') { should match 'http-request deny if email_systeminfo' }
  end
end
