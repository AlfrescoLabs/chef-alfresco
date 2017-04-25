control 'alfresco-03' do
  impact 0.5
  title 'Alfresco version'

  describe file('/usr/share/tomcat/alfresco/webapps/alfresco/WEB-INF/classes/alfresco/version.properties') do
    it { should exist }
    it { should be_file }
    its('content') { should match 'version.major=5' }
    its('content') { should match 'version.minor=2' }
  end
end
