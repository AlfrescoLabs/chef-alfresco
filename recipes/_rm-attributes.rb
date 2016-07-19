if node['alfresco']['edition'] == 'enterprise'

  node.default['artifacts']['alfresco-rm-core-repo']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-core-repo']['artifactId'] = "alfresco-rm-core-repo"
  node.default['artifacts']['alfresco-rm-core-repo']['version'] = "2.4"
  node.default['artifacts']['alfresco-rm-core-repo']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-core-repo']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-core-repo']['destination'] = node['alfresco']['amps_folder']

  node.default['artifacts']['alfresco-rm-core-share']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-core-share']['artifactId'] = "alfresco-rm-core-share"
  node.default['artifacts']['alfresco-rm-core-share']['version'] = "2.4"
  node.default['artifacts']['alfresco-rm-core-share']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-core-share']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-core-share']['destination'] = node['alfresco']['amps_share_folder']

  node.default['artifacts']['alfresco-rm-enterprise-repo']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-enterprise-repo']['artifactId'] = "alfresco-rm-enterprise-repo"
  node.default['artifacts']['alfresco-rm-enterprise-repo']['version'] = "2.4"
  node.default['artifacts']['alfresco-rm-enterprise-repo']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-enterprise-repo']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-enterprise-repo']['destination'] = node['alfresco']['amps_folder']

  node.default['artifacts']['alfresco-rm-enterprise-share']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-enterprise-share']['artifactId'] = "alfresco-rm-enterprise-share"
  node.default['artifacts']['alfresco-rm-enterprise-share']['version'] = "2.4"
  node.default['artifacts']['alfresco-rm-enterprise-share']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-enterprise-share']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-enterprise-share']['destination'] = node['alfresco']['amps_share_folder']

else

  node.default['artifacts']['alfresco-rm-community-repo']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-community-repo']['artifactId'] = "alfresco-rm-community-repo"
  node.default['artifacts']['alfresco-rm-community-repo']['version'] = "2.4.b"
  node.default['artifacts']['alfresco-rm-community-repo']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-community-repo']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-community-repo']['destination'] = node['alfresco']['amps_folder']

  node.default['artifacts']['alfresco-rm-community-share']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-community-share']['artifactId'] = "alfresco-rm-community-share"
  node.default['artifacts']['alfresco-rm-community-share']['version'] = "2.4.b"
  node.default['artifacts']['alfresco-rm-community-share']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-community-share']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-community-share']['destination'] = node['alfresco']['amps_share_folder']

end
