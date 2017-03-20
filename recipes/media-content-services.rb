content_services_packages = node['media']['content_services_packages']
content_services_pid_path = node['media']['content_services_pid_path']
content_services_log_path = node['media']['content_services_log_path']
content_services_config_path = node['media']['content_services_config_path']
content_services_user = node['media']['content_services_user']

# Fixing temporary downtime of atrpms,
# used for libmp3lame0 package

# TODO: - switch to http://repo.enetres.net/
# Read more on  http://vicendominguez.blogspot.nl/2015/09/atrpms-is-dead-and-i-need-ffmpeg-for.html

# node.set['yum']['atrpms']['baseurl'] = "https://www.mirrorservice.org/sites/dl.atrpms.net/el$releasever-$basearch/atrpms/stable"
# node.set['yum']['atrpms']['gpgcheck'] = false

# Doesn't work, we set yum repo manually
# include_recipe 'yum-atrpms::default'
template '/etc/yum.repos.d/atrpms.repo' do
  source 'yum/atrpms.repo.erb'
end

user content_services_user do
  action :create
  shell '/sbin/nologin'
end

# Installing  codecs needed for FFMpeg
content_services_packages.each do |pkg|
  package pkg do
    action :install
  end
end

template content_services_config_path do
  source 'media/config.yml.erb'
  owner content_services_user
end

directory content_services_log_path do
  action :create
  owner content_services_user
  recursive true
end

directory content_services_pid_path do
  action :create
  owner content_services_user
  recursive true
end

template '/etc/init.d/alfresco-content-services' do
  source 'media/alfresco-content-services.erb'
  mode '0755'
end

service 'alfresco-content-services' do
  action :enable
end
