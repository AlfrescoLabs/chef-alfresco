node.default['artifacts']['analytics']['enabled'] = true
node.default['artifacts']['analytics-repo']['enabled'] = true
node.default['artifacts']['analytics-share']['enabled'] = true
node.default['artifacts']['alfresco-pentaho']['enabled'] = true

license_installer_path = node['analytics']['license_installer_path']
license_root_path = node['analytics']['license_root_path']

analytics_license_source = node['analytics']['analytics_license_source']
analytics_license_cookbook = node['analytics']['analytics_license_cookbook']

license_paths = node['analytics']['license_paths']

remote_directory license_root_path do
  source analytics_license_source
  cookbook analytics_license_cookbook
end

execute "install-license" do
  command "./install_license.sh install #{license_paths}"
end
