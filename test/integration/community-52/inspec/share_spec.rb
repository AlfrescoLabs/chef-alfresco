control 'alfresco-06' do
  impact 0.7
  title 'Checks for the Share'

  describe directory('/usr/share/tomcat/shared/classes/alfresco/web-extension') do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' } 
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should be_executable.by_user('tomcat') }
    it { should be_readable.by_user('nginx') }
    it { should be_executable.by_user('nginx') }
    it { should_not be_writable.by_user('nginx') }
  end

  describe file('/usr/share/tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' } 
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should_not be_executable.by_user('tomcat') }
    it { should be_readable.by_user('nginx') }
    it { should_not be_executable.by_user('nginx') }
    it { should_not be_writable.by_user('nginx') }
  end
  
  describe file('/usr/share/tomcat/shared/classes/alfresco/web-extension/share-cluster-application-context.xml') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' } 
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should_not be_executable.by_user('tomcat') }
    it { should be_readable.by_user('nginx') }
    it { should_not be_executable.by_user('nginx') }
    it { should_not be_writable.by_user('nginx') }
  end
end
