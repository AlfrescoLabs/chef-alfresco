require 'spec_helper'

describe "Alfresco folder permission" do
  describe file("/usr/share/tomcat-alfresco/webapps") do
    it { should be_owned.by('root') }
    it { should be_writable.by('root') }
    it { should be_readable.by('root') }
    it { should_not be_writable.by('tomcat') }
    it { should be_readable.by('tomcat') }
  end
end
