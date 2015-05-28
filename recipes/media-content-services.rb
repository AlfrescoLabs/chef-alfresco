content_services_packages = node['media']['content_services_packages']
content_services_pid_path = node['media']['content_services_pid_path']

# Installing  codecs needed for FFMpeg
content_services_packages.each do |pkg|
  package pkg do
    action :install
  end
end

directory content_services_pid_path do
  action :create
  owner "tomcat"
  group "tomcat"
  recursive true
end

template "/etc/init.d/alfresco-content-services" do
  source "media/alfresco-content-services.erb"
  mode "0755"
end

service "alfresco-content-services" do
  action :enable
end
