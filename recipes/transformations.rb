# TODO: - build-essential shouldnt really be here. move it to default (or essentials.rb)
include_recipe 'build-essential::default'

if alf_version_lt?('5.2')
  node.default['alfresco']['libreoffice_version'] = '4.4.5.2'
  node.default['alfresco']['properties']['jodconverter.officeHome'] = '/opt/libreoffice4.4/'
end

node.default['alfresco']['libre_office_name'] = "LibreOffice_#{node['alfresco']['libreoffice_version']}_Linux_x86-64_rpm"
node.default['alfresco']['libre_office_tar_name'] = "#{node['alfresco']['libre_office_name']}.tar.gz"
node.default['alfresco']['libre_office_tar_url'] = "https://downloadarchive.documentfoundation.org/libreoffice/old/#{node['alfresco']['libreoffice_version']}/rpm/x86_64/#{node['alfresco']['libre_office_tar_name']}"

if node['alfresco']['use_libreoffice_os_repo']
  if node['platform'] == 'redhat'
    yum_repos = [
      'rhui-REGION-rhel-server-extras',
      'rhui-REGION-rhel-server-optional',
      'rhui-REGION-rhel-server-source-optional',
    ]
    yum_repos.each do |repo|
      execute "enable-yum-repo-#{repo}" do
        command "yum-config-manager --enable #{repo}"
      end
    end
  end
  # Remove existing libreoffice installation
  package 'libreoffice' do
    action :remove
  end
  # Install the version we specified in attributes
  include_recipe 'libreoffice::default'
else
  libre_office_name = node['alfresco']['libre_office_name']
  libre_office_tar_name = node['alfresco']['libre_office_tar_name']
  libre_office_tar_url = node['alfresco']['libre_office_tar_url']

  remote_file "#{Chef::Config[:file_cache_path]}/#{libre_office_tar_name}" do
    source libre_office_tar_url
    owner node['libreoffice']['user']
    group node['libreoffice']['user']
  end

  execute 'unpack-libreoffice' do
    cwd Chef::Config[:file_cache_path]
    command "tar -xf #{libre_office_tar_name}"
    creates "#{Chef::Config[:file_cache_path]}/#{libre_office_name}"
    not_if "test -d #{Chef::Config[:file_cache_path]}/#{libre_office_name}"
  end

  execute 'install-libreoffice' do
    cwd Chef::Config[:file_cache_path]
    command "yum -y localinstall #{Chef::Config[:file_cache_path]}/#{libre_office_name}/RPMS/*.rpm"
    not_if 'yum list installed | grep libreoffice'
  end

  execute 'change-libreoffice-permissions' do
    command "chown #{node['libreoffice']['user']}:#{node['libreoffice']['user']} -R #{node['alfresco']['properties']['jodconverter.officeHome']}"
  end
end

if node['platform_family'] == 'ubuntu'
  include_recipe 'ffmpeg::default'
  include_recipe 'swftools::default'
elsif node['platform_family'] == 'rhel'
  install_fonts = node['alfresco']['install_fonts']
  exclude_font_packages = node['alfresco']['exclude_font_packages']

  # TODO: - implement it also for Ubuntu using apt-get
  execute 'install-all-fonts' do
    command "yum install -y *fonts.noarch --exclude='#{exclude_font_packages}'"
    only_if { install_fonts && node['platform_family'] == 'rhel' }
  end

  # Taken from https://www.centos.org/forums/viewtopic.php?f=48&t=50232
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
    not_if 'test -f /usr/local/bin/pdf2swf'
    only_if { node['alfresco']['install_swftools'] }
  end
end

imagemagick_path = "#{Chef::Config[:file_cache_path]}/#{node['alfresco']['imagemagick_name']}"
imagemagick_libs_path = "#{Chef::Config[:file_cache_path]}/#{node['alfresco']['imagemagick_libs_name']}"

# Imagemagick OS repo installation
if node['alfresco']['install_imagemagick'] && node['alfresco']['use_imagemagick_os_repo']
  include_recipe 'imagemagick::default'
end

# Imagemagick dependencies
packages = [
  'fftw',
  'libXmu',
  'urw-fonts',
  'libwmf-lite',
  'libtool-ltdl',
  'ghostscript',
  'poppler-data',
  'ghostscript-fonts',
]
packages.each do |package|
  package package do
    action :install
    only_if { node['alfresco']['install_imagemagick'] }
    not_if { node['alfresco']['use_imagemagick_os_repo'] }
  end
end

remote_file imagemagick_libs_path do
  source node['alfresco']['imagemagick_libs_url']
  only_if { node['alfresco']['install_imagemagick'] }
end

rpm_package imagemagick_libs_path do
  action :install
  only_if { node['alfresco']['install_imagemagick'] }
  not_if { node['alfresco']['use_imagemagick_os_repo'] }
end

remote_file imagemagick_path do
  source node['alfresco']['imagemagick_url']
  only_if { node['alfresco']['install_imagemagick'] }
  not_if { node['alfresco']['use_imagemagick_os_repo'] }
end

rpm_package imagemagick_path do
  action :install
  only_if { node['alfresco']['install_imagemagick'] }
  not_if { node['alfresco']['use_imagemagick_os_repo'] }
end

package 'perl-Image-ExifTool' do
  action :install
end
