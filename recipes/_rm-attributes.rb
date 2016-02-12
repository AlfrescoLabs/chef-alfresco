node.default['amps']['repo']['rm-repo']['groupId'] = 'org.alfresco'
node.default['amps']['repo']['rm-repo']['artifactId'] = 'alfresco-rm'
node.default['amps']['repo']['rm-repo']['version'] = '2.3'
node.default['amps']['repo']['rm-repo']['destination'] = node['alfresco']['amps_folder']
node.default['amps']['repo']['rm-repo']['owner'] = node['alfresco']['user']
node.default['amps']['repo']['rm-repo']['type'] = "amp"

node.default['amps']['share']['rm-share']['groupId'] = 'org.alfresco'
node.default['amps']['share']['rm-share']['artifactId'] = 'alfresco-rm-share'
node.default['amps']['share']['rm-share']['version'] = '2.3'
node.default['amps']['share']['rm-share']['destination'] = node['alfresco']['amps_share_folder']
node.default['amps']['share']['rm-share']['owner'] = node['alfresco']['user']
node.default['amps']['share']['rm-share']['type'] = "amp"
