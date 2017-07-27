control 'alfresco-pfdium-check' do
  impact 0.5
  title 'Check pfd is installed and the properties are in alfresco.properties'

  describe file('/usr/local/bin/alfresco-pdf-renderer') do
    it { should exist }
    it { should be_file }
  end

  describe file('/usr/share/tomcat/shared/classes/alfresco-global.properties') do
    it { should exist }
    it { should be_file }
    its('content') { should include('alfresco-pdf-renderer.root=/usr/local/bin') }
    its('content') { should include('alfresco-pdf-renderer.exe=${alfresco-pdf-renderer.root}/alfresco-pdf-renderer') }
  end
end
