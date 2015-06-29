
node.default['media']['content_services_folder'] = "#{node['artifacts']['media']['destination']}/media/remote-node"
node.default['media']['content_services_jar_path'] = "#{node['media']['content_services_folder']}/content-services-node-#{node['artifacts']['media']['version']}.jar"
node.default['media']['content_services_content_path'] = "#{node['artifacts']['media']['destination']}/media/AlfrescoContentServices"

node.default['media']['source']['file']['path'] = node['media']['content_services_content_path']
node.default['media']['target']['file']['path'] = node['media']['content_services_content_path']

node.default['artifacts']['media']['owner'] = node['alfresco']['user']

node.default['artifacts']['media-repo']['path'] = "#{node['artifacts']['media']['destination']}/media/amps-repository/alfresco-mm-repo-#{node['artifacts']['media']['version']}.amp"
node.default['artifacts']['media-repo']['destination'] = node['alfresco']['amps_folder']
node.default['artifacts']['media-repo']['owner'] = node['alfresco']['user']
node.default['artifacts']['media-repo']['type'] = "amp"

node.default['artifacts']['media-share']['path'] = "#{node['artifacts']['media']['destination']}/media/amps-share/alfresco-mm-share-#{node['artifacts']['media']['version']}.amp"
node.default['artifacts']['media-share']['destination'] = node['alfresco']['amps_share_folder']
node.default['artifacts']['media-share']['owner'] = node['alfresco']['user']
node.default['artifacts']['media-share']['type'] = "amp"
