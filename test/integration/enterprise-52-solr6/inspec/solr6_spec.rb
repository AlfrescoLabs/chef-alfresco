control "alfresco-09" do
  impact 0.5
  title "Solr6"

  describe service('solr') do
    it { should be_installed }
    it { should be_enabled }
    # it { should be_running }
  end

  describe directory("/opt/alfresco-search-services/") do
    it { should exist }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
    it { should be_readable.by_user('root') }
    it { should be_writable.by_user('root') }
    it { should_not be_writable.by_user('solr') }
  end
  #
  describe file('/etc/default/solr.in.sh') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
    it { should be_readable.by_user('root') }
    it { should be_writable.by_user('root') }
    it { should be_readable.by_user('solr') }
    it { should_not be_writable.by_user('solr') }
  end

  describe file('/var/solr/log4j.properties') do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'solr' }
    its('group') { should cmp 'solr' }
    it { should be_readable.by_user('solr') }
    it { should be_writable.by_user('solr') }
    it { should_not be_writable.by_user('tomcat') }
    it { should_not be_readable.by_user('tomcat') }
  end

  describe file '/etc/init.d/solr' do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
    it { should be_readable.by_user('root') }
    it { should be_writable.by_user('root') }
    it { should be_executable.by_user('root') }
    it { should_not be_writable.by_user('solr') }
    it { should be_readable.by_user('solr') }
    it { should_not be_executable.by_user('solr') }
  end

  describe directory '/opt/alfresco-search-services/solrhome' do
    it { should_not exist }
  end

  describe file '/var/solr/data/conf/shared.properties' do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'solr' }
    its('group') { should cmp 'solr' }
    it { should be_readable.by_user('solr') }
    it { should_not be_writable.by_user('solr') }
    it { should_not be_executable.by_user('solr') }
    it { should_not be_writable.by_user('tomcat') }
    it { should_not be_readable.by_user('tomcat') }
    its('content') { should match("solr.host=127.0.0.1") }
    its('content') { should match("solr.port=9000") }
    its('content') { should match("solr.baseurl=/solr") }
  end

  describe file '/var/solr/data/templates/rerank/conf/solrcore.properties' do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'solr' }
    its('group') { should cmp 'solr' }
    it { should be_readable.by_user('solr') }
    it { should_not be_writable.by_user('solr') }
    it { should_not be_executable.by_user('solr') }
    it { should_not be_writable.by_user('tomcat') }
    it { should_not be_readable.by_user('tomcat') }
    its('content') { should match("alfresco.port=9000") }
    its('content') { should match("alfresco.host=localhost") }
  end

  describe directory '/opt/alfresco-search-services/solr/bin' do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
    it { should be_readable.by_user('root') }
    it { should be_writable.by_user('root') }
    it { should be_executable.by_user('root') }
    it { should be_readable.by_user('solr') }
    it { should be_executable.by_user('solr') }
    it { should_not be_writable.by_user('solr') }
  end

  describe directory '/var/log/solr' do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'solr' }
    its('group') { should cmp 'solr' }
    it { should be_readable.by_user('solr') }
    it { should be_writable.by_user('solr') }
    it { should be_executable.by_user('solr') }
    it { should_not be_readable.by_user('tomcat') }
    it { should_not be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('tomcat') }
  end

  describe file '/var/log/solr/solr.log' do
    it { should exist }
    it { should be_file }
    its('owner') { should cmp 'solr' }
    its('group') { should cmp 'solr' }
    it { should be_readable.by_user('solr') }
    it { should be_writable.by_user('solr') }
    it { should_not be_executable.by_user('solr') }
    it { should_not be_readable.by_user('tomcat') }
    it { should_not be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('tomcat') }
  end

  describe directory '/var/solr/data' do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'solr' }
    its('group') { should cmp 'solr' }
    it { should be_readable.by_user('solr') }
    it { should be_writable.by_user('solr') }
    it { should be_executable.by_user('solr') }
    it { should_not be_readable.by_user('tomcat') }
    it { should_not be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('tomcat') }
  end

  describe directory '/var/solr/data/archive' do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'solr' }
    its('group') { should cmp 'solr' }
    it { should be_readable.by_user('solr') }
    it { should be_writable.by_user('solr') }
    it { should be_executable.by_user('solr') }
    it { should_not be_readable.by_user('tomcat') }
    it { should_not be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('tomcat') }
  end

  describe directory '/var/solr/data/alfresco' do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'solr' }
    its('group') { should cmp 'solr' }
    it { should be_readable.by_user('solr') }
    it { should be_writable.by_user('solr') }
    it { should be_executable.by_user('solr') }
    it { should_not be_readable.by_user('tomcat') }
    it { should_not be_executable.by_user('tomcat') }
    it { should_not be_writable.by_user('tomcat') }
  end

  describe command('service solr status') do
    its('stdout') { should match /Found 1 Solr nodes:/ }
    its('stdout') { should match /Solr process ([^\s]+) running on port 8090/ }
    its('stdout') { should match /\"solr_home\":\"\/var\/solr\/data\"/ }
  end
end
