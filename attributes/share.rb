default['alfresco']['share']['groupId']     = node['alfresco']['groupId']
default['alfresco']['share']['artifactId']  = "share"
default['alfresco']['share']['version']     = node['alfresco']['version']

default['alfresco']['share']['alfresco_protocol'] = node['alfresco']['url']['repo']['protocol']
default['alfresco']['share']['alfresco_host']     = node['alfresco']['url']['repo']['host']
default['alfresco']['share']['alfresco_port']     = node['alfresco']['url']['repo']['port']
default['alfresco']['share']['alfresco_context']  = node['alfresco']['url']['repo']['context']