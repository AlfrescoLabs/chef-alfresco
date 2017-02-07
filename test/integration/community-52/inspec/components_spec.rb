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
end
