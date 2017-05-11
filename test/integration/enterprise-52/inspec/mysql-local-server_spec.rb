control 'alfresco-11' do
  impact 0.7
  title 'MySQL local server'
  desc 'Checks for mysql local server'

  describe directory('/tmp') do
    it { should exist }
    it { should be_directory }
    its('owner') { should cmp 'root' }
    its('group') { should cmp 'root' }
    it { should be_readable.by_user('root') }
    it { should be_writable.by_user('root') }
    it { should be_executable.by_user('root') }
    it { should be_readable.by_user('tomcat') }
    it { should be_writable.by_user('tomcat') }
    it { should be_executable.by_user('tomcat') }
  end

  describe service('mysql-default') do
    it { should be_installed }
    it { should be_running }
  end

  describe command('rpm -qa | grep mysql') do
    its(:stdout) { should include('5.6') }
  end
  describe port(3306) do
    it { should be_listening }
    its('processes') { should include 'mysqld' }
  end
end
