control 'alfresco-05' do
  impact 0.5
  title 'Installed Amps'

  describe command('java -jar /usr/share/tomcat-multi/bin/alfresco-mmt.jar \
   list /usr/share/tomcat-multi/alfresco/webapps/alfresco.war') do
    its('stdout') { should match /'alfresco-share-services' installed/ }
    its('stdout') { should match /'org_alfresco_module_rm' installed/ }
    its('stdout') { should match /'alfresco-rm-enterprise-repo' installed/ }
    its('stdout') { should match /'alfresco-aos-module' installed/ }
  end

  describe command('java -jar /usr/share/tomcat-multi/bin/alfresco-mmt.jar \
   list /usr/share/tomcat-multi/share/webapps/share.war') do
    its('stdout') { should match /'alfresco-rm-enterprise-share' installed/ }
  end
end
