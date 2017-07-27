node.default['artifacts']['googledocs-repo']['groupId'] = 'org.alfresco.integrations'
node.default['artifacts']['googledocs-repo']['artifactId'] = 'alfresco-googledocs-repo'
node.default['artifacts']['googledocs-repo']['version'] = '3.0.4'
node.default['artifacts']['googledocs-repo']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['googledocs-repo']['owner'] = node['alfresco']['user']
node.default['artifacts']['googledocs-repo']['type'] = 'amp'

node.default['artifacts']['googledocs-share']['groupId'] = 'org.alfresco.integrations'
node.default['artifacts']['googledocs-share']['artifactId'] = 'alfresco-googledocs-share'
node.default['artifacts']['googledocs-share']['version'] = '3.0.4'
node.default['artifacts']['googledocs-share']['destination'] = node['alfresco']['amps_share_folder']
node.default['artifacts']['googledocs-share']['owner'] = node['alfresco']['user']
node.default['artifacts']['googledocs-share']['type'] = 'amp'
