node.default['artifacts']['share']['enabled']           = true
node.default['artifacts']['sharedclasses']['enabled']   = true

shared_folder     = node['alfresco']['shared']

directory "web-extension" do
  path        "#{shared_folder}/classes/alfresco/web-extension"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

file "#{shared_folder}/classes/alfresco/extension/share-log4j.properties" do
  action :create
  content ""
end

if node['alfresco']['generate.share.config.custom'] == true
  template "share-config-custom.xml" do
    path        "#{shared_folder}/classes/alfresco/web-extension/share-config-custom.xml"
    source      "share-config-custom.xml.erb"
    owner       node['tomcat']['user']
    group       node['tomcat']['group']
    mode        "0664"
  end
end
