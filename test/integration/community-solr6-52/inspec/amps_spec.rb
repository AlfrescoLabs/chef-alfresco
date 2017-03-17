control 'alfresco-05' do
  impact 0.5
  title 'Installed Amps'

  describe command('java -jar /usr/share/tomcat/bin/alfresco-mmt.jar \
   list /var/lib/tomcat-alfresco/webapps/alfresco.war') do
    its('stdout') { should match /'alfresco-share-services' installed/ }
    its('stdout') { should match /'org.alfresco.integrations.google.docs' installed/ }
  end

  describe command('java -jar /usr/share/tomcat/bin/alfresco-mmt.jar \
   list /var/lib/tomcat-share/webapps/share.war') do
    its('stdout') { should match /'org.alfresco.integrations.share.google.docs' installed/ }
  end
end
