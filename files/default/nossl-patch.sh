#!/bin/bash
cd /tmp
mkdir alfresco-war-temp ; cd alfresco-war-temp
unzip /usr/share/tomcat-alfresco/webapps/alfresco.war >> /var/log/messages
mv WEB-INF/web.xml WEB-INF/web.xml.orig
sed 's/api\/solr/fakeurl/' WEB-INF/web.xml.orig >> WEB-INF/web.xml
yum install -y zip >> /var/log/messages
zip -r alfresco.war * >> /var/log/messages
chown tomcat:tomcat alfresco.war >> /var/log/messages
service tomcat-alfresco stop >> /var/log/messages
sleep 5
rm -rf /usr/share/tomcat-alfresco/webapps/* >> /var/log/messages
mv -f alfresco.war /usr/share/tomcat-alfresco/webapps/ >> /var/log/messages
cd .. ; rm -rf alfresco-war-temp >> /var/log/messages
