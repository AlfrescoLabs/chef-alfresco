services = %w(alfresco solr share)

control 'alfresco-01' do
  impact 0.7
  title 'Alfresco configuration permission'
  desc 'Checks to be sure that the right files have the right permissions and cannot be seen by not authorized users'

  describe user('tomcat') do
    it { should exist }
  end

  describe group('tomcat') do
    it { should exist }
  end

  describe file('/usr/share/tomcat-alfresco/webapps') do
    it { should exist }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' }
    it { should be_writable.by_user('root') }
    it { should be_readable.by_user('root') }
  end

  describe file('/etc/tomcat/jmxremote.password') do
    it { should exist }
    its('owner') { should eq 'tomcat' }
    its('group') { should eq 'tomcat' }
    it { should be_writable.by_user('tomcat') }
    it { should be_readable.by_user('tomcat') }
    it { should_not be_readable.by_user('nginx') }
    it { should_not be_writable.by_user('nginx') }
    it { should_not be_executable.by_user('nginx') }
  end

  services.each do |service|
    describe directory("/var/cache/tomcat-#{service}/") do
      it { should exist }
      its('owner') { should cmp 'tomcat' }
      its('group') { should cmp 'tomcat' }
      it { should be_readable.by_user('tomcat') }
      it { should be_writable.by_user('tomcat') }
      it { should_not be_readable.by_user('nginx') }
      it { should_not be_writable.by_user('nginx') }
      it { should_not be_executable.by_user('nginx') }
    end
  end
end
