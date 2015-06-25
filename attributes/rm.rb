default['artifacts']['rm']['groupId'] = 'org.alfresco'
default['artifacts']['rm']['artifactId'] = 'alfresco-rm'
default['artifacts']['rm']['version'] = '2.3'
default['artifacts']['rm']['destination'] = node['alfresco']['amps_folder']
default['artifacts']['rm']['owner'] = node['alfresco']['user']
default['artifacts']['rm']['type'] = "amp"

default['artifacts']['rm-share']['groupId'] = 'org.alfresco'
default['artifacts']['rm-share']['artifactId'] = 'alfresco-rm-share'
default['artifacts']['rm-share']['version'] = '2.3'
default['artifacts']['rm-share']['destination'] = node['alfresco']['amps_share_folder']
default['artifacts']['rm-share']['owner'] = node['alfresco']['user']
default['artifacts']['rm-share']['type'] = "amp"
