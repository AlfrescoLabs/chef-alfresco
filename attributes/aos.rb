default['artifacts']['_vti_bin']['groupId'] = node['alfresco']['groupId']
default['artifacts']['_vti_bin']['artifactId'] = "alfresco-enterprise-vti-bin"
default['artifacts']['_vti_bin']['version'] = node['alfresco']['version']
default['artifacts']['_vti_bin']['type'] = 'war'
default['artifacts']['_vti_bin']['destination'] = node['tomcat']['webapp_dir']
default['artifacts']['_vti_bin']['owner'] = node['alfresco']['user']

default['artifacts']['ROOT']['groupId'] = node['alfresco']['groupId']
default['artifacts']['ROOT']['artifactId'] = "alfresco-enterprise-server-root"
default['artifacts']['ROOT']['version'] = node['alfresco']['version']
default['artifacts']['ROOT']['type'] = 'war'
default['artifacts']['ROOT']['destination'] = node['tomcat']['webapp_dir']
default['artifacts']['ROOT']['owner'] = node['alfresco']['user']
