node.default['amps']['repo']['rm']['groupId'] = 'org.alfresco'
node.default['amps']['repo']['rm']['artifactId'] = 'alfresco-rm'
node.default['amps']['repo']['rm']['version'] = '2.3'
node.default['amps']['repo']['rm']['destination'] = node['alfresco']['amps_folder']
node.default['amps']['repo']['rm']['owner'] = node['alfresco']['user']
node.default['amps']['repo']['rm']['type'] = "amp"

node.default['amps']['share']['rm']['groupId'] = 'org.alfresco'
node.default['amps']['share']['rm']['artifactId'] = 'alfresco-rm-share'
node.default['amps']['share']['rm']['version'] = '2.3'
node.default['amps']['share']['rm']['destination'] = node['alfresco']['amps_share_folder']
node.default['amps']['share']['rm']['owner'] = node['alfresco']['user']
node.default['amps']['share']['rm']['type'] = "amp"
