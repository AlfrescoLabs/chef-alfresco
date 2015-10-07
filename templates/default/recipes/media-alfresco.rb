node.default['media']['install.content.services'] = true

node.default['artifacts']['media']['enabled'] = true
node.default['artifacts']['media-repo']['enabled'] = true
node.default['artifacts']['media-repo-messaging']['enabled'] = true
node.default['artifacts']['media-share']['enabled'] = true

source_type = node['media']['source_type']
target_type = node['media']['target_type']

if source_type == 's3'
  begin
    s3_auth_databag = node['media']['s3_auth_databag']
    s3_auth_databag_item = node['media']['s3_auth_databag_item']
    s3_auth = data_bag_item(s3_auth_databag,s3_auth_databag_item)
    node.default['alfresco']['properties']['content.remote.default.contentRefHandler.source.s3.accessKey'] = s3_auth['aws_access_key_id']
    node.default['alfresco']['properties']['content.remote.default.contentRefHandler.source.s3.secretKey'] = s3_auth['aws_secret_access_key']
    node.default['alfresco']['properties']['content.remote.default.contentRefHandler.target.s3.accessKey'] = s3_auth['aws_access_key_id']
    node.default['alfresco']['properties']['content.remote.default.contentRefHandler.target.s3.secretKey'] = s3_auth['aws_secret_access_key']
  rescue
    Chef::Log.warn("Cannot load databag #{s3_auth_databag}, item #{s3_auth_databag_item}")
  end
end

node.default['alfresco']['properties']['content.remote.default.contentRefHandler.source.type'] = source_type
node.default['alfresco']['properties']['content.remote.default.contentRefHandler.target.type'] = target_type
node['media']['source'][source_type].each do |option,value|
  node.default['alfresco']['properties']["content.remote.default.contentRefHandler.source.#{source_type}.#{option}"] = value
end
node['media']['target'][target_type].each do |option,value|
  node.default['alfresco']['properties']["content.remote.default.contentRefHandler.target.#{target_type}.#{option}"] = value
end
