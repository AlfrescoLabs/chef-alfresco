services = %w(alfresco solr share)
control 'alfresco-05' do
  impact 05
  title 'Repo Checks'

  describe directory('/usr/share/tomcat/alf_data') do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' }
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('nginx') }
    it { should_not be_readable.by_user('nginx') }
    it { should_not be_executable.by_user('nginx') }
  end
  # Not needed on standard a installation, unless Solr SSL is enabled
  # describe directory('/usr/share/tomcat/alf_data/keystore/alfresco/keystore') do
  #   it { should exist }
  #   it { should be_directory }
  # end
  # describe file('/usr/share/tomcat/alf_data/keystore/alfresco/keystore/ssl.keystore') do
  #   it { should exist }
  #   it { should be_file }
  # end
  describe directory('/usr/share/tomcat/shared/classes/alfresco/extension') do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' }
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('nginx') }
    it { should_not be_readable.by_user('nginx') }
    it { should_not be_executable.by_user('nginx') }
  end

  describe file('/usr/share/tomcat/shared/classes/alfresco/log4j.properties') do
    it { should exist }
    it { should be_file }
    its('content') { should match 'log4j.logger.org.hibernate=error' }
    its('content') { should match 'log4j.logger.org.springframework=warn' }
  end

  describe file('/usr/share/tomcat/shared/classes/alfresco-global.properties') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'tomcat' }
    its('group') { should cmp 'tomcat' }
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('nginx') }
    it { should_not be_readable.by_user('nginx') }
    it { should_not be_executable.by_user('nginx') }
    its('content') { should match 'db.driver=org.gjt.mm.mysql.Driver' }
    its('content') { should match 'db.username=alfresco' }
  end
  # permissions to be verified
  services.each do |service|
    describe directory("/var/log/tomcat/#{service}/") do
      it { should exist }
      it { should be_directory }
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
