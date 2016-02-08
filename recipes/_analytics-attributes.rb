node.default['analytics']['analytics_path'] = "#{node['artifacts']['alfresco-pentaho']['destination']}/alfresco-analytics-1.0.2"
node.default['analytics']['ba_server_path'] = "#{node['analytics']['analytics_path']}/ba-server"
node.default['analytics']['license_installer_path'] = "#{node['analytics']['analytics_path']}/license-installer"

node.default['analytics']['license_paths'] = "#{node['analytics']['license_root_path']}/license1.lic"

# TODO - there's no default location publicly available,
# since artifacts.alfresco.com doesn't contain analytics yet
node.default['artifacts']['analytics']['destination'] = '/tmp'
node.default['artifacts']['analytics']['unzip'] = true
node.default['artifacts']['analytics']['type'] = "zip"
node.default['artifacts']['analytics']['owner'] = node['alfresco']['user']

node.default['amps']['repo']['analytics']['path'] = "#{node['artifacts']['analytics']['destination']}/amps/alfresco-analytics-repo-1.0.amp"
node.default['amps']['repo']['analytics']['owner'] = node['alfresco']['user']
node.default['amps']['repo']['analytics']['type'] = "amp"

node.default['amps']['share']['analytics']['path'] = "#{node['artifacts']['analytics']['destination']}/amps/alfresco-analytics-share-1.0.amp"
node.default['amps']['share']['analytics']['owner'] = node['alfresco']['user']
node.default['amps']['share']['analytics']['type'] = "amp"

node.default['artifacts']['alfresco-pentaho']['destination'] = '/opt/alfresco-pentaho'
node.default['artifacts']['alfresco-pentaho']['unzip'] = true
node.default['artifacts']['alfresco-pentaho']['type'] = "zip"
node.default['artifacts']['alfresco-pentaho']['owner'] = node['alfresco']['user']
