# destination has to be set at recipe time since amp_folder path is calculated at recipe time
node.default['artifacts']['alfresco-rm-enterprise-repo']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['alfresco-rm-enterprise-share']['destination'] = node['alfresco']['amps_share_folder']
node.default['artifacts']['alfresco-rm-community-repo']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['alfresco-rm-community-share']['destination'] = node['alfresco']['amps_share_folder']
node.default['artifacts']['alfresco-rm-core-repo']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['alfresco-rm-core-share']['destination'] = node['alfresco']['amps_share_folder']
node.default['artifacts']['alfresco-rm-server']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['alfresco-rm-share']['destination'] = node['alfresco']['amps_share_folder']

if node['alfresco']['edition'] == 'enterprise'
  if alf_version_ge?('5.0') && alf_version_lt?('5.1.0')
    node.default['artifacts']['alfresco-rm-server']['enabled'] = true
    node.default['artifacts']['alfresco-rm-share']['version'] = '2.3.1'
    node.default['artifacts']['alfresco-rm-server']['enabled'] = true
    node.default['artifacts']['alfresco-rm-share']['version'] = '2.3.1'
  elsif alf_version_ge?('5.1.0') && alf_version_lt?('5.1.1')
    node.default['artifacts']['alfresco-rm-core-share']['enabled'] = true
    node.default['artifacts']['alfresco-rm-core-repo']['enabled'] = true
    node.default['artifacts']['alfresco-rm-enterprise-share']['enabled'] = true
    node.default['artifacts']['alfresco-rm-enterprise-share']['version'] = '2.4.0.1'
    node.default['artifacts']['alfresco-rm-enterprise-repo']['enabled'] = true
    node.default['artifacts']['alfresco-rm-enterprise-repo']['version'] = '2.4.0.1'
  elsif alf_version_ge?('5.1.1') && alf_version_lt?('5.2.0')
    node.default['artifacts']['alfresco-rm-enterprise-share']['enabled'] = true
    node.default['artifacts']['alfresco-rm-enterprise-share']['version'] = '2.5.0.1'
    node.default['artifacts']['alfresco-rm-enterprise-repo']['enabled'] = true
    node.default['artifacts']['alfresco-rm-enterprise-repo']['version'] = '2.5.0.1'
  elsif alf_version_ge?('5.2.0')
    node.default['artifacts']['alfresco-rm-enterprise-share']['enabled'] = true
    node.default['artifacts']['alfresco-rm-enterprise-share']['version'] = '2.5.1'
    node.default['artifacts']['alfresco-rm-enterprise-repo']['enabled'] = true
    node.default['artifacts']['alfresco-rm-enterprise-repo']['version'] = '2.5.1'
  end

elsif node['alfresco']['edition'] == 'community'
  if alf_version_ge?('5.0.a') && alf_version_lt?('5.1.a')
    node.default['artifacts']['alfresco-rm-server']['enabled'] = true
    node.default['artifacts']['alfresco-rm-share']['version'] = '2.3.c'
    node.default['artifacts']['alfresco-rm-server']['enabled'] = true
    node.default['artifacts']['alfresco-rm-share']['version'] = '2.3.c'

  elsif alf_version_ge?('5.1.a') && alf_version_lt?('5.2.a')
    node.default['artifacts']['alfresco-rm-community-share']['enabled'] = true
    node.default['artifacts']['alfresco-rm-community-share']['version'] = '2.4.b'
    node.default['artifacts']['alfresco-rm-community-repo']['enabled'] = true
    node.default['artifacts']['alfresco-rm-community-repo']['enabled'] = '2.4.b'

  elsif alf_version_ge?('5.2.a') && alf_version_le?('5.2.b')
    node.default['artifacts']['alfresco-rm-community-share']['enabled'] = true
    node.default['artifacts']['alfresco-rm-community-share']['version'] = '2.5.a'
    node.default['artifacts']['alfresco-rm-community-repo']['enabled'] = true
    node.default['artifacts']['alfresco-rm-community-repo']['version'] = '2.5.a'
  end
end
