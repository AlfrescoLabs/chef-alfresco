control 'alfresco-03' do
  impact 0.7
  title 'RM existance checks'
  desc 'Checks to be sure that RM has been downloaded correctly'

  describe file('/usr/share/tomcat/amps/alfresco-rm-enterprise-repo.amp') do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end

  describe file('/usr/share/tomcat/amps_share/alfresco-rm-enterprise-share.amp') do
    it { should exist }
    it { should be_owned_by 'tomcat' }
  end
end
