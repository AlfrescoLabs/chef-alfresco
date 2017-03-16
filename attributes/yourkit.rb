default['yourkit']['package_url'] = 'https://www.yourkit.com/download/yjp-2014-build-14124-linux.tar.bz2'
default['yourkit']['package_path'] = '/tmp/yjp-2014-build-14124-linux.tar.bz2'
default['yourkit']['install_parent_path'] = '/tmp/yourkit'
default['yourkit']['install_path'] = "#{node['yourkit']['install_parent_path']}/yjp-2014-build-14124"
default['yourkit']['session_name'] = node['alfresco']['public_hostname']
