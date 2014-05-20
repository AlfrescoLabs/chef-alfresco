services          = node['alfresco']['system_services']
service_action    = node['alfresco']['system_service_action']

amps_folder       = node['alfresco']['amps_folder']
amps_share_folder = node['alfresco']['amps_share_folder']
bin_folder        = node['alfresco']['bin']
user              = node['tomcat']['user']
group             = node['tomcat']['group']

directory "amps-repo" do
  path        amps_folder
  owner       user
  group       group
  mode        "0775"
  recursive   true
end

directory "amps-share" do
  path        amps_share_folder
  owner       user
  group       group
  mode        "0775"
  recursive   true
end

template "apply_amps.sh" do
  path        "#{bin_folder}/apply_amps.sh"
  source      "apply_amps.sh.erb"
  owner       user
  group       group
  mode        "0775"
end

execute "run-apply-amps" do
  command "./apply_amps.sh"
  cwd         bin_folder
  user        user
  group       group
end

services.each do |service_name|
  service service_name  do
    action    service_action
  end
end