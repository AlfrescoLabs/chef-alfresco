control 'alfresco-07' do
  impact 0.5
  title 'Solr properties'

  describe file('/usr/share/tomcat-multi/alf_data/solrhome/archive-SpacesStore/conf/solrcore.properties') do
    it { should exist }
    it { should be_file }
    its('content') { should match 'enable.alfresco.tracking=true' }
    its('content') { should match 'alfresco.version=5.1.2' }
  end

  describe file('/usr/share/tomcat-multi/alf_data/solrhome/workspace-SpacesStore/conf/solrcore.properties') do
    it { should exist }
    it { should be_file }
    its('content') { should match 'enable.alfresco.tracking=true' }
    its('content') { should match 'alfresco.version=5.1.2' }
  end
end
