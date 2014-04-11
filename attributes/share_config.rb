default['artifacts']['share']['groupId'] = node['alfresco']['groupId']
default['artifacts']['share']['artifactId'] = node['share']['artifactId']
default['artifacts']['share']['version'] = node['alfresco']['version']
default['artifacts']['share']['type'] = "war"
default['artifacts']['share']['destination'] = node['tomcat']['webapps']
default['artifacts']['share']['owner'] = node['tomcat']['user']
default['artifacts']['share']['unzip'] = false

default['alfresco']['share']['alfresco_protocol'] = node['alfresco']['url']['repo']['protocol']
default['alfresco']['share']['alfresco_host']     = node['alfresco']['url']['repo']['host']
default['alfresco']['share']['alfresco_port']     = node['alfresco']['url']['repo']['port']
default['alfresco']['share']['alfresco_context']  = node['alfresco']['url']['repo']['context']