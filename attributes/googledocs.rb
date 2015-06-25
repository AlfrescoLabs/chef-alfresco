default['artifacts']['googledocs-repo']['groupId'] = 'org.alfresco.integrations'
default['artifacts']['googledocs-repo']['artifactId'] = 'alfresco-googledocs-repo'
default['artifacts']['googledocs-repo']['version'] = '3.0.2'
default['artifacts']['googledocs-repo']['destination'] = node['alfresco']['amps_folder']
default['artifacts']['googledocs-repo']['owner'] = node['alfresco']['user']
default['artifacts']['googledocs-repo']['type'] = "amp"

default['artifacts']['googledocs-share']['groupId'] = 'org.alfresco.integrations'
default['artifacts']['googledocs-share']['artifactId'] = 'alfresco-googledocs-share'
default['artifacts']['googledocs-share']['version'] = '3.0.2'
default['artifacts']['googledocs-share']['destination'] = node['alfresco']['amps_share_folder']
default['artifacts']['googledocs-share']['owner'] = node['alfresco']['user']
default['artifacts']['googledocs-share']['type'] = "amp"
