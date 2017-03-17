control 'alfresco-06' do
  impact 0.7
  title 'Share Checks'

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
    its('content') { should match 'http://127.0.0.1:9000/alfresco/s' }
    its('content') { should match 'http://127.0.0.1:9000/alfresco/activiti-admin' }
    its('content') { should match 'http://127.0.0.1:9000/alfresco/api' }
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
    its('content') { should match 'webframework.cluster.slingshot' }
    its('content') { should match '5802' }
    its('content') { should match 'pwd' }
  end
end
