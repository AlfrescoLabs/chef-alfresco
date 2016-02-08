
node.default['media']['content_services_folder'] = "#{node['artifacts']['media']['destination']}/media/remote-node"
node.default['media']['content_services_jar_path'] = "#{node['media']['content_services_folder']}/content-services-node-#{node['artifacts']['media']['version']}.jar"
node.default['media']['content_services_content_path'] = "#{node['artifacts']['media']['destination']}/media/AlfrescoContentServices"

node.default['media']['source']['file']['path'] = node['media']['content_services_content_path']
node.default['media']['target']['file']['path'] = node['media']['content_services_content_path']

node.default['artifacts']['media']['owner'] = node['alfresco']['user']

node.default['amps']['repo']['media']['path'] = "#{node['artifacts']['media']['destination']}/media/amps-repository/alfresco-mm-repo-#{node['artifacts']['media']['version']}.amp"
node.default['amps']['repo']['media']['owner'] = node['alfresco']['user']
node.default['amps']['repo']['media']['type'] = "amp"

node.default['amps']['share']['media']['path'] = "#{node['artifacts']['media']['destination']}/media/amps-share/alfresco-mm-share-#{node['artifacts']['media']['version']}.amp"
node.default['amps']['share']['media']['owner'] = node['alfresco']['user']
node.default['amps']['share']['media']['type'] = "amp"
