node.default['artifacts']['share']['enabled']           = true
node.default['artifacts']['sharedclasses']['enabled']   = true

shared_folder     = node['alfresco']['shared']
share_log4j_path   = node['alfresco']['share-log4j-path']

#TODO - make it generic using File.dirName(share_log4j_path)
directory "web-extension" do
  path        "#{shared_folder}/classes/alfresco/web-extension"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

file share_log4j_path do
  action :create
  content ""
end

template "share-config-custom.xml" do
  path        "#{shared_folder}/classes/alfresco/web-extension/share-config-custom.xml"
  source      "share-config-custom.xml.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0664"
  #TODO - not working; for now, we run it all the time
  only_if     { node['alfresco']['generate.share.config.custom'] == 'true' }
end
