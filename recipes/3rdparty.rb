include_recipe "build-essential::default"
include_recipe "libreoffice::default"
include_recipe "imagemagick::default"

# Community cookbook only supports Ubuntu
# include_recipe "ffmpeg::default"

nux_desktop_rpm_source = "http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm"
nux_desktop_rpm = "#{Chef::Config[:file_cache_path]}/nux-dextop-release-0-5.el7.nux.noarch.rpm"

remote_file nux_desktop_rpm do
  source nux_desktop_rpm_source
end

package "epel-release"
  action :install
end

rpm_package nux_desktop_rpm do
  action :install
end

package "ffmpeg" do
  action :install
end

if node['platform_family'] != "rhel" and node['alfresco']['version'] < "5.0"
  include_recipe "swftools::default"
end
