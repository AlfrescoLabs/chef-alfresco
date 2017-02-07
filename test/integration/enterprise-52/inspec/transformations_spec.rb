control 'alfresco-04' do
  impact 0.7
  title 'Libreoffice installation'
  desc 'Checks to be sure that Libreoffice has been installed correctly'

  describe file("/opt/libreoffice4.4/") do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end

  describe file("/usr/share/tomcat/shared/classes/alfresco-global.properties") do
    its('content') { should match("jodconverter.officeHome=/opt/libreoffice4.4/") }
  end
end
