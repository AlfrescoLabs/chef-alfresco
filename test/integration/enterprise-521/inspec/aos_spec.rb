control 'alfresco-aos-check' do
  impact 0.5
  title 'Check AOS is installed and the correct version'

  describe command('java -jar /usr/share/tomcat/bin/alfresco-mmt.jar \
   list /var/lib/tomcat-alfresco/webapps/alfresco.war') do
    its('stdout') { should match /'alfresco-aos-module' installed/ }
    its('stdout') { should match /Version:      1.1.6/ }
  end
end
