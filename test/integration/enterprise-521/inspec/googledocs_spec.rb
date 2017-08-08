control 'alfresco-googledocs-check' do
  impact 0.5
  title 'Check Googledocs is installed and the correct version'

  describe command('java -jar /usr/share/tomcat/bin/alfresco-mmt.jar \
   list /var/lib/tomcat-alfresco/webapps/alfresco.war') do
    its('stdout') { should match /'org.alfresco.integrations.google.docs' installed/ }
    its('stdout') { should match /Version:      3.0.4.1/ }
  end
end
