include_recipe "build-essential::default"
include_recipe "libreoffice::default"
include_recipe "imagemagick::default"

if node['platform_family'] == "ubuntu"
  include_recipe "ffmpeg::default"
  include_recipe "swftools::default"
elsif node['platform_family'] == "rhel"
  install_fonts = node['alfresco']['install_fonts']
  exclude_font_packages = node['alfresco']['exclude_font_packages']

  # TODO - implement it also for Ubuntu using apt-get
  execute "install-all-fonts" do
    command "yum install -y *fonts.noarch --exclude='#{exclude_font_packages}'"
    only_if { install_fonts and node['platform_family'] == "rhel" }
  end

  #Taken from https://www.centos.org/forums/viewtopic.php?f=48&t=50232
  bash 'install_swftools' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    yum install -y wget zlib zlib-devel freetype-devel jpeglib-devel giflib-devel libjpeg-turbo-devel
    wget http://www.swftools.org/swftools-2013-04-09-1007.tar.gz -O swftools-2013-04-09-1007.tar.gz
    tar -zvxf swftools-2013-04-09-1007.tar.gz
    cd swftools-2013-04-09-1007
    ./configure --libdir=/usr/lib64 --bindir=/usr/local/bin
    make && make install
    EOH
    not_if "test -f /usr/local/bin/pdf2swf"
  end
end

package "libreoffice-headless" do
  action :install
end

package "perl-Image-ExifTool" do
  action :install
end
