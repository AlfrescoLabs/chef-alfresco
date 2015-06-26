node.default['artifacts']['rm']['groupId'] = 'org.alfresco'
node.default['artifacts']['rm']['artifactId'] = 'alfresco-rm'
node.default['artifacts']['rm']['version'] = '2.3'
node.default['artifacts']['rm']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['rm']['owner'] = node['alfresco']['user']
node.default['artifacts']['rm']['type'] = "amp"

node.default['artifacts']['rm-share']['groupId'] = 'org.alfresco'
node.default['artifacts']['rm-share']['artifactId'] = 'alfresco-rm-share'
node.default['artifacts']['rm-share']['version'] = '2.3'
node.default['artifacts']['rm-share']['destination'] = node['alfresco']['amps_share_folder']
node.default['artifacts']['rm-share']['owner'] = node['alfresco']['user']
node.default['artifacts']['rm-share']['type'] = "amp"
