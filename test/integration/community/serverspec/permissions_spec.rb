require 'spec_helper'



describe "Alfresco folder permission" do
  describe file("/usr/share/tomcat-alfresco/webapps") do
    it { should be_owned_by 'root' }
    it { should be_writable.by_user('root') }
    it { should be_readable.by_user('root') }
    it { should_not be_writable.by_user('tomcat') }
    it { should be_readable.by_user('tomcat') }
  end

  describe file ()"/usr/share/something/jmxremote.password") do
    it { should be_owned.by('tomcat') }
    it { should be_writable.by('tomcat') }
    it { should be_readable.by('tomcat') }
  end
end
