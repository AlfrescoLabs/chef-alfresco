# maven_repos               = node['alfresco']['maven']['repos']
# 
# share_warpath             = node['alfresco']['share']['war_path']
# share_groupId             = node['alfresco']['share']['groupId']
# share_artifactId          = node['alfresco']['share']['artifactId']
# share_version             = node['alfresco']['share']['version']
# 
# webapp_dir                = node['tomcat']['webapp_dir']
# tomcat_dir                = node['tomcat']['home']
# tomcat_base_dir           = node['tomcat']['base']
# tomcat_user               = node['tomcat']['user']
# tomcat_group              = node['tomcat']['group']
# 
# cache_path                = Chef::Config['file_cache_path']

# directory "share-classes-alfresco" do
#   path      "#{tomcat_base_dir}/shared/classes/alfresco"
#   owner     tomcat_user
#   group     tomcat_group
#   mode      "0775"
# end
# 
directory "web-extension" do
  path        "#{node['tomcat']['shared']}/classes/alfresco/web-extension"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end
 
template "share-config-custom.xml" do
  path        "#{node['tomcat']['shared']}/classes/alfresco/web-extension/share-config-custom.xml"
  source      "share-config-custom.xml.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0664"
  subscribes  :create, "directory[web-extension]", :immediately
end

# maven "share" do
#   artifact_id   share_artifactId
#   group_id      share_groupId
#   version       share_version
#   action        :put
#   dest          cache_path
#   owner         tomcat_user
#   packaging     'war'
#   repositories  maven_repos
#   subscribes    :put, "template[share-config-custom.xml]", :immediately
# end
# 
# if !share_warpath.nil?
#   # Deploy the war file as it is
#   ruby_block "deploy-share-warpath" do
#     block do
#       require 'fileutils'
#       FileUtils.cp "#{share_warpath}","#{webapp_dir}/"
#     end
#     notifies :restart, "service[tomcat]"
#   end  
# else
#   ark "share" do
#     url                 "file://#{cache_path}/share.war"
#     path                cache_path
#     owner               tomcat_user
#     action              :put
#     strip_leading_dir   false
#     append_env_path     false
#     subscribes          :put, "maven[share]", :immediately
#   end
# 
#   template "share-log4j" do
#     path        "#{cache_path}/share/WEB-INF/classes/log4j.properties"
#     source      "share-log4j.properties.erb"
#     owner       tomcat_user
#     group       tomcat_group
#     mode        "0664"
#     subscribes  :create, "ark[share]", :immediately
#   end
# 
#   ruby_block "deploy-share" do
#     block do
#       require 'fileutils'
#       FileUtils.rm_rf "#{cache_path}/share/share"
#       FileUtils.cp_r "#{cache_path}/share","#{webapp_dir}/share"
#     end
#     subscribes  :create, "template[share-log4j]", :immediately
#   end
# end
# 
# service "tomcat7"  do
#   action      :restart
#   subscribes  :restart, "ruby-block[deploy-share-warpath]",:immediately
#   subscribes  :restart, "ruby-block[deploy-share]",:immediately
# end