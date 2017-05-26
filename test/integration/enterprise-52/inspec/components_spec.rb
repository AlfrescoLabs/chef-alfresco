control 'alfresco-02' do
  impact 0.7
  title 'Libreoffice configuration in Alfresco'
  desc 'Checks Alfresco configuration for LibreOffice'

  describe file('/usr/share/tomcat/shared/classes/alfresco-global.properties') do
    its('content') { should match('jodconverter.officeHome=/opt/libreoffice') }
  end
end
