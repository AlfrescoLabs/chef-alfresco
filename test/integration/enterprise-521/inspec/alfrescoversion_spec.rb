control 'alfresco_version_check' do
  impact 0.5
  title 'Alfresco Version'

  describe file('/var/lib/tomcat-alfresco/webapps/alfresco/WEB-INF/classes/alfresco/version.properties') do
    it { should exist }
    it { should be_file }
    its('content') { should match 'version.major=5' }
    its('content') { should match 'version.minor=2' }
    its('content') { should match 'version.revision=1' }
  end
end
