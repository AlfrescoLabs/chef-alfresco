if node['alfresco']['edition'] == 'enterprise'
  node.default['artifacts']['alfresco-rm-enterprise-repo']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-enterprise-repo']['artifactId'] = "alfresco-rm-enterprise-repo"
  node.default['artifacts']['alfresco-rm-enterprise-repo']['version'] = "2.5.0.1"
  node.default['artifacts']['alfresco-rm-enterprise-repo']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-enterprise-repo']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-enterprise-repo']['destination'] = node['alfresco']['amps_folder']

  node.default['artifacts']['alfresco-rm-enterprise-share']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-enterprise-share']['artifactId'] = "alfresco-rm-enterprise-share"
  node.default['artifacts']['alfresco-rm-enterprise-share']['version'] = "2.5.0.1"
  node.default['artifacts']['alfresco-rm-enterprise-share']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-enterprise-share']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-enterprise-share']['destination'] = node['alfresco']['amps_share_folder']

else

  node.default['artifacts']['alfresco-rm-community-repo']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-community-repo']['artifactId'] = "alfresco-rm-community-repo"
  node.default['artifacts']['alfresco-rm-community-repo']['version'] = "2.5.a"
  node.default['artifacts']['alfresco-rm-community-repo']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-community-repo']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-community-repo']['destination'] = node['alfresco']['amps_folder']

  node.default['artifacts']['alfresco-rm-community-share']['groupId'] = "org.alfresco"
  node.default['artifacts']['alfresco-rm-community-share']['artifactId'] = "alfresco-rm-community-share"
  node.default['artifacts']['alfresco-rm-community-share']['version'] = "2.5.a"
  node.default['artifacts']['alfresco-rm-community-share']['type'] = "amp"
  node.default['artifacts']['alfresco-rm-community-share']['owner'] = node['alfresco']['user']
  node.default['artifacts']['alfresco-rm-community-share']['destination'] = node['alfresco']['amps_share_folder']

end
