node.default['artifacts']['_vti_bin']['groupId'] = 'org.alfresco.aos-module'
node.default['artifacts']['_vti_bin']['artifactId'] = 'alfresco-vti-bin'
node.default['artifacts']['_vti_bin']['version'] = '1.1.5'
node.default['artifacts']['_vti_bin']['type'] = 'war'
node.default['artifacts']['_vti_bin']['owner'] = node['alfresco']['user']

node.default['artifacts']['ROOT']['groupId'] = node['alfresco']['groupId']
node.default['artifacts']['ROOT']['artifactId'] = 'alfresco-server-root'
node.default['artifacts']['ROOT']['version'] = node['alfresco']['version']
node.default['artifacts']['ROOT']['type'] = 'war'
node.default['artifacts']['ROOT']['owner'] = node['alfresco']['user']

node.default['artifacts']['aos-module']['groupId'] = 'org.alfresco.aos-module'
node.default['artifacts']['aos-module']['artifactId'] = 'alfresco-aos-module'
node.default['artifacts']['aos-module']['version'] = '1.1.5'
node.default['artifacts']['aos-module']['type'] = 'amp'
node.default['artifacts']['aos-module']['owner'] = node['alfresco']['user']
node.default['artifacts']['aos-module']['destination'] = '/usr/share/tomcat/amps'
