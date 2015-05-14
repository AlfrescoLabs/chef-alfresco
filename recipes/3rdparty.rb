include_recipe "build-essential::default"
include_recipe "libreoffice::default"
include_recipe "imagemagick::default"

package "libreoffice-headless" do
  action :install
end

# Community cookbook only supports Ubuntu
# include_recipe "ffmpeg::default"

nux_desktop_rpm_source = "http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm"
nux_desktop_rpm = "#{Chef::Config[:file_cache_path]}/nux-dextop-release-0-5.el7.nux.noarch.rpm"

remote_file nux_desktop_rpm do
  source nux_desktop_rpm_source
end

package "epel-release" do
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
else
  #Taken from https://www.centos.org/forums/viewtopic.php?f=48&t=50232
  bash 'install_swftools' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  yum install -y zlib zlib-devel freetype-devel jpeglib-devel giflib-devel libjpeg-turbo-devel
  wget http://www.swftools.org/swftools-2013-04-09-1007.tar.gz -O swftools-2013-04-09-1007.tar.gz
  tar -zvxf swftools-2013-04-09-1007.tar.gz
  cd swftools-2013-04-09-1007
  ./configure --libdir=/usr/lib64 --bindir=/usr/local/bin
  make && make install
  EOH
  not_if "test -f /usr/bin/local/pdf2swf"
  end
end
