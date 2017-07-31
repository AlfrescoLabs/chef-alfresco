control 'alfresco-rm-checks' do
  impact 0.7
  title 'RM has been installed and is the correct version'

  describe command('java -jar /usr/share/tomcat/bin/alfresco-mmt.jar \
   list /var/lib/tomcat-alfresco/webapps/alfresco.war') do
    its('stdout') { should match /'alfresco-rm-enterprise-repo' installed/ }
    its('stdout') { should match /Version:      2.5.2/ }
  end
end
