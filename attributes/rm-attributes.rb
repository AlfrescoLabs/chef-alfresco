# rm 2.5/2.4 enterprise repo
default['artifacts']['alfresco-rm-enterprise-repo']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-rm-enterprise-repo']['artifactId'] = 'alfresco-rm-enterprise-repo'
default['artifacts']['alfresco-rm-enterprise-repo']['type'] = 'amp'
default['artifacts']['alfresco-rm-enterprise-repo']['owner'] = node['alfresco']['user']
default['artifacts']['alfresco-rm-enterprise-repo']['enabled'] = false

# rm 2.5/2.4 enterprise share
default['artifacts']['alfresco-rm-enterprise-share']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-rm-enterprise-share']['artifactId'] = 'alfresco-rm-enterprise-share'
default['artifacts']['alfresco-rm-enterprise-share']['type'] = 'amp'
default['artifacts']['alfresco-rm-enterprise-share']['owner'] = node['alfresco']['user']
default['artifacts']['alfresco-rm-enterprise-share']['enabled'] = false

# rm 2.5/2.4 community repo
default['artifacts']['alfresco-rm-community-repo']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-rm-community-repo']['artifactId'] = 'alfresco-rm-community-repo'
default['artifacts']['alfresco-rm-community-repo']['type'] = 'amp'
default['artifacts']['alfresco-rm-community-repo']['owner'] = node['alfresco']['user']
default['artifacts']['alfresco-rm-community-repo']['enabled'] = false

# rm 2.5/2.4 community share
default['artifacts']['alfresco-rm-community-share']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-rm-community-share']['artifactId'] = 'alfresco-rm-community-share'
default['artifacts']['alfresco-rm-community-share']['type'] = 'amp'
default['artifacts']['alfresco-rm-community-share']['owner'] = node['alfresco']['user']
default['artifacts']['alfresco-rm-community-share']['enabled'] = false

# rm 2.4 enterprise core repo
default['artifacts']['alfresco-rm-core-repo']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-rm-core-repo']['artifactId'] = 'alfresco-rm-core-repo'
default['artifacts']['alfresco-rm-core-repo']['version'] = '2.4.0.1'
default['artifacts']['alfresco-rm-core-repo']['type'] = 'amp'
default['artifacts']['alfresco-rm-core-repo']['owner'] = node['alfresco']['user']
default['artifacts']['alfresco-rm-core-repo']['enabled'] = false

# rm 2.4 enterprise core share
default['artifacts']['alfresco-rm-core-share']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-rm-core-share']['artifactId'] = 'alfresco-rm-core-share'
default['artifacts']['alfresco-rm-core-share']['version'] = '2.4.0.1'
default['artifacts']['alfresco-rm-core-share']['type'] = 'amp'
default['artifacts']['alfresco-rm-core-share']['owner'] = node['alfresco']['user']
default['artifacts']['alfresco-rm-core-share']['enabled'] = false

# rm 2.3 community/enterprise repo
default['artifacts']['alfresco-rm-server']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-rm-server']['artifactId'] = 'alfresco-rm-server'
default['artifacts']['alfresco-rm-server']['type'] = 'amp'
default['artifacts']['alfresco-rm-server']['owner'] = node['alfresco']['user']
default['artifacts']['alfresco-rm-server']['enabled'] = false

# rm 2.3 community/enterprise share
default['artifacts']['alfresco-rm-share']['groupId'] = 'org.alfresco'
default['artifacts']['alfresco-rm-share']['artifactId'] = 'alfresco-rm-share'
default['artifacts']['alfresco-rm-share']['type'] = 'amp'
default['artifacts']['alfresco-rm-share']['owner'] = node['alfresco']['user']
default['artifacts']['alfresco-rm-share']['enabled'] = false
