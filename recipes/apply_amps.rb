directory "amps-repo" do
  path        node['alfresco']['amps_folder']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
  # subscribes  :create, "template[apply_amps.sh]", :immediately
end

directory "amps-share" do
  path        node['alfresco']['amps_share_folder']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
  # subscribes  :create, "directory[amps-repo]", :immediately
  # notifies    :run, "script[apply_amps.sh]", :immediately
end

template "apply_amps.sh" do
  path        "#{node['tomcat']['bin']}/apply_amps.sh"
  source      "apply_amps.sh.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  # notifies    :run, "execute[run-apply-amps]", :immediately
  # subscribes  :create, "service[tomcat7]", :immediately
end

service "tomcat7" do
  action :stop
end

execute "run-apply-amps" do
  command "./apply_amps.sh"
  cwd     "#{node['tomcat']['bin']}"
  user    node['tomcat']['user']
  group       node['tomcat']['group']
end

service "tomcat7" do
  action :start
end
