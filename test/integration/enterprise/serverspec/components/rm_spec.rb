require 'spec_helper'

describe "RM components" do
  describe file("/usr/share/tomcat/amps/alfresco-rm-enterprise-repo.amp") do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end

  describe file("/usr/share/tomcat/amps_share/alfresco-rm-enterprise-share.amp") do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end
end
