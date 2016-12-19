control "alfresco-02" do
  impact 0.5
  title "Libreoffice existence"

  describe file("/opt/libreoffice4.4/") do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end

  describe command("cat /usr/share/tomcat/shared/classes/alfresco-global.properties") do
    its(:stdout) { should include("jodconverter.officeHome=/opt/libreoffice4.4/") }
  end

  describe file('/etc/haproxy/haproxy.cfg') do
    it { should exist }
    it { should be_file }
    its('content') { should match ('http-response set-header Strict-Transport-Security max-age\=15768000\; includeSubDomains\; preload\;') }
  end
end
